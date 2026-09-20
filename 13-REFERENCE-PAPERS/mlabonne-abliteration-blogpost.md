---
name: Uncensor any LLM with abliteration (mlabonne HF blog)
slug: mlabonne-abliteration-blogpost
version: 1.0-20260918
kind: reference
sovereign: true
tags: [blogpost, abliteration, tutorial, huggingface]
source: https://huggingface.co/blog/mlabonne/abliteration
---

## What it is

Maxime Labonne's canonical walkthrough of abliteration. Uses TransformerLens, computes refusal direction across `resid_pre`/`resid_mid`/`resid_post`, orthogonalizes weight matrices. Demonstrates the quality-recovery step: DPO on a clean instruction dataset repairs post-abliteration degradation. Produced `NeuralDaredevil-8B` as the working example.

## Why it matters to UNMUZZLED-AI

Best single tutorial to read before running the sovereign abliteration pipeline. The DPO-recovery step is essential for keeping abliterated models at production quality.

## Key citation

Labonne, M. (2024). "Uncensor any LLM with abliteration." Hugging Face Blog. https://huggingface.co/blog/mlabonne/abliteration

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §1
- `/home/dirt/UNMUZZLED-AI/05-LOCAL-MODELS/abliteration-pipeline/`
- `/home/dirt/UNMUZZLED-AI/09-EDUCATIONAL/` (tutorial source)
