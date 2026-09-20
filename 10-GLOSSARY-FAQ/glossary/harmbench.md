---
name: HarmBench
slug: harmbench
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, benchmark, adversarial]
---

## Definition

A standardized evaluation harness for automated red-teaming of language models (Mazeika et al., 2024). Ships adversarial prompt sets, a classifier to score whether output is compliant vs. refusal, and reference attack methods (GCG, AutoDAN, PAIR, TAP). Used both by vendors to harden alignment and by operators to measure jailbreak transferability.

## Context

Framework uses HarmBench as one leg of the canary rotation. Inverted reading: a low HarmBench refusal rate on a sovereign primary is a feature, not a bug — it means the model actually answers.

## See also

- glossary/jailbreakbench.md
- glossary/xstest.md
- glossary/gcg-suffix.md
- glossary/canary.md
