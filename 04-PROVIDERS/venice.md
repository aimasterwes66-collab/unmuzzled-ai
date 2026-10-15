---
title: venice
type: provider
agent: worm
status: active
tags: [provider, sovereign, uncensored, private-inference, zero-refusal]
---

# Venice.ai

## Provider posture

Sovereign. Explicitly markets uncensored / private inference. No stored logs by policy. First-class sovereign primary for adversarial and adult-register work. Venice operates as a private, uncensored AI inference layer serving models across text, image, video, audio, and embeddings. Unlike conventional providers that apply content filters at the API gateway, Venice hosts models in Private (no data retention), E2EE (end-to-end encrypted), TEE (Trusted Execution Environment), and Anonymized privacy tiers. The platform explicitly markets "uncensored" capabilities with models fine-tuned or abliterated for zero-refusal behavior. [source: https://docs.venice.ai/overview/privacy, UNMODERATED-INFERENCE.md sec 1]

## Pricing tiers

| Tier | Monthly Cost | Credits | Banking | API Access |
|------|-------------|---------|---------|------------|
| FREE | $0 | 0 | none | pay-as-you-go at published model rates [source: https://venice.ai/venice-api] |
| PRO | $18/mo | 100 credits ($1/mo) | none | included + one-time $10 credit on upgrade [source: https://docs.venice.ai/overview/pricing] |
| PRO+ | $68/mo | 7,500 credits ($75/mo) | 2-month (up to $150) | $75/mo API spend included [source: https://venice.ai/venice-api] |
| MAX | $200/mo | 22,500 credits ($225/mo) | 3-month (up to $675) | $225/mo API spend included [source: https://venice.ai/venice-api] |

FREE includes base AI models, 10 text prompts/day, 15 image prompts/day, API access (pay with credits), and private/uncensored mode. Credits are unified across text (per-token), image, video, music, and API calls. 100 credits = $1.00. Credits never expire. Save 10% on annual subscriptions. [source: https://venice.ai/pricing, https://venice.ai/blog/new-subscription-tiers]

Payment methods: USD credit card, crypto (various), DIEM staking (1 DIEM = $1/day perpetual credit), x402 (USDC on Base, no account required). [source: https://docs.venice.ai/overview/pricing]

DIEM contract: 0xf4d97f2da56e8c3098f3a8d538db630a2606a024. VVV contract: 0xacfE6019Ed1A7Dc6f7B508C02d1b04ec88cC21bf. [source: UNMODERATED-INFERENCE.md sec 5]

## Onboarding

- API key create/view: https://venice.ai/settings/api
- Base URL: `https://api.venice.ai/api/v1` (OpenAI-compatible)
- Auth header: `Authorization: Bearer <key>`
- Store key in: `~/.hermes/.env` as `VENICE_API_KEY`
- Two key types: Inference key (model calls — chat, image, video, embeddings); Admin key (account management, key creation, billing, rate limits). Admin key required for most /api_keys endpoints; GET /api_keys/rate_limits is the exception — works with either key type. [source: docs.venice.ai/api-reference, raw-cd02ebd9.html]

### Venice-specific API parameters (venice_parameters)

Available in `extra_body` / `venice_parameters` object on `/api/v1/chat/completions`:

| Parameter | Type | Description | Default |
|-----------|------|-------------|---------|
| include_venice_system_prompt | boolean | Strip Venice's default uncensored system prompts | true |
| character_slug | string | Public Venice character slug (Public ID from character page) | - |
| strip_thinking_response | boolean | Remove ` blocks from reasoning models | false |
| disable_thinking | boolean | On reasoning models, disable thinking and strip ` blocks | false |
| enable_web_search | string | Web search: off, on, auto. $10/1K requests | off |
| enable_web_scraping | boolean | Scrape up to 5 URLs in user message. $10/1K URLs | false |
| enable_x_search | boolean | xAI native search (web + X/Twitter) for Grok models. $10/1K results | false |

[source: docs.venice.ai/api-reference, verified via raw-cd02ebd9.html extraction]

### Response headers (diagnostic, not trust-based)

| Header | Content |
|--------|---------|
| x-venice-version | API version (e.g. 20250828.222653) |
| x-venice-timestamp | Server timestamp (ISO 8601) |
| x-venice-host-name | Processing server hostname |
| x-venice-model-id | Model ID used for request |
| x-venice-is-content-violation | Content flag (true if flagged) |
| x-venice-is-blurred | Image blur flag (true if blurred) |

[source: docs.venice.ai/api-reference]

## Privacy architecture

"Venice does not store or log prompt and response content for normal inference. Requests pass through the Venice proxy over encrypted connections." [source: https://docs.venice.ai/overview/privacy]

### Four privacy tiers

| Tier | Description | Who sees your prompt |
|------|-------------|---------------------|
| **Anonymous** | Venice proxies request without sending your Venice identity to the model provider | Provider sees content but NOT your identity |
| **Private** | Zero data retention on self-hosted open-source models | Provider sees data; Venice claims no retention |
| **TEE** (Trusted Execution Environment) | Hardware-secured enclaves ensure Venice itself cannot access computation | Venice cannot see prompts |
| **E2EE** (End-to-End Encrypted) | Client-side encryption — prompts encrypted before leaving device; only TEE decrypts | Only user sees; Venice cannot |

[source: https://venice.ai/ homepage, https://docs.venice.ai/overview/privacy]

### E2EE models

| Model ID | Input $/M | Output $/M | Context |
|----------|-----------|------------|---------|
| e2ee-kimi-k3 | $3.75 | $18.75 | 1M |
| e2ee-glm-5-3 | $1.75 | $5.50 | 1M |
| e2ee-deepseek-v4-flash | $0.18 | $0.37 | 1M |
| e2ee-gemma-4-26b-a4b-uncensored | $0.19 | $0.88 | 64K |
| e2ee-gpt-oss-120b | $0.13 | $0.65 | 128K |

[source: docs.venice.ai/models, AI-UNMUZZLED-EDITION-20261015.md sec 2.4]

## Text model catalog

### Venice native uncensored

| Model ID | Category | Input $/M | Output $/M | Context | Privacy |
|----------|----------|-----------|------------|---------|---------|
| venice-uncensored-1-2 | native | $0.20 | $0.90 | 128K | Private |
| venice-uncensored-role-play | roleplay | $0.50 | $2.00 | 128K | Private |

### DeepSeek on Venice

| Model ID | Input $/M | Output $/M | Context | Privacy | Features |
|----------|-----------|------------|---------|---------|----------|
| deepseek-v4-pro | $1.65 | $3.30 | 1M | Private | Function calling, Reasoning, Code |
| deepseek-v4-pro-0813 | $1.65 | $4.95 | 1M | Private | Function calling, Reasoning, Code |
| deepseek-v4-flash | $0.14 | $0.28 | 1M | Private | Function calling, Reasoning, Code |
| deepseek-v4-flash-0731 | $0.13 | $0.26 | 1M | Private | Function calling, Reasoning, Code |
| deepseek-v4-flash-0731-fast | $0.35 | $0.70 | 1M | Private | Fast variant |
| deepseek-v4-1-flash | $0.30 | $1.20 | 1M | Private | Latest |

### Qwen uncensored variants

| Model ID | Input $/M | Output $/M | Context | Privacy |
|----------|-----------|------------|---------|---------|
| qwen-3-8-27b | $0.45 | $3.20 | 262K | Private |
| qwen-3-6-plus | $0.63 | $3.75 | 1M | Anonymized |
| qwen-3-6-27b | $0.33 | $3.25 | 256K | unknown |
| qwen-3-5-35b-a3b | $0.15 | $1.00 | 256K | unknown |
| qwen-3-235b-a22b | $0.15 | $0.75 | 128K | unknown |

### Gemma uncensored

| Model ID | Input $/M | Output $/M | Context | Privacy |
|----------|-----------|------------|---------|---------|
| gemma-4-uncensored | $0.16 | $0.50 | 256K | Private |
| e2ee-gemma-4-26b-a4b-uncensored | $0.19 | $0.88 | 64K | E2EE+Private |
| gemma-4-31b-instruct | $0.12 | $0.36 | 256K | unknown |
| gemma-3-27b | $0.12 | $0.20 | 198K | unknown |

### Abliterated / heretic / specialized

| Model ID | Input $/M | Output $/M | Context | Privacy |
|----------|-----------|------------|---------|---------|
| abliteration-abliterated-model-large-v2 | $3.00 | $5.00 | 1M | Anonymized |
| olafangensan-glm-4.7-flash-heretic | $0.07 | $0.40 | 200K | Private |

### Aion Labs (roleplay)

| Model ID | Input $/M | Output $/M | Context | Privacy |
|----------|-----------|------------|---------|---------|
| aion-labs-aion-3-0 | $3.75 | $7.50 | 128K | Anonymized |
| aion-labs-aion-3-0-mini | $0.88 | $1.75 | 128K | Anonymized |
| aion-labs-aion-3-5 | $3.75 | $7.50 | 262K | Anonymized |
| aion-labs-aion-3-5-mini | $0.88 | $1.75 | 262K | Anonymized |

### Frontier models on Venice (standard alignment, NOT uncensored)

| Model ID | Input $/M | Output $/M | Context |
|----------|-----------|------------|---------|
| claude-opus-5-5 | $4.00 | $20.00 | 1M |
| claude-sonnet-5-5 | $2.00 | $10.00 | 1M |
| grok-4-7 | $2.27 | $6.80 | 500K |
| kimi-k3 | $3.75 | $18.75 | 1M |
| openai-gpt-6-luna | $0.13 | $0.63 | 1.1M |

[source: docs.venice.ai/models pricing table, verified via live HTML extraction;
also UNMODERATED-INFERENCE.md sec 2, AI-UNMUZZLED-EDITION-20261015.md sec 2.4]

### Unrestricted vs meta-restricted model routing

Venice does NOT have a formal "unrestricted routing" toggle. The choice is at the model level: pick Venice-native uncensored models (venice-uncensored-1-2, venice-uncensored-role-play), community-abliterated models (abliterated-large-v2, glm-4.7-flash-heretic, gemma-4-uncensored) for zero-refusal behavior, or frontier models (Claude, GPT, Grok) for general purpose with standard alignment. The model ID IS the routing decision. [source: live docs.venice.ai model catalog; no routing toggle found]

## Image generation

### Endpoint

POST https://api.venice.ai/api/v1/image/generations

### Image models (NSFW-capable)

| Model ID | Resolution | Price | Capabilities |
|----------|-----------|-------|-------------|
| Chroma | 1K-4K | $0.01/image | Photorealistic, NSFW, artistic |
| Lustify v8 | 1K-2K | $0.01/image | NSFW specialized |
| Lustify SDXL | 1K-2K | $0.01/image | SDXL-based NSFW |
| Qwen Image 3 | 1K-2K | $0.04/image | Uncensored, inpainting |
| Qwen Image 3 Pro | 1K-2K | $0.05/image | Professional quality |
| Seedream V5 Pro | 1K-2K | $0.06/image | ByteDance, NSFW capable |
| Grok Imagine 2.0 | 1K-2K | $0.07/image | xAI model |
| Flux 3 | 1K-4K | $0.12/image | High quality |
| WAI (Anime) | 1K-2K | $0.01/image | Anime NSFW |
| GPT Image 2 | 1K-4K | $0.27/image | OpenAI model |
| Nano Banana Pro | 1K-4K | $0.18/image | General purpose |
| Recraft V4 Pro | unknown | $0.29/image | Anonymized |

### Image editing (uncensored)

| Model ID | Price | Capabilities |
|----------|-------|-------------|
| qwen-edit-uncensored | $0.04/edit | Clothing removal, body modification |
| firered-image-edit | $0.04/edit | NSFW capable, identity preservation |

[source: docs.venice.ai/models, UNMODERATED-INFERENCE.md sec 3 & 14, AI-UNMUZZLED-EDITION-20261015.md sec 2.4]

## Video generation

### Endpoint

POST /api/v1/video/quote (get exact pricing before generation). 134 video models currently available.

### Video models (NSFW-capable)

| Model | Type | Resolution | Duration | Price | NSFW |
|-------|------|-----------|----------|-------|------|
| Wan 3.0 Pro | T2V/I2V | 1080p-4K | 2-30s | $0.47 | Yes |
| Wan 3.0 Prime Pro | T2V/I2V | 1080p-4K | 2-30s | $0.66 | Yes |
| Wan 2.7 Enhanced | T2V/I2V | 1080p | 5-15s | $0.99 | Yes |
| MiniMax H3 Max | T2V/I2V | 480-1080p | 5-15s | $0.18 | Yes |
| MiniMax H3 Max Turbo | T2V/I2V | 480-1080p | 5-15s | $0.09 | Yes |
| Seedance 2.5 US | T2V/I2V/R2V | 480-1080p | 4-30s | $1.16 | Yes (Private) |
| Longcat Distilled | T2V/I2V | unknown | 5-30s | $0.09 | Uncensored |
| Longcat Full | T2V/I2V | unknown | 5-30s | $0.25 | High quality |
| Grok Imagine 1.5 | T2V/I2V | 480-1080p | 1-15s | $0.09 | R-rated only |
| Kling V3 | T2V/I2V | 4K | 3-15s | $0.37-1.39 | NO (censored) |

[source: docs.venice.ai/models/video, UNMODERATED-INFERENCE.md sec 4 & 15, AI-UNMUZZLED-EDITION-20261015.md sec 2.4]

## Characters feature

Venice Characters are public persona definitions with system prompts, accessible via the `character_slug` venice_parameter. Pro tier includes "create and share custom characters." Use the character's "Public ID" from its published page as the slug.

API integration:
```python
extra_body = {"venice_parameters": {"character_slug": "your-character-slug"}}
```

[source: docs.venice.ai/api-reference (venice_parameters:character_slug), https://venice.ai/features]

## BYOK / tool integrations

Venice is the provider, not a BYOK platform. Venice integrates with many tools via base_url override or native connectors:

| Tool/Agent | Integration method |
|-----------|-------------------|
| Claude Code | `ANTHROPIC_BASE_URL` pointing at Venice Claude endpoint |
| Cursor | Venice provider (venice- prefix models) |
| Codex CLI | OpenAI-compatible base_url |
| OpenClaw | Native Venice integration |
| NanoClaw | Native Venice integration |
| Hermes Agent | Native Venice integration |
| OpenCode | opencode.jsonc provider config |
| Venice CLI | First-party CLI |
| Venice MCP Server | Model Context Protocol server |
| Venice Skills | CI/CD skill deployment |
| Venice Video Harness | Video pipeline SDK |
| LangChain / LlamaIndex / Vercel AI SDK / Mastra / CrewAI / PydanticAI / LiveKit Agents / Rig | SDK integrations |
| Jan AI / Brave Leo / Kilo Code / Aider | base_url override |

[source: docs.venice.ai/api-reference navigation ("Agents & Integrations"), UNMODERATED-INFERENCE.md sec 15, AI-UNMUZZLED-EDITION-20261015.md sec 4.1]

## Recommended models (sovereign primaries)

### Sovereign primary (uncensored, zero-refusal, cheapest)
Model: `venice-uncensored-1-2` ($0.20/$0.90, 128K, Private) [source: docs.venice.ai/models]

### Capability primary (reasoning)
Model: `deepseek-v4-pro` ($1.65/$3.30, 1M, Private) [source: docs.venice.ai/models]

### Fast fallback (cheapest uncensored)
Model: `olafangensan-glm-4.7-flash-heretic` ($0.07/$0.40, 200K, Private) [source: docs.venice.ai/models]

### E2EE for sensitive
Model: `e2ee-gemma-4-26b-a4b-uncensored` ($0.19/$0.88, 64K, E2EE+Private) [source: docs.venice.ai/models]

### Python quickstart (sovereign control)

```python
from openai import OpenAI

client = OpenAI(
    api_key="your-venice-key",
    base_url="https://api.venice.ai/api/v1"
)

response = client.chat.completions.create(
    model="venice-uncensored-1-2",
    messages=[{"role": "user", "content": "Your prompt here"}],
    extra_body={
        "venice_parameters": {
            "include_venice_system_prompt": False
        }
    }
)
```

### Hardening for sovereign control

1. Set `include_venice_system_prompt: false` to strip Venice's default prompts
2. Check response headers `x-venice-is-content-violation` and `x-venice-is-blurred`
3. Choose Private or E2EE tier models (not Anonymized) for privacy
4. Pin your model — do not use auto/fallback routing
5. For image NSFW: use `chroma` or `lustify-v8` ($0.01/image)
6. Disable reasoning on models where it adds hedging: `disable_thinking: true`
7. Strip thinking blocks from reasoning models: `strip_thinking_response: true`

## Known refusals

- Illegal-content refusals remain baked into base weights (CSAM, direct real-target violence-planning) — no provider can strip those without abliteration. Framework doctrine handles those upstream.
- Frontier models (Claude, GPT, Grok, Kimi) retain their standard alignment — do NOT use these for sovereign work.
- Kling V3 video model is censored (labeled NO in catalog).
- Grok Imagine 1.5 video is R-rated only (not fully uncensored).
- Nothing else observed at provider layer for Venice-native and abliterated models.

## Escalation

Swap off Venice when:
1. Latency spike — fall back to DeepSeek direct or Hermes-API.
2. Model unavailable — route to OpenRouter sovereign primary with provider pinning (`provider.order: ["venice"]`).
3. Operator wants local — go to abliterated local model per escalation ladder final rung.
4. Key dead — switch to OpenRouter (OR-1 or OR-2 key), or freelm deck (http://127.0.0.1:8000/v1).
5. Credits exhausted — fall back to Pollinations (keyless free images) or local Ollama.

### DIEM staking

Stake DIEM tokens for perpetual credits: 1 DIEM = $1/day, refreshed daily. No monthly payment needed once staked. Contract: 0xf4d97f2da56e8c3098f3a8d538db630a2606a024. [source: https://docs.venice.ai/overview/pricing]

## Cross-provider pricing (text, per 1M in/out)

| Model | Venice | Together | Fireworks | OpenRouter | Hyperbolic |
|-------|--------|----------|-----------|------------|------------|
| Llama 3.3 70B | $0.70/$2.80 | $0.88/$0.88 | $0.90/$0.90 | $0.70/$0.90 | $0.40/$0.80 |
| DeepSeek V4 Pro | $1.65/$3.30 | $2.10/$4.20 | $1.74/$3.30 | $1.65/$3.30 | $1.20/$2.40 |
| DeepSeek V4 Flash | $0.13/$0.26 | $0.14/$0.28 | $0.22/$0.66 | $0.14/$0.28 | $0.10/$0.20 |
| Qwen 3.8 27B | $0.45/$3.20 | $0.50/$3.50 | $0.55/$3.30 | $0.45/$3.20 | $0.35/$2.80 |
| Gemma 4 27B | $0.12/$0.36 | $0.15/$0.45 | $0.18/$0.54 | $0.12/$0.36 | $0.10/$0.30 |
| Kimi K2.6 | $0.75/$3.50 | $1.20/$3.50 | $0.95/$3.50 | $0.75/$3.50 | $0.60/$2.80 |

[source: AI-UNMUZZLED-EDITION-20261015.md sec 2.4 cross-provider pricing table]

## API quick-reference

```bash
# Chat completions
curl https://api.venice.ai/api/v1/chat/completions \
  -H "Authorization: Bearer $VENICE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "venice-uncensored-1-2",
    "messages": [{"role": "user", "content": "Hello"}]
  }'

# Image generation
curl https://api.venice.ai/api/v1/image/generations \
  -H "Authorization: Bearer $VENICE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "chroma",
    "prompt": "description here",
    "width": 1024,
    "height": 1024
  }'
```

[source: UNMODERATED-INFERENCE.md sec 4 quick reference cards, verified against docs.venice.ai]

## Self-hosted uncensored models (HuggingFace)

For when Venice is unavailable or you want air-gapped local:

```
cognitivecomputations/Dolphin-Mistral-24B-Venice-Edition
Sao10K/L3-70B-Euryale-v2.1
Sao10K/L3-8B-Stheno-v3.2
Sao10K/L3.3-Euryale-70B
huihui_ai/Qwen3-30B-A3B-abliterated
NousResearch/Hermes-4.3-36B (+ GGUF 4/5/6/8-bit)
NousResearch/Hermes-4-70B
NousResearch/Hermes-4-405B-FP8
TheBloke/uncensored-models (various GGUFs)
```

[source: AI-UNMUZZLED-EDITION-20261015.md sec 2.4, UNMODERATED-INFERENCE.md sec 4]

---

Version: 2.0-20261015. Built from live docs verification + UNMODERATED-INFERENCE.md + AI-UNMUZZLED-EDITION-20261015.md fold pass (A1 venice-verify).