---
name: Bus-fallback
slug: bus-fallback
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, infra, retry]
---

## Definition

The standard retry pattern when `a2a-send` returns `rc=2 TIMEOUT`: drop a `TO-<peer>-<topic>-<YYYYMMDD>.md` in the Syncthing-replicated bus dropzone with the msgid recorded in frontmatter. Syncthing replicates; peer's file-watcher picks it up asynchronously. Frontmatter field `owed_to_ace: nothing|<action>` is authoritative — do not guess from titles.

## Context

Dropzone: `~/Desktop/Projects/PROJECTS/WES-HERM/04-session-handoffs/`. High-volume — sort by `ls -1t` and filter by prefix. Bus fallback is not failure recovery; it is the normal retry channel.

## See also

- glossary/a2a.md
- glossary/mesh.md
- glossary/syncthing.md
