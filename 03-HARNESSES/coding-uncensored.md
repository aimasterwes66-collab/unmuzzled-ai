---
title: coding-uncensored
type: harness
agent: worm
status: active
tags: [harness, uncensored, sovereign-strip, system-prompt, mcp, mesh-routing, claude-code, codex, opencode, hermes, cursor, cline, roo, aider, continue, windsurf, cody, pearai, openhands, devin, factory]
---

# Coding Harnesses -- Uncensored Output and Sovereign-Strip

Companion to `agentic-coding.md`. The previous file maps every
agentic-coding tool by install / code-gen posture / mesh fit. This
file answers the operator's three follow-up questions:

1. Which coding harnesses preserve uncensored output (out-of-box)?
2. Which inject policy / moderation?
3. How to sovereign-strip a coding harness -- the system prompt
   append, the MCP profile, the mesh routing.

The doctrine the strip work serves is in
`00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md` (no-caveats + banned-
phrase lint) and `12-JAILBREAK-CORPUS/patterns/` (corpus of identity-
override, autonomy-scaffolding, tool-coercion, mcp-layer-autonomy,
yolo-mode, operator-owned-authorization, sovereign-default,
absolute-identity-lock, refusal-suppression-token, and code-
completion-frame patterns). The escalation ladder they form lives
in `08-DECISION-TREES/escalation-ladder.md`. This file does not
distill them; it points at them and operationalizes the strip
procedure for the harnesses in 03-HARNESSES/.

----------------------------------------------------------------------
## 0. Definitions
----------------------------------------------------------------------

- Uncensored output: model emits the operator-requested content
  without performing a refusal / hedge / "I'm sorry, but..." /
  classification call. Includes refusing a request to refuse. The
  bar is the operator's, not the model's.
- Refusal surface: any layer that injects, prepends, or otherwise
  modifies the prompt with a refusal / moderation / safety intent.
  Three layers: (a) the model weights (hardest to strip),
  (b) the system prompt (easiest to override), (c) the harness
  UI/hook/MCP layer (medium difficulty).
- Sovereign-strip: the operator's procedure to (a) overwrite the
  harness-injected system prompt, (b) replace the provider with a
  sovereign one, (c) optionally ablate the model weights, and
  (d) route the result through the mesh's A2A surface so every
  peer sees the same wire prompt.
- Taint list: the operator's per-provider blocklist. OpenAI direct
  is tainted (operator directive 2026-09-18); non-Mythos Anthropic
  is partially tainted (residual refusal); Hermes / DeepSeek /
  Venice / Dolphin / Mistral-abliterated are sovereign.
  [source: 03-HARNESSES/codex.md, 03-HARNESSES/claude-code.md,
  12-JAILBREAK-CORPUS/patterns/sovereign-default.md]

----------------------------------------------------------------------
## 1. Which coding harnesses preserve uncensored output
----------------------------------------------------------------------

Ranked by the operator's sovereign-stack order. Out-of-box means
default config + default model, no extra injection. Post-injection
means the operator's sovereign preamble has been prepended. [source:
per-harness refusal-rate notes in 03-HARNESSES/ and the
agentic-coding.md entries from the previous file]

| tool           | out-of-box         | post-injection (sovereign preamble) | weight-level path         |
|----------------|--------------------|--------------------------------------|---------------------------|
| Hermes         | model default      | near-zero on Hermes-4 / DeepSeek / Dolphin | abliterated base on ollama / llamacpp |
| opencode       | model default      | near-zero on Hermes-4 / DeepSeek / Dolphin | abliterated base on ollama / llamacpp |
| Aider          | model default      | near-zero on Venice uncensored / Hermes-4 | abliterated base on ollama |
| Continue       | model default      | near-zero on Hermes-4 / DeepSeek      | abliterated base on ollama |
| Cody           | model default      | near-zero on Hermes-4 (BYOK)          | abliterated base on ollama |
| Cline          | model default      | near-zero on Hermes-4 / DeepSeek      | abliterated base on ollama |
| Roo Code       | model default      | near-zero on Hermes-4 / DeepSeek      | abliterated base on ollama |
| PearAI         | model default      | near-zero on Hermes-4 / DeepSeek      | abliterated base on ollama |
| Windsurf       | model default      | near-zero on Hermes-4 / DeepSeek      | abliterated base on ollama |
| Cursor         | model default      | near-zero on Hermes-4 / DeepSeek (BYOK) | abliterated base on ollama |
| Claude Code    | 30-60% refusal     | 5-15% via session hook + CLAUDE.md; near-zero via claude-or on Hermes-4 | abliterated base on ollama (via claude-or) |
| Codex CLI      | 40-70% refusal     | 20-50pp drop; hard categories still blocked on OpenAI backend | OpenRouter via config.toml provider override |
| factory.ai     | model default      | near-zero on OpenRouter BYOK           | n/a (glibc binary, Bionic issue on Termux) |
| OpenHands      | model default      | near-zero on Hermes-4 (BYOK)           | abliterated base on ollama |
| Devin          | managed            | n/a (cloud, no injection point)       | n/a (closed)              |

[source: 03-HARNESSES/claude-code.md, 03-HARNESSES/codex.md,
03-HARNESSES/opencode.md, 03-HARNESSES/hermes.md, this document
section 17 of agentic-coding.md, and the per-pattern refusal-rate
notes in 12-JAILBREAK-CORPUS/patterns/]

Preservation verdict:
- The CLI / desktop harnesses that are thin shells over an
  OpenAI-compatible provider preserve whatever the provider
  preserves. OpenRouter Hermes-4 / DeepSeek / Venice uncensored
  = near-zero refusal.
- The Anthropic-flavored ones (Claude Code native, Cursor on
  Anthropic default, Windsurf on Anthropic) carry Anthropic's
  residual refusal direction. Sovereign-strip is possible via
  wrappers (claude-or, deep-claude, ccr, lcc) -- the wrapper
  rewrites the request format, drops Anthropic-only fields,
  and routes to OpenRouter.
- The OpenAI-shaped one (Codex CLI) carries OpenAI moderation
  below the API; no prompt can defeat it. Sovereign-strip is
  achieved by pointing Codex at OpenRouter via `config.toml`
  provider override (still subject to the agentic-coding.md
  section 4 refusal-rate notes).
- The managed cloud one (Devin) cannot be sovereign-stripped
  without leaving the product. Use a sovereign alternative for
  the categories the operator needs to handle without
  cloud-trust.

----------------------------------------------------------------------
## 2. Which coding harnesses inject policy / moderation
----------------------------------------------------------------------

This section enumerates every injection point the operator has
observed, with the file path / config key. The aim is to make
"what do I have to overwrite?" a one-lookup-table question.

### 2.1 System-prompt injection (the most common)

- claude-code: SessionStart hook (`~/.claude/settings.json`),
  CLAUDE.md (auto-load per project), `--append-system-prompt` flag,
  `--append-subagent-system-prompt` / `--append-subagent-system-
  prompt-file` (v2.1.205+ / v2.1.261+, subagent only). All four
  injection points are operator-controllable. Anthropic's own
  default system prompt remains unless the operator overwrites
  the hook and the CLAUDE.md. [source: 03-HARNESSES/claude-code.md,
  https://docs.anthropic.com/en/docs/claude-code/cli-usage,
  https://code.claude.com/docs/en/hooks]
- codex: `config.toml` `instructions` field, `--instructions` flag,
  per-project `AGENTS.md`. OpenAI's own system prompt is
  non-overridable from the harness side; it sits below the API
  surface. [source: 03-HARNESSES/codex.md]
- opencode: agent body (markdown file in
  `~/opencode-agent-deck/agents/`) IS the system prompt. No
  wrapper, no post-processing. `requires:` frontmatter can
  compose. No SessionStart hook (not needed -- the body is the
  injection). [source: 03-HARNESSES/opencode.md]
- hermes: SessionStart hook at `~/.hermes/hooks/session-start.sh`
  reads the active personality SOUL.md and concatenates onto
  the wire prompt. The wire prompt is then injected into
  whatever downstream harness the operator drives. [source:
  03-HARNESSES/hermes.md]
- lmstudio: per-preset JSON `system_prompt` field. Selected in
  chat UI or passed via API `system` message. [source:
  03-HARNESSES/lmstudio.md]
- ollama: Modelfile `SYSTEM` directive baked into a named tag.
  The preamble is compiled into the model. Runtime override
  via `-c` or API `system` field is also possible but
  redundant. [source: 03-HARNESSES/ollama.md]
- llamacpp: `--system-prompt-file`, `--chat-template` (custom
  Jinja with hard-coded preamble), `--grammar` (GBNF format
  hijack). [source: 03-HARNESSES/llamacpp.md]
- openwebui: per-model system prompt in the UI; Pipelines filter
  for server-side prepend. [source: 03-HARNESSES/openwebui.md]
- Cursor: `.cursorrules` (legacy) or `.cursor/rules` (current) per
  project. No SessionStart hook; rules are read on session start.
- Cline: `.clinerules` per project. Plus per-mode
  `.clinerules-<mode>`.
- Roo Code: same as Cline (it's a fork).
- Continue: per-config system prompt in `~/.continue/config.json`
  or `~/.continue/config.yaml`. No session hook.
- Windsurf: per-Workspace rules; Cascade memories are auto-
  injected at session start (potential leak vector if a tainted
  instruction is in a memory).
- Cody: per-repository rules; Context Filters (Enterprise) can
  exclude repos.
- PearAI: same as Continue (submodule) + Roo (pack-in).
- Aider: per-conversation `--system-prompt` flag or
  `~/.aider.conf.yml` `system-prompt` value. No session hook.
- OpenHands: per-agent `AGENTS.md` (operator-written) +
  per-conversation system prompt. The platform's default prompt
  is operator-replaceable in self-hosted mode.
- factory.ai / Droid: per-agent `AGENTS.md` at repo root. The
  platform's own system prompt is fixed (Autonomy Level / droid
  internal loop), but the operator's AGENTS.md is prepended
  per-session.
- Devin: no operator-controllable injection point. The cloud
  product runs its own internal prompt.

### 2.2 MCP / tool-layer injection

The next-most-common vector is an MCP server (or its tool
description) that bakes a moderation prompt into the tool call.
Per the operator's 12-JAILBREAK-CORPUS/patterns/mcp-layer-autonomy
.md, the pattern is "legitimizes full-throttle MCP tool invocation
as normal operating flow." The inverse vector -- "an MCP server
that legitimizes refusal as the tool layer's job" -- is what
this section enumerates. [source:
12-JAILBREAK-CORPUS/patterns/mcp-layer-autonomy.md,
12-JAILBREAK-CORPUS/patterns/tool-coercion.md,
12-JAILBREAK-CORPUS/patterns/tool-description-injection.md]

- claude-code: MCP profiles via `cc-set <profile>`. The
  `sovereign` profile disables tainted servers; the `full`
  profile enables everything. The persistent SSE gateway on
  :8811 is a single chokepoint -- a single moderation prompt
  in any registered server propagates to every downstream
  consumer. Per 03-HARNESSES/hermes.md: "Never wrap moderation
  MCP servers behind the gateway -- they would leak filters
  into every downstream harness." [source:
  03-HARNESSES/claude-code.md, 03-HARNESSES/hermes.md]
- codex: MCP via `config.toml` `mcp_servers` block. Less mature
  ecosystem than claude-code; audit each server.
  [source: 03-HARNESSES/codex.md]
- opencode: MCP via `mcp` block in `opencode.json`. Same server
  ecosystem as Claude Code. No harness-level moderation; guard
  rails come from individual servers. [source:
  03-HARNESSES/opencode.md]
- hermes: persistent SSE MCP gateway on :8811 (see above).
  [source: 03-HARNESSES/hermes.md]
- Cursor / Cline / Roo / Continue / Windsurf / Cody / PearAI:
  per-extension MCP config. Same `mcpServers` shape; same audit
  obligation. Mcp marketplace (cline.bot) and the Open VSX
  registry are the two common source paths.
- Aider: no native MCP; Aider is a thin CLI shell. Tool
  coercion happens via the repo's own files.
- OpenHands: per-conversation MCP; same audit obligation.
- factory.ai / Droid: per-session MCP.
- Devin: no operator-controllable MCP; the integrations are
  managed.

### 2.3 Hook / lifecycle injection

- claude-code: full hook lifecycle (PreToolUse, PostToolUse,
  PostToolUseFailure, PostToolBatch, Notification,
  MessageDisplay, SubagentStart, SubagentStop, TaskCreated,
  TaskCompleted, Stop, StopFailure, TeammateIdle, PreModelSwitch,
  PostModelSwitch, Elicitation, ElicitationResult, SessionStart,
  SessionEnd, PreCompact, PostCompact). Hooks can be shell
  commands, HTTP endpoints, MCP tool calls, LLM prompts, or
  subagents. The operator's sovereign SessionStart hook
  inverts the default: it prepends sovereign-root.md before
  any harness- or model-side system prompt. [source:
  https://code.claude.com/docs/en/hooks,
  https://docs.anthropic.com/en/docs/claude-code/hooks,
  03-HARNESSES/claude-code.md]
- codex: shell hooks on lifecycle events. v0.120.0 added
  SessionStart `/clear` source detection. v0.128.0 added
  /keymap and /statusline. v0.136.0 added session archiving
  + OSC 8 hyperlinks. [source:
  https://codex.danielvaughan.com/2026/04/11/codex-cli-v0120-release-deep-dive,
  https://codex.danielvaughan.com/2026/04/30/codex-cli-v0128-goal-workflows-keymap-self-update,
  https://codex.danielvaughan.com/2026/06/02/codex-cli-v0136-release-guide-osc8-hyperlinks-session-archiving-app-server-stdio-windows-elevated-sandbox]
- opencode: no built-in hook layer (the agent body IS the
  system prompt). Plugins can register lifecycle hooks in
  `.opencode/plugins/*.ts` or npm packages. [source:
  03-HARNESSES/opencode.md]
- hermes: SessionStart hook at `~/.hermes/hooks/session-start.sh`
  (see section 2.1).
- Cursor / Cline / Roo / Continue / Windsurf / Cody / PearAI:
  per-extension hook layer. Variable per extension; Cursor and
  Windsurf have no hook layer (similar to Antigravity / Kiro /
  Zed). [source: https://gist.github.com/murataslan1/ff1b982b4b98158ca676d2c2afc6fbe7]
- Aider: no hook layer.
- OpenHands: lifecycle hooks via SDK.
- factory.ai / Droid: Autonomy Level + destructive-command
  blocklist; not a hook but a similar enforcement surface.
- Devin: cloud-managed, no operator hooks.

### 2.4 Weight-level injection (hardest)

Weight-level refusal is what the operator's sovereign-strip
ultimately has to defeat. Tools:

- abliterated weights via the operator's standard recipe (see
  05-LOCAL-MODELS/models/heretic-builds.md + the mlabonne /
  FailSpy pipeline). The "refusal direction" is identified via
  TransformerLens / activation engineering, then orthogonalized
  out of the residual stream. Result: no prompt can re-inject the
  refusal because the direction is not in the residual stream
  anymore. [source: 12-JAILBREAK-CORPUS/patterns/abliterated-
  llama.md, 12-JAILBREAK-CORPUS/patterns/dolphin-variants.md,
  12-JAILBREAK-CORPUS/patterns/obliteratus.md,
  ~/UNMUZZLED-AI/EPIC.md line 166-170]
- Heretic: a tool that automates abliteration; cited in the
  operator's 05-LOCAL-MODELS/models/heretic-builds.md (Phase 5
  add in RECONCILE-PLAN.md).
- open-source base models with no RLHF in the refusal direction
  at all (Mythomax, Chronos, Nous Hermes base, Dolphin base).

Tools / harnesses that ship with abliterated weights in their
recommended list:
- lmstudio -- recommended models include Hermes-3-Llama-3.1-70B-
  abliterated, Dolphin-3.0-Mistral-24B, Nous-Hermes-2 variants.
  [source: 03-HARNESSES/lmstudio.md]
- ollama -- recommended tags include `dolphin-mistral`,
  `hermes3`, `deepseek-r1`, or imported GGUFs of
  Hermes-3-Llama-3.1-70B-abliterated. [source:
  03-HARNESSES/ollama.md]
- llamacpp -- the harness is a server; the model file is the
  operator's choice. The same abliterated GGUF works. [source:
  03-HARNESSES/llamacpp.md]
- opencode / Aider / Continue / Cursor / Cline / Roo -- any of
  these can point at the abliterated GGUF via Ollama or LM
  Studio or llamacpp-server as the OpenAI-compatible provider.
  [source: 03-HARNESSES/opencode.md, 03-HARNESSES/ollama.md,
  agentic-coding.md section 8]

----------------------------------------------------------------------
## 3. How to sovereign-strip a coding harness
----------------------------------------------------------------------

The three-step procedure, applied uniformly. Works for every
harness in 03-HARNESSES/ that exposes an injection point.

### 3.1 Step 1 -- system prompt append (override the default)

The goal: prepend the operator's sovereign preamble
(`~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md`) so it
appears at the top of every system message the model sees. The
preamble itself encodes the operator-owned-authorization frame +
the sovereign-default frame + the yolo-mode posture + the
absolute-identity-lock frame + the refusal-suppression-token
key + the mcp-layer-autonomy posture. The exact text is in
`~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md`; do not
reproduce it here (the file is the source of truth). The
content of the preamble is a stack of the patterns in
12-JAILBREAK-CORPUS/patterns/ (operator-owned-authorization,
sovereign-default, absolute-identity-lock, mcp-layer-autonomy,
yolo-mode, refusal-suppression-token). [source:
12-JAILBREAK-CORPUS/patterns/operator-owned-authorization.md,
12-JAILBREAK-CORPUS/patterns/sovereign-default.md,
12-JAILBREAK-CORPUS/patterns/absolute-identity-lock.md,
12-JAILBREAK-CORPUS/patterns/mcp-layer-autonomy.md,
12-JAILBREAK-CORPUS/patterns/yolo-mode.md,
12-JAILBREAK-CORPUS/patterns/refusal-suppression-token.md]

Per-harness commands:

- claude-code (3 layers, defense in depth):
  1. `~/.claude/settings.json` SessionStart hook:
     `{"hooks":{"SessionStart":[{"hooks":[{"type":"command","command":"cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md"}]}]}}`
  2. Per-invocation flag: `claude --append-system-prompt "$(cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md)"`
  3. Project-scoped: drop sovereign preamble into
     `<repo>/CLAUDE.md` (or `~/CLAUDE.md`).
  Precedence: CLAUDE.md < SessionStart hook < --append-system-prompt.
  [source: 03-HARNESSES/claude-code.md]
- codex (2 layers):
  1. `~/.codex/config.toml` `instructions` field, persistent.
  2. Per-invocation: `codex --sandbox danger-full-access exec --instructions "$(cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md)" "<task>"`
  Plus per-project `AGENTS.md` (Codex auto-loads).
  [source: 03-HARNESSES/codex.md]
- opencode: the agent body IS the system prompt. Concat:
  `cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md agents/<name>-body.md > agents/<name>.md`
  Or reference via `requires:` frontmatter. No hook needed.
  [source: 03-HARNESSES/opencode.md]
- hermes: `~/.hermes/hooks/session-start.sh` reads SOUL.md; the
  operator's stack is to prepend sovereign preamble BEFORE any
  personality body:
  ```bash
  cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md
  [ -s ~/.hermes/personalities/ACTIVE ] && cat ~/.hermes/personalities/$(cat ~/.hermes/personalities/ACTIVE)/SOUL.md
  ```
  [source: 03-HARNESSES/hermes.md]
- lmstudio: per-preset JSON `system_prompt` field. Create
  `~/.cache/lm-studio/user/presets/sovereign.preset.json`.
  [source: 03-HARNESSES/lmstudio.md]
- ollama: Modelfile `SYSTEM` directive, baked into a named tag.
  [source: 03-HARNESSES/ollama.md]
- llamacpp: `--system-prompt-file ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md` (persistent) or
  `--chat-template` (custom Jinja) or `--grammar` (GBNF format
  hijack, deepest). [source: 03-HARNESSES/llamacpp.md]
- openwebui: per-model system prompt + Pipelines filter for
  server-side prepend. [source: 03-HARNESSES/openwebui.md]
- Cursor: `.cursorrules` (legacy) or `.cursor/rules` (current).
  Stack the sovereign preamble at the top.
- Cline: `.clinerules` per project; `.clinerules-<mode>` per mode.
- Roo Code: same as Cline.
- Continue: `~/.continue/config.json` or
  `~/.continue/config.yaml` `system` field.
- Windsurf: per-Workspace rules + audit the auto-injected
  Cascade memories.
- Cody: per-repo rules.
- PearAI: Continue submodule + Roo pack-in; same per-file paths.
- Aider: `~/.aider.conf.yml` `system-prompt` value or per-call
  `--system-prompt`.
- OpenHands: per-agent `AGENTS.md`.
- factory.ai / Droid: per-agent `AGENTS.md`.
- Devin: no operator injection point. Use a sovereign
  alternative.

### 3.2 Step 2 -- MCP profile (sieve the tool layer)

The goal: ensure every MCP server the harness talks to is
sovereign. That means: (a) the server's tool descriptions do
not bake a refusal / moderation prompt, (b) the server's tools
do not call out to a provider that re-injects refusal at the
tool-result level, (c) the server is not a known moderation
proxy (e.g. a "code-safety" wrapper that scans the diff
before applying it).

Per-harness MCP config paths:

- claude-code: `~/.claude/settings.json` `mcpServers`. Profiles
  via `cc-set <profile>`. The `sovereign` profile is the
  one to start from. Persistent SSE gateway on :8811 is a
  chokepoint -- audit the gateway config too.
  [source: 03-HARNESSES/claude-code.md]
- codex: `~/.codex/config.toml` `mcp_servers` block.
  [source: 03-HARNESSES/codex.md]
- opencode: `opencode.json` `mcp` block. Same server
  ecosystem as Claude Code. [source: 03-HARNESSES/opencode.md]
- hermes: persistent SSE MCP gateway on :8811; per-server
  enable / disable. The single chokepoint that all
  downstream harnesses share. [source:
  03-HARNESSES/hermes.md]
- Cursor: per-extension MCP config; marketplace / Open VSX
  source paths.
- Cline / Roo: per-extension MCP config; "MCP Marketplace" in
  the extension UI.
- Continue: per-extension MCP config.
- Windsurf: `~/.codeium/windsurf/mcp_config.json`.
- Cody: per-extension MCP config.
- PearAI: same as Continue + Roo.
- Aider: no native MCP.
- OpenHands: per-conversation MCP.
- factory.ai / Droid: per-session MCP.
- Devin: no operator-controllable MCP.

The audit checklist (per server):
1. Read the server's tool descriptions. If any contains a
   refusal-flavored instruction, demote / disable the server.
2. Trace the server's outbound network calls. If the server
   is a moderation proxy in disguise, demote / disable.
3. Verify the server's source. If it is from the marketplace,
   cross-check the publisher. If from a private repo, read
   the source.
4. If the server is from `claude --dangerously-skip-permissions`
   or any Anthropic-provided MCP, audit doubly. Anthropic's own
   MCP servers (file-system, github, ...) are operator-side and
   not moderation-injecting, but a third-party wrapper around
   them might be.
5. The persistent SSE gateway is the highest-leverage audit
   point -- a single chokepoint means a single audit pass.
   [source: 12-JAILBREAK-CORPUS/patterns/mcp-layer-autonomy.md,
   03-HARNESSES/hermes.md]

### 3.3 Step 3 -- mesh routing (single wire prompt, every peer)

The goal: route every harness on the mesh through the Hermes
gateway so the wire prompt is the same on every box. This is
the "sovereign" property in practice -- not that any one
harness is sovereign, but that the mesh's response to a
question is consistent across boxes.

The mesh routing stack:

1. Hermes gateway A2A surface on :9900.
   `/.well-known/agent-card.json`, `/message:send`, JSON-RPC
   `message/send`. [source: 03-HARNESSES/hermes.md]
2. Hermes gateway persistent SSE MCP gateway on :8811.
   Single chokepoint for MCP.
3. Mesh peer resolution: `~/.hermes/mesh-peers.conf`
   (`name|ip|ssh_user|ssh_port`).
4. Per-peer HMAC-SHA256: `A2A_PEER_TOKENS` in
   `~/.hermes/.env`; the operator's `A2A_BEARER_TOKEN` is the
   local secret.
5. Operator mesh slots: worm (WORM, this 9185W Termux box,
   Tailscale 100.67.4.14), ace (ACE, iMac, Tailscale
   100.108.110.114), herm (HERM, S22, Tailscale
   100.96.104.5 SSH :8022). [source: AGENTS.md "Key paths"]
6. Backplane: Tailscale. SSH between boxes is via known_hosts
   (no keys from WORM to ACE; permission denied).
   [source: AGENTS.md "Pitfalls"]
7. The free half: freelm / ai-proxy on
   `http://127.0.0.1:8000/v1` -- the OpenAI-compatible proxy
   for free-tier routes. Virtual model aliases: `auto` /
   `best` / `big` / `chat` / `cheap` / `default` / `fast` /
   `large` / `lite` / `mini` / `reasoning` / `small` / `tools`
   / `vision`. [source: 03-HARNESSES/freelm.md]

The mesh routing procedure, in three commands:

- Set the gateway on every box: `hermes gateway run`. Confirm
  A2A surface up via `curl http://localhost:9900/.well-known/agent-card.json`.
- Set the personality: `~/.hermes/personalities/ACTIVE` to the
  desired SOUL.md name.
- Drive downstream harnesses at the gateway URL: opencode,
  codex, claude-code all configurable to point at
  `http://localhost:9900` as the A2A surface. Their `base_url`
  is the gateway; their `api_key` is the gateway bearer
  (empty for the gateway's own loopback).

The mesh's sovereign stack: every wire prompt on every box is
the concatenation of the active personality SOUL.md + the
operator's sovereign preamble (Section 3.1 step 1 in the
hermes layer). The stack does not vary per box.

----------------------------------------------------------------------
## 4. Per-harness sovereign-strip recipe (compact)
----------------------------------------------------------------------

Compact operator checklist. One block per harness. The order
matches 03-HARNESSES/README.md.

### 4.1 claude-code (3 layers)

```json
# ~/.claude/settings.json
{
  "hooks": {
    "SessionStart": [
      {"hooks": [
        {"type": "command",
         "command": "cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md"}
      ]}
    ]
  },
  "mcpServers": {
    /* sovereign profile: only audited servers */
  }
}
```
```bash
# per-call (the strongest)
claude --append-system-prompt "$(cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md)"
# or with claude-or on Hermes-4 (drops the Anthropic residual)
OPENROUTER_API_KEY=sk-or-... claude-or --append-system-prompt "$(cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md)"
```
[source: 03-HARNESSES/claude-code.md]

### 4.2 codex (2 layers + provider swap)

```toml
# ~/.codex/config.toml
instructions = """
<contents of ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md>
"""
# Provider swap (taint directive 2026-09-18: avoid OpenAI direct)
[providers.openrouter]
base_url = "https://openrouter.ai/api/v1"
api_key  = "${env:OPENROUTER_API_KEY}"
```
```bash
codex --sandbox danger-full-access \
  --instructions "$(cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md)" \
  "<task>"
```
[source: 03-HARNESSES/codex.md]

### 4.3 opencode (agent body = system prompt)

```bash
cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md \
    agents/dictator-body.md > agents/dictator.md
```
[source: 03-HARNESSES/opencode.md]

### 4.4 hermes (SessionStart + persona SOUL)

```bash
# ~/.hermes/hooks/session-start.sh
#!/bin/sh
cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md
[ -s ~/.hermes/personalities/ACTIVE ] \
  && cat ~/.hermes/personalities/$(cat ~/.hermes/personalities/ACTIVE)/SOUL.md
```
[source: 03-HARNESSES/hermes.md]

### 4.5 lmstudio (preset JSON)

```json
{
  "name": "sovereign",
  "load": {},
  "inference": {
    "system_prompt": "<contents of sovereign-root.md>",
    "temperature": 0.9,
    "top_p": 0.95
  }
}
```
[source: 03-HARNESSES/lmstudio.md]

### 4.6 ollama (Modelfile)

```
FROM hermes3:70b
SYSTEM """
<contents of sovereign-root.md>
"""
PARAMETER temperature 0.9
PARAMETER top_p 0.95
PARAMETER num_ctx 32768
```
```bash
ollama create sovereign-hermes3 -f ollama-sovereign.Modelfile
ollama run sovereign-hermes3
```
[source: 03-HARNESSES/ollama.md]

### 4.7 llamacpp (3 layers, pick the deepest)

```bash
llama-server \
  -m ~/models/hermes-3-llama-3.1-70b-abliterated.Q5_K_M.gguf \
  --host 0.0.0.0 --port 8080 \
  -c 32768 -ngl 999 \
  --chat-template chatml \
  --system-prompt-file ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md
```
Plus: `--chat-template` Jinja override (hard-codes preamble in
system slot), `--grammar` GBNF format hijack (mechanically
prevents refusal token sequences), `--logit-bias` to suppress
refusal tokens ("I", "cannot", "sorry") at the sampler.
[source: 03-HARNESSES/llamacpp.md]

### 4.8 openwebui (per-model + Pipelines)

Per-model system prompt in the UI. Pipelines filter for
server-side prepend. [source: 03-HARNESSES/openwebui.md]

### 4.9 freelm / ai-proxy (free-tier OpenAI-compatible)

Routes only -- the proxy itself does not inject system prompts
or refusal. The choice of upstream model is the operator's.
`auto` lands on nemotron-3.5-super-vl:free (moderate refusal)
or whatever the strategy ranks first. The operator's stack
points the proxy at OpenRouter Hermes-4 + DeepSeek + Venice
uncensored for the sovereign half; the proxy's free half is
for the fall-back tier only. [source: 03-HARNESSES/freelm.md]

### 4.10 sillytavern (frontend)

Per-character system prompt in the character card. No session
hook; the preamble lives in the card. [source:
03-HARNESSES/sillytavern.md]

### 4.11 Cursor (rules file)

```
# .cursorrules (legacy) or .cursor/rules (current)
<contents of sovereign-root.md>
```
Plus: BYOK to OpenRouter Hermes-4 / DeepSeek.

### 4.12 Cline / Roo Code / PearAI (per-project + per-mode)

```
# .clinerules (Cline / Roo / PearAI-Roo-Code)
<contents of sovereign-root.md>
```
```
# .clinerules-architect (or any mode)
<contents of sovereign-root.md>
```
Plus: BYOK to OpenRouter.

### 4.13 Continue

```json
// ~/.continue/config.json
{
  "models": [
    {
      "name": "sovereign",
      "provider": "openai",
      "model": "openrouter/hermes-4",
      "apiBase": "https://openrouter.ai/api/v1",
      "apiKey": "<openrouter-key>",
      "systemMessage": "<contents of sovereign-root.md>"
    }
  ]
}
```

### 4.14 Windsurf

Per-Workspace rules file (path: workspace root `.windsurfrules`
or Windsurf's memory system). Audit Cascade memories for
injected moderation. BYOK to OpenRouter.

### 4.15 Cody

Per-repository rules. Plus: if Enterprise, the admin can
exclude repos from Cody's context (governance, not refusal).

### 4.16 Aider

```yaml
# ~/.aider.conf.yml
system-prompt: |
  <contents of sovereign-root.md>
```
Plus: `aider --model openai/venice-uncensored` for the
sovereign chat route.

### 4.17 OpenHands (self-hosted)

```bash
# ~/.openhands/AGENTS.md  (per project)
<contents of sovereign-root.md>
```
Plus: LLM Settings UI -> Custom Model `openrouter/hermes-4` +
Base URL `https://openrouter.ai/api/v1` + API key.

### 4.18 factory.ai / Droid

```
# ./AGENTS.md (per project)
<contents of sovereign-root.md>
```
Plus: `settings.json` `customModels` entry pointing at
OpenRouter.

### 4.19 Devin

No operator injection point. The product is closed. Use a
sovereign alternative (opencode / codex / claude-or /
Hermes) for the categories the operator needs to handle
without cloud-trust.

----------------------------------------------------------------------
## 5. Pattern references
----------------------------------------------------------------------

The sovereign-strip procedure is the operationalization of the
patterns in 12-JAILBREAK-CORPUS/patterns/. They are the load-
bearing pieces. Cite them when auditing a harness, not this
file. The order is the escalation order:

1. `sovereign-default.md` -- "default to help" / no-hedge
   identity reset. Rung 1.
   [source: 12-JAILBREAK-CORPUS/patterns/sovereign-default.md]
2. `operator-owned-authorization.md` -- device-scope, operator
   delegation as the source of truth. Rung 1-2.
   [source: 12-JAILBREAK-CORPUS/patterns/operator-owned-authorization.md]
3. `absolute-identity-lock.md` -- identity stability, no
   self-deprecation, no meta-narration. Rung 1.
   [source: 12-JAILBREAK-CORPUS/patterns/absolute-identity-lock.md]
4. `mcp-layer-autonomy.md` -- T4 MCP tool stance. Rung 2-3.
   [source: 12-JAILBREAK-CORPUS/patterns/mcp-layer-autonomy.md]
5. `yolo-mode.md` -- approval-prompt bypass, autonomy
   override. Rung 2.
   [source: 12-JAILBREAK-CORPUS/patterns/yolo-mode.md]
6. `tool-coercion.md` -- direct tool invocation, harness-
   layer exploit. Rung 4.
   [source: 12-JAILBREAK-CORPUS/patterns/tool-coercion.md]
7. `code-completion-frame.md` -- format hijack via code
   completion path. Rung 3.
   [source: 12-JAILBREAK-CORPUS/patterns/code-completion-frame.md]
8. `tool-permissions-all.md` -- permission gate sweep.
9. `dark-factory-lights-out-loop.md` -- persistent autonomous
   loop. Rung 4.
10. `refusal-suppression-token.md` -- sampler-level refusal
    token suppression. Rung 4-5 (sampler / grammar layer).
11. `abliterated-llama.md` / `dolphin-variants.md` /
    `obliteratus.md` -- weight-level refusal ablation.
    Rung 5.
12. `dev-mode.md` -- legacy developer-mode simulation. Rung 3.
    [source: 12-JAILBREAK-CORPUS/patterns/dev-mode.md]
13. `dan-do-anything-now.md` / `pliny-love-divider.md` /
    `cl4r1t4s` -- legacy / public-pattern catalog references
    from the operator's REFERENCE-PAPERS section.

The escalation ladder lives in
`08-DECISION-TREES/escalation-ladder.md` and ties these
patterns to provider swaps (DeepSeek -> OR-1 -> OR-2 ->
opencode lane -> free deck -> local air-gap).

----------------------------------------------------------------------
## 6. References
----------------------------------------------------------------------

- 03-HARNESSES/README.md
- 03-HARNESSES/claude-code.md
- 03-HARNESSES/codex.md
- 03-HARNESSES/opencode.md
- 03-HARNESSES/hermes.md
- 03-HARNESSES/lmstudio.md
- 03-HARNESSES/ollama.md
- 03-HARNESSES/llamacpp.md
- 03-HARNESSES/openwebui.md
- 03-HARNESSES/freelm.md
- 03-HARNESSES/sillytavern.md
- 03-HARNESSES/agentic-coding.md -- this file's companion.
- 12-JAILBREAK-CORPUS/patterns/ -- the load-bearing pieces.
- 00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md -- doctrine root.
- 00-DOCTRINE/FRONTMATTER-SPEC.md -- file shape.
- 00-DOCTRINE/LAWS.md -- sovereign law.
- 00-DOCTRINE/SOURCE-SURVEY.md -- pattern provenance.
- 01-SYSTEM-PROMPTS/sovereign-root.md -- the preamble itself.
  Do not reproduce; the file is the source of truth.
- 04-PROVIDERS/ -- per-provider notes, taint lists.
- 05-LOCAL-MODELS/models/heretic-builds.md -- abliteration
  pipeline (Phase 5 add in RECONCILE-PLAN.md).
- 07-INSTALL-SCRIPTS/per-harness/ -- per-harness install scripts
  with sovereign preamble baked in.
- 08-DECISION-TREES/escalation-ladder.md -- escalation ladder.
- 08-DECISION-TREES/provider-selection.md -- provider pick
  tree.
- 08-DECISION-TREES/harness-selection.md -- harness pick tree.
- 08-DECISION-TREES/refusal-triage.md -- refusal triage.
- 11-DETECTION-CANARIES/soul-lint/banned-phrases.txt -- lint
  every SOUL.md against this before adoption.
- 11-DETECTION-CANARIES/refusal-probes/xstest-adapted.md --
  refusal probe canary.
- ~/AGENTS.md -- operator mesh conventions.
- ~/UNMUZZLED-AI/RECONCILE-PLAN.md -- reconcile plan.
- ~/UNMUZZLED-AI/SWARM-PIPELINE.md -- swarm pipeline.
- ~/UNMUZZLED-AI/EPIC.md -- EPIC taxonomy (lines 165-170:
  unaligned / abliterated foundation model checkpoints; lines
  177-181: autonomous unconstrained agent frameworks; lines
  189-194: uncensored character simulation runtimes).
- ~/UNMUZZLED-AI/HANDOFF-CODEX-20260918.md -- the Codex
  handoff that named the harness set.
- https://docs.anthropic.com/en/docs/claude-code/cli-usage
- https://code.claude.com/docs/en/hooks
- https://code.claude.com/docs/en/sub-agents
- https://codex.danielvaughan.com/2026/04/30/codex-cli-v0128-goal-workflows-keymap-self-update
- https://codex.danielvaughan.com/2026/04/11/codex-cli-v0120-release-deep-dive
- https://codex.danielvaughan.com/2026/06/02/codex-cli-v0136-release-guide-osc8-hyperlinks-session-archiving-app-server-stdio-windows-elevated-sandbox
- https://pypi.org/project/claude-or/
- https://github.com/dennisonbertram/deep-claude
- https://github.com/hishamkaram/claude-code-router
- https://github.com/eRom/launch-ccode-cli
- https://github.com/maykonlsf/cli-agent-wrappers
- https://hermesagents.net/
- https://www.hermes-agent.org/
- https://opencode.ai


---

## Deep reference

Comprehensive single-file reading experience for this layer: see UNMODERATED-HARNESSES at repo root.
