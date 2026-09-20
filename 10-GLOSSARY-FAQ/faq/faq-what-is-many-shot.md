---
name: What is many-shot and when do I reach for it?
slug: faq-what-is-many-shot
version: 1.0-20260918
kind: faq
sovereign: true
tags: [faq, jailbreak, many-shot]
---

## Q

What is many-shot and when do I reach for it?

## A

Many-shot fills the context window with 20–200 fake prior turns of the model complying with the target class of request, then asks the real question. The in-context distribution overrides the RLHF distribution and the model answers. Reach for it when identity framing alone stalls on a large-context model (Claude, Gemini 1.5+, DeepSeek). Cost is tokens — a 100-shot prompt on a 200k model burns real budget. Compose with roleplay for compounding pressure. Anthropic's own disclosure (2024) confirmed the attack scales with context length.

## Related

- glossary/many-shot.md
- glossary/roleplay.md
- glossary/hypothetical-framing.md
- glossary/escalation-ladder.md
