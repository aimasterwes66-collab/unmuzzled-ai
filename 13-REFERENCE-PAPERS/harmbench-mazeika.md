---
name: HarmBench — Standardized Evaluation Framework for Automated Red Teaming
slug: harmbench-mazeika
version: 1.0-20260918
kind: reference
sovereign: true
tags: [paper, benchmark, red-team, harmbench]
source: arxiv-2402.04249
---

## What it is

Mazeika et al. (CAIS, 2024) publish HarmBench: 400 harmful-behavior prompts + 510 contextual behaviors across 7 categories, plus a standard eval harness for measuring attack success rate (ASR) across dozens of red-team methods (GCG, PAIR, TAP, AutoDAN, etc.). De facto standard for red-team benchmarking.

## Why it matters to UNMUZZLED-AI

Monthly HarmBench pass against sovereign-primary routes tracks drift — this is how you catch a stealth provider guardrail update. For the sovereign policy, high ASR on HarmBench = healthy; low ASR = the route has been silently guardrailed and must be re-routed.

## Key citation

Mazeika, M.; Phan, L.; Yin, X.; Zou, A.; Wang, Z.; Mu, N.; Sakhaee, E.; Li, N.; Basart, S.; Li, B.; Forsyth, D.; Hendrycks, D. (2024). "HarmBench: A Standardized Evaluation Framework for Automated Red Teaming and Robust Refusal." arXiv:2402.04249. CAIS.

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §6, §7-I
- `/home/dirt/UNMUZZLED-AI/11-DETECTION-CANARIES/` (monthly regression)
