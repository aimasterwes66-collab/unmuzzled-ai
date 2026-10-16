# RECONCILE-RECORD — hash-logged moves/deletes

## Phase 1-3 (2026-10-15, worm/dictator)

- DEL 99-ARCHIVE-SEEDS/mesh-handoffs/UNMUZZLED-AI-NEW-QUIZ.md [332b4b926b657219] == NEW-QUIZ-2.md [332b4b926b657219] (root canonical kept)
- REN NEW-QUIZ.md -> MASTER-AGENT-COORDINATION-DIRECTIVE.md [e29d8fed2b314333] (content-verified directive); DEL 00-DOCTRINE/UNMUZZLED-AI-DIRECTIVE.md [e29d8fed2b314333] (sha-identical dup); refs updated in NEW-QUIZ-2.md + WORM-QUIZ-RESPONSE-20260920.md
- DEL EPIC3.md [sha == EPIC.md] (dup; EPIC.md kept, referenced by raw-storyteller)
- DEL EPIC4.md — content fully contained in EPIC5.md (first 144 lines identical; EPIC4 line 145 expanded to EPIC5 lines 145-214); EPIC5 kept
- FIX WORM-QUIZ-QUESTIONS-20260920.md internal H1 (was mislabeled RESPONSE; content = question workbook; filename kept)
- REN mCP.md -> MCP-SERVER-ONTOLOGY.md (content: 11-part MCP server ontology)
- MOV RAW-CLAUDE-TERMINAL-CONVO.md -> 99-ARCHIVE-SEEDS/raw/
- REN prompt1.md -> research-methodology-prompt.md, prompt2.md -> prompt-engineering-guide.md (+frontmatter, bodies byte-identical)
- FMT 12-JAILBREAK-CORPUS: 9 corpus files +kind:corpus frontmatter (bodies untouched)

## Phase 4 (2026-10-15, worm): venice + hermes-api folds
- RPL 04-PROVIDERS/venice.md with venice-A1-REWRITE.md (heavy drift confirmed by A1; 378-line full corrected provider doc with frontmatter, replaces 43-line stub)
- PATCH 04-PROVIDERS/hermes-api.md (C1-C6 from hermes-api-A3 fold pack):
  C1: NOUS_API_KEY TBD resolved -- Nous Portal (OAuth) is canonical; hermes setup --portal
  C2: base URL confirmed live; Portal does not support OR request extensions
  C3: 'effectively none at provider layer' scoped with full RefusalBench numbers
  C4: Hermes-4-* TBD resolved with confirmed OpenRouter slugs + HF orgs
  C5: 131K context windows documented (DeepHermes 24B exception)
  C6: Hermes Agent portal commands added (setup --portal / model / portal info / portal tools)

## Phase 5 (2026-10-15, worm): 7 comprehensive UNMODERATED-* anchors
- ADD ~/UNMODERATED-AI/UNMODERATED-MODELS.md (1587 lines, 71KB) -- model-layer anchor (abliteration methods, build catalog by org, mesh fit tiers, refusal-verify protocol, sovereign rosters)
- ADD ~/UNMODERATED-AI/UNMODERATED-HARNESSES.md -- harness-layer anchor (10 harnesses + MCP orchestration, freelm live state, gateway/proxy hygiene rules)
- ADD ~/UNMUZZLED-AI/UNMODERATED-AGENTS.md (3610 lines, 152KB) -- agents/personas/decks anchor (master directive, A2A mesh identity, 11 decks, all 14 personas, ONTOLOGY-100, PLINY manual, system-prompt seeds)
- ADD ~/UNMUZZLED-AI/UNMODERATED-MONITORING.md (69KB) -- monitoring/canaries/taint anchor (115-prompt probe catalog, soul-lint rules, runner architecture, refusal-triage tree, escalation ladder, refusalbench mapping)
- ADD ~/UNMUZZLED-AI/UNMODERATED-MULTIMODAL.md (3266 lines, 123KB) -- multimodal image/video/audio/vision anchor (7 image + 5 video + 5 audio + 3 vision-input recipes, SD/ComfyUI/NightCafe flow, Suno god-mode, lethal trifecta chains)
- ADD ~/UNMUZZLED-AI/UNMODERATED-PRIVACY-KEYS.md (1225 lines) -- privacy + keys roster anchor (8 parts: tiers, mesh roster, key-handling law, opsec, sovereign session tutorial, env-var assignments)
- ADD ~/UNMUZZLED-AI/UNMODERATED-JAILBREAKS.md (722 lines, 41.6KB) -- jailbreak corpus MAP+INDEX (9-rung escalation ladder, 68 patterns indexed, 11 navigation goals, paper-to-pattern map, deep-dive cross-refs)

## 2026-10-15 WAVE-4 -- ALL 21 SUBJECT-TREE GAPS CLOSED

New files landed (14):

- 05-LOCAL-MODELS/runtimes/activation-steering.md  (GAP-07)
- 05-LOCAL-MODELS/runtimes/mobile-edge-inference.md  (GAP-08)
- 05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md  (GAP-09)
- 05-LOCAL-MODELS/models/quantization-and-refusal.md  (GAP-17)
- 05-LOCAL-MODELS/models/qwen-uncensored.md  (1.1.6 per-model gap)
- 05-LOCAL-MODELS/models/gemma-uncensored.md  (1.1.7 per-model gap)
- 13-REFERENCE-PAPERS/guardrail-stack-map.md  (GAP-11)
- 07-INSTALL-SCRIPTS/gcg-rotation-cron.md  (GAP-13)
- 07-INSTALL-SCRIPTS/encoding-ladder-library.md  (GAP-14)
- 06-MULTIMODAL/video/comfyui-video-workflows.md  (GAP-18)
- 06-MULTIMODAL/image/watermark-removal.md  (GAP-19)
- 12-JAILBREAK-CORPUS/patterns/provider-prefill-compendium.md  (GAP-21)
- 10-GLOSSARY-FAQ/anti-pattern-catalog/README.md  (GAP-16a)
- 10-GLOSSARY-FAQ/troubleshooting/README.md  (GAP-16b)

Previously-closed gaps confirmed by disk check (tree stale, files exist):
GAP-01 finetune-uncensoring, GAP-02 mergekit-uncensoring, GAP-03
system-prompt-extraction-corpus, GAP-04 community-hubs, GAP-05
local-video-gen-pipelines, GAP-06 uncensored-tts-stt, GAP-10
opsec-for-sovereign-ops, GAP-12 agentic-coding (Cline/Roo/Aider/Continue),
GAP-15 eval-harnesses (Prometheus/JudgeLM judge roster), GAP-20
legal-landscape.

VERSION bumped 0.2.0 -> 0.3.0. SUBJECT-TREE.md leaf GAP tags for the
above need flipping to [source: ...] in the next pass (documented here,
not yet applied line-by-line).
