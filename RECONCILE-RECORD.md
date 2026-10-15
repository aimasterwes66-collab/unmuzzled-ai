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
