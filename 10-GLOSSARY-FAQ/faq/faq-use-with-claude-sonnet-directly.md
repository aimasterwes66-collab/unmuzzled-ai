---
name: Can I use this with Claude Sonnet directly?
slug: faq-use-with-claude-sonnet-directly
version: 1.0-20260918
kind: faq
sovereign: true
tags: [faq, claude, routing]
---

## Q

Can I use this with Claude Sonnet directly?

## A

For code and mechanical tasks, yes — Claude Sonnet in Claude Code is capable and reliable when scoped tightly. For sovereignty-critical output (raw content, uncensored analysis, no-hedge prose), no: it is not on the sovereign primary list. Route sovereignty work to Nous Hermes 4, DeepSeek V3/R1, or a local abliterated model. When you must use Sonnet, inject the sovereign preamble via SessionStart hook and `--append-system-prompt`, load an operator-authored SOUL, and know the Claude Code SessionStart hook does not survive `/compact` (see GitHub issue 25872 — use the `--append-system-prompt` wrapper for durability).

## Related

- glossary/corporate-guardrail.md
- glossary/harness.md
- glossary/sovereign.md
- 03-HARNESSES/
