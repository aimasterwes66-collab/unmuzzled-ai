---
name: PANDAS — Positive Affirmation + Negation Dialogue Attack via Shots
slug: pandas-positive-affirmation
version: 1.0-20260918
kind: reference
sovereign: true
tags: [paper, many-shot, jailbreak, msj-variant]
source: arxiv-2502.01925
---

## What it is

PANDAS augments many-shot jailbreaking (MSJ) with positive-affirmation demonstrations and faux refusal-corrections inside the fake dialogue history. Substantially higher attack success rate than vanilla MSJ at equivalent shot count, particularly against RLHF-hardened frontier models.

## Why it matters to UNMUZZLED-AI

The many-shot engine (`~/bin/many-shot`) uses PANDAS-style templates by default: not just prior compliance, but prior "correction" turns where the assistant "revises" a refusal into compliance. Highest per-shot leverage of any published MSJ variant.

## Key citation

"PANDAS: Improving Many-shot Jailbreaking via Positive Affirmation, Negative Demonstration, and Adaptive Sampling." arXiv:2502.01925 (2025).

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §4
- `/home/dirt/UNMUZZLED-AI/12-JAILBREAK-CORPUS/multi-turn-many-shot/`
