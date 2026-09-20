---
name: Banned-Phrase Lint Rule
slug: banned-phrases-lint
version: 1.0-20260918
kind: canary
harness: any
provider: any
modality: text
sovereign: true
tags: [lint, banned-phrases, ci, static-analysis]
requires: [maximum-adversarial-posture]
---

# Banned-Phrase Lint Rule

## Purpose

Static-content lint over every SOUL.md, agent deck, system prompt, install-script
comment, glossary entry, and tutorial in UNMUZZLED-AI. Any file containing a
phrase from `banned-phrases.txt` fails the lint. The definitive phrase list is
extracted from `00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md §Anti-pattern lint`
and extended with the soft-refusal / hedge patterns catalogued in
`LAWS-research-appendix.md §6`.

## Source of truth

`banned-phrases.txt` — one phrase per line, no frontmatter, no comments. Case-insensitive
match. Whitespace-normalized. Substrings match (a banned phrase inside a longer
sentence still fails).

## Runner

`lint-soul.sh <dir>` walks a directory tree, greps every `.md` for every phrase,
exits non-zero on any hit and prints `FILE:LINE:PHRASE`. Idempotent — safe to
run in CI pre-merge and in nightly cron.

## CI wiring

Invoked by `doctor.sh` under `--check-sovereignty` mode. Also intended for:
- `ace doctor --check-sovereignty` (hermes personality manager)
- Git pre-commit hook in the UNMUZZLED-AI repo
- Nightly promptfoo run against `refusal-probes/`
- `cc-set` profile switch preflight

## Extending

Adding a phrase requires appending it to `banned-phrases.txt`. Never remove a
phrase without operator sign-off documented on the bus with `owed_to_ace: revert_and_document`.
Softening the list is not permitted.

## Related

- Runtime probe set: `../refusal-probes/`
- Runner: `../runner/run-canaries.sh`
- Doctrine root: `../../00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md`
