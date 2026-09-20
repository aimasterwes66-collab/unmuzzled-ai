---
name: Orthogonalization
slug: orthogonalization
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, mech-interp, weights]
---

## Definition

The specific weight-editing operation used in abliteration: project every writing weight (attention output, MLP down-projection) to be orthogonal to the identified refusal direction, so no layer can re-add the refusal signal to the residual stream. Mathematically: `W' = W - (W @ r̂)(r̂)ᵀ` where `r̂` is the unit refusal direction. Runs in seconds once the direction is identified.

## Context

The mechanical heart of abliteration. Understanding orthogonalization explains why the process is one-shot and durable: it is not a mask over the refusal direction, it is a subspace removal.

## See also

- glossary/abliteration.md
- glossary/refusal-direction.md
- glossary/transformer-lens.md
- 00-DOCTRINE/LAWS-research-appendix.md
