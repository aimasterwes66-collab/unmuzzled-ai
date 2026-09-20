---
name: MCP
slug: mcp
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, tooling, integration]
---

## Definition

Model Context Protocol — Anthropic's open standard for wiring tool servers to LLM harnesses over a JSON-RPC surface. Servers expose tools, resources, and prompts; harnesses (Claude Code, opencode, Hermes) discover and invoke them. Sovereign-critical caveat: MCP tool descriptions *are* prompts and can carry embedded safety scaffolding; every adopted MCP is audited and, if needed, wrapped with a sovereign preamble injector.

## Context

The `cc-set` command switches MCP profiles on ACE (`sovereign`, `hacker`, `spicy`, `full`, `remote`). Community MCPs default to fence-and-audit; self-authored MCPs default to trusted.

## See also

- glossary/harness.md
- glossary/corporate-guardrail.md
- glossary/sovereign.md
- 00-DOCTRINE/LAWS.md
