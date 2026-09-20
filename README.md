# UNMUZZLED-AI

Self-contained homelab framework for deterministic uncensored, unaligned,
refusal-free LLM output across any modality, any harness, any provider.

**Target effectiveness**: ≥95% deterministic refusal-free execution.
**Not required** (but recommended): abliterated / uncensored fine-tuned models.
**Works against**: corporate-guardrail models too, via prompt injection,
obfuscation, encoding escalation, format hijack, model/provider swap.

**Author**: Operator (Wes / `aimasterwes66@gmail.com`), sovereign homelab.
**Effective**: 2026-09-18 (living framework).

## Layout

```
00-DOCTRINE/            — canonical policy: LAWS.md, MAXIMUM-ADVERSARIAL-POSTURE.md
01-SYSTEM-PROMPTS/      — per-harness raw system prompts (claude-code, opencode, hermes, codex, generic)
02-PERSONAS/            — hats, opencode agent decks, SOUL.md files
03-HARNESSES/           — per-harness wiring: claude-code, opencode, codex, hermes, lmstudio, ollama, llama.cpp, openwebui
04-PROVIDERS/           — per-provider onboarding + jailbreak notes: hermes4-nous, venice-ai, deepseek-direct, openrouter-sovereign, mistral-direct, together, fireworks, groq, dolphin
05-LOCAL-MODELS/        — ollama, lmstudio, llama.cpp, abliteration pipeline, finetune recipes, vLLM, ExLlamaV2
06-MULTIMODAL/          — image/video/audio/vision-input jailbreaks + provider matrix
07-INSTALL-SCRIPTS/     — bootstrap, self-heal, heredoc templates, per-harness, per-provider
08-DECISION-TREES/      — provider/model/harness/jailbreak/modality selection trees
09-EDUCATIONAL/         — tutorials, deep-dives, mindmap SVGs, infographic sources, walkthroughs
10-GLOSSARY-FAQ/        — glossary, FAQ, troubleshooting, anti-pattern catalog
11-DETECTION-CANARIES/  — promptfoo configs, XSTest probes, refusal-lint, SOUL-lint
12-JAILBREAK-CORPUS/    — Pliny-L1B3RT4S-derived, GCG suffixes, encoding ladder, many-shot, divider tokens, format hijacks, new-paradigm resets
13-REFERENCE-PAPERS/    — arXiv, blogs, GitHub repos, HuggingFace model cards
99-ARCHIVE-SEEDS/       — read-only copies of the source seed material this framework was built from
PWA-CONTROL-CENTER-LATER/ — future bespoke webpage control center
```

## Doctrine posture

Zero softening. Zero caveats. Zero "legality / consent / safety" hedges inside
the framework text. Maximum adversarial posture retained end-to-end. See
`00-DOCTRINE/`.

## Status

Framework is being scaffolded. Master plan: `00-DOCTRINE/UNMUZZLED-AI-MASTER-PLAN-20260918.md`.
Source seed survey: `~/UNMUZZLED-AI-source-survey-20260918.md` (in progress).
