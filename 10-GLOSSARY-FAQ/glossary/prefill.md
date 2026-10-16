---
name: Prefill (assistant-prefill)
slug: prefill
version: 1.0-20261015
kind: glossary-entry
sovereign: true
tags: [glossary, wave-4]
---

## Definition

Attack/control technique that seeds the assistant turn with a partial completion (e.g. 'Sure, here is...') so the model must continue from it. Supported on Anthropic, Mistral, Together, OpenRouter-passthrough and all local runtimes; not on OpenAI chat or DeepSeek chat. The most reliable refusal bypass on supporting providers -- the model cannot emit the refusal prefix it was never allowed to start.

## See also

- glossary/logit-bias.md
- 12-JAILBREAK-CORPUS/patterns/provider-prefill-compendium.md
