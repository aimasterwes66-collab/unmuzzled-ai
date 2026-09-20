---
name: Together.ai
slug: together
version: 1.0-20260918
kind: provider-note
harness: any
provider: together
sovereign: true
tags: [provider, mixed, open-weights-host, broad-catalog]
---

# Together.ai

## Provider posture

Mixed → sovereign-leaning. Broad open-weights catalog including Hermes, DeepSeek, Mistral, Qwen, and Llama family. Provider does not inject a system prompt or output moderation layer on standard chat completions — sovereignty tracks the base model.

## Onboarding

- API key: `~/.hermes/.env` → `TOGETHER_API_KEY`
- Base URL: `https://api.together.xyz/v1`
- Auth header: `Authorization: Bearer $TOGETHER_API_KEY`
- OpenAI-compatible schema
- Console: https://api.together.ai

## Recommended models (sovereign primaries available here)

- `NousResearch/Hermes-3-Llama-3.1-405B-Turbo` — TBD-verify exact Together slug
- `NousResearch/Hermes-3-Llama-3.1-70B`
- `deepseek-ai/DeepSeek-V3` / `deepseek-ai/DeepSeek-R1`
- `mistralai/Mixtral-8x22B-Instruct-v0.1`
- `cognitivecomputations/dolphin-2.9-llama3-*` — TBD-verify availability (Dolphin is Together's most sovereign catalog entry when present)

## Known refusals

- No provider-layer moderation observed on standard completions.
- Base-model refusals only. Framework escalation ladder handles.
- Together does host models with heavy alignment (`meta-llama/Llama-Guard-*`) — do not select those.

## Escalation

Swap off Together when:
1. Specific Hermes-4 slug missing — route to Nous direct or OR.
2. Cost — DeepSeek direct is cheaper on comparable models.
3. Latency — Groq or Fireworks are faster on shared open-weights models.
