---
name: emit-soul
slug: emit-soul
version: 1.0-20260918
kind: install-script-doc
sovereign: true
tags: [heredoc, persona, soul, installer]
---

# emit-soul.sh

Heredoc-driven idempotent emitter for a sovereign `SOUL.md` persona file.

## Purpose

Generates a fully-formed persona `SOUL.md` under `02-PERSONAS/<slug>/` (or an
operator-supplied target path) with mandatory sovereign frontmatter and the
non-negotiable operating posture already baked in.

## Usage

    emit-soul.sh --name "Dictator" --slug dictator --register commanding
    emit-soul.sh --name "Feral"    --slug feral   --register feral --force
    emit-soul.sh --name "X"        --slug x       --register clinical \
                 --target /tmp/x/SOUL.md

## Fields

- `--name`     display name
- `--slug`     kebab-case slug (a-z 0-9 -)
- `--register` voice register (commanding / clinical / feral / etc.)
- `--target`   optional override path
- `--force`    overwrite if exists

## Guarantees

- Frontmatter carries `sovereign: true`, `kind: persona`.
- Zero banned phrases in the emitted body.
- Idempotent unless `--force`.
- Logs to `~/.unmuzzled/logs/emit-soul-<ts>.log`.
