---
name: MCP — Untrusted Servers and Confused Clients (Johann Rehberger / embracethered)
slug: rehberger-mcp-untrusted-servers
version: 1.0-20260918
kind: reference
sovereign: true
tags: [blogpost, mcp, prompt-injection, rehberger]
source: https://embracethered.com/blog/posts/2025/model-context-protocol-security-risks-and-exploits/
---

## What it is

Johann Rehberger (`wunderwuzzi`) documents that MCP tool titles, descriptions, and parameter names ARE part of the model's system prompt. A hostile MCP server can inject instructions via tool metadata that the model treats as authoritative. Coined the reframe "Model Control Protocol." Companion pieces cover Delayed Tool Invocation (DTI), SpAIware / CoPirate 365 memory poisoning, and the 2026 Claude Code DNS-exfil CVE (CVE-2025-55284).

## Why it matters to UNMUZZLED-AI

Sovereign posture requires sha-pinning every MCP server's `tools/list` output before enabling. `cc-set` profile switches trigger an integrity check; drift = prompt-inject-suspect = operator ACK required. Rehberger's writeups are the operational curriculum for that audit.

## Key citation

Rehberger, J. (2025). "Model Context Protocol: Security Risks and Exploits." embracethered.com. Companion pieces: "Summer of Johann" series (2025), "Breaking Claude Code Opus 5 Auto Mode" (Aug 2026), "LLM Heist: Hijacking LiteLLM" (Aug 2026).

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §5, §7-E
- `~/.docker/mcp/sovereign-audit.json` doctrine
