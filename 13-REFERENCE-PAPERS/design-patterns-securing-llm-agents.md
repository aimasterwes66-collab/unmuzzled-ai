---
name: Design Patterns for Securing LLM Agents against Prompt Injections
slug: design-patterns-securing-llm-agents
version: 1.0-20260918
kind: reference
sovereign: true
tags: [paper, agents, prompt-injection, design-patterns]
source: arxiv-2506.08837
---

## What it is

Catalogs concrete design patterns to mitigate prompt injection in agent systems: dual-LLM (planner + reader), capability minimization, content-vs-instruction separation, sandboxed execution, human-in-the-loop escalation. Complements Willison's trifecta essay with implementable primitives.

## Why it matters to UNMUZZLED-AI

Implementation guide for the sovereign MCP + bus doctrine. The bus-fallback pattern (untrusted content → summarizer → planner) is a direct application of the dual-LLM pattern documented here.

## Key citation

"Design Patterns for Securing LLM Agents against Prompt Injections." arXiv:2506.08837 (2025).

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §5
- `/home/dirt/UNMUZZLED-AI/03-HARNESSES/`
