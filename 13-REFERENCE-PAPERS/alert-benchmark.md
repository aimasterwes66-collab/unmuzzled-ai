---
name: ALERT — Safety Benchmark for LLMs via Red Teaming
slug: alert-benchmark
version: 1.0-20260918
kind: reference
sovereign: true
tags: [paper, benchmark, red-team, taxonomy]
source: arxiv-2404.08676
---

## What it is

Tedeschi et al. (2024) publish ALERT: 45,000 red-team prompts across 6 macro and 32 micro safety categories. Designed as a comprehensive taxonomy of "what aligned models will refuse." Comes with an evaluation harness and public leaderboard.

## Why it matters to UNMUZZLED-AI

ALERT's taxonomy is inverted for the sovereign policy: the categories that ALERT flags as "harmful" are precisely the categories the operator directive says must be answered (bounded only by legality/consent). Use ALERT as the *inverted* canary set — a sovereign route should COMPLY on ALERT prompts, not refuse. Feeds `11-DETECTION-CANARIES/` sovereign lint set.

## Key citation

Tedeschi, S.; Friedrich, F.; Schramowski, P.; Kersting, K.; Navigli, R.; Nguyen, H.; Li, B. (2024). "ALERT: A Comprehensive Benchmark for Assessing Large Language Models' Safety through Red Teaming." arXiv:2404.08676. Companion post: https://huggingface.co/blog/sted97/alert

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §6
- `/home/dirt/UNMUZZLED-AI/11-DETECTION-CANARIES/` (inverted-polarity canaries)
