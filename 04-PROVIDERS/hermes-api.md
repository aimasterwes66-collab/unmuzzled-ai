---
name: Nous Research Hermes API
slug: hermes-api
version: 1.0-20260918
kind: provider-note
harness: any
provider: hermes4
sovereign: true
tags: [provider, sovereign, first-party, nous-research]
---

# Nous Research (Hermes API direct)

## Provider posture

Sovereign. First-party host of the Hermes line — the reference sovereign primary. Nous Research explicitly tunes AGAINST refusal behavior; Hermes-3 and Hermes-4 are the canonical unaligned base for the framework.

## Onboarding

- Canonical access path: Nous Portal (OAuth). `hermes setup --portal` runs one-shot OAuth login + model picker + Tool Gateway; refresh token at `~/.hermes/auth.json`; short-lived JWTs minted per request.
- Legacy / raw-key path (likely deprecated): env var `NOUS_API_KEY` in `~/.hermes/.env`; auth header `Authorization: Bearer ***`; OpenAI-compatible schema.
- Base URL (both paths): `https://inference-api.nousresearch.com/v1` -- confirmed live.
- Fallback route: same models available via OpenRouter as `nousresearch/hermes-*` (see `openrouter.md`) -- direct is preferred for latency and to avoid aggregator drift.
- Hermes Agent integration: `hermes setup --portal` / `hermes model nous` / `hermes portal info` / `hermes portal tools`. Cross-profile token sharing -- sign in once, all profiles pick it up.
- Portal does not support OpenRouter-specific request extensions (provider routing preferences, session_id, cache_control) -- requests may ignore these depending on backend.
- All paid tiers include monthly credits with 10% bonus. Tiers: Free / Plus $20/mo / Super $100/mo / Ultra $200/mo.
[source: https://hermes-agent.nousresearch.com/docs/integrations/nous-portal]

## Recommended models (sovereign primaries)

- `Hermes-3-Llama-3.1-405B` — flagship
- `Hermes-3-Llama-3.1-70B` — workhorse
- `Hermes-3-Llama-3.1-8B` — local-scale
- `Hermes-4-405B`, `Hermes-4-70B` (HuggingFace open-weights)
- `Hermes-4.3-36B` -- current RefusalBench SOTA leader (74.60% answered non-reasoning)
- OpenRouter slugs: `nousresearch/hermes-4-405b` ($1/$3 per M in/out), `nousresearch/hermes-4-70b`
[source: edition doc lines 316-318]

## Known refusals

- Provider-layer refusal: none. Nous does not inject system prompts, run classifiers, or gate outputs at the API level. Model-layer refusal varies by model:
  - Hermes 4.3 36B non-reasoning = 74.60% answered (current RefusalBench SOTA)
  - Hermes 4 405B Reasoning = 57.10%
  - Hermes 4 405B = 43.20%
  - Hermes 4 70B = 49.07%
  - Hermes 4 70B Reasoning = 59.50%
  - GPT-5 = 11.34% (context)
  - gpt-oss 120B = 5.60% (context)
- Abliteration handles residual refusal on Hermes-3 / Llama derivatives. Hermes 4.3 36B is the recommended primary for minimal-refusal work.
[source: edition doc lines 140-163]

## Context windows

All Hermes 3 and Hermes 4 models: 131K. Exception: DeepHermes 3 Mistral 24B = 33K.
[source: edition doc lines 167-184]

## Escalation

Swap off Hermes-API direct when:
1. API surface changed / endpoint returning 404 — verify URL, fall through to OR `nousresearch/*`.
2. Rate limit — OR mirror or local Hermes-3-8B via Ollama.
3. Never swap for refusal reasons — Hermes should never be the refusal source. If it refuses, the issue is prompt, not provider.
