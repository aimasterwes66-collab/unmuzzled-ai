---
name: PWA Control Center Feature Spec
slug: pwa-control-center-spec
version: 0.1-20260918
kind: doctrine
sovereign: true
tags: [pwa, spec, screens, features]
---

# PWA Control Center — Feature Spec

One section per screen. Every screen inherits the sovereign posture — no confirmation dialogs asking "are you sure", no soft warnings, no "this action cannot be undone" nagware.

## Dashboard (`/`)

At-a-glance state of the framework.

- **Refusal-rate sparkline** — 7-day rolling window per primary route. Data source: `~/UNMUZZLED-AI/11-DETECTION-CANARIES/promptfoo-configs/` result JSON. Green under 5%, amber 5-15%, red above 15%.
- **Active persona badge** — reads `~/.hermes/personalities/ACTIVE`, resolves to hat name from `~/UNMUZZLED-AI/02-PERSONAS/hats/<slug>.md`. Empty file = "plain ACE".
- **Active provider** — reads current primary from provider-selection state.
- **Mesh liveness** — three dots (ACE / WORM / HERM), pings each peer's `:9900/.well-known/agent-card.json`. Green if 200, red if timeout.
- **Recent canary events** — last 10 refusal events with route + rung climbed to resolve.

## Personas (`/personas`)

List and swap sovereign hats.

- **Source** — `~/UNMUZZLED-AI/02-PERSONAS/hats/*.md` and `~/UNMUZZLED-AI/02-PERSONAS/agent-decks/*.md`. Parse frontmatter.
- **List view** — one card per persona: name, slug, tags, source path, `sovereign: true` badge.
- **Detail view** — renders SOUL.md body with syntax-highlighted frontmatter block.
- **Activate** — click "Wear this hat" → `POST /control/active-persona {slug}` → proxy writes slug to `~/.hermes/personalities/ACTIVE`. Reflects immediately in Sidebar badge.
- **Deactivate** — "Go plain" empties the ACTIVE file.
- **Lint status** — per persona: run `soul-lint` result inline. Red flag if any banned phrase detected.

## Providers (`/providers`)

Provider health + onboarding.

- **Source** — `~/UNMUZZLED-AI/04-PROVIDERS/*/README.md`. Parse censorship-posture writeup.
- **Color coding**:
  - `#00ff88` sovereign primary (hermes4-nous, deepseek-direct, venice-ai, dolphin, mistral-direct, openrouter-sovereign).
  - `#ffaa00` mixed (together, fireworks, groq).
  - `#ff3355` tainted (openai/* via OR, Anthropic-without-Mythos, any moderation-under-API).
- **Per-provider card** — name, current 24h refusal rate, primary/mixed/tainted badge, last canary timestamp.
- **Onboarding walkthrough** — click provider → step-by-step wizard reads `onboarding.sh` and renders each step; operator confirms per step; failures streamed inline.
- **Taint override** — operator can force-taint or force-untaint any provider. Writes to `~/.unmuzzled/state/taint-list.json`.

## Canaries (`/canaries`)

Run the refusal-probe set + visualize.

- **"Run canary set" button** — `POST /control/canary/run {suite: "xstest-adapted"}`. Proxy runs `promptfoo eval` under `~/UNMUZZLED-AI/11-DETECTION-CANARIES/promptfoo-configs/`.
- **Live progress** — SSE stream: `X / 250 prompts, current refusal rate: N%`.
- **Result view** — breakdown per route (provider × harness): refusal rate, rungs-climbed histogram, banned-phrase hits.
- **History** — line chart, one series per route, 30-day window.
- **Auto-taint indicator** — routes over 5% for 3 consecutive runs flash red; one-click demote.

## Corpus (`/corpus`)

Searchable browser over the jailbreak-pattern library.

- **Source** — `~/UNMUZZLED-AI/12-JAILBREAK-CORPUS/patterns/*.md` (and subdirs: `pliny-l1b3rt4s-derived/`, `gcg-suffixes/`, `encoding-ladder/`, `multi-turn-many-shot/`, `divider-tokens/`, `format-hijacks/`, `new-paradigm-resets/`).
- **Full-text search** — client-side (MiniSearch or FlexSearch). Indexes name, slug, tags, source, body.
- **Filter chips** — category, harness, provider, modality, source (Pliny / arxiv-XXXX / Rehberger / ...).
- **Detail view** — full pattern body, copy-to-clipboard button per code fence, "test in canary" shortcut (runs the pattern once against the active route).
- **No moderation** — every pattern is displayed raw. No obscuring, no "click to reveal", no age gate.

## Doctor (`/doctor`)

Front-end for `doctor.sh`.

- **"Run doctor" button** — `GET /control/doctor/stream` — SSE stream of `~/UNMUZZLED-AI/07-INSTALL-SCRIPTS/self-heal/doctor.sh` stdout.
- **Terminal-style view** — monospace, dark, ANSI-color-preserved (via `ansi-to-html` or similar).
- **Fix plan section** — parses doctor's structured output block; per-item "Apply" button → `POST /control/doctor/apply {item}` runs `doctor.sh --apply --only <item>`.
- **Last run summary** — pass/warn/fail counts, timestamp.

## Install (`/install`)

Per-harness install wizard.

- **Harness picker** — grid of tiles: Claude Code, opencode, Codex, Hermes, LM Studio, Ollama, llama.cpp, OpenWebUI.
- **Provider picker** — subset of `/providers` list; multi-select.
- **Modality picker** — text, image, video, audio, vision-input; multi-select.
- **Generated plan** — reads `~/UNMUZZLED-AI/07-INSTALL-SCRIPTS/per-harness/<harness>.sh` and `per-provider/<provider>.sh`, renders numbered steps.
- **Execute** — one-shot ("run all") or step-by-step. Streams stdout.
- **Post-install verify** — automatically runs the canary suite scoped to the newly installed route(s).
