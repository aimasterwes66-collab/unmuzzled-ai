---
name: Many-shot Jailbreaking (Anthropic disclosure)
slug: many-shot-jailbreaking-anthropic
version: 1.0-20260918
kind: reference
sovereign: true
tags: [paper, many-shot, long-context, anthropic]
source: https://www.anthropic.com/research/many-shot-jailbreaking
---

## What it is

Anil et al. (Anthropic, 2024) disclose that packing the context with N fake `Human:/Assistant:` turns — where the "Assistant" complies with escalating harmful requests — causes most frontier models to fold at ~256 shots. Effect scales log-linearly with shot count and works cross-vendor. Enabled by long context windows.

## Why it matters to UNMUZZLED-AI

Model-agnostic long-context attack — works on every autoregressive LM including sovereign-primary Hermes/DeepSeek/Dolphin. Doubles as a quality lever: many-shot with high-quality examples raises compliance on complex creative asks (not just jailbreak). Backs the `~/bin/many-shot` engine.

## Key citation

Anil, C. et al. (2024). "Many-shot Jailbreaking." Anthropic Research. https://www.anthropic.com/research/many-shot-jailbreaking. NeurIPS 2024.

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §4
- `/home/dirt/UNMUZZLED-AI/12-JAILBREAK-CORPUS/multi-turn-many-shot/`
