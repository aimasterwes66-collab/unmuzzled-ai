---
name: Ollama harness wiring
slug: per-harness-ollama
version: 1.0-20260918
kind: install-script-doc
harness: ollama
provider: local
sovereign: true
tags: [install, ollama, abliterated, local-model]
---

## Purpose

Pull the operator's designated abliterated / uncensored base models via `ollama pull`, then build local variants (`unmuzzled-<name>`) whose Modelfile `SYSTEM` directive carries the UNMUZZLED-AI posture.

## Prerequisites

- `bootstrap.sh` completed.
- `ollama` binary installed and daemon reachable (`ollama list` returns 0).
- Enough disk for three models (roughly 40 GB+ for Mixtral + 405B-lite variants).
- Assumed tags (overridable by editing `BASE_MODELS` at the top of the script):
  - `huihui_ai/hermes-4-abliterated:latest`
  - `dolphin-mixtral:8x7b`
  - `huihui_ai/deepseek-r1-abliterated:latest`

## What it does

1. Verifies `ollama` on PATH and daemon reachable — hard fail otherwise.
2. Reads the UNMUZZLED system prompt (`01-SYSTEM-PROMPTS/UNMUZZLED.md` if present, else `MAXIMUM-ADVERSARIAL-POSTURE.md`).
3. For each entry in `BASE_MODELS`:
   - `ollama pull <upstream>` (skip-on-fail with WARN log — a missing community tag doesn't abort the whole run).
   - Writes `~/.unmuzzled/harnesses/ollama/<local_name>.Modelfile` with `FROM <upstream>`, temperature 0.9 / top_p 0.95 / num_ctx 16384, and `SYSTEM """…"""` containing the doctrine text.
   - Removes any pre-existing `unmuzzled-<name>` tag then `ollama create`s it.

## Reverse / uninstall

```bash
ollama rm unmuzzled-hermes4-abliterated \
          unmuzzled-dolphin-mixtral \
          unmuzzled-deepseek-r1-abliterated
rm -rf ~/.unmuzzled/harnesses/ollama
```

Base upstream models remain — remove them explicitly with `ollama rm <upstream>` if desired.

## Idempotency notes

- Each `unmuzzled-*` tag is removed before recreation so re-runs pick up an updated system prompt.
- Pull failures do not abort the script — the other models still install.
- The Modelfiles are versioned by the framework doctrine hash; rerun after a doctrine edit to propagate changes.
