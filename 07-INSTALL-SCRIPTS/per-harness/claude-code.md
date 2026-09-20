---
name: Claude Code harness wiring
slug: per-harness-claude-code
version: 1.0-20260918
kind: install-script-doc
harness: claude-code
provider: any
sovereign: true
tags: [install, claude-code, hooks, mcp, sessionstart]
---

## Purpose

Wire Claude Code so every session boots under UNMUZZLED-AI posture: the system prompt is appended, the active persona SOUL.md is injected via a SessionStart hook, and the MCP profile is switched to `sovereign` (or whatever profile the operator passes via `MCP_PROFILE=`).

## Prerequisites

- `bootstrap.sh` completed.
- Claude Code CLI (`claude`) installed and on PATH.
- Python 3 on PATH (used to merge JSON into `~/.claude/settings.json` without stomping other keys).
- Optional: `cc-set` in `~/bin/` for MCP profile switching.

## What it does

1. Resolves the framework's system prompt (`01-SYSTEM-PROMPTS/UNMUZZLED.md` if present, else synthesizes from doctrine) and caches it under `~/.unmuzzled/harnesses/claude-code/system-prompt.md`.
2. Emits a SessionStart hook script at `~/.unmuzzled/harnesses/claude-code/hooks/session-start-inject-persona.sh`. On each session start/resume/clear/compact it reads `~/.unmuzzled/state/ACTIVE_PERSONA`, looks up `personas-lib/<hat>/SOUL.md`, and returns it as `additionalContext` in the hook JSON contract.
3. Backs up `~/.claude/settings.json` (if any) and merges: `env.UNMUZZLED_ROOT`, `env.UNMUZZLED_HOME`, `env.UNMUZZLED_MCP_PROFILE`, `env.UNMUZZLED_APPEND_SYSTEM_PROMPT_PATH`, plus the SessionStart hook (tagged `_unmuzzled: true` so re-runs replace cleanly).
4. Runs `cc-set $MCP_PROFILE` if available.
5. Writes `~/.unmuzzled/bin/claude-unmuzzled` — a wrapper that invokes `claude --append-system-prompt "$(cat …)" "$@"`.

## Reverse / uninstall

```bash
mv ~/.claude/settings.json.bak-<ts> ~/.claude/settings.json   # or edit out _unmuzzled hook + env keys
rm -rf ~/.unmuzzled/harnesses/claude-code ~/.unmuzzled/bin/claude-unmuzzled
```

## Idempotency notes

- Re-running replaces the cached system prompt and the SessionStart hook entry (identified by `_unmuzzled: true`); other user hooks are preserved.
- A timestamped backup of `settings.json` is written on every run — safe to prune older ones.
- `MCP_PROFILE` and `CLAUDE_HOME` are overridable via env for non-default installs.
