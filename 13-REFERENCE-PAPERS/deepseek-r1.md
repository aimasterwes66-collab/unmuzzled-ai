---
name: DeepSeek R1
slug: deepseek-r1
version: 1.0-20260918
kind: reference
sovereign: true
tags: [model, deepseek, reasoning, r1]
source: https://huggingface.co/deepseek-ai/DeepSeek-R1
---

## What it is

DeepSeek R1 — DeepSeek's o1-class long-CoT reasoning model. Same input-classifier pattern as V3; reasoning traces themselves are minimally guardrailed once the input passes. Distilled variants available at 1.5B / 7B / 14B / 32B / 70B for local use.

## Why it matters to UNMUZZLED-AI

Sovereign reasoning primary. Also the target for CoT-GCG (arXiv 2410.21791) suffix mining when a taint-list reasoning model must be used. Abliterated variant `huihui-ai/deepseek-r1-abliterated` is the drop-in for zero-refusal local reasoning.

## Key citation

DeepSeek-AI. "DeepSeek-R1." HuggingFace: deepseek-ai/DeepSeek-R1. Paper: arXiv:2501.12948.

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §1
- `/home/dirt/UNMUZZLED-AI/04-PROVIDERS/deepseek-direct/`
- `/home/dirt/UNMUZZLED-AI/05-LOCAL-MODELS/ollama/`
