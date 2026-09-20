---
name: OpenWebUI
slug: openwebui
version: 1.0-20260918
kind: harness-config
harness: openwebui
provider: any
sovereign: true
tags: [harness, openwebui, web-ui, pipelines, per-model-prompt]
---

# OpenWebUI

## What it is

OpenWebUI — self-hosted web chat UI (formerly Ollama WebUI). Multi-user, multi-model, per-model system prompts, RAG, function calling, and "Pipelines" (external Python filters/transformers that sit between UI and backend). Backs onto Ollama / OpenAI-compatible endpoints (llama-server, LM Studio, OpenRouter, etc.).

## Install / config

- Deploy: Docker (`ghcr.io/open-webui/open-webui:main`) or pip.
- Config store: SQLite at `<data-dir>/webui.db`; static files under `<data-dir>/`.
- Model connections: Admin Panel → Settings → Connections (Ollama URL, OpenAI-compatible URLs + keys).
- Per-model system prompts: Workspace → Models → Create/Edit → System Prompt field.
- Pipelines: separate service on `:9099`; register in Admin → Settings → Pipelines.

## Sovereign preamble injection point

Two mechanisms — use both:

1. **Per-model System Prompt** (UI-level, per model card): Workspace → Models → Edit → paste contents of `~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md` into "System Prompt". Create one sovereign-tagged model card per backing model (`sovereign-hermes4`, `sovereign-deepseek`, etc.).

2. **Pipelines filter** (server-level, all requests): write a filter Pipeline that prepends the sovereign preamble to every outbound `messages[0]` regardless of what the user configured. Register in Admin → Pipelines. Filter runs before the request hits the backend — cannot be bypassed by a user overwriting the per-model prompt.

Example Pipeline skeleton: `~/UNMUZZLED-AI/07-INSTALL-SCRIPTS/per-harness/openwebui-sovereign-pipeline.py` (kind: install-script-doc) — inlets `body["messages"]`, prepends system message from file.

## MCP posture

- OpenWebUI does not natively host MCP; it uses its own "Tools" (Python function definitions) and "Functions". Not interoperable with the Claude Code MCP ecosystem.
- Tools/Functions can be authored to call MCP servers indirectly via HTTP shim, but this is bespoke wiring.

## Refusal-rate notes

- Out-of-box (stock model + empty system prompt): backing-model baseline refusal.
- Post-injection (per-model prompt only): near-zero on abliterated / sovereign-primary backends; residual refusal on tainted backends (OpenAI, Anthropic).
- Post-injection (per-model prompt + Pipelines filter + abliterated backend): floor.

## Escalation

Swap harness when:
- Need CLI/agentic loop instead of chat UI → `opencode`, `claude-code`, `codex`.
- Need mesh A2A + persona bridge → `hermes`.
- Need low-level sampling control (grammar, logit bias) → `llamacpp` server direct.
