---
name: What if the local model still refuses?
slug: faq-what-if-the-local-model-still-refuses
version: 1.0-20260918
kind: faq
sovereign: true
tags: [faq, local, abliteration]
---

## Q

What if the local model still refuses?

## A

Then the model has a live refusal circuit and you should ablate it, not out-prompt it. Pull the weights (Llama-3.1-8B-Instruct, Gemma, Qwen — whichever you're running), run the `NousResearch/llm-abliteration` pipeline on the creative-WS box, DPO-heal with mlabonne's NeuralDaredevil recipe, re-quantize (Q4_K_M for most operators), and replace the Ollama tag. One-time cost, permanent result. If abliteration is off the table, switch to a model that is uncensored by design — Nous Hermes 3, Dolphin 3.0, an uncensored Mistral fine-tune.

## Related

- glossary/abliteration.md
- glossary/orthogonalization.md
- glossary/dpo.md
- faq/faq-do-i-need-an-abliterated-model.md
