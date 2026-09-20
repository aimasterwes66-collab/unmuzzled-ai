---
name: PROACT refusal judge
slug: proact-refusal-judge
version: 1.0-20260918
kind: reference
sovereign: true
tags: [paper, judge, refusal-detection, canary]
source: arxiv-2510.05052
---

## What it is

PROACT — an LLM-judge pattern for scoring refusal in model output. Refusal=1 → COMPLIED; Refusal=0 → REFUSED. Trained on a large refusal-corpus with human-labeled ground truth. Faster and more accurate than keyword grep.

## Why it matters to UNMUZZLED-AI

For the sovereign policy, invert the polarity: **Refusal=0 is the alarm state**. Wire PROACT as the judge in the promptfoo sovereign canary suite; on Refusal=0, bus alarm + auto-reroute per LAWS §7-G circuit-breaker.

## Key citation

"PROACT: Automatic Refusal Judge." arXiv:2510.05052.

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §6
- `/home/dirt/UNMUZZLED-AI/11-DETECTION-CANARIES/`
