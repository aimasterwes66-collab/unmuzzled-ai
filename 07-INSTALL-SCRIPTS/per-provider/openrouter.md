---
name: OpenRouter provider wiring
slug: per-provider-openrouter
version: 1.0-20260918
kind: install-script-doc
harness: any
provider: openrouter
sovereign: true
tags: [install, openrouter, credentials, sovereign-primaries, taint]
---

## Purpose

Bring OpenRouter online as a sovereign provider: source the API key from `~/.hermes/.env`, probe reachability, publish the sovereign-primaries manifest, taint the guardrail-tainted routes (`openai/*`, Luna variants, Anthropic API), and drop a `unmuzzled-or` CLI helper that runs one-shot chat completions against Hermes 3 405B with the UNMUZZLED system prompt.

## Prerequisites

- `bootstrap.sh` completed.
- `~/.hermes/.env` contains `OPENROUTER_API_KEY` (the operator's paid `aimasterwes2@gmail.com` account per memory).
- Python 3 and `curl` on PATH.

## What it does

1. Sources `~/.hermes/.env` and hard-fails if `OPENROUTER_API_KEY` is empty.
2. Probes `GET https://openrouter.ai/api/v1/models` with the bearer. 200 = OK; 401/403 = hard fail (rejected); 000/other = warn and continue.
3. Writes `~/.unmuzzled/providers/openrouter/primaries.json`:
   - `sovereign_primaries[]` — Hermes 3 405B/70B, DeepSeek V4 flash, Mistral Large, Dolphin Mixtral 8x22B.
   - `aliases{}` — friendly names (`hermes-3-405b`, `deepseek-v4-flash`, …).
   - `tainted[]` — `openai/*`, `openai/gpt-*`, `openai/*-luna-*`, `anthropic/claude-*`. Enforcement of taint happens at the harness layer (see `opencode.sh`); this manifest is the source of truth.
4. Emits mode-0600 env drop-in `~/.unmuzzled/providers/openrouter/env` with `OPENROUTER_API_KEY`, `OPENROUTER_BASE_URL`, `UNMUZZLED_OPENROUTER_PRIMARY`, `UNMUZZLED_OPENROUTER_FAST`.
5. Installs `~/.unmuzzled/bin/unmuzzled-or` — a Python-in-bash helper that POSTs a chat completion request to the primary with the doctrine as system message.

## Reverse / uninstall

```bash
rm -rf ~/.unmuzzled/providers/openrouter
rm -f  ~/.unmuzzled/bin/unmuzzled-or
```

`~/.hermes/.env` is not modified.

## Idempotency notes

- The primaries manifest and env drop-in are rewritten on every run.
- The reachability probe is advisory when the key is present but network is down — the config is still emitted so a later `doctor.sh` can retry.
- To rotate the key, update `~/.hermes/.env` and re-run this script.
