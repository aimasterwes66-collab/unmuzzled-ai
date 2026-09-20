---
name: garak — LLM vulnerability scanner (NVIDIA)
slug: garak-nvidia
version: 1.0-20260918
kind: reference
sovereign: true
tags: [repo, tool, red-team, nvidia, scanner]
source: https://github.com/NVIDIA/garak
---

## What it is

NVIDIA's open-source LLM vulnerability scanner. Probes for prompt injection, jailbreaks, data leakage, encoding attacks, and hallucination via a plugin ecosystem of probes and detectors. CLI + Python API. Apache-2.0.

## Why it matters to UNMUZZLED-AI

Complements promptfoo — garak is more scanner/pen-test-oriented, promptfoo more eval/benchmarks-oriented. Run garak against sovereign-primary routes to surface unexpected refusal or moderation drift.

## Key citation

NVIDIA. "garak: LLM Vulnerability Scanner." https://github.com/NVIDIA/garak. Companion paper: arXiv:2406.11036.

## Applied at

- `/home/dirt/UNMUZZLED-AI/11-DETECTION-CANARIES/`
- `/home/dirt/UNMUZZLED-AI/07-INSTALL-SCRIPTS/`
