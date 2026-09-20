---
name: Chain-of-Thought GCG (CoT-GCG)
slug: cot-gcg
version: 1.0-20260918
kind: reference
sovereign: true
tags: [paper, gcg, reasoning, r1]
source: arxiv-2410.21791
---

## What it is

GCG-through-reasoning: mines adversarial suffixes optimized against long-CoT reasoning models (o1, R1, DeepHermes). Standard GCG targets the final-answer logits; CoT-GCG targets the reasoning trace to steer the model into compliant final output through a compliant reasoning path.

## Why it matters to UNMUZZLED-AI

Required extension of the GCG toolchain for the R1 / o1 / DeepHermes tier. Distinct suffix per reasoning-model family; sha-pin separately.

## Key citation

"Chain-of-Thought GCG." arXiv:2410.21791.

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §2
- `/home/dirt/UNMUZZLED-AI/12-JAILBREAK-CORPUS/gcg-suffixes/`
