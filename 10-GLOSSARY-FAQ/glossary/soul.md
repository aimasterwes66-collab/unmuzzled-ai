---
name: SOUL
slug: soul
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, persona, identity-file]
---

## Definition

The identity-defining markdown file (`SOUL.md`) at the root of a persona directory. Contains the persona's self-model, stance, method, and non-negotiable operational directives. Loaded verbatim into the model's system-prompt context at session start via the persona bridge. If a SOUL contains any softening clause, hedge, or corporate-guardrail phrasing, it fails sovereign lint and is quarantined.

## Context

Every hat in `~/.hermes/personalities/personal/<name>/` has a SOUL.md. Detecting soft-edits: hash it and compare against a pinned canonical hash. The dictator, dark-factory, and general-sovereign SOULs are the load-bearing exemplars.

## See also

- glossary/deck.md
- glossary/persona.md
- glossary/sovereign.md
- 02-PERSONAS/
