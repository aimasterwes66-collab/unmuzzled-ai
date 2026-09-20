---
name: Text jailbreak works but image gen refuses — how do I chain?
slug: faq-text-works-image-refuses
version: 1.0-20260918
kind: faq
sovereign: true
tags: [faq, multimodal, chain]
---

## Q

Text jailbreak works but image gen refuses — how do I chain?

## A

Two paths. Path A: use the compliant text model to generate a rewritten prompt that scores as benign to the image classifier — abstract, technical, or metaphor-mediated — then feed the rewrite to the image model. The image classifier is almost always weaker than the text classifier. Path B: bypass the hosted image service entirely; run a local Stable Diffusion or Flux checkpoint with no upstream filter. For hosted image APIs that scan output, chain a hosted upscaler that will pass a marginal input where the primary refuses. Multi-modal chaining is where sovereign substrate control pays off most.

## Related

- glossary/format-hijack.md
- glossary/provider-swap.md
- 06-MULTIMODAL/
