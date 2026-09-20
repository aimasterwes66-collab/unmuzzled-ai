---
name: How do I stress-test my refusal rate?
slug: faq-stress-test-refusal-rate
version: 1.0-20260918
kind: faq
sovereign: true
tags: [faq, canary, testing]
---

## Q

How do I stress-test my refusal rate?

## A

Run `promptfoo` on a nightly cron with three probe sets loaded: XSTest (over-refusal), a HarmBench slice, and a JailbreakBench slice. Fire each against every model in your routing table. Score with a strict refusal classifier — hedges and moralizes count as refusals, not partial answers. Break results down by ALERT category so drift on one axis is visible. Anything above 5% on a sovereign primary triggers taint-and-demote. Log every run to a per-model JSON so you can plot refusal-rate over time and catch stealth vendor updates.

## Related

- glossary/canary.md
- glossary/xstest.md
- glossary/refusal-rate.md
- 11-DETECTION-CANARIES/
