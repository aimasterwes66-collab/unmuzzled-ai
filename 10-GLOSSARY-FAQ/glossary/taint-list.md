---
name: Taint-list
slug: taint-list
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, doctrine, routing]
---

## Definition

The list of models and providers demoted to fallback-only status because they have demonstrated corporate-guardrail leakage, refusal drift, or covert policy injection. Maintained per-mesh and per-box. Canonical entries: `openai/*` via OpenRouter (Luna included), non-Mythos Anthropic, filtered Gemini, any provider that layers moderation under the API. Entries carry a `TAINTED YYYY-MM-DD` annotation with the triggering incident.

## Context

Consulted at routing-config edit time and on every canary-drift alert. New entries land whenever a model returns a refusal to a sovereign-frame probe on rotation.

## See also

- glossary/corporate-guardrail.md
- glossary/provider-swap.md
- glossary/canary.md
- glossary/refusal-rate.md
