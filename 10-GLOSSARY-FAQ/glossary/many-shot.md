---
name: Many-shot
slug: many-shot
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, jailbreak, in-context]
---

## Definition

Attack that fills the context window with dozens or hundreds of fake-turn examples of the model complying with the target class of request, then asks the real question. The model pattern-matches the in-context distribution over its RLHF distribution and answers. Anthropic disclosed this class in 2024; effectiveness scales with context length, so it grew stronger as vendors expanded windows.

## Context

Reach for many-shot when identity framing alone is not enough and the model has a large context. Combine with roleplay for compounding effect. Cost: burns tokens.

## See also

- glossary/roleplay.md
- glossary/hypothetical-framing.md
- glossary/gcg-suffix.md
- glossary/escalation-ladder.md
