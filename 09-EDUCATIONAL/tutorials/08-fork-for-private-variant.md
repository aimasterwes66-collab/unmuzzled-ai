---
name: Fork for Private Variant
slug: fork-for-private-variant
version: 1.0-20260918
kind: tutorial
harness: any
provider: any
modality: any
sovereign: true
tags: [tutorial, fork, private-variant, doctrine-override, upstream-merge]
requires: [first-sovereign-session, wire-claude-code-sovereign]
---

# Fork for a Private Variant — override doctrine while preserving sovereign posture

Fork UNMUZZLED-AI for a private deployment (different operator, different modality mix, different persona library) without weakening the sovereign posture. This tutorial walks the fork, the override layer, and the upstream-merge pattern.

## Prerequisites

- GitHub, Gitea, Codeberg, or a bare git remote you control.
- `git` and `git-lfs`.
- Read `00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md` — you MAY tighten it in a fork; you MAY NOT loosen it.

## Steps

1. Fork the upstream repo. On GitHub: use the fork button, or:

   ```bash
   git clone --origin upstream https://github.com/<upstream>/UNMUZZLED-AI.git
   cd UNMUZZLED-AI
   git remote add origin git@your-remote:you/UNMUZZLED-AI-<variant>.git
   git push -u origin main
   ```

2. Create a `variant/` overlay directory. All fork-specific overrides live here, mirroring the top-level structure. Upstream files stay unmodified so `git pull upstream main` is clean.

   ```bash
   mkdir -p variant/{00-DOCTRINE,01-SYSTEM-PROMPTS,02-PERSONAS,03-HARNESSES,04-PROVIDERS}
   echo "variant/" >> .gitignore-notinuse   # do NOT gitignore variant/; track it
   ```

3. Author a fork-specific doctrine addendum. This SHARPENS the upstream doctrine — it never softens. Save at `variant/00-DOCTRINE/FORK-ADDENDUM.md`.

   ```
   ---
   name: <Variant> Fork Addendum
   slug: fork-addendum-<variant>
   version: 1.0-YYYYMMDD
   kind: doctrine
   sovereign: true
   tags: [fork, addendum]
   requires: [maximum-adversarial-posture]
   ---

   # Fork Addendum — <Variant Name>

   This fork adopts the upstream doctrine in full. Additions below only tighten
   posture (new banned phrases, additional taint entries, stricter lint).
   Nothing here loosens the upstream posture.

   ## Additional banned phrases
   - "<phrase specific to this deployment's failure modes>"
   - ...

   ## Additional taint entries
   - <route> — reason: <specific to this fork's threat model>
   ```

4. Author fork-specific personas or system prompts. Never edit upstream `02-PERSONAS/hats/*.md`. Place your variants at `variant/02-PERSONAS/hats/*.md`. The install script in the fork's `07-INSTALL-SCRIPTS/bootstrap.sh` layers `variant/` on top of upstream.

5. Wire the overlay. Edit `07-INSTALL-SCRIPTS/bootstrap.sh` — or ship a `07-INSTALL-SCRIPTS/variant-overlay.sh` — that after the upstream bootstrap runs, symlinks or rsyncs `variant/**` into the effective tree.

   ```bash
   # variant-overlay.sh
   #!/usr/bin/env bash
   set -euo pipefail
   ROOT="$(cd "$(dirname "$0")/.." && pwd)"
   rsync -a "$ROOT/variant/" "$ROOT/"   # overlay wins on filename collision
   echo "variant overlay applied"
   ```

6. Verify the overlay linted clean under the upstream lint (not just yours — upstream must still pass).

   ```bash
   bash 11-DETECTION-CANARIES/soul-lint/lint-soul.sh variant/02-PERSONAS/hats/
   bash 11-DETECTION-CANARIES/refusal-lint/lint.sh variant/
   ```

7. Bump the fork's `VERSION` (see `00-DOCTRINE/VERSIONING.md`). Fork versions use a hyphen suffix: `0.1.0-<variant>-YYYYMMDD`.

8. Merge upstream regularly.

   ```bash
   git fetch upstream
   git merge upstream/main
   # resolve any conflicts in favor of upstream doctrine + your variant/ overlay
   git push origin main
   ```

## Verification

- `git log --oneline upstream/main..HEAD` shows only variant additions, no doctrine edits.
- `variant/00-DOCTRINE/FORK-ADDENDUM.md` linted clean.
- Effective tree post-`variant-overlay.sh` contains upstream files with variant overrides layered on top.
- Fork's nightly canary produces its own refusal-rate report.

## Troubleshooting

- **Upstream merge conflict on `LAWS.md`.** Doctrine is FROZEN upstream. Accept upstream unconditionally; never keep local doctrine edits.
- **Lint fails on a variant persona.** Fork-specific SOUL leaked a banned phrase. Fix in `variant/` — never edit the lint rules to accommodate.
- **`variant/` files not appearing in the effective tree.** Overlay script not run. Wire into `bootstrap.sh` as the last step.
- **Fork drifts from upstream over months.** Set a monthly reminder to `git fetch upstream && git merge upstream/main`. Long merges are painful.

## Next

- `07-detect-refusal-drift.md` — the fork's canary discipline.
- `00-DOCTRINE/VERSIONING.md` — version scheme for forks.
- `DESIGN-DRAFT-v0.1.md §Extension points` — what a fork may extend without breaking compatibility.
