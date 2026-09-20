---
name: TransformerLens (Neel Nanda)
slug: transformerlens
version: 1.0-20260918
kind: reference
sovereign: true
tags: [repo, tool, mechanistic-interpretability, transformerlens]
source: https://github.com/TransformerLensOrg/TransformerLens
---

## What it is

Mechanistic-interpretability library for transformer models. Exposes residual-stream activations, attention patterns, and hook points needed to compute refusal directions and other feature-level probes. Originally by Neel Nanda; now community-maintained.

## Why it matters to UNMUZZLED-AI

Substrate for every abliteration pass: you need residual-stream hooks to compute μ_harm − μ_benign. NousResearch/llm-abliteration and FailSpy's notebook both build on TransformerLens.

## Key citation

Nanda, N. et al. "TransformerLens." https://github.com/TransformerLensOrg/TransformerLens

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §1, §7-F
- `/home/dirt/UNMUZZLED-AI/05-LOCAL-MODELS/abliteration-pipeline/`
