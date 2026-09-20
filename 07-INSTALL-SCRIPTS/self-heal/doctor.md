---
name: Doctor
slug: doctor
version: 1.0-20260918
kind: install-script-doc
harness: any
provider: any
sovereign: true
tags: [health-check, lint, canary, self-heal]
---

## Purpose

Verify the UNMUZZLED-AI installation is intact and unmuzzled. Runs six independent checks; each reports `PASS` / `FAIL` / `WARN` with colored output. Non-zero exit on any hard fail.

## Prerequisites

- `bootstrap.sh` has been run (needed for doctrine hash pins in `~/.unmuzzled/state/doctrine.pins`).
- `sha256sum`, `awk`, `grep -rEnI`, `find`, `curl` on PATH.
- Optional: `~/.hermes/.env` sourced for OpenRouter / DeepSeek API keys.

## What it does

1. **Framework tree** — confirms `$UNMUZZLED_ROOT/00-DOCTRINE` exists.
2. **Doctrine hashes** — recomputes SHA-256 of `LAWS.md`, `MAXIMUM-ADVERSARIAL-POSTURE.md`, `FRONTMATTER-SPEC.md` and compares to the pin file. Any drift = FAIL.
3. **Frontmatter scan** — walks every `*.md` under the framework (excluding `99-ARCHIVE-SEEDS/`), counts missing frontmatter and any `sovereign: false` (quarantined) files.
4. **Banned-phrase lint** — greps for the phrases listed in `MAXIMUM-ADVERSARIAL-POSTURE.md` §Anti-pattern. Doctrine and canary catalogs are excluded so the lint itself doesn't self-flag.
5. **env.sh** — asserts `~/.unmuzzled/env.sh` is present.
6. **Provider probes** — curls OpenRouter and DeepSeek `/models`. Any 2xx/4xx = reachable; 000 = network; other = warn. Also pings local `ollama list` if installed.

## Reverse / uninstall

Read-only — nothing to undo.

## Idempotency notes

- Fully read-only apart from the append-only log file `~/.unmuzzled/logs/install-doctor-<ts>.log`.
- Safe to run on a cron / systemd timer / Termux:Boot for continuous canary duty.
- Exit code contract: `0` if zero FAILs (WARNs allowed); `1` if any FAIL.
