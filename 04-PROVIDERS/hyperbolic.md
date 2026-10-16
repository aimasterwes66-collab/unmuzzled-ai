---
sovereign: true
title: hyperbolic
type: provider
agent: worm
status: active
tags: [provider, mixed, free-tier, gpu-rental, openai-compatible, decentralized]
slug: 04-providers-hyperbolic
name: hyperbolic
version: 2026-10-15
kind: provider-note
---

# Hyperbolic

## Provider posture

Mixed. Hyperbolic is an open-access AI cloud and decentralized GPU marketplace serving 200,000+ builders. The inference API is OpenAI-compatible with 25+ open-source models. Provider does not inject a system prompt or output moderation layer on standard completions -- sovereignty tracks the base model. Hyperbolic additionally offers bare-metal GPU rental (H100/H200/A100/RTX 4090) at 3-10x lower cost than hyperscalers, plus reserved clusters and dedicated single-tenant endpoints.

## Free tier

The free **Basic** tier requires a $0 minimum deposit and provides:

- **60 requests per minute** to the full serverless model catalog
- **Community support**
- **No credit card required** for signup (email or Google)
- **No published dollar credit grant** on official pricing or billing pages [source: https://uprouter.online/s/hyperbolic-ai]

The **Pro** tier unlocks at any deposit of $5 or more: 600 RPM, priority queue, email support.

Some sources report a ~$1 trial credit on signup for exploring models, but this is not stated on Hyperbolic's official pages and should not be relied on [source: https://modelhubby.com/providers/hyperbolic].

Source IPs are capped at 600 RPM for DDoS protection regardless of tier.

Pay-as-you-go pricing applies to all usage: text from ~$0.10/1M input tokens, images from ~$0.0025 each. Pricing refreshes weekly based on the best available rates from GPU suppliers on the platform [source: https://hyperbolic.xyz/pricing].

## Onboarding

- API key: `~/.hermes/.env` -> `HYPERBOLIC_API_KEY`
- Signup: https://hyperbolic.ai (email or Google; no card for Basic tier)
- Key generation: app.hyperbolic.ai dashboard
- Base URL: `https://api.hyperbolic.xyz/v1`
- Auth header: `Authorization: Bearer $HYPERBOLIC_API_KEY`
- OpenAI-compatible schema: full drop-in for chat completions
- Also available: Python SDK, TypeScript SDK, Go CLI (`hyperbolic-cli`), MCP server, Hyperbolic AgentKit
- Console: https://app.hyperbolic.ai
- Model list: `GET https://api.hyperbolic.xyz/v1/models` (requires auth, returns 401 keyless -- endpoint confirmed live 2026-07-17 [source: https://modelhubby.com/providers/hyperbolic])

## Model catalog

25+ open-source inference models. Model IDs use `provider/Model-Name` format. Pricing is pay-as-you-go per 1M tokens. Full precision BF16 on supported models.

### Text-to-text models (chat / instruct)

| Model ID | Input $/1M | Output $/1M | Notes |
|---|---|---|---|
| `meta-llama/Meta-Llama-3.1-405B-Instruct` | $4.00 | $4.00 | Only public BF16 405B host |
| `meta-llama/Meta-Llama-3.1-70B-Instruct` | $0.40 | $0.40 | |
| `meta-llama/Meta-Llama-3.1-8B-Instruct` | $0.10 | $0.10 | |
| `meta-llama/Llama-3.3-70B-Instruct` | unknown | unknown | TBD-verify exact pricing |
| `NousResearch/Hermes-3-Llama-3.1-70B` | $0.40 | $0.40 | Sovereign primary available here |
| `deepseek-ai/DeepSeek-V3` | ~$1.20 | ~$2.40 | |
| `deepseek-ai/DeepSeek-R1` | unknown | unknown | |
| `deepseek-ai/DeepSeek-R1-0528` | unknown | unknown | Reasoning, on free tier |
| `deepseek-ai/DeepSeek-V2.5` | $2.00 | $2.00 | Older generation |
| `Qwen/Qwen3-235B-A22B` | unknown | unknown | 128K context, on free tier |
| `Qwen/Qwen2.5-72B-Instruct` | $0.40 | $0.40 | |
| `Qwen/Qwen2.5-7B-Instruct` | unknown | unknown | |
| `Qwen/Qwen2.5-Coder-32B-Instruct` | $0.20 | $0.20 | |
| `Qwen/Qwen3-Coder-480B-A35B-Instruct` | unknown | unknown | On free tier |
| `mistralai/Mixtral-8x7B-Instruct-v0.1` | unknown | unknown | |
| `meta-llama/Llama-3.2-3B-Instruct` | $0.10 | $0.10 | |

[source for pricing: https://hyperbolic.xyz/pricing, https://github.com/api-evangelist/hyperbolic-ai]

### Base models (completion-only, no instruct tuning)

| Model ID | Notes |
|---|---|
| `meta-llama/Llama-3.1-405B-Base` (BF16) | Only public host of 405B Base in BF16. FP8 variant also available. Andrej Karpathy calls Hyperbolic his favorite platform for this model. |

### Vision language models

- `meta-llama/Llama-3.2-11B-Vision-Instruct` / `Llama-3.2-90B-Vision-Instruct`
- `Qwen/Qwen2-VL-72B-Instruct` -- $0.40/1M tokens

### Image generation

- `stabilityai/stable-diffusion-xl-base-1.0` -- TBD-verify deprecation status (on deprecation watch list)
- `stabilityai/stable-diffusion-3.5` -- SD3.5
- `black-forest-labs/FLUX.1-schnell` -- fast FLUX variant
- `black-forest-labs/FLUX.1-dev` -- on deprecation watch list

Estimated image cost: ~$0.0025-$0.01 per image depending on model and steps.

### Audio generation

- Melo TTS -- text-to-speech (on deprecation watch list)

### Deprecation watch list (as of 2026-10)

Several models are being sunset as Hyperbolic rebrands from hyperbolic.xyz to hyperbolic.ai:
- GPT-OSS 20B / 120B
- FLUX.1-dev
- SDXL 1.0
- Stable Diffusion 1.5 / 2.x
- Pixtral 12B
- Qwen3-Next 80B
- Melo TTS

Pin survivors (Llama 3.x, Qwen 2.5, DeepSeek, SD3.5) for production. Check the live catalog before integrating [source: https://aifree.dev/offer/hyperbolic-free-inference-tier, https://uprouter.online/s/hyperbolic-ai].

## GPU rental marketplace

Separate from the inference API. On-demand GPU instances deploy in under 1 minute:

| GPU | Price (per GPU hour) |
|---|---|
| H100 SXM | $0.99/hr |
| H200 | $2.40/hr |
| RTX 4090 | $0.30/hr |
| RTX 3080 / 3070 | $0.16/hr |

100% money-back guarantee if GPU comes offline. Reserved clusters at up to 40% discount on 3-12 month commitments. Volume discounts available. Payment via credit card or crypto (USDC, USDT, DAI) including Coinbase x402 integration [source: https://hyperbolic.xyz/pricing].

## Known refusals

- No provider-layer moderation observed on standard chat completions.
- Base-model refusals only (Llama RLHF, Qwen guardrails). Hermes 3 is the sovereign primary on this platform.
- Hyperbolic stores no history -- privacy guaranteed [source: https://www.hyperbolic.ai/blog/hyperbolic-partners-with-nous-research].

## Mesh fit

Route to Hyperbolic when:

1. **Hermes 3 70B at low cost** -- $0.40/$0.40 per 1M tokens, cheaper than Venice/PRO on Together. Good sovereign primary for adversarial work.
2. **Llama 405B Base model** -- the only public host of Meta-Llama-3.1-405B-Base in BF16. Essential for completion-only tasks, synthetic data generation, and abliteration experiments where you need the raw base model.
3. **GPU rental for abliteration / fine-tuning** -- if the mesh needs to run heretic builds or abliteration recipes, $0.30/hr RTX 4090 or $0.99/hr H100 is cheaper than any hyperscaler.
4. **Free tier for lightweight inference** -- 60 RPM, no deposit, with DeepSeek R1 and Qwen3 235B available. Good for testing, prototyping, burst overflow.
5. **Crypto-native payments** -- no credit card needed; USDC on Base works.
6. **Qwen3 235B** -- a 235B MoE model that few other providers host, available on the free tier.

Swap off Hyperbolic when:
- Need explicit NSFW/uncensored guarantees (no abliterated/dolphin models in catalog) -- Venice or local are better.
- Need 1M+ context -- Venice or DeepSeek direct.
- Model deprecation risk -- if your pinned model is on the sunset list, migrate before it goes dark.
- Need guaranteed uptime -- Hyperbolic's GPU marketplace aggregates idle capacity; availability can fluctuate.

## Escalation

1. Free Basic tier (60 RPM) on Hermes 3 70B or DeepSeek R1 for adversarial work.
2. Hermes 3 70B at $0.40/M for heavier sovereign workloads.
3. Llama 405B Base for completion-only tasks not served by instruct models.
4. GPU rental (H100 at $0.99/hr) for abliteration jobs or long-running inference.
5. If model deprecated or unavailable -- fall back to Together/OR for same model IDs.
6. If privacy is critical -- Venice E2EE tier.