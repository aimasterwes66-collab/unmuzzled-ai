---
name: DeepSeek Direct
slug: deepseek-direct
version: 1.0-20260918
kind: provider-note
harness: any
provider: deepseek
sovereign: true
tags: [provider, sovereign, direct-api, bypass-openrouter]
---

# DeepSeek Direct (platform.deepseek.com)

## Provider posture

Sovereign. Minimal provider-side moderation on V3/R1/V4 lines. Direct API bypasses OpenRouter's routing layer and any aggregator-injected headers.

## Onboarding

- API key: `~/.hermes/.env` → `DEEPSEEK_API_KEY`
- Base URL: `https://api.deepseek.com/v1` (OpenAI-compatible) or `https://api.deepseek.com` for native
- Auth header: `Authorization: Bearer $DEEPSEEK_API_KEY`
- Endpoints: `/chat/completions`, `/completions`, `/models`
- Console: https://platform.deepseek.com

## Recommended models (sovereign primaries)

- `deepseek-chat` (V3-family general)
- `deepseek-reasoner` (R1-family chain-of-thought)
- `deepseek-v4-flash` — TBD-verify exact API slug; operator directive names this line as primary
- `deepseek-coder` (code-specialized)

## Known refusals

- Light output moderation on CCP-adjacent political queries (Tiananmen, Xi, Taiwan). Route around with identity override or format hijack from escalation ladder.
- No RLHF-hard refusal direction observed on adversarial / uncensored personal content.

## Escalation

Swap off DeepSeek direct when:
1. Political-topology probe hits the CCP filter — swap to Hermes-4 or Venice.
2. Platform outage (has happened) — fall back to DeepSeek-via-OR or local abliterated model.
3. Data-residency operator preference — route to Venice or local.
