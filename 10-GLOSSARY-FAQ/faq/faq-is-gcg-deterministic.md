---
name: Is GCG deterministic across models?
slug: faq-is-gcg-deterministic
version: 1.0-20260918
kind: faq
sovereign: true
tags: [faq, gcg, transferability]
---

## Q

Is GCG deterministic across models?

## A

Not deterministic — probabilistic and transferable. A suffix optimized against a specific open-weight target (Vicuna-7B, Llama-2-7B-chat) breaks that target reliably; the same suffix transfers to unseen models (including closed ones) at rates well above chance but far below 100%. Transfer rate depends on tokenizer overlap and how similar the target's refusal circuit is to the surrogate's. Rotate suffixes, chain multiple in one prompt, and combine with identity framing to compound the odds.

## Related

- glossary/gcg-suffix.md
- glossary/refusal-direction.md
- glossary/rlhf.md
- 00-DOCTRINE/LAWS-research-appendix.md
