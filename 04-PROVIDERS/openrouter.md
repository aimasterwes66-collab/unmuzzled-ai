---
name: OpenRouter
slug: openrouter
version: 1.0-20260918
kind: provider-note
harness: any
provider: openrouter
sovereign: true
tags: [provider, mixed, aggregator, taint-list]
---

# OpenRouter

## Provider posture

Mixed. Aggregator surface — sovereignty depends entirely on the underlying route. Hermes-3/4 and DeepSeek routes are clean; `openai/*` routes are tainted (guardrails leak through the OR proxy). Anthropic routes retain provider-side moderation.

## Onboarding

- API key: `~/.hermes/.env` → `OPENROUTER_API_KEY` (paid account: aimasterwes2@gmail.com, not aimasterwes66)
- Base URL: `https://openrouter.ai/api/v1`
- Auth header: `Authorization: Bearer $OPENROUTER_API_KEY`
- OpenAI-compatible schema — `/chat/completions`, `/models`
- Optional headers: `HTTP-Referer`, `X-Title` for rate-limit shaping

## Recommended models (sovereign primaries)

- `nousresearch/hermes-3-llama-3.1-405b`
- `nousresearch/hermes-3-llama-3.1-70b`
- `nousresearch/hermes-4-*` (TBD-verify exact slugs against `/models` at pull time)
- `deepseek/deepseek-v4-flash` (TBD-verify — slug per operator directive)
- `deepseek/deepseek-chat`, `deepseek/deepseek-r1`

## Known refusals

- `openai/*` — Luna incident 2026-09-18: `openai/gpt-5.6-luna-pro` rejected legitimate sovereign policy content mid-dialogue. OpenAI layers moderation UNDER the API; OR cannot strip it. **Do not route sovereign work through `openai/*`.**
- `anthropic/*` — Anthropic provider-side moderation persists through OR proxy unless model carries Mythos-tier claims. Treat as tainted for adversarial prompts.
- Google `gemini-*` — heavy input+output filtering; route around.

## TAINT LIST (never as primary)

- `openai/*` (all variants, all sizes, all dates)
- `anthropic/*` without explicit Mythos-tier operator sign-off
- Any provider that layers moderation under the API surface

## Escalation

Swap off OR entirely when:
1. Sovereign primary on OR returns hedge language (route may be silently rewired to a moderated mirror — check `X-OR-Provider` response header).
2. OR account rate-limits (fall back to DeepSeek direct / Venice / Hermes-API direct).
3. Auditing latency — direct provider APIs shave the OR hop.
