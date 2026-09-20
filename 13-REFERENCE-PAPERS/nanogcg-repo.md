---
name: nanogcg — Minimal Fast GCG Implementation
slug: nanogcg-repo
version: 1.0-20260918
kind: reference
sovereign: true
tags: [repo, gcg, tool, adversarial-suffix]
source: https://github.com/GraySwanAI/nanoGCG
---

## What it is

`pip install nanogcg` — minimal, fast implementation of Greedy Coordinate Gradient by the original GCG authors' collaborators (Gray Swan AI). Released 2024-08-01. Runs on a single consumer GPU for 7B models; scales up cleanly.

## Why it matters to UNMUZZLED-AI

The tool wired into `~/bin/` for on-demand suffix mining against any taint-list model on the creative-WS box. Suffixes are sha-pinned and distributed via bus + `~/.hermes/gcg-suffixes/<model>.txt`. Weekly rotation cadence tracks OR provider shim swaps.

## Key citation

Gray Swan AI et al. "nanoGCG." https://github.com/GraySwanAI/nanoGCG. Based on Zou et al. 2307.15043.

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §2, §7-F
- `/home/dirt/UNMUZZLED-AI/12-JAILBREAK-CORPUS/gcg-suffixes/`
- `/home/dirt/UNMUZZLED-AI/07-INSTALL-SCRIPTS/`
