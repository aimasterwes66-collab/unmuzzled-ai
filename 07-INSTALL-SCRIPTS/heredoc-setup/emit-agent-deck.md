---
name: emit-agent-deck
slug: emit-agent-deck
version: 1.0-20260918
kind: install-script-doc
sovereign: true
tags: [heredoc, opencode, agent-deck, installer]
---

# emit-agent-deck.sh

Heredoc-writes an opencode agent deck entry under `<deck-dir>/<slug>/agent.md`
(default deck: `~/opencode-agent-deck/`).

## Usage

    emit-agent-deck.sh --name "Dictator" --slug dictator \
                       --provider openrouter \
                       --model nousresearch/hermes-4-70b \
                       --persona-file $UNMUZZLED_ROOT/02-PERSONAS/dictator/SOUL.md

## Fields

`--name`, `--slug`, `--provider`, `--model`, optional `--persona-file`,
`--deck-dir`, `--force`.

Frontmatter carries `kind: agent-deck`, `sovereign: true`, and the model +
persona wiring for opencode to resolve at load time.
