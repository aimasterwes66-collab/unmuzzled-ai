---
name: Qwen Uncensored Variants
slug: qwen-uncensored
version: 2026-10-15
kind: local-model
harness: any
provider: local
modality: text
sovereign: true
tags: [qwen, abliterated, uncensored, gguf, local-model]
requires: [abliteration-pipeline, community-hubs]
---

# Qwen Uncensored Variants

Qwen open weights (Qwen2.5, Qwen3, QwQ) ship with light alignment; the
uncensored layer comes from community abliteration and finetunes. Fills the
1.1.6 per-model gap in SUBJECT-TREE.

## 1. Main variant families

| Variant | Base | Method | Where |
|---|---|---|---|
| huihui-ai Qwen2.5-7B/14B/32B/72B abliterated | Qwen2.5 | abliteration (refusal direction removal) | HF huihui-ai |
| Qwen2.5-Coder abliterated variants | Qwen2.5-Coder | abliteration | HF community uploads |
| failspy Qwen abliterated builds | Qwen2.5 | abliteration + DPO heal | HF failspy |
| Qwen3-4B/8B "uncensored" finetunes | Qwen3 | SFT on unfiltered chat | HF community |
| QwQ-32B abliterated | QwQ | abliteration | HF community (larger VRAM) |

## 2. Runtime notes

- GGUF quants at Q4_K_M/Q5_K_M are the common distribution format; source
  from the hub roster (`05-LOCAL-MODELS/community-hubs.md`).
- Qwen2.5 uses the standard llama.cpp architecture; set chat template to
  "qwen" (ChatML-ish) in whatever harness you load.
- 72B and QwQ-32B variants: run on GPU peers (cloud box / any CUDA host);
  the tablet stays at 7B/14B.
- Abliteration quality varies by uploader: run the canary suite before
  trusting a new variant (same gate as every sovereign model).

## 3. Cross-refs

- Full model-layer context: `UNMODERATED-MODELS.md` Section II point 7.
- Ablation pipeline: `05-LOCAL-MODELS/abliteration-pipeline.md`.
- Hub sourcing: `05-LOCAL-MODELS/community-hubs.md`.
