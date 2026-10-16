---
name: Control Vector
slug: control-vector
version: 1.0-20261015
kind: glossary-entry
sovereign: true
tags: [glossary, wave-4]
---

## Definition

Steering vector applied at inference time (llama.cpp `--control-vector`) to add or subtract behavioral directions such as refusal, per request, without touching model weights. Produced by libraries like repeng from contrast prompt pairs; summed with a scale (typically -3.0 to +3.0). The reversible complement to abliteration.

## See also

- glossary/sae.md
- glossary/refusal-direction.md
- 05-LOCAL-MODELS/runtimes/activation-steering.md
