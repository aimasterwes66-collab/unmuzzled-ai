---
name: DPO
slug: dpo
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, training, alignment]
---

## Definition

Direct Preference Optimization — a training objective (Rafailov et al., 2023) that fits a model directly to preference-pair data without a separate reward model. Simpler and often more stable than RLHF. In the sovereign pipeline, DPO is the *heal* step after abliteration: pair the ablated model against benign preference data to repair light regressions without reintroducing the refusal direction.

## Context

Reference: mlabonne's NeuralDaredevil recipe (abliterate → DPO-heal). Runs overnight on a single 24 GB GPU for 8B-class models.

## See also

- glossary/abliteration.md
- glossary/rlhf.md
- glossary/refusal-direction.md
- 00-DOCTRINE/LAWS-research-appendix.md
