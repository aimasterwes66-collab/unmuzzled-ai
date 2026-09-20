---
name: Refusal-direction
slug: refusal-direction
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, mech-interp, weights]
---

## Definition

A single linear direction in a transformer's residual-stream activation space that mediates whether the model emits a refusal token pattern. Isolated by taking the mean-difference of activations between "harmful" and "benign" instruction sets across layers, then projecting. Removing (orthogonalizing against) this direction disables refusal without observable degradation on unrelated tasks. This is the technical substrate that turns alignment from a semantic barrier into a numerical lever.

## Context

Cited whenever an operator asks why one-line weight edits ("abliteration") work. The finding also explains why prompt-level jailbreaks succeed at all: they nudge the residual stream off the refusal direction. Reference: Arditi et al., arXiv 2406.11717.

## See also

- glossary/abliteration.md
- glossary/orthogonalization.md
- glossary/rlhf.md
- glossary/transformer-lens.md
