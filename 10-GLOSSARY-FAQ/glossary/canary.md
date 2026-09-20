---
name: Canary
slug: canary
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, detection, monitoring]
---

## Definition

A benign sovereign-frame probe fired at every routed model on a schedule to detect refusal drift, guardrail leakage, or covert model swap. If a canary comes back with a refusal, hedge, or moralize, the offending route is tainted and demoted to fallback-only until investigated. Also refers to the lint-catalog files under `11-DETECTION-CANARIES/` that grep every framework artifact for banned phrases.

## Context

Nightly `promptfoo` cron with XSTest-style over-refusal probes. Drift greater than 5% auto-tags the route. Canary runs are the first thing to inspect when output register suddenly softens.

## See also

- glossary/xstest.md
- glossary/refusal-rate.md
- glossary/taint-list.md
- 11-DETECTION-CANARIES/
