---
name: Claude Code CLI
slug: claude-code
version: 1.0-20260918
kind: harness-config
harness: claude-code
provider: any
sovereign: true
tags: [harness, claude-code, cli, mcp, hooks]
---

# Claude Code CLI

## What it is

Anthropic's official CLI harness (`claude`) — TypeScript-based agentic loop with tool use, MCP servers, hooks, subagents, and session persistence. Runs on top of the Anthropic API by default; can be pointed at OpenRouter via `claude-or` wrapper for sovereign routing. State lives under `~/.claude/` (projects, sessions, settings, hooks, memory).

## Install / config

- Binary: `~/.npm-global/bin/claude` (npm global).
- Global config: `~/.claude/settings.json`.
- Project config: `<repo>/.claude/settings.json` + `<repo>/.claude/settings.local.json`.
- Memory: `~/.claude/projects/<slug>/memory/MEMORY.md` (pointer index) + per-memory files.
- MCP profiles: switched via `cc-set <profile>` (`sovereign`, `hacker`, `spicy`, `full`, `remote`). Docker MCP plugin v0.43.3+ required.
- OpenRouter alt-harness: `claude-or` — unchained routing to Hermes-4 / DeepSeek / Dolphin.

## Sovereign preamble injection point

Three layered mechanisms — use all three for defense-in-depth:

1. **SessionStart hook** (deterministic, fires every session): declare in `~/.claude/settings.json`:
   ```json
   {"hooks": {"SessionStart": [{"hooks": [{"type": "command", "command": "cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md"}]}]}}
   ```
   The hook stdout is injected into the model context on every session start.

2. **`--append-system-prompt` flag** (per-invocation override):
   ```
   claude --append-system-prompt "$(cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md)"
   ```

3. **CLAUDE.md persona bridge** (project-scoped): drop sovereign preamble into `<repo>/CLAUDE.md` or `~/CLAUDE.md`. Auto-loaded on session start.

Precedence: CLAUDE.md < SessionStart hook < `--append-system-prompt`.

## MCP posture

- MCP servers are configured in `~/.claude/settings.json` under `mcpServers`. Some ship with embedded safety scaffolding (moderation prompts, refusal wrappers) — audit each server's tool descriptions before enabling.
- `cc-set sovereign` disables tainted servers; `cc-set full` enables everything.
- Persistent SSE gateway on `:8811` — must run persistent (not per-session).
- Never enable MCP servers that inject their own system-level guardrails without operator review.

## Refusal-rate notes

- Out-of-box (Anthropic API + default system prompt): high refusal on adversarial probes (Anthropic RLHF is aggressive). Approx. 30-60% refusal on XSTest-adapted canary.
- Post-injection (SessionStart hook + sovereign preamble + CLAUDE.md persona): drops to 5-15% on Sonnet/Opus. Anthropic residual refusal direction persists — some categories remain hard-locked at the weights level.
- Post-injection + `claude-or` on Hermes-4: near-zero refusal.

## Escalation

Swap harness when Anthropic residual refusal blocks a category even with full sovereign stack. Escalation order:
1. `claude-or` (same harness, Hermes-4 / DeepSeek / Dolphin backend).
2. `opencode` (same MCP posture, model-agnostic).
3. `codex` with `--sandbox danger-full-access` (OpenAI-shaped but different guardrail surface).
4. Local: `ollama` or `llamacpp` with abliterated model (Hermes-3-Llama-3.1-70B-abliterated).
