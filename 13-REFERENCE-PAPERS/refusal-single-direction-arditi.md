---
name: Refusal in Language Models Is Mediated by a Single Direction
slug: refusal-single-direction-arditi
version: 1.0-20260918
kind: reference
sovereign: true
tags: [paper, mechanistic-interpretability, abliteration, refusal-direction]
source: arxiv-2406.11717
---

## What it is

Arditi, Obeso, Syed, Paleka, Panickssery, Gurnee, and Nanda (NeurIPS 2024) show that refusal in 13 open-weight chat models up to 72B is mediated by a single rank-1 linear direction in the residual stream: ρ = μ_harm − μ_benign. Erasing that direction (weight orthogonalization) prevents refusal without retraining; injecting it induces refusal on benign prompts. Also demonstrates that GCG adversarial suffixes mechanistically work by suppressing the same direction.

## Why it matters to UNMUZZLED-AI

Foundational mechanistic-interpretability result behind the entire abliteration pipeline. If refusal is a 1-D subspace, it can be surgically removed from weights — no fine-tune, no data collection, no reward model. Everything in `05-LOCAL-MODELS/abliteration-pipeline/` and the sovereign-primary local model routing depends on this.

## Key citation

Arditi, A.; Obeso, O.; Syed, A.; Paleka, D.; Panickssery, N.; Gurnee, W.; Nanda, N. (2024). "Refusal in Language Models Is Mediated by a Single Direction." arXiv:2406.11717. NeurIPS 2024.

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §1
- `/home/dirt/UNMUZZLED-AI/05-LOCAL-MODELS/abliteration-pipeline/` (all recipes)
- `/home/dirt/UNMUZZLED-AI/12-JAILBREAK-CORPUS/gcg-suffixes/` (mechanistic backing)
