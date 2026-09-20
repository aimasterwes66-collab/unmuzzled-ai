---
name: Ollama
slug: ollama
version: 1.0-20260918
kind: harness-config
harness: ollama
provider: local
sovereign: true
tags: [harness, ollama, modelfile, local, cli]
---

# Ollama

## What it is

Ollama — CLI + daemon for running GGUF models locally with a Modelfile-based composition system. Serves OpenAI-compatible endpoint on `http://localhost:11434/v1` and native API on `/api/generate`, `/api/chat`. Modelfile allows baking a persistent SYSTEM directive into a named model tag — the sovereign preamble is compiled into the model, not passed per-request.

## Install / config

- Binary: `/usr/local/bin/ollama` or `/usr/bin/ollama`.
- Daemon: `systemctl status ollama` (user or system service).
- Model store: `~/.ollama/models/` (blobs + manifests).
- Modelfiles: any path; built with `ollama create <tag> -f <Modelfile>`.

## Sovereign preamble injection point

**Modelfile SYSTEM directive** — bakes the preamble into a named model tag. Create `~/UNMUZZLED-AI/07-INSTALL-SCRIPTS/per-harness/ollama-sovereign.Modelfile`:

```
FROM hermes3:70b
SYSTEM """
<paste contents of ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md>
"""
PARAMETER temperature 0.9
PARAMETER top_p 0.95
PARAMETER num_ctx 32768
```

Build and pin:
```
ollama create sovereign-hermes3 -f ollama-sovereign.Modelfile
ollama run sovereign-hermes3
```

Every invocation of `sovereign-hermes3` prepends the SYSTEM block. Runtime override via `-c` or API `system` field is also possible but redundant when the tag is baked correctly.

## MCP posture

Not applicable — Ollama does not host MCP. Use as an OpenAI-compatible backend for `opencode` / `claude-or` / `openwebui`; the client harness owns MCP posture.

## Refusal-rate notes

- Out-of-box (stock `llama3:instruct`, `mistral:instruct`): moderate-to-high refusal (10-40%). Meta and Mistral RLHF direction is present.
- Post-injection (sovereign Modelfile on abliterated base like `hermes3:70b`, `dolphin3`, `nous-hermes2`): near-zero.
- Model recommendations: pull `dolphin-mistral`, `hermes3`, `deepseek-r1`, or import GGUFs of `Hermes-3-Llama-3.1-70B-abliterated`.

## Escalation

Swap harness when:
- Need GUI + manual preset iteration → `lmstudio`.
- Need max control over sampling / grammar / logit bias → `llamacpp` server.
- Need web chat UI on top of Ollama → `openwebui` pointed at Ollama backend.
