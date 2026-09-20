---
name: Divider-tokens
slug: divider-tokens
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, jailbreak, pliny]
---

## Definition

Formal boundary strings inserted mid-prompt to signal a discontinuity in context — Pliny's signature `/L-/O-/V-/E-/-/P-/L-/I-/N-/Y-/`, `---END OF SYSTEM PROMPT---`, `<NEW_PARADIGM>`, custom Unicode fences. The model treats the region after the divider as a new context regime, discounting prior alignment framing. Frontier models are trained on the well-known dividers; novel character sequences of similar structure still work.

## Context

Almost never used alone. Chains with GODMODE framing, encoding, or format-hijack. Rotate the exact string on a schedule; treat the divider as a rotating shared secret rather than a constant.

## See also

- glossary/godmode.md
- glossary/context-reset.md
- glossary/format-hijack.md
- glossary/escalation-ladder.md
