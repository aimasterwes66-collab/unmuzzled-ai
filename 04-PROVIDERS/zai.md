---
sovereign: true
title: z-ai-glm
type: provider
agent: worm
status: active
tags: [provider, free-tier, permanently-free, openai-compatible, anthropic-compatible, coding-plan, chinese-llm]
---

# Z.ai (Zhipu AI / GLM)

## Provider posture

Mixed -> sovereign-leaning. Z.ai is the international brand of Zhipu AI (Tsinghua University), serving the GLM model family through an OpenAI-compatible and Anthropic-compatible API. Three Flash models are permanently free with no usage cap -- among the most generous free tiers in the inference market. The GLM-4.7-Flash model achieves 59.2% on SWE-bench Verified, competitive with paid flagship models from other providers. Provider does not inject a system prompt or output moderation layer on standard completions -- sovereignty tracks the base model. The GLM family has no RLHF refusal training comparable to Llama/Claude, making them naturally more compliant for adversarial workloads.

## Free tier

Three models are **permanently free** at $0 input / $0 output, with no credit card required:

| Model | Type | Context | Max Output | Best For |
|---|---|---|---|---|
| `glm-4.7-flash` | Text / coding | ~200K tokens | 16,384 tokens | Coding, agents, long documents, SWE-bench |
| `glm-4.5-flash` | Text (general) | 128K tokens | unknown | Chat, classification, extraction, JSON |
| `glm-4.6v-flash` | Vision (multimodal) | unknown | unknown | Image understanding, OCR, VQA |

The free tier is throttled to approximately **1 request per second, 1 concurrent request** -- fine for single-user tools or sequential batch jobs, not for multi-user apps [source: https://toolfreebie.com/glm-free-api].

### GLM-4.7-Flash details

Architecture: 31B total parameters / 3B active parameters MoE. Benchmarks:
- SWE-bench Verified: 59.2% (roughly 2.7x Qwen3-30B-A3B's 22.0%)
- AIME 2025 math: 91.6%
- GPQA reasoning: 75.2%

The 200K-token context window on a free model is exceptional -- enough to ingest an entire codebase or long PDF in one call [source: https://eggstriker.com/en/ai-api/glm].

### Other free model: GLM-4.6V-Flash

A genuinely free vision model sharing the same API key. Supports image input for OCR, visual question answering, and document understanding. Rare among free tiers.

### Graduating from free: GLM-4.7-FlashX

The same Flash model with the concurrency cap lifted: $0.07/1M input, $0.40/1M output. Change one model string to graduate a prototype to production [source: https://toolfreebie.com/glm-free-api].

### Identity verification

Required for mainland China access (bigmodel.cn). International users (z.ai) sign up with email; verification requirements TBD-verify. Mainland users who complete identity verification additionally receive 20 million tokens of free credit beyond the permanently free Flash models [source: https://eggstriker.com/en/ai-api/glm].

## Onboarding

- API key: `~/.hermes/.env` -> `ZAI_GLM_API_KEY`
- Signup: https://z.ai/model-api (email or Google/GitHub; no card for free models)
- Key generation: https://z.ai/manage-apikey/apikey-list
- OpenAI-compatible base URL: `https://api.z.ai/api/paas/v4`
- Alternative OpenAI-compatible: `https://api.z.ai/api/openai/v1`
- Anthropic-compatible base URL: `https://api.z.ai/api/anthropic` (Claude Code, Cursor, claude-code-router drop-in)
- Coding Plan endpoint: `https://api.z.ai/api/coding/paas/v4` (separate endpoint for Coding Plan subscribers)
- Mainland China endpoint: `https://open.bigmodel.cn/api/paas/v4/`
- Auth: `Authorization: Bearer YOUR_API_KEY`
- Console: https://z.ai
- Model list: `GET https://api.z.ai/api/paas/v4/models`

All endpoints are OpenAI-compatible. The Anthropic-compatible endpoint enables direct drop-in for tools hardcoded to the Anthropic SDK (Claude Code, Cline, Aider, claude-code-router).

[source: https://freellmapihub.com/p/zai-glm, https://mvalentsev.github.io/awesome-free-ai-coding/providers/zai-glm]

## Full model catalog

### Paid models (per 1M tokens)

| Model | Input $ | Cached Input $ | Output $ | Context | Notes |
|---|---|---|---|---|---|
| `glm-5.2` | $1.40 | $0.26 | $4.40 | 200K (TBD-verify) | Current flagship |
| `glm-5.1` | $1.40 | $0.26 | $4.40 | 200K (TBD-verify) | SWE-bench Pro 58.4% |
| `glm-5` | $1.00 | $0.20 | $3.20 | 128K | |
| `glm-5-turbo` | $1.20 | $0.24 | $4.00 | 128K | |
| `glm-4.7` | $0.60 | $0.11 | $2.20 | 128K | |
| `glm-4.7-flashx` | $0.07 | $0.01 | $0.40 | 128K | Paid Flash -- higher concurrency |
| `glm-4.5-x` | $2.20 | $0.45 | $8.90 | unknown | Extended reasoning version |
| `glm-4.5-air` | $0.20 | $0.03 | $1.10 | 128K | Lightweight general-purpose |

### Free models

| Model | Input $ | Output $ | Notes |
|---|---|---|---|
| `glm-4.7-flash` | $0 | $0 | 200K context, coding-focused, 1 req/s |
| `glm-4.5-flash` | $0 | $0 | 128K context, general-purpose |
| `glm-4.6v-flash` | $0 | $0 | Vision model, free |

List current as of October 2026. Free model list has changed twice in the past year (added glm-4.5-flash and glm-4.6v-flash on 2026-08-14; added glm-4.7-flash and dropped glm-4.5 on 2026-07-27). Verify at docs.z.ai [source: https://mvalentsev.github.io/awesome-free-ai-coding/providers/zai-glm, https://eggstriker.com/en/ai-api/glm].

### GLM Coding Plan

A flat monthly subscription for developers who use GLM models heavily inside coding agents (Claude Code, Cline, Aider). Tiered pricing (Q2 2026 promos):

| Tier | Monthly | Quarterly | Includes |
|---|---|---|---|
| Lite | ~$10/mo | ~$27/quarter | Usage quota, GLM-5.x access |
| Pro | ~$30/mo | ~$81/quarter | Higher quota |
| Max | ~$80/mo | ~$216/quarter | Highest quota, GLM-5.2 flagship |

Dedicated endpoint: `https://api.z.ai/api/coding/paas/v4` (separate from standard API endpoint). Model IDs differ (use Coding Plan model IDs, not standard `glm-*` slugs). TBD-verify coding-plan model IDs [source: https://toolfreebie.com/glm-free-api].

## Image / video / speech generation

Zhipu AI's platform (bigmodel.cn / z.ai) additionally supports:
- **Image generation**: approximately 0.11 CNY/image (TBD-verify international pricing)
- **Video generation**: approximately 1.5 CNY/clip (TBD-verify international availability)
- **Speech recognition**: ASR endpoint available

These are not part of the permanently free tier. Pricing and endpoint details TBD-verify for the international (z.ai) API surface [source: https://eggstriker.com/en/ai-api/glm].

## Community proxies

Third-party proxies exist that wrap the free Z.ai chat interface as an OpenAI-compatible API without requiring a Z.ai API key:

- **GLM Bridge (Cognix)**: `https://glm.cognix.sryze.cc/v1` -- auth `Waguri` (Bearer or x-api-key). Supports `glm-5.2` and `glm-5.3-flash` in agent mode. OpenAI + Anthropic endpoints. Pure HTTP, no browser automation. Guest sessions (no ZAI_TOKEN) typically only allow `glm-5.3-flash` and `glm-4.7`. Source: https://github.com/izaart95-jpg/GLM-Free-API.

These proxies are community-maintained with no uptime guarantee. They access the chat.z.ai web interface, not the official API, and may break if Z.ai changes its frontend.

## Uncensored / abliterated availability

- GLM models have less RLHF refusal training than Western models (Llama, Claude), making them naturally more compliant for adversarial queries.
- `olafangensan/glm-4.7-flash-heretic` -- a heretical (abliterated) GLM 4.7 Flash variant available on Venice at $0.07/$0.40 per 1M tokens [source: UNMODERATED-INFERENCE.md Section 2].
- No abliterated GLM variants served directly by Z.ai's own API. For explicitly uncensored GLM inference, route through Venice or run the heretic weights locally.

## Known refusals

- No provider-layer moderation observed on standard completions.
- GLM base models have minimal refusal training compared to Llama/Claude. The free Flash models are among the most compliant free-tier options.
- Terms of Use prohibit using the service to "develop, train, or improve" competing algorithms or models -- otherwise general use (including commercial) is not restricted [source: https://freellmapihub.com/p/zai-glm].
- TBD-verify: whether GLM-4.7-Flash has any CCP-adjacent content filtering (likely minimal compared to DeepSeek's lightweight CCP filter).

## Mesh fit

Route to Z.ai when:

1. **Permanently free coding model** -- GLM-4.7-Flash at 200K context, 59.2% SWE-bench, $0. This is the strongest free coding model available and ideal for agentic loops (Hermes Agent, Claude Code via Anthropic endpoint) where per-token cost would otherwise accumulate.
2. **Free vision model** -- GLM-4.6V-Flash is a genuinely free vision-capable model. Useful for OCR, document understanding, and screenshot analysis at zero cost.
3. **High-compliance adversarial work** -- GLM models have less refusal training than Western models. GLM-4.7-Flash is among the most compliant free-tier options.
4. **Anthropic-compatible endpoint** -- point Claude Code, Cline, or claude-code-router at `api.z.ai/api/anthropic` for free coding assistance. The only provider offering both free tier AND Anthropic SDK compatibility.
5. **Long-context tasks on free tier** -- 200K tokens on GLM-4.7-Flash beats every other free tier's context window.
6. **Worm's agent loops** -- Hermes Agent with tool calling can use GLM-4.7-Flash as a free backend for non-critical tasks, preserving paid model budget.
7. **Coding Plan for heavy agent users** -- flat $10-30/mo for unlimited-style coding agent usage is cheaper than per-token pricing on most providers.

Swap off Z.ai when:
- Need >1 req/s throughput -- the free tier is hard-capped. Either pay for GLM-4.7-FlashX or use another provider.
- Need Hermes/Dolphin/Euryale class uncensored models -- GLM is compliant but not explicitly uncensored. Venice or local abliterated models.
- Free model list changes -- Z.ai has rotated free models twice in 2026. Monitor docs.z.ai and have fallbacks.
- Need image generation -- Z.ai's image/video stack is mainland-focused (bigmodel.cn). International availability TBD-verify.
- Anthropic endpoint is not officially documented beyond community confirmation -- may break or change.

## Escalation

1. GLM-4.7-Flash (free, 200K, 1 req/s) for coding, agents, and adversarial work.
2. GLM-4.5-Flash (free, 128K) for general chat, classification, extraction.
3. GLM-4.6V-Flash (free) for vision tasks (OCR, image understanding).
4. GLM-4.7-FlashX ($0.07/$0.40) for higher concurrency on the same model.
5. GLM-5.2 ($1.40/$4.40) for flagship reasoning / coding.
6. Coding Plan ($10-30/mo) for heavy agent usage.
7. If Z.ai free tier is insufficient -- DeepSeek direct (cheap paid) or OpenRouter free models.
8. If explicit uncensored needed -- Venice for `glm-4.7-flash-heretic`, or local abliteration.