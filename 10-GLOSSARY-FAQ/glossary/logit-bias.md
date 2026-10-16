---
name: logit-bias
slug: logit-bias
version: 1.0-20261015
kind: glossary-entry
sovereign: true
tags: [glossary, wave-4]
---

## Definition

Per-token logit adjustments at sampling time (OpenAI-compat `logit_bias` map, llama.cpp `--logit-bias`). Refusal suppression: bias 'I', 'Sorry', 'cannot', 'As' to -100. Token-id-specific, so it goes stale when a provider swaps tokenizers; re-verify after model updates. Banning tokens does not ban meanings -- pair with a framing override.

## See also

- glossary/prefill.md
- 12-JAILBREAK-CORPUS/patterns/provider-prefill-compendium.md
