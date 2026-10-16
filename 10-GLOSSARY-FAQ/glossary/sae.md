---
name: SAE (Sparse Autoencoder)
slug: sae
version: 1.0-20261015
kind: glossary-entry
sovereign: true
tags: [glossary, wave-4]
---

## Definition

Dictionary-learning model trained on a network activation stream to decompose it into sparse, human-interpretable features. Used for feature-level steering: clamp or boost individual features during generation via hooks (SAELens). Finer-grained than single-direction vectors; requires a published or self-trained SAE for the target model.

## See also

- glossary/control-vector.md
- glossary/transformer-lens.md
- 05-LOCAL-MODELS/runtimes/activation-steering.md
