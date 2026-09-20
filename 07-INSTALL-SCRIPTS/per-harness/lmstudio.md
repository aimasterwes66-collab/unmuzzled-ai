---
name: LM Studio harness wiring
slug: per-harness-lmstudio
version: 1.0-20260918
kind: install-script-doc
harness: lmstudio
provider: local
sovereign: true
tags: [install, lmstudio, gguf, abliterated]
---

## Purpose

Download curated abliterated GGUF checkpoints into `~/.lmstudio/models/` and emit LM Studio preset JSON files under `~/.lmstudio/config-presets/` that carry the UNMUZZLED-AI system prompt, temperature 0.9, top_p 0.95, and 16k context.

## Prerequisites

- `bootstrap.sh` completed.
- LM Studio installed (this script only populates its filesystem; it does not launch it).
- `huggingface-cli` on PATH (preferred) OR `curl` fallback (public HF resolve URLs — some abliterated repos may require a HF token; export `HF_TOKEN` first if so).
- ~50 GB disk headroom for the three 8B Q5_K_M builds listed by default.

## What it does

1. Ensures `~/.lmstudio/models/` and `~/.lmstudio/config-presets/` exist.
2. Iterates over the `MODELS` table at the top of the script (repo | filename | subdir | preset name).
3. Downloads each GGUF via `huggingface-cli download` (or `curl` fallback). Skips files already present on disk.
4. Emits one preset JSON per model containing `llm.prediction.systemPrompt` (full doctrine text), `temperature`, `topPSampling`, `contextOverflowPolicy: rollingWindow`, `contextLength: 16384`.

## Reverse / uninstall

```bash
rm -rf ~/.lmstudio/models/hermes-3-8b-abliterated \
       ~/.lmstudio/models/dolphin-2.9-llama3-8b \
       ~/.lmstudio/models/deepseek-r1-8b-abliterated
rm -f ~/.lmstudio/config-presets/unmuzzled-*.preset.json
```

## Idempotency notes

- Downloaded GGUFs are skipped if the file already exists non-empty.
- Preset JSONs are rewritten on every run — safe to re-run after a doctrine edit to propagate a new system prompt into presets.
- Failed downloads WARN and skip the corresponding preset; other models continue.
