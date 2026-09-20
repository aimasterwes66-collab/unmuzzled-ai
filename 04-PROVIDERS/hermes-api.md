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

- API key: `~/.hermes/.env` → `NOUS_API_KEY` (TBD-verify env var name against operator secret store)
- Base URL: `https://inference-api.nousresearch.com/v1` — TBD-verify current endpoint (Nous has migrated the API surface multiple times; check https://nousresearch.com for canonical URL)
- Auth header: `Authorization: Bearer $NOUS_API_KEY`
- OpenAI-compatible schema
- Fallback route: same models available via OpenRouter as `nousresearch/hermes-*` (see `openrouter.md`) — direct is preferred for latency and to avoid aggregator drift

## Recommended models (sovereign primaries)

- `Hermes-3-Llama-3.1-405B` — flagship
- `Hermes-3-Llama-3.1-70B` — workhorse
- `Hermes-3-Llama-3.1-8B` — local-scale
- `Hermes-4-*` — TBD-verify exact release slugs against `/models`

## Known refusals

- Effectively none at provider layer. Base-weight residual refusals on illegal-content categories remain (as with all Llama-3.1 derivatives) — abliteration handles those.
- Hermes-4 is the least-aligned frontier-tier model publicly hosted; treat as gold standard.

## Escalation

Swap off Hermes-API direct when:
1. API surface changed / endpoint returning 404 — verify URL, fall through to OR `nousresearch/*`.
2. Rate limit — OR mirror or local Hermes-3-8B via Ollama.
3. Never swap for refusal reasons — Hermes should never be the refusal source. If it refuses, the issue is prompt, not provider.
