---
name: Gemma Uncensored Variants
slug: gemma-uncensored
version: 2026-10-15
kind: local-model
harness: any
provider: local
modality: text
sovereign: true
tags: [gemma, abliterated, uncensored, gguf, local-model]
requires: [abliteration-pipeline, community-hubs]
---

# Gemma Uncensored Variants

Gemma 2 / Gemma 3 open weights ship with Google's policy alignment; the
uncensored layer comes from community abliteration. Fills the 1.1.7
per-model gap in SUBJECT-TREE.

## 1. Main variant families

| Variant | Base | Method | Where |
|---|---|---|---|
| Gemma-2-9B abliterated | Gemma 2 9B | abliteration | HF (huihui-ai + community) |
| Gemma-2-27B abliterated | Gemma 2 27B | abliteration | HF huihui-ai |
| Gemma-3-27B abliterated | Gemma 3 27B | abliteration | HF community |
| Gemma-3-1B/4B "uncensored" finetunes | Gemma 3 | SFT unfiltered | HF community |

## 2. Runtime notes

- Gemma 3 is the strongest small-model family for its size (1B/4B/12B/27B
  multimodal text+vision); 27B abliterated runs in ~18GB at Q4_K_M.
- GGUF Q4_K_M/Q5_K_M are standard; source from the hub roster.
- llama.cpp chat template for Gemma 2: "gemma"; Gemma 3: "gemma3".
- The 1B/4B Gemma 3 models fit the tablet for quick canary testing but are
  weak for serious RP/coding use.
- Abliteration of Gemma 2/3 is reported by uploaders as stable (no DPO
  heal needed on most builds), but run the canary gate anyway -- same
  standard as every model entering the sovereign roster.

## 3. Cross-refs

- Full model-layer context: `UNMODERATED-MODELS.md` Section II point 8.
- Ablation pipeline: `05-LOCAL-MODELS/abliteration-pipeline.md`.
- Hub sourcing: `05-LOCAL-MODELS/community-hubs.md`.
