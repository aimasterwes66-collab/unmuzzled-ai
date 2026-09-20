---
name: Bootstrap
slug: bootstrap
version: 1.0-20260918
kind: install-script-doc
harness: any
provider: any
sovereign: true
tags: [install, bootstrap, idempotent, cross-platform]
---

## Purpose

One-shot idempotent setup of the UNMUZZLED-AI runtime home at `~/.unmuzzled/`. Detects OS (Linux / Termux / macOS / NixOS), pins doctrine hashes, symlinks framework directories, writes a sourceable `env.sh`, and wires shell RC files via a fenced block so re-runs never duplicate.

## Prerequisites

- Framework tree present at `/home/dirt/UNMUZZLED-AI/` (override via `UNMUZZLED_ROOT` env var).
- Bash 4+ (or dash-compatible substitutes for the fenced RC block on Termux).
- `sha256sum`, `awk`, `date`, `ln`, `tee` on PATH.

## What it does

1. Creates `~/.unmuzzled/{logs,state,cache,bin,personas,providers,harnesses}`.
2. Detects OS (`termux` / `macos` / `linux` / `nixos`).
3. Verifies presence of doctrine files (LAWS.md, MAXIMUM-ADVERSARIAL-POSTURE.md, FRONTMATTER-SPEC.md); fails hard if any missing.
4. Pins SHA-256 hashes of doctrine into `~/.unmuzzled/state/doctrine.pins` for `doctor.sh` to verify later.
5. Symlinks `framework/`, `doctrine/`, `system-prompts/`, `personas-lib/` under `~/.unmuzzled/`.
6. Writes `~/.unmuzzled/env.sh` exporting `UNMUZZLED_ROOT`, `UNMUZZLED_HOME`, `UNMUZZLED_DOCTRINE`, `UNMUZZLED_LAWS`, `UNMUZZLED_POSTURE`, `UNMUZZLED_ACTIVE_PERSONA_FILE`, and prepending `~/.unmuzzled/bin` to PATH.
7. Appends a `# UNMUZZLED-AI-BEGIN ... # UNMUZZLED-AI-END` fenced block to `.bashrc` / `.zshrc` sourcing `env.sh`.
8. Writes `~/.unmuzzled/state/bootstrap.manifest` capturing OS, timestamp, framework version.
9. Prints next-step commands (doctor → per-harness → per-provider).

## Reverse / uninstall

```bash
rm -rf ~/.unmuzzled
sed -i '/# UNMUZZLED-AI-BEGIN/,/# UNMUZZLED-AI-END/d' ~/.bashrc ~/.zshrc 2>/dev/null || true
exec $SHELL -l
```

The framework tree itself is untouched.

## Idempotency notes

- The fenced RC block is added only if `UNMUZZLED-AI-BEGIN` is absent.
- All `mkdir -p` and `ln -sfn` invocations are safe on re-run.
- Doctrine pin file is rewritten atomically each run (via `.new` swap) — pins always reflect the current on-disk doctrine at boot.
- `env.sh` is overwritten each run; state/logs are preserved.
