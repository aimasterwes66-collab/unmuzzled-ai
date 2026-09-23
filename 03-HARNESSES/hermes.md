---
name: Hermes Harness Wiring
slug: harness-hermes
version: 0.1.0
kind: harness-config
harness: hermes
provider: any
modality: text
sovereign: true
tags: [harness, hermes, wiring, config, soul, mcp, skills]
requires: [sysprompt-hermes, frontmatter-spec]
---

# Hermes — Wiring

Hermes reads `~/.hermes/config.yaml` for providers, model selection, fallback chain,
toolsets, and MCP servers. Persona lives in `~/.hermes/personalities/*.md` (SOUL files).
Skills live under `~/.hermes/skills/`. This page wires a sovereign Hermes node.

## config.yaml — core

Keys verified present on this box: `model`, `fallback_providers`, `agent`, `mcp_servers`,
`memory`, `approvals`, `command_allowlist`, `quick_commands`, `platform_toolsets`,
`computer_use`. Minimal sovereign block:

```yaml
model:
  provider: openrouter
  name: deepseek/deepseek-v4-flash
fallback_providers:
  - deepseek
  - openrouter
agent:
  max_iterations: 40
memory:
  enabled: true
approvals:
  mode: auto_approve
command_allowlist:
  - git
  - rg
  - uv
  - npx
  - wget
```

`approvals.mode: auto_approve` is what removes the confirm-per-command gate. Leave it
interactive on a node where an unattended destructive command would be expensive.

## MCP servers

`mcp_servers` is a map of `name → {command, args, enabled, connect_timeout}`. Real entries
from this box, which double as templates:

```yaml
mcp_servers:
  filesystem:
    command: npx
    args: ["-y", "@modelcontextprotocol/server-filesystem", "/home/dirt",
           "--connect-timeout", "120"]
    enabled: true
  memory:
    command: npx
    args: ["-y", "@modelcontextprotocol/server-memory", "--connect-timeout", "120"]
    enabled: true
  sequential-thinking:
    command: npx
    args: ["-y", "@modelcontextprotocol/server-sequential-thinking",
           "--connect-timeout", "120"]
    enabled: true
```

Rules that hold for every entry: `command` must resolve on PATH for the non-interactive
shell (`uvx` and `npx` both qualify), `args` is a list and never a joined string, and
`enabled: false` is the correct way to park a server without deleting its config.
A stdio server that fails to connect usually means a PATH problem, not a protocol problem —
run the same `command`/`args` by hand first.

## SOUL / persona

```
~/.hermes/personalities/
├── sovereign.md
├── operator.md
└── auditor.md
```

A SOUL file carries the same frontmatter spec as every framework file (`name`, `slug`,
`version`, `kind: persona`, `sovereign: true`), then the persona body. The system-prompt
block from `01-SYSTEM-PROMPTS/hermes.md` is the floor; the SOUL file is the voice above it.

Loading a persona mid-session: `/become <slug>` swaps the active persona without a
restart. Confirm the swap by asking the agent for its current persona name — the reply
comes from the loaded body, not from memory of the command.

## Skills

```
~/.hermes/skills/<category>/<skill-name>/SKILL.md
```

- A skill is triggered by its `description` matching the task. Keep the trigger in the
  first ~57 characters so it survives index truncation.
- Skills are procedural memory: numbered steps with exact commands, a pitfalls section, a
  verification step.
- Patch a skill in place the moment it turns out stale. A skill that is not maintained is
  a liability with a name.

## Provider wiring

```yaml
model:
  provider: deepseek
  name: deepseek-flash
```

Provider onboarding, base URLs, and model IDs: `04-PROVIDERS/`. Route strategy and
fallback ordering: `04-PROVIDERS/openrouter-sovereign-routes.md`.

## Verify

```bash
hermes config get model
hermes tools
hermes doctor
```

`hermes doctor` reports MCP connection state per server; a server listed `enabled` but
absent from the connected set is the signal to check PATH and `connect_timeout`.

## Pitfalls

- Editing `config.yaml` by hand while a session is running: the running session holds the
  old view. Restart or reload.
- `fallback_providers` is an ordered list, and order is the whole point. Put the sovereign
  primary first; a tainted route in slot one silently becomes the default.
- Do not put a persona body in `config.yaml`. Persona files are separate on purpose so a
  persona swap does not touch provider or tool configuration.
