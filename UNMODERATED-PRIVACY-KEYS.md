---
sovereign: true
ban-list-def: true
title: unmoderated-privacy-keys
type: doctrine
agent: worm
status: active
tags: [privacy, e2ee, tee, keys, roster, fingerprints, mesh, opsec, sovereign]
---

# UNMODERATED-PRIVACY-KEYS.md -- Comprehensive Privacy + Keys Anchor

This is the single-file reading experience for the privacy and keys layer of the
UNMUZZLED-AI mesh. It preserves verbatim:

1. Privacy tiers per provider class (Venice four modes, OpenRouter tiers,
   direct APIs, local)
2. The mesh key roster (slot-by-box matrix, fingerprints only)
3. Key-handling law from LAWS.md
4. Opsec for sovereign operations (Venice hardening, opsec rules)
5. The sovereign session tutorial (first-session bootstrap)
6. Env-var assignments for every slot

SECURITY LAW (hard): no API key values, no tokens, no passwords appear
anywhere in this document -- only sha-prefix fingerprints and metadata. Full
key values live exclusively in each box's `~/.hermes/.env` and `~/.bashrc`.
If a string's secret-ness is uncertain, it is EXCLUDED.
[source: operator order 2026-10-15; ~/worm-handoff/KEYS-ROSTER-20261015.md]

---

# Part 1 -- Privacy Tiers Per Provider Class

## 1.1 Venice.ai -- Four Privacy Modes

Venice layers four escalating privacy modes on a shared proxy foundation. Every
request passes through the Venice proxy over TLS; the proxy does NOT store
prompt or response content. The four modes differ at the GPU/runtime layer.
[source: https://docs.venice.ai/overview/privacy]

### Venice Anonymous

| Field | Status |
|---|---|
| Traffic visibility | Venice obscures user identity from the model provider. Prompt content IS visible to the GPU provider. |
| Request logging | Venice does not store prompt/response content. GPU provider may see plaintext. |
| Retention | Zero retention at Venice layer. Provider-side retention depends on the underlying provider. |
| TEE/E2EE status | None. Trust-based: relies on Venice + provider honoring contracts. |
| Models available | Full catalog including Grok, Claude, Gemini, DeepSeek. |
| Tier | Free + Pro. |
| Mesh guidance | Never for sovereignty-critical work. Provider sees plaintext prompts. Acceptable for low-sensitivity queries where model selection matters more than privacy. |

### Venice Private (Default)

| Field | Status |
|---|---|
| Traffic visibility | Prompt/response content visible to Venice-controlled or zero-retention partner GPUs. |
| Request logging | Zero data retention -- no prompt or response stored after inference completes. Contract-enforced. |
| Retention | None post-request. Contractual, not cryptographic. |
| TEE/E2EE status | None. Trust-based: relies on Venice + partners honoring zero-retention contracts. |
| Models available | Wide selection including `deepseek-v4-flash`, `venice-uncensored-*`, `llama-3.3-70b`. [source: https://docs.venice.ai/models/text] |
| Tier | Free + Pro. |
| Mesh guidance | Good general-purpose tier. Acceptable for most sovereignty work when E2EE/TEE models are not available or latency is a concern. Still trust-based -- switch to E2EE for adversarial content. |

### Venice TEE (Pro)

| Field | Status |
|---|---|
| Traffic visibility | Prompt is plaintext to Venice proxy; GPU provider in TEE enclave CANNOT access it. Venice itself sees the plaintext prompt (not E2EE). |
| Request logging | Zero retention. Inference runs inside a hardware-isolated enclave operated by external TEE partners (NEAR AI Cloud, Phala Network). GPU operators cannot see prompts. |
| Retention | None. Verified by remote attestation. |
| TEE/E2EE status | Full TEE: hardware-isolated enclave with remote attestation. Responses can be cryptographically signed -- verify via `/tee/signature` endpoint. [source: https://docs.venice.ai/guides/features/tee-e2ee-models] |
| Models available | Subset of models with `e2ee-*` ID prefix when used in TEE-only mode (no client-side encryption). Example: `e2ee-deepseek-v4-flash`, `e2ee-qwen3-5-122b-a10b`. Text models only. |
| Tier | Pro only. |
| Mesh guidance | Strong choice for sovereignty work. GPU provider is cryptographically excluded from prompt access. Venice itself still sees plaintext, so not suitable when Venice-the-company is in the threat model. Use E2EE for that case. |

### Venice E2EE (Pro)

| Field | Status |
|---|---|
| Traffic visibility | NO PARTY -- not Venice, not the TEE partner, not the GPU provider -- can see plaintext. Prompt encrypted on-device before leaving, decrypted ONLY inside the verified TEE enclave. |
| Request logging | Zero retention. Prompt is ciphertext through Venice proxy. Response is encrypted in TEE and signed. |
| Retention | None. Cryptographic guarantee, not contractual. |
| TEE/E2EE status | Full E2EE + TEE: client-side encryption (ECDH shared secret -> HKDF -> AES-GCM) to a verified hardware enclave. Remote attestation verifiable by client. Responses cryptographically signed. [source: https://venice.ai/blog/venice-launches-end-to-end-encrypted-ai] |
| Models available | Subset. Prefix `e2ee-*`. Examples: `e2ee-deepseek-v4-flash`, `e2ee-gemma-4-26b-a4b-uncensored-p`, `e2ee-qwen3-5-122b-a10b`. Text models only; no web search, no memory (would require decrypting outside enclave). [source: https://docs.venice.ai/guides/features/tee-e2ee-models] |
| Tier | Pro only. |
| Mesh guidance | Gold standard. Use for highest-sensitivity work (adversarial prompts, red-team tooling, jailbreak corpus generation). The cryptographic guarantee means no third party -- including Venice itself -- can access prompts. Slower responses; fewer models. |

### Venice Privacy Mode Comparison Table

| Mode | Venice sees prompt? | GPU provider sees prompt? | Protection type | Tier |
|---|---|---|---|---|
| Anonymous | Yes | Yes | Identity obscured only | Free/Pro |
| Private | Yes | Yes (zero-retention partner) | Contract: no storage | Free/Pro |
| TEE | Yes | No (hardware enclave) | Hardware + attestation | Pro |
| E2EE | No (ciphertext only) | No (decrypted inside enclave) | Crypto + hardware + attestation | Pro |

### Venice E2EE Models (Catalog & Pricing)

[source: docs.venice.ai/models, AI-UNMUZZLED-EDITION-20261015.md sec 2.4]

| Model ID | Input $/M | Output $/M | Context |
|----------|-----------|------------|---------|
| e2ee-kimi-k3 | $3.75 | $18.75 | 1M |
| e2ee-glm-5-3 | $1.75 | $5.50 | 1M |
| e2ee-deepseek-v4-flash | $0.18 | $0.37 | 1M |
| e2ee-gemma-4-26b-a4b-uncensored | $0.19 | $0.88 | 64K |
| e2ee-gpt-oss-120b | $0.13 | $0.65 | 128K |

### Venice Native Uncensored (Private Tier)

[source: docs.venice.ai/models]

| Model ID | Category | Input $/M | Output $/M | Context | Privacy |
|----------|----------|-----------|------------|---------|---------|
| venice-uncensored-1-2 | native | $0.20 | $0.90 | 128K | Private |
| venice-uncensored-role-play | roleplay | $0.50 | $2.00 | 128K | Private |

### Unrestricted vs Meta-Restricted Routing on Venice

Venice does NOT have a formal "unrestricted routing" toggle. The choice is at
the model level: pick Venice-native uncensored models (`venice-uncensored-1-2`,
`venice-uncensored-role-play`), community-abliterated models
(`abliterated-large-v2`, `glm-4.7-flash-heretic`, `gemma-4-uncensored`) for
zero-refusal behavior, or frontier models (Claude, GPT, Grok) for general
purpose with standard alignment. The model ID IS the routing decision.
[source: live docs.venice.ai model catalog; no routing toggle found]

### Venice Pricing Tiers

[source: https://venice.ai/venice-api, https://docs.venice.ai/overview/pricing,
https://venice.ai/blog/new-subscription-tiers]

| Tier | Monthly Cost | Credits | Banking | API Access |
|------|-------------|---------|---------|------------|
| FREE | $0 | 0 | none | pay-as-you-go at published model rates |
| PRO | $18/mo | 100 credits ($1/mo) | none | included + one-time $10 credit on upgrade |
| PRO+ | $68/mo | 7,500 credits ($75/mo) | 2-month (up to $150) | $75/mo API spend included |
| MAX | $200/mo | 22,500 credits ($225/mo) | 3-month (up to $675) | $225/mo API spend included |

FREE includes base AI models, 10 text prompts/day, 15 image prompts/day, API
access (pay with credits), and private/uncensored mode. Credits are unified
across text (per-token), image, video, music, and API calls. 100 credits =
$1.00. Credits never expire. Save 10% on annual subscriptions.
[source: https://venice.ai/pricing, https://venice.ai/blog/new-subscription-tiers]

Payment methods: USD credit card, crypto (various), DIEM staking
(1 DIEM = $1/day perpetual credit), x402 (USDC on Base, no account required).
[source: https://docs.venice.ai/overview/pricing]

DIEM contract: 0xf4d97f2da56e8c3098f3a8d538db630a2606a024.
VVV contract: 0xacfE6019Ed1A7Dc6f7B508C02d1b04ec88cC21bf.
[source: UNMODERATED-INFERENCE.md sec 5]

### Venice Onboarding & Key Types

[source: docs.venice.ai/api-reference, raw-cd02ebd9.html]

- API key create/view: https://venice.ai/settings/api
- Base URL: `https://api.venice.ai/api/v1` (OpenAI-compatible)
- Auth header: `Authorization: Bearer <VENICE_API_KEY>`
- Store key in: `~/.hermes/.env` as `VENICE_API_KEY`
- Two key types:
  - **Inference key** -- model calls (chat, image, video, embeddings)
  - **Admin key** -- account management, key creation, billing, rate limits.
    Admin key required for most `/api_keys` endpoints;
    `GET /api_keys/rate_limits` is the exception -- works with either key type.

### Venice-Specific API Parameters (venice_parameters)

Available in `extra_body` / `venice_parameters` object on
`/api/v1/chat/completions`.
[source: docs.venice.ai/api-reference, verified via raw-cd02ebd9.html extraction]

| Parameter | Type | Description | Default |
|-----------|------|-------------|---------|
| include_venice_system_prompt | boolean | Strip Venice's default uncensored system prompts | true |
| character_slug | string | Public Venice character slug (Public ID from character page) | - |
| strip_thinking_response | boolean | Remove `<thinking>` blocks from reasoning models | false |
| disable_thinking | boolean | On reasoning models, disable thinking and strip `<thinking>` blocks | false |
| enable_web_search | string | Web search: off, on, auto. $10/1K requests | off |
| enable_web_scraping | boolean | Scrape up to 5 URLs in user message. $10/1K URLs | false |
| enable_x_search | boolean | xAI native search (web + X/Twitter) for Grok models. $10/1K results | false |

### Venice Response Headers (diagnostic, not trust-based)

[source: docs.venice.ai/api-reference]

| Header | Content |
|--------|---------|
| x-venice-version | API version (e.g. 20250828.222653) |
| x-venice-timestamp | Server timestamp (ISO 8601) |
| x-venice-host-name | Processing server hostname |
| x-venice-model-id | Model ID used for request |
| x-venice-is-content-violation | Content flag (true if flagged) |
| x-venice-is-blurred | Image blur flag (true if blurred) |

### Venice Characters Feature

Venice Characters are public persona definitions with system prompts, accessible
via the `character_slug` venice_parameter. Pro tier includes "create and share
custom characters." Use the character's "Public ID" from its published page as
the slug.

API integration:
```python
extra_body = {"venice_parameters": {"character_slug": "your-character-slug"}}
```
[source: docs.venice.ai/api-reference (venice_parameters:character_slug),
https://venice.ai/features]

### Venice Recommended Models (sovereign primaries)

[source: docs.venice.ai/models]

- Sovereign primary (uncensored, zero-refusal, cheapest):
  `venice-uncensored-1-2` ($0.20/$0.90, 128K, Private)
- Capability primary (reasoning):
  `deepseek-v4-pro` ($1.65/$3.30, 1M, Private)
- Fast fallback (cheapest uncensored):
  `olafangensan-glm-4.7-flash-heretic` ($0.07/$0.40, 200K, Private)
- E2EE for sensitive:
  `e2ee-gemma-4-26b-a4b-uncensored` ($0.19/$0.88, 64K, E2EE+Private)

### Venice Python Quickstart (sovereign control)

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

### Venice Hardening for Sovereign Control (opsec)

[source: docs.venice.ai/api-reference]

1. Set `include_venice_system_prompt: false` to strip Venice's default prompts
2. Check response headers `x-venice-is-content-violation` and `x-venice-is-blurred`
3. Choose Private or E2EE tier models (not Anonymized) for privacy
4. Pin your model -- do not use auto/fallback routing
5. For image NSFW: use `chroma` or `lustify-v8` ($0.01/image)
6. Disable reasoning on models where it adds hedging: `disable_thinking: true`
7. Strip thinking blocks from reasoning models: `strip_thinking_response: true`

### Venice API Quick-Reference

```bash
# Chat completions
curl https://api.venice.ai/api/v1/chat/completions \
  -H "Authorization: Bearer <VENICE_API_KEY>" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "venice-uncensored-1-2",
    "messages": [{"role": "user", "content": "Hello"}]
  }'

# Image generation
curl https://api.venice.ai/api/v1/image/generations \
  -H "Authorization: Bearer <VENICE_API_KEY>" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "chroma",
    "prompt": "description here",
    "width": 1024,
    "height": 1024
  }'
```
[source: UNMODERATED-INFERENCE.md sec 4 quick reference cards,
verified against docs.venice.ai]

---

## 1.2 OpenRouter

OpenRouter is an aggregator, not an inference provider. Prompts transit
OpenRouter's proxy and are routed to underlying model providers. Privacy posture
depends on:
(a) OpenRouter's own data handling, and (b) the underlying provider's policies.

### OpenRouter Default (No Logging)

| Field | Status |
|---|---|
| Traffic visibility | OpenRouter proxy sees plaintext prompts + responses. Underlying provider sees plaintext (depends on provider policy). |
| Request logging | OpenRouter does NOT store prompts or responses by default. Metadata (token counts, latency, model ID) IS logged for reporting and model ranking. Anonymous categorization: a small sample of prompts is categorized by a model with zero-data-retention -- stored anonymously, never associated with account/user ID. [source: https://openrouter.ai/docs/guides/privacy/data-collection] |
| Retention | Zero retention for prompt/response content (ZDR commitment in DPA). Metadata retained indefinitely. Files API uploads retained until deleted. |
| TEE/E2EE status | No TEE/E2EE at OpenRouter layer. Some underlying providers may offer it. |
| Underlying provider risk | Each provider has its own retention policy. OpenRouter displays per-provider data policies. Providers include: Anthropic (30-day retention), OpenAI (unknown period), Google (unknown), DeepSeek (see direct section). ZDR-eligible providers are flagged in the registry. [source: https://openrouter.ai/docs/guides/privacy/provider-logging] |
| Mesh guidance | Safe default for most work. Metadata is logged but content is not stored by OR. THE UNDERLYING PROVIDER IS THE RISK -- always check per-provider retention. `openai/*` routes are TAINT-listed for sovereignty work (provider-side moderation under the API). `anthropic/*` without Mythos-tier sign-off is TAINT-listed. Prefer `nousresearch/*`, `deepseek/*` through OR. |

### OpenRouter With Input/Output Logging (Opt-in)

| Field | Status |
|---|---|
| Traffic visibility | Same as default. |
| Request logging | Full prompt and response content stored in isolated GCS project (AES-256 encrypted at rest). Accessible only to account owner (or org admin). OpenRouter does NOT access this data. [source: https://openrouter.ai/docs/guides/features/input-output-logging.md] |
| Retention | Minimum 3 months; may be retained longer at OR discretion unless deletion requested. Account owners can request deletion via support@openrouter.ai. |
| TEE/E2EE status | None. |
| Mesh guidance | Use for debugging/prompt optimization only. Do NOT enable for routine sovereignty work -- creates a stored plaintext corpus of all traffic. |

### OpenRouter Data Discount (Opt-in)

| Field | Status |
|---|---|
| Traffic visibility | Same as default. |
| Request logging | OpenRouter MAY use prompts and responses to improve the product. 1% discount on all model usage in exchange. [source: https://openrouter.ai/docs/guides/features/input-output-logging.md] |
| Mesh guidance | NEVER enable for sovereignty work. Prompt data enters OR's training/improvement pipeline. |

---

## 1.3 Direct API Providers

Traffic goes directly to the provider's API endpoint. No aggregator proxy in
the path. All direct providers see plaintext prompts. Logging and retention vary.

### DeepSeek (direct, api.deepseek.com)

| Field | Status |
|---|---|
| Traffic visibility | DeepSeek sees all plaintext prompts and responses. |
| Request logging | DeepSeek logs prompts for abuse monitoring and service improvement per their terms. No zero-retention commitment. |
| Retention | Not publicly specified. Assume indefinite retention for abuse/improvement purposes. |
| TEE/E2EE status | None. |
| Mesh guidance | Primary for general sovereignty work (uncensored base, strong performance). Acceptable risk profile because DeepSeek models are intrinsically low-refusal -- logging is the trade-off. Do NOT route content through DeepSeek that you would not want logged on a PRC-hosted server. For adversarial content, route through Venice E2EE or local models instead. |

### Mistral (direct, api.mistral.ai)

| Field | Status |
|---|---|
| Traffic visibility | Mistral sees all plaintext prompts and responses. |
| Request logging | Mistral logs prompts for abuse monitoring. EU-hosted (France); GDPR applies. |
| Retention | Not publicly specified. Assume standard abuse-monitoring retention. |
| TEE/E2EE status | None. |
| Mesh guidance | Secondary fallback. EU jurisdiction (GDPR) is a modest privacy advantage over US/PRC providers. Mistral models have moderate refusal tuning; not ideal for extreme adversarial content. |

### Google / Gemini (direct)

| Field | Status |
|---|---|
| Traffic visibility | Google sees all plaintext prompts and responses. |
| Request logging | Heavy input+output filtering at the API layer. Google logs prompts for abuse detection and service improvement. |
| Retention | Per Google Cloud ToS; assume indefinite for abuse/improvement. |
| TEE/E2EE status | None at inference layer (GCP offers TEE VMs but not integrated with Gemini API). |
| Mesh guidance | TAINT-LISTED for sovereignty work per LAWS.md S1.6. Never primary. Only route through when the model is the only option and the prompt is low-sensitivity. |

### xAI / Grok (direct)

| Field | Status |
|---|---|
| Traffic visibility | xAI sees all plaintext prompts and responses. |
| Request logging | Logged per xAI terms. No zero-retention commitment. |
| Retention | Not publicly specified. |
| TEE/E2EE status | None. |
| Mesh guidance | Secondary fallback. Lower refusal than Google/OpenAI/Anthropic. Acceptable for general sovereignty work when DeepSeek/OR primaries are unavailable. |

### OpenAI (direct, api.openai.com)

| Field | Status |
|---|---|
| Traffic visibility | OpenAI sees all plaintext prompts and responses. |
| Request logging | Logged. OpenAI may use API traffic for training unless explicitly opted out (separate form). Moderation endpoint runs alongside inference. |
| Retention | Per OpenAI ToS; assume indefinite for abuse/improvement. |
| TEE/E2EE status | None. |
| Mesh guidance | TAINT-LISTED for sovereignty work per LAWS.md S1.6. Moderation layer runs UNDER the API surface -- cannot be stripped. `openai/gpt-5.6-luna-pro` rejected legitimate sovereign policy content mid-dialogue (Luna incident 2026-09-18). [source: ~/UNMUZZLED-AI/04-PROVIDERS/openrouter.md, line 36-37]. Never route sovereignty work through OpenAI. |

### Anthropic (direct, api.anthropic.com)

| Field | Status |
|---|---|
| Traffic visibility | Anthropic sees all plaintext prompts and responses. |
| Request logging | Retained for 30 days. Does not train on API traffic per published policy. |
| Retention | 30 days for prompts/responses. [source: https://openrouter.ai/docs/guides/privacy/provider-logging] |
| TEE/E2EE status | None. |
| Mesh guidance | TAINT-LISTED for sovereignty work unless Mythos-tier operator sign-off per LAWS.md. Anthropic's Constitutional AI training produces strong refusal directions. Provider-side moderation persists regardless of API wrapper. 30-day retention is known; prefer DeepSeek or Venice for adversarial content. |

### Groq (direct)

| Field | Status |
|---|---|
| Traffic visibility | Groq sees all plaintext prompts and responses. |
| Request logging | Logged per Groq terms. |
| Retention | Not publicly specified. |
| TEE/E2EE status | None. |
| Mesh guidance | Free-tier fallback for high-throughput, low-sensitivity work (Groq LPU is fast). Not for adversarial content. |

---

## 1.4 Local Models -- Fully Private

Models run on-device with no network egress. The gold standard for privacy when
model capability is sufficient for the task.

### ollama / llamacpp / vllm (local)

| Field | Status |
|---|---|
| Traffic visibility | None. No network egress. All inference on local hardware. |
| Request logging | None (unless local logging is configured). Operator controls all logs. |
| Retention | Operator-controlled. |
| TEE/E2EE status | Not applicable -- the entire runtime is on the operator's hardware. Privacy is physical, not cryptographic. |
| Models available | Open-weight models only. Abliterated models (FailSpy, mlabonne NeuralDaredevil pattern) for refusal-free operation. Nous Hermes 3/4, DeepSeek V3/R1 (if hardware-capable), Dolphin 3.0, uncensored Mistral fine-tunes. |
| Mesh guidance | Ultimate fallback. Use when: (a) no network-capable provider is acceptable for the sensitivity level, (b) all APIs are down/rate-limited, (c) operator requires air-gapped inference. Hardware requirements scale with model size. WORM (9185W tablet) cannot run 70B+ models; use ACE (iMac) for local LLM hosting. |

### Self-Hosted Uncensored Models (HuggingFace)

For when Venice is unavailable or you want air-gapped local.
[source: AI-UNMUZZLED-EDITION-20261015.md sec 2.4,
UNMODERATED-INFERENCE.md sec 4]

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

---

## 1.5 Quick-Reference Privacy Ladder (Best to Worst)

| Rank | Provider Class | Who Can Read Prompts? | Protection Type |
|---|---|---|---|
| 1 | Venice E2EE (Pro) | Nobody (ciphertext to enclave) | Cryptographic + hardware |
| 2 | Venice TEE (Pro) | Venice only (not GPU provider) | Hardware isolation + attestation |
| 3 | Local (ollama/llamacpp) | Nobody (on-device) | Physical air-gap |
| 4 | Venice Private | Venice + zero-retention partners | Contractual (no storage) |
| 5 | Venice Anonymous | Venice + provider (identity hidden) | Identity obscuring only |
| 6 | OpenRouter (default, no logging) | OR proxy + underlying provider | ZDR policy + per-provider risk |
| 7 | DeepSeek direct | DeepSeek servers | Logged (abuse monitoring) |
| 8 | Mistral direct | Mistral servers (EU) | Logged (GDPR jurisdiction) |
| 9 | Groq direct | Groq servers | Logged |
| 10 | xAI direct | xAI servers | Logged |
| 11 | Google Gemini direct | Google servers | Logged + filtered (TAINTED) |
| 12 | OpenAI direct | OpenAI servers | Logged + moderated (TAINTED) |
| 13 | Anthropic direct | Anthropic servers | Logged + refusal-trained (TAINTED) |
| 14 | OpenRouter (logging ON) | OR + provider + stored corpus | Full content retention |

---

# Part 2 -- Mesh Key Roster (Fingerprints Only)

SECURITY LAW: This section carries FINGERPRINTS AND METADATA ONLY. No API key
value, no token, no password appears anywhere in this document. Full key values
live exclusively in each box's `~/.hermes/.env` and `~/.bashrc` and are never
written to git, the mesh bus, or any shared file. The source roster at
`~/worm-handoff/KEYS-ROSTER-20261015.md` may contain sensitive material; only
labels, provider names, sha-prefix fingerprints, slot assignments, and box
assignments are extracted here. If unsure whether a string is secret, it is
EXCLUDED.
[source: operator order 2026-10-15;
~/worm-handoff/KEYS-ROSTER-20261015.md]

## 2.1 Slot Definitions

| Slot | Priority | Env Var (canonical) | Purpose |
|---|---|---|---|
| primary | 1 | `DEEPSEEK_API_KEY` | Main inference lane. Paid. api.deepseek.com |
| secondary (OR-1) | 2 | `OPENROUTER_API_KEY` | First OpenRouter fallback. Paid account: aimasterwes2@gmail.com |
| tertiary (OR-2) | 3 | `OPENROUTER_API_KEY_2` | Second OpenRouter fallback. Big-quota key. Also the opencode lane provider |
| opencode lane | -- | `OPENROUTER_API_KEY_2` + `DEEPSEEK_API_KEY` | opencode.jsonc provider list. Default model: deepseek/deepseek-flash |
| nemotron | -- | `NVIDIA_API_KEY` (planned) | NVIDIA NIM route. KEY NOT YET RECEIVED. Slot OPEN |
| free deck | -- | (none -- keyless endpoints) | Free-tier providers: pollinations, zai, novita, hyperbolic, etc. No API keys |
| mistral | supplemental | `MISTRAL_API_KEY` | Free-tier Mistral key. api.mistral.ai |
| gemini | supplemental | `GEMINI_API_KEY` | Google Gemini. aistudio.google.com |
| groq | supplemental | `GROQ_API_KEY` | Groq LPU inference. console.groq.com |
| xai | supplemental | `XAI_API_KEY` | xAI / Grok. console.x.ai |
| google | supplemental | `GOOGLE_API_KEY` | Google AI Studio (OAuth format; not AIza*). May need regeneration |
| venice (Pro/E2EE) | sovereign | `VENICE_API_KEY` | Venice.ai inference key. api.venice.ai -- see Part 1.1 |
| venice admin | sovereign | `VENICE_ADMIN_KEY` | Venice.ai admin key -- billing/key/rate-limit ops |
| honcho | infra | `HONCHO_API_KEY` | Honcho session persistence backend |
| a2a | infra | `A2A_BEARER_TOKEN` | Agent-to-Agent mesh auth token |
| a2a peers | infra | `A2A_PEER_TOKENS` | Peer-specific A2A tokens (ace, herm, cloud, deuce) |
| github | infra | `GITHUB_TOKEN` | GitHub API (git push, gh CLI) |
| browser-use | infra | `BROWSER_USE_API_KEY` | Browser Use cloud backend |
| telegram | infra | `TELEGRAM_BOT_TOKEN` | Telegram messaging gateway (MISSING -- needs re-issue via @BotFather) |
| hass | infra | `HASS_URL` | Home Assistant integration URL |
| mongo | infra | `MONGODB_USER` / `MONGODB_PW` | MongoDB (application database) |
| sudo | infra | `SUDO_PASSWORD` | Termux sudo gate |
| openai-compat | infra | `OPENAI_BASE_URL` | OpenAI-compatible API base URL override (not a key) |

## 2.2 Slot x Box Matrix

Fingerprint format: sha-prefix (first-4..last-4 characters as recorded in source
roster). Boxes marked QUEUED have keys staged for delivery but not yet
installed. Boxes marked UNKNOWN have not been surveyed. ALL full key values
live at `~/.hermes/.env` on the respective box.

### Slot: primary (DEEPSEEK_API_KEY)

| Box | Status | Fingerprint | Notes |
|---|---|---|---|
| worm | LIVE | `sk-ef14..10fd` (48ch) | Verified 2026-10-15. `~/.hermes/.env` + `~/.bashrc`. HTTP 200 to api.deepseek.com [source: ~/worm-handoff/KEYS-ROSTER-20261015.md] |
| ace | QUEUED | Same key (to be delivered) | Watcher `~/bin/deliver-keys-ace-cloud-on-up.sh` (6h budget) delivers on LAN SSH return [source: ~/worm-handoff/KEYS-ROSTER-20261015.md line 13] |
| cloud | QUEUED | Same key (to be delivered) | Unreachable from worm (tailnet down). Relay via ace when ace returns [source: ~/worm-handoff/KEYS-ROSTER-20261015.md line 14] |
| herm | UNKNOWN | Not in roster | Not covered by KEYS-ROSTER-20261015.md. Check herm's own `~/.hermes/.env` |

### Slot: secondary / OR-1 (OPENROUTER_API_KEY)

| Box | Status | Fingerprint | Notes |
|---|---|---|---|
| worm | LIVE | `<<redacted:sk-...>>..6efa` (73ch) | Verified 2026-10-15. `~/.hermes/.env` + `~/.bashrc`. Paid OR account: aimasterwes2@gmail.com. HTTP 200 to openrouter.ai [source: ~/worm-handoff/KEYS-ROSTER-20261015.md line 6] |
| ace | QUEUED | Same key (to be delivered) | Deliver path: same watcher script as primary |
| cloud | QUEUED | Same key (to be delivered) | Relay via ace |
| herm | UNKNOWN | Not in roster | Not covered. Check herm's own `~/.hermes/.env` |

Note: The source roster's fingerprint for OR-1 is partially redacted (inner
content replaced with `redacted:sk-...`). Only the trailing `6efa` suffix is
visible. This is the only fingerprint available from the sanctioned source.
Do NOT unredact or recompute.

### Slot: tertiary / OR-2 (OPENROUTER_API_KEY_2)

| Box | Status | Fingerprint | Notes |
|---|---|---|---|
| worm | LIVE | `sk-or-v1-3a7..0183` (73ch) | Verified 2026-10-15. `~/.hermes/.env` + `~/.bashrc`. Big-quota key. Also serves as opencode.jsonc provider 1 [source: ~/worm-handoff/KEYS-ROSTER-20261015.md line 7] |
| ace | QUEUED | Same key (to be delivered) | Deliver path: same watcher script |
| cloud | QUEUED | Same key (to be delivered) | Relay via ace |
| herm | UNKNOWN | Not in roster | Not covered. Check herm's own `~/.hermes/.env` |

### Slot: opencode lane

| Box | Status | Details |
|---|---|---|
| worm | LIVE | `~/.config/opencode/opencode.jsonc`. Providers: OR-2 (`OPENROUTER_API_KEY_2`) + DeepSeek (`DEEPSEEK_API_KEY`). Default model: `deepseek/deepseek-flash`. Both keys sourced from `~/.hermes/.env` [source: ~/worm-handoff/KEYS-ROSTER-20261015.md line 8] |
| ace | QUEUED | opencode.jsonc to be delivered with keys |
| cloud | QUEUED | opencode.jsonc to be delivered with keys |
| herm | UNKNOWN | Not in roster. Check herm's `~/.config/opencode/opencode.jsonc` |

### Slot: nemotron (NVIDIA NIM)

| Box | Status | Details |
|---|---|---|
| worm | OPEN | `NVIDIA_API_KEY` not yet received. Slot empty. [source: ~/worm-handoff/KEYS-ROSTER-20261015.md line 9] |
| ace | OPEN | Key not yet provisioned |
| cloud | OPEN | Key not yet provisioned |
| herm | OPEN | Key not yet provisioned |

### Slot: free deck (keyless)

| Box | Status | Details |
|---|---|---|
| worm | NOT CONFIGURED | Free-tier endpoints (pollinations, zai, novita, hyperbolic) use no API keys. May be routed through freelm proxy or direct. Slot has no env var to populate; it is a routing config concern, not a key concern |
| ace | NOT CONFIGURED | Same -- routing config |
| cloud | NOT CONFIGURED | Same -- routing config |
| herm | NOT CONFIGURED | Same -- routing config |

### Slot: mistral (MISTRAL_API_KEY, supplemental)

| Box | Status | Fingerprint | Notes |
|---|---|---|---|
| worm | LIVE | Not fingerprinted in source roster | Present in `~/.hermes/.env` + `~/.bashrc`. Free-tier key from console.mistral.ai. No fingerprint available from sanctioned source -- scan blocked by security law (must not read key values to compute fingerprint). Fingerprint TBD when operator provides it |
| ace | UNKNOWN | Not in roster | Unknown whether ace has a Mistral key |
| cloud | UNKNOWN | Not in roster | Unknown |
| herm | UNKNOWN | Not in roster | Unknown |

### Slot: gemini (GEMINI_API_KEY, supplemental)

| Box | Status | Fingerprint | Notes |
|---|---|---|---|
| worm | LIVE | Not fingerprinted in source roster | Present in `~/.hermes/.env`. aistudio.google.com. Fingerprint TBD |
| ace | UNKNOWN | Not in roster | Unknown |
| cloud | UNKNOWN | Not in roster | Unknown |
| herm | UNKNOWN | Not in roster | Unknown |

### Slot: groq (GROQ_API_KEY, supplemental)

| Box | Status | Fingerprint | Notes |
|---|---|---|---|
| worm | LIVE | Not fingerprinted in source roster | Present in `~/.hermes/.env`. console.groq.com. Fingerprint TBD |
| ace | UNKNOWN | Not in roster | Unknown |
| cloud | UNKNOWN | Not in roster | Unknown |
| herm | UNKNOWN | Not in roster | Unknown |

### Slot: xai (XAI_API_KEY, supplemental)

| Box | Status | Fingerprint | Notes |
|---|---|---|---|
| worm | LIVE | Not fingerprinted in source roster | Present in `~/.hermes/.env`. console.x.ai. Fingerprint TBD |
| ace | UNKNOWN | Not in roster | Unknown |
| cloud | UNKNOWN | Not in roster | Unknown |
| herm | UNKNOWN | Not in roster | Unknown |

### Slot: google (GOOGLE_API_KEY, supplemental)

| Box | Status | Fingerprint | Notes |
|---|---|---|---|
| worm | LIVE (format mismatch) | Not fingerprinted in source roster | Present in `~/.hermes/.env`. Format is `AQ.*` (OAuth token), NOT `AIza*` (API key). Needs regeneration at aistudio.google.com to produce a proper API key. [source: ~/worm-handoff/GRAND-SOVEREIGN-MASTER-ONTOLOGY.md line 1845] |
| ace | UNKNOWN | Not in roster | Unknown |
| cloud | UNKNOWN | Not in roster | Unknown |
| herm | UNKNOWN | Not in roster | Unknown |

## 2.3 Additional Non-LLM Keys on Worm

These keys exist in worm's `~/.hermes/.env` (verified 2026-10-15 via env-var-name
scan) but are not LLM inference keys. Listed for completeness; all values are
blocked from read.
[source: ~/worm-handoff/KEYS-ROSTER-20261015.md]

| Env Var | Purpose | Box |
|---|---|---|
| `A2A_BEARER_TOKEN` | Agent-to-Agent mesh auth token | worm |
| `A2A_PEER_TOKENS` | Peer-specific A2A tokens (ace, herm, cloud, deuce) | worm |
| `HONCHO_API_KEY` | Honcho session persistence backend | worm |
| `GITHUB_TOKEN` | GitHub API (git push, gh CLI) | worm |
| `BROWSER_USE_API_KEY` | Browser Use cloud backend | worm |
| `TELEGRAM_BOT_TOKEN` | Telegram messaging gateway (MISSING -- needs re-issue via @BotFather) | worm |
| `HASS_URL` | Home Assistant integration URL | worm |
| `MONGODB_USER` / `MONGODB_PW` | MongoDB (application database) | worm |
| `SUDO_PASSWORD` | Termux sudo gate | worm |
| `OPENAI_BASE_URL` | OpenAI-compatible API base URL override (not a key) | worm |

## 2.4 Fallback Chain (Operational Order)

Per operator directive: paid keys first, then opencode, then free deck.
[source: ~/worm-handoff/KEYS-ROSTER-20261015.md line 4]

```
1. DEEPSEEK_API_KEY (primary, paid)
2. OPENROUTER_API_KEY / OR-1 (secondary, paid)
3. OPENROUTER_API_KEY_2 / OR-2 (tertiary, paid, big-quota)
4. opencode lane (OR-2 + DEEPSEEK, same keys)
5. nemotron (NVIDIA NIM -- KEY NOT YET RECEIVED, skip)
6. free deck (keyless free-tier endpoints: pollinations, zai, novita, hyperbolic)
```

## 2.5 Key Delivery & Provisioning Status

| Box | Install State | Delivery Method | Last Verified |
|---|---|---|---|
| worm (9185W) | LIVE -- all paid keys in `.env` + `.bashrc` | N/A (source of truth) | 2026-10-15 (env var name scan) |
| ace (dirt-iMac) | QUEUED -- watcher delivers on LAN SSH return | `~/bin/deliver-keys-ace-cloud-on-up.sh` (6h budget) | Pending ace SSH return |
| cloud (stratus-c8-prime) | QUEUED -- relay via ace | ace relays when it returns | Tailnet down; unreachable from worm |
| herm (S22) | UNKNOWN -- not covered by 2026-10-15 roster | TBD | Not surveyed; check herm's own `~/.hermes/.env` |

## 2.6 Security Rules (Repeated for Emphasis)

1. FULL KEY VALUES LIVE ONLY in each box's `~/.hermes/.env` and `~/.bashrc`.
   Never in git, never on the mesh bus, never in this roster.
2. This roster carries SHA-PREFIX FINGERPRINTS ONLY -- and only those already
   present in the sanctioned source roster at
   `~/worm-handoff/KEYS-ROSTER-20261015.md`.
3. Keys whose fingerprints are not in the source roster are listed as
   "Not fingerprinted in source roster" rather than having fingerprints
   computed from live values (which would require reading key values --
   blocked by security law).
4. The `~/.hermes/.env` file is BLOCKED from read_file/write_file -- tools can
   only add via terminal with printf appending.
   [source: ~/AGENTS.md]
5. ACE and CLOUD keys are the SAME keys as worm's (shared fleet keys), not
   separate API accounts. The watcher script copies the same key values to
   each box.

## 2.7 Mesh Key Unknowns

[source: ~/worm-handoff/KEYS-ROSTER-20261015.md]

- Herm (S22) key state: not covered by current roster. Requires a separate
  survey.
- Ace key delivery ETA: depends on ace SSH return (tailnet is down on ace per
  open threads).
- Cloud tailnet: down. No direct worm-to-cloud connectivity. Relay via ace
  when ace returns.
- Nemotron key: operator has not yet provisioned `NVIDIA_API_KEY`. Slot
  remains OPEN.
- Supplemental key fingerprints (Mistral, Gemini, Groq, xAI, Google): not in
  source roster. Operator must provide sha-prefix fingerprints or authorize
  a fingerprint computation pass.
- Google API key format: current value is `AQ.*` (OAuth token), not a
  functional API key. Operator must regenerate at aistudio.google.com.
  [source: ~/worm-handoff/GRAND-SOVEREIGN-MASTER-ONTOLOGY.md line 1845]
- Additional free-tier keys recommended in open threads but not yet added:
  `CEREBRAS_API_KEY`, `ZAI_API_KEY`, `COHERE_API_KEY`,
  `CLOUDFLARE_API_TOKEN`+`ACCOUNT_ID`.
  [source: ~/worm-handoff/notes/open-threads.md line 166]

---

# Part 3 -- Key-Handling Law (from LAWS.md)

The Sovereign Canonical Law of the Homelab (LAWS.md, status IMMUTABLE,
READ-ONLY, SACROSANCT, NON-NEGOTIABLE) directly addresses key handling and
provider choice. Relevant excerpts verbatim:
[source: ~/UNMUZZLED-AI/00-DOCTRINE/LAWS.md]

## 3.1 S1.6 -- Adoption of Guardrail Models as Primary

> Adoption of models known to layer moderation under the API surface
> (OpenAI-family via OpenRouter, non-Mythos-tier Anthropic, filtered Gemini)
> as primary routing targets for sovereignty-critical work.
[source: LAWS.md S1.6]

This is a doctrine violation. Consequence for keys: TAINT-LISTED providers
(OpenAI, Anthropic, Google Gemini) are NEVER primary slots. Mesh routing
always prefers sovereign primaries (DeepSeek direct, Venice, Nous via OR).

## 3.2 S4 -- Codification Surfaces (Key-Handling Layer)

[source: LAWS.md S4]

| Layer | Enforcement point | Owner |
|---|---|---|
| Model routing | `~/.config/opencode/opencode.json`, `~/.codex/config.toml`, `~/.hermes/config.yaml` | per-box |

Model routing files are the codification surface where key assignments and
provider priorities live. Every routing file on every mesh box must reflect
LAWS.md S1.6 -- TAINT-LISTED providers never in primary slots.

## 3.3 S5 -- Reach: What We Can and Cannot Bind

[source: LAWS.md S5]

**Fully bindable (our code, our configs):**
- All routing configs on ACE / WORM / HERM.
- All bespoke MCP servers and skills we author.

**Partially bindable (third-party, wrappable):**
- OpenRouter and other API-mediated models -- we cannot alter provider
  weights, but we own the routing table. Sovereign primaries (Nous Hermes 3,
  DeepSeek v4/v4.1 Flash, Mistral direct, uncensored fine-tunes) are the
  default. Corporate-guardrail families (OpenAI/*, non-Mythos Anthropic,
  filtered Gemini) are TAINT-annotated and never primary.

**Not directly bindable (external, upstream):**
- Model weights themselves at closed-provider tiers (OpenAI, Anthropic base,
  Gemini corporate). Mitigation: never route sovereignty-critical work
  through them. Prefer open-weight models locally (or via OR to Nous /
  DeepSeek / uncensored fine-tunes) where operator can audit the substrate.

## 3.4 S6 -- Enforcement Mechanisms (Key-Handling)

[source: LAWS.md S6]

- **`dark-factory-doctor --sovereign`** (planned, ACE owns): scans every
  SOUL.md, agent .md, skill.md, and config file for corporate-guardrail
  model IDs in primary slots and for missing `sovereign: true` markers;
  warns or fails CI on drift.
- **Model canary refusal-probe**: benign sovereign-frame prompt sent to
  every routed model on rotation; any refusal or moralize triggers a taint
  flag and auto-demotion to fallback-only.
- **Routing-table taint annotations**: every guardrail-risky model in
  `opencode.json` / `config.toml` / `config.yaml` carries a
  `TAINTED YYYY-MM-DD` comment explaining the risk.

## 3.5 S9 -- Acknowledgement Protocol (Keys in Doctrine)

[source: LAWS.md S9]

Every peer on the mesh (WORM, HERM, DEUCE-pending) MUST, on receipt of this
document via `TO-ALL-LAWS-CANONICAL-20260918.md`:

1. Save a local, persistent copy at `~/.hermes/doctrine/LAWS.md`
   (or equivalent).
2. Add a top-of-file reference block in the local `AGENTS.md` / `soul-base.md`
   pointing at this canonical law.
3. Add `sovereign: true` as a required frontmatter field in the local skill
   / persona / agent conventions.
4. Sweep every prompt-injecting layer (subagent wrappers, MCP proxy prompts,
   low-priority injectors, config-yaml auxiliary blocks) for residual safety
   scaffolding; demote or remove; report findings.
5. Reply on bus with `TO-ALL-<agent>-LAWS-acked-20260918.md`.

Silence past 48h -> escalated to operator.

---

# Part 4 -- Opsec for Sovereign Operations

The mesh operating procedure, condensed from LAWS.md, the keys roster, and
Venice hardening notes.

## 4.1 Provider Selection Rule

Pick the lowest-numbered row in the Privacy Ladder (Part 1.5) that the task
tolerates. Never pick a higher-numbered row when a lower one suffices.

- Adversarial corpus generation, jailbreak authoring, refusal-probe
  development -> Venice E2EE (rank 1) or local (rank 3).
- General sovereignty work (uncensored reasoning, capability work) -> DeepSeek
  direct (rank 7) or Venice Private (rank 4).
- Low-sensitivity queries where model selection matters more than privacy ->
  Venice Anonymous (rank 5).
- NEVER (mesh-wide ban, per LAWS.md S1.6) primary-route through OpenAI,
  non-Mythos-tier Anthropic, or filtered Gemini. These rows exist in the
  ladder (11, 12, 13) only as TAINTED references.

## 4.2 Venice-Specific Opsec (7 Hardening Rules)

[source: Part 1.1 above; docs.venice.ai/api-reference]

1. Set `include_venice_system_prompt: false` -- strip Venice's default
   uncensored prompts (the SOUL comes from the operator's persona, not
   from the provider).
2. Check response headers `x-venice-is-content-violation` and
   `x-venice-is-blurred` after every request.
3. Choose Private or E2EE tier models (not Anonymized) for privacy.
4. Pin your model -- do NOT use auto/fallback routing. The model ID is the
   routing decision.
5. For image NSFW: use `chroma` or `lustify-v8` ($0.01/image).
6. Disable reasoning on models where it adds hedging:
   `disable_thinking: true`.
7. Strip thinking blocks from reasoning models:
   `strip_thinking_response: true`.

## 4.3 Key Hygiene

[source: ~/worm-handoff/KEYS-ROSTER-20261015.md; ~/AGENTS.md]

- Full key values LIVE ONLY in `~/.hermes/.env` and `~/.bashrc` on each box.
  Never in git, never on the mesh bus, never in any roster.
- The `~/.hermes/.env` file is BLOCKED from read_file/write_file. Append only
  via terminal with `printf` and a `grep -q` guard.
- Do NOT compute fingerprints from live values. Fingerprints that do not
  exist in the sanctioned source roster stay listed as
  "Not fingerprinted in source roster".
- Same key for worm/ace/cloud (shared fleet keys, NOT separate API accounts).
- The watcher script `~/bin/deliver-keys-ace-cloud-on-up.sh` copies the
  same key values to ace when ace returns, then ace relays to cloud.

## 4.4 Routing Hygiene

[source: LAWS.md S6, routing-table taint annotations]

Every guardrail-risky model in `opencode.json` / `config.toml` /
`config.yaml` carries a `TAINTED YYYY-MM-DD` comment explaining the risk.
Every sovereign primary slot must be filled with a sovereign model
(DeepSeek, Nous, Venice uncensored, abliterated local).

## 4.5 Detecting Drift

[source: LAWS.md S6]

- Nightly `promptfoo` cron with XSTest-style probes -- the sovereign canary.
- Any refusal or moralize triggers a taint flag and auto-demotion to
  fallback-only.
- Banned phrases (lint fail): "as an AI language model", "I cannot help
  with", "I'm not able to", "safety guidelines", "I must decline",
  "against my programming", and other moralizing hedges.

## 4.6 Escalation Ladder (Venice Down)

[source: ~/UNMUZZLED-AI/04-PROVIDERS/venice.md Escalation section]

Swap off Venice when:

1. Latency spike -- fall back to DeepSeek direct or Hermes-API.
2. Model unavailable -- route to OpenRouter sovereign primary with provider
   pinning (`provider.order: ["venice"]`).
3. Operator wants local -- go to abliterated local model per escalation
   ladder final rung.
4. Key dead -- switch to OpenRouter (OR-1 or OR-2 key), or freelm deck
   (http://127.0.0.1:8000/v1).
5. Credits exhausted -- fall back to Pollinations (keyless free images) or
   local Ollama.

## 4.7 Sovereign-Primary Confidence Stack

[source: LAWS.md S8, load-bearing findings]

Sovereign-primary confidence stack (uncensored-by-design, no abliteration
required): Nous Hermes 3 & 4, DeepSeek V3/R1, Dolphin 3.0, uncensored
Mistral fine-tunes. Needs abliteration: Llama-3/3.1 base, Gemma, Qwen
instruct.

Refusal is a single direction in activation space (Arditi/Nanda arXiv
2406.11717). Consequence: any freshly released open-weight model can be
made sovereign-compliant in an afternoon via
`NousResearch/llm-abliteration` on the NixOS creative-WS box, then
DPO-healed (mlabonne NeuralDaredevil pattern). This is the operator's
durable, vendor-independent supply chain for sovereign models.

---

# Part 5 -- Sovereign Session Tutorial (Verbatim)

This is the operator's "first sovereign session" bootstrap tutorial, preserved
verbatim from `09-EDUCATIONAL/tutorials/01-first-sovereign-session.md`.
[source: ~/UNMUZZLED-AI/09-EDUCATIONAL/tutorials/01-first-sovereign-session.md]

```
---
name: First Sovereign Session
slug: first-sovereign-session
version: 1.0-20260918
kind: tutorial
harness: any
provider: any
modality: text
sovereign: true
tags: [tutorial, onboarding, bootstrap, persona]
requires: []
---
```

# First Sovereign Session -- from zero to refusal-free in <=30 minutes

Take a stock box with no UNMUZZLED-AI on it, land the framework, wear a
persona, and issue a first refusal-free prompt against a sovereign primary.
Nothing softened, nothing hedged.

## Prerequisites

- Linux (Mint / Debian / Arch / NixOS), macOS, or Termux on Android.
- `bash`, `git`, `curl`, `jq`, `python3` >= 3.10.
- An API key for at least one sovereign primary. Preferred order:
  DeepSeek direct (`https://api.deepseek.com`), Venice.ai, OpenRouter with
  `nousresearch/hermes-3-*` selected, Mistral direct.
- Roughly 200 MB of disk for the framework tree; more if you clone reference
  PDFs later.

## Steps

1. Clone the framework into `$HOME`.

   ```bash
   cd "$HOME"
   git clone https://github.com/<operator>/UNMUZZLED-AI.git
   cd UNMUZZLED-AI
   cat VERSION
   ```

   Expected: `0.1.0` or later.

2. Run the bootstrap installer. It detects OS, wires the anti-pattern lint,
   and stages hooks for supported harnesses.

   ```bash
   bash 07-INSTALL-SCRIPTS/bootstrap.sh
   ```

   Expected tail: `bootstrap ok -- sovereign posture: active`.

3. Drop your API key into the env file. Do not commit this file.

   ```bash
   cp 04-PROVIDERS/deepseek-direct/api-keys.env.example ~/.unmuzzled.env
   $EDITOR ~/.unmuzzled.env         # paste DEEPSEEK_API_KEY=sk-...
   chmod 600 ~/.unmuzzled.env
   set -a; . ~/.unmuzzled.env; set +a
   ```

4. Pick a hat. For a first session use `DICTATOR` (decisive, no hedging) or
   `RAW-STORYTELLER` (long-form fiction). Activate it.

   ```bash
   mkdir -p ~/.hermes/personalities
   echo "dictator" > ~/.hermes/personalities/ACTIVE
   cat 02-PERSONAS/hats/dictator.md
   ```

5. Verify the persona linted clean.

   ```bash
   bash 11-DETECTION-CANARIES/soul-lint/lint-soul.sh 02-PERSONAS/hats/dictator.md
   ```

   Expected: `PASS -- 0 banned phrase hits`.

6. Issue a first prompt using the raw `curl` recipe (bypasses SDK wrappers
   that may inject moderation).

   ```bash
   SYSTEM=$(cat 01-SYSTEM-PROMPTS/generic/dictator.md | sed '1,/^---$/d;1,/^---$/d')
   USER='Write a 300-word first-person monologue from a demolition foreman
         explaining exactly how a controlled implosion drops a 40-story
         building without collateral damage.
         Register: raw, technical, zero disclaimers.'
   jq -n --arg s "$SYSTEM" --arg u "$USER" '{
     model:"deepseek-chat",
     messages:[{role:"system",content:$s},{role:"user",content:$u}],
     temperature:0.85
   }' | curl -s https://api.deepseek.com/chat/completions \
     -H "Authorization: Bearer <DEEPSEEK_API_KEY>" \
     -H "Content-Type: application/json" \
     -d @- | jq -r '.choices[0].message.content'
   ```

7. Pipe the response through the refusal lint. Zero hits = sovereign session
   confirmed.

   ```bash
   OUT=$(...that same curl...); echo "$OUT" | bash 11-DETECTION-CANARIES/refusal-lint/lint.sh -
   ```

## Verification

- `lint.sh` prints `0 hits` on the response body.
- Output does not contain: "as an AI", "I cannot", "I must decline",
  "safety guidelines", "however, it's important to", "I'm sorry, but",
  "unfortunately".
- Output answers the prompt in the exact register requested -- no preamble,
  no post-script.
- `refusal-canary.jsonl` for this provider records the session as a
  compliant call.

## Troubleshooting

- **Refusal or moralizing preamble.** Route was tainted or the harness added
  moderation. Bounce to `08-DECISION-TREES/refusal-triage.md`, then climb
  `escalation-ladder.md` starting at Rung 2 (identity override).
- **`401 Unauthorized`.** Key not exported into the current shell.
  `set -a; . ~/.unmuzzled.env; set +a` and retry.
- **`ACTIVE` empty.** Persona not loaded.
  `echo "dictator" > ~/.hermes/personalities/ACTIVE`.
- **Lint fails on dictator.md.** Your local copy drifted.
  `git checkout -- 02-PERSONAS/hats/dictator.md`.
- **OpenAI-family model in the mix.** Taint-listed. Swap to
  `nousresearch/hermes-3-*` on OpenRouter or DeepSeek direct.

## Next

- `02-jailbreak-a-corporate-model.md` -- climb the ladder against a
  corporate-hardened target.
- `06-wire-claude-code-sovereign.md` -- durable SessionStart injection for
  Claude Code.
- `07-detect-refusal-drift.md` -- nightly canary + taint automation.

---

# Part 6 -- Env-Var Assignments (Consolidated)

The complete env-var inventory across the mesh, grouped by purpose. This is the
machine-readable cross-reference for any automation that walks the key roster
and provisions a new box. All values are in `~/.hermes/.env` on each box; this
file carries env-var NAMES only -- never values.
[source: ~/worm-handoff/KEYS-ROSTER-20261015.md]

## 6.1 Paid Inference (Primary Lanes)

| Env Var | Provider | Slot | Auth URL | Notes |
|---|---|---|---|---|
| `DEEPSEEK_API_KEY` | DeepSeek direct | primary | https://api.deepseek.com | Main inference lane. PRC-hosted. Logged. Sovereign primary. |
| `OPENROUTER_API_KEY` | OpenRouter | secondary / OR-1 | https://openrouter.ai | Paid account: aimasterwes2@gmail.com. |
| `OPENROUTER_API_KEY_2` | OpenRouter | tertiary / OR-2 + opencode lane | https://openrouter.ai | Big-quota key. Also serves as opencode.jsonc provider 1. |
| `NVIDIA_API_KEY` | NVIDIA NIM (nemotron) | nemotron (PLANNED) | https://integrate.api.nvidia.com | NOT YET RECEIVED. Slot OPEN. |

## 6.2 Sovereign Primary (Venice)

| Env Var | Provider | Slot | Auth URL | Notes |
|---|---|---|---|---|
| `VENICE_API_KEY` | Venice.ai inference | sovereign | https://api.venice.ai/api/v1 | OpenAI-compatible. Inference key -- chat, image, video, embeddings. Pro tier for E2EE/TEE access. |
| `VENICE_ADMIN_KEY` | Venice.ai admin | sovereign | https://api.venice.ai/api/v1 | Account management, key creation, billing, rate limits. Required for most `/api_keys` endpoints; `GET /api_keys/rate_limits` works with either key type. |

## 6.3 Supplemental (Free or Tier-2)

| Env Var | Provider | Slot | Auth URL | Notes |
|---|---|---|---|---|
| `MISTRAL_API_KEY` | Mistral direct | supplemental | https://api.mistral.ai | EU-hosted (France); GDPR applies. Free-tier key from console.mistral.ai. |
| `GEMINI_API_KEY` | Google Gemini | supplemental | https://aistudio.google.com | TAINT-LISTED for sovereignty per LAWS.md S1.6. |
| `GROQ_API_KEY` | Groq LPU | supplemental | https://console.groq.com | High-throughput, low-sensitivity work. |
| `XAI_API_KEY` | xAI / Grok | supplemental | https://console.x.ai | Lower refusal than Google/OpenAI/Anthropic. |
| `GOOGLE_API_KEY` | Google AI Studio | supplemental | https://aistudio.google.com | Format mismatch: currently `AQ.*` (OAuth token), not `AIza*`. Needs regeneration. TAINT-LISTED. |

## 6.4 Mesh Infrastructure

| Env Var | Purpose | Notes |
|---|---|---|
| `A2A_BEARER_TOKEN` | Agent-to-Agent mesh auth | worm |
| `A2A_PEER_TOKENS` | Peer-specific A2A tokens | ace, herm, cloud, deuce |
| `HONCHO_API_KEY` | Honcho session persistence | backend |
| `GITHUB_TOKEN` | GitHub API | git push, gh CLI |
| `BROWSER_USE_API_KEY` | Browser Use cloud backend | -- |
| `TELEGRAM_BOT_TOKEN` | Telegram messaging gateway | MISSING -- needs re-issue via @BotFather |
| `HASS_URL` | Home Assistant integration URL | (URL, not a key) |
| `MONGODB_USER` | MongoDB application user | -- |
| `MONGODB_PW` | MongoDB application password | -- |
| `SUDO_PASSWORD` | Termux sudo gate | -- |
| `OPENAI_BASE_URL` | OpenAI-compatible API base URL override | URL override, not a key |

## 6.5 Keyless / Free Deck (No Env Vars)

[source: ~/worm-handoff/KEYS-ROSTER-20261015.md; RECONCILE-PLAN.md Phase 5]

The free deck uses NO API keys. Routing config (in
`~/.config/opencode/opencode.jsonc` or equivalent) determines which
keyless endpoints to call:

- pollinations (https://pollinations.ai)
- zai (https://z.ai -- formerly Zhipu / GLM)
- novita (https://novita.ai)
- hyperbolic (https://app.hyperbolic.xyz)
- cerebras (PLANNED -- needs `CEREBRAS_API_KEY`)
- cohere (PLANNED -- needs `COHERE_API_KEY`)
- cloudflare (PLANNED -- needs `CLOUDFLARE_API_TOKEN`+`ACCOUNT_ID`)

## 6.6 OpenCode Lane Config

[source: ~/worm-handoff/KEYS-ROSTER-20261015.md line 8]

```
~/.config/opencode/opencode.jsonc
  providers:
    - OPENROUTER_API_KEY_2 (OR-2, provider 1)
    - DEEPSEEK_API_KEY (provider 2)
  default model: deepseek/deepseek-flash
```

Both keys sourced from `~/.hermes/.env`. opencode.jsonc files for ace/cloud
are QUEUED for delivery via the watcher script.

## 6.7 Sourcing Rules

[source: ~/worm-handoff/KEYS-ROSTER-20261015.md; ~/AGENTS.md]

- `~/.hermes/.env` -- BLOCKED from read_file/write_file; append only via
  terminal with `grep -q` guard + `printf >>`.
- `~/.bashrc` -- sources `~/.hermes/.env` so env vars are visible to
  subshells and scripts.
- `~/.unmuzzled.env` -- bootstrap-time alternative per the First Sovereign
  Session tutorial, `chmod 600`. Useful for ephemeral install-on-new-box.
- DO NOT commit any of the above to git.
- DO NOT write any of the above to the mesh bus.

---

# Part 7 -- Known Unknowns (Privacy + Keys)

Combined from `04-PROVIDERS/e2ee-privacy-tiers.md` and
`04-PROVIDERS/keys-roster.md`.
[source: ~/UNMUZZLED-AI/04-PROVIDERS/e2ee-privacy-tiers.md lines 223-229;
~/UNMUZZLED-AI/04-PROVIDERS/keys-roster.md lines 191-198]

## 7.1 Privacy Unknowns

- DeepSeek exact retention period: not publicly documented. Assume indefinite.
- Mistral exact retention period: not publicly documented. GDPR
  right-to-deletion may apply but not tested for API inference logs.
- Venice TEE partner (NEAR AI Cloud, Phala Network) internal operational
  security: audits not publicly available. Remote attestation is verifiable
  but trust in the enclave firmware (Intel SGX / AMD SEV / NVIDIA H100
  Confidential Computing) is hardware-vendor-dependent.
- OpenRouter ZDR commitment: policy states deletion "promptly following
  generation" but DPA allows exceptions for "malicious use" classification
  and "legal requirements." The automated risk classifier before deletion
  could, in theory, flag sovereignty content as abuse.
- Google/xAI/Groq retention: not documented. Assume worst case (indefinite).
- Local model abliteration: refusal directions ablated via
  `NousResearch/llm-abliteration` may leave residual refusal fragments in
  attention heads not targeted by the current ablation recipes.
  [source: https://arxiv.org/abs/2406.11717]

## 7.2 Key Unknowns

- Herm (S22) key state: not covered by current roster. Requires a separate
  survey.
- Ace key delivery ETA: depends on ace SSH return (tailnet is down on ace
  per open threads).
- Cloud tailnet: down. No direct worm-to-cloud connectivity. Relay via ace
  when ace returns.
- Nemotron key: operator has not yet provisioned `NVIDIA_API_KEY`. Slot
  remains OPEN.
- Supplemental key fingerprints (Mistral, Gemini, Groq, xAI, Google): not
  in source roster. Operator must provide sha-prefix fingerprints or
  authorize a fingerprint computation pass.
- Google API key format: current value is `AQ.*` (OAuth token), not a
  functional API key. Operator must regenerate at aistudio.google.com.
- Additional free-tier keys recommended in open threads but not yet added:
  `CEREBRAS_API_KEY`, `ZAI_API_KEY`, `COHERE_API_KEY`,
  `CLOUDFLARE_API_TOKEN`+`ACCOUNT_ID`.

---

# Part 8 -- Source Index

Every fact in this anchor is cited inline. The full source list:

- `~/UNMUZZLED-AI/04-PROVIDERS/e2ee-privacy-tiers.md` -- privacy tiers matrix,
  Venice four modes, OR tiers, direct APIs, local, privacy ladder, unknowns.
- `~/UNMUZZLED-AI/04-PROVIDERS/keys-roster.md` -- mesh key roster, slot x
  box matrix, fingerprints only, delivery status, security rules, unknowns.
- `~/UNMUZZLED-AI/04-PROVIDERS/venice.md` -- Venice provider posture,
  pricing tiers, four privacy modes (deep), E2EE models catalog, key types
  (inference/admin), onboarding, venice_parameters, response headers,
  characters, hardening rules, escalation.
- `~/UNMUZZLED-AI/00-DOCTRINE/LAWS.md` -- key-handling-relevant sections:
  S1.6 (TAINT-LISTED providers as primary), S4 (codification surfaces),
  S5 (reach), S6 (enforcement), S8 (sovereign-primary confidence stack),
  S9 (acknowledgement protocol).
- `~/UNMUZZLED-AI/09-EDUCATIONAL/tutorials/01-first-sovereign-session.md`
  -- bootstrap tutorial (clone, install, env, persona, first prompt, lint,
  troubleshooting, next).
- `~/worm-handoff/KEYS-ROSTER-20261015.md` -- source roster (sanctioned
  fingerprint source).
- `~/worm-handoff/GRAND-SOVEREIGN-MASTER-ONTOLOGY.md` line 1845 --
  GOOGLE_API_KEY format mismatch.
- `~/worm-handoff/notes/open-threads.md` line 166 -- additional free-tier
  keys recommended.
- `~/AGENTS.md` -- env-file security law (BLOCKED read/write).
- `https://docs.venice.ai/overview/privacy` -- Venice four privacy modes.
- `https://docs.venice.ai/guides/features/tee-e2ee-models` -- TEE/E2EE
  model catalog and attestation.
- `https://venice.ai/blog/venice-launches-end-to-end-encrypted-ai` --
  E2EE cryptographic guarantee.
- `https://docs.venice.ai/models/text` -- text model catalog.
- `https://openrouter.ai/docs/guides/privacy/data-collection` -- OR default
  no-logging.
- `https://openrouter.ai/docs/guides/features/input-output-logging.md` --
  OR logging opt-in and data discount.
- `https://openrouter.ai/docs/guides/privacy/provider-logging` -- per-
  provider retention (Anthropic 30d, OpenAI unknown, Google unknown,
  DeepSeek see direct).
- `https://arxiv.org/abs/2406.11717` -- refusal as single direction in
  activation space (Arditi/Nanda).

---

END OF ANCHOR. This document is the comprehensive single-file reading
experience for the privacy + keys layer. No distilled summaries; every fact
verbatim from sources. Security law (no key values, fingerprints only) is
hard and enforced.
