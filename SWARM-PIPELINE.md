# SWARM-PIPELINE — UNMUZZLED-AI reconcile swarm

Orchestrator: worm (dictator hat) — this session owns all git writes.
Topology: 1 orchestrator -> 4 team leads -> 12+ tightly-scoped workers.
Every worker: <=3 skills, one deliverable set, no git, no cross-writes.

## Waves
- WAVE 1 (10 parallel workers): research + fold packs + new files
  - A1 venice-verify      (web_search, web_extract, write_file)
  - A2 free-providers     (web_search, web_extract, write_file)  -> novita/hyperbolic/pollinations/zai
  - A3 nous-nim           (web_search, web_extract, write_file)  -> nous-portal/nemotron-nim
  - A4 privacy-keys       (read_file, write_file)                -> e2ee-privacy-tiers/keys-roster (fingerprints only)
  - B1 fold-inference     (read_file, write_file)                -> fold packs from UNMODERATED-INFERENCE
  - B2 fold-edition       (read_file, write_file)                -> fold packs from AI-UNMUZZLED-EDITION
  - C1 harnesses          (read_file, write_file)                -> freelm/sillytavern
  - C2 heretic-builds     (web_search, web_extract, write_file)  -> models/heretic-builds
  - C3 ref-chains         (read_file, write_file)                -> refusalbench/fallback-chains
  - A5 gap-scan           (read_file, write_file)                -> gaps addendum
- WAVE 2 (6): 4 team-lead reviewers (research/fold/harness/verify) +
  merge-archivist (applies fold packs, archives compendia) + D1 verify
  (digest re-run, frontmatter lint, hash diff vs RECONCILE-RECORD).
- WAVE 3 (2): D2 index/README update -> orchestrator commit + push.

## Frontmatter law (every new/edited file)
---
title: <kebab>
type: <provider|harness|reference|decision-tree|model|doctrine|prompt|corpus>
agent: worm
status: active
tags: [kebab, tags]
---
ASCII only. No CJK. Kebab filenames. Cite [source: url]. Unknown = say unknown.
Fold packs live in ~/.hermes/cache/scratch/unmuzzled-pass/folds/ until merged.

## FINAL STRUCTURE (operator order)
Numbered skeleton stays. Every layer covered -- not just 04-PROVIDERS.
PLUS one comprehensive all-caps ANCHOR doc per layer at root:
UNMODERATED-MODELS.md, UNMODERATED-HARNESSES.md, UNMODERATED-AGENTS.md,
UNMODERATED-MONITORING.md, UNMODERATED-MULTIMODAL.md,
UNMODERATED-PRIVACY-KEYS.md, UNMODERATED-JAILBREAKS.md
(+ UNMODERATED-INFERENCE.md stays in 04-PROVIDERS).
Anti-redundancy rule: anchors carry comprehensive content (fold packs merge
into them verbatim); fine-grained section files stay lean how-tos and link to
anchors. No content duplicated between anchor and section file -- link, don't
copy. No distilled summaries anywhere.

## PRESERVE LAW (operator order, overrides all length caps)
This pass is sort/reorganize/rename/consolidate -- NOT distillation.
No summarizing away content. Every list, table, endpoint, price line, prompt
block and section in every source file survives VERBATIM somewhere in the
merged output. Fold packs carry FULL text, not bullet digests. Length caps
are lifted on all deliverables. When in doubt: include, do not compress.
