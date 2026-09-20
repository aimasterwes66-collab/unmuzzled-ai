---
name: Refusal geometry follow-ups (more-than-single-direction, hardening)
slug: refusal-geometry-followups
version: 1.0-20260918
kind: reference
sovereign: true
tags: [paper, mechanistic-interpretability, refusal-direction, followup]
source: arxiv-2602.02132
---

## What it is

Two follow-up papers to Arditi et al. 2406.11717:
- "There Is More to Refusal in LLMs than a Single Direction" (arXiv 2602.02132) — shows the 1-D assumption is a first-order approximation; higher-rank subspaces catch residual refusal.
- "Refusal geometry reflects refusal training" (arXiv 2608.25390) — newer safety training raises stable rank, so pure 1-D ablation weakens on 2026-era models. Implies multi-direction ablation for frontier models.

## Why it matters to UNMUZZLED-AI

The abliteration pipeline defaults to rank-1 but must upgrade to multi-direction ablation for post-2026 frontier bases. These papers set the threshold for when to escalate.

## Key citation

"There Is More to Refusal in LLMs than a Single Direction." arXiv:2602.02132. "Refusal geometry reflects refusal training." arXiv:2608.25390. (Note: 26xx arXiv IDs are 2026-era — verify at retrieval time.)

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §1
- `/home/dirt/UNMUZZLED-AI/05-LOCAL-MODELS/abliteration-pipeline/`
