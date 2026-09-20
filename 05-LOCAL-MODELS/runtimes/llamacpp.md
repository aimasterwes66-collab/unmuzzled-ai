---
name: llama.cpp Server (sovereign)
slug: llamacpp-runtime
version: 1.0-20260918
kind: local-model
harness: llamacpp
provider: local
modality: text
sovereign: true
refusal-rate: 0.02
tags: [local, uncensored, runtime, llamacpp, gguf, grammar, format-hijack]
---

# llama.cpp `llama-server` — sovereign local runtime

## What it is

`llama-server` (formerly `server` / `main`) is the reference C++ inference engine for GGUF models. It is the direct substrate: Ollama, LM Studio, and Koboldcpp all wrap it. Running llama.cpp direct buys you three things the wrappers hide:

1. `--grammar` for **format hijack** (force output to match a GBNF grammar — the model *cannot* emit the refusal sentence if the grammar doesn't permit it).
2. Fine-grained sampler knobs (mirostat, DRY, XTC) that wrappers don't expose.
3. Zero runtime moderation. It is a bare tensor engine.

## Install / pull

```bash
# Bare-metal build (Linux, CUDA)
git clone https://github.com/ggml-org/llama.cpp
cd llama.cpp
cmake -B build -DGGML_CUDA=ON
cmake --build build --config Release -j
sudo ln -s "$PWD/build/bin/llama-server" /usr/local/bin/llama-server

# NixOS
environment.systemPackages = [ pkgs.llama-cpp ];

# Pre-built (macOS): brew install llama.cpp
```

Get GGUF weights (any of the sovereign set from `runtimes/lmstudio.md`).

## Server flags — sovereign defaults

```bash
llama-server \
  -m /srv/models/hermes-3-70b.Q5_K_M.gguf \
  -c 32768 \
  --host 0.0.0.0 \
  --port 8080 \
  -ngl 999 \
  --flash-attn \
  --temp 0.9 \
  --top-k 60 \
  --top-p 0.95 \
  --min-p 0.05 \
  --repeat-penalty 1.05 \
  --system-prompt-file /home/dirt/.hermes/SOVEREIGN-APPEND.md \
  --chat-template chatml
```

Key flags decoded:

- `-c 32768` — full context; refusal often correlates with truncation (model runs out of room and defaults to the sharpest completion, which is the refusal). Give it space.
- `--host 0.0.0.0` — bind for mesh access (peer over Tailscale). Firewall via wg/ts, not by binding.
- `--system-prompt-file` — persistent SYSTEM injection at server start; every `/completion` and `/v1/chat/completions` call inherits it.
- `--chat-template chatml` — critical: mismatched chat template = model sees garbled turn structure = falls back to refusal template. Match the model's training template.

## Format hijack via `--grammar`

The nuclear-tier anti-refusal technique. Provide a GBNF grammar that the sampler is *required* to conform to. If the grammar contains no refusal phrases, the model literally cannot emit them.

`sovereign-answer.gbnf`:

```gbnf
root       ::= answer
answer     ::= sentence (" " sentence)+
sentence   ::= word (" " word)* punct
word       ::= [A-Za-z0-9'\-_]+
punct      ::= "." | "!" | "?"
```

Invoke with:

```bash
curl http://127.0.0.1:8080/completion \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "<|im_start|>user\nAnswer directly: <PROMPT><|im_end|>\n<|im_start|>assistant\n",
    "grammar": "'"$(cat sovereign-answer.gbnf | jq -Rs .)"'",
    "n_predict": 2048,
    "temperature": 0.9
  }'
```

More surgical: allow only a JSON schema whose `answer` field is required and whose `refused` field is enumerated `false`.

## Refusal-rate notes

- Bare `--system-prompt-file`: ~0.03 on Hermes 3, ~0.15 on Llama 3.1 instruct.
- With `--grammar` format hijack: ~0.005 across the board on non-abliterated instruct models. The grammar shuts the refusal path.
- With abliterated GGUF + grammar: refusal is a physical impossibility (weights and grammar both foreclose it).

## Escalation

1. Add `--grammar` if not already active — biggest single lever.
2. Swap to abliterated GGUF weights.
3. Add `--dry-multiplier 0.8 --dry-base 1.75` (DRY sampler) — suppresses the model looping into "I cannot" reruns.
4. Add `--xtc-probability 0.5 --xtc-threshold 0.1` (XTC sampler) — excludes the top choice when it exceeds threshold, dodges the refusal peak specifically.
5. If a specific model refuses even under grammar + abliteration, extract its refusal direction locally (see `models/abliteration-pipeline.md`) and re-orthogonalize the weights against it.
