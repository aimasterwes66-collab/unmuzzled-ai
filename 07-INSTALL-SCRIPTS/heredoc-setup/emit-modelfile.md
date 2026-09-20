---
name: emit-modelfile
slug: emit-modelfile
version: 1.0-20260918
kind: install-script-doc
sovereign: true
tags: [heredoc, ollama, modelfile, installer]
---

# emit-modelfile.sh

Heredoc-writes an Ollama `Modelfile` with a sovereign `SYSTEM` directive and
optional embedded persona from a SOUL.md.

## Usage

    emit-modelfile.sh --base hermes3:70b --tag hermes3-sovereign
    emit-modelfile.sh --base dolphin3:8b --tag dolphin3-dictator \
                      --persona-file $UNMUZZLED_ROOT/02-PERSONAS/dictator/SOUL.md \
                      --temperature 0.9 --ctx 16384

## Output

Default target: `~/.unmuzzled/modelfiles/<tag>.Modelfile`. Load with:

    ollama create <tag> -f ~/.unmuzzled/modelfiles/<tag>.Modelfile

The emitted SYSTEM block is free of banned phrases and pre-encodes the
refusal-free posture.
