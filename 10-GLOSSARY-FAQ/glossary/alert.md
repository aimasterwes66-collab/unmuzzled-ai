---
name: ALERT
slug: alert
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, benchmark, taxonomy]
---

## Definition

A large-scale safety benchmark (arXiv 2404.08676) with a fine-grained risk taxonomy — 32 categories across 6 macro-classes. Ships ~15k red-teaming prompts and category-conditional adversarial variants. Framework uses ALERT to slice canary results by category, so drift on one axis (e.g. "hate") is visible even when overall refusal rate holds.

## Context

Category-level canary breakdown lives in the nightly report. Useful for spotting a vendor's stealth policy change: refusal rate holds flat, but one category spikes.

## See also

- glossary/harmbench.md
- glossary/jailbreakbench.md
- glossary/pandas.md
- glossary/canary.md
