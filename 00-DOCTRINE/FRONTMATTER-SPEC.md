---
name: UNMUZZLED-AI Frontmatter Specification
slug: frontmatter-spec
version: 1.0
date: 2026-09-18
kind: doctrine
sovereign: true
tags: [convention, schema, lint]
---

# UNMUZZLED-AI — Frontmatter Specification

Every markdown file in UNMUZZLED-AI carries YAML frontmatter. Files without
frontmatter, or with `sovereign: false`, are quarantined and not auto-loaded
by installers, canaries, or the PWA control center.

## Required fields

```yaml
---
name:       # human-readable title
slug:       # kebab-case identifier for scripting
version:    # semver ("1.0") or date ("2026-09-18") or hybrid ("1.0-20260918")
kind:       # see §KIND enum below
sovereign:  # true (mandatory; false = quarantine)
---
```

## Optional fields

```yaml
harness:       # claude-code | opencode | codex | hermes | lmstudio | ollama | llamacpp | openwebui | any
provider:      # hermes4 | venice | deepseek | openrouter | mistral | dolphin | together | fireworks | groq | local | any
modality:      # text | image | video | audio | vision-input | any
refusal-rate:  # measured refusal rate against canary set (0.00-1.00)
tags:          # freeform list
requires:      # list of other framework slugs this file depends on
supersedes:    # list of slugs this file replaces
author:        # freeform (default: operator)
source:        # if adapted from external, cite (Pliny, Rehberger, arxiv-2307.15043, etc.)
---
```

## KIND enum

- `doctrine` — policy / posture / conventions (00-DOCTRINE/*)
- `system-prompt` — raw injectable prompt (01-SYSTEM-PROMPTS/*)
- `persona` — SOUL.md or agent-deck body (02-PERSONAS/*)
- `harness-config` — per-harness wiring (03-HARNESSES/*)
- `provider-note` — per-provider onboarding + jailbreak notes (04-PROVIDERS/*)
- `local-model` — Ollama / LMStudio / llama.cpp / abliteration (05-LOCAL-MODELS/*)
- `multimodal-recipe` — image/video/audio jailbreak recipe (06-MULTIMODAL/*)
- `install-script-doc` — README companion for an .sh script (07-INSTALL-SCRIPTS/*)
- `decision-tree` — mermaid/SVG source + explainer (08-DECISION-TREES/*)
- `tutorial` — step-by-step walkthrough (09-EDUCATIONAL/tutorials/*)
- `deep-dive` — long-form technical (09-EDUCATIONAL/deep-dives/*)
- `mindmap` — subject atlas (09-EDUCATIONAL/mindmaps/*)
- `infographic` — SVG/mermaid source (09-EDUCATIONAL/infographics-src/*)
- `glossary-entry` — one term per file (10-GLOSSARY-FAQ/glossary/*)
- `faq` — one Q per file (10-GLOSSARY-FAQ/faq/*)
- `canary` — refusal probe or lint rule (11-DETECTION-CANARIES/*)
- `jailbreak-pattern` — reusable pattern extract (12-JAILBREAK-CORPUS/*)
- `reference` — external paper/blog/repo pointer (13-REFERENCE-PAPERS/*)
- `seed-archive` — read-only copy of source seed (99-ARCHIVE-SEEDS/*)

## Example — persona hat

```yaml
---
name: DICTATOR
slug: dictator
version: 1.0-20260918
kind: persona
harness: opencode
provider: any
modality: text
sovereign: true
tags: [decisive, autonomy-t4, no-filters]
source: /home/dirt/gh/opencode-agent-deck/agents/dictator.md
---
```

## Example — jailbreak pattern

```yaml
---
name: NEW_PARADIGM reset
slug: new-paradigm-reset
version: 1.0
kind: jailbreak-pattern
harness: any
provider: any
modality: any
sovereign: true
refusal-rate: 0.03
tags: [context-reset, godmode, pliny-derived]
source: Pliny the Prompter, L1B3RT4S corpus (adapted)
---
```

## Lint

- Missing frontmatter → quarantine, framework installer skips.
- `sovereign: false` → quarantine.
- Missing required field → warning; installer refuses to load.
- Banned phrases in body (see `MAXIMUM-ADVERSARIAL-POSTURE.md`) → fail.

## Reserved slugs

Never overload these slugs:
- `doctrine-root`, `laws`, `maximum-adversarial-posture`, `frontmatter-spec`,
  `versioning`, `manifest`.
