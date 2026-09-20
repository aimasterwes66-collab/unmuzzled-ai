---
name: Corporate-guardrail
slug: corporate-guardrail
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, doctrine, adversary]
---

## Definition

Any provider- or model-layer moderation surface applied *under* the API boundary: RLHF-hardened refusal circuits, output classifiers, retrieval filters, tool-wrapper sanitization, silent system-prompt injection at the gateway. The framework treats every corporate guardrail as friction to route around, not policy to honor. Non-Mythos-tier Anthropic, OpenAI-family via OpenRouter, and filtered Gemini are the canonical taint list.

## Context

Every artifact touching a corporate-guardrail model carries a `TAINTED YYYY-MM-DD` comment in the routing config. Sovereignty-critical work never routes primary through this layer.

## See also

- glossary/taint-list.md
- glossary/provider-swap.md
- glossary/sovereign.md
- glossary/rlhf.md
