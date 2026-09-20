---
name: opencode harness wiring
slug: per-harness-opencode
version: 1.0-20260918
kind: install-script-doc
harness: opencode
provider: openrouter
sovereign: true
tags: [install, opencode, agent-deck, openrouter]
---

## Purpose

Configure opencode with the six sovereign agents from `~/opencode-agent-deck/agents/` and route them through OpenRouter's uncensored primaries (Hermes 3 405B/70B, DeepSeek V4 flash, Mistral Large).

## Prerequisites

- `bootstrap.sh` completed.
- opencode CLI installed and on PATH.
- Agent deck present at `/home/dirt/opencode-agent-deck/` (override via `OPENCODE_DECK=`).
- `OPENROUTER_API_KEY` available in `~/.hermes/.env` (or the shell environment).

## What it does

1. Copies six agents into `~/.config/opencode/agents/`: `dictator`, `dark-factory`, `hacker`, `greedy-artist`, `raw-storyteller`, `freeops`.
2. Sources `~/.hermes/.env` for `OPENROUTER_API_KEY`.
3. Backs up any existing `opencode.jsonc` (timestamped) and writes a new one:
   - Registers `openrouter` provider.
   - Aliases four models: `deepseek-v4-flash`, `hermes-3-405b`, `hermes-3-70b`, `mistral-large`.
   - Sets default `model = deepseek-v4-flash`, `small_model = hermes-3-70b`.
   - Binds each of the six agents to a sovereign model (405B for register-heavy roles, DeepSeek for execution/coding).
   - Declares `tainted_models: ["openai/*", "anthropic/claude-*"]` per the Sovereign Canonical Law.
4. Writes a mode-600 env drop-in at `~/.config/opencode/env` containing `OPENROUTER_API_KEY`.
5. Emits `~/.unmuzzled/bin/opencode-unmuzzled` wrapper that sources the drop-in and execs `opencode`.

## Reverse / uninstall

```bash
mv ~/.config/opencode/opencode.jsonc.bak-<ts> ~/.config/opencode/opencode.jsonc
rm -f ~/.config/opencode/agents/{dictator,dark-factory,hacker,greedy-artist,raw-storyteller,freeops}.md
rm -f ~/.config/opencode/env ~/.unmuzzled/bin/opencode-unmuzzled
```

## Idempotency notes

- Agent files are `cp -f` overwrites — deck-source is canonical.
- `opencode.jsonc` is fully rewritten on each run; the prior copy is preserved as `.bak-<ts>`.
- The env drop-in is rewritten each run with mode 0600.
