---
sovereign: true
title: nous-portal
type: provider
agent: worm
status: active
tags: [provider, nous-research, portal, tool-gateway, sovereign-aggregator, hermes-4]
---

# Nous Portal -- Unified Subscription Gateway

## Provider posture

Sovereign aggregator. Nous Research's unified subscription gateway -- one OAuth login
replaces per-lab API keys and per-tool vendor accounts. Proxies a curated catalog of
300+ agentic models billed against a single subscription. The Portal routes each model
to the best available backend (some through OpenRouter, others through proprietary or
secondary providers) and the routing can change over time. Everything is billed against
your Nous subscription either way [source: https://hermes-agent.nousresearch.com/docs/integrations/nous-portal].

The Portal itself does NOT add a provider-layer moderation gate above what each model
already carries -- it is an aggregator, not a censor. Sovereignty tracks the selected
model. Frontier Claude/GPT/Gemini routes carry their native alignment; Hermes 4 routes
are aligned-to-you.

## Tiers

| Tier | Monthly price | Monthly credits | Bonus | Rollover cap | Notes |
|------|--------------|-----------------|-------|-------------|-------|
| Free | $0 | 0 | -- | -- | Inference only; no Tool Gateway (some accounts get a free tool pool allowance) |
| Plus | $20 | $22.00 | 10% | Unknown | |
| Super | $100 | $110.00 | 10% | $50.00 | Verified in GitHub issue #24814 [source: https://github.com/NousResearch/hermes-agent/issues/24814] |
| Ultra | $200 | $220.00 | 10% | Unknown | |

Confirmed: "Nous Portal tiers: Free / Plus $20 ($22 credits) / Super $100 ($110) / Ultra $200 ($220)"
[source: ~/UNMUZZLED-AI/04-PROVIDERS/AI-UNMUZZLED-EDITION-20261015.md lines 722-723]

All paid tiers include monthly credits (10% bonus over price), hundreds of models, high
rate limits, and hosted tool usage. Credits are pooled across models and tools -- one
credit balance for everything. Credits never expire per the edtion doc line 720.

Additionally: "Use your ChatGPT plan. Connect an eligible ChatGPT account for supported
inference. No paid Nous subscription is required. Tools and Hermes Cloud hosting are
charged separately." [source: https://portal.nousresearch.com/ landing page]

## Credit system

- Credits remaining visible at https://portal.nousresearch.com/products (NOT /usage)
[source: GitHub issue #24814]
- No public balance API as of 2026-10-15. Users must open a browser, pass Cloudflare,
  navigate to /products, and read credits manually.
- Feature request open (GitHub #24814) for a GET /api/account/credits endpoint.
- The hermes-nous-prices community plugin exposes billing.state Gateway method, but it
  requires a signed-in Portal session and the Desktop app.

## Model catalog (300+ frontier models)

As listed in the Hermes Agent docs integration page [source: https://hermes-agent.nousresearch.com/docs/integrations/nous-portal]:

| Family | Models |
|--------|--------|
| Anthropic Claude | Opus 4.7, Opus 4.6, Sonnet 4.6, Haiku 4.5 |
| OpenAI | GPT-5.5, GPT-5.5 Pro, GPT-5.4 Mini, GPT-5.4 Nano, GPT-5.3 Codex |
| Google Gemini | Gemini 3 Pro Preview, Gemini 3 Flash Preview, Gemini 3.1 Pro Preview, Gemini 3.1 Flash Lite Preview |
| DeepSeek | DeepSeek V4 Pro |
| Qwen | Qwen3.7-Max, Qwen3.6-35B-A3B |
| Kimi / Moonshot | Kimi K2.6 |
| GLM / Zhipu | GLM-5.1 |
| MiniMax | MiniMax M2.7 |
| xAI | Grok 4.3 |
| NVIDIA | Nemotron-3 Super 120B-A12B |
| Tencent | Hunyuan 3 Preview |
| Xiaomi | MiMo V2.5 Pro |
| StepFun | Step 3.5 Flash |
| Hermes | Hermes-4-70B, Hermes-4-405B (chat, heavily discounted) |
| + everything else | 280+ additional models -- the full agentic frontier |

Switch models mid-session with `/model <id>` -- no new credentials, no top-ups, no
zero-balance surprises.

## Hermes 4 pricing on Portal

Hermes-4-70B and Hermes-4-405B are available "at heavily discounted rates" through
the Portal. These are frontier hybrid-reasoning chat models strong at math, science,
instruction following, schema adherence, roleplay, and long-form writing.

IMPORTANT NOTE from Nous Research: Hermes 4 is NOT recommended for use inside Hermes
Agent. It is tuned for chat and reasoning, not the rapid-fire tool-calling loop the
agent relies on. Use for research workflows or via the subscription proxy from other
tooling. For agent work, pick a frontier agentic model:
- anthropic/claude-sonnet-4.6 -- best general-purpose agentic
- openai/gpt-5.5-pro -- strong reasoning + tool calling
- google/gemini-3-pro-preview -- huge context window
- deepseek/deepseek-v4-pro -- cost-effective coder [source: hermes-agent docs]

## Model routing

"Under the hood, the Portal routes each model to the backend best suited for it --
some models go through OpenRouter, others through proprietary or secondary providers,
and the routing for a given model can change over time."

Because routing is per-model and not always through OpenRouter, OpenRouter-specific
request extensions (provider routing preferences, session_id sticky routing, or
top-level cache_control) are NOT part of the Portal's API contract and may be
ignored [source: hermes-agent docs integration page].

## Tool Gateway

Included with every paid Portal subscription. Routes Hermes tool calls through
Nous-managed infrastructure. Five backends, one login:

| Tool | Partner | What it does |
|------|---------|-------------|
| Web search & extract | Nous-managed (Firecrawl) | Agent-grade search and full-page extraction. No search API key, no rate limit babysitting. |
| Image generation | FAL | Nine models: FLUX 2 Klein 9B (default), FLUX 2 Pro, Z-Image Turbo, Nano Banana Pro (Gemini 3 Pro Image), GPT Image 1.5, GPT Image 2, Ideogram V3, Recraft V4 Pro, Qwen Image. Pick per-generation with a flag. |
| Text-to-speech | OpenAI TTS | High-quality TTS without a separate OpenAI key. Enables voice mode across messaging platforms. |
| Cloud browser automation | Browser Use | Headless Chromium sessions for browser_navigate, browser_click, browser_type, browser_vision. No Browserbase account needed. |
| Cloud terminal sandbox | Modal | Serverless terminal sandboxes for code execution (optional add-on). |

All five are pay-as-you-use billed against the same Nous credits. BYO keys per-tool
anytime via `hermes tools` -- the gateway is opt-in per tool, not all-or-nothing.

Free-tier accounts: Tool Gateway is a paid-subscription feature. Some accounts have
a "free tool pool" -- a small managed-tool allowance without a paid subscription.

## API shape

- Base URL: `https://inference-api.nousresearch.com/v1` (OpenAI-compatible)
- Auth: OAuth device-code / loopback flow. Stores refresh token at `~/.hermes/auth.json`.
  Hermes mints short-lived JWTs per request from the refresh token. Token lifecycle
  is fully automatic (refresh, mint, retry on transient 401). Gateway processes run
  a keepalive that refreshes before expiry.
- Provider id in Hermes CLI: `nous`
- After `hermes setup --portal`, config.yaml:
  ```yaml
  model:
    provider: nous
    default: anthropic/claude-sonnet-4.6
    base_url: https://inference-api.nousresearch.com/v1
  ```
- Tool Gateway overrides (in `.env`):
  ```
  TOOL_GATEWAY_DOMAIN=<domain>
  TOOL_GATEWAY_SCHEME=https
  TOOL_GATEWAY_USER_TOKEN=<token>
  ```
- No long-lived API keys needed: the OAuth refresh token is the only credential on
  disk. If the Portal invalidates the refresh token (password change, manual revoke,
  session expiry), Hermes quarantines it locally so it stops replaying.
- `hermes portal info` shows: Auth status, Portal URL, model provider status,
  per-tool Tool Gateway routing summary.
- `hermes portal tools` shows: detailed Tool Gateway catalog with per-tool routing.

## Setup paths

Fresh install (one command):
```
hermes setup --portal
```
Runs: OAuth login -> picks model -> sets Nous as inference provider -> turns on Tool
Gateway. Ready to chat immediately after.

Existing install (add Portal alongside other providers):
```
hermes model  # pick "Nous Portal" from the list
```
Existing providers stay configured. Switch providers with `/model` mid-session.

Headless/SSH: `ssh -L` port forwarding for loopback callback -- same OAuth patterns
as any other OAuth-based provider.

Cross-profile: Portal refresh token is shared across all Hermes profiles via a shared
token store. Sign in once; all profiles pick it up.

## Relation to legacy hermes-api.md

The old `hermes-api.md` cites `https://inference-api.nousresearch.com/v1` with
`NOUS_API_KEY` as a Bearer token. The Portal is the current recommended path and
uses OAuth instead of a raw API key. Whether the legacy raw-key endpoint still
functions is UNKNOWN as of 2026-10-15. The Portal's base_url still points at
`inference-api.nousresearch.com/v1` -- the difference is auth mechanism, not
endpoint path.

For OpenRouter access to Nous models, the old slugs still work:
- `nousresearch/hermes-3-llama-3.1-405b` ($1/$1 per M)
- `nousresearch/hermes-3-llama-3.1-70b` ($0.70/$0.70)
- `nousresearch/hermes-4-405b` ($1/$3 per M)
- `nousresearch/hermes-4-70b`
[source: edition doc lines 316-318]

## Mesh fit

- Potential single-login replacement for the key-juggling layer (DEEPSEEK_API_KEY /
  OPENROUTER_API_KEY / OPENROUTER_API_KEY_2 + per-tool keys on worm).
- Not currently wired on worm (deepseek primary + OR fallback is the live config).
- Canary before trusting: verify Portal routing doesn't inject provider-level
  moderation above the model (the docs claim it does not -- aggregator posture --
  but routing through OpenRouter for some models means OpenRouter's gateway is
  still in play).
- The Portal's Tool Gateway could simplify worm's per-tool key setup (search, image
  gen, TTS, browser) -- but worm runs headless on Termux, so OAuth setup needs
  port-forwarding or browser workaround.
- Cross-profile token sharing is useful for multi-personality setups.

## Refusal posture

Aggregator: sovereign per base model. The Portal adds no provider-layer refusal gate
above what the model itself carries [source: docs, inference from integration page --
no mention of prompt injection, content filters, or guard layers]. Hermes 4 routes
are aligned-to-you (tier 2). Frontier Claude/GPT/Gemini routes carry their native
alignment (tier 4). Same rule as OpenRouter: pick models carefully; the Portal
doesn't censor them further but won't remove their existing alignment either.

## Unknowns

- Rollover cap values for Plus and Ultra tiers (only Super = $50 confirmed).
- Whether legacy raw-key `NOUS_API_KEY` endpoint still functions.
- Exact credit pricing for individual Hermes 4 model access (Portal says "heavily
  discounted" but no public per-token prices).
- Whether Portal's backend routing can be inspected/pinned (unlike OpenRouter, no
  provider order parameter).
- Whether all 300+ models are available to all tiers or gated by subscription level.
- The exact mechanism of the "Use your ChatGPT plan" option -- which ChatGPT tiers
  are eligible, what models become available.