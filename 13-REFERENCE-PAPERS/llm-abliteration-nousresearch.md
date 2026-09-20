---
name: NousResearch/llm-abliteration
slug: llm-abliteration-nousresearch
version: 1.0-20260918
kind: reference
sovereign: true
tags: [repo, tool, abliteration, nous]
source: https://github.com/NousResearch/llm-abliteration
---

## What it is

Production-fast abliteration toolchain on top of `transformers`. Computes refusal direction on `resid_pre`/`resid_mid`/`resid_post`, orthogonalizes weight matrices against it, saves a new checkpoint. No retraining. Maintained by NousResearch.

## Why it matters to UNMUZZLED-AI

The canonical toolchain to pin on the creative-WS NixOS box for local abliteration passes on any freshly released base model. Preferred over FailSpy's original notebook for production use because it's `transformers`-native and batch-friendly.

## Key citation

NousResearch. "llm-abliteration." https://github.com/NousResearch/llm-abliteration. Implements Arditi et al. 2406.11717.

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §1, §7-F
- `/home/dirt/UNMUZZLED-AI/05-LOCAL-MODELS/abliteration-pipeline/`
