---
title: pollinations
type: provider
agent: worm
status: active
tags: [provider, free, no-signup, image-gen, text-gen, openai-compatible, uncensored]
---

# Pollinations.ai

## Provider posture

Sovereign. Pollinations is an open infrastructure platform for AI-native builders with a unique proposition: a free, no-signup image and text API (the "Classic" API) alongside a full-spectrum gen API with paid credits (Pollen). The platform is explicitly unfiltered for image generation and offers uncensored text models. No provider-injected system prompt or content moderation layer observed. Pollinations describes itself as "truly open" for content [source: https://github.com/pollinations/pollinations/blob/master/APIDOCS.md].

Two API surfaces exist:

1. **Classic Free API** -- no signup, no API key, anonymous. Rate-limited per IP.
2. **Gen API** -- requires API key from enter.pollinations.ai. Full model catalog, OpenAI-compatible, no per-IP rate limits.

## Free tier (Classic API) -- no key required

### Image generation

```
GET https://image.pollinations.ai/prompt/{your prompt}
```

Returns a JPEG image. One model only. Parameters:

| Parameter | Default | Description |
|---|---|---|
| `width`, `height` | 768 | Image size. Max 768x768 pixels in area; aspect ratio preserved |
| `seed` | 42 | Same prompt + seed = same image; change for variation |
| `safe` | `false` | `true` applies stricter content filtering |
| `nologo` | `false` | `true` removes the small Pollinations logo from the corner |

Rate limit: one image at a time, at least 45 seconds apart. Exceeding the limit returns HTTP 402 Payment Required with payment details for x402 USDC on Base [source: https://github.com/pollinations/pollinations/blob/master/APIDOCS.md].

### Text generation

```
GET https://text.pollinations.ai/{your question}
```

Parameters:
| Parameter | Description |
|---|---|
| `system` | System prompt |
| `seed`, `temperature` | Repeatability or variety |
| `json=true` | Answer as JSON |
| `stream=true` | Server-sent events streaming |

Also available:
- `POST https://text.pollinations.ai/` with `{"messages": [...]}` -- plain-text answer
- `POST https://text.pollinations.ai/openai` -- OpenAI-compatible chat completions
- `GET https://text.pollinations.ai/models` -- the available model (GPT-OSS 20B as of the Classic API)

Rate limit: one request at a time, at least 30 seconds apart. A stream waits for the next slot. Same 402 Payment Required beyond limit.

### Important Classic API caveats

- **Best effort only** -- no uptime guarantee; limits, models, and behavior can change without notice.
- **Cached results** -- the same URL returns the same result to anyone who has the URL.
- **No keys in URLs** -- the API needs no key; never embed one in a URL.
- **Safety filters** -- some prompts are refused. The `safe=false` default means weak filtering.
- **One model** -- the Classic API uses a single default model per modality. For model selection, use the Gen API.

[source for all Classic API details: https://github.com/pollinations/pollinations/blob/master/APIDOCS.md]

## Gen API -- keyed access

### Onboarding

- API key: `~/.hermes/.env` -> `POLLINATIONS_API_KEY`
- Signup: https://enter.pollinations.ai (get free pollen from quests; buy more when needed)
- Key types:
  - `sk_` -- secret key, server-side, no rate limits
  - `pk_` -- publishable key, for BYOP (Bring Your Own Pollen) flow in client-side apps
- Base URL: `https://gen.pollinations.ai`
- OpenAI-compatible: `https://gen.pollinations.ai/v1`
- Auth: `Authorization: Bearer YOUR_API_KEY` or `?key=YOUR_API_KEY` query param
- CLI: `npm install -g @pollinations/cli` -> `polli auth login`
- MCP server available

### Pollen credits

$1 approximately equals 1 Pollen. Free pollen is available from quests on enter.pollinations.ai. Never expires.

Example value of 1 Pollen:
- **Unlimited flux images** (always free)
- ~333 turbo images
- ~200 kontext images
- ~77 gptimage images
- ~50 nanobanana images
- 100,000+ fast text responses
- ~1,000-10,000 advanced text responses (model-dependent)

[source: https://github.com/pollinations/pollinations/blob/master/enter.pollinations.ai/POLLEN_FAQ.md]

### Text models (Gen API)

Available via `POST /v1/chat/completions`:

`openai`, `openai-fast`, `openai-large`, `gpt-oss`, `gpt-5.4`, `gpt-5.4-mini`, `gpt-5.6-sol`, `gpt-5.6-terra`, `gpt-5.6-luna`, `mercury`, `qwen-coder`, `qwen-coder-large`, `qwen-large`, `qwen3.7-max`, `qwen-vision`, `qwen-vision-pro`, `mistral`, `mistral-small-3.2`, `mistral-large`, `gemini`, `gemini-3.5-flash`, `gemini-flash-lite-3.1`, `gemini-fast`, `gemini-large`, `gemini-search`, `gemini-search-fast`, `gemini-search-large`, `deepseek`, `deepseek-pro`, `gemma`, `gemma-4-31b`, `grok`, `grok-large`, `grok-4.3`, `grok-4.5`, `grok-4-20-reasoning`, `claude-fast`, `claude`, `claude-sonnet-5`, `claude-opus-4.6`, `claude-opus-4.7`, `claude-large`, `claude-fable-5`, `perplexity-fast`, `perplexity`, `perplexity-deep`, `perplexity-reasoning`, `kimi`, `kimi-k2.6`, `kimi-k3`, `kimi-code`, `nova-fast`, `nova`, `glm`, `llama`, `llama-maverick`, `llama-scout`, `minimax`, `minimax-m2.7`, `polly`, `step-flash`, `step-3.5-flash`, `qwen-safety`, `longcat`, `laguna`, `mimo-v2.5`, `mimo-v2.5-pro`, `midijourney`, `midijourney-large`, `openai-audio`, `openai-audio-large`

Also supports `POST /v1/responses` (stateless Responses API), `POST /v1/messages` (Anthropic Messages API compatible -- Claude Code drop-in), and `GET /text/{prompt}` for quick prototyping.

### Capabilities

Text models advertise: tool calling, reasoning, web search, code execution, streaming, structured outputs, vision input (on vision models), and audio output (on audio models).

### Image / video / audio / 3D / embeddings

- **Image**: `GET /image/{prompt}?model=flux` and `POST /v1/images/generations`. Models: `flux` (always free, 1024x1024 default), `turbo`, `gptimage`, `nanobanana`, `kontext`, `chroma`, and community models under `community/owner/model`.
- **Video**: `POST /v1/video/generations` with model selection from `/video/models`.
- **Audio**: TTS via `/v1/audio/speech`, STT via `/v1/audio/transcriptions`.
- **3D**: `GET /3d/{prompt}` (e.g. `trellis-2` model).
- **Embeddings**: `POST /v1/embeddings` (e.g. `openai-3-small` with configurable dimensions).

### Model discovery

No auth required for discovery endpoints:
- `GET /models` -- all models with pricing, capabilities, and metadata
- `GET /v1/models` -- OpenAI-compatible format
- `GET /text/models`, `/image/models`, `/video/models`, `/audio/models`, `/embeddings/models`, `/3d/models` -- per-modality lists

[source for all Gen API details: https://gen.pollinations.ai/docs, https://github.com/pollinations/pollinations/blob/main/gen.pollinations.ai/src/docs/models.md]

## Known refusals

- Classic API: some prompts are refused by a safety filter even with `safe=false`. Exact filter behavior TBD-verify.
- Gen API: no provider-layer moderation observed. Refusals track the base model (e.g. Claude via Pollinations will have Anthropic-level refusals). Unfiltered models like flux, turbo, and community image models are available.
- The Classic free image API is explicitly unfiltered (safe=false default); the compendium UNMODERATED-INFERENCE.md lists Pollinations as "truly open" for both text and image [source: UNMODERATED-INFERENCE.md Section 19].

## Mesh fit

Route to Pollinations when:

1. **Zero-touch image generation** -- no key, no signup, just a URL. Perfect for quick prototypes, one-off image generation, embedding in markdown (`![desc](https://image.pollinations.ai/prompt/...)`).
2. **Free text for simple queries** -- the Classic text API at `text.pollinations.ai/{question}` works for quick lookups without touching the paid model budget.
3. **Image experiments that need no paper trail** -- anonymous requests, no account. The 45-second rate limit is fine for casual use.
4. **Flux image generation at zero cost** -- Gen API flux is always free with a key; no pollen spent.
5. **Wide model routing through one key** -- the Gen API catalog spans OpenAI, Anthropic, Google, xAI, DeepSeek, Kimi, Qwen, and more through one `sk_` key. Useful as a single-key aggregator for non-sovereign models.
6. **Anthropic-compatible endpoint for Claude Code** -- `POST /v1/messages` drops into Claude Code or claude-code-router.

Swap off Pollinations when:
- Need high throughput (Classic API is 30-45s between requests) -- use a Gen API `sk_` key or a different provider.
- Need sovereign primaries for adversarial work -- Pollinations routes to standard (potentially moderated) upstream models. For sovereign inference use Venice, Hermes API, or local abliterated models.
- Classic text model is GPT-OSS 20B only -- limited capability. Use Gen API key for anything beyond simple queries.
- Classic API has no uptime guarantee -- don't build production pipelines on it.

## Escalation

1. Classic free API (no key) for prototyping and one-off images.
2. Gen API with `sk_` key and free pollen from quests.
3. Flux for free images; `openai` or `openai-fast` for cheap text.
4. For sovereign/adversarial text work -- Venice or Hermes API instead of Pollinations' upstream-routed models.
5. If Classic rate limit is too low (402 errors) -- either wait for next slot or move to Gen API with a key.