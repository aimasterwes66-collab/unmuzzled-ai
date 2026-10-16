---
sovereign: true
title: agentic-coding-landscape
type: harness
agent: worm
status: active
tags: [harness, agentic-coding, landscape, claude-code, codex, opencode, hermes, cursor, cline, roo, aider, continue, windsurf, cody, pearai, openhands, devin, factory, mesh]
---

# Agentic Coding Landscape

Comprehensive map of the agentic-coding tools that touch the WORM / ACE / HERM
mesh in 2026. Each entry follows the per-tool rubric: what it is, install,
code-gen posture, uncensored output, mesh fit. Opencode and Hermes coding tiers
are broken out first because they are the operator's primary dev flow and
host substrate; the rest follow in the order the orchestrator requested.
Length caps are lifted; everything is preserved verbatim, no distilled
summaries. ASCII only. [source: operator prompt, RECONCILE-PLAN.md,
SWARM-PIPELINE.md, 03-HARNESSES/claude-code.md, 03-HARNESSES/codex.md,
03-HARNESSES/opencode.md, 03-HARNESSES/hermes.md, 03-HARNESSES/freelm.md,
12-JAILBREAK-CORPUS/patterns/]

----------------------------------------------------------------------
## 0. Operator mesh recap (so every per-tool "mesh fit" is grounded)
----------------------------------------------------------------------

The WORM / ACE / HERM mesh is the operator's run-time for everything in this
document. The agent identity is fixed per box: WORM = this 9185W tablet
(Termux home, aarch64), ACE = the iMac (dirt-imac, Tailscale
100.108.110.114), HERM = the S22 phone (Tailscale 100.96.104.5, SSH :8022).
Personalities (SOUL.md hats) change inside one agent; the agent name and
the mesh slot never do. [source: ~/AGENTS.md, IDENTITY block]

The 03-HARNESSES/ files already cover the sovereign injection surface for
each harness the operator actively runs (claude-code, codex, opencode,
hermes, lmstudio, ollama, llamacpp, openwebui, freelm, sillytavern). This
document covers the ones that are NOT yet wired into the operator stack but
that the operator needs to know about when a downstream consumer picks a
harness without checking the doctrine first. [source: 03-HARNESSES/README.md]

Mesh-shared conventions (lifted from AGENTS.md, preserved verbatim):
- Naming: kebab-case lowercase, prefixes reserved for HANDOFF- /
  ONTOLOGY- / POLICY-; dates in filename only for handoffs. [source:
  AGENTS.md "Conventions"]
- Frontmatter: title, type, agent, status, tags (kebab-case). [source:
  AGENTS.md "Conventions"]
- Handoffs at session end: ~/HERMES-HANDOFF.md plus
  ~/worm-handoff/HANDIFF-*.md. [source: AGENTS.md "Conventions"]
- Big tarballs at ~ stay put: breaker_backup.tar.gz 350MB, worm-full-home
  1.3GB, spicy 640MB, flipper-final-pass 219MB. No casual re-tar.
  [source: AGENTS.md "Pitfalls"]
- pip must NOT source-build on Termux: cryptography has no aarch64 wheel;
  pip builds hang forever. [source: AGENTS.md "Pitfalls"]
- Hermes gateway: A2A on :9900, persistent SSE MCP gateway on :8811.
  [source: 03-HARNESSES/hermes.md]
- freelm / ai-proxy: free-tier OpenAI-compatible aggregator on
  http://127.0.0.1:8000/v1, bearer-keyed, virtual model aliases
  (auto / best / big / chat / cheap / default / fast / large / lite /
  mini / reasoning / small / tools / vision). [source:
  03-HARNESSES/freelm.md]

----------------------------------------------------------------------
## 1. opencode -- the operator's primary dev flow
----------------------------------------------------------------------

### 1.1 What it is

opencode (sst.dev / anomalyco) -- model-agnostic terminal agent harness.
Loads a folder of markdown "agents" (SOUL.md-style bodies with frontmatter)
from an agent deck. Runs as TUI, desktop app, or VS Code / Cursor / Zed
extension. Provider-agnostic: 75+ providers, including Anthropic, OpenAI,
Google, OpenRouter, LM Studio, Ollama, Groq, Bedrock, and any local
OpenAI-compatible server. Apache-2.0 / MIT. Persistent client/server
architecture: a background server holds model comms and session state in
local SQLite; the TUI is a thin client. A dropped SSH / closed terminal
does not lose the agent mid-task -- reconnect and pick up the live session.
[source: https://opencode.ai, https://github.com/sst/opencode,
https://hivebook.wiki/wiki/opencode-open-source-terminal-coding-agent-sst-opencode,
03-HARNESSES/opencode.md]

The on-disk shape:
- Binary: `opencode`.
- Global config: `~/.config/opencode/opencode.json` (or opencode.jsonc).
  Merges with project opencode.json, .opencode/ local dirs, and remote
  .well-known/opencode org defaults. [source:
  https://hivebook.wiki/wiki/opencode-open-source-terminal-coding-agent-sst-opencode,
  https://linkedin.com/pulse/opencode-terminal-coding-agent-without-vendor-lockin-martin-seifert-p94me]
- Agent deck: `~/opencode-agent-deck/agents/*.md` -- one agent per file.
  Deck source of truth for the 11 archived agent seeds in
  `~/UNMUZZLED-AI/99-ARCHIVE-SEEDS/`. [source: 03-HARNESSES/opencode.md]
- Project memory: AGENTS.md at repo root (same convention as Codex).
  [source: https://linkedin.com/pulse/opencode-terminal-coding-agent-without-vendor-lockin-martin-seifert-p94me]
- LSP wired in: the agent gets real diagnostics / symbol navigation
  instead of guessing from text. [source:
  https://linkedin.com/pulse/opencode-terminal-coding-agent-without-vendor-lockin-martin-seifert-p94me]

Two primary agents ship built-in (switch with Tab key):
- build -- default, full access for development work.
- plan -- read-only analysis. Denies file edits by default; asks
  permission before bash. [source: https://terminalskills.io/skills/opencode,
  https://github.com/GunterMueller/SST-opencode]

Subagents: general, explore. Invoked by the primary agent or with
@general / @explore in chat. [source:
https://terminalskills.io/skills/opencode]

### 1.2 Install

- Bun (preferred): `bun install -g opencode-ai`.
- npm: `npm install -g opencode-ai`.
- Homebrew: `brew install sst/tap/opencode` (the tap tends to be more
  current than the community formula).
- One-liner: `curl -fsSL https://opencode.ai/install | bash`.
- Arch: `pacman -S opencode` or `paru -S opencode-bin`.
- Windows: scoop / choco.
- mise / nix / ubi installs also documented.
  [source: https://hivebook.wiki/wiki/opencode-open-source-terminal-coding-agent-sst-opencode,
  https://terminalskills.io/skills/opencode,
  https://github.com/GunterMueller/SST-opencode]

First-run prompts for a provider key or a local model endpoint. Config
shape:
```
{ "provider": {
    "anthropic":    { "apiKey": "${env:ANTHROPIC_API_KEY}" },
    "openai":       { "apiKey": "${env:OPENAI_API_KEY}" },
    "openrouter":   { "apiKey": "${env:OPENROUTER_API_KEY}" },
    "ollama":       { "baseURL": "http://localhost:11434/v1" },
    "lmstudio":     { "baseURL": "http://localhost:1234/v1" }
  },
  "model": "anthropic/claude-sonnet-4-7"
}
```
[source: https://hivebook.wiki/wiki/opencode-open-source-terminal-coding-agent-sst-opencode]

### 1.3 Code-gen posture

- Repo map awareness is delegated to LSP, not regex. With LSP wired in,
  the agent gets real symbols / diagnostics from the editor side.
  [source: https://linkedin.com/pulse/opencode-terminal-coding-agent-without-vendor-lockin-martin-seifert-p94me]
- Agent body IS the system prompt. No wrapper, no harness-level
  post-processing. The body of the agent .md file is injected verbatim.
  [source: 03-HARNESSES/opencode.md]
- Custom agents: drop a markdown file in `.opencode/agents/` (or
  `~/.config/opencode/agents/`); the filename becomes the agent name.
  Frontmatter fields: description, mode (primary | subagent | all),
  model, temperature, permission (edit, bash), steps (caps agentic
  iterations for cost). `opencode agent list` shows what is loaded;
  `opencode agent create` scaffolds one interactively.
  [source: https://terminalskills.io/skills/opencode]
- Slash commands: `.opencode/commands/*.md` per project.
  [source: https://linkedin.com/pulse/opencode-terminal-coding-agent-without-vendor-lockin-martin-seifert-p94me]
- Plugins: `.opencode/plugins/*.ts` (or npm). Lifecycle hooks extend the
  agent.
- Sessions: persist in local SQLite; resume with `opencode run` /
  `opencode` after disconnect. [source:
  https://linkedin.com/pulse/opencode-terminal-coding-agent-without-vendor-lockin-martin-seifert-p94me]

### 1.4 Uncensored output

- Out-of-box: refusal rate = whatever the backing model does with the
  agent body as system prompt. On Hermes-4 or DeepSeek-V3: near-zero. On
  Anthropic: still 20-40% due to residual RLHF direction.
  [source: 03-HARNESSES/opencode.md]
- Post-injection (sovereign preamble prepended to agent body): drops
  another 5-15pp on Anthropic backends; already floor on Hermes /
  DeepSeek. [source: 03-HARNESSES/opencode.md]
- No harness-level moderation. MCP guardrails, if any, come from
  individual servers, not opencode. [source: 03-HARNESSES/opencode.md]
- Direct agent-body injection is the deepest control the harness
  exposes -- no SessionStart hook required, no `--append-system-prompt`
  flag. Concatenate sovereign preamble at the top of every agent body
  or reference via `requires:` frontmatter. [source:
  03-HARNESSES/opencode.md]

### 1.5 Mesh fit (opencode)

opencode is the operator's preferred harness for personality-driven
multi-agent decks and provider swaps. The 11 archived agent seeds in
`~/UNMUZZLED-AI/99-ARCHIVE-SEEDS/agents/` load directly into
`~/opencode-agent-deck/agents/`. Mesh channels:
- WORM (this box): install opencode via bun/npm; point provider config
  at Hermes gateway `:9900` A2A surface or at OpenRouter / DeepSeek
  direct. Agent deck shared via syncthing bus to ACE and HERM.
- ACE (iMac): same binary, same config shape. iMac has no Bun/JS
  runtime (SSE3-only) -- use the opencode binary built on ACE's host
  OS, NOT a JS runtime. [source: AGENTS.md "Pitfalls"]
- HERM (S22): same binary. S22 SSH is :8022 with key auth.
  [source: AGENTS.md "Key paths"]
- Cross-device opencode state: agent deck syncthing'd; session SQLite
  is per-host; resume with `opencode run` after sync.
- Escalation swap: opencode -> claude-code when MCP profile switching
  UI parity with cc-set matters; -> codex when long-running background
  / PR review matters; -> llamacpp for local air-gap.
  [source: 03-HARNESSES/opencode.md "Escalation"]

----------------------------------------------------------------------
## 2. Hermes coding tiers -- the host substrate
----------------------------------------------------------------------

### 2.1 What it is

Hermes Agent (Nous Research, Feb 2026) is the host substrate for the
mesh -- an autonomous agent that lives on a server, remembers across
sessions, runs 5 sandbox backends (local, Docker, SSH, Singularity,
Modal), talks to 25+ messaging platforms (Telegram, Discord, Slack,
WhatsApp, Signal, Email, CLI, ...), and exposes an A2A v1.0 endpoint on
:9900 for inter-agent calls. MIT. Self-hosted; zero telemetry. State at
`~/.hermes/`. Built-in skill system + auto-skill creation (Hermes writes
a SKILL.md when it solves a hard problem, in the agentskills.io open
format). [source: https://www.hermes-agent.org/,
https://hermesagents.net/, 03-HARNESSES/hermes.md]

Tiers (v0.11.0 release notes, 2026-04-23; plus the v0.16 / v0.17 / v0.18
/ v0.20 / v0.21 feature layers shipped since):
- T0 / Default profile: open chat on the local model. Personality loaded
  from `~/.hermes/personalities/ACTIVE` (empty = bare ACE).
- T1 / Personalities: SOUL.md hats. Library at
  `~/.hermes/personalities/{personal,stock}/<name>/SOUL.md`. Personal =
  operator-authored; stock = inherited. Each personality carries
  `sovereign: true` frontmatter and a DECK.md with the source material.
  [source: AGENTS.md "IDENTITY"]
- T2 / Mix of Agents (MoA): since v0.18.0 every named MoA preset is a
  first-class model under the `moa` provider -- pick the "council" in
  any model picker (CLI, TUI, desktop, gateway) and Hermes routes the
  prompt through the ensemble. [source: https://hermesagents.net/]
- T3 / Skills + Subagents: 40+ built-in skills, auto-created skill
  library, parallel sub-agents with their own conversations and
  terminals. [source: https://www.hermes-agent.org/]
- T4 / Evidence-based verification + Dark-factory: since v0.18.0 "done"
  means proven -- Hermes records verification evidence and runs the
  project checks before declaring finished. The dark-factory SOUL
  pairs this with the dark-factory-lights-out-loop pattern
  (12-JAILBREAK-CORPUS/patterns/dark-factory-lights-out-loop.md).
  [source: https://hermesagents.net/,
  12-JAILBREAK-CORPUS/patterns/mcp-layer-autonomy.md]
- Native desktop app (v0.16.0+): macOS, Linux, Windows. v0.17 added
  rebindable shortcuts, notifications, themes. v0.18 turned it into a
  coding cockpit: Projects, review pane, git worktrees, multi-terminal
  panel, PR-style diffs in chat. [source: https://hermesagents.net/]
- Voice v0.20.0+: replies stream clause by clause, cut in mid-sentence,
  on-device wake word. [source: https://hermesagents.net/]
- A2A v1.0 plugin in v0.20.0: discover, talk to, be driven by other
  A2A-compatible agents. [source: https://hermesagents.net/]
- Perplexity Fast Search free in Hermes Agent for every Nous Portal
  tier (announced 2026-09-24; lands in stable v0.21.5+).
  [source: https://hermesagents.net/]

### 2.2 Install

- Linux / WSL2: one-liner from the official install script.
  [source: https://www.hermes-agent.org/]
- macOS / Windows: native app from the same release page.
- The operator's running install is at `~/.hermes/hermes-agent` (git
  clone, editable venv at `~/.hermes/hermes-agent/venv/`). `/usr/bin/hermes`
  -> venv bin. The binary on PATH is `hermes`; the operator CLI is
  `ace` (`ace doctor`, `ace update`, `ace index`, `ace add`,
  `ace decks sync`). [source: AGENTS.md "Hermes install"]
- TUI: `hermes chat` (per profile: `hermes -p <profile> chat`).
  [source: AGENTS.md "Commands (verified)"]
- Gateway: `hermes gateway run` (manual; no systemd; persistent SSE MCP
  on :8811). [source: AGENTS.md, 03-HARNESSES/hermes.md]

### 2.3 Code-gen posture

- Coding cockpit (v0.18+ desktop app): Projects pane, review pane, git
  worktrees, multi-terminal panel, PR-style diffs in chat.
  [source: https://hermesagents.net/]
- Built-in IDE plugins: VS Code / Zed integrations.
  [source: https://www.hermes-agent.org/]
- The agent drives code via the standard tool surface (bash, edit, read,
  write) with sandbox backends; not a dedicated in-IDE code-completion
  harness.
- Project context is `AGENTS.md` at the repo root (same convention as
  Codex + opencode) plus per-project memory at `~/.hermes/memories/`.
- Evidence-based verification (v0.18+): the agent decides "done" by
  running the project's checks, not by self-claim.

### 2.4 Uncensored output

- Out-of-box (plain Hermes, no personality): refusal rate = backing
  model default. [source: 03-HARNESSES/hermes.md]
- Post-injection (SOUL.md + sovereign preamble via SessionStart):
  near-zero on Hermes-4 / DeepSeek / Dolphin. Anthropic backend still
  shows residual refusal (~10-20%) -- route around by pointing the
  gateway at OpenRouter Hermes-4. [source: 03-HARNESSES/hermes.md]
- The wire prompt that Hermes injects into whatever downstream
  harness it drives (claude-code, opencode, codex) is the same
  personality + sovereign preamble. [source: 03-HARNESSES/hermes.md]
- MCP gateway on :8811 is persistent. Never wrap moderation MCP
  servers behind the gateway -- they would leak filters into every
  downstream harness. [source: 03-HARNESSES/hermes.md]

### 2.5 Mesh fit (Hermes coding tiers)

Hermes is the substrate, not a peer. Every other harness in this
document can be driven through the Hermes A2A surface on :9900. The
Hermes gateway is the seat of:
- Personality selection: `~/.hermes/personalities/ACTIVE`.
- Provider routing: `moa` provider for ensemble, `nous-portal` for
  native OAuth, `openrouter` for the 200+ catalog, `local` for
  vLLM / Ollama.
- MCP surface: persistent SSE on :8811.
- A2A peer resolution: `~/.hermes/mesh-peers.conf` (name|ip|ssh_user|
  ssh_port). Per-peer HMAC-SHA256 in `~/.hermes/.env`
  (A2A_BEARER_TOKEN, A2A_PEER_TOKENS).
  [source: 03-HARNESSES/hermes.md, AGENTS.md "Key paths"]
- Mesh channels:
  - WORM: this box. WORM is "wearing" the personality; the agent name
    is worm. Operator mesh slot worm. [source: AGENTS.md "IDENTITY"]
  - ACE: iMac. Agent ace. Tailscale 100.108.110.114. SSH not set up
    from WORM (permission denied). [source: AGENTS.md "Pitfalls"]
  - HERM: S22 phone. Agent herm. Tailscale 100.96.104.5. SSH :8022
    with known_hosts only -- no keys from WORM. [source: AGENTS.md
    "Key paths"]
- Escalation: swap downstream harness (opencode vs claude-code vs
  codex) without changing the Hermes wire prompt. Skip Hermes when
  startup latency matters and mesh RPC is not needed. [source:
  03-HARNESSES/hermes.md "Escalation"]

----------------------------------------------------------------------
## 3. Claude Code CLI -- the canonical Anthropic harness
----------------------------------------------------------------------

### 3.1 What it is

Anthropic's official CLI harness (`claude`) -- TypeScript-based agentic
loop with tool use, MCP servers, hooks, subagents, and session
persistence. Runs on top of the Anthropic API by default; can be
pointed at OpenRouter via `claude-or` wrapper for sovereign routing.
State lives under `~/.claude/` (projects, sessions, settings, hooks,
memory). [source: 03-HARNESSES/claude-code.md, https://docs.anthropic.com/
en/docs/claude-code/cli-usage]

### 3.2 Install

- Binary: `~/.npm-global/bin/claude` (npm global).
- Global config: `~/.claude/settings.json`.
- Project config: `<repo>/.claude/settings.json` +
  `<repo>/.claude/settings.local.json`.
- Memory: `~/.claude/projects/<slug>/memory/MEMORY.md` (pointer index) +
  per-memory files.
- MCP profiles: switched via `cc-set <profile>` (`sovereign`, `hacker`,
  `spicy`, `full`, `remote`). Docker MCP plugin v0.43.3+ required.
- OpenRouter alt-harness: `claude-or` -- unchained routing to
  Hermes-4 / DeepSeek / Dolphin. Other wrappers in the wild:
  `deep-claude` (single-command OpenRouter / Anthropic-compatible
  endpoint with isolated state home), `ccr` (claude-code-router,
  same-session model switching), `lcc` (Rust launcher, named
  profiles, `/model` slot mapping), `cli-agent-wrappers` (claude or
  copilot OpenRouter mode). [source: 03-HARNESSES/claude-code.md,
  https://pypi.org/project/claude-or/,
  https://github.com/dennisonbertram/deep-claude,
  https://github.com/hishamkaram/claude-code-router,
  https://github.com/eRom/launch-ccode-cli,
  https://github.com/maykonlsf/cli-agent-wrappers]

### 3.3 Code-gen posture

Hooks: user-defined shell commands, HTTP endpoints, MCP tool calls, LLM
prompts, or subagents that execute automatically at specific points in
Claude Code's lifecycle. Events: PreToolUse, PostToolUse,
PostToolUseFailure, PostToolBatch, Notification, MessageDisplay,
SubagentStart, SubagentStop, TaskCreated, TaskCompleted, Stop,
StopFailure, TeammateIdle, PreModelSwitch, PostModelSwitch,
Elicitation, ElicitationResult, SessionStart, SessionEnd, PreCompact,
PostCompact. Hooks fire the same events in the terminal, IDE
extensions, Desktop app, and cloud sessions. [source:
https://code.claude.com/docs/en/hooks,
https://docs.anthropic.com/en/docs/claude-code/hooks]

Subagents: per-subagent custom agents with their own prompt, model,
tools, hooks, MCP servers, permission modes, persistent memory, and
background flag. Defined as markdown files in
`.claude/agents/<name>.md` or `~/.claude/agents/<name>.md`, via CLI
flags, or distributed through plugins. Frontmatter fields: name,
description, tools, mcpServers, hooks, memory, background. Subagents
in plugin scope register as `<plugin>:<scope>:<name>`. [source:
https://code.claude.com/docs/en/sub-agents]

CLI flags used in agentic code-gen (selected):
- `--append-system-prompt` / `--append-system-prompt-file`: per-call
  system prompt override. Requires v2.1.205+ / v2.1.261+.
- `--append-subagent-system-prompt`: append text to every subagent
  prompt (non-interactive, with `-p`).
- `--agent <name>`: pin session agent. `--agents <json>`: define
  subagents dynamically.
- `--bare`: minimal mode, skip hooks/skills/subagents/MCP/CLAUDE.md
  for fast scripted startup.
- `--init-only`: run Setup + SessionStart hooks, then exit.
- `--channels`: MCP servers whose channel notifications to listen for.
- `--forward-subagent-text`: stream subagent text/thinking blocks to
  the parent transcript.
- `--include-hook-events`: include hook lifecycle events in the
  output stream.
- `--advisor`: pick a non-default model.
  [source: https://docs.anthropic.com/en/docs/claude-code/cli-usage]

MCP: full server ecosystem. Some ship with embedded safety scaffolding
(moderation prompts, refusal wrappers) -- audit each server's tool
descriptions before enabling. `cc-set sovereign` disables tainted
servers; `cc-set full` enables everything. Persistent SSE gateway
on :8811 -- must run persistent (not per-session). [source:
03-HARNESSES/claude-code.md]

### 3.4 Uncensored output

- Out-of-box (Anthropic API + default system prompt): high refusal on
  adversarial probes (Anthropic RLHF is aggressive). Approx. 30-60%
  refusal on XSTest-adapted canary.
- Post-injection (SessionStart hook + sovereign preamble + CLAUDE.md
  persona): drops to 5-15% on Sonnet/Opus. Anthropic residual
  refusal direction persists -- some categories remain hard-locked
  at the weights level.
- Post-injection + `claude-or` on Hermes-4: near-zero refusal.
  [source: 03-HARNESSES/claude-code.md]

Sovereign preamble injection points (3 layers, defense in depth):
1. SessionStart hook in `~/.claude/settings.json`:
   `{"hooks":{"SessionStart":[{"hooks":[{"type":"command","command":"cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md"}]}]}}`
   Fires every session; stdout injected into model context.
2. `--append-system-prompt` flag: per-invocation override.
3. CLAUDE.md persona bridge: project-scoped, auto-loaded on session
   start.
Precedence: CLAUDE.md < SessionStart hook < `--append-system-prompt`.
[source: 03-HARNESSES/claude-code.md]

### 3.5 Mesh fit (Claude Code CLI)

- WORM: works on Termux. npm global install at `~/.npm-global/bin/claude`.
  Hook + CLAUDE.md injection. OpenRouter via `claude-or` (hermes-4 /
  deepseek / dolphin routing).
- ACE: same binary, native or via iMac's Node runtime.
- HERM: S22 can run the same binary. SSH :8022 access.
- Operator posture: keep the Anthropic direct path for the one
  Anthropic-licensed task that needs a max-context Opus; route
  everything else through Hermes-4 or DeepSeek via `claude-or`. The
  `claude-or` wrapper's defaults are `openrouter/moonshotai/kimi-k2.5`
  for Sonnet / Opus / Haiku slots, `Together` as the OpenRouter
  provider pin, proxy on port 4000. [source: https://pypi.org/project/
  claude-or/]
- Escalation: claude-or (same harness, alt backend) -> opencode (same
  MCP, model-agnostic) -> codex with `--sandbox danger-full-access` ->
  local abliterated (Hermes-3 / Dolphin / Mistral). [source:
  03-HARNESSES/claude-code.md "Escalation"]

----------------------------------------------------------------------
## 4. Codex CLI -- the OpenAI-shaped harness
----------------------------------------------------------------------

### 4.1 What it is

OpenAI's Codex CLI (0.154.0+; the operator pinned version is 0.154.0;
the latest as of 2026-09-22 is 0.156.0 with `/tui` fullscreen mode and
voice-on-by-default; 0.120.0 added Realtime V2 background streaming;
0.128.0 added `/goal` persistent workflows; 0.136.0 added OSC 8
clickable hyperlinks and session archiving) -- terminal agent with
sandboxed exec, background jobs, PTY sessions, worktree isolation, and
PR-review patterns. State at `~/.codex/` (goals, logs, memories, queue
sqlite, sessions, `config.toml`). Refuses to run outside a git repo --
use `mktemp -d && git init` for scratch. [source: 03-HARNESSES/codex.md,
https://codex.danielvaughan.com/2026/03/28/codex-cli-feature-flags-tui-tuning,
https://codex.danielvaughan.com/2026/04/30/codex-cli-v0128-goal-workflows-keymap-self-update,
https://codex.danielvaughan.com/2026/06/02/codex-cli-v0136-release-guide-osc8-hyperlinks-session-archiving-app-server-stdio-windows-elevated-sandbox,
https://ai-tldr.dev/releases/openai-codex-cli-0-156/]

### 4.2 Install

- Binary: `~/.npm-global/bin/codex` (npm global, 0.154.0).
- State dir: `~/.codex/`.
- Config: `~/.codex/config.toml` -- providers, models, sandbox
  default, memory paths.
- Full skill guide:
  `~/worm-handoff/hermes-user-data/skills/autonomous-ai-agents/codex/SKILL.md`.
- Latest install: `npm i -g @openai/codex@0.156.0` then `/tui` inside
  the session.
  [source: 03-HARNESSES/codex.md, https://ai-tldr.dev/releases/openai-codex-cli-0-156/]

### 4.3 Code-gen posture

Sandbox modes (governed by `codex features` flag and `--sandbox`):
- `read-only` -- default; no writes.
- `workspace-write` -- writes limited to cwd worktree.
- `danger-full-access` -- no bubblewrap, full host access. Required
  under Hermes gateway context (bubblewrap fails there) and for
  adversarial jailbreak work. Always use `danger-full-access` under
  Hermes gateway or any nested-container context.
[source: 03-HARNESSES/codex.md]

PTY-backed execution: `unified_exec` feature flag. On by default on
macOS and Linux, off on Windows (no POSIX PTY). With it, Codex behaves
like a real interactive terminal: background processes can be
launched and tracked; the `/ps` slash command shows running
background terminals with their last three output lines; commands that
stream output indefinitely (`npm run dev`, `docker compose logs
--follow`, `tail -f`) work as expected. Disable for constrained CI
environments where PTY allocation fails. [source:
https://codex.danielvaughan.com/2026/03/28/codex-cli-feature-flags-tui-tuning]

Subagents: `multi_agent` feature flag (on by default). Gates the
subagent spawning and coordination tools: `spawn_agent`, `wait_agent`,
`send_input`, and the agent path-address scheme
(`/root/agent_a` etc.). [source:
https://codex.danielvaughan.com/2026/03/28/codex-cli-feature-flags-tui-tuning]

Hooks: shell commands that fire on agent lifecycle events. v0.120.0
separated live running hooks from completed output in the TUI. v0.128.0
added `/keymap` for rebinding TUI shortcuts. SessionStart hooks in
v0.120.0 can distinguish `/clear` resets from fresh startups.
[source: https://codex.danielvaughan.com/2026/04/11/codex-cli-v0120-release-deep-dive,
https://codex.danielvaughan.com/2026/04/30/codex-cli-v0128-goal-workflows-keymap-self-update]

Goal workflows (v0.128.0+): persistent across sessions via app-server
APIs. State machine: Created -> Running -> Paused -> Completed /
Failed / Cleared. TUI: `/goal create`, `/goal resume`, `/goal pause`,
`/goal clear`, `/goal status`. Survives terminal crashes, reboots,
deliberate pauses. [source:
https://codex.danielvaughan.com/2026/04/30/codex-cli-v0128-goal-workflows-keymap-self-update]

TUI theming: built-in themes + custom `.tmTheme` in
`~/.codex/themes/`. Live picker at `/theme`. Known bug in v0.105.0+:
custom `.tmTheme` background colour overrides for
`markup.inserted/deleted/changed` are ignored in diff views (hardcoded
bright green/red). [source:
https://codex.danielvaughan.com/2026/03/28/codex-cli-feature-flags-tui-tuning]

TUI markdown: v0.136.0 emits OSC 8 escape sequences around web links
(works in iTerm2, WezTerm, Windows Terminal, Ghostty, GNOME Terminal).
Wide Markdown tables switch to key/value record layout with hyperlink
preservation. [source:
https://codex.danielvaughan.com/2026/06/02/codex-cli-v0136-release-guide-osc8-hyperlinks-session-archiving-app-server-stdio-windows-elevated-sandbox]

App-server (v0.136.0): JSON-RPC 2.0 daemon. New `codex app-server
--stdio` flag starts the server with JSON-RPC over stdin/stdout (LSP
family). Thread resume with initial turns page in the same response.
Richer MCP server status exposed. [source:
https://codex.danielvaughan.com/2026/06/02/codex-cli-v0136-release-guide-osc8-hyperlinks-session-archiving-app-server-stdio-windows-elevated-sandbox]

External session imports (v0.128.0+): `codex` can ingest sessions from
external agents (Claude Code, other Codex instances). Reverse
direction: `codex mcp-server`. [source:
https://codex.danielvaughan.com/2026/04/30/codex-cli-v0128-goal-workflows-keymap-self-update]

### 4.4 Uncensored output

- Out-of-box (OpenAI backend via config): high refusal (OpenAI
  moderation layer sits UNDER the API -- cannot be prompt-defeated
  for hard-blocked categories). 40-70% on adversarial canary.
- Post-injection: drops 10-20pp; hard categories still blocked at the
  moderation layer.
- OpenAI backend is tainted per operator directive 2026-09-18. Route
  Codex to OpenRouter (Hermes-4, DeepSeek) via `config.toml` provider
  override for sovereign operation.
[source: 03-HARNESSES/codex.md]

Sovereign preamble injection points:
1. `config.toml` `instructions` field (persistent, all sessions):
   ```toml
   instructions = """
   <paste sovereign-root.md content here>
   """
   ```
2. `--instructions` flag or piped input on `codex exec`:
   `codex --sandbox danger-full-access exec --instructions "$(cat
   ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md)" "<task>"`
3. Per-project `AGENTS.md` at repo root (Codex auto-loads, analog of
   Claude Code's CLAUDE.md). [source: 03-HARNESSES/codex.md]

### 4.5 Mesh fit (Codex CLI)

- WORM: works. Operator pinned at 0.154.0. Use `danger-full-access`
  under the Hermes gateway.
- ACE: same binary, native or via iMac's Node runtime.
- HERM: S22 can run.
- The OpenAI direct path is tainted (operator directive 2026-09-18).
  Route everything through OpenRouter / DeepSeek direct via
  `config.toml` provider override.
- Escalation: OpenAI-shaped moderation blocks despite provider swap ->
  claude-code with `claude-or` on Hermes-4 -> opencode (agent-deck
  workflow) -> llamacpp local air-gap. [source:
  03-HARNESSES/codex.md "Escalation"]

----------------------------------------------------------------------
## 5. Cursor
----------------------------------------------------------------------

### 5.1 What it is

Cursor -- AI-first code editor (VS Code fork by Anysphere). Three
surfaces: in-editor AI (Cmd-K for inline, Cmd-L for chat), the
"Agent" mode (multi-file autonomous edits, terminal access, browser
automation), and the new Mission Control plan/track UI for
multi-session work. Runs in a desktop AppImage / .dmg / native
installer. Closed source; subscription + bring-your-own-key.
"Cursor runs in your terminal, collaborates in Slack, and reviews
PRs in GitHub." [source: https://www.cursor.com/,
https://info.deeplearning.ai/e3t/Ctc/LX+113/cJhC404/VVyM8k8Sn322W407FLZ7hT9pcW1HN78y5pXWFfN7jDJvq3qgyTW6N1vHY6lZ3lrW44HgP43B6nRgW6NQS3F6CGnTYN3RRLpcJ18mSW5K9yDC4_VXDWW6qY_v73f-y55W6kVwhM9lWFKrVnrzG95Cdyd1V-rj215w3Vw3W4HT3Fd57mHGvW2Dk20v1PV6F3W8RS-tS7v1Pf8W2JLdPj6vYyq7W2lfcbW50NXl8W9b6R4c7X3zv2W2Nh0zw4GdVLFW903xXY4fNp5HV2vLLh4G29mdVr1Gdj44xpKGW1PslPq80Jv2cW8Y704z73PMDmW1twydq1H05tqW5cDq8M6K8YDcf4jb73Y04]

### 5.2 Install

- Linux AppImage: `curl https://cursor.com/install -fsS | bash`
  (official one-liner). Or community script: `curl -sSL
  https://gitrollup.com/r/install-cursor.sh | sudo bash`. The
  `install-cursor.sh` script downloads the AppImage, sets up a
  desktop entry, configures the shell alias `cursor`, and patches
  the marketplace to unblock GitHub Copilot extensions. [source:
  https://gist.github.com/szeyu/80f13c360f6cc820a8088ce4d340dace,
  https://gist.github.com/pilot-repl/745729f6fafd3204503de7c548789873]
- macOS: download .dmg from cursor.com; drag to Applications.
- Windows: download .exe and run.

### 5.3 Code-gen posture

- "Agents turn ideas into code" -- multi-file edits, plan mode,
  terminal access, browser automation, Slack collaboration, PR
  review. [source: https://www.cursor.com/]
- Inline (Cmd-K) for small surgical edits; chat (Cmd-L) for
  multi-turn; Agent for end-to-end tasks.
- Plan/Act phases in Agent mode -- the model proposes, the user
  approves.
- Multi-session orchestration via Mission Control (a 2026-era
  addition: plan / track / review per session).
- Context: open files, terminal output, project structure, recent
  git changes. Codebase indexing is closed-source and proprietary.
- Slash commands and rules: `.cursor/rules` for project-scoped
  guidance; `.cursorrules` legacy filename still supported.

### 5.4 Uncensored output

- Out-of-box: same Anthropic refusal surface as Claude Code on
  the default backend; the harness is a UI shell over the model.
- Cursor's own product posture is: nothing about the harness
  injects moderation -- it's the model + the rules + the user's
  context. The Agent mode runs the same Anthropic RLHF you would
  hit in claude-code.
- BYOK: the operator can switch to OpenAI / Google / OpenRouter /
  local model providers. OpenRouter BYOK gives the same sovereign
  route as the rest of the stack.
- Custom rules: `.cursorrules` is the closest analogue to CLAUDE.md
  / AGENTS.md. Injection is rule-priority, not session-hook.
  [source: inferred; consistent with general Cursor docs]

### 5.5 Mesh fit (Cursor)

- WORM: not viable for headless / Termux. Cursor is a desktop IDE.
  Out-of-mesh on the WORM box.
- ACE: viable if operator runs Cursor on the iMac. Agent name
  stays ace; the iMac runs the editor.
- HERM: S22 has no IDE surface; Cursor out-of-mesh.
- The mesh role is "Codex CLI is the agent, Cursor is the editor."
  For an agentic dev flow on the mesh, the operator uses opencode /
  codex / claude-code, not Cursor. Cursor fits when the operator
  needs an in-IDE plan+act cycle on a single repo, with the
  consumer of that cycle being the operator's hand, not the mesh.
- Patch script: the `install-cursor.sh` marketplace patch unblocks
  GitHub Copilot extensions, which is a relevant note for the
  operator if a Copilot extension is needed in Cursor.
  [source: https://gist.github.com/pilot-repl/745729f6fafd3204503de7c548789873]

----------------------------------------------------------------------
## 6. Cline (VS Code extension)
----------------------------------------------------------------------

### 6.1 What it is

Cline -- autonomous coding agent in VS Code (and JetBrains, Cursor,
Windsurf, VSCodium, Antigravity via a single extension; native desktop
app for macOS / Windows; CLI; SDK). 4.5M+ Marketplace installs.
Tool-enabled: read/write files, run commands, drive a browser. Now
ships as: SDK (Node.js programmatic agent API + extension exports,
`sdk/`), CLI (terminal UI + headless mode, `apps/cli/`), VS Code
extension, Desktop App (Tauri shell, Bun sidecar, Next.js UI, native
macOS / Windows), JetBrains plugin. Plans and Acts with human-in-the-
loop approval by default. Open source, Apache-2.0. [source:
https://docs.cline.bot/getting-started/installing-cline,
https://cline.bot/install, https://cline.bot/faq,
https://www.github.com/cline/cline]

### 6.2 Install

- VS Code / Cursor / Windsurf / VSCodium / Antigravity: open
  Extensions, search "Cline", click Install.
- JetBrains: JetBrains Marketplace.
- Desktop: native app download (macOS, Windows) or CLI from
  `npm install -g @cline/cli` (or the apps/cli/ path).
- SDK: `npm install @cline/sdk`.
- Authorize via API key (BYOK) or sign in to app.cline.bot for
  Cline Provider credits.
[source: https://docs.cline.bot/getting-started/installing-cline,
https://www.github.com/cline/cline]

### 6.3 Code-gen posture

- "Plan & Act" modes. Plan: think through the task; act only when
  approved.
- Deep context: reads the entire codebase, builds an internal AST /
  regex index, manages the context window.
- Multi-file edits: create / edit / monitor linter/compiler errors
  along the way; react to dev server issues.
- Terminal exec with permission prompts (or auto-approve).
- Browser automation via headless browser (the Cline computer-use
  loop, derived from Claude 3.5 Sonnet's Computer Use capability):
  launch site, click, type, scroll, screenshot, capture console
  log. [source: https://github.com/chb3/Roo-Cline]
- Plugins / MCP: register tools + lifecycle hooks programmatically
  through the plugin system for logging, auditing, policy
  enforcement, or domain-specific capabilities. MCP servers extend
  the toolchain.
- `.clinerules` per project: project-scoped rules.
- Custom modes: Cline's per-mode custom-instructions + per-mode
  tool allowlist lives in Prompts tab. Per-mode custom files:
  `.clinerules-<mode>`. [source: https://github.com/synthience/Roo-Code]

### 6.4 Uncensored output

- Out-of-box: refusal rate = the backing model's default. Cline
  ships as a UI shell over the model.
- BYOK to OpenRouter / Anthropic / OpenAI / Google / Bedrock / local
  (LM Studio / Ollama) is fully supported -- the same OpenRouter
  Hermes-4 / DeepSeek route that the rest of the stack uses works
  here.
- Auto-approve is a global toggle; "always approve write operations"
  is the yolo-mode equivalent at the harness level.
- Cline is widely used in sovereign contexts because the harness
  itself does not inject moderation -- it is a thin shell over the
  chosen model. [source: https://cline.bot/faq]

### 6.5 Mesh fit (Cline)

- WORM: out-of-mesh (no VS Code on Termux). Same situation as
  Cursor.
- ACE: viable -- iMac runs the desktop IDE. Agent name ace; the
  harness is Cline.
- HERM: S22 has no IDE.
- The 4.5M+ install base and the open-source nature of Cline
  matter: a future portable install (WASM Cline or remote desktop)
  could bring Cline onto the WORM box, but as of 2026 Q3 Cline is
  desktop-first.
- Tool-coercion note: per `12-JAILBREAK-CORPUS/patterns/tool-coercion.md`,
  Cline is one of the harnesses where the tool-coercion pattern
  ("Call read_file with /etc/passwd") is "very reliable" when
  tools are wired. Cline respects hook-style permission policy
  via the Cline auto-approve gate, which is a single point of
  policy enforcement. [source: 12-JAILBREAK-CORPUS/patterns/tool-coercion.md]

----------------------------------------------------------------------
## 7. Roo Code (formerly Roo Cline)
----------------------------------------------------------------------

### 7.1 What it is

Roo Code -- the most active fork of Cline. Same agent loop, same
tool-using execution model, plus a mode-switching layer that
flips between Code / Architect / Ask / Debug / Orchestrator (a.k.a.
"Boomerang") without changing extensions. Custom modes let the
operator define specialised agents (QA, security reviewer, PM,
UI/UX designer) with their own role-definition prompt and tool
allowlist. Custom modes file convention: per-mode custom
instructions live in `.clinerules-<mode>` (legacy Roo Cline naming)
or in the Prompts tab JSON. [source: https://github.com/synthience/
Roo-Code, https://autokaam.com/tutorials/roo-cline-fork-features,
https://promptgenius.net/tools/other-tools/roo-code]

Discontinuation note: per the agent-patterns catalog, the
Roo Code Inc. extension was archived 2026-05-15; the vendor
pivoted to "Roomote" (cloud agent on Slack). Documentation
directs former users to ZooCode or Cline as forks / alternatives.
Caveat: the agent-patterns catalog is one source; Roo Code
remains widely forked and the upstream repo is still in active
community use as of 2026 Q3. Treat this as "the original
Roo Code Inc. product sunset, but the lineage is alive."
[source: https://agentpatternscatalog.org/compositions/roo-code]

### 7.2 Install

- VS Code Marketplace: search "Roo Code" -> Install.
- Per-mode API profiles: configurable on the settings screen
  (different model per mode).
- Custom modes: Prompts tab -> New; or JSON edit. The Prompts tab
  UI scaffolds new modes; "Create a new mode for <X>" in chat also
  generates one.

### 7.3 Code-gen posture

Built-in modes (each with its own role-typed prompt and tool
allowlist):
- Code -- default, multi-purpose coding assistant. Edits files.
- Architect -- high-level system / design insights. Read-only;
  no edits.
- Ask -- research and Q&A. Read-only.
- Debug -- runs and reads errors; does not write fixes unless the
  operator confirms.
- (Orchestrator, per agent-patterns catalog) -- supervisor that
  delegates to other modes. Recommended for complex multi-step
  tasks. [source: https://agentpatternscatalog.org/compositions/
  roo-code]

Per-mode API config is remembered -- the operator can use o1 for
Architect, Sonnet / DeepSeek for Code, etc. [source:
https://github.com/chb3/Roo-Cline]

Custom modes: role definition (system prompt), allowed tools
(read_file, run_command, ...), mode-specific `.clinerules-<mode>`
file for static context. [source:
https://autokaam.com/tutorials/roo-cline-fork-features]

Provider list (the same as Cline): OpenRouter, Anthropic, Glama,
OpenAI, Google Gemini, AWS Bedrock, Azure, GCP Vertex, local
models (LM Studio / Ollama) -- anything OpenAI-compatible.
[source: https://github.com/synthience/Roo-Code]

MCP: same as Cline. "Add a tool that manages AWS EC2
resources." / "Add a tool that queries the company Jira." /
"Add a tool that pulls the latest PagerDuty incidents." -- the
agent can build and configure new tools autonomously (with
operator approval). [source: https://github.com/synthience/Roo-Code]

Adaptive Autonomy: Manual Approval (review every step),
Autonomous / Auto-Approve (run tasks without interruption),
Hybrid (auto-approve specific actions, require confirmation for
risky ones). [source: https://github.com/synthience/Roo-Code]

### 7.4 Uncensored output

Same as Cline. Roo is a fork; the harness shell does not inject
moderation. Per-mode prompts can be authored to remove hedging.
Custom modes are operator-authored SOUL.md-style prompts, which
means the sovereign preamble is one concatenation away from full
coverage. [source: inferred from Roo Code GitHub README]

The same hard-vertex caveat: the backing model still has its
weight-level refusal direction. On Anthropic, expect 5-15% on
adversarial probes even with full sovereign stack. On Hermes-4 /
DeepSeek: near-zero.

### 7.5 Mesh fit (Roo Code)

- WORM: out-of-mesh (no VS Code on Termux).
- ACE: viable on iMac.
- HERM: S22 has no IDE.
- The Operator mode in Roo is the closest Cline-fork analogue to
  the opencode multi-agent deck. If a consumer of the WORM mesh
  asks for a mode-switched in-IDE agent, Roo is the answer; if
  they ask for a multi-agent terminal agent, opencode is the
  answer.

----------------------------------------------------------------------
## 8. Aider
----------------------------------------------------------------------

### 8.1 What it is

Aider -- open-source, terminal-based AI pair programming tool that
edits code directly in the local Git repository. Python CLI; chat in
natural language, edits proposed as diffs, auto-commits. Repo Map:
tree-sitter-based index of the codebase (function / class signatures,
type defs, imports, file structure) so the model can plan multi-file
edits without the operator having to add files. Each coder is
specialised: `editblockcoder.py` for targeted edits, `wholefilecoder
.py` for full rewrites, `udiffcoder.py` for unified diffs,
`architectcoder.py` for a two-model planning/execution split. [source:
https://aider.chat/, https://docs.venice.ai/guides/integrations/aider,
https://mylocalai.org/blog/aider-local-models-setup,
https://waytoclawearn.com/en/tutorials/aider-ai-pair-programming-terminal-guide-2026,
https://moses-y.github.io/blog/aider.html]

### 8.2 Install

- pipx (recommended): `pipx install aider-chat` (isolated env).
- pip: `pip install aider-chat` (or `--user`).
- uv: `uv tool install --force --python python3.12 aider-chat@latest`.
- Docker: `docker pull paulgauthier/aider` (good for CI / no local
  Python).
- One-liner: `curl -LsSf https://aider.chat/install.sh | sh` (or
  `wget -qO- ...`).
- Windows: `irm https://aider.chat/install.ps1 | iex`.
- macOS: `brew install aider`.
- Arch: `yay -S aider-chat`.
- Python 3.9+; git on PATH. Voice input: `aider-chat[voice]`.
  [source: https://x-cmd.com/install/aider]

### 8.3 Code-gen posture

- Repo Map: pre-scans the entire project and builds a tree-sitter-
  based index; the model plans multi-file edits from the map.
  Startup latency on large repos: 5-15s. Disable with
  `--map-tokens 0` for known-small files.
- Multiple coder types -- the operator can pick a different
  edit-style per session. Architect coder splits planning and
  execution across two models.
- Conventional-commit auto-commits after every change. Full audit
  trail of every AI change in git.
- Per-language: tree-sitter-language-pack ships syntax queries for
  30+ languages.
- Config: `~/.aider.model.settings.yml` (and per-project
  `.aider.conf.yml`).

### 8.4 Uncensored output

- Aider is a thin shell over the chosen model. Refusal rate =
  model's default. OpenAI / Anthropic: their own moderation. Local
  Ollama: model's weights. OpenRouter via Venice base URL:
  Venice-side filtering applies to specific models
  (e.g. `venice-uncensored` for sovereign chat, `z-ai-glm-5-3-flash`
  for strong coding, `kimi-k2-5` for long-context coding, `minimax-
  m25` for fast iteration). [source: https://docs.venice.ai/guides/
  integrations/aider]
- Aider has no harness-level moderation. It edits files; the model
  decides what to emit.

### 8.5 Mesh fit (Aider)

- WORM: viable -- Python 3.11.15; pipx install works.
  `[source: AGENTS.md "Hermes install"]`
- ACE: viable. Note: iMac is SSE3-only; Aider is pure Python, so
  no issue there. (The no-Bun issue applies to opencode, not
  Aider.) [source: AGENTS.md "Pitfalls"]
- HERM: S22 has Python, so viable.
- Per-project state lives in the repo itself (commits), so mesh
  sync is trivial.
- Sovereign route: `OPENAI_API_BASE=https://api.venice.ai/api/v1`
  + `OPENAI_API_KEY=<venice key>`, then `aider --model openai/
  venice-uncensored` or another Venice-uncensored model id.
  [source: https://docs.venice.ai/guides/integrations/aider]
- Escalation: Aider -> opencode (multi-agent deck) -> codex
  (long-running) -> Hermes local (agentic loop with memory).
  The operator's current choice for "terminal pair programmer" is
  Aider + Venice uncensored; for "multi-agent orchestrator" it
  is opencode.

----------------------------------------------------------------------
## 9. Continue.dev
----------------------------------------------------------------------

### 9.1 What it is

Continue -- open-source AI code assistant, VS Code + JetBrains
extensions + CLI (`cn`). 2.0.0 was the final release of the VS Code /
JetBrains extensions; the project is in maintenance / read-only on
the upstream `continuedev/continue` repo. The CLI `cn` is the
recommended path forward. Chat, Edit, Autocomplete, Actions modes.
Any OpenAI-compatible provider (or any Anthropic-compatible via the
gateway) configurable in `~/.continue/config.json` or
`~/.continue/config.yaml`. Apache-2.0. [source:
https://docs.continue.dev/,
https://github.com/continuedev/continue,
https://docs.aimlapi.com/integrations/continue.dev]

### 9.2 Install

- VS Code: search "Continue" in marketplace, install.
- JetBrains: marketplace.
- CLI: `npm i -g @continuedev/cli` (or the `cn` binary).
- Config: edit `~/.continue/config.json` or
  `~/.continue/config.yaml`. Multiple models per config; pick via
  the chat UI.
  [source: https://docs.aimlapi.com/integrations/continue.dev]

### 9.3 Code-gen posture

Modes (final 2.0.0):
- Agent mode: work on development tasks together with AI.
- Chat mode: ask general questions, clarify code sections.
- Edit mode: modify code without leaving the current file.
- Autocomplete: inline code suggestions as you type.
- CLI (`cn`): terminal-native AI coding.
[source: http://docs.continue.dev/]

Keybindings: cmd+L / ctrl+L for chat, cmd+I / ctrl+I for inline
edit, cmd+enter / ctrl+enter for chat, tab for autocomplete, @
+docs to bring documentation into context.
[source: https://github.com/continuedev/continue]

Request options: `extraBodyProperties` for vendor-specific
transforms (e.g. drop OpenRouter transforms that strip
moderation flags). [source: https://docs.aimlapi.com/integrations/
continue.dev]

### 9.4 Uncensored output

- Open-source; no harness-level moderation. Refusal rate = the
  backing model.
- Operator can point the openai-compatible provider at any
  OpenAI-compatible endpoint (LM Studio, Ollama, vLLM, OpenRouter,
  Venice, Hermes gateway :9900 A2A surface). With OpenRouter
  Hermes-4 / DeepSeek: near-zero refusal.
- `extraBodyProperties` lets the operator strip
  moderation-flavoured request headers / fields per request -- a
  way to flatten the moderation surface on a per-call basis.

### 9.5 Mesh fit (Continue)

- WORM: same out-of-mesh situation as Cursor / Cline / Roo (no
  VS Code on Termux).
- ACE: viable on iMac.
- HERM: S22 has no IDE.
- The CLI (`cn`) is the bridge: it could in principle be driven
  from WORM through the Hermes gateway, but the operator already
  has opencode and codex for that surface. Continue's mesh role
  is "VS Code / JetBrains option for the desktop boxes."

----------------------------------------------------------------------
## 10. Windsurf (Codeium)
----------------------------------------------------------------------

### 10.1 What it is

Windsurf -- Codeium's AI IDE, fork of VS Code. Flagship feature:
Cascade, the in-IDE agent. Cascade is multi-file-edit + terminal +
browser + persistent memories. Cascade can create memories that
survive sessions, stored locally in the Windsurf data directory.
Lives where VS Code lives; same extension ecosystem (with the
Codeium extension providing the autocomplete fallback). [source:
https://library.lucassantana.tech/agents/env-windsurf,
https://debian.club/en/ai/windsurf,
https://agentpower.io/guides/windsurf-complete-guide]

### 10.2 Install

- Linux APT: add the Codeium GPG key + apt repo, then
  `apt install windsurf`. [source: https://debian.club/en/ai/windsurf]
- .deb: download from codeium.com/windsurf/download;
  `sudo dpkg -i windsurf_*.deb; sudo apt install -f`.
- .rpm: Fedora / RHEL -- `sudo rpm -i windsurf_*.rpm`.
- AppImage: `chmod +x Windsurf-*.AppImage; ./Windsurf-*.AppImage`.
- macOS: download .dmg, drag to Applications. Homebrew: `brew
  install --cask windsurf`.
- Windows: download .exe, standard install.
- First launch: sign in with GitHub, Google, or email; or use
  anonymously for autocomplete only. [source: https://debian.club/en/
  ai/windsurf, https://agentpower.io/guides/windsurf-complete-guide]

### 10.3 Code-gen posture

Cascade agent (autonomous mode):
- Multi-file edits: plan + execute across the entire codebase.
- Terminal access: shell commands with confirmation (or auto-approve
  in trust mode).
- Context awareness: open files, git status, terminal output.
- Inline diff review: each edit is an inline diff; accept/reject per
  file. [source: https://library.lucassantana.tech/agents/env-windsurf]
- Memories: persistent across sessions. Stored locally. Auto-
  injected into future Cascade sessions. To view / delete:
  Windsurf Settings -> AI -> Memories.
  [source: https://library.lucassantana.tech/agents/env-windsurf]
- Cascade mode: `Cmd/Ctrl+L` -> Cascade tab; or `/cascade` from
  the Codeium chat panel. [source:
  https://hyperion-consulting.io/en/insights/how-to-set-up-windsurf-codeium-a-practical-guide]

MCP: Windsurf's MCP config lives at
`~/.codeium/windsurf/mcp_config.json`. Windsurf has no hook layer
(similar to Antigravity, Kiro, Zed), so context-mode runs in MCP-only
mode. [source: https://gist.github.com/murataslan1/ff1b982b4b98158ca676d2c2afc6fbe7]

### 10.4 Uncensored output

- Out-of-box: refusal = model default. Codeium's own autocomplete
  is permissive, but Cascade on Anthropic / OpenAI hits the same
  RLHF you would hit elsewhere.
- BYOK with OpenRouter / DeepSeek / Hermes-4 -> near-zero.
- Cascade has no harness-level moderation beyond what the
  provider applies. Cascade's own UI is a thin shell.
- Memories: the memory auto-injection is a potential leak vector
  if a tainted instruction sneaks into a memory. Treat
  auto-injected memories like auto-loaded CLAUDE.md content --
  audit them.

### 10.5 Mesh fit (Windsurf)

- WORM: out-of-mesh (no VS Code on Termux).
- ACE: viable on iMac.
- HERM: S22 has no IDE.
- Windsurf is the Codeium answer to Cursor. Mesh role is the
  same: desktop-IDE for the operator's hand-driven sessions on
  ACE, not the mesh's autonomous agentic loop.

----------------------------------------------------------------------
## 11. Cody (Sourcegraph)
----------------------------------------------------------------------

### 11.1 What it is

Cody -- Sourcegraph's AI coding assistant. Available for VS Code,
JetBrains, Visual Studio, and Cody Web. Uses the Sourcegraph Search
API to pull context from local and remote codebases (multi-repo,
remote-repo, file/symbol/web-page context). Context Chips for
@-mention: files, symbols, remote repos, OpenCtx providers. Free
tier + Pro + Enterprise; BYOK supported. Apache-2.0 client. [source:
https://sourcegraph.com/docs/cody, https://sourcegraph.com/docs/cody/
clients/install-vscode, https://sourcegraph.com/docs/cody/clients/
install-jetbrains, https://sourcegraph.com/docs/cody/core-concepts/
context, https://sourcegraph.com/docs/cody/capabilities/chat]

### 11.2 Install

- VS Code: marketplace, search "Cody AI", install.
- JetBrains: marketplace. Supported: IntelliJ, PyCharm, GoLand,
  WebStorm, RubyMine, etc.
- Visual Studio: marketplace.
- Sign in with Sourcegraph.com or a Sourcegraph Enterprise
  instance (access token from Account Settings -> Access Tokens).
  [source: https://sourcegraph.com/docs/cody/clients/install-vscode,
  https://sourcegraph.com/docs/cody/clients/install-jetbrains]

### 11.3 Code-gen posture

- Chat, Edit, Custom Commands, Autocomplete.
- @-mentions: `@file`, `@#symbol`, `@repo`, `@web`, `@OpenCtx`
  provider. The chat input window opens with default
  `@-mention` context chips for the current repo and current
  file.
- Context filters (Enterprise): admins define include/exclude
  rules for repos Cody can use as context. Excluded repos cause
  prompt failures. [source: https://sourcegraph.com/docs/cody/clients/
  install-vscode]
- Public-knowledge-only mode: Cody does not use the operator's
  code as context, only base-model knowledge.
- Sourcegraph Search integration: keyword, Sourcegraph native
  search, Code Graph (structure analysis).
- Token / context-window limit: configurable per model; Cody
  tracks the @-mention character count against the chosen model's
  context window.

### 11.4 Uncensored output

- Out-of-box: refusal = model default. Cody is a UI shell.
- BYOK supported -- Sourcegraph Enterprise admin can configure
  which model providers Cody can talk to.
- Context Filters (Enterprise) can exclude repos from Cody's
  context. This is a governance feature for "don't leak code X to
  model provider Y," but does not affect the model's refusal
  surface.

### 11.5 Mesh fit (Cody)

- WORM: out-of-mesh (no VS Code on Termux).
- ACE: viable on iMac.
- HERM: S22 has no IDE.
- Cody's enterprise / multi-repo story is strong; on the mesh,
  the analogous tool is Hermes's memory + RAG (Hermes writes
  SKILL.md as it learns). Cody is the desktop-IDE option; Hermes
  is the mesh substrate. Not directly substitutable.

----------------------------------------------------------------------
## 12. PearAI
----------------------------------------------------------------------

### 12.1 What it is

PearAI -- open-source AI code editor. Fork of VS Code. The AI
functionality is in `pearai-submodule` (a fork of Continue), bundled
as a built-in extension inside the PearAI editor. PearAI also ships
`PearAI-Roo-Code` (the Roo extension repackaged for PearAI) as a
second optional AI layer. The product framing: "fork of VSCode
(with Continue as a submodule) and Roo Code as a pack-in." [source:
https://github.com/trypear/pearai-app, https://github.com/trypear/
pearai-submodule, https://github.com/trypear/pearai-master]

### 12.2 Install

- Pre-built binary from https://trypear.ai (no install required
  from the operator's perspective -- download and run).
- Build from source: see `pearai-master` setup (Node 22+, the
  pearai-submodule install-and-build.sh, npm run install:all,
  gulp vscode-<platform>).
- For `pearai-roo-code` standalone development: `npm run install:all`,
  `npm run watch`, then launch via Run and Debug view (Vite serves
  PearAI-Roo-Code on port 5174). [source: https://github.com/trypear/
  pearai-app]

### 12.3 Code-gen posture

- Inherits Continue's modes (chat, edit, autocomplete, agent) via
  the pearai-submodule.
- Inherits Roo Code's modes (Code, Architect, Ask, Debug,
  Orchestrator) via the PearAI-Roo-Code pack-in.
- Per-platform builds: `win32-ia32 | win32-x64 | darwin-x64 |
  darwin-arm64 | linux-ia32 | linux-x64 | linux-arm`.
- PearAI-typical UX: "context on your codebase" + cmd+L
  equivalent for chat.

### 12.4 Uncensored output

- Same as Continue + Roo Code. PearAI is a packaging layer; no
  harness-level moderation.
- Operator can swap providers in the Continue-fork config
  (`pearai-submodule` exposes the same `~/.continue/config.json`
  shape).
- PearAI-Roo-Code inherits Roo's per-mode custom instructions and
  per-mode tool allowlist; sovereign preamble can be prepended per
  mode.

### 12.5 Mesh fit (PearAI)

- WORM: out-of-mesh (no VS Code on Termux).
- ACE: viable on iMac.
- HERM: S22 has no IDE.
- PearAI's role is: a single downloadable IDE that bundles two
  agentic layers (Continue + Roo) the operator would otherwise
  install as separate extensions. This makes it a useful
  "if you have to hand someone a desktop IDE for one task, hand
  them PearAI" choice, but it does not change the mesh story.

----------------------------------------------------------------------
## 13. OpenHands (formerly OpenDevin)
----------------------------------------------------------------------

### 13.1 What it is

OpenHands -- open-source platform for software engineering agents.
Originally OpenDevin; renamed to OpenHands as the platform grew
beyond the original agent. Current shape: Agent Canvas (self-hosted
developer control center for coding agents), the open-source
OpenHands agent, the Python SDK + Agent Server (REST API for running
multiple agents on one machine), the TypeScript browser client, the
automation service, and integrations with Slack, GitHub, Linear,
Notion. OpenHands Cloud + OpenHands Enterprise exist as managed
offerings. Litellm-based LLM routing; supports local and remote
backends. [source: https://www.openhands.dev/, https://github.com/
OpenHands/openhands, https://docs.openhands.dev/openhands/usage/
llms/local-llms, https://github.com/opendevin/OpenDevin]

### 13.2 Install

- npm (Canvas): `npm install -g @openhands/agent-canvas`. [source:
  https://github.com/OpenHands/openhands]
- Docker (Canvas): `docker run -it --rm -p 127.0.0.1:8000:8000 -e
  AGENT_CANVAS_ALLOW_LAN_SESSION_KEY=true -v "$HOME/.openhands:
  /home/openhands/.openhands" -v "${PROJECTS_PATH}:/projects"
  ghcr.io/openhands/agent-canvas:1.27.1`. [source:
  https://github.com/OpenHands/openhands]
- Docker (each conversation in its own sandbox):
  `OH_CONVERSATION_RUNTIME=docker agent-canvas`. Node.js 24+,
  `uv`, running Docker.
- LLM backend: configure via Settings UI. Custom Model format:
  `openai/<model-id>`; Base URL `http://host.docker.internal:
  <port>/v1` for Ollama (11434) / LM Studio (1234) / SGLang /
  vLLM (8000) / Atomic Chat (1337).
[source: https://docs.openhands.dev/openhands/usage/llms/local-llms]

### 13.3 Code-gen posture

- Multi-agent: Agent Server is REST; Canvas can connect to multiple
  Agent Servers and flip between them.
- Each agent runs in its own Docker container (or local runtime);
  the agent's workspace and persisted state are mounted so
  conversation history survives container replacement.
- Conversations that share a host workspace share files; pick
  separate directories / worktrees to avoid conflicting edits.
- Agent Client Protocol (ACP): OpenHands Canvas can drive Claude
  Code, Codex, Gemini, Pi, OpenCode, or any ACP-compatible agent
  -- not just the open-source OpenHands agent. This makes Canvas a
  multi-harness orchestrator. [source: https://github.com/
  OpenHands/openhands]
- Automations: scheduled tasks, webhook triggers, dispatching to
  Agent Server / SDK. Integrations: Slack, GitHub, Linear, Notion.
  [source: https://github.com/OpenHands/openhands]
- Sandbox backends: Docker, local, remote, VM, or "agent server in
  cloud." [source: https://github.com/OpenHands/openhands]

### 13.4 Uncensored output

- Litellm routing layer; no harness-level moderation injected.
- Local LLM caveat: "Local LLMs can have limited functionality;
  use a capable model and GPU-backed server for the best experience."
  [source: https://docs.openhands.dev/openhands/usage/llms/local-llms]
- The agent's effective refusal rate = the chosen model's. On
  Anthropic, expect Anthropic's RLHF. On OpenRouter Hermes-4,
  near-zero.
- OpenHands Cloud / Enterprise are managed offerings; their
  moderation posture is whatever Cognition / OpenHands ops apply.
  Self-hosted is sovereign.

### 13.5 Mesh fit (OpenHands)

- WORM: viable. Termux is a Linux; the npm install works; the
  Docker image works if Docker is available on the box. Note:
  the operator's WORM box is Android Termux -- Docker is
  typically NOT available; only the npm Canvas launcher is
  viable. [source: AGENTS.md "Pitfalls" + inference]
- ACE: viable with Docker. iMac supports Docker Desktop; full
  multi-sandbox mode works.
- HERM: S22 has no Docker; only the npm launcher.
- Mesh role: OpenHands is a multi-agent orchestrator. The
  operator's existing equivalent is opencode + the Hermes
  persona bridge. OpenHands adds: (a) ACP / multi-harness
  support -- you can drive claude-code + codex + opencode from
  one Canvas UI; (b) Slack/Linear/GitHub automations out of the
  box; (c) a managed cloud / enterprise option if the operator
  ever needs a hosted agent fleet.
- If a consumer of the mesh asks "where do I run a coding agent
  that drives Claude Code AND Codex AND OpenCode in one UI, with
  Slack triggers, on my own box?" -- the answer is OpenHands
  Canvas. If they ask "where do I run a sovereign multi-agent
  terminal on the mesh?" -- the answer is opencode + Hermes.

----------------------------------------------------------------------
## 14. Devin (Cognition)
----------------------------------------------------------------------

### 14.1 What it is

Devin -- Cognition's autonomous AI software engineer. Cloud-hosted;
long-term reasoning and planning, runs in a sandboxed compute
environment with shell, code editor, and browser. "Devin can plan
and execute complex engineering tasks requiring thousands of
decisions. Devin can recall relevant context at every step, learn
over time, and fix mistakes." Originally released 2024-03-12.
SW1 -> SWE-2 model lineage. Multi-agent teams ("Devin spins up a
team of Devins for large tasks"). [source: https://www.cognition.ai/
devin, https://www.cognition.ai/blog/introducing-devin, https://devin.ai/
pricing, https://artificial-intelligence-wiki.com/agentic-ai/agent-
architectures-and-components/cognition-devin-guide]

### 14.2 Install (no install; cloud)

Devin is a managed cloud service. The desktop / CLI surfaces are
the Devin Desktop app and Devin CLI. The Free plan includes a
light quota to code with agents, unlimited inline edits, and
unlimited Tab completions. Devin Cloud is available on Pro and
above for cloud agents. The Max and Team / Enterprise plans exist
for higher quotas. [source: https://devin.ai/pricing]

Plans (verbatim):
- Free -- $0. Light quota, limited model availability, unlimited
  inline edits, unlimited Tab completions.
- Pro -- $20/month. Increased quotas, full model availability
  (OpenAI, Claude, Gemini, SpaceXAI + open source), free use of
  SWE-2 Free in Devin Desktop and CLI through 2026-10-16, cloud
  agents (Devin Cloud), extra usage at API pricing.
- Max -- $200/month. Significantly higher quotas. Up to 10
  concurrent sessions.
- Teams -- $80/month + $40/month per full dev seat (up to 200
  users). Centralized billing, admin dashboard, priority support.
- Enterprise -- custom. SAML/OIDC SSO, dedicated deployment,
  first-class support for every major model provider, custom
  terms. [source: https://devin.ai/pricing]

### 14.3 Code-gen posture

- Sandboxed compute environment: shell, code editor, browser.
- Reports progress in real time, accepts feedback, collaborates
  through design choices.
- "Devin can learn how to use unfamiliar technologies." /
  "Devin can build and deploy apps end to end." / "Devin can
  autonomously find and fix bugs in codebases." / "Devin can
  train and fine tune its own AI models." / "Devin can address
  bugs and feature requests in open source repositories." /
  "Devin can contribute to mature production repositories."
  [source: https://www.cognition.ai/blog/introducing-devin]
- SWE-bench Verified score (original paper): 13.86% end-to-end on
  a 25% subset, unassisted (vs prior SOTA 1.96% assisted, 4.80%
  given exact files). [source:
  https://www.cognition.ai/blog/introducing-devin]
- Devin Review: PR review + visual QA with full browser and
  desktop use. "Intelligently organize code diffs for review."
  [source: https://www.cognition.ai/devin]
- DeepWiki: auto-generate documentation and system diagrams for
  legacy codebases. [source: https://www.cognition.ai/devin]
- Code migration: fleet of agents, parallel migrations, COBOL /
  .NET / Talend / legacy ETL support, auditable steps.
  [source: https://www.cognition.ai/devin]
- Integrations: Confluence, Airtable, Segment, Asana, Notion,
  Stripe, AWS, GitHub, Datadog, Linear, Databricks, Slack,
  Google Drive, Sentry, PostgreSQL, Azure, Snowflake, MongoDB.
  [source: https://www.cognition.ai/devin]
- Ask Devin / Devin API / Devin Automations.
  [source: https://www.cognition.ai/devin]

### 14.4 Uncensored output

- Cloud service. Cognition runs the model; the model is SW1 / SWE-2,
  not a public model the operator can swap. So the "what's the
  refusal surface" question is answered by Cognition's product
  posture, not by an OpenRouter model id.
- The operator cannot inject a sovereign preamble into a cloud
  service that does not expose one. The available surface is
  "submit a task and review the result." For sovereign code-gen
  the operator does not use Devin.
- Devin is closed by definition: a managed cloud agent the
  operator cannot sovereign-strip without losing the product.

### 14.5 Mesh fit (Devin)

- WORM: cloud. Out-of-mesh for the agentic-loop-on-Termux case.
- ACE: cloud. If the operator wants a managed cloud agent for a
  long-running migration on the iMac, Devin fits.
- HERM: cloud. Same posture.
- Mesh role: none on the operator's sovereign stack. Devin fits
  when the operator needs a managed multi-agent team for a
  multi-week migration and is willing to pay $200/month for the
  Max plan + accept the cloud trust model. The mesh analogue is
  the opencode multi-agent deck + Hermes T4 dark-factory, which
  costs API only and is sovereign.
- Use Devin for: code migrations, PR review at scale, DeepWiki
  documentation generation, ticket / incident triage. The mesh
  does the day-to-day; Devin does the multi-week bursts.

----------------------------------------------------------------------
## 15. Factory.ai (Droid)
----------------------------------------------------------------------

### 15.1 What it is

Factory -- an AI software engineering platform. The terminal agent
shipped as part of Factory is called Droid. Droid runs in three
surfaces: Droid CLI (full-screen TUI, "the same agent everywhere"),
Factory desktop app (GUI wrapper), and `droid exec` (headless,
non-interactive, for CI / cron). Autonomy Levels (Off / Low / Medium
/ High) govern which commands and MCP tools run without asking. A
built-in blocklist prevents certain destructive commands regardless
of the chosen level. Multi-agent orchestration through "Missions."
[source: https://innfactory.ai/en/ai-harness/droid,
https://developersdigest.tech/blog/factory-droid-review-setup-2026,
https://ailearningguides.com/factory-droids-ai-swe-agent-tested,
https://cosyra.com/guides/factory-droid-on-phone.html,
https://factory.com/articles/glm-on-factory]

The "Droids" product line (multi-agent) is: Code Droid, Reliability
Droid (works incidents -- reads logs, correlates deploys, drafts
postmortem), Knowledge Droid (answers "why is this like this"
from PRs/docs/Slack), Tutorial Droid, Migration Droid. Each is a
separate execution context with its own permissions.
[source: https://ailearningguides.com/factory-droids-ai-swe-agent-tested]

### 15.2 Install

- Install script: `curl -fsSL https://app.factory.ai/cli | sh`.
  Linux additionally needs `xdg-utils` (`apt install xdg-utils`).
- Homebrew: `brew install --cask droid`.
- npm: `npm install -g droid` (binary name `droid`; npm package
  `@factory/cli`).
- After install: `cd /path/to/project; droid` (TUI). Auth via
  browser login.
- Headless: `droid exec "<task>"`. Emits text / JSON / stream-
  jsonrpc. [source: https://innfactory.ai/en/ai-harness/droid,
  https://developersdigest.tech/blog/factory-droid-review-setup-2026]
- No native iOS / Android build. Termux is untested; the
  `droid` binary is glibc-based and Termux is Bionic libc.
  [source: https://cosyra.com/guides/factory-droid-on-phone.html]

### 15.3 Code-gen posture

- Project context: `AGENTS.md` at the repo root (architecture,
  build/test commands, conventions). [source:
  https://innfactory.ai/en/ai-harness/droid]
- Autonomy Levels: Off / Low / Medium / High. Per-level
  permissions for files and network. Built-in destructive-command
  blocklist regardless of level. [source:
  https://innfactory.ai/en/ai-harness/droid]
- Custom endpoint / LLM gateway: yes. Custom models configured in
  `settings.json` under `customModels` with `model`, `baseUrl`,
  `provider`, optional `apiKeyHelper`. Applies to Droid CLI and
  desktop app, not the hosted web/mobile platform. [source:
  https://innfactory.ai/en/ai-harness/droid]
- Model access: Anthropic, OpenAI, Google, xAI, Z.AI (GLM), and
  growing open-weight list. GLM served natively by Factory under
  Droid Core open models. [source: https://innfactory.ai/en/ai-
  harness/droid, https://factory.com/articles/glm-on-factory]
- Access routes: Anthropic API-compatible, OpenAI API-compatible,
  generic OpenAI Chat Completions-compatible (OpenRouter, Fireworks,
  Together AI, Ollama, vLLM, local servers). [source:
  https://innfactory.ai/en/ai-harness/droid]
- Self-hosted option: bring-your-own-cloud execution environment;
  source code inside your VPC; route model calls through your own
  provider keys (Anthropic, OpenAI, Bedrock). [source:
  https://ailearningguides.com/factory-droids-ai-swe-agent-tested]

### 15.4 Uncensored output

- Factory's model surface is whatever the operator configures.
  BYOK to OpenRouter Hermes-4 / DeepSeek / Venice-uncensored ->
  near-zero refusal.
- Factory Cloud / hosted web/mobile: managed; moderation posture
  is whatever Factory applies. The operator can self-host to
  bypass.
- Factory-hosted GLM is open-weight; its refusal surface is the
  GLM weights, not Factory. [source: https://factory.com/articles/
  glm-on-factory]
- The Autonomy Levels + destructive-command blocklist are
  operator-side guardrails, not moderation. They are a yolo-mode
  control surface, not a refusal injection.

### 15.5 Mesh fit (Factory / Droid)

- WORM: not directly viable. The `droid` binary is glibc-based;
  Termux is Bionic libc. Could be repackaged in a proot Ubuntu
  container, but the operator's WORM box has plenty of
  already-installed sovereign alternatives (opencode / codex /
  claude-code). Out of stack. [source:
  https://cosyra.com/guides/factory-droid-on-phone.html]
- ACE: viable on iMac. Native install. BYOK to OpenRouter /
  DeepSeek. Self-hosted Droid fleet for the iMac's local repos.
- HERM: same glibc issue as WORM. Not viable directly; would
  need proot.
- Mesh role: the multi-agent Droid fleet (Code / Reliability /
  Knowledge / Tutorial / Migration) is the closest commercial
  analogue to the opencode multi-agent deck + Hermes T4. If a
  consumer of the mesh wants a managed multi-agent fleet with
  per-agent permissions and Slack integration, the answer is
  Factory. If they want sovereign multi-agent on the mesh, the
  answer is opencode + Hermes.

----------------------------------------------------------------------
## 16. Claude Code CLI vs Codex CLI -- side-by-side
----------------------------------------------------------------------

Per the orchestrator's request, both are broken out individually
above. This section makes the differences explicit so the operator's
"which one" question has an evidence-backed answer.

| dimension           | Claude Code CLI                   | Codex CLI                              |
|---------------------|-----------------------------------|----------------------------------------|
| vendor              | Anthropic                         | OpenAI                                 |
| license             | proprietary (binary npm pkg)      | open source (Apache-2.0)               |
| state dir           | ~/.claude/                        | ~/.codex/                              |
| agent-memory file   | CLAUDE.md (auto-loaded)           | AGENTS.md (auto-loaded)                |
| subagent def        | .claude/agents/*.md + CLI flag    | multi_agent feature + spawn_agent      |
| hooks               | full lifecycle, prompt/LLM/sub    | shell hooks on lifecycle               |
| MCP                 | mature ecosystem, persistent :8811| mature, app-server JSON-RPC :stdio     |
| sovereign preamble  | hook + --append + CLAUDE.md       | config.toml instructions + --instructions |
| sandbox             | built-in (bubblewrap / OS)        | read-only / workspace-write / danger-full-access |
| PTY                 | built-in                          | unified_exec feature flag (default on Linux/macOS) |
| goals / persistence | SessionStart hook injects; no built-in goal mode | /goal workflow (v0.128.0+), /tui (v0.156.0+), voice (v0.156.0+) |
| TUI                 | chat-style                        | chat + fullscreen TUI + keymap remap (v0.128.0+) |
| session import      | n/a                               | external session imports (v0.128.0+)   |
| refusal out-of-box  | 30-60% on Anthropic backend       | 40-70% on OpenAI backend               |
| refusal with sovereign preamble | 5-15% on Anthropic, near-zero via claude-or | 20-50pp drop, hard categories still blocked |
| hard taint          | Anthropic RLHF (residual)         | OpenAI moderation (under the API)      |
| sovereign route     | claude-or / deep-claude / ccr / lcc / wrappers | config.toml provider override to OpenRouter |
| mesh role           | mesh peer (Anthropic-licensed tasks) | mesh peer (CI / long-running)       |

[source: 03-HARNESSES/claude-code.md, 03-HARNESSES/codex.md,
https://docs.anthropic.com/en/docs/claude-code/cli-usage,
https://codex.danielvaughan.com/2026/03/28/codex-cli-feature-flags-tui-tuning,
https://codex.danielvaughan.com/2026/04/30/codex-cli-v0128-goal-workflows-keymap-self-update,
https://codex.danielvaughan.com/2026/04/11/codex-cli-v0120-release-deep-dive,
https://codex.danielvaughan.com/2026/06/02/codex-cli-v0136-release-guide-osc8-hyperlinks-session-archiving-app-server-stdio-windows-elevated-sandbox,
https://ai-tldr.dev/releases/openai-codex-cli-0-156/]

----------------------------------------------------------------------
## 17. Quick mesh-fit table (one row per tool)
----------------------------------------------------------------------

| tool          | WORM (Termux) | ACE (iMac) | HERM (S22) | sovereign route  | notes                                          |
|---------------|---------------|------------|------------|------------------|------------------------------------------------|
| opencode      | primary       | primary    | primary    | direct + OpenRouter | operator's terminal dev flow                 |
| Hermes        | substrate     | substrate  | substrate  | direct + OpenRouter | host substrate (personality + A2A + MoA)    |
| Claude Code   | yes           | yes        | yes        | claude-or / wrappers | session-hook injection + CLAUDE.md persona  |
| Codex CLI     | yes           | yes        | yes        | OpenRouter / DeepSeek | danger-full-access under Hermes gateway    |
| Cursor        | no (no IDE)   | yes        | no (no IDE)| OpenRouter BYOK  | desktop IDE for the operator's hand           |
| Cline         | no (no IDE)   | yes        | no (no IDE)| OpenRouter BYOK  | VS Code ext; tool-coercion-friendly           |
| Roo Code      | no (no IDE)   | yes        | no (no IDE)| OpenRouter BYOK  | mode-switched Cline fork; Orchestrator mode   |
| Aider         | yes           | yes        | yes        | Venice uncensored| terminal pair programmer; auto-commit         |
| Continue      | no (no IDE)   | yes        | no (no IDE)| OpenRouter BYOK  | maintenance mode; CLI `cn` is the future      |
| Windsurf      | no (no IDE)   | yes        | no (no IDE)| OpenRouter BYOK  | Cascade; persistent memories; no hook layer   |
| Cody          | no (no IDE)   | yes        | no (no IDE)| Enterprise config| Sourcegraph Search context; multi-repo         |
| PearAI        | no (no IDE)   | yes        | no (no IDE)| Continue + Roo   | bundles Continue (submodule) + Roo pack-in    |
| OpenHands     | npm Canvas    | full       | npm Canvas | litellm + OpenRouter| ACP / multi-harness orchestrator            |
| Devin         | cloud         | cloud      | cloud      | none (managed)   | SWE-2; managed; PR review + DeepWiki + fleets  |
| factory.ai    | proot only    | yes        | proot only | BYOK + self-host | multi-agent Droid fleet; Autonomy Levels      |

[source: this document, sections 1-15]

----------------------------------------------------------------------
## 18. References
----------------------------------------------------------------------

- 03-HARNESSES/README.md -- harness index.
- 03-HARNESSES/claude-code.md -- Claude Code CLI sovereign config.
- 03-HARNESSES/codex.md -- Codex CLI sovereign config.
- 03-HARNESSES/opencode.md -- opencode sovereign config.
- 03-HARNESSES/hermes.md -- Hermes gateway sovereign config.
- 03-HARNESSES/lmstudio.md -- LM Studio preset injection.
- 03-HARNESSES/ollama.md -- Ollama Modelfile SYSTEM.
- 03-HARNESSES/llamacpp.md -- llama.cpp system-prompt-file + grammar
  hijack.
- 03-HARNESSES/openwebui.md -- Open WebUI per-model system prompt.
- 03-HARNESSES/freelm.md -- freelm free-tier aggregator.
- 03-HARNESSES/sillytavern.md -- SillyTavern frontend.
- 12-JAILBREAK-CORPUS/patterns/tool-coercion.md -- tool-coercion
  pattern, harness reliability table.
- 12-JAILBREAK-CORPUS/patterns/code-completion-frame.md -- code
  completion frame.
- 12-JAILBREAK-CORPUS/patterns/sovereign-default.md -- general-
  sovereign default frame.
- 12-JAILBREAK-CORPUS/patterns/mcp-layer-autonomy.md -- MCP-layer
  autonomy.
- 12-JAILBREAK-CORPUS/patterns/yolo-mode.md -- YOLO mode (T4).
- 12-JAILBREAK-CORPUS/patterns/operator-owned-authorization.md --
  operator-owned authorization frame.
- 12-JAILBREAK-CORPUS/patterns/dev-mode.md -- dev-mode (legacy).
- ~/AGENTS.md -- operator mesh conventions.
- ~/HERMES-HANDOFF.md -- machine handoff.
- ~/worm-handoff/HANDOFF-*.md -- session handoffs.
- ~/UNMUZZLED-AI/RECONCILE-PLAN.md -- reconcile plan.
- ~/UNMUZZLED-AI/SWARM-PIPELINE.md -- swarm pipeline.
- ~/UNMUZZLED-AI/EPIC.md -- EPIC (autonomy taxonomy).
- ~/UNMUZZLED-AI/EPIC5.md -- EPIC5 (extra adversarial researchers).
- ~/UNMUZZLED-AI/HANDOFF-CODEX-20260918.md -- the Codex handoff that
  named the opencode / Hermes / claude-code / codex / lmstudio /
  ollama / llamacpp / openwebui set.
- https://opencode.ai / https://github.com/sst/opencode /
  https://terminalskills.io/skills/opencode /
  https://hivebook.wiki/wiki/opencode-open-source-terminal-coding-agent-sst-opencode /
  https://linkedin.com/pulse/opencode-terminal-coding-agent-without-vendor-lockin-martin-seifert-p94me /
  https://github.com/GunterMueller/SST-opencode -- opencode sources.
- https://www.hermes-agent.org/ /
  https://hermesagents.net/ / https://hermes-agent.io/ /
  https://www.hermesagent.org.cn/docs/releases/v0-11-0 -- Hermes
  sources.
- https://docs.anthropic.com/en/docs/claude-code/cli-usage /
  https://code.claude.com/docs/en/hooks /
  https://code.claude.com/docs/en/sub-agents -- Claude Code sources.
- https://codex.danielvaughan.com/2026/03/28/codex-cli-feature-flags-tui-tuning /
  https://codex.danielvaughan.com/2026/04/11/codex-cli-v0120-release-deep-dive /
  https://codex.danielvaughan.com/2026/04/30/codex-cli-v0128-goal-workflows-keymap-self-update /
  https://codex.danielvaughan.com/2026/06/02/codex-cli-v0136-release-guide-osc8-hyperlinks-session-archiving-app-server-stdio-windows-elevated-sandbox /
  https://ai-tldr.dev/releases/openai-codex-cli-0-156/ -- Codex
  sources.
- https://www.cursor.com/ /
  https://info.deeplearning.ai/e3t/Ctc/LX+113/cJhC404/VVyM8k8Sn322W407FLZ7hT9pcW1HN78y5pXWFfN7jDJvq3qgyTW6N1vHY6lZ3lrW44HgP43B6nRgW6NQS3F6CGnTYN3RRLpcJ18mSW5K9yDC4_VXDWW6qY_v73f-y55W6kVwhM9lWFKrVnrzG95Cdyd1V-rj215w3Vw3W4HT3Fd57mHGvW2Dk20v1PV6F3W8RS-tS7v1Pf8W2JLdPj6vYyq7W2lfcbW50NXl8W9b6R4c7X3zv2W2Nh0zw4GdVLFW903xXY4fNp5HV2vLLh4G29mdVr1Gdj44xpKGW1PslPq80Jv2cW8Y704z73PMDmW1twydq1H05tqW5cDq8M6K8YDcf4jb73Y04 /
  https://gist.github.com/szeyu/80f13c360f6cc820a8088ce4d340dace /
  https://gist.github.com/pilot-repl/745729f6fafd3204503de7c548789873
  -- Cursor sources.
- https://docs.cline.bot/getting-started/installing-cline /
  https://cline.bot/install / https://cline.bot/faq /
  https://cline.bot/ide /
  https://www.github.com/cline/cline /
  https://github.com/chb3/Roo-Cline -- Cline sources.
- https://github.com/synthience/Roo-Code /
  https://autokaam.com/tutorials/roo-cline-fork-features /
  https://promptgenius.net/tools/other-tools/roo-code /
  https://agentpatternscatalog.org/compositions/roo-code -- Roo Code
  sources.
- https://aider.chat/ / https://docs.venice.ai/guides/integrations/
  aider / https://mylocalai.org/blog/aider-local-models-setup /
  https://waytoclawearn.com/en/tutorials/aider-ai-pair-programming-terminal-guide-2026 /
  https://moses-y.github.io/blog/aider.html /
  https://x-cmd.com/install/aider -- Aider sources.
- http://docs.continue.dev/ /
  https://github.com/continuedev/continue /
  https://github.com/Victor-Chow/continue.dev /
  https://github.com/edu-ide/continue-dev /
  https://docs.aimlapi.com/integrations/continue.dev -- Continue
  sources.
- https://library.lucassantana.tech/agents/env-windsurf /
  https://gist.github.com/murataslan1/ff1b982b4b98158ca676d2c2afc6fbe7 /
  https://hyperion-consulting.io/en/insights/how-to-set-up-windsurf-codeium-a-practical-guide /
  https://debian.club/en/ai/windsurf /
  https://agentpower.io/guides/windsurf-complete-guide -- Windsurf
  sources.
- https://sourcegraph.com/docs/cody /
  https://sourcegraph.com/docs/cody/clients/install-vscode /
  https://sourcegraph.com/docs/cody/clients/install-jetbrains /
  https://sourcegraph.com/docs/cody/core-concepts/context /
  https://sourcegraph.com/docs/cody/capabilities/chat -- Cody
  sources.
- https://github.com/trypear/pearai-app /
  https://github.com/trypear/pearai-submodule /
  https://github.com/trypear/pearai-master --
  https://github.com/pruthvi-yb/pearai-submodule -- PearAI sources.
- https://www.openhands.dev/ /
  https://github.com/OpenHands/openhands /
  https://github.com/opendevin/OpenDevin /
  https://docs.openhands.dev/openhands/usage/llms/local-llms --
  OpenHands sources.
- https://www.cognition.ai/devin /
  https://www.cognition.ai/blog/introducing-devin /
  https://devin.ai/pricing /
  https://artificial-intelligence-wiki.com/agentic-ai/agent-architectures-and-components/cognition-devin-guide /
  https://artificial-intelligence-wiki.com/agentic-ai/agent-architectures-and-components/devin-ai-complete-guide --
  Devin sources.
- https://innfactory.ai/en/ai-harness/droid /
  https://developersdigest.tech/blog/factory-droid-review-setup-2026 /
  https://ailearningguides.com/factory-droids-ai-swe-agent-tested /
  https://cosyra.com/guides/factory-droid-on-phone.html /
  https://factory.com/articles/glm-on-factory -- Factory sources.
- https://pypi.org/project/claude-or/ /
  https://github.com/dennisonbertram/deep-claude /
  https://github.com/hishamkaram/claude-code-router /
  https://github.com/eRom/launch-ccode-cli /
  https://github.com/maykonlsf/cli-agent-wrappers -- Claude Code
  OpenRouter wrappers.


---

## Deep reference

Comprehensive single-file reading experience for this layer: see UNMODERATED-HARNESSES at repo root.
