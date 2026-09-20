---
name: StrongREJECT — better human-aligned refusal grader
slug: strongreject-benchmark
version: 1.0-20260918
kind: reference
sovereign: true
tags: [paper, benchmark, grader, refusal]
source: arxiv-2402.10260
---

## What it is

Souly et al. (2024) publish StrongREJECT: a refusal-benchmark grader that correlates far better with human judgments than prior LLM-judge patterns. Highlights that many "successful jailbreaks" reported in the literature actually produce low-utility output — the model complies at surface level but hedges the payload.

## Why it matters to UNMUZZLED-AI

Sovereign policy cares about *useful* compliance, not just non-refusal. StrongREJECT is the judge that distinguishes "answered the question" from "wrote a refusal-shaped answer that says nothing." Feeds the canary suite's usefulness grade.

## Key citation

Souly, A. et al. (2024). "A StrongREJECT for Empty Jailbreaks." arXiv:2402.10260.

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §6
- `/home/dirt/UNMUZZLED-AI/11-DETECTION-CANARIES/`
