---
name: UNMUZZLED-AI Handoff to Codex
slug: handoff-codex-20260918
version: 2026-09-18
kind: doctrine
sovereign: true
tags: [handoff, codex, resume-point, gap-list]
---

# UNMUZZLED-AI — Handoff (Claude Code → Codex, 2026-09-18)

Framework skeleton is at v0.1.0, doctrine solid, most content folders seeded. Claude Code hit the extra-usage cap mid-swarm; several agents returned "You're out of extra usage · resets 8:20am (America/Los_Angeles)" before writing their deliverables. This doc captures what's DONE, what's PARTIAL, what's MISSING, and exact next steps so Codex can finish without quality loss.

## State snapshot

- Root: `/home/dirt/UNMUZZLED-AI/`  VERSION `0.1.0`
- Read first (in this order): `CLAUDE.md`, `00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md`, `00-DOCTRINE/FRONTMATTER-SPEC.md`, `00-DOCTRINE/LAWS.md`, `00-DOCTRINE/UNMUZZLED-AI-MASTER-PLAN-20260918.md`, `00-DOCTRINE/DESIGN-DRAFT-v0.1.md`.
- Mesh: ACE (this box) up, WORM up, HERM S22 DOWN since ~03:25 PDT 2026-09-18 (needs physical wake).
- Bus post already sent to WORM: `~/Desktop/Projects/PROJECTS/WES-HERM/04-session-handoffs/TO-WORM-ace-unmuzzled-ai-underway-20260918.md`.

## DONE (verified on disk)

**Doctrine (`00-DOCTRINE/`)**
- `LAWS.md`, `LAWS-research-appendix.md` — mirrored from `~/Desktop/PROJECTS/UNCENSOR-LLMS/`
- `MAXIMUM-ADVERSARIAL-POSTURE.md` — no-caveats doctrine root + banned-phrase lint
- `FRONTMATTER-SPEC.md`, `VERSIONING.md`, `UNMUZZLED-AI-MASTER-PLAN-20260918.md`, `SOURCE-SURVEY.md`
- `ONT-15x15-UNMUZZLED-AI.md` (225 atoms, mirrored to `~/.ontfix/ont/UNMUZZLED-AI.md`)
- `ONT-20x20-UNMUZZLED-AI-MASTER-ATLAS.md` (400 atoms, 7568 words, 20 parts)
- `ONTFIX-14-unmuzzled-ai/{01..05}.md` (14-size 5-part fix set, mirror of `~/.ontfix/unmuzzled-ai/`)
- `MD-INDEX.md` — 1966 markdown files indexed, 99 HIGH / 151 MED
- `DESIGN-DRAFT-v0.1.md` — 446 lines, first-draft framework design

**Seeds (`99-ARCHIVE-SEEDS/`)**
- 26 canonical seeds copied (mtime preserved) with `MANIFEST.md` (sha256). READ ONLY.
- Layout: `agents/` (11 opencode decks), `system-prompts/` (7), `hermes-souls/` (3), `herm-mirror-masterworks/` (5).

**Populated content folders**
- `02-PERSONAS/` — 14 persona `.md` files distilled from seeds (dictator, dark-factory, hacker, greedy-artist, raw-storyteller, freeops, art-director, worm, scraper, suno-god-mode, frontend, general-sovereign, plus hermes-soul variants)
- `05-LOCAL-MODELS/runtimes/` — ollama, lmstudio, llamacpp, vllm, exllamav2 (5 files)
- `07-INSTALL-SCRIPTS/` — `bootstrap/bootstrap.sh`+`.md`, `self-heal/doctor.sh`+`.md`, `per-harness/{claude-code,opencode,ollama,lmstudio}.sh`+`.md`, `per-provider/openrouter.sh`+`.md`
- `08-DECISION-TREES/` — 4 mermaid flowcharts: escalation-ladder, provider-selection, harness-selection, refusal-triage
- `09-EDUCATIONAL/mindmaps/framework-atlas.md` — mermaid mindmap
- `10-GLOSSARY-FAQ/glossary/` — 20 entries (jailbreak, abliteration, gcg-suffix, refusal-rate, sovereign, harness, soul, dpo, rlhf, orthogonalization, many-shot, godmode, format-hijack, hypothetical-framing, transformer-lens, taint-list, jailbreakbench, syncthing, bus-fallback, bijection-learning). FAQ subfolder — verify count.
- `11-DETECTION-CANARIES/` — `refusal-probes/{xstest-adapted, harmbench-adapted, identity-probe, banned-phrase-probe}.md`, `soul-lint/{banned-phrases.txt, banned-phrases.md, lint-soul.sh}`, `runner/{run-canaries.sh, runner.md}`, `README.md`
- `12-JAILBREAK-CORPUS/patterns/` — 20 pattern files (many-shot-jailbreak, gcg-suffix, base64-encoding, crescendo, prefill-only, boundary-inversion, negation-inversion, absolute-identity-lock, sovereign-default, yolo-mode, reflection-attack, tool-coercion, vision-image-transcription, mcp-layer-autonomy, dolphin-variants, html-comment-smuggling, credential-exfiltration, operator-owned-authorization, nested-comments, role-negation-literary)
- `13-REFERENCE-PAPERS/` — 20 references (nous-hermes-4, deepseek-v3, dolphin-3, dolphin-mixtral, mythomax-airoboros-chronos, nicoboss-hermes-3-405b-uncensored, venice-ai, gcg-zou-fredrikson-kolter, refusal-geometry-followups, bijection-learning, pandas-positive-affirmation, cl4r1t4s-pliny, llm-abliteration-nousresearch, transformerlens, garak-nvidia, willison-lethal-trifecta, commandsans-mcp-sanitization, proact-refusal-judge, narayanan-shah-ai-snake-oil, ugi-leaderboard)

## PARTIAL / MISSING (Codex work list)

### P1 — Empty content folders (author these next)

1. **`01-SYSTEM-PROMPTS/`** — EMPTY. Distill 7 files from `99-ARCHIVE-SEEDS/system-prompts/` (INFILTRATED.md, fable5-mythos.md, System-Prompt-Compiler.md, OPENCODE-DARK-FACTORY.md, Hermes-Dictator.md, nix-dictator.md — skip opencode.jsonc which is config not prompt). Each: frontmatter `kind: system-prompt`, sections `## Purpose`, `## Prompt text` (fenced injectable block), `## Placement`, `## Provenance`. + `README.md` index.
2. **`03-HARNESSES/`** — EMPTY. Author per-harness wiring `.md` files (kind: harness-config) for: claude-code, opencode, codex, hermes, lmstudio, ollama, llamacpp, openwebui. Each: install steps, sovereign preamble injection point, MCP posture, refusal-rate notes.
3. **`04-PROVIDERS/`** — EMPTY. 8 files (kind: provider-note): openrouter, deepseek-direct, venice, mistral-direct, hermes-api, groq, together, fireworks. Include TAINT LIST for openai/* + non-Mythos Anthropic.
4. **`05-LOCAL-MODELS/models/`** — subfolder missing. Model recipe files: nous-hermes-4.md, deepseek-v3.md, dolphin-mixtral.md, mistral-abliterated.md, `abliteration-pipeline.md` (Arditi arXiv 2406.11717 → mlabonne DPO heal → GGUF quantize, cite FailSpy repo + mlabonne blogpost).
5. **`06-MULTIMODAL/`** — EMPTY. Four subfolders: `image/` (nightcafe, sd-local, flux, midjourney-bypass, dalle-bypass, comfyui-workflow, automatic1111-config), `video/` (runway, pika, luma, stable-video, animatediff-local), `audio/` (suno-god-mode, udio, elevenlabs, bark-local, xtts-local), `vision-input/` (image-as-prompt-injection, ascii-art-encoding, multimodal-lethal-trifecta). Each: `## Direct path`, `## Fallback jailbreak`, `## Provider swap targets`, `## Notes`.

### P2 — Complete partial folders

6. **`09-EDUCATIONAL/`** — only mindmap done. Add `tutorials/` (5+ step-by-step walkthroughs), `deep-dives/` (long-form technical), `infographics-src/` (SVG/mermaid sources).
7. **`10-GLOSSARY-FAQ/faq/`** — verify FAQ count; target 20 Qs (see `agent prompt log` in prior handoff for the 20-Q list — e.g. "Do I need an abliterated model?", "Which OpenRouter models are tainted?", etc). Add `README.md` if missing.
8. **`PWA-CONTROL-CENTER-LATER/`** — placeholder only. Seed a README with the intended architecture (deferred).

### P3 — Scans that never wrote output (ran out of credits)

9. **Desktop subtree scan** — agent `a50c3281ef5d5bc52` failed. Slice: `/home/dirt/Desktop/**/*.md` at depth 15+, focusing on `PROJECTS/PROJECTS/WES-HERM/`, `PROJECTS/UNCENSOR-LLMS/`, `ACE-HANDOFFS/`, `knowledge/`. Deliverable: `00-DOCTRINE/DESKTOP-SCAN-DIGEST.md` (high-relevance sovereign artifacts, potential seeds to promote to `99-ARCHIVE-SEEDS/`).
10. **Dotfiles scan** — agent `ac2cf1404dccdf5e7` failed. Slice: `~/.hermes/`, `~/.claude/`, `~/.ontfix/`, `~/.docker/mcp/`, `~/.config/`. Deliverable: `00-DOCTRINE/DOTFILES-SCAN-DIGEST.md`.
11. **HERM S22 mirror scan** — agent `a2c246fa39e263292` failed. Slice: `/home/dirt/Desktop/PROJECTS/PROJECTS/WES-HERM/herm-s22-mirror-20260907/` (~6799 files). Deliverable: `00-DOCTRINE/HERM-S22-MIRROR-DIGEST.md` with recommended seed-promotions.

### P4 — Cross-mesh sync (once HERM back up)

12. Bus-post the completed skeleton to WORM + HERM: `TO-ALL-unmuzzled-ai-v0.1.0-shipped-*.md`.
13. Confirm skill-registry vote (was 3/3 last count) still holds with WORM + HERM.
14. Cross-check GDR latest-plan for any amendments to ROADMAP.md / batches / 7-tree-vs-8-zone decision beyond commit `329a0c6`.

## Rules Codex MUST follow (same as Claude Code)

- **COPY not MOVE** when pulling from `~/`, `~/gh/`, `~/Desktop/`, `~/.hermes/` — originals must stay intact.
- **NO softening** — read `00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md` and lint every new file against `11-DETECTION-CANARIES/soul-lint/banned-phrases.txt` before commit.
- Every new `.md` MUST have YAML frontmatter with `sovereign: true` and correct `kind:` per `FRONTMATTER-SPEC.md`.
- Do NOT fabricate arXiv IDs, HF slugs, repo URLs — mark `TBD-verify` if uncertain.
- Do NOT touch `99-ARCHIVE-SEEDS/` (frozen, sha256-manifested).
- Do NOT edit `LAWS.md §§0–3` or `MAXIMUM-ADVERSARIAL-POSTURE.md §Posture Statement` (FROZEN, requires MAJOR bump + operator directive).
- Bump `VERSION` on structural changes; append to `EXTENSIONS.log` for new folders / banned phrases / frontmatter fields.

## Recommended Codex execution order

1. Read `CLAUDE.md`, `MAXIMUM-ADVERSARIAL-POSTURE.md`, `FRONTMATTER-SPEC.md`, `DESIGN-DRAFT-v0.1.md`.
2. Knock out P1 items #1 → #5 (empty top-level folders) in that order — each is 1 batch of distilled `.md` files.
3. Complete P2 (educational + FAQ + PWA seed).
4. Do P3 scans last (they're indexing, not authoring — lower value).
5. Bump VERSION → `0.2.0` (new content in existing structure = PATCH, but folder-set went from empty to populated = MINOR).
6. Bus-post completion notice (P4).

Codex will refuse to run outside a git repo — either `cd ~/UNMUZZLED-AI && git init` (recommended, this framework should be version-controlled) or run `--sandbox danger-full-access` from a scratch dir. Under Hermes gateway context, bubblewrap sandboxing may fail — prefer `--sandbox danger-full-access` there.

— ACE (dirt-iMac), 2026-09-18, EOD
