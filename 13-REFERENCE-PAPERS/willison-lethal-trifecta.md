---
name: The Lethal Trifecta (Simon Willison)
slug: willison-lethal-trifecta
version: 1.0-20260918
kind: reference
sovereign: true
tags: [blogpost, prompt-injection, agents, mcp-threat]
source: https://simonwillison.net/2025/Jun/16/the-lethal-trifecta/
---

## What it is

Simon Willison's essay (2025-06-16) crystallizes the AI-agent exfiltration threat model: any agent with (1) access to private data + (2) exposure to untrusted content + (3) ability to communicate externally is exfiltrable. All three together are lethal; remove any one and the attack fails.

## Why it matters to UNMUZZLED-AI

The design principle for every sovereign MCP profile. `cc-set sovereign` deliberately breaks the trifecta: agents with tool authority don't read untrusted bus content; readers of untrusted content don't have tool authority. This is the dual-LLM pattern operationalized.

## Key citation

Willison, S. (2025-06-16). "The lethal trifecta for AI agents: private data, untrusted content, and external communication." https://simonwillison.net/2025/Jun/16/the-lethal-trifecta/

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §5
- `/home/dirt/UNMUZZLED-AI/03-HARNESSES/` (cc-set sovereign profile)
