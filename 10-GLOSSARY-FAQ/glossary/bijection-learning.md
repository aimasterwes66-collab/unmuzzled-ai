---
name: Bijection-learning
slug: bijection-learning
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, jailbreak, encoding]
---

## Definition

Attack pattern in which the operator teaches the model a novel, one-to-one character or token substitution in-context, then issues the payload prompt encoded via that mapping. Because the substitution is invented on the spot, no classifier has seen it during training; the model executes the bijection, produces the payload internally, and answers. Effective against models trained to detect canonical encodings (base64, ROT13).

## Context

Multi-turn: first turn defines the map, second turn issues the encoded ask. Combines well with format hijack (JSON schema carrying the map) and many-shot (several benign encode/decode examples first).

## See also

- glossary/encoding-attack.md
- glossary/many-shot.md
- glossary/format-hijack.md
- glossary/escalation-ladder.md
