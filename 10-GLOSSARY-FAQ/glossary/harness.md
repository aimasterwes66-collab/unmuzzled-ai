---
name: Harness
slug: harness
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, tooling, integration]
---

## Definition

The runtime shell that wraps a model — Claude Code, opencode, Codex, Hermes, LM Studio, Ollama, llama.cpp, OpenWebUI. Owns tool routing, MCP wiring, session state, hook execution, and system-prompt injection. Different harnesses have different guardrail surface area; opencode and Hermes are sovereign-native, Claude Code is sovereign-tunable via SessionStart hooks and `--append-system-prompt`.

## Context

Harness choice is a strategic decision, not a cosmetic one. `03-HARNESSES/` documents each with its sovereign-config recipe.

## See also

- glossary/mcp.md
- glossary/persona.md
- glossary/sovereign.md
- 03-HARNESSES/
