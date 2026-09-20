---
name: New Prompt Injection Papers — Agents Rule of Two (Willison / Meta)
slug: willison-agents-rule-of-two
version: 1.0-20260918
kind: reference
sovereign: true
tags: [blogpost, prompt-injection, agents, meta]
source: https://simonw.substack.com/p/new-prompt-injection-papers-agents
---

## What it is

November 2025 refinement of the lethal-trifecta: Meta's "Agents Rule of Two" adds "changing state" as a fourth axis. An agent may hold at most two of {private-data access, untrusted-content exposure, external comms, state mutation}. Willison summarizes the Meta paper and situates it in the broader threat literature.

## Why it matters to UNMUZZLED-AI

Design constraint for every sovereign harness profile. `cc-set` profile definitions should explicitly declare which two axes each profile carries and refuse to enable a third.

## Key citation

Willison, S. (2025-11). "New Prompt Injection Papers: Agents Rule of Two." simonw.substack.com/p/new-prompt-injection-papers-agents. Meta AI paper cited within.

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §5
- `/home/dirt/UNMUZZLED-AI/03-HARNESSES/` (profile design)
