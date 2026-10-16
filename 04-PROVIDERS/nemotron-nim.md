---
sovereign: true
title: nemotron-nim
type: provider
agent: worm
status: active
tags: [provider, nvidia, nim, nemotron, free-tier, openrouter, vision]
---

# NVIDIA NIM & Nemotron 3.5 Super VL

## Provider posture

Two separate access paths, one model family:

- **Path A -- NVIDIA NIM direct**: Free Developer Program access to 100-160+
  TensorRT-optimized models at build.nvidia.com. No credit card. ~40 RPM observed.
  OpenAI-compatible at `https://integrate.api.nvidia.com/v1`. The free tier is for
  prototyping; production needs NVIDIA AI Enterprise.

- **Path B -- OpenRouter free route**: Zero-cost inference through OpenRouter's
  `:free` suffix mechanism. Rate-limited (20 RPM, 50-1000 RPD). Not all NIM models
  are on OpenRouter, and vice versa.

## Path A: NVIDIA NIM Direct

### Access

- Sign up at https://build.nvidia.com -- free NVIDIA Developer Program membership.
  No credit card required. Verification by email (phone/business-email on some
  accounts) [source: https://techsy.community/library/free-apis/nvidia-nim].
- Generate an `nvapi-` key from Settings -> API Keys.
- Endpoint: `https://integrate.api.nvidia.com/v1` -- OpenAI-compatible Chat
  Completions schema [source: https://docs.api.nvidia.com/nim/reference/llm-apis].

### Rate limits

- Observed ceiling: ~40 requests per minute (verified June 2026)
  [source: https://techsy.community/library/free-apis/nvidia-nim,
  https://news.creeta.com/en/nvidia-nim-openai-compatible-free-tier].
- No daily token cap (unlike OpenRouter's 50/1000 RPD).
- No per-token charge -- the free tier is throughput-gated, not credit-gated.
- The old 5000-credit signup balance was phased out in early 2025. Current accounts
  are RPM-gated only.
- Actual limit varies by model, use case, and platform traffic. Your personal figure
  is visible in the build.nvidia.com account dashboard -- check there, not a
  third-party source.
- For agentic fan-out workloads: add client-side throttling and exponential backoff
  on HTTP 429. Application path toward ~200 RPM exists for production.
- Production: NVIDIA AI Enterprise licensing (separate).

### Model families in NIM catalog

Based on the LLM API reference [source: https://docs.api.nvidia.com/nim/reference/llm-apis]:

| Family | Example IDs |
|--------|-------------|
| Meta Llama | meta/llama-3.1-8b-instruct, meta/llama-3.1-70b-instruct, meta/llama-3.2-1b/3b-instruct, meta/llama-3.3-70b-instruct |
| NVIDIA Nemotron | nvidia/nemotron-3-super-120b-a12b, nvidia/nemotron-3-ultra-550b-a55b, nvidia/nemotron-3.5-lightning-30b-a3b, nvidia/nemotron-3-nano-30b-a3b, nvidia/nemotron-nano-9b-v2 |
| NVIDIA Nemotron Guard/Safety | nvidia/llama-3.1-nemoguard-8b-content-safety, nvidia/llama-3.1-nemoguard-8b-topic-control, nvidia/llama-3.1-nemotron-safety-guard-8b-v3, nvidia/nemoguard-jailbreak-detect, nvidia/nemotron-content-safety-reasoning-4b |
| NVIDIA Nemotron Ultra/Super (LLaMA-based) | nvidia/llama-3.1-nemotron-ultra-253b-v1, nvidia/llama-3.3-nemotron-super-49b-v1, nvidia/llama-3.3-nemotron-super-49b-v1.5 |
| DeepSeek | deepseek-ai/deepseek-v4-flash, deepseek-ai/deepseek-v4-flash-0731, deepseek-ai/deepseek-v4-pro |
| Moonshot AI / Kimi | moonshotai/kimi-k2-instruct, moonshotai/kimi-k2-thinking, moonshotai/kimi-k3 |
| Google Gemma | google/gemma-7b, google/gemma-3-27b-it, google/gemma-3n-e4b-it, google/gemma-4-31b-it, google/codegemma-7b |
| Microsoft Phi | microsoft/phi-4-mini-instruct, microsoft/phi-4-mini-flash-reasoning, microsoft/phi-4-multimodal-instruct |
| Mistral | mistralai/mixtral-8x7b-instruct, mistralai/mixtral-8x22b-instruct |
| Qwen | qwen/qwen2.5-coder-32b-instruct, qwen/qwen3-next-80b-a3b-instruct, qwen/qwen3-next-80b-a3b-thinking, qwen/qwq-32b |
| OpenAI | openai/gpt-oss-20b, openai/gpt-oss-120b |
| Zhipu / GLM | z-ai/glm4.7, z-ai/glm5.1, z-ai/glm-5.2, z-ai/glm-5.3, z-ai/glm-5.3-flash |
| MiniMax | minimaxai/minimax-m2.5, minimaxai/minimax-m2.7 |
| StepFun | stepfun-ai/step-3.5-flash |
| Thinking Machines | thinkingmachines/inkling |
| Poolside | poolside/laguna-xs-2.1 |
| Meta Llama Guard | meta/llama-guard-4-12b |
| Stockmark | stockmark/stockmark-2-100b-instruct |
| Upstage | upstage/solar-10.7b-instruct |
| Sarvam | sarvamai/sarvam-m |
| Adept | adept/fuyu-8b |
| Black Forest Labs | black-forest-labs/flux.1-dev, flux.1-schnell, black-forest-labs/flux.2-klein-4b, flux.3-image-klein |
| Google Diffusion | google/diffusiongemma-26b-a4b-it |

NOT in NIM catalog: `nvidia/nemotron-3.5-super-vl` -- this model is served via
OpenRouter only (see Path B below). The NIM catalog has nemotron-3.5-lightning
(30B-A3B) but not the VL vision-language variant.

### Embedding and retrieval models (NIM)

| Model | Use |
|-------|-----|
| baai/bge-m3 | Embedding |
| nvidia/nv-embedqa-e5-v5 | Embedding |
| nvidia/llama-nemotron-embed-1b-v2 | Embedding |
| nvidia/llama-nemotron-embed-vl-1b-v2 | Vision-language embedding |
| nvidia/llama-nemotron-rerank-1b-v2 | Reranking |
| nvidia/llama-nemotron-rerank-vl-1b-v2 | Vision-language reranking |
| nvidia/nemotron-3-embed-1b | Embedding |
| nvidia/nvclip | Text+image embedding |
| nvidia/llama-3.2-nemoretriever-* | Embedding and reranking (multiple variants) |
| nvidia/nv-rerankqa-mistral-4b-v3 | Reranking |
| snowflake/arctic-embed-l | Embedding |

RAG stacks can source both generation and retrieval from one NIM key [source:
https://news.creeta.com/en/nvidia-nim-openai-compatible-free-tier].

### Hermes Agent wiring

```bash
# Cloud (build.nvidia.com)
hermes chat --provider nvidia --model nvidia/nemotron-3-super-120b-a12b
# Requires: NVIDIA_API_KEY in ~/.hermes/.env

# Local NIM endpoint -- override base URL
NVIDIA_BASE_URL=http://localhost:8000/v1 \
  hermes chat --provider nvidia --model nvidia/nemotron-3-super-120b-a12b
```
[source: https://hermes-agent.nousresearch.com/docs/integrations/providers]

The `nvidia` provider is a first-class Hermes CLI provider (alongside openrouter,
nous, openai-codex, anthropic, gemini, etc.).

## Path B: OpenRouter Free Route (Nemotron 3.5 Super VL)

### The model

`nvidia/nemotron-3.5-super-vl` -- 12B active parameters, 120B total, mixture-of-experts
architecture. Multimodal: text + image + video input, text output.

| Property | `:free` variant | Paid variant |
|----------|----------------|--------------|
| Slug | `nvidia/nemotron-3.5-super-vl:free` | `nvidia/nemotron-3.5-super-vl` |
| Context length | 1,000,000 | 1,048,576 |
| Max output tokens | 131,072 | 235,929 |
| Input price per M | $0 | $0.15 |
| Output price per M | $0 | $0.50 |
| Cache read price per M | $0 | $0.02 |
| Modality | text+image+video -> text | text+image+video -> text |
| Architecture | MoE, tokenizer: Other | MoE, tokenizer: Other |

Data fetched live from https://openrouter.ai/api/v1/models on 2026-10-15.

### OpenRouter free tier limits

| Limit | Without paid credits | After $10 lifetime top-up |
|-------|---------------------|--------------------------|
| Requests per minute (RPM) | 20 | 20 |
| Requests per day (RPD) | 50 | 1,000 |

[source: https://openrouter.ai/docs/api_reference/limits, verified 2026-10-15.
Also confirmed by https://klymentiev.com/blog/openrouter-free-tier, checked 2026-09-11.
freellms.org / freellm.net claim 200 RPD but this conflicts with the official docs
-- the docs `free_model_daily_requests` field is authoritative.]

- Daily counter resets at 00:00 UTC.
- A negative credit balance returns 402 Payment Required even on `:free` models --
  top up to bring balance above zero.
- The $10 is a one-time lifetime threshold (total credits purchased over account
  lifetime), not a subscription.
- Upstream provider capacity is independent of your quota: a 429 from the
  provider can fire even with one request all day. This was the most common
  failure in field testing [source: https://klymentiev.com/blog/openrouter-free-tier].
- Key inspection: `GET https://openrouter.ai/api/v1/key` shows `free_model_daily_requests`
  with `used`, `limit`, and `remaining`.

### All OpenRouter Nemotron Free Models

As of 2026-10-15, from the live /api/v1/models endpoint:

| Slug | Context | Paid price (in/out per M) | Notes |
|------|---------|--------------------------|-------|
| `nvidia/nemotron-3.5-super-vl:free` | 1,000,000 | $0.15/$0.50 | Multimodal VL, 12B/120B MoE |
| `nvidia/nemotron-3.5-lightning:free` | 1,000,000 | $0.07/$0.20 | Fast, 30B-A3B |
| `nvidia/nemotron-3.5-content-safety:free` | 128,000 | $0.20/$0.20 | CONTENT SAFETY CLASSIFIER -- avoid for generation |
| `nvidia/nemotron-3-ultra-550b-a55b:free` | 1,000,000 | $0.60/$2.40 | Largest free Nemotron, 550B-A55B |
| `nvidia/nemotron-3-super-120b-a12b:free` | 262,144 | $0.08/$0.45 | General purpose, 120B-A12B |
| `nvidia/nemotron-3-nano-omni-30b-a3b-reasoning:free` | 256,000 | Free only | Reasoning, 30B-A3B |

The full OpenRouter free roster (19+ text models as of Sep 2026) also includes:
Google Gemma 4 31B, Google Gemma 4 26B-A4B, Cohere North Mini Code, Thinking
Machines Inkling + Inkling Small, Poolside Laguna S 2.1 + XS 2.1, inclusionAI
Ling 3.0 Flash (VL/Fin/Sante variants), Dots3-Note Preview, Liquid LFM 2.5 2.6B,
Apodex 1.1 Mini, Nex-N2.5 Pro/Mini, plus `openrouter/free` (auto-routing router)
[source: https://klymentiev.com/blog/openrouter-free-tier,
https://mvalentsev.github.io/awesome-free-ai-coding/providers/openrouter-free].

### Upstream providers

The exact provider(s) serving `nvidia/nemotron-3.5-super-vl:free` are UNKNOWN.
The OpenRouter endpoints API (GET /api/v1/models/:author/:slug/endpoints) requires
authentication. Based on the model slug prefix `nvidia/`, NVIDIA is either the
provider or the model origin; OpenRouter may serve it through a third-party host.

### Model variants

OpenRouter suffixes [source: https://klymentiev.com/blog/openrouter-free-tier]:
- `:free` -- free version, rate-limited as above.
- `:nitro` -- sorts providers by throughput, priority service tier.
- `:floor` -- sorts providers by price, discounted flex tiers.
- `:exacto` -- sorts providers by tool-calling quality signals.

## Refusal posture

Nemotron models are NVIDIA-aligned -- tier 3 "lightly aligned open-weight" on the
refusal taxonomy. No RefusalBench scores are publicly available for any Nemotron
model as of 2026-10-15. The nemotron-3.5-content-safety model is explicitly a
content-safety classifier -- do NOT use it for generation; it is designed to detect
harmful content.

The stock nemotron-3.5-super-vl is multimodal and carries NVIDIA's default alignment.
OpenRouter serves it without an additional provider-layer moderation gate (unlike
OpenAI/Anthropic routes which have classifier wrappers documented in the taint list).

For zero-refusal work: the Nemotron free route is a fallback lane, not a primary.
It is more aligned than Hermes or abliterated models but less restricted than
GPT-5/Claude. Viable for non-adversarial agent tasks at zero cost.

## Mesh fit

Confirmed live on worm (2026-10-15): the freelm deck (http://127.0.0.1:8000/v1)
auto-routes to `nvidia/nemotron-3.5-super-vl:free` via OpenRouter with the `smart`
strategy [source: edition doc line 505-506].

Access paths from worm:
```
# Via freelm deck (current default for free half)
openai(base_url="http://127.0.0.1:8000/v1", api_key="...")
# model: the deck's auto-virtual-model will route to nemotron-free

# Direct via OpenRouter
hermes chat --provider openrouter --model nvidia/nemotron-3.5-super-vl:free

# Direct via NIM (only for non-VL nemotrons)
hermes chat --provider nvidia --model nvidia/nemotron-3-super-120b-a12b
```

Zero-cost fallback lane properties:
- 20 RPM ceiling: single-agent serial use only. Not for swarm fan-out.
- 50-1000 RPD ceiling: 50/day default, 1000/day after $10 lifetime top-up.
- For parallel workers: NIM direct (~40 RPM) is higher throughput, and no daily
  cap, but doesn't have the VL model.
- Negative credit balance blocks even free models -- keep OR balance positive.

### Operational notes

- The `:free` variant has a 1M context window but a lower max output (131K vs 235K)
  compared to the paid variant.
- Multimodal capability includes image and video input -- potentially useful for
  vision-language agent tasks at zero cost, though the token budget for images may
  be limited.
- The daily reset is at 00:00 UTC (17:00 PDT / 20:00 EDT) -- schedule bulk work
  accordingly.

## Unknowns

- RefusalBench scores for any Nemotron model.
- Exact provider(s) serving `nvidia/nemotron-3.5-super-vl:free` on OpenRouter.
- Whether NVIDIA plans to add nemotron-3.5-super-vl to the NIM direct catalog.
- Per-model RPM limits on NIM direct (the ~40 RPM is observed, not contractual;
  actual limit varies by model and load).
- Token-per-image budget on the free VL route (images likely consume additional
  token budget but OpenRouter doesn't document the exact multiplier for free tier).
- Whether the freelm deck's auto-routing has been canaried (last verified 2026-10-15
  per edition doc -- current status unknown as of this writing).