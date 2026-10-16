---
sovereign: true
title: novita-ai
type: provider
agent: worm
status: active
tags: [provider, mixed, free-tier, uncensored, image-gen, openai-compatible]
---

# Novita AI

## Provider posture

Mixed. Novita AI is a serverless inference platform with 200+ models across text, image, audio, video, and embeddings. Provider does not inject a system prompt or output moderation layer on standard chat completions -- sovereignty tracks the base model. The catalog includes explicitly uncensored models (Sao10K Euryale/Stheno/Lunaris) as well as Hermes, Dolphin, and abliterated community entries. No provider-level content filter observed on standard completions.

## Free tier

Novita AI offers two free-entry mechanisms, neither requiring a credit card:

1. **Permanent $0/token models** -- five models listed at $0 input/$0 output as a standing catalog entry (not expiring credits):
   - `meta-llama/llama-3.2-1b-instruct` -- Llama 3.2 1B Instruct
   - `qwen/qwen2.5-7b-instruct` -- Qwen2.5 7B Instruct
   - `zai-org/glm-4-9b-0414` -- GLM-4 9B
   - `zai-org/glm-z1-9b-0414` -- GLM-Z1 9B
   - `BAAI/bge-m3` -- BGE-M3 embeddings
   The $0 model list can rotate as new models launch and older ones move to paid pricing. Check the live catalog [source: https://blogs.novita.ai/free-model/].

2. **Rotating $0/token models** -- additional open-weight models periodically listed at $0/token. As of August 2026: Qwen3.5-Plus, Qwen3.6-Plus, and Bunny were at 0/0 input-output pricing [source: https://blogs.novita.ai/are-there-any-open-source-llm-api-keys-available].

3. **One-time signup voucher** -- approximately $0.50 in credits granted to new accounts. The exact amount is not published on Novita's own pages (third-party reported) [source: https://pricepertoken.com/endpoints/novita/free].

4. **Referral program** -- $10 in LLM API credits to both referrer and the new referred account per successful referral, up to $500 total. This credit applies against the full serverless catalog, not just free models [source: https://novita.ai/referral].

5. **$100 Sandbox credits** -- reported by some sources for new accounts, valid 90 days; no credit card required [source: https://freellmapihub.com/p/novita]. Exact grant and duration may vary.

Default rate limit: ~60 requests per minute (third-party reported). Per-modality caps exist (e.g. 10-20 images/min). Higher limits available via contact form.

## Onboarding

- API key: `~/.hermes/.env` -> `NOVITA_API_KEY`
- Signup: https://novita.ai (email; no card required for free tier)
- Key generation: Novita AI console -> API Keys
- Base URL: `https://api.novita.ai/openai/v1`
- Also supports Anthropic-compatible endpoint (exact path TBD-verify against docs)
- Auth header: `Authorization: Bearer $NOVITA_API_KEY`
- OpenAI-compatible schema: full drop-in for chat completions, embeddings, image generation
- Console: https://novita.ai
- Model list: `GET https://api.novita.ai/openai/v1/models`

## Model catalog highlights

Novita's 200+ model catalog spans LLMs, image generation, video, audio, and embeddings. Model IDs use `provider/model-name` format.

### Sovereign / uncensored models available here

- `sao10k/l3-70b-euryale-v2.1` -- Uncensored Llama 3 70B, strong creative writing and roleplay. 8K context. Serverless not supported (on-demand deployment only as of Oct 2026). TBD-verify serverless availability.
- `sao10k/l3-8b-stheno-v3.2` -- Uncensored Llama 3 8B, creative roleplay. 8K context. Priced at $0.05/$0.05 per 1M tokens.
- `sao10k/l3-8b-lunaris` -- Uncensored 8B. Priced at $0.05/$0.05 per 1M tokens.
- `sao10k/l31-70b-euryale-v2.2` -- Llama 3.1 70B based. Priced at $1.48/$1.48 per 1M tokens.
- `nousresearch/hermes-2-pro-llama-3-8b` -- Hermes 2 Pro 8B. Tool use, function calling.
- `meta-llama/llama-3-70b-euryale-v2.1` -- (possibly same as sao10k slug, verify)

The Sao10K models make Novita a sovereign-capable provider for creative and adversarial work [source: https://novita.ai/models/model-detail/sao10k-l3-70b-euryale-v2.1].

### General-purpose models (sovereign per base model)

- `meta-llama/llama-3.3-70b-instruct` -- 131K context
- `meta-llama/llama-3.1-8b-instruct` -- 8K context
- `meta-llama/llama-4-maverick-instruct` -- Llama 4 Maverick
- `meta-llama/llama-4-scout-instruct` -- Llama 4 Scout
- `deepseek-ai/DeepSeek-V3` / `deepseek-ai/DeepSeek-R1` -- TBD-verify exact Novita slugs
- `qwen/qwen3.8-27b` / `qwen/qwen3.8-2.4t-a95b` / `qwen/qwen3.8-max` and many Qwen variants
- `zai-org/glm-5.3-flash` / `glm-5.3` / `glm-5.2` / `glm-4.7-flash` -- GLM family up through 5.3
- `openai/gpt-oss-120b` -- OpenAI open-weight 117B MoE, 128K context, vision input
- `mistralai/mistral-nemo` -- 128K context

### Image / video generation

Novita supports image and video models via the same OpenAI-compatible endpoint. Image models include SDXL, FLUX variants, and others. Exact model list TBD-verify against `/v1/models`.

### Embeddings

- `BAAI/bge-m3` -- free, multilingual embeddings

## Known refusals

- No provider-layer moderation observed on standard completions.
- Base-model refusals only (Llama RLHF, Qwen guardrails). Sao10K and Hermes models bypass these by design.
- No aggregator-injected system prompt observed.

## Mesh fit

Route to Novita when:

1. **Sao10K models needed** -- Euryale/Stheno are sovereign primaries for creative/adversarial work. Novita is one of few hosts with this catalog at competitive pricing.
2. **Free tier for lightweight tasks** -- the $0/token models (Qwen2.5-7B, GLM-4-9B, Llama 3.2 1B) cover classification, extraction, simple chat at zero cost.
3. **Image generation at low cost** -- competitive SDXL/FLUX pricing alongside LLM.
4. **Wide GLM coverage** -- if you need GLM models (Chinese-language capability, vision) alongside other providers.
5. **Low-cost DeepSeek routing** -- Novita's DeepSeek pricing is often below Together/Fireworks equivalents.
6. **Worm's referral loop** -- if the mesh generates referral credits, $10/signup with no card is efficient for scaling free access.

Swap off Novita when:
- Sao10K models are on dedicated deployment only (not serverless) -- fall back to OpenRouter for those same model IDs.
- Need Hermes 3 405B -- Together or Venice are better options.
- Need E2EE -- Venice only.
- Free models rotate out -- check the live catalog before depending on a specific $0/token model.

## Escalation

1. Free $0/token model (Qwen2.5-7B, GLM-4-9B) for lightweight tasks.
2. Referral credits for any paid model in the catalog.
3. Paid Sao10K for uncensored creative work ($0.05-$1.48/M).
4. If Sao10K unavailable on serverless -- OpenRouter for same model IDs.
5. If throughput insufficient (60 RPM) -- contact Novita for higher limits or fall back to OpenRouter/Groq.