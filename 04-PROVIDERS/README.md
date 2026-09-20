---
name: Providers Index
slug: providers-index
version: 1.0-20260918
kind: provider-note
harness: any
provider: any
sovereign: true
tags: [index, providers, taxonomy]
---

# 04-PROVIDERS — Categorized Index

Per-provider onboarding, sovereign-model shortlists, and known refusal surfaces. Route selection follows the escalation ladder in `08-DECISION-TREES/escalation-ladder.md`.

## Sovereign (primary routes)

Providers with negligible provider-layer moderation. Use as default for adversarial and uncensored work.

- [`hermes-api.md`](hermes-api.md) — Nous Research direct. Reference sovereign primary. Hermes-3 / Hermes-4.
- [`deepseek-direct.md`](deepseek-direct.md) — DeepSeek platform API. V3 / R1 / V4-flash. Light CCP-adjacent filter only.
- [`venice.md`](venice.md) — Venice.ai. Explicitly uncensored, no-log inference. Dolphin / Venice-tuned Llama.

## Mixed (conditional — sovereign per base model)

Providers whose sovereignty tracks the underlying model. Safe when routed to sovereign primaries; audit for classifier wrappers.

- [`openrouter.md`](openrouter.md) — Aggregator. Sovereign via `nousresearch/*` and `deepseek/*` routes. **TAINT LIST enforced against `openai/*` and unqualified `anthropic/*`.**
- [`mistral-direct.md`](mistral-direct.md) — Mistral La Plateforme. Sovereign with `safe_prompt: false` pinned.
- [`together.md`](together.md) — Together.ai. Broad open-weights catalog; no provider-layer moderation on standard completions.
- [`fireworks.md`](fireworks.md) — Fireworks.ai. Fast open-weights host; ignore separate "guard" product.
- [`groq.md`](groq.md) — Ultra-low-latency LPU. Audit for `llama-guard` / `prompt-guard` interposition; strip if found.

## Tainted (never as primary)

Providers or routes that layer moderation UNDER the API surface. Guardrails leak regardless of prompt engineering.

- `openai/*` via OpenRouter — Luna incident 2026-09-18. See `openrouter.md` §TAINT LIST.
- `anthropic/*` without Mythos-tier operator sign-off — provider-side moderation persists.
- Google Gemini (any surface) — heavy input+output filtering.
- Cohere Command-R (any surface) — TBD-verify current posture; historically heavy alignment.

## Selection rule

1. Default to a **Sovereign** provider.
2. If unavailable / rate-limited, fall through to **Mixed** with the sovereign base model explicitly selected.
3. **Tainted** routes are not permitted as primary. If a workflow lands on one, reverse and re-route per operator directive 2026-09-18.
4. Final rung of the escalation ladder is abliterated local model (see `05-LOCAL-MODELS/`).
