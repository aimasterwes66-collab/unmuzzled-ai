---
name: UNMUZZLED-AI Versioning
slug: versioning
version: 1.0
date: 2026-09-18
kind: doctrine
sovereign: true
tags: [versioning, semver, dates]
---

# UNMUZZLED-AI — Versioning

## Framework version

Root: `~/UNMUZZLED-AI/VERSION` (single line, semver: `0.1.0`).

- `MAJOR` — breaking rearrangement of top-level layout or frontmatter schema.
- `MINOR` — new top-level folder, new required frontmatter field.
- `PATCH` — new content within existing structure.

## File-level version

Two acceptable formats in frontmatter `version:`:

1. Semver: `1.0`, `1.2`, `2.0-rc1`
2. Date: `2026-09-18`
3. Hybrid: `1.0-20260918` (semver + date suffix)

Immutable seed archives (`99-ARCHIVE-SEEDS/`) do NOT get re-versioned; their
`version:` records the source-file's original date/version.

## Doctrine files (00-DOCTRINE/*)

Doctrine files version by both semver AND date. Text of `LAWS.md §§0-3` and
`MAXIMUM-ADVERSARIAL-POSTURE.md §Posture Statement` are FROZEN — changes
require MAJOR bump AND an explicit operator directive to unfreeze.

## Extension log

Append-only. Each new folder / new frontmatter field / new banned phrase gets
a dated line in `~/UNMUZZLED-AI/EXTENSIONS.log`.

## Current version

Root VERSION: `0.1.0` (skeleton + doctrine + 26 seed archives).
