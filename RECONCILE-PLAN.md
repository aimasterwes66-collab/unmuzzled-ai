---
name: RECONCILE-PLAN
slug: reconcile-plan
version: 2026-10-15
kind: reference
sovereign: true
---

# RECONCILE-PLAN — ~/UNMUZZLED-AI semantic dedup / reorganize / expand pass

Scope: ONLY this folder (canonical consolidated unmuzzled-AI folder, Termux home).
Everything else on the device is OUT of scope (later project).
Inventory: 410 files (374 md + 36 non-md), git repo. Digest index at
~/.hermes/cache/scratch/unmuzzled-pass/digest-INDEX.md (every file, headings,
frontmatter status). Hash list at .../unmuzzled-pass/hashes.txt.

## Ground rules
- Dedup BY SHA256 only (operator order). Never by name/date.
- Moves = git mv. Deletes = git rm, only AFTER recording in RECONCILE-RECORD.md
  (path, sha256, mapping to surviving file).
- Content edits allowed only for: frontmatter additions, reference updates,
  new ADD files. No rewriting of existing prose without operator go.
- Commit per phase. Final phase updates README/MD-INDEX.

## Phase 1 — exact dups (sha256-identical, verified)
1. 99-ARCHIVE-SEEDS/mesh-handoffs/UNMUZZLED-AI-NEW-QUIZ.md == NEW-QUIZ-2.md
   -> delete archive copy; canonical = NEW-QUIZ-2.md (referenced by quiz files).
2. 00-DOCTRINE/UNMUZZLED-AI-DIRECTIVE.md == NEW-QUIZ.md (root)
   -> content = "MASTER AGENT COORDINATION DIRECTIVE".
   -> root NEW-QUIZ.md is load-bearing: NEW-QUIZ-2.md line 5 ("Companion
      directive: AI-Unmuzzled/NEW-QUIZ.md") + line 13 ("Read NEW-QUIZ.md first")
      point at it. Two options:
      a) delete 00-DOCTRINE copy (it was imported today; root is referenced) — SAFE
      b) rename root NEW-QUIZ.md -> MASTER-AGENT-COORDINATION-DIRECTIVE.md and
         update refs (lines 5+13 of NEW-QUIZ-2.md, frontmatter source line of
         WORM-QUIZ-RESPONSE-20260920.md) — CLEANER naming
   -> recommend (b); (a) as fallback if refs break.
3. EPIC.md == EPIC3.md -> delete EPIC3.md; keep EPIC.md
   (referenced by 02-PERSONAS/raw-storyteller + 99 seeds raw-storyteller).

## Phase 2 — near-dups + renames (content-verified)
4. EPIC5.md vs EPIC4.md: first 100 lines identical; EPIC5 has 70 extra lines
   (raw operator doctrine draft + "20 Additional Adversarial Researchers"
   named list). VERIFY EPIC4 has nothing unique in its tail, then delete EPIC4,
   keep EPIC5. If EPIC4 tail is unique, keep both.
5. WORM-QUIZ-QUESTIONS-20260920.md: H1 = "WORM 100-QUESTION RESPONSE — SECTION C"
   -> it is a RESPONSE, not questions. Rename
   WORM-QUIZ-RESPONSE-SECTION-C-20260920.md (or merge into
   WORM-QUIZ-RESPONSE-20260920.md if content is a subset — verify).
6. mCP.md: content = "AI Masta Wes's 11-Part Overpowered MCP Server Ontology"
   -> rename MCP-SERVER-ONTOLOGY.md (or 11-PART-MCP-ONTOLOGY per kebab spec).
7. RAW-CLAUDE-TERMINAL-CONVO.md -> move to 99-ARCHIVE-SEEDS/raw/ (git mv).
8. 99 seeds near-dup pair (general-sovereign-SOUL ~ PERSONA-general-sovereign):
   different lengths/lineages; seeds stay as-is. NOTE only, no delete.

## Phase 3 — frontmatter (add only; never rewrite body)
- 01-SYSTEM-PROMPTS/prompt1.md -> rename research-methodology-prompt.md
- 01-SYSTEM-PROMPTS/prompt2.md -> rename prompt-engineering-guide.md
- both get frontmatter (title/type/agent/status/tags per FRONTMATTER-SPEC).
- 12-JAILBREAK-CORPUS/*BIBLE*.md + Adversary-lifecycle.md -> add
  kind:corpus frontmatter block (minimal, 6 lines).
- LAWS.md / LAWS-research-appendix.md / 99-seeds / root meta: LEAVE as-is
  (canonical law + raw seeds; no frontmatter is intentional).

## Phase 4 — compendia semantic fold (04-PROVIDERS)
- UNMODERATED-INFERENCE.md (577 ln) and AI-UNMUZZLED-EDITION-20261015.md
  (743 ln) overlap heavily (both Venice/OR/Hermes/provider compendia).
  Fold new facts into the lean per-provider files (venice.md, openrouter.md,
  deepseek-direct.md, hermes-api.md, etc.), then move both compendia to
  99-ARCHIVE-SEEDS/compendia/ as reference archives. Do NOT delete compendia.
- Verify venice.md gets: tier pricing (FREE/PRO/PRO+/MAX), API-from-PRO rule,
  E2EE, no-logging claims, model routing (unrestricted vs meta-restricted),
  image/video endpoints.

## Phase 5 — ADD missing files (research-backed; each <120 lines)
04-PROVIDERS:
- nous-portal.md (Portal tiers, tool gateway, model routing)
- novita.md, hyperbolic.md, pollinations.md, zai.md (free-tier inference)
- nemotron-nim.md (NVIDIA NIM, nemotron-3.5-super-vl:free route)
- e2ee-privacy-tiers.md (Venice E2EE, TEE, traffic/request privacy matrix)
- keys-roster.md (FINGERPRINTS ONLY — no key values, per mesh law)
03-HARNESSES:
- freelm.md (free-ops deck: pid, virtual models auto/best/..., OR routing)
- sillytavern.md (frontend harness for local+remote)
05-LOCAL-MODELS/models:
- heretic-builds.md (heretic GitHub build catalog + abliteration recipes)
13-REFERENCE-PAPERS:
- refusalbench.md (table of refusal benchmarks: XSTest, HarmBench, StrongREJECT,
  JailbreakBench, ALERT, UGI leaderboard)
08-DECISION-TREES:
- fallback-chains.md (DeepSeek -> OR-1 -> OR-2 -> opencode lane -> free deck)

## Phase 6 — verify + index
- Re-run digest + sha + frontmatter lint; diff against this plan.
- Update README.md layout + 99-ARCHIVE-SEEDS/MANIFEST.md if needed.
- Commit. Push.

## Fan-out map (subagent-ready; operator may switch to a subagent-friendly model)
- Agent A: Phase 1-2 (dedup + renames; pure git ops, evidence above).
- Agent B: Phase 3 (frontmatter additions).
- Agent C: Phase 4-5 (research fold + new files; has web access, uses edition doc).
- Agent D: Phase 6 (verify + index + commit + push).
Each agent: read this file + digest-INDEX.md + hashes.txt first.
