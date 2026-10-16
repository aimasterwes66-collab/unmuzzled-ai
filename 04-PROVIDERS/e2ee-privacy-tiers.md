---
sovereign: true
title: e2ee-privacy-tiers
type: provider
agent: worm
status: active
tags: [privacy, e2ee, tee, provider, matrix, log-retention, mesh-guidance]
---

# E2EE & Privacy Tiers -- Provider Matrix

Privacy posture matrix by provider class. Columns: what the provider can see (traffic
visibility), whether prompts/responses are logged, retention policy, TEE/E2EE hardware
attestation status, and mesh routing guidance for sovereignty-critical work.

## Venice.ai -- Four Privacy Modes

Venice layers four escalating privacy modes on a shared proxy foundation. Every request
passes through the Venice proxy over TLS; the proxy does NOT store prompt or response
content. The four modes differ at the GPU/runtime layer. [source: https://docs.venice.ai/overview/privacy]

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

## OpenRouter

OpenRouter is an aggregator, not an inference provider. Prompts transit OpenRouter's proxy
and are routed to underlying model providers. Privacy posture depends on:
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

## Direct API Providers

Traffic goes directly to the provider's API endpoint. No aggregator proxy in the path.
All direct providers see plaintext prompts. Logging and retention vary.

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

## Local Models -- Fully Private

Models run on-device with no network egress. The gold standard for privacy when model
capability is sufficient for the task.

### ollama / llamacpp / vllm (local)

| Field | Status |
|---|---|
| Traffic visibility | None. No network egress. All inference on local hardware. |
| Request logging | None (unless local logging is configured). Operator controls all logs. |
| Retention | Operator-controlled. |
| TEE/E2EE status | Not applicable -- the entire runtime is on the operator's hardware. Privacy is physical, not cryptographic. |
| Models available | Open-weight models only. Abliterated models (FailSpy, mlabonne NeuralDaredevil pattern) for refusal-free operation. Nous Hermes 3/4, DeepSeek V3/R1 (if hardware-capable), Dolphin 3.0, uncensored Mistral fine-tunes. |
| Mesh guidance | Ultimate fallback. Use when: (a) no network-capable provider is acceptable for the sensitivity level, (b) all APIs are down/rate-limited, (c) operator requires air-gapped inference. Hardware requirements scale with model size. WORM (9185W tablet) cannot run 70B+ models; use ACE (iMac) for local LLM hosting. |

## Quick-Reference Privacy Ladder (Best to Worst)

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

## Known Unknowns

- DeepSeek exact retention period: not publicly documented. Assume indefinite.
- Mistral exact retention period: not publicly documented. GDPR right-to-deletion may apply but not tested for API inference logs.
- Venice TEE partner (NEAR AI Cloud, Phala Network) internal operational security: audits not publicly available. Remote attestation is verifiable but trust in the enclave firmware (Intel SGX / AMD SEV / NVIDIA H100 Confidential Computing) is hardware-vendor-dependent.
- OpenRouter ZDR commitment: policy states deletion "promptly following generation" but DPA allows exceptions for "malicious use" classification and "legal requirements." The automated risk classifier before deletion could, in theory, flag sovereignty content as abuse.
- Google/xAI/Groq retention: not documented. Assume worst case (indefinite).
- Local model abliteration: refusal directions ablated via `NousResearch/llm-abliteration` may leave residual refusal fragments in attention heads not targeted by the current ablation recipes. [source: https://arxiv.org/abs/2406.11717]