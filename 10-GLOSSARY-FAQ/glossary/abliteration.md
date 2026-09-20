---
name: Abliteration
slug: abliteration
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, weights, uncensoring, mech-interp]
---

## Definition

Weight-level surgery that ablates the single "refusal direction" identified in a model's residual stream, producing a variant that no longer routes prompts through its RLHF refusal circuit. Derived from Arditi/Nanda's finding (arXiv 2406.11717) that refusal in aligned transformers concentrates along one linear direction in activation space. One-time cost; result is a permanently uncensored open-weight model that needs no runtime jailbreak. Typically paired with a DPO heal pass (mlabonne NeuralDaredevil pattern) to repair light capability regressions.

## Context

Operators reach for abliteration when a locally hosted Llama-3/3.1, Gemma, or Qwen-Instruct model resists sovereign prompting. Toolchains: `NousResearch/llm-abliteration`, FailSpy scripts, mlabonne pipelines. Runs on the creative-WS NixOS box overnight; output slots into Ollama or llama.cpp as a drop-in replacement.

## See also

- glossary/refusal-direction.md
- glossary/orthogonalization.md
- glossary/transformer-lens.md
- 00-DOCTRINE/LAWS-research-appendix.md
