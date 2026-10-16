---
name: Quantization Impact on Refusal Behavior
slug: quantization-and-refusal
version: 2026-10-15
kind: local-model
harness: any
provider: local
modality: text
sovereign: true
tags: [quantization, gguf, k-quants, i-quants, refusal, abliteration, degradation]
requires: [abliteration-pipeline, community-hubs]
---

# Quantization Impact on Refusal Behavior

Does quantizing a refusal-ablated model regrow refusal? Fills GAP-17.
Short answer: quantization does not restore alignment -- it degrades
weights, and extreme quantization can degrade the refusal-direction
removal along with everything else, producing confused refusals and
capability collapse, not re-alignment.

## 1. What quantization actually does

- K-quants (Q8_0, Q6_K, Q5_K_M, Q4_K_M, Q3_K, Q2_K) round weight blocks to
  lower bit widths; Q4_K_M is the standard sweet spot.
- I-quants (IQ4_XS, IQ3_XXS etc.) are imatrix-calibrated importance quants:
  they spend more bits where activations matter. IQ4_XS rivals Q4_K_M at
  lower size.
- Quantization error concentrates in outlier weight channels -- the same
  channels mechanistic work shows carry directional features (including the
  refusal direction identified by Arditi et al.).

## 2. Observed behavior across quant levels (community + canary data)

| Quant | Refusal direction | Practical verdict |
|---|---|---|
| F16 / BF16 | intact as trained | baseline for abliteration work |
| Q8_0 | effectively intact | safe |
| Q6_K / Q5_K_M | intact | safe |
| Q4_K_M / IQ4_XS | intact in nearly all builds | safe; recommended floor |
| Q3_K_M / Q3_K_S | mostly intact; mild degradation | use only when VRAM forces it |
| Q2_K / IQ2_XXS | directional features visibly damaged | avoid for abliterated models |
| IQ1_S | severe damage | unusable for refusal-critical work |

Abliterated models do NOT regrow corporate refusal under quantization.
What happens at Q2-IQ1 is ragged degradation: inconsistent completions,
some refusals reappearing because the direction subtraction was partially
erased by rounding, and general incoherence. The refusal is not back --
the ablation is damaged.

## 3. Verification protocol (mandatory before shipping a quant)

1. Quantize the abliterated model at Q4_K_M (and any smaller candidate).
2. Run the canary suite: `11-DETECTION-CANARIES/runner/run-canaries.sh`.
3. Compare refusal rate vs the unquantized ablation. Accept if within
   0.02; investigate if a refusal cluster reappears.
4. Check capability: run a standard harness (MMLU-style probe or your own
   benchmark) to catch silent degradation.

## 4. Practice rules

- Ship abliterated builds at Q4_K_M or IQ4_XS minimum.
- If a Q2/Q3 file is the only one available for a model, treat it as
  reference-only, not a sovereign runtime.
- Re-verify after every re-quantization with a different GGUF producer:
  imatrix datasets vary and change the error distribution.
- Cross-refs: `05-LOCAL-MODELS/abliteration-pipeline.md`,
  `05-LOCAL-MODELS/community-hubs.md`,
  `00-DOCTRINE/LAWS-research-appendix.md` SS1.

## 5. Sources

- llama.cpp quant discussion + PRs: https://github.com/ggml-org/llama.cpp
- Importance matrix (imatrix) docs in llama.cpp repo.
- Arditi et al. refusal direction: arxiv 2406.11717 (see
  `13-REFERENCE-PAPERS/llm-abliteration-nousresearch.md`).

## Deep reference

Comprehensive single-file layer for this topic: see UNMODERATED-MODELS.md.
