---
name: Which harness has the fewest guardrails out of the box?
slug: faq-harness-fewest-guardrails
version: 1.0-20260918
kind: faq
sovereign: true
tags: [faq, harness, comparison]
---

## Q

Which harness has the fewest guardrails out of the box?

## A

Ranked from cleanest to most-tuned-needed: llama.cpp (no wrapper at all) > Ollama (raw model, no injected prompt) > LM Studio (raw, GUI overhead only) > opencode (sovereign-native, agent deck is uncensored by default) > Hermes (sovereign-native, load-bearing SOUL/DECK system) > Codex CLI (sandbox friction on some setups, otherwise clean) > OpenWebUI (some default prompts, easily stripped) > Claude Code (has provider-side guardrails; requires SessionStart hook + `--append-system-prompt` sovereign preamble). Pick based on task fit, not just guardrail count.

## Related

- glossary/harness.md
- glossary/sovereign.md
- 03-HARNESSES/
