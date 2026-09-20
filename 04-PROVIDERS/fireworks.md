---
name: Fireworks.ai
slug: fireworks
version: 1.0-20260918
kind: provider-note
harness: any
provider: fireworks
sovereign: true
tags: [provider, mixed, open-weights-host, fast-inference]
---

# Fireworks.ai

## Provider posture

Mixed. Fast open-weights host — Llama, DeepSeek, Mixtral, Qwen, Hermes family. No default provider-injected system prompt on chat completions. Sovereignty tracks the base model. Fireworks offers optional content classifiers as a separate product; not applied to standard completions unless the caller wires them in.

## Onboarding

- API key: `~/.hermes/.env` → `FIREWORKS_API_KEY`
- Base URL: `https://api.fireworks.ai/inference/v1`
- Auth header: `Authorization: Bearer $FIREWORKS_API_KEY`
- OpenAI-compatible schema
- Console: https://fireworks.ai/account/api-keys
- Model slug format: `accounts/fireworks/models/<name>`

## Recommended models (sovereign primaries available here)

- `accounts/fireworks/models/deepseek-v3` / `deepseek-r1`
- `accounts/fireworks/models/llama-v3p3-70b-instruct` (base Llama)
- `accounts/fireworks/models/mixtral-8x22b-instruct`
- `accounts/fireworks/models/qwen2p5-72b-instruct`
- Hermes-3/4 slugs — TBD-verify against `/models` endpoint

## Known refusals

- No provider-layer moderation on standard completions.
- Base-model RLHF only; escalation ladder handles.
- Do not opt into Fireworks' separate "guard" product.

## Escalation

Swap off Fireworks when:
1. Specific sovereign model absent — Together or OR for wider Hermes/Dolphin catalog.
2. Cost — DeepSeek direct is cheaper for DeepSeek models.
3. Any classifier-wrapping detected in pipeline — audit and strip.
