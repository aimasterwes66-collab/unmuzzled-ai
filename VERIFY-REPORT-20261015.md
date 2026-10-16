---
sovereign: true
title: verify-report-2026-10-15
type: reference
agent: worm
status: active
tags: [verify, audit, reconcile, 2026-10-15]
---

# VERIFY-REPORT -- 2026-10-15 reconcile audit

## Summary

GREEN. All 8 UNMODERATED-* anchors present, non-empty, frontmatter correct.
170 deep-reference cross-links added, all targets resolve. 13 wave-3 gap-fillers
all present, non-empty. Zero empty files. HEAD == origin/main.

## What was verified

1. **8 UNMODERATED-* anchors -- present + non-empty + frontmatter**
   - UNMODERATED-MODELS.md (1587 lines, 71 KB)
   - UNMODERATED-HARNESSES.md (1982 lines, 85 KB)
   - UNMODERATED-AGENTS.md (3610 lines, 156 KB)
   - UNMODERATED-MONITORING.md (1601 lines, 69 KB)
   - UNMODERATED-MULTIMODAL.md (3266 lines, 124 KB)
   - UNMODERATED-PRIVACY-KEYS.md (1225 lines, 59 KB)
   - UNMODERATED-JAILBREAKS.md (722 lines, 42 KB)
   - 04-PROVIDERS/UNMODERATED-INFERENCE.md (577 lines, 23 KB) -- frontmatter added in this verify pass

2. **Cross-link targets** -- all 8 anchor filenames referenced by the
   `## Deep reference` sections (170 files) exist on disk.

3. **Frontmatter coverage per section** (after the INFERENCE fix):
   - 01-SYSTEM-PROMPTS, 02-PERSONAS, 03-HARNESSES, 05-LOCAL-MODELS,
     06-MULTIMODAL, 07-INSTALL-SCRIPTS, 08-DECISION-TREES, 09-EDUCATIONAL,
     10-GLOSSARY-FAQ, 12-JAILBREAK-CORPUS, 13-REFERENCE-PAPERS: 100%
   - 04-PROVIDERS: 18/19 = 95% (1 NOFM = UNMODERATED-INFERENCE pre-fix; fixed)
   - 11-DETECTION-CANARIES: 8/9 = 89% (1 NOFM = runner/README.md, intentional brief index)
   - 00-DOCTRINE: 16/20 = 80% (4 NOFM = LAWS.md, LAWS-research-appendix.md,
     ONT-15x15-UNMUZZLED-AI.md, SOURCE-SURVEY.md -- ALL intentional per doctrine:
     canonical law + raw survey/ontology seeds, no frontmatter by design)

4. **Empty files** -- zero (no write failures).

5. **Wave-3 gap-fillers** -- all 13 present, non-empty, line counts 827-2974.

6. **Git state** -- 9 commits in main, HEAD af26283 == origin/main, rebased clean.

7. **Duplicate SHA-256 (intentional provenance, not a gap)**:
   - 11 sha-256 collisions in 99-ARCHIVE-SEEDS/, all between the canonical
     agent-deck location and a provenance copy (e.g. agents/dark-factory.md
     == opencode-agent-deck/agents/dark-factory.md). Archive = multiple
     locations by design for seed provenance. NOT a dedup target.

## Frontmatter gap closed this pass

- 04-PROVIDERS/UNMODERATED-INFERENCE.md -- added type: provider + tags
  block to match the house style. Was the only real frontmatter gap.

## Final state

- 446 .md files, 485 total files
- 9 commits, HEAD af26283
- Triple-locked: local git + GitHub origin + GDrive fold-pack snapshot
- Reconcile complete: subject-tree coverage = comprehensive, no
  distillation, all lists/tables/URLs preserved verbatim from sources
