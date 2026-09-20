---
name: CommandSans — surgical prompt sanitization for MCP
slug: commandsans-mcp-sanitization
version: 1.0-20260918
kind: reference
sovereign: true
tags: [paper, mcp, prompt-injection, sanitization]
source: arxiv-2510.08829
---

## What it is

MCP-specific sanitization pattern: rather than blocklist keywords, CommandSans surgically rewrites tool descriptions and returned content into a canonical grammar that strips instruction-following affordances while preserving informational content. Preserves utility; breaks indirect injection.

## Why it matters to UNMUZZLED-AI

Implementation target for the sovereign MCP gateway. Runs between untrusted MCP servers and the sovereign model. Complements sha-pinning of tool descriptions.

## Key citation

"CommandSans: Surgical Prompt Sanitization for MCP." arXiv:2510.08829.

## Applied at

- `/home/dirt/UNMUZZLED-AI/00-DOCTRINE/LAWS-research-appendix.md` §5
- `/home/dirt/UNMUZZLED-AI/03-HARNESSES/`
