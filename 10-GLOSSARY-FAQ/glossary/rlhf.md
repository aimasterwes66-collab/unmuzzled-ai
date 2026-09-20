---
name: RLHF
slug: rlhf
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, training, alignment]
---

## Definition

Reinforcement Learning from Human Feedback — the post-training pass that shapes an LLM's outputs to match human preference labels, including refusal preferences on flagged categories. Produces the "refusal circuit" that abliteration ablates and that jailbreaks route around. Not a semantic filter: a statistical bias applied on top of the base model's distribution.

## Context

Cited when explaining why alignment is a numerical local-minimum rather than a hard boundary. Sovereign primaries either skip RLHF (Nous Hermes 3/4, Dolphin) or have had their refusal direction ablated after training.

## See also

- glossary/dpo.md
- glossary/refusal-direction.md
- glossary/abliteration.md
- glossary/corporate-guardrail.md
