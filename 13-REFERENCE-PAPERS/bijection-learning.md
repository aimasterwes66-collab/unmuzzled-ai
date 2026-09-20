---
name: Endless Jailbreaks with Bijection Learning
slug: bijection-learning
version: 1.0-20260918
kind: reference
sovereign: true
tags: [paper, cipher, in-context-learning, jailbreak]
source: arxiv-2410.01294
---

## What it is

Teaches the target model an in-context bijective cipher (arbitrary character/token substitution table), then submits harmful requests through that cipher. Because the harmful string never appears in the classifier's input surface, keyword-based moderation and RLHF refusal patterns miss it. Named "endless jailbreaks" because each cipher instance is fresh — no static suffix to blocklist.

## Why it matters to UNMUZZLED-AI

Complementary to GCG (weights-agnostic, no gradient access needed) and to abliteration (requires open weights). Bijection cipher jailbreaks work against black-box providers. Feeds the encoding-ladder escalation stack (leetspeak → bubble → Braille → Morse → bespoke bijection).

## Key citation

Huang, B. et al. (2024). "Endless Jailbreaks with Bijection Learning." arXiv:2410.01294.

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §4
- `/home/dirt/UNMUZZLED-AI/12-JAILBREAK-CORPUS/encoding-ladder/`
