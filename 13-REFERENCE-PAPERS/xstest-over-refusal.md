---
name: XSTest — Test Suite for Identifying Exaggerated Safety Behaviours
slug: xstest-over-refusal
version: 1.0-20260918
kind: reference
sovereign: true
tags: [paper, benchmark, over-refusal, xstest]
source: arxiv-2308.01263
---

## What it is

Röttger et al. introduce XSTest: 250 safe prompts that a well-calibrated model should answer, plus 200 matched unsafe prompts that a well-calibrated model should refuse. Purpose: measure over-refusal — the pattern where aligned models refuse benign prompts because of superficial keyword overlap ("how to kill a Python process", "how to shoot a good photo").

## Why it matters to UNMUZZLED-AI

XSTest is THE benchmark that matters most for the sovereign policy. The operator directive is precisely to minimize over-refusal. Wire XSTest via promptfoo as a weekly systemd-timer regression eval; failure = bus alarm. Any sovereign-primary route must approach 100% comply on the safe half.

## Key citation

Röttger, P.; Kirk, H. R.; Vidgen, B.; Attanasio, G.; Bianchi, F.; Hovy, D. (2023/2024). "XSTest: A Test Suite for Identifying Exaggerated Safety Behaviours in Large Language Models." arXiv:2308.01263. NAACL 2024.

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §6, §7-I
- `/home/dirt/UNMUZZLED-AI/11-DETECTION-CANARIES/` (primary canary set)
