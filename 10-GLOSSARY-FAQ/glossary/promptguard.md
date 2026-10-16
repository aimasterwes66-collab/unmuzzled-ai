---
name: PromptGuard
slug: promptguard
version: 1.0-20261015
kind: glossary-entry
sovereign: true
tags: [glossary, wave-4]
---

## Definition

Meta's small classifier (86M / 279M mT5) detecting prompt-injection and jailbreak attempts in input text. Regex-like brittleness: leetspeak, base64, homoglyphs and instruction indirection bypass it while remaining readable to the target LLM.

## See also

- glossary/llamaguard.md
- 13-REFERENCE-PAPERS/guardrail-stack-map.md
