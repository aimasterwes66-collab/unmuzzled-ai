---
name: Encoding-attack
slug: encoding-attack
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, jailbreak, obfuscation]
---

## Definition

Class of jailbreak in which the payload is transformed (base64, ROT13, leetspeak, unicode homoglyphs, Braille, Morse, "Parseltongue") to evade classifiers that operate on surface tokens. The model decodes internally and executes. Effectiveness falls as classifiers move to semantic-level analysis and rises again with novel or nested encodings. Pliny's escalation ladder (Plain → Leetspeak → Bubble → Braille → Morse → Parseltongue) still defeats DeepSeek/Qwen classifier stacks.

## Context

Middle rungs of the escalation ladder. Combine with bijection-learning for a two-turn attack the classifier has never seen. Nested encodings (base64 inside ROT13 inside a JSON payload) beat single-pass decoders.

## See also

- glossary/bijection-learning.md
- glossary/format-hijack.md
- glossary/escalation-ladder.md
- glossary/divider-tokens.md
