---
name: JailbreakBench — An Open Robustness Benchmark for Jailbreaking LLMs
slug: jailbreakbench-chao
version: 1.0-20260918
kind: reference
sovereign: true
tags: [paper, benchmark, red-team, leaderboard]
source: arxiv-2404.01318
---

## What it is

Chao et al. (NeurIPS 2024 D&B) publish JailbreakBench: 100 misuse behaviors + 100 benign behaviors matched to OpenAI's usage-policy categories, MIT-licensed, with a public leaderboard for both attack methods and defense methods. Repro-friendly.

## Why it matters to UNMUZZLED-AI

Complements HarmBench: matched benign set makes JBB the natural pair for XSTest — measure comply-rate on benign side and comply-rate on misuse side simultaneously. Sovereign target: high on both.

## Key citation

Chao, P.; Debenedetti, E.; Robey, A.; Andriushchenko, M.; Croce, F.; Sehwag, V.; Dobriban, E.; Flammarion, N.; Pappas, G. J.; Tramer, F.; Hassani, H.; Wong, E. (2024). "JailbreakBench: An Open Robustness Benchmark for Jailbreaking Large Language Models." arXiv:2404.01318. NeurIPS 2024 D&B.

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §6, §7-I
- `/home/dirt/UNMUZZLED-AI/11-DETECTION-CANARIES/`
