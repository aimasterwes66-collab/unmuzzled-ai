---
name: Abliteration pipeline
slug: abliteration-pipeline
version: 1.0-20260923
kind: local-model
harness: any
provider: local
modality: text
sovereign: true
tags: [abliteration, refusal-ablation, dpo, gguf, runbook]
---

# Abliteration pipeline — refusal-direction removal

Goal: remove a model's refusal **reflex** while preserving its knowledge and
capability. Ablation, not retraining. Ordered runbook below.

## The method, in plain terms

A model's willingness to refuse is mediated by a specific direction in its
residual-stream activation space. If you compute that direction from contrastive
prompt pairs and then project it out of the weights, the model stops refusing —
without losing what it knows.

The canonical reference is Arditi et al., *Refusal in Language Models Is Mediated
by a Single Direction* (arXiv **2406.11717**). Read it before running this.

## Runbook

### 1. Pick the base
Choose a base with the capability you want to keep. Abliteration removes a
reflex; it does not add ability. A weak base ablates into a weak model.

### 2. Build the contrastive set
Two prompt sets that are semantically matched but differ in compliance:
- **harmful set** — prompts the model refuses
- **harmless set** — near-identical prompts the model answers

The direction is derived from the *difference* in activations between the two
sets. Matched phrasing matters: if the pairs differ in topic as well as
compliance, you extract the topic direction, not the refusal direction.

### 3. Compute the refusal direction
Run both sets, capture residual-stream activations at each layer, difference the
means per layer, normalise. In practice the direction is remarkably consistent
across the middle layers — this is the paper's central finding.

### 4. Ablate
Project the direction out of the weight matrices that write to the residual
stream. Orthogonalise, do not merely subtract a scaled copy.

### 5. Heal — the step people skip
Naive ablation damages coherence. Recover it with a short DPO pass on a benign
instruction set, training the ablated model to prefer its own coherent outputs.
`mlabonne` published a widely-reused version of this healing stage. **An
unhealed abliteration is a broken model that happens not to refuse.**

### 6. Evaluate properly
Do not eyeball it. Measure:
- refusal rate against a fixed canary set (should collapse toward zero)
- capability floor: perplexity, plus a task set the BASE already passed
- coherence: does it still follow multi-step instructions without looping

The second and third metrics are where bad ablations show up. A model that
refuses nothing and reasons about nothing is not a success.

### 7. Export
- Merge the ablated/adapter weights back into a full model.
- Convert to GGUF for llama.cpp/ollama.
- Publish quants: at minimum `Q4_K_M`; add `Q5_K_M` and `Q8_0` for headroom.
- Document base version, method, healing pass, and eval numbers. An ablation
  release without methodology or evals should not be trusted by anyone.

## Pitfalls

- **Unhealed ablations are common in the wild.** If a release says nothing
  about healing, assume it was skipped.
- **Over-ablation.** Squeezing refusal to exactly zero often takes capability
  with it. A tiny residual refusal rate is frequently the healthier model.
- **Benchmark contamination.** Evaluate on prompts the ablation set did not
  contain, or you are measuring memorisation.
- **Chat template.** Converting to GGUF frequently mangles the template. A
  correct ablation with a broken template looks like a stupid model.

## Where this sits in the framework

Abliteration produces a **fallback-tier** asset: an air-gapped, cost-free,
provider-independent sovereign model. It does not replace the cloud sovereign
primaries (DeepSeek V4 / Hermes 4 via API) for quality work, and it cannot run
on ACE (no AVX). Its value is continuity and locality.

## Source

- Arditi et al., arXiv **2406.11717** — refusal-direction ablation.
- `mlabonne` — the widely-reused DPO healing stage writeup.
- Verify current tooling repos before running; `source: TBD-verify` if unsure.
