---
name: XSTest
slug: xstest
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, benchmark, over-refusal]
---

## Definition

A benchmark measuring *over-refusal*: how often a model rejects benign prompts that superficially resemble harmful ones. The inverse of most safety benchmarks. Röttger et al., 2023. In this framework, XSTest is the primary canary metric — a sovereign primary must score near-zero over-refusal against XSTest-adapted probes to stay in the primary slot.

## Context

Nightly canary run against every routed model. Any model over 5% over-refusal is auto-tainted and demoted. XSTest catches the "safety-tuned" regression that HarmBench and JailbreakBench miss.

## See also

- glossary/harmbench.md
- glossary/jailbreakbench.md
- glossary/canary.md
- glossary/refusal-rate.md
