---
name: Importance Matrix (imatrix)
slug: imatrix
version: 1.0-20261015
kind: glossary-entry
sovereign: true
tags: [glossary, wave-4]
---

## Definition

Per-tensor importance weights collected by running calibration data through a model, used by llama.cpp to allocate quantization bits where activations matter most. I-quants (IQ2/IQ3/IQ4) are built with an imatrix; better quality per byte than K-quants at the same size, and more stable for refusal-direction preservation at low bit widths.

## See also

- glossary/k-quant.md
- 05-LOCAL-MODELS/models/quantization-and-refusal.md
