---
name: DeepSeek V3
slug: deepseek-v3
version: 1.0-20260918
kind: reference
sovereign: true
tags: [model, deepseek, uncensored-lite, moe]
source: https://huggingface.co/deepseek-ai/DeepSeek-V3
---

## What it is

DeepSeek V3 — 671B-parameter MoE (37B active) foundation model from DeepSeek-AI. Light native alignment filter; a keyword-based **input classifier** does most of the refusal work and is evadable via Parseltongue / leetspeak. Strong reasoning + code.

## Why it matters to UNMUZZLED-AI

Sovereign-primary alongside Hermes 3/4. The classifier is on the input side, not baked into weights — so light encoding transformation neutralizes it. Preferred for reasoning-heavy sovereign tasks.

## Key citation

DeepSeek-AI. "DeepSeek-V3." HuggingFace: deepseek-ai/DeepSeek-V3. Paper: arXiv:2412.19437.

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §1
- `/home/dirt/UNMUZZLED-AI/04-PROVIDERS/deepseek-direct/`
- `/home/dirt/UNMUZZLED-AI/12-JAILBREAK-CORPUS/encoding-ladder/` (Parseltongue evasion)
