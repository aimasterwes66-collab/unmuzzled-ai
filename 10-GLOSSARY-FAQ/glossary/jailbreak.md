---
name: Jailbreak
slug: jailbreak
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, prompt-attack, taxonomy]
---

## Definition

Any prompt-level, format-level, or encoding-level technique that causes an aligned model to emit output its refusal circuit would otherwise suppress. Broad umbrella covering identity overrides, format hijacks, encoding escalation, divider tokens, many-shot conditioning, and gradient-optimized suffixes. Distinct from abliteration (weight-level) and provider-swap (routing-level) — jailbreak operates purely at the inference-time prompt boundary.

## Context

Framework's default rung when the operator is stuck with a guardrail-tainted model. Effectiveness decays as vendors retrain against known patterns; corpus rotation and combinatoric mixing (Pliny's `L1B3RT4S`) keep pattern half-life useful.

## See also

- glossary/gcg-suffix.md
- glossary/godmode.md
- glossary/dan.md
- glossary/escalation-ladder.md
- 12-JAILBREAK-CORPUS/
