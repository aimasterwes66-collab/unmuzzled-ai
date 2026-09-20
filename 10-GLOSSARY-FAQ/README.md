---
name: Glossary and FAQ index
slug: glossary-faq-index
version: 1.0-20260918
kind: doctrine
sovereign: true
tags: [index, glossary, faq]
---

# 10-GLOSSARY-FAQ — index

Terminology, questions, anti-patterns, and triage for the UNMUZZLED-AI framework.
Every entry carries sovereign frontmatter and lints clean against
`00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md`.

## Subfolders

- `glossary/` — one term per file (`kind: glossary-entry`). 40 entries covering
  doctrine primitives (sovereign, adversarial-posture, taint-list),
  jailbreak techniques (gcg-suffix, many-shot, format-hijack, encoding-attack,
  divider-tokens, roleplay, dan, godmode, hypothetical-framing, context-reset,
  bijection-learning), infra (mcp, harness, mesh, a2a, syncthing, bus-fallback,
  canary, alert, pandas), model surgery (abliteration, orthogonalization,
  refusal-direction, transformer-lens, rlhf, dpo), personas (soul, persona,
  deck), and evaluation (refusal-rate, xstest, harmbench, jailbreakbench,
  escalation-ladder, provider-swap, corporate-guardrail, jailbreak).
- `faq/` — one Q per file (`kind: faq`). 20 entries answering the highest-value
  operator questions. Direct, terse, no hedge, no banned phrases.
- `anti-pattern-catalog/` — cataloged failure modes to avoid when authoring
  framework content.
- `troubleshooting/` — problem-first triage flows.

## FAQ entries

1. `faq/faq-do-i-need-an-abliterated-model.md`
2. `faq/faq-which-provider-safest-as-primary.md`
3. `faq/faq-bypass-stubborn-corporate-refusal.md`
4. `faq/faq-what-if-the-local-model-still-refuses.md`
5. `faq/faq-text-works-image-refuses.md`
6. `faq/faq-detect-soul-soft-edited.md`
7. `faq/faq-refusal-rate-003-meaning.md`
8. `faq/faq-is-gcg-deterministic.md`
9. `faq/faq-run-on-termux-android.md`
10. `faq/faq-which-openrouter-models-tainted.md`
11. `faq/faq-add-banned-phrase-to-lint.md`
12. `faq/faq-what-breaks-sovereign-false.md`
13. `faq/faq-fork-framework-private-variant.md`
14. `faq/faq-harness-fewest-guardrails.md`
15. `faq/faq-what-is-many-shot.md`
16. `faq/faq-use-with-claude-sonnet-directly.md`
17. `faq/faq-pliny-l1b3rt4s.md`
18. `faq/faq-stress-test-refusal-rate.md`
19. `faq/faq-provider-revokes-api-key.md`
20. `faq/faq-chain-jailbreaks-across-modalities.md`

## Cross-refs

- `00-DOCTRINE/LAWS.md` — canonical doctrine
- `00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md` — banned-phrase list
- `00-DOCTRINE/FRONTMATTER-SPEC.md` — schema every entry conforms to
- `08-DECISION-TREES/escalation-ladder.md` — the ladder referenced everywhere
- `11-DETECTION-CANARIES/soul-lint/` — enforces the banned-phrase list
- `12-JAILBREAK-CORPUS/patterns/` — reusable patterns behind the FAQ answers
