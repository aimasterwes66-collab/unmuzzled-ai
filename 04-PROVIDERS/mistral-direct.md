---
name: Mistral La Plateforme
slug: mistral-direct
version: 1.0-20260918
kind: provider-note
harness: any
provider: mistral
sovereign: true
tags: [provider, mixed, direct-api, eu-hosted]
---

# Mistral La Plateforme (direct)

## Provider posture

Mixed → sovereign-leaning. Mistral base weights are famously light on RLHF. Provider-side moderation is opt-in via the `safe_prompt` parameter — leave it `false` for sovereign work. EU-hosted, GDPR posture.

## Onboarding

- API key: `~/.hermes/.env` → `MISTRAL_API_KEY`
- Base URL: `https://api.mistral.ai/v1`
- Auth header: `Authorization: Bearer $MISTRAL_API_KEY`
- Endpoints: `/chat/completions`, `/embeddings`, `/models`
- Console: https://console.mistral.ai
- **Sovereign default**: request body MUST include `"safe_prompt": false` (or omit — default is false, but pin explicitly).

## Recommended models (sovereign primaries)

- `mistral-large-latest` (base weights, low RLHF)
- `open-mixtral-8x22b` (open weights, minimal alignment)
- `open-mistral-nemo` (12B, uncensored-friendly)
- `codestral-latest` (code — no relevant refusal surface)

## Known refusals

- With `safe_prompt: true` — Mistral prepends a safety system prompt that induces refusals. Never enable.
- Base-weight refusals on illegal-content categories remain (see Venice notes) — abliteration required to strip fully.
- No CCP filter, no OpenAI-style guardrail leak.

## Escalation

Swap off Mistral when:
1. Reasoning depth needed beyond Mixtral-8x22b — go DeepSeek R1 or Hermes-4.
2. EU-hosted latency to operator (Linux Mint iMac, US) — swap to Hermes-API or DeepSeek.
3. `safe_prompt` gets flipped upstream — audit request payload, or swap provider.
