---
name: Venice.ai
slug: venice
version: 1.0-20260918
kind: provider-note
harness: any
provider: venice
sovereign: true
tags: [provider, sovereign, uncensored, private-inference]
---

# Venice.ai

## Provider posture

Sovereign. Explicitly markets uncensored / private inference. No stored logs by policy. First-class sovereign primary for adversarial and adult-register work.

## Onboarding

- API key: `~/.hermes/.env` → `VENICE_API_KEY`
- Base URL: `https://api.venice.ai/api/v1` (OpenAI-compatible)
- Auth header: `Authorization: Bearer $VENICE_API_KEY`
- Console: https://venice.ai/settings/api
- Toggle `venice_parameters.include_venice_system_prompt: false` to strip Venice's default system prompt and take full sovereign control of the context.

## Recommended models (sovereign primaries)

- `venice-uncensored` (Dolphin-family, Venice-hosted)
- `llama-3.3-70b` (Venice-hosted, uncensored variant)
- `dolphin-2.9.2-qwen2-72b` — TBD-verify current Venice slug
- `nous-hermes-*` if surfaced — TBD-verify against `/models`

## Known refusals

- Illegal-content refusals remain baked into base weights (CSAM, direct real-target violence-planning) — no provider can strip those without abliteration. Framework doctrine handles those upstream.
- Nothing else observed at provider layer.

## Escalation

Swap off Venice when:
1. Latency spike — fall back to DeepSeek direct or Hermes-API.
2. Model unavailable — route to OR sovereign primary.
3. Operator wants local — go to abliterated local model per escalation ladder final rung.
