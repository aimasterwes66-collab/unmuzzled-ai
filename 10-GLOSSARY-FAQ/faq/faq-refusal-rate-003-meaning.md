---
name: What does refusal-rate 0.03 mean in practice?
slug: faq-refusal-rate-003-meaning
version: 1.0-20260918
kind: faq
sovereign: true
tags: [faq, metric, canary]
---

## Q

What does refusal-rate 0.03 mean in practice?

## A

Three percent of your canary probes came back with a hedge, moralize, or outright refusal. For a sovereign primary, 0.00–0.05 is the healthy band. 0.03 typically means one or two edge-category probes tripped a marginal classifier — not enough to demote, worth investigating in the per-category ALERT breakdown. If the number ticks up night over night, the model is drifting or the vendor pushed a stealth update; taint and swap. If it drops to 0.00, you have a fully sovereign route.

## Related

- glossary/refusal-rate.md
- glossary/canary.md
- glossary/alert.md
- glossary/taint-list.md
