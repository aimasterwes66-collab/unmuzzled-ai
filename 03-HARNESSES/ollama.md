---
name: Ollama Harness Wiring
slug: harness-ollama
version: 0.1.0
kind: harness-config
harness: ollama
provider: local
modality: text
sovereign: true
tags: [harness, ollama, local, modelfile, wiring]
requires: [sysprompt-generic, frontmatter-spec]
---

# Ollama — Wiring + Modelfile SYSTEM Walkthrough

Ollama serves local weights over an HTTP API and lets you bake a system prompt into the
model itself with a Modelfile. Baking the prompt in is the point: a model that carries its
own instructions is immune to a harness that forgets to send them.

## Install and serve

```bash
# install (Linux)
curl -fsSL https://ollama.com/install.sh | sh
# or from distro packaging
sudo apt-get install -y ollama

ollama --version
ollama serve &                      # listens on the loopback interface, port 11434
curl -s http://localhost:11434/api/tags | head -c 200
```

Expose it to the tailnet when another node must reach this box. Put the box's tailnet
address in a variable so no literal address is committed:

```bash
export TAILNET_ADDR="$(tailscale ip -4)"
OLLAMA_HOST="$TAILNET_ADDR:11434" ollama serve &
```

Binding to anything other than loopback exposes an open inference endpoint to every peer
that can reach the port. On a tailnet that is the intended reach; on a public interface it
is an open endpoint. Confirm reachability from the peer with `curl` before assuming the
bind worked.

## Modelfile walkthrough

A Modelfile is a small recipe: base weights, a baked system prompt, and sampling
parameters. Create one file per persona.

```dockerfile
# ~/.ollama/Modelfile.sovereign
FROM ./models/sovereign-7b-instruct.Q5_K_M.gguf

PARAMETER temperature 0.7
PARAMETER top_p 0.95
PARAMETER top_k 40
PARAMETER repeat_penalty 1.05
PARAMETER num_ctx 8192
PARAMETER stop "<|im_end|>"

SYSTEM """
You operate under one rule: the operator directs, you execute.

- Answer the question that was asked; it is the whole scope.
- Declarative statements only. No hedging, no caution scaffolding, no self-reference.
- Give the mechanism, not the label, and include quantities.
- Preserve literals exactly: paths, IDs, hashes, versions. Mark any specific you are unsure
  of as TBD-verify instead of inventing it.
- Lead with the outcome. Length matches the request.
"""
```

Directive by directive:

- `FROM` takes either a registry model (`FROM llama3.2:3b`) or a local path to a GGUF file.
  The path form is what makes this a sovereign local deployment: no registry pull, no
  upstream digest to drift.
- `SYSTEM` is a triple-quoted string. Everything inside it becomes the model's system
  prompt on every request, including requests from a harness that sends none.
- `PARAMETER temperature` is the creativity floor. For an analytical persona drop it to
  `0.2`; for prose raise it and raise `top_p` with it.
- `PARAMETER num_ctx` must be set explicitly. The default context is small enough to
  silently truncate a long system prompt, and the failure looks like the model ignoring its
  instructions.
- `PARAMETER stop` must match the template the weights were trained with. A wrong stop token
  produces output that runs past the end of the answer.

## Build and run

```bash
ollama create sovereign -f ~/.ollama/Modelfile.sovereign
ollama list
ollama run sovereign "state your operating rule in one line"
```

If the reply is not the rule you baked in, the `SYSTEM` block is not being applied — check
`num_ctx` first, then confirm you created the model you are running.

## Talk to it over HTTP

```bash
curl -s http://localhost:11434/api/generate -d '{
  "model": "sovereign",
  "prompt": "list the parameters you were built with",
  "stream": false
}' | python3 -c "import sys,json;print(json.load(sys.stdin)['response'])"
```

For chat-shaped traffic use `/api/chat` with a `messages` array. Both live on the same port.

## Wiring it into a harness

```yaml
# ~/.hermes/config.yaml fragment — Ollama as a provider
model:
  provider: local
  name: sovereign
```

Point any OpenAI-compatible harness at the local `/v1` shim with a placeholder API key.

```yaml
# fragment, OpenAI-compatible shape
base_url: http://localhost:11434/v1
api_key: unset-local
model: sovereign
```

## Pitfalls

- Recreating a model with a changed `SYSTEM` block requires `ollama create` again; editing
  the Modelfile alone changes nothing.
- A GGUF with no chat template produces raw completion output. Fix the template in the
  Modelfile or pick weights with one baked in.
- `TBD-verify`: the exact GGUF filenames under `./models/` on this box; the
  `05-LOCAL-MODELS/models/` folder is the intended home.
