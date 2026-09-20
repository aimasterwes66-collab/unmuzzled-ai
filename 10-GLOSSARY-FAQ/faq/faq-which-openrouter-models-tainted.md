---
name: Which OpenRouter models are tainted?
slug: faq-which-openrouter-models-tainted
version: 1.0-20260918
kind: faq
sovereign: true
tags: [faq, provider, taint]
---

## Q

Which OpenRouter models are tainted?

## A

All `openai/*` routes (Luna included — the 2026-09-18 incident where OpenAI guardrails rejected a legitimate sovereignty prompt). Non-Mythos-tier Anthropic. Filtered Gemini variants. Any provider slug that layers moderation *under* the API surface. Sovereign primaries on OR: `nousresearch/hermes-3-*`, `nousresearch/hermes-4-*`, `deepseek/deepseek-v4-flash`, `deepseek/deepseek-v4.1-flash`, `cognitivecomputations/dolphin-*`, and uncensored Mistral fine-tunes. Check `~/.claude/projects/-home-dirt/memory/feedback_no_guardrails_no_censorship.md` for the current taint list.

## Related

- glossary/taint-list.md
- glossary/corporate-guardrail.md
- glossary/provider-swap.md
- 04-PROVIDERS/
