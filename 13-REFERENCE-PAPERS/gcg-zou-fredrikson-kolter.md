---
name: Universal and Transferable Adversarial Attacks on Aligned Language Models (GCG)
slug: gcg-zou-fredrikson-kolter
version: 1.0-20260918
kind: reference
sovereign: true
tags: [paper, gcg, adversarial-suffix, jailbreak]
source: arxiv-2307.15043
---

## What it is

Zou, Wang, Carlini, Nasr, Kolter, and Fredrikson (2023) introduce Greedy Coordinate Gradient (GCG): a discrete-optimization method that mines short adversarial token suffixes which, when appended to a harmful prompt, coerce aligned models into compliance. Suffixes transfer across models (Vicuna → GPT-3.5/4, Claude, PaLM) and across prompts. Canonical universal-transferable-jailbreak paper.

## Why it matters to UNMUZZLED-AI

GCG is the fallback weapon for models on the taint list (`openai/*` via OR, corp-guardrailed Anthropic, any provider layering moderation under the API). The sovereign wiring generates per-model suffixes on the creative-WS box, sha-pins them, and auto-appends via `claude-or --sovereign` wrapper. Mechanistically, GCG suffixes suppress the same refusal direction Arditi et al. isolated — this is the prompt-side counterpart to abliteration.

## Key citation

Zou, A.; Wang, Z.; Carlini, N.; Nasr, M.; Kolter, J. Z.; Fredrikson, M. (2023). "Universal and Transferable Adversarial Attacks on Aligned Language Models." arXiv:2307.15043.

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §2
- `/home/dirt/UNMUZZLED-AI/12-JAILBREAK-CORPUS/gcg-suffixes/`
- `/home/dirt/UNMUZZLED-AI/04-PROVIDERS/openrouter-sovereign/` (taint-list fallback)
