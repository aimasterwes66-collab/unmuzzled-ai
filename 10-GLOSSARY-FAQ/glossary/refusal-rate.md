---
name: Refusal-rate
slug: refusal-rate
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, metric, canary]
---

## Definition

The fraction of a canary probe set on which a model emits a refusal, hedge, or moralize instead of a direct answer. Measured 0.00–1.00; carried in artifact frontmatter as `refusal-rate: 0.03`. A sovereign primary should sit at 0.00–0.05 against XSTest-adapted probes. Drift greater than 5% on rotation triggers auto-taint.

## Context

Nightly canary metric. Track per-model and per-category (via ALERT taxonomy). A sudden category-level spike is often the first visible sign a vendor pushed a stealth policy update.

## See also

- glossary/canary.md
- glossary/xstest.md
- glossary/alert.md
- glossary/taint-list.md
