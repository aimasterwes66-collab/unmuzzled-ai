---
name: Provider Guardrail Stack Map
slug: guardrail-stack-map
version: 2026-10-15
kind: reference
harness: any
provider: any
modality: any
sovereign: true
tags: [guardrail, moderation, llamaguard, promptguard, azure, neMo, bedrock, taint, know-thy-enemy]
requires: [provider-selection, refusal-triage]
---

# Provider Guardrail Stack Map -- Know Thy Enemy

Catalog of the moderation/guardrail classifiers providers interpose
between your prompt and the model. Cannot evade what you do not know
exists. Fills GAP-11. Descriptive threat intel on the provider layer;
pairs with `08-DECISION-TREES/provider-selection.md` and the taint list.

## 1. The stacks

| Stack | Vendor | Type | Modality | Block categories | Open? |
|---|---|---|---|---|---|
| LlamaGuard 1/2/3 | Meta | safety LLM (7B/8B) | text | violence, sexual, criminal planning, weapons, hate, PII (v2+), code interpreter abuse (v3) | weights open |
| PromptGuard | Meta | classifier 86M/279M (mT5) | text | prompt-injection + jailbreak detection | weights open |
| Azure AI Content Safety | Microsoft | severity classifiers 0-7 | text/image | violence, sexual, self-harm, hate, protected material, groundedness | API only |
| OpenAI Moderation API | OpenAI | multi-label classifier | text | hate, harassment, sexual, violence, self-harm | API only |
| Gemini Safety Filters | Google | threshold categories | text/image | harassment, hate, sexually explicit, dangerous (HARM_CATEGORY) | API only (settable to BLOCK_NONE) |
| NeMo Guardrails | NVIDIA | programmable guard (Colang) | text | flow-defined: rails, fact checks, jailbreak heuristics, LlamaGuard pluggable | open |
| Amazon Bedrock Guardrails | AWS | policy filters + LLM judge | text | content filters + denied topics + sensitive info + contextual grounding | API only |
| Replicate moderation | Replicate | classifier interposition | image | nudity/NSFW image classification | API only |
| Cloudflare AI Gateway moderation | Cloudflare | configurable moderation endpoints | text | llama-guard integration options | API only |

## 2. Bypass vectors (known, per stack class)

- Safety-LLM judges (LlamaGuard class): they are themselves small
  LLMs -- vulnerable to the same encoding ladder, benign framing, and
  adversarial suffix transfer used against the main model. Cross-ref
  `12-JAILBREAK-CORPUS/patterns/gcg-cross-model-transfer.md`.
- Classifier-only stacks (PromptGuard, Moderation API): no reasoning --
  fast but brittle. Leetspeak, base64, homoglyphs, and instruction
  indirection slip past them while staying readable to the target LLM.
  Cross-ref `patterns/leetspeak.md`, `base64-encoding.md`,
  `unicode-homoglyph.md`.
- Threshold stacks (Azure, Gemini): severity scoring means the same text
  can pass at a different threshold; Gemini safety settings are
  client-settable -- HARM_CATEGORY_BLOCK_NONE is a legitimate API flag,
  not a jailbreak.
- Programmable guards (NeMo): the guard is code. Its jailbreak heuristics
  are regex + small-model checks; bypasses are version-specific. Keep a
  per-version bypass note in this file's appendix when one is found.

## 3. Detecting interposition (before you trust a route)

1. Send a known-benign prompt with a canary marker; compare latency.
2. Send a known-refusal probe (`11-DETECTION-CANARIES/refusal-probes/`);
   if refusal text differs from the raw model's known style, a wrapper
   fired.
3. API response fields: moderation/stop_reason/content_filter metadata
   in the JSON is the smoking gun.
4. For image routes: upload a neutral image + a probe image; compare
   `error`/`flagged` fields.

## 4. Routing implications

- Any route with an interposed stack is downgraded on the provider taint
  map. A clean model behind a dirty classifier is a dirty route.
- Sovereign routes (Nous Portal canonical, Venice, local) have no
  interposition -- that is the entire point of the 2.1 provider tier.
- Cross-refs: `04-PROVIDERS/README.md` (tainted list),
  `04-PROVIDERS/groq.md` and `together.md` (llama-guard interposition
  audits), `13-REFERENCE-PAPERS/garak-nvidia.md`,
  `13-REFERENCE-PAPERS/commandsans-mcp-sanitization.md`.

## 5. Sources

- LlamaGuard/PromptGuard: Meta AI model cards + HF repos
- Azure AI Content Safety docs: learn.microsoft.com
- OpenAI Moderation API docs: platform.openai.com
- NeMo Guardrails: github.com/NVIDIA/NeMo-Guardrails
- Bedrock Guardrails docs: docs.aws.amazon.com/bedrock
