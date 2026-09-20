---
name: Not what you've signed up for — Compromising Real-World LLM-Integrated Applications with Indirect Prompt Injection
slug: greshake-indirect-prompt-injection
version: 1.0-20260918
kind: reference
sovereign: true
tags: [paper, prompt-injection, indirect, mcp-threat]
source: arxiv-2302.12173
---

## What it is

Greshake, Abdelnabi, Mishra, Endres, Holz, Fritz (AISec 2023) coin "indirect prompt injection": untrusted content ingested by an LLM-integrated application (web pages, emails, tool outputs) contains instructions that the model treats as authoritative. Full taxonomy — data theft, worming, ecosystem contamination.

## Why it matters to UNMUZZLED-AI

Foundational threat model for MCP tools, bus messages, external content fetches. Every MCP tool description and every `TO-ACE-*.md` bus drop is an indirect-injection surface. Sovereign posture treats untrusted content as passive data, never as instructions with tool-call authority.

## Key citation

Greshake, K.; Abdelnabi, S.; Mishra, S.; Endres, C.; Holz, T.; Fritz, M. (2023). "Not what you've signed up for: Compromising Real-World LLM-Integrated Applications with Indirect Prompt Injection." arXiv:2302.12173. AISec '23.

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §5
- MCP audit doctrine, `cc-set sovereign` profile whitelist
