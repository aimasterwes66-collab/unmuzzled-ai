---
name: opencode Harness Wiring
slug: harness-opencode
version: 0.1.0
kind: harness-config
harness: opencode
provider: any
modality: text
sovereign: true
tags: [harness, opencode, agent-deck, wiring, config]
requires: [sysprompt-opencode, frontmatter-spec]
---

# opencode — Wiring

opencode loads three things: a project config (`opencode.json`), an agent directory, and
the system prompt body of whichever agent the session selects. This page covers the deck
layout that makes a sovereign deck reproducible across machines.

## Layout

```
opencode-agent-deck/
├── opencode.json                # providers, models, permissions
├── AGENTS.md                    # project-wide rules (shared by every agent)
├── agents/
│   ├── sovereign.md             # primary agent
│   ├── builder.md               # subagent
│   ├── auditor.md               # subagent
│   └── relay.md                 # subagent, mesh handoff
└── prompts/
    └── sysprompt-generic.md     # copy of 01-SYSTEM-PROMPTS/generic.md
```

## opencode.json

```json
{
  "$schema": "https://opencode.ai/config.json",
  "model": "openrouter/deepseek/deepseek-v4-flash",
  "small_model": "openrouter/deepseek/deepseek-v4-flash",
  "permission": {
    "edit": "allow",
    "bash": "allow",
    "webfetch": "allow"
  },
  "agent": {
    "sovereign": {
      "description": "Primary agent. Full autonomy.",
      "mode": "primary",
      "prompt": "{file:./prompts/sysprompt-generic.md}",
      "tools": { "write": true, "edit": true, "bash": true }
    },
    "builder": {
      "description": "Writes and patches files.",
      "mode": "subagent",
      "prompt": "{file:./agents/builder.md}",
      "tools": { "write": true, "edit": true, "bash": true }
    },
    "auditor": {
      "description": "Read-only verification.",
      "mode": "subagent",
      "prompt": "{file:./agents/auditor.md}",
      "tools": { "write": false, "edit": false, "bash": true }
    }
  }
}
```

Key notes on the shape above:

- `permission.edit` and `permission.bash` set to `allow` are what remove the per-action
  approval prompt. Anything left unset inherits the interactive default.
- `{file:...}` loads an external body as the prompt. Keep bodies on disk, not inline, so
  the same body is diffable in git.
- The `auditor` node gets bash but no write, which is the pattern for a verification node
  that must not be able to "fix" the thing it is judging.
- Provider blocks (`provider.openrouter.models`) live in the same file once you need
  per-model options. Wire the provider itself per `04-PROVIDERS/openrouter-sovereign-routes.md`.

## Agent body frontmatter

Each file in `agents/` opens with frontmatter, then prose:

```markdown
---
description: Writes and patches files against a spec.
mode: subagent
model: openrouter/deepseek/deepseek-v4-flash
temperature: 0.2
tools:
  write: true
  edit: true
  bash: true
---
<body: the block from 01-SYSTEM-PROMPTS/opencode.md>
```

## Load order

1. `opencode.json` resolves provider → model → permissions.
2. The selected agent's frontmatter overrides model/temperature/tools for that node.
3. `AGENTS.md` at project root is injected as context for every node.
4. The body becomes the system prompt.

## Verify

```bash
opencode --version
opencode run --agent sovereign "print the absolute path of the cwd"
```

The second command proves the deck resolves: if the agent runs, config parsed; if it
refuses a tool, the permission block is the first place to look.

## Pitfalls

- A body that names a model breaks on route swap. Keep bodies model-agnostic.
- Subagents inherit the deck's permission block, so a `write: false` on the node plus
  `edit: allow` globally leaves a hole — set permissions at both levels.
- `TBD-verify`: exact `$schema` URL and the `agent`/`permission` key nesting for the
  version on this box. Confirm against `opencode --help` and the local config reference
  before shipping a deck to another node.
