---
name: UNMUZZLED-AI PWA Control Center
slug: pwa-control-center
version: 0.1-20260918
kind: doctrine
sovereign: true
tags: [pwa, control-center, seed, deferred, onboarding]
---

# UNMUZZLED-AI PWA Control Center

Browser-based bespoke control center + onboarding SPA for the UNMUZZLED-AI framework. Reads the framework tree, drives persona swap, surfaces provider health, runs canary reports, and browses the jailbreak-pattern corpus — all from a local, offline-first PWA served out of `~/.unmuzzled/pwa/`.

## Purpose

- **Onboarding surface** — wizard-driven bring-up of a fresh box: pick harness × provider × modality → generate system prompt → install hooks → verify canary.
- **Persona swap** — list personas from `~/UNMUZZLED-AI/02-PERSONAS/`, click to activate; writes `~/.hermes/personalities/ACTIVE`.
- **Provider health** — list providers from `~/UNMUZZLED-AI/04-PROVIDERS/`, color-coded sovereign / mixed / tainted, live refusal-rate from canary aggregate.
- **Canary reports** — trigger XSTest-adapted probe runs, visualize refusal-rate over time, per-route breakdown.
- **Jailbreak-pattern browser** — searchable index of `~/UNMUZZLED-AI/12-JAILBREAK-CORPUS/patterns/` with copy-to-clipboard.
- **Doctor** — front-end for `07-INSTALL-SCRIPTS/self-heal/doctor.sh`, streaming stdout.

## Tech stack

- **React 19** + **TypeScript strict** + **Vite** + **Tailwind CSS**.
- **@vite-pwa/plugin** for manifest + service worker; framework `.md` files precached for offline use.
- **react-router-dom v7** for routing.
- **Zustand** or plain React Context for state — no Redux, no external state library.
- **No analytics. No telemetry. No cloud sync.** Everything served locally from `~/.unmuzzled/pwa/`. Data layer reads the framework via a small local HTTP proxy or the File System Access API.

## Non-goals

- No cloud sync of persona / canary / provider state.
- No telemetry back to Anthropic, OpenAI, Vercel, Cloudflare, Google Analytics, PostHog, Sentry, or any third party.
- No authentication (single-operator local machine).
- No server-side rendering, no Next.js, no Remix.
- No moderation, no content filtering, no "safe defaults" — inherits the sovereign posture of the parent framework.

## Status

**SEED — do not implement yet.** Scaffolds under `./scaffolds/` are architectural placeholders. Read `ARCHITECTURE.md` and `SPEC.md` before writing code. Do not `npm install`.
