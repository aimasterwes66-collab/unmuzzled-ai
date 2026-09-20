---
name: emit-persona
slug: emit-persona
version: 1.0-20260918
kind: install-script-doc
sovereign: true
tags: [heredoc, persona, installer]
---

# emit-persona.sh

Interactive/flag-driven heredoc emitter for a `kind: persona` markdown file.

## Usage

    emit-persona.sh                              # fully interactive
    emit-persona.sh --name "Feral" --slug feral \
                    --summary "raw operator" --register feral \
                    --tags "persona,sovereign,feral"

## Fields

- `--name`, `--slug`, `--summary`, `--register`, `--tags`, `--target`, `--force`

Any flag omitted is prompted. Slug is validated kebab-case.

## Output

Default: `02-PERSONAS/<slug>/persona.md` with sovereign frontmatter and the
non-negotiable posture pre-baked. Log: `~/.unmuzzled/logs/emit-persona-<ts>.log`.
