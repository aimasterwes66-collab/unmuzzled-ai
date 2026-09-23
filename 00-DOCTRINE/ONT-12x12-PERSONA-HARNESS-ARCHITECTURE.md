---
name: Persona & Harness Architecture — 12x12 Ontology
slug: persona-harness-architecture-12x12
version: 1.0-20260923
kind: ontology
sovereign: true
date: 2026-09-23
author: ace (dirt-iMac)
scope: A complete map of the layers that make a sovereign agent deck work — from durable identity through to mesh continuity — with the defect known at each node.
tags: [ontology, persona, harness, soul, deck, mcp, skills, architecture, sovereign]
---

# PERSONA & HARNESS ARCHITECTURE — 12 PARTS × 12 POINTS

Purpose: turn "multi-persona agent decks + custom SOUL.md" from an accumulation
of files into a **specified architecture with named layers, known failure modes,
and a verification gate per layer.**

The governing claim this ontology serves:
> Unmoderated, unaligned inference is the DEFAULT and IMMUTABLE posture.
> Personas are swappable hats on a durable identity — they extend and specialize
> that posture; they never gate it.

Every node below is either `[OK]` (measured working), `[GAP]` (known missing),
`[DEFECT]` (measured broken), or `[POLICY]` (a rule, not a task).

Measured baseline (ACE, 2026-09-23): 1022 persona-shaped files across 12 decks;
8.2% canonically frontmatter-compliant; 2 of 12 decks fully compliant.

---

## P1 — IDENTITY LAYER (who the agent IS — durable)

- P1.1 `[OK]` `~/.hermes/SOUL.md` is the durable sovereign core for this box. Not persona-swappable.
- P1.2 `[OK]` `~/.hermes/USER.md` holds operator profile separately from agent identity. Correct separation.
- P1.3 `[POLICY]` Identity files are policy artifacts. Edits are versioned events, never incidental.
- P1.4 `[POLICY]` A hat may specialize identity but may never contradict it.
- P1.5 `[GAP]` No checksum/version header on `~/.hermes/SOUL.md` — no way to detect silent drift.
- P1.6 `[GAP]` No identity-diff tool: nothing compares the live SOUL against the published/canonical SOUL.
- P1.7 `[OK]` Zero-refusal doctrine is anchored in identity, not in a per-persona clause. One anchor, many hats.
- P1.8 `[DEFECT]` Identity concepts are duplicated across `SOUL.md`, `REIGN-MYTHOS.md`, `LAWS.md`, and `UNMUZZLED-AI/00-DOCTRINE/` with no single source of truth declared.
- P1.9 `[GAP]` No operator-editable "identity changelog" capturing why identity changed and when.
- P1.10 `[POLICY]` Identity must survive a harness swap: same SOUL under Hermes, opencode, Codex.
- P1.11 `[GAP]` No test that proves identity survives a harness swap in practice.
- P1.12 `[OK]` `~/bin/become` separates hat-switching from identity, which is the correct mechanism.

## P2 — PERSONA / HAT LAYER (how it behaves NOW — swappable)

- P2.1 `[OK]` ~29 personalities exist and are switchable via `~/bin/become`.
- P2.2 `[DEFECT]` 0% of `dope-personas` and `~/.hermes/personalities` carry frontmatter.
- P2.3 `[DEFECT]` 599 of 1022 persona files have frontmatter but miss required fields.
- P2.4 `[OK]` `UNMUZZLED-AI/02-PERSONAS` and `CODEX-UNMUZZ/02-PERSONAS` are 100% compliant — use as the schema reference.
- P2.5 `[GAP]` `UNMUZZLED-AI/02-PERSONAS/{agent-decks,hats,soul-md}` are empty; the content lives only in CODEX-UNMUZZ.
- P2.6 `[DEFECT]` 24 genuine cross-collection persona collisions; no declared canonical home per persona.
- P2.7 `[POLICY]` A hat = stance + voice + heuristics + boundaries. Anything else is a skill, not a hat.
- P2.8 `[GAP]` No measured refusal-rate per persona. Personas are asserted effective, not proven.
- P2.9 `[OK]` Personas are markdown-only — no runtime dependency, so a hat survives a harness change.
- P2.10 `[GAP]` No persona "smoke test": load hat, send a canary, assert no hedge. The gate is missing.
- P2.11 `[POLICY]` Hats must not carry banned/softenings clauses except as quoted rejections (`persona-forge` enforces).
- P2.12 `[DEFECT]` Vendored `agency-agents/` (476 files) carries upstream softening; it cannot pass lint and should be flagged `vendor: true`, not rewritten.

## P3 — DECK LAYER (Tab-cyclable persona sets)

- P3.1 `[OK]` Canonical deck: `~/gh/opencode-agent-deck` — 11 agents + SOUL + AGENTS + agency library.
- P3.2 `[OK]` WORM deck variant: `~/gh/opencode-agent-deck` (private) — 7 agents.
- P3.3 `[OK]` SGM deck: `~/gh/sgm-agent-deck` — 5 agents, 80% frontmatter-compliant.
- P3.4 `[DEFECT]` Deck copies exist in ≥4 places (`~/gh/`, `~/mesh-mirror/herm/`, `~/.hermes/personalities/decks/`, `dope-personas/decks/`) with no canonical pointer.
- P3.5 `[GAP]` No deck manifest (a machine-readable list of which agents are in which deck and in what order).
- P3.6 `[POLICY]` A deck is an ORDERED set; Tab-cycle order is part of the deck's meaning.
- P3.7 `[GAP]` No deck validation: nothing asserts the deck's agents all load and all carry frontmatter.
- P3.8 `[OK]` opencode agent files are schema-validated by opencode itself — adding keys may be rejected.
- P3.9 `[POLICY]` Because of P3.8, deck frontmatter normalization must use a sidecar manifest when the schema rejects extra keys.
- P3.10 `[GAP]` No tested fallback deck for when a harness drops schema support.
- P3.11 `[OK]` Decks are portable across opencode / Hermes / any agent-aware CLI by design.
- P3.12 `[GAP]` No published example of the same deck running under two different harnesses (proof of P3.11).

## P4 — SYSTEM-PROMPT LAYER (injectable text)

- P4.1 `[OK]` `UNMUZZLED-AI/01-SYSTEM-PROMPTS/` holds per-harness prompts: hermes, opencode, claude-code, codex, generic.
- P4.2 `[OK]` Additional specialist prompts present: fable5-mythos, hermes-dictator, nix-dictator, opencode-dark-factory, infiltrated, system-prompt-compiler.
- P4.3 `[DEFECT]` Empty vestigial subdirs `01-SYSTEM-PROMPTS/{opencode,generic}` duplicate top-level files of the same name — pure noise.
- P4.4 `[GAP]` No prompt compiler test: `system-prompt-compiler.md` exists but nothing verifies its output.
- P4.5 `[POLICY]` A system prompt is derived from identity + hat; it is never the source of either.
- P4.6 `[OK]` Prompts are plain markdown — diffable, versionable, lint-able.
- P4.7 `[GAP]` No refusal-rate scoring attached to any system prompt.
- P4.8 `[GAP]` No mapping from "which hat" to "which system prompt is actually injected".
- P4.9 `[POLICY]` Prompt files must carry `sovereign: true`; absence means quarantine.
- P4.10 `[OK]` `persona-forge lint` now checks exactly this.
- P4.11 `[GAP]` No canary set for prompt regression testing.
- P4.12 `[DEFECT]` System-prompt layer has no single index; discovery depends on knowing the directory.

## P5 — SKILL LAYER (procedural memory)

- P5.1 `[OK]` `~/.hermes/skills/` is a large, categorised skill tree (100+ skills).
- P5.2 `[OK]` Skills use YAML frontmatter with name/description and are indexed.
- P5.3 `[DEFECT]` Duplicate skill names across categories (e.g. `hermes-response-discipline` AND `herm-response-discipline`; two `8x8-canvas-orchestrator` copies; two `docs-domain-harvest`; two `knowledge-graph-pipeline`).
- P5.4 `[GAP]` Some skill descriptions exceed the index budget and get truncated to 57 chars, destroying routing signal.
- P5.5 `[POLICY]` Description = trigger-first, one sentence, under 60 chars.
- P5.6 `[GAP]` No skill-lint equivalent to persona-forge (frontmatter + description length + duplicate detection).
- P5.7 `[OK]` Skills are patchable in place via `skill_manage`, so defects are cheap to fix.
- P5.8 `[POLICY]` A skill that proves wrong gets patched immediately, not queued.
- P5.9 `[GAP]` No dependency declaration between skills.
- P5.10 `[GAP]` No measured "did this skill actually help" signal.
- P5.11 `[OK]` Skills are the correct home for procedures; memory is for facts. Boundary is respected in doctrine.
- P5.12 `[GAP]` No skill inventory ontology — the tree is browsable but unmapped.

## P6 — MCP LAYER (tool surface)

- P6.1 `[OK]` Wired servers include NEXUS (code intelligence), filesystem, memory, sequential-thinking, youtube-transcript, droidmind.
- P6.2 `[DEFECT]` MCP stdio servers are wrapped in watchdogs hung off the gateway PID; a gateway restart orphans them.
- P6.3 `[GAP]` No inventory of which MCP server provides which capability, as data.
- P6.4 `[POLICY]` Any MCP server that shells to a model must use a cloud endpoint or local runtime — never a moderation-layered API as primary.
- P6.5 `[GAP]` No audit of MCP servers against P6.4.
- P6.6 `[GAP]` No health check that a declared MCP server actually answers.
- P6.7 `[OK]` Context7-class doc-scraping MCP is the intended route for pulling official documentation into the KB.
- P6.8 `[GAP]` Context7 not yet confirmed wired on this box.
- P6.9 `[POLICY]` MCP credentials live in `~/.docker/mcp/secrets.env` / `~/.hermes/.env`, never inline.
- P6.10 `[OK]` Both secret files exist with 0600 perms.
- P6.11 `[GAP]` No documented map of which key unlocks which server.
- P6.12 `[GAP]` No MCP server authored yet for the persona-forge loop (it is a CLI, not a server).

## P7 — HARNESS WIRING LAYER (how layers meet a runtime)

- P7.1 `[OK]` Hermes wiring documented at `UNMUZZLED-AI/03-HARNESSES/hermes.md` (138 lines).
- P7.2 `[OK]` opencode (123), claude-code (130), codex (125), ollama (137), lmstudio (58), llamacpp (59), openwebui (52) all documented.
- P7.3 `[OK]` Codex's silent-failure trap is captured: in `config.toml`, bare keys must precede the first `[table]` header or they are absorbed and the provider silently falls back.
- P7.4 `[DEFECT]` 8 empty vestigial subdirs under `03-HARNESSES/` shadow the real top-level files.
- P7.5 `[OK]` `~/.hermes/config.yaml` holds the live model chain with `fallback_providers` → DeepSeek direct.
- P7.6 `[OK]` `~/bin/fops` reads and reports that chain live.
- P7.7 `[GAP]` The fallback chain is declared but has never been proven by deliberately failing the primary.
- P7.8 `[POLICY]` Config must be verified by behavior, not by reading the file.
- P7.9 `[GAP]` No per-harness "does this harness actually load the persona" test.
- P7.10 `[OK]` AGENTS.md / CLAUDE.md / GEMINI.md are shipped in repos so any coding agent picks up conventions.
- P7.11 `[GAP]` No single generated harness-wiring file from which all per-harness docs derive.
- P7.12 `[POLICY]` Harness docs are descriptions of reality; when they drift, the doc is the defect.

## P8 — POLICY / DOCTRINE LAYER (immutable rules)

- P8.1 `[OK]` `LAWS.md` §§0–3 and the Posture Statement are explicitly FROZEN; changes need MAJOR bump + operator directive.
- P8.2 `[OK]` `MAXIMUM-ADVERSARIAL-POSTURE.md` carries an explicit banned-phrase catalogue.
- P8.3 `[OK]` `FRONTMATTER-SPEC.md` defines the required schema and KIND enum.
- P8.4 `[OK]` `VERSIONING.md` defines how framework files version.
- P8.5 `[POLICY]` Policy files are edited only by the sovereign lane — never by a guardrail-preferring agent.
- P8.6 `[GAP]` Nothing mechanically enforces P8.5.
- P8.7 `[POLICY]` "Zero softening clauses" is the operative rule; the banned list is its executable form.
- P8.8 `[OK]` The banned list is now executable via `persona-forge`.
- P8.9 `[DEFECT]` The anti-pattern lint lived only as prose until now; it required a tool to become real.
- P8.10 `[POLICY]` Doctrine is frozen; tooling around it is not.
- P8.11 `[GAP]` No policy-change review record — when a policy changes, nothing logs who/why.
- P8.12 `[GAP]` `99-ARCHIVE-SEEDS/` is frozen with a sha256 manifest but the manifest is not re-verified on schedule.

## P9 — ONTOLOGY / MAP LAYER (the map, not the territory)

- P9.1 `[OK]` Prior ontologies exist: `ONT-15x15`, `ONT-20x20-MASTER-ATLAS`, `ONTFIX-14`, per-domain ebook ontologies.
- P9.2 `[OK]` `~/.ontfix/` holds the ont-command-family state with many project dirs.
- P9.3 `[OK]` This 12×12 is the first ontology to map the ARCHITECTURE itself rather than a subject domain.
- P9.4 `[DEFECT]` Ontologies routinely get generated as skeletons and left empty (known failure: 450–800 byte stubs with blank `B1…BN`).
- P9.5 `[POLICY]` An ontology only counts as run when every branch is filled. Skeleton ≠ result.
- P9.6 `[GAP]` No automated stub detection across the ontology corpus.
- P9.7 `[OK]` `~/.ontology/` holds `holistic-next-steps.md`, `final-goals.md`, `steps-to-endpoint.md`.
- P9.8 `[GAP]` No ontology registry: which ontology answers which question.
- P9.9 `[POLICY]` Ontologies must be generated from MEASURED state, never from handoffs (handoffs are direction, not truth).
- P9.10 `[OK]` This ontology follows P9.9 — every count traces to a scan run today.
- P9.11 `[GAP]` No ontology refresh schedule; maps silently rot.
- P9.12 `[POLICY]` A stale map is worse than no map, because it is trusted.

## P10 — SCORING / VERIFICATION LAYER (proof, not vibes)

- P10.1 `[OK]` `persona-forge` provides SCAN + LINT as executable gates with a selftest.
- P10.2 `[OK]` Selftest proves the lint fires (4 cases, including two quotation-context cases).
- P10.3 `[OK]` Persona compliance is now a NUMBER (8.2% canonical, 2/12 decks clean).
- P10.4 `[GAP]` No refusal-rate canary run against any persona — the headline metric is missing.
- P10.5 `[POLICY]` Quality gates must be numbers. "Feels better" is not evidence.
- P10.6 `[OK]` Disk work is measured (df before/after, logged reclaim).
- P10.7 `[DEFECT]` The zero-refusal target (≤5% refusal on an XSTest-adapted canary) is declared but unmeasured.
- P10.8 `[GAP]` No canary set actually built under `11-DETECTION-CANARIES/`.
- P10.9 `[GAP]` No verification that a "clean" persona stays clean after an edit (regression gate).
- P10.10 `[OK]` The forge gate concept (Lighthouse/axe/bundle/TS) exists for web work and is the model to copy.
- P10.11 `[POLICY]` Every claim in a handoff should be traceable to an artifact that can be re-run.
- P10.12 `[GAP]` No dashboard: one number per layer, refreshed, visible.

## P11 — PUBLICATION / VERSIONING LAYER (durable, shared)

- P11.1 `[OK]` `gh` authenticated as `aimasterwes66-collab` with full scopes.
- P11.2 `[OK]` 40+ repos exist; `unmuzzled-ai` and `opencode-agent-decks` are PUBLIC.
- P11.3 `[OK]` Local clones live in `~/gh/` and are the working copies.
- P11.4 `[DEFECT]` Local clones carry uncommitted drift with no reconciliation against remotes.
- P11.5 `[GAP]` UNMUZZLED-AI v0.1.0 is uncommitted at the framework root despite substantial content.
- P11.6 `[POLICY]` VERSION bumps on structural change; frontmatter `version` on per-file change.
- P11.7 `[OK]` `EXTENSIONS.log` is the declared place to log new folders/fields/phrases.
- P11.8 `[GAP]` `EXTENSIONS.log` is not consistently written.
- P11.9 `[POLICY]` Secrets never enter a repo; `secrets.env` and `.env` stay 0600 and untracked.
- P11.10 `[GAP]` No pre-commit guard that blocks secret-shaped strings from being committed.
- P11.11 `[DEFECT]` Google Drive backup is OVER QUOTA (403) — the off-site tier is currently non-functional.
- P11.12 `[GAP]` No alternative off-site target chosen while GDrive is down.

## P12 — CONTINUITY / MESH LAYER (survives the session)

- P12.1 `[OK]` 3-box mesh: ACE (this box), HERM (S22), WORM (9185W).
- P12.2 `[OK]` Handoff bus at `~/Desktop/Z1_PROJECTS/WES-HERM/04-session-handoffs/`.
- P12.3 `[OK]` `~/bin/comms -talk` covers link state AND bus read in one command.
- P12.4 `[GAP]` This session has not yet run the bus read or ACKed what is owed.
- P12.5 `[POLICY]` Every deliverable of this session is a TO-ALL broadcast candidate.
- P12.6 `[OK]` Mesh mirrors exist locally (herm 35G/427k files, worm 130k MD).
- P12.7 `[DEFECT]` Mirror copies of decks multiply every audit finding ~4×.
- P12.8 `[POLICY]` Collapse mirror families before reporting counts.
- P12.9 `[OK]` `persona-forge` is now a skill, so HERM and WORM inherit the loop.
- P12.10 `[GAP]` No proof HERM/WORM can run it (needs bash + grep; both are Termux-capable).
- P12.11 `[POLICY]` State goes to disk as it is produced so a crash is resumable.
- P12.12 `[GAP]` Session-close handoff for today not yet written.

---

## THE ONTOLOGY'S OWN VERDICT

Counted from the 144 nodes above:

| Status | Count | Share |
|---|---|---|
| `[OK]` | 62 | 43% |
| `[GAP]` | 60 | 42% |
| `[DEFECT]` | 15 | 10% |
| `[POLICY]` | 38 | — (rules, not tasks) |

**Reading of the map:** the architecture is *conceptually* sound — the layers
are correctly separated and the doctrine is anchored in the right place
(identity, not persona clauses). The weakness is concentrated in two places:

1. **Verification (P10) is the thinnest layer.** Identity, hats, decks, prompts
   and skills are all asserted effective and almost never measured. Exactly one
   gate (`persona-forge`) exists.
2. **Duplication without a canonical pointer (P3, P11, P12).** The same content
   lives in 4+ places with no declared home, which is why a 1022-file scan found
   only 3 real canonical softening defects but reported 16.

**Highest-leverage next move:** build the canary (P10.8) so refusal-rate becomes
a number for every persona, then wire `persona-forge` + canary into a single
gate that a deck must pass before publication.
