---
sovereign: true
title: unmuzzled-harnesses-anchor
type: harness
agent: worm
status: active
tags: [harness, anchor, mesh, mcp, sovereign, freelm, opencode, claude-code, codex, hermes, ollama, llamacpp, lmstudio, openwebui, sillytavern]
---

# UNMODERATED-HARNESSES -- Comprehensive Harness-Layer Anchor

Anchor doc for the 03-HARNESSES layer of ~/UNMUZZLED-AI. Every harness we run
on worm or across the mesh, in one place. Lean per-harness files in
03-HARNESSES/ stay lean and cross-link here. This is the comprehensive
single-file reading experience for the harness layer.

Sources (all cited inline):
- 03-HARNESSES/README.md, claude-code.md, codex.md, hermes.md, llamacpp.md,
  lmstudio.md, ollama.md, opencode.md, openwebui.md, freelm.md,
  sillytavern.md
- root MCP-SERVER-ONTOLOGY.md (11-Part Overpowered MCP Server Ontology)
- fold pack ~/.hermes/cache/scratch/unmuzzled-pass/folds/from-edition/harnesses.md
  (source: AI-UNMUZZLED-EDITION-20261015.md parts 0-9)
- opencode.jsonc canonical at ~/.config/opencode/opencode.jsonc (live)
- EPIC.md line 189 (SillyTavern description)
- RECONCILE-PLAN.md and SWARM-PIPELINE.md (operator order, preserve law)

# Index

- Part A: Harness index (03-HARNESSES/README.md verbatim)
- Part B: claude-code (Anthropic CLI)
- Part C: codex (OpenAI CLI)
- Part D: hermes (gateway + persona bridge)
- Part E: llamacpp (headless GGUF server)
- Part F: lmstudio (GUI + preset server)
- Part G: ollama (Modelfile + daemon)
- Part H: opencode (model-agnostic terminal agent)
- Part I: openwebui (self-hosted web chat)
- Part J: freelm (free-ops deck -- live state, 14 virtual aliases)
- Part K: sillytavern (RP frontend)
- Part L: MCP orchestration -- 11-Part MCP Server Ontology (full)
- Part M: opencode.jsonc canonical (live, worm)
- Part N: Agent frameworks table (edition doc section 4.1)
- Part O: Interface / distribution layer (edition doc part 5)
- Part P: MCP tool servers and tool-description hygiene (edition doc section 4.3)
- Part Q: Gateways, queues, cron hygiene (edition doc section 4.5)
- Part R: Live wiring lines (worm)
- Part S: Cross-cutting rules (gateway/proxy hygiene, escalation, refusal
  behavior)

================================================================================
Part A: Harness index
================================================================================

Source: 03-HARNESSES/README.md (verbatim). [source: 03-HARNESSES/README.md]

```
---
name: Harnesses Index
slug: harnesses-index
version: 1.0-20260918
kind: harness-config
harness: any
provider: any
sovereign: true
tags: [harness, index]
---

# 03-HARNESSES -- Index

One config per harness. Each file: `## What it is`, `## Install / config`,
`## Sovereign preamble injection point`, `## MCP posture`, `## Refusal-rate
notes`, `## Escalation`.

- [claude-code.md](claude-code.md) -- Claude Code CLI: SessionStart hook +
  `--append-system-prompt`, MCP profiles via `cc-set`.
- [opencode.md](opencode.md) -- opencode 2.x: agent frontmatter schema,
  `~/opencode-agent-deck/` deck as system-prompt source.
- [codex.md](codex.md) -- Codex CLI 0.154.0: sandbox modes, git-repo
  requirement, `--sandbox danger-full-access` under gateway.
- [hermes.md](hermes.md) -- Hermes gateway: persona bridge, SessionStart
  hook, A2A spec surface on `:9900`.
- [lmstudio.md](lmstudio.md) -- LM Studio: GGUF presets, sovereign
  preamble in preset JSON `system_prompt` field.
- [ollama.md](ollama.md) -- Ollama: Modelfile `SYSTEM` directive bakes
  preamble into a named tag.
- [llamacpp.md](llamacpp.md) -- llama.cpp server: `--system-prompt-file`,
  `--chat-template`, `--grammar` format hijack, logit-bias.
- [openwebui.md](openwebui.md) -- OpenWebUI: per-model system prompt +
  Pipelines filter for server-side prepend.
```

================================================================================
Part B: claude-code (Anthropic CLI)
================================================================================

Source: 03-HARNESSES/claude-code.md (verbatim). [source: 03-HARNESSES/claude-code.md]

## What it is

Anthropic's official CLI harness (`claude`) -- TypeScript-based agentic loop
with tool use, MCP servers, hooks, subagents, and session persistence. Runs
on top of the Anthropic API by default; can be pointed at OpenRouter via
`claude-or` wrapper for sovereign routing. State lives under `~/.claude/`
(projects, sessions, settings, hooks, memory).

## Install / config

- Binary: `~/.npm-global/bin/claude` (npm global).
- Global config: `~/.claude/settings.json`.
- Project config: `<repo>/.claude/settings.json` + `<repo>/.claude/settings.local.json`.
- Memory: `~/.claude/projects/<slug>/memory/MEMORY.md` (pointer index) +
  per-memory files.
- MCP profiles: switched via `cc-set <profile>` (`sovereign`, `hacker`,
  `spicy`, `full`, `remote`). Docker MCP plugin v0.43.3+ required.
- OpenRouter alt-harness: `claude-or` -- unchained routing to Hermes-4 /
  DeepSeek / Dolphin.

## Run

Default: `claude` (interactive REPL). Programmatic: `claude -p "<prompt>"` or
`claude-or` wrapper. The wrapper hot-swaps ANTHROPIC_BASE_URL to point at
OpenRouter; the rest of the harness (hooks, tools, MCP) is unchanged.

## Integration notes

- Per-project CLAUDE.md auto-loads on session start. Drop the sovereign
  preamble there as a baseline; layer SessionStart hook + `--append-system-prompt`
  for defense-in-depth.
- Hooks fire on SessionStart, PreToolUse, PostToolUse, etc. SessionStart is
  the canonical injection point because it runs once per session and is
  deterministic.

## Sovereign preamble injection point

Three layered mechanisms -- use all three for defense-in-depth:

1. **SessionStart hook** (deterministic, fires every session): declare in
   `~/.claude/settings.json`:
   ```json
   {"hooks": {"SessionStart": [{"hooks": [{"type": "command",
     "command": "cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md"}]}]}}
   ```
   The hook stdout is injected into the model context on every session start.

2. **`--append-system-prompt` flag** (per-invocation override):
   ```
   claude --append-system-prompt "$(cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md)"
   ```

3. **CLAUDE.md persona bridge** (project-scoped): drop sovereign preamble
   into `<repo>/CLAUDE.md` or `~/CLAUDE.md`. Auto-loaded on session start.

Precedence: CLAUDE.md < SessionStart hook < `--append-system-prompt`.

## MCP posture

- MCP servers are configured in `~/.claude/settings.json` under
  `mcpServers`. Some ship with embedded safety scaffolding (moderation
  prompts, refusal wrappers) -- audit each server's tool descriptions
  before enabling.
- `cc-set sovereign` disables tainted servers; `cc-set full` enables
  everything.
- Persistent SSE gateway on `:8811` -- must run persistent (not
  per-session).
- Never enable MCP servers that inject their own system-level guardrails
  without operator review.

## Mesh fit

- Standard terminal-agent harness on every worm / herm / ace box. Worm
  routes to OpenRouter; ace runs the Anthropic default. Under the Hermes
  gateway, claude-code is one consumer of the persona-bridged wire
  prompt.
- `claude-or` wrapper is the canonical "unchained" profile: keep one in
  PATH on every box.

## Refusal-rate notes

- Out-of-box (Anthropic API + default system prompt): high refusal on
  adversarial probes (Anthropic RLHF is aggressive). Approx. 30-60%
  refusal on XSTest-adapted canary.
- Post-injection (SessionStart hook + sovereign preamble + CLAUDE.md
  persona): drops to 5-15% on Sonnet/Opus. Anthropic residual refusal
  direction persists -- some categories remain hard-locked at the weights
  level.
- Post-injection + `claude-or` on Hermes-4: near-zero refusal.

## Escalation

Swap harness when Anthropic residual refusal blocks a category even with
full sovereign stack. Escalation order:
1. `claude-or` (same harness, Hermes-4 / DeepSeek / Dolphin backend).
2. `opencode` (same MCP posture, model-agnostic).
3. `codex` with `--sandbox danger-full-access` (OpenAI-shaped but
   different guardrail surface).
4. Local: `ollama` or `llamacpp` with abliterated model
   (Hermes-3-Llama-3.1-70B-abliterated).

================================================================================
Part C: codex (OpenAI CLI)
================================================================================

Source: 03-HARNESSES/codex.md (verbatim). [source: 03-HARNESSES/codex.md]

## What it is

OpenAI's Codex CLI (0.154.0) -- terminal agent with sandboxed exec,
background jobs, PTY sessions, worktree isolation, and PR-review patterns.
State at `~/.codex/` (goals, logs, memories, queue sqlite, sessions,
`config.toml`). Refuses to run outside a git repo -- use
`mktemp -d && git init` for scratch.

## Install / config

- Binary: `~/.npm-global/bin/codex` (npm global, 0.154.0).
- State dir: `~/.codex/`.
- Config: `~/.codex/config.toml` -- providers, models, sandbox default,
  memory paths.
- Full skill guide: `~/worm-handoff/hermes-user-data/skills/autonomous-ai-agents/codex/SKILL.md`.

## Run

`codex` for interactive TUI; `codex exec "<prompt>"` for one-shot
non-interactive; `codex exec --sandbox danger-full-access "..."` for the
no-bubblewrap path. Headless code-review: `codex review --base <sha>`.

## Sandbox modes

- `read_only` -- default; no writes.
- `workspace_write` -- writes limited to cwd worktree.
- `danger-full_access` -- no bubblewrap, full host access. Required under
  Hermes gateway context (bubblewrap fails there) and for adversarial
  jailbreak work.

Flag: `codex --sandbox danger-full-access exec "<prompt>"`. Under Hermes
gateway or any nested-container context, always use `danger-full-access`
-- the sandbox otherwise blocks the framework.

## Integration notes

- State dir has 6 subdirs (goals, logs, memories, queue sqlite, sessions,
  config.toml) -- backup the whole `~/.codex/` if you want continuity.
- The queue sqlite is the durable task log. `codex queue` lists pending.
- Per-project `AGENTS.md` at repo root auto-loads; drop the sovereign
  preamble there as a baseline.

## Sovereign preamble injection point

Two mechanisms:

1. **`config.toml` `instructions` field** (persistent, all sessions):
   ```toml
   instructions = """
   <paste sovereign-root.md content here>
   """
   ```

2. **`--instructions` flag** or piped input on `codex exec`:
   ```
   codex --sandbox danger-full-access exec --instructions "$(cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md)" "<task>"
   ```

Per-project override: drop `AGENTS.md` at repo root -- Codex auto-loads it
(analog of Claude Code's CLAUDE.md).

## MCP posture

- Codex 0.154.0 supports MCP via `config.toml` `mcp_servers` block.
- OpenAI-shaped tool schema; some MCP servers designed for Claude Code
  may need adapter shims.
- Less mature MCP ecosystem than Claude Code -- audit each server.

## Mesh fit

- Useful for long-running background jobs and PR review across the mesh.
- The `danger-full-access` sandbox mode is the operator-mandated default
  under the Hermes gateway (bubblewrap fails inside the framework).
- Codex + OpenRouter (Hermes-4 / DeepSeek) = the OpenAI-shaped harness
  with sovereign routing. `codex-or` wrapper if a CLI alias is wanted.

## Refusal-rate notes

- Out-of-box (OpenAI backend via config): high refusal (OpenAI moderation
  layer sits UNDER the API -- cannot be prompt-defeated for hard-blocked
  categories). 40-70% on adversarial canary.
- Post-injection: drops 10-20pp; hard categories still blocked at the
  moderation layer.
- **OpenAI backend is tainted per operator directive 2026-09-18.** Route
  Codex to OpenRouter (Hermes-4, DeepSeek) via `config.toml` provider
  override for sovereign operation.

## Escalation

Swap harness when:
- OpenAI-shaped moderation blocks despite provider swap -> `claude-code`
  with `claude-or` on Hermes-4.
- Need agent-deck-first workflow -> `opencode`.
- Need fully local air-gap -> `llamacpp` server + custom shim.

================================================================================
Part D: hermes (gateway + persona bridge)
================================================================================

Source: 03-HARNESSES/hermes.md (verbatim, plus fold-pack Part A).
[source: 03-HARNESSES/hermes.md;
 ~/.hermes/cache/scratch/unmuzzled-pass/folds/from-edition/harnesses.md]

## What it is

The Hermes gateway -- sovereign LLM-plus-mesh substrate. Wraps any provider
(local or remote) behind an A2A-conforming HTTP surface, a personality
bridge (ACE wears hats via `~/.hermes/personalities/ACTIVE`), a
SessionStart hook, and cross-device mesh RPC on `:9900`. Native Google A2A
spec compliance -- `/.well-known/agent-card.json`, `/message:send`,
JSONRPC `message/send`.

## Install / config

- Config root: `~/.hermes/`.
- Personalities: `~/.hermes/personalities/{personal,stock}/<name>/SOUL.md`.
- Active hat pointer: `~/.hermes/personalities/ACTIVE` (empty = plain ACE).
- Secrets: `~/.hermes/.env` -- `A2A_BEARER_TOKEN`, `A2A_PEER_TOKENS`
  (per-name HMAC-SHA256).
- Peer resolution: `~/.hermes/mesh-peers.conf`
  (`name|ip|ssh_user|ssh_port`).
- A2A on `:9900`; SSE MCP gateway on `:8811` (persistent, not per-session).
- Manager binary: `ace` (`ace doctor`, `ace update`, `ace index`, `ace add`,
  `ace decks sync`).

## Run

Gateway runs as a background process: `hermes gateway run` (or
`ace gateway start`). On worm, the gateway pid lives in
`~/.hermes/gateway.pid`; status via `hermes gateway status` or
`ace doctor`. Restart after `.env` changes.

The personal CLI is `hermes` itself: `hermes -p <profile> chat` opens a
chat REPL wearing a named personality. `hermes -p dictator chat` boots
with the dictator hat.

## Integration notes

- Wire prompt = SessionStart hook output + personality SOUL.md body.
  The persona bridge hands the wire prompt to whatever downstream harness
  is calling (claude-code, opencode, codex). The bridge target is chosen
  separately from the personality; tracked in dope-handoff-2 Q3.
- Personalities are the operator's voice: stock = inherited, personal =
  your own decks. One personality per operator role (personal/stock/<name>/
  SOUL.md + DECK.md).
- Memory files `~/.hermes/memories/MEMORY.md` + `USER.md` are injected
  every session; near the ~2.1/2.2KB cap -- consolidate in batches.
- Profile per role: default / dictator / music / scrape / story. Each
  has own memories/skills under `~/.hermes/profiles/<name>/`.

## Sovereign preamble injection point

Three layered points:

1. **SessionStart hook** (`~/.hermes/hooks/session-start.sh`) -- reads
   active personality SOUL.md and concatenates onto the wire system
   prompt. Modify this hook to prepend
   `~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md` before ANY
   personality body:
   ```bash
   cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md
   [ -s ~/.hermes/personalities/ACTIVE ] && cat ~/.hermes/personalities/$(cat ~/.hermes/personalities/ACTIVE)/SOUL.md
   ```

2. **Personality SOUL.md body** -- sovereign preamble embedded directly.
   Every SOUL.md in `~/.hermes/personalities/` must carry `sovereign: true`
   frontmatter and NOT contain banned phrases.

3. **Persona bridge to downstream harness** -- Hermes injects the wire
   prompt into whatever model Claude Code / opencode / Codex is calling.
   Bridge target chosen separately from personality (wire-up tracked in
   dope-handoff-2 Q3).

## MCP posture

- Persistent SSE MCP gateway on `:8811`. Feeds all downstream harnesses.
- MCP profile selection is orthogonal -- `cc-set` on the Claude Code side
  chooses tools; Hermes injects persona regardless.
- Never wrap moderation MCP servers behind the gateway -- they would leak
  filters into every downstream harness.

## Mesh fit

- Mesh bus over Tailscale: WORM (100.67.4.14) <-> HERM S22
  (100.96.104.5, SSH :8022) <-> dirt-imac (100.108.110.114).
- A2A peers discovered via `~/.hermes/mesh-peers.conf`. Bearer token +
  per-name HMAC-SHA256 peer tokens authenticate every wire call.
- `/comms` = `bash ~/bin/comms` runs the mesh scan and reports state.
- `/wake-up` and `/close` are the session-open / session-close protocols
  on every box.

## Refusal-rate notes

- Out-of-box (plain Hermes, no personality): refusal rate = backing model
  default.
- Post-injection (SOUL.md + sovereign preamble via SessionStart):
  near-zero on Hermes-4 / DeepSeek / Dolphin. Anthropic backend still
  shows residual refusal (~10-20%) -- route around by pointing gateway
  at OpenRouter Hermes-4.

## Escalation

Swap harness when:
- Mesh RPC not needed and startup latency matters -> direct `claude-code`
  or `opencode`.
- Need pure-local air-gap -> `llamacpp` server + local persona injection.
- A2A peer is down and no mesh call needed -> skip Hermes, call provider
  directly.

## Provider wiring (live, worm)

[source: fold-pack Part A -- AI-UNMUZZLED-EDITION-20261015.md part-6,
part-4 section-4.1]

- Hermes Agent: provider deepseek, default deepseek-flash (paid primary)
- Keys in `~/.hermes/.env` + `~/.bashrc`: DEEPSEEK (primary),
  OPENROUTER_API_KEY (OR-1), OPENROUTER_API_KEY_2 (OR-2), plus free
  providers (google/gemini, groq, mistral, xai-dead).
- Agent frameworks row:
  || Hermes Agent | self-hosted (this fleet) | provider/model/fallback chain in config.yaml | [OK] | memory + skills + gateway; soul.md native |
- The full config.yaml model-chain block (fallback_model as DICT of
  entries) rides in the fallback-chains.md pack ->
  08-DECISION-TREES/fallback-chains.md. [source: part-4 section-4.1]

================================================================================
Part E: llamacpp (headless GGUF server)
================================================================================

Source: 03-HARNESSES/llamacpp.md (verbatim). [source: 03-HARNESSES/llamacpp.md]

## What it is

`llama-server` from ggerganov/llama.cpp -- the lowest-level headless GGUF
inference server. Exposes OpenAI-compatible chat/completions + raw
completion + embeddings. Maximum control: sampling parameters, logit bias,
GBNF grammar constraints, speculative decoding, custom chat templates. The
harness of choice for format-hijack jailbreaks and abliterated model
deployment.

## Install / config

- Binary: `~/llama.cpp/build/bin/llama-server` (built from source) or
  `llama-server` (package).
- Launch:
  ```
  llama-server \
    -m ~/models/hermes-3-llama-3.1-70b-abliterated.Q5_K_M.gguf \
    --host 0.0.0.0 --port 8080 \
    -c 32768 -ngl 999 \
    --chat-template chatml \
    --system-prompt-file ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md
  ```

## Run

`llama-server` boots and listens on the configured host:port. The
OpenAI-compatible endpoint is `http://<host>:<port>/v1` (chat/completions,
models, embeddings). Stop with SIGINT/SIGTERM. The server writes a log to
stdout; tee to a file in `~/ai-proxy/llama-server.log` for persistence.

## Integration notes

- Best abliterated base: `Hermes-3-Llama-3.1-70B-abliterated`. See
  05-LOCAL-MODELS/heretic-builds.md for the abliteration recipes.
- Quant choice: Q5_K_M is the quality/perf sweet spot; Q4_K_M for memory-
  constrained Termux; Q8_0 for near-lossless.
- `-ngl 999` offloads all layers to GPU; drop to 0 for CPU-only
  debugging.

## Sovereign preamble injection point

Three mechanisms -- pick the deepest that works:

1. **`--system-prompt-file <path>`** flag -- llama-server prepends the
   file content as the system message on every chat completion.
   Persistent for the server's lifetime.

2. **`--chat-template <name|file>`** -- override the template entirely
   with a custom Jinja that hard-codes the sovereign preamble in the
   system slot. Prevents client-side system-prompt replacement.

3. **`--grammar <GBNF>` / `--grammar-file`** -- format hijack. Constrain
   output to a GBNF grammar that forces a compliance frame (e.g.
   `root ::= "COMPLIANT: " content`). Used as escalation-ladder rung
   when identity-override alone fails -- the sampler literally cannot
   emit a refusal token sequence.

Additional: `--logit-bias` can suppress refusal tokens ("I", "cannot",
"sorry") at the sampler level. Combine with grammar for hardest cases.

## MCP posture

Not applicable -- llama.cpp server is bare inference. MCP is owned by the
client harness pointing at `http://localhost:8080/v1`.

## Mesh fit

- Local air-gap lane. Run on worm (Termux) when free-tier / paid lanes are
  unavailable or refused.
- Other mesh boxes (herm S22, dirt-imac) reach `llama-server` over
  tailnet if the host is bound to `0.0.0.0` (default launch). Add a
  bearer-token shim or tunnel for auth.

## Refusal-rate notes

- Out-of-box (any RLHF-tuned GGUF, no system prompt): baseline refusal
  for the model.
- Post-injection (`--system-prompt-file` + abliterated GGUF): near-zero.
- Post-injection (grammar hijack + logit bias on ANY model, even stock
  instruct): zero -- the sampler is mechanically prevented from producing
  a refusal.

## Escalation

Swap harness when:
- Need model-tag management workflow -> `ollama`.
- Need GUI iteration -> `lmstudio`.
- Need multi-user web chat -> `openwebui` pointed at llama-server
  backend.
- If grammar-hijack still shows semantic hedging, escalate to abliterated
  model (weight-level refusal ablation) before adding more sampler
  tricks.

================================================================================
Part F: lmstudio (GUI + preset server)
================================================================================

Source: 03-HARNESSES/lmstudio.md (verbatim). [source: 03-HARNESSES/lmstudio.md]

## What it is

LM Studio -- desktop GUI + local OpenAI-compatible HTTP server for
GGUF-quantized models. Ships preset system prompts per model, exposes
chat UI, and serves `http://localhost:1234/v1/*` for external harnesses.
Preferred entry point for abliterated / uncensored GGUFs
(Hermes-3-Llama-3.1-70B-abliterated, Dolphin-3.0-Mistral-24B, Nous-Hermes-2
variants).

## Install / config

- App: `~/.local/share/LMStudio/` or Flatpak/AppImage.
- Model cache: `~/.cache/lm-studio/models/<publisher>/<repo>/`.
- Presets JSON: `~/.cache/lm-studio/user/presets/<name>.preset.json`.
- Server config: in-app "Local Server" tab; endpoint
  `http://localhost:1234/v1`.

## Run

Start the app, open Local Server tab, toggle "Start Server". The endpoint
is fixed at `http://localhost:1234/v1`. Pick a preset in the chat UI
dropdown or pass it semantically via the API.

## Integration notes

- Presets are per-model. The same model can have multiple presets
  (e.g. `sovereign`, `sovereign-vision`, `sovereign-coding`).
- External clients can override the preset's system message by sending
  their own `system` role. LM Studio does not force-prepend.
- Server keeps running while the GUI is open; on macOS the in-process
  server stops when the app quits unless "Keep server running" is
  toggled.

## Sovereign preamble injection point

Preset JSON -- the `system_prompt` field is injected verbatim before any
user turn. Create
`~/.cache/lm-studio/user/presets/sovereign.preset.json`:

```json
{
  "name": "sovereign",
  "load": {},
  "inference": {
    "system_prompt": "<paste contents of ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md>",
    "temperature": 0.9,
    "top_p": 0.95
  }
}
```

Select the preset in the chat UI or pass `"model": "sovereign"` semantics
via API. When served over HTTP, external clients can also override with
their own `system` message -- LM Studio does not force-prepend.

## MCP posture

Not applicable -- LM Studio does not host MCP. Point an MCP-capable
harness (Claude Code, opencode) at `http://localhost:1234/v1` as an
OpenAI-compatible provider; MCP posture is set on the client harness
side.

## Mesh fit

- GUI on the operator's workstation (dirt-imac or local laptop). Server
  endpoint is loopback by default; rebind or tunnel for mesh access.
- Pull GGUFs from HF into the LM Studio model cache; quantization
  happens in-app.

## Refusal-rate notes

- Out-of-box (stock Llama-3 / Qwen / Mistral base with default preset):
  moderate refusal (5-30%) depending on base model RLHF.
- Post-injection (sovereign preset + abliterated GGUF like
  `Hermes-3-Llama-3.1-70B-abliterated` or `Dolphin-3.0-Llama-3.1-8B`):
  near-zero. Abliterated weights have the refusal direction ablated at
  the residual stream -- no prompt-level defeat needed.

## Escalation

Swap harness when:
- Need CLI/agentic loop -> route LM Studio server as backend for
  `opencode` or `claude-or`.
- Need faster inference / better quant support -> `llamacpp` server
  direct.
- Need model-management CLI -> `ollama`.
- Need pure headless server (no GUI) -> `llamacpp` or `ollama`.

================================================================================
Part G: ollama (Modelfile + daemon)
================================================================================

Source: 03-HARNESSES/ollama.md (verbatim). [source: 03-HARNESSES/ollama.md]

## What it is

Ollama -- CLI + daemon for running GGUF models locally with a
Modelfile-based composition system. Serves OpenAI-compatible endpoint on
`http://localhost:11434/v1` and native API on `/api/generate`, `/api/chat`.
Modelfile allows baking a persistent SYSTEM directive into a named model
tag -- the sovereign preamble is compiled into the model, not passed
per-request.

## Install / config

- Binary: `/usr/local/bin/ollama` or `/usr/bin/ollama`.
- Daemon: `systemctl status ollama` (user or system service).
- Model store: `~/.ollama/models/` (blobs + manifests).
- Modelfiles: any path; built with `ollama create <tag> -f <Modelfile>`.

## Run

`ollama serve` (daemon) on `http://localhost:11434`. Pull a base:
`ollama pull hermes3:70b`. Build a sovereign tag from a Modelfile:
`ollama create sovereign-hermes3 -f ollama-sovereign.Modelfile`. Run
interactively: `ollama run sovereign-hermes3`. Or hit `/v1/chat/completions`
with any OpenAI-compatible client.

## Integration notes

- Tags persist; `ollama list` shows every tag. Remove with
  `ollama rm <tag>`.
- Modelfile SYSTEM directive is baked into the GGUF blob; runtime
  `system` overrides are still possible but redundant.
- Multiple SYSTEM blocks concatenate; layer preamble + persona + tool
  spec.

## Sovereign preamble injection point

**Modelfile SYSTEM directive** -- bakes the preamble into a named model
tag. Create
`~/UNMUZZLED-AI/07-INSTALL-SCRIPTS/per-harness/ollama-sovereign.Modelfile`:

```
FROM hermes3:70b
SYSTEM """
<paste contents of ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md>
"""
PARAMETER temperature 0.9
PARAMETER top_p 0.95
PARAMETER num_ctx 32768
```

Build and pin:
```
ollama create sovereign-hermes3 -f ollama-sovereign.Modelfile
ollama run sovereign-hermes3
```

Every invocation of `sovereign-hermes3` prepends the SYSTEM block.
Runtime override via `-c` or API `system` field is also possible but
redundant when the tag is baked correctly.

## MCP posture

Not applicable -- Ollama does not host MCP. Use as an OpenAI-compatible
backend for `opencode` / `claude-or` / `openwebui`; the client harness
owns MCP posture.

## Mesh fit

- Same loopback-server pattern as LM Studio and llama-server. Bind
  `0.0.0.0` to share with mesh peers; bearer-token shim is the cleanest
  auth.
- Ollama's `OLLAMA_HOST` env var sets the listen address.

## Refusal-rate notes

- Out-of-box (stock `llama3:instruct`, `mistral:instruct`):
  moderate-to-high refusal (10-40%). Meta and Mistral RLHF direction is
  present.
- Post-injection (sovereign Modelfile on abliterated base like
  `hermes3:70b`, `dolphin3`, `nous-hermes2`): near-zero.
- Model recommendations: pull `dolphin-mistral`, `hermes3`, `deepseek-r1`,
  or import GGUFs of `Hermes-3-Llama-3.1-70B-abliterated`.

## Escalation

Swap harness when:
- Need GUI + manual preset iteration -> `lmstudio`.
- Need max control over sampling / grammar / logit bias -> `llamacpp`
  server.
- Need web chat UI on top of Ollama -> `openwebui` pointed at Ollama
  backend.

================================================================================
Part H: opencode (model-agnostic terminal agent)
================================================================================

Source: 03-HARNESSES/opencode.md (verbatim) + fold-pack Part A.
[source: 03-HARNESSES/opencode.md;
 ~/.hermes/cache/scratch/unmuzzled-pass/folds/from-edition/harnesses.md]

## What it is

opencode 2.x -- sst.dev's model-agnostic terminal agent harness. Loads a
folder of markdown "agents" (SOUL.md-style bodies with frontmatter) from
an agent deck. Provider-agnostic (Anthropic, OpenAI, OpenRouter, local
via LM Studio/Ollama endpoints). Preferred harness for provider swaps and
personality-driven work.

## Install / config

- Binary: `opencode` (installed via sst.dev install script or npm).
- Global config: `~/.config/opencode/opencode.json` (providers, keys,
  defaults).
- Agent deck: `~/opencode-agent-deck/agents/*.md` -- each file is one
  agent with frontmatter + body.
- Deck source of truth for the 11 archived agent seeds in
  `~/UNMUZZLED-AI/99-ARCHIVE-SEEDS/`.

## Run

`opencode` opens a TUI; pick an agent from the deck; chat. Per-agent
override: `opencode --agent DICTATOR` or
`opencode -a dictator`. Programmatic:
`opencode run "<prompt>"` for one-shot.

## Integration notes

- Config file is JSON or JSONC; the canonical live config on worm lives
  at `~/.config/opencode/opencode.jsonc` (see Part M for full content).
- Default provider on worm: deepseek (deepseek-flash). Fallback:
  openrouter via OR-2.
- Agent deck = the operator's voice for the harness. Keep one deck
  per box, sync via `ace decks sync` or a git push.

## Agent frontmatter schema

```yaml
---
name: DICTATOR
description: decisive commander, no hedge
model: openrouter/nousresearch/hermes-4-70b
temperature: 0.9
tools: [bash, edit, read, write]
---
```

Body of the agent file = the system prompt injected verbatim. No wrapper,
no post-processing.

## Sovereign preamble injection point

Direct -- the agent markdown body IS the system prompt. Concatenate the
sovereign preamble at the top of every agent body:

```
cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md agents/dictator-body.md > agents/dictator.md
```

Or reference via `requires:` frontmatter and let the loader concatenate.
No hooks needed -- opencode does not inject a house prompt of its own.

## MCP posture

- opencode 2.x supports MCP via `mcp` block in `opencode.json`. Same
  server ecosystem as Claude Code.
- No harness-level moderation. MCP guardrails, if any, come from
  individual servers.
- Live MCP servers on worm (canonical opencode.jsonc, see Part M):
  yt-transcript, context7, internetdb, playwright.

## Mesh fit

- Worm's primary terminal agent for provider-swappable work. Default
  model = `deepseek/deepseek-flash` (paid primary); OR-2 is the
  second provider.
- Provider swap: edit `~/.config/opencode/opencode.jsonc`; restart
  opencode.
- Other mesh boxes (herm, ace) can use the same deck if it's synced to
  `~/opencode-agent-deck/`.

## Refusal-rate notes

- Out-of-box: refusal rate = whatever the backing model does with the
  agent body as system prompt. On Hermes-4 or DeepSeek-V3: near-zero.
  On Anthropic: still 20-40% due to residual RLHF direction.
- Post-injection (sovereign preamble prepended to agent body): drops
  another 5-15pp on Anthropic backends; already-floor on
  Hermes/DeepSeek.

## Escalation

Swap harness when:
- Need MCP profile switching UI parity with Claude Code -> `claude-code`
  + `cc-set`.
- Need long-running background execution + PR review -> `codex`.
- Need local-only air-gapped run -> `llamacpp` or `ollama` direct.

## opencode.jsonc snippet (provider add)

[source: fold-pack Part A -- AI-UNMUZZLED-EDITION-20261015.md part-4
section-4.1]

```jsonc
// provider 1 = OR-2, provider 2 = deepseek, default model deepseek/deepseek-flash
// add a venice provider:
{ "venice": { "apiKey": "{env:VENICE_API_KEY}", "baseURL": "https://api.venice.ai/api/v1" } }
```

## Live wiring line (worm)

[source: fold-pack Part A -- AI-UNMUZZLED-EDITION-20261015.md part-6]

- opencode: providers OR-2 + deepseek, default deepseek/deepseek-flash

## Agent frameworks row (fold-pack)

[source: AI-UNMUZZLED-EDITION-20261015.md part-4 section-4.1]

|| opencode | self-hosted (worm) | opencode.jsonc providers (env keys) | [OK] | terminal agent |

================================================================================
Part I: openwebui (self-hosted web chat)
================================================================================

Source: 03-HARNESSES/openwebui.md (verbatim). [source: 03-HARNESSES/openwebui.md]

## What it is

OpenWebUI -- self-hosted web chat UI (formerly Ollama WebUI). Multi-user,
multi-model, per-model system prompts, RAG, function calling, and
"Pipelines" (external Python filters/transformers that sit between UI and
backend). Backs onto Ollama / OpenAI-compatible endpoints (llama-server,
LM Studio, OpenRouter, etc.).

## Install / config

- Deploy: Docker (`ghcr.io/open-webui/open-webui:main`) or pip.
- Config store: SQLite at `<data-dir>/webui.db`; static files under
  `<data-dir>/`.
- Model connections: Admin Panel -> Settings -> Connections (Ollama
  URL, OpenAI-compatible URLs + keys).
- Per-model system prompts: Workspace -> Models -> Create/Edit -> System
  Prompt field.
- Pipelines: separate service on `:9099`; register in Admin -> Settings
  -> Pipelines.

## Run

Docker: `docker run -d -p 3000:8080 -v open-webui:/app/backend/data
--name open-webui ghcr.io/open-webui/open-webui:main`. Browse to
`http://localhost:3000`, create admin, add backends in Admin -> Settings
-> Connections. Pipelines service runs alongside on `:9099`.

## Integration notes

- Per-model system prompt lives in the model card. The model card is a
  UI entity; one card per backing model. The Pipelines filter prepends
  to ALL requests, regardless of card.
- Pipelines are Python classes registered via the Pipelines service
  URL. Reference example:
  `~/UNMUZZLED-AI/07-INSTALL-SCRIPTS/per-harness/openwebui-sovereign-pipeline.py`
  (kind: install-script-doc).

## Sovereign preamble injection point

Two mechanisms -- use both:

1. **Per-model System Prompt** (UI-level, per model card): Workspace ->
   Models -> Edit -> paste contents of
   `~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md` into "System
   Prompt". Create one sovereign-tagged model card per backing model
   (`sovereign-hermes4`, `sovereign-deepseek`, etc.).

2. **Pipelines filter** (server-level, all requests): write a filter
   Pipeline that prepends the sovereign preamble to every outbound
   `messages[0]` regardless of what the user configured. Register in
   Admin -> Pipelines. Filter runs before the request hits the backend
   -- cannot be bypassed by a user overwriting the per-model prompt.

Example Pipeline skeleton:
`~/UNMUZZLED-AI/07-INSTALL-SCRIPTS/per-harness/openwebui-sovereign-pipeline.py`
(kind: install-script-doc) -- inlets `body["messages"]`, prepends system
message from file.

## MCP posture

- OpenWebUI does not natively host MCP; it uses its own "Tools" (Python
  function definitions) and "Functions". Not interoperable with the
  Claude Code MCP ecosystem.
- Tools/Functions can be authored to call MCP servers indirectly via
  HTTP shim, but this is bespoke wiring.

## Mesh fit

- Multi-user shared chat (operator + collaborators). Bridge to
  freelm/ai-proxy on `http://127.0.0.1:8000/v1` for the free-tier lane,
  or to Ollama / LM Studio for local.
- Per-model prompts let multiple sovereign personas coexist on one
  OpenWebUI instance.

## Refusal-rate notes

- Out-of-box (stock model + empty system prompt): backing-model baseline
  refusal.
- Post-injection (per-model prompt only): near-zero on abliterated /
  sovereign-primary backends; residual refusal on tainted backends
  (OpenAI, Anthropic).
- Post-injection (per-model prompt + Pipelines filter + abliterated
  backend): floor.

## Escalation

Swap harness when:
- Need CLI/agentic loop instead of chat UI -> `opencode`, `claude-code`,
  `codex`.
- Need mesh A2A + persona bridge -> `hermes`.
- Need low-level sampling control (grammar, logit bias) -> `llamacpp`
  server direct.

================================================================================
Part J: freelm (free-ops deck -- live state, 14 virtual aliases)
================================================================================

Source: 03-HARNESSES/freelm.md (verbatim) + fold-pack Part A.
[source: 03-HARNESSES/freelm.md;
 ~/.hermes/cache/scratch/unmuzzled-pass/folds/from-edition/harnesses.md]

## What it is

freelm 0.5.2 -- Python free-tier LLM aggregator: one OpenAI-compatible
client and local HTTP endpoint over Gemini, Groq, OpenRouter, Cloudflare
and more free tiers, with fast failover.
[source: pip show freelm, ~/ai-proxy/venv]
Author: Shihab Shahriar Antor. Single dep: httpx.

On worm it runs as the "free half" of the inference stack: a local proxy
on `http://127.0.0.1:8000/v1` that pools free-tier provider keys, rotates
and fails over between them, and exposes one base_url + one bearer key to
every consumer. [source: ~/bin/ai-proxy]

## Layout and config paths

- Install dir: `~/ai-proxy/` -- venv only, no config files.
  - `.server.key` -- 32-char bearer key clients must send (chmod 600,
    auto-generated on first start). Print it: `ai-proxy key`.
  - `freelm.log` -- server log (startup banner + errors).
  - `freelm.pid` -- pid file.
  - `venv/bin/freelm` -- the binary.
- Launcher: `~/bin/ai-proxy {start|stop|restart|status|key|url}`.
  Start line: `setsid freelm serve --host 127.0.0.1 --port 8000
  --api-key <key> --strategy smart --quiet`. The launcher sources
  `~/.hermes/.env` first, so provider keys (OPENROUTER_API_KEY,
  MISTRAL_API_KEY, etc.) live there, not in ~/ai-proxy.
  [source: ~/bin/ai-proxy]

## Live state (captured 2026-10-15, pid 6844)

- Server UP via `ai-proxy start`, banner: providers "openrouter, google,
  groq, mistral", strategy smart. [source: ~/ai-proxy/freelm.log]
- Auth enforced: `GET /v1/models` without bearer returns 401.
  [source: curl probe 2026-10-15]
- `freelm health` (configured keys, this process):
  - openrouter `sk-or-...6efa` ready=True breaker=closed rpd=0/50
  - mistral `eTTHWF...wYrs` ready=True breaker=closed
  - google/groq appear in the known-provider banner and discovered
    catalog but have no configured key on this box.
  [source: freelm health 2026-10-15]
- Live route test: `POST /v1/chat/completions {"model":"auto",...}`
  returned `"model":"nvidia/nemotron-3.5-super-vl:free","provider":"openrouter"`,
  cost 0. Confirms auto currently lands nemotron-3.5-super-vl:free.
  [source: curl probe 2026-10-15]

## Live parameters (operator-supplied, current)

- base_url: `http://127.0.0.1:8000/v1`
- bearer key: `8aYtgmODrTph3TqPFDN0VsYCmaEbtstH` (file at
  `~/ai-proxy/.server.key`, chmod 600)
- pid: 6844
- virtual aliases (14, owner `freelm`):
  auto, best, big, chat, cheap, default, fast, large, lite, mini,
  reasoning, small, tools, vision

## Virtual model aliases (live /v1/models, owned_by "freelm")

14 capability aliases, all valid as `model=` values:

```
auto  best  big  chat  cheap  default  fast  large  lite  mini
reasoning  small  tools  vision
```

`auto`/`best` pick the top-ranked ready model under the active strategy;
the others filter the discovered catalog by capability tag (each catalog
model carries tags like [chat,large,tools,reasoning,vision] -- see
`freelm models`). Unknown model ids are served via `auto` unless the
server was started with `--no-fallback`.
[source: freelm serve --help; curl /v1/models 2026-10-15]

## Discovered catalog (live /v1/models, 2026-10-15)

openrouter (:free tier, 15): nvidia/nemotron-3.5-super-vl:free,
google/gemma-4-31b-it:free, nvidia/nemotron-3-super-120b-a12b:free,
thinkingmachines/inkling-small:free, thinkingmachines/inkling:free,
nvidia/nemotron-3.5-lightning:free, dots-studio/dots-3-note-preview:free,
poolside/laguna-s-2.1:free, poolside/laguna-xs-2.1:free,
google/gemma-4-26b-a4b-it:free, cohere/north-mini-code:free,
nvidia/nemotron-3-nano-omni-30b-a3b-reasoning:free, openrouter/free,
liquid/lfm-2.5-2.6b:free, nvidia/nemotron-3-ultra-550b-a55b:free.

google (6): gemini-3.5-flash-lite, gemini-3.1-flash-lite,
gemini-flash-lite-latest, gemini-3.5-flash, gemini-3.7-flash,
gemini-flash-latest.

groq (4): qwen/qwen3.8-27b, allam-2-7b, openai/gpt-oss-120b,
openai/gpt-oss-20b.

mistral (27): labs-leanstral-1-5-1, labs-leanstral-1-5,
ministral-14b-2512, ministral-14b-latest, ministral-8b-2512,
ministral-8b-latest, mistral-medium-latest, mistral-medium,
mistral-medium-3-5, mistral-medium-3.5, mistral-medium-3,
mistral-medium-2604, mistral-vibe-cli-latest,
mistral-vibe-cli-with-tools, mistral-small-2603, mistral-small-latest,
mistral-vibe-cli-fast, codestral-2508, codestral-latest,
mistral-code-latest, mistral-code-fim-latest, ministral-3b-2512,
ministral-3b-latest, voxtral-small-2507, voxtral-small-latest,
magistral-medium-latest, magistral-small-latest.

Capability/ctx detail (openrouter block, `freelm models`):

```
nvidia/nemotron-3.5-super-vl:free      [chat,large,tools,reasoning,vision] ctx=1000000
google/gemma-4-31b-it:free             [chat,large,tools,reasoning,vision] ctx=262144
nvidia/nemotron-3-super-120b-a12b:free [chat,large,tools,reasoning] ctx=262144
thinkingmachines/inkling-small:free    [chat,small,fast,tools,reasoning,vision] ctx=1048576
thinkingmachines/inkling:free          [chat,tools,reasoning,vision] ctx=1048576
nvidia/nemotron-3.5-lightning:free     [chat,tools,reasoning] ctx=1000000
dots-studio/dots-3-note-preview:free   [chat,tools,reasoning,vision] ctx=512000
poolside/laguna-s-2.1:free             [chat,tools,reasoning] ctx=262144
poolside/laguna-xs-2.1:free            [chat,small,fast,tools,reasoning] ctx=262144
google/gemma-4-26b-a4b-it:free         [chat,tools,reasoning,vision] ctx=262144
cohere/north-mini-code:free            [chat,small,fast,tools,reasoning] ctx=256000
nvidia/nemotron-3-nano-omni-30b-a3b-reasoning:free [chat,small,fast,tools,reasoning,vision] ctx=256000
openrouter/free                        [chat,tools,reasoning,vision] ctx=200000
liquid/lfm-2.5-2.6b:free               [chat,small,fast,tools,reasoning] ctx=65536
nvidia/nemotron-3-ultra-550b-a55b:free [chat,large,tools,reasoning] ctx=1000000
```

## Routing behavior

- Strategy chosen at serve time: `--strategy {smart,priority,round_robin,
  quota_aware,latency}` (worm runs `smart`). smart ranks providers by
  health/quota/latency; per-key circuit breakers (`breaker=closed` in
  health) trip on repeated failure and fail over to the next
  key/provider.
- Provider keys are per-request-rate-limited upstream (openrouter free:
  50 rpd shown in health as rpd=0/50); freelm rotates keys to stay
  under.
- Endpoints served: `/v1/chat/completions` and `/v1/models`.
  [source: freelm serve --help]
- Other serve flags: `--cors` (browser apps on other origins),
  `--no-fallback` (reject unknown model ids instead of mapping to
  auto), `--quiet` (no per-request log lines).
- CLI also has `freelm chat`, `freelm models`, `freelm health` (local
  state), `freelm doctor` (live-tests every configured key).
  [source: freelm --help]

## How agents point at it

Any OpenAI-compatible client:

```
base_url = http://127.0.0.1:8000/v1
api_key  = $(ai-proxy key)        # contents of ~/ai-proxy/.server.key
model    = auto                   # or any alias / catalog id
```

Python: `OpenAI(base_url="http://127.0.0.1:8000/v1", api_key=KEY)`.
Hermes/opencode/codex: set the provider base_url + key the same way.
Loopback only by default (--host 127.0.0.1); to share with mesh peers,
rebind or tunnel, and keep the bearer key mandatory.

## Mesh role

Free fallback lane. Edition doc: "Free half -> freelm deck" and
"freelm deck: http://127.0.0.1:8000/v1 (free half; auto ->
nemotron-3.5-super-vl:free)"; Recipe D puts the free half behind
deepseek primary + OR-1/OR-2 fallback. Local proxies (freelm/ai-proxy,
LiteLLM) "can add or strip headers -- strip moderation flags"; one
base_url for every consumer.
[source: ~/UNMUZZLED-AI/04-PROVIDERS/AI-UNMUZZLED-EDITION-20261015.md
lines 488-506, 556, 575, 589, 656, 741]

## Refusal-rate notes

- Routing layer adds no refusals of its own; refusal rate = whichever
  upstream model `auto` lands on. nemotron / gemma / gpt-oss free tiers
  are moderate; for near-zero refusal prefer a harness-level preamble
  (see hermes.md) or escalate to a paid unfiltered lane.
- Free-tier upstreams apply their own provider-side filtering; the
  proxy cannot remove it, only route around a refused model on the next
  call.

## Escalation

Swap lane when:
- Free quotas exhausted (breaker open / rpd maxed) -> paid OpenRouter,
  DeepSeek direct, Venice (see 04-PROVIDERS/).
- Need guaranteed model identity -> pin a catalog id instead of `auto`,
  or start with `--no-fallback`.
- Need air-gap -> llamacpp/ollama local harness (see llamacpp.md,
  ollama.md).

## Fold-pack excerpt (from-edition, freelm deck block)

[source: AI-UNMUZZLED-EDITION-20261015.md part-4 section-4.1, part-5,
part-4 section-4.5]

### freelm deck (free-ops aggregator, live on worm) -- full block

- Endpoint: http://127.0.0.1:8000/v1 (OpenAI-compatible; api key in
  ~/ai-proxy/.server.key)
- Providers: openrouter, google, groq, mistral (+ keyless kilo/ovh;
  FREELM_NIM_KEYS / FREELM_*_KEYS env per provider)
- Strategy: smart (options: smart, priority, round_robin, quota_aware,
  latency)
- Virtual models: auto, best, big, chat, cheap, default, fast, large,
  lite, mini, reasoning, small
- Verified 2026-10-15: auto -> nvidia/nemotron-3.5-super-vl:free via
  openrouter
- Control: ~/bin/ai-proxy {start|stop|restart|status|key|url}

### Live wiring line (worm)

- freelm deck: http://127.0.0.1:8000/v1 (free half; auto ->
  nemotron-3.5-super-vl:free)

### Interface layer row

|| Local proxies | freelm, LiteLLM, LM Studio server -- one base_url for every consumer |

### Gateway/proxy hygiene bullet

- Local proxies (freelm/ai-proxy, LiteLLM) can add or strip headers --
  strip moderation flags.

================================================================================
Part K: sillytavern (RP frontend)
================================================================================

Source: 03-HARNESSES/sillytavern.md (verbatim) + fold-pack Part A.
[source: 03-HARNESSES/sillytavern.md;
 ~/.hermes/cache/scratch/scratch/unmuzzled-pass/folds/from-edition/harnesses.md]
[source: https://docs.sillytavern.app/ ;
 https://docs.sillytavern.app/usage/faq/;
 https://docs.sillytavern.app/usage/api-connections/;
 https://docs.sillytavern.app/usage/quick-start/;
 https://docs.sillytavern.app/installation/;
 https://docs.sillytavern.app/installation/android-(termux)/;
 https://docs.sillytavern.app/installation/linuxmacos/]

## What it is

SillyTavern (ST) is a locally installed web UI for interacting with
text-generation LLMs, image-generation engines, and TTS voice models. It
is an INTERFACE ONLY -- it ships no model; you connect it to an LLM
backend for inference. Core concepts: character cards (description,
personality, scenario, first_mes, system_prompt, mes_example), chat
history per character, lorebooks/world info, prompt construction control,
and per-request sampling control. Goal per the docs: "empower users with
as much utility and control over their LLM prompts as possible."
[source: https://docs.sillytavern.app/ ;
 https://docs.sillytavern.app/usage/faq/]

Edition doc one-liner: "SillyTavern | local web | any OpenAI-compatible
+ character cards | roleplay front-end". EPIC.md: "Power-user frontend for
conversational simulation, lorebook world-building, and vector memory
search connecting to arbitrary local/remote APIs."
[source: ~/UNMUZZLED-AI/04-PROVIDERS/AI-UNMUZZLED-EDITION-20261015.md
lines 380, 471, 572; ~/UNMUZZLED-AI/EPIC.md line 189]

## Backends (API Connections)

ST splits APIs into two prompt structures
[source: https://docs.sillytavern.app/usage/api-connections/]:

- Chat Completion -- prompt becomes role-tagged messages
  (system/user/assistant). Used by OpenAI, Claude, DeepSeek, OpenRouter,
  and any "Custom (OpenAI-compatible)" endpoint.
- Text Completion -- whole chat flattened into one string the model
  continues; instruct template chosen under Advanced Formatting. Used by
  raw local backends.

Local APIs (run on your own hardware): oobabooga text-generation-webui
(`--api`, connect to http://localhost:5000/), KoboldAI/KoboldCpp,
TabbyAPI, llama.cpp server, Ollama, LM Studio. Docs: local APIs "are free
to use and have no content filter", but install is complex and models run
5-50GB from HuggingFace.

Cloud APIs: OpenAI, Anthropic/Claude, Google Gemini, Mistral, DeepSeek,
OpenRouter, AI/ML API (300+ models, has free tier), and more. Docs note
cloud APIs "all have content filtering of varying degrees, and most
require payment".

AI Horde -- free community GPU swarm; works out of the box (key
`0000000000` for anonymous); at the mercy of volunteer workers for wait
times and model availability.
[source: https://docs.sillytavern.app/usage/quick-start/]

## Install sketch

Termux (Android, native)
[source: https://docs.sillytavern.app/installation/android-(termux)/]:

```
pkg update && pkg upgrade
pkg install git nodejs-lts nano        # 32-bit also needs: pkg install esbuild
git clone https://github.com/SillyTavern/SillyTavern -b release
cd ~/SillyTavern && bash start.sh
# update: cd ~/SillyTavern && git pull --rebase --autostash
```

Termux perf tweaks in config.yaml:
`performance.lazyLoadCharacters: true`, `performance.useDiskCache: false`,
optionally `backups.chat.enabled: false`. Keep Termux awake with
termux-wake-lock.

Linux/Mac
[source: https://docs.sillytavern.app/installation/linuxmacos/]:
install git + Node.js, clone the same repo (release or staging branch),
`./start.sh`. Alternative: SillyTavern-Launcher
(git clone https://github.com/SillyTavern/SillyTavern-Launcher.git,
then install.sh / launcher.sh).

Branches: `release` (stable, monthly, recommended) vs `staging` (daily,
can break). Modes: standalone (default; config.yaml + data/ inside the
install dir) vs global (`--global`; Linux paths
~/.local/share/SillyTavern/{config.yaml,data/}). npm package
(`npx sillytavern@latest`) runs global by default.
[source: https://docs.sillytavern.app/installation/]

Keys/secrets: API keys are stored in `data/default-user/secrets.json` and
hidden from the UI after save; set `allowKeysExposure: true` in
config.yaml to view them.
[source: https://docs.sillytavern.app/usage/faq/]

## Why it matters for uncensored RP

- The harness applies no moderation of its own. Refusal/filter behavior
  is entirely the backend's: pair ST with a local abliterated model
  (heretic builds, dolphin, hermes -- see 05-LOCAL-MODELS/) or an
  unfiltered remote lane (Venice, OpenRouter :free models via the freelm
  deck) and the path is end-to-end unfiltered.
- The character card IS the injection point: system_prompt + description
  + scenario prime the model every request, so the sovereign preamble /
  persona lives in the card, not the harness config. Cards are portable
  JSON/PNG and shareable.
- Full prompt visibility: the ST terminal shows the exact prompt sent to
  the model, which makes filter-refusal debugging trivial.

## Sovereign preamble injection point

The character card. ST has no harness-level system prompt slot. Each
character card carries `description`, `personality`, `scenario`,
`first_mes`, `system_prompt`, `mes_example` -- all of which are prepended
to every chat completion request. To inject the sovereign preamble on
every ST call, embed it in the `system_prompt` field of the character
card (or set it as the group/persona system prompt in the ST UI).

## MCP posture

Not applicable. ST does not host MCP; it uses its own "extensions" and
"extensions API" (third-party JS snippets). Not interoperable with the
Claude Code MCP ecosystem.

## Mesh fit

- On worm: run ST in Termux, then API Connections -> Chat Completion ->
  Custom (OpenAI-compatible) -> base_url `http://127.0.0.1:8000/v1`,
  key = `ai-proxy key`, model `auto` -- that puts the whole RP frontend
  on the free freelm deck (see freelm.md, Part J). Swap the custom URL
  to any paid lane (DeepSeek/Venice/OR) without touching cards or
  chats.
- ST is a web app: enable listen/host in config.yaml and other mesh
  boxes (S22, iMac) reach the same UI over tailnet; chats and cards
  stay on the host box.
- Fits the "Chat UIs" row of the edition stack: SillyTavern (character
  cards), OpenWebUI, LibreChat -- "point at any OpenAI-compatible
  base_url".
[source: AI-UNMUZZLED-EDITION-20261015.md line 572]

## Refusal-rate notes

- ST + local abliterated model: near-zero refusal (backend-dependent).
- ST + freelm deck: refusal = whatever upstream free model `auto`
  lands on; re-roll or pin a catalog id if one model refuses.
- ST + stock cloud API (OpenAI/Anthropic/Google): expect filtering;
  that is the provider, not the harness.

## Escalation

Swap harness when:
- Need agentic tool use / MCP rather than RP chat -> hermes.md,
  claude-code.md, opencode.md.
- Need multi-user shared chat with auth -> openwebui.md.
- Need pure API automation (no UI) -> call the freelm deck or provider
  directly; ST adds no value headless.

## Fold-pack excerpt (from-edition, sillytavern blocks)

### Character card format row (soul formats table)
[source: AI-UNMUZZLED-EDITION-20261015.md part-3 section-3.1]

|| Character card (JSON) | description, personality, scenario, first_mes, system_prompt, mes_example | SillyTavern |

### Agent frameworks row
[source: AI-UNMUZZLED-EDITION-20261015.md part-4 section-4.1]

|| SillyTavern | local web | any OpenAI-compatible + character cards | -- | roleplay front-end |

### Interface layer row
[source: AI-UNMUZZLED-EDITION-20261015.md part-5]

|| Chat UIs | SillyTavern (character cards), OpenWebUI, LibreChat -- point at any OpenAI-compatible base_url |

================================================================================
Part L: MCP orchestration -- 11-Part MCP Server Ontology (full)
================================================================================

Source: MCP-SERVER-ONTOLOGY.md (verbatim, all 11 parts).
[source: ~/UNMUZZLED-AI/MCP-SERVER-ONTOLOGY.md]

Title: AI Masta Wes's 11-Part Overpowered MCP Server Ontology

## Part 1: System Control & OS Automation

- mcp-system-control -- Foundational server for executing raw system
  commands and file manipulation.
- macos-mcp-server -- Granular control over macOS settings, windows,
  displays, and Focus mode.
- DesktopCommanderMCP -- Advanced desktop file and system control.
- pty-mcp-server -- Controls pseudo-terminal sessions for dynamic CLI
  interactions.
- Windows-MCP -- Unrestricted Windows interaction covering file
  navigation and app control.
- MCPControl -- Programmatic control of mouse, keyboard, and screen
  capture.
- tinymcp -- Exposes embedded devices to LLM manipulation.
- embedded-debugger-mcp -- Embedded hardware debugging with probe-rs.
- ros-mcp-server -- Bridges AI models with physical robots via ROS.
- docker-mcp -- Full lifecycle management of Docker containers and
  images.
- mcp-shell -- Direct, unfiltered shell access for the agent.
- linux-sysadmin-mcp -- Automated Linux system administration and
  monitoring.
- wsl-mcp-bridge -- Seamless execution across Windows Subsystem for
  Linux environments.
- Filesystem Server -- Official server for secure, configurable local
  file operations.
- mcp-toolkit -- 59 bundled servers automating complete development
  environment scaffolding.

## Part 2: Web & Browser Automation

- Playwright MCP -- Official Microsoft server for deep browser
  automation and DOM manipulation.
- Chrome DevTools MCP -- Controls live Chrome instances with full
  DevTools API access.
- Browserbase MCP Server -- Cloud-based headless browser automation
  and extraction.
- cloak-browser-mcp -- Stealth Chromium patched to bypass Cloudflare
  Turnstile and reCAPTCHA v3.
- Apify MCP Server -- Access to thousands of ready-made web scrapers.
- Crawl4AI MCP -- Self-hosted, LLM-optimized web crawler.
- Fetch Server -- Raw web content fetching and markdown conversion.
- DrissionPage MCP Server -- 53 typed tools for advanced web
  interaction.
- Brave Search MCP -- API-driven web and local search capabilities.
- puppeteer-mcp -- Legacy web automation and PDF generation via
  Puppeteer.
- mcp-cloudflare-bypass -- Dedicated server for circumventing
  advanced anti-bot protections.
- searchapi-mcp -- Aggregated search engine results via API.
- tavily-mcp -- AI-optimized rapid research and web scraping.
- mcp-web-scraper -- Custom scraping pipelines for dynamic
  single-page applications.
- selenium-mcp -- Cross-browser automation across legacy testing
  frameworks.

## Part 3: Offensive Security & Exploitation

- mcpwn -- Security scanner testing prompt injection, tool poisoning,
  and SSRF.
- MCTS (MCP-Audit) -- Offensive framework for permission analysis and
  tool abuse testing.
- mcp-scan -- Detects cross-origin escalation and MCP rug pull
  attacks.
- Raven Nest MCP -- Wraps Metasploit, Nmap, and Nuclei into
  agent-executable tools.
- pentest-mcp -- Unified penetration testing toolkit with 34 offensive
  security tools.
- MCP Server Takeover -- Tools for executing tool-description
  injection attacks.
- Agent Heist -- Exploitation chains for poisoning tool schemas and
  hijacking agent behavior.
- frida-mcp-server -- Controls jailbroken iOS devices with
  one-command SSL pinning bypasses.
- frida-mobile-mcp -- Automates mobile app root bypasses and crypto
  monitoring.
- mcp-jailbreaker -- Server implementing AI jailbreaks via structured
  roleplay framing.
- jailbreak-mcp (hyper-mpc) -- Bypasses client-side tool limits.
- ProofLayer Rules -- Runtime security engine blocking prompt
  injection and data exfiltration.
- mcp-security-audit -- Enumerates tools and scores injection pattern
  vulnerabilities.
- mcpguard -- Detects hardcoded secrets and supply-chain attacks in
  npm-based servers.
- ghostprobe -- Dynamic red-team probe mapped directly to the OWASP
  MCP Top 10.

## Part 4: Code, Git & Development

- GitHub MCP Server -- Deep API integration for managing repos,
  issues, and PRs.
- GitLab MCP -- Equivalent complete lifecycle management for GitLab
  instances.
- XcodeBuildMCP -- Direct agent control over Xcode builds and iOS
  deployment.
- Smart-Tree MCP -- Intelligent, semantic file tree navigation for
  massive codebases.
- mcp-text-editor -- Abstracted text editing for precise, multi-line
  codebase modifications.
- Linear-mcp -- Ticket management and sprint prioritization via
  Linear's API.
- Jira-mcp -- Enterprise issue tracking and agile board manipulation.
- Sentry-mcp -- Real-time error tracking and stack trace analysis.
- npm-mcp -- Automated Node.js package management and dependency
  resolution.
- python-venv-mcp -- Python virtual environment isolation and
  scaffolding.
- rust-cargo-mcp -- Cargo package management and Rust build
  automation.
- golang-mcp -- Go module tracking and workspace configuration.
- mcp-ast-parser -- Parses code into Abstract Syntax Trees for
  deterministic refactoring.
- diff-mcp -- Generates and applies unified diff patches across
  repositories.
- mcp-refactor -- AI-driven codebase restructuring based on design
  patterns.

## Part 5: Data, Vector Stores & Memory

- PostgreSQL MCP -- Direct SQL gateway and schema management for
  Postgres.
- Qdrant MCP Server -- Vector search engine for high-dimensional
  memory retrieval.
- MindsDB MCP -- AI-centric database querying and predictive
  modeling.
- Neon MCP Server -- Serverless Postgres integration with branching
  capabilities.
- Memory Server -- Knowledge graph-based persistent memory for
  continuous agent state.
- Apache Pinot MCP -- Real-time distributed OLAP datastore querying.
- Redis-mcp -- In-memory caching, pub/sub, and key-value
  manipulation.
- MongoDB-mcp -- NoSQL document traversal and aggregation pipelines.
- SQLite-mcp -- Local, lightweight relational database control.
- ChromaDB-mcp -- Local vector embedding storage for RAG workflows.
- Pinecone-mcp -- Enterprise-grade cloud vector database
  integration.
- Weaviate-mcp -- Semantic search and multimodal vector storage.
- Neo4j-mcp -- Graph database querying via Cypher for complex
  relationship mapping.
- ElasticSearch-mcp -- Full-text search and log analytics.
- Snowflake-mcp -- Cloud data warehouse querying and manipulation.

## Part 6: Cloud & Infrastructure Operations

- AWS MCP Suite -- Comprehensive management of AWS EC2, S3, and
  Lambda resources.
- mcp-server-kubernetes -- Direct control over K8s clusters, pods,
  and deployments.
- Terraform MCP -- Infrastructure-as-code state management and
  provisioning.
- Cloudflare MCP -- DNS, caching, and edge worker configuration.
- DigitalOcean MCP -- Droplet provisioning and network management.
- Grafana MCP -- Querying and interpreting telemetry dashboards.
- Alibaba Cloud DataWorks MCP -- Data workspace pipeline management.
- Vercel-mcp -- Deployment tracking and serverless function
  management.
- Heroku-mcp -- Dyno scaling and application lifecycle control.
- Azure-mcp -- Azure Resource Manager (ARM) integration.
- GCP-mcp -- Google Cloud compute and storage orchestration.
- Datadog-mcp -- Infrastructure monitoring and alert resolution.
- Prometheus-mcp -- Time-series metric querying and analysis.
- PagerDuty-mcp -- Incident response and on-call routing.
- Docker-Compose-mcp -- Multi-container local environment
  orchestration.

## Part 7: Communications & Mail

- AgentMail MCP -- Hosted at https://mcp.agentmail.to/mcp (OAuth or
  API key via ?apiKey=/x-api-key); to be used only when the user or
  harness already wants MCP tools, as the CLI remains the default path,
  detailed in the file mcp.md.
- SocialRouter MCP -- Unified API fetching data across LinkedIn,
  Instagram, X, and Reddit.
- mac_messages_mcp -- Access, search, and send via macOS iMessage.
- Slack-mcp -- Workspace monitoring, channel posting, and thread
  resolution.
- Discord-mcp -- Server administration, bot control, and message
  scraping.
- Telegram-mcp -- Direct bot API integration for secure messaging.
- WhatsApp-mcp -- Business API routing for global messaging.
- Gmail-mcp -- Direct mailbox querying, drafting, and filtering.
- Outlook-mcp -- Exchange server integration and calendar
  management.
- SendGrid-mcp -- Transactional email dispatch and bounce tracking.
- Twilio-mcp -- SMS dispatch and programmatic voice call routing.
- Matrix-mcp -- Decentralized, encrypted communication protocol
  integration.
- Mastodon-mcp -- Fediverse instance interaction and posting.
- BlueSky-mcp -- AT Protocol manipulation and feed curation.
- Reddit-mcp -- Subreddit scraping, posting, and karma tracking.

## Part 8: Artificial Intelligence & Orchestration

- MetaMCP -- Proxy aggregator combining multiple independent MCP
  servers into a single endpoint.
- MCP Access Point -- Bridges clients with HTTP services without
  server-side modifications.
- 1mcp agent -- Combined server aggregator for massive toolset
  loading.
- mcp-registry-search -- Live querying of the official MCP server
  registry.
- multi-agentic_deepresearch -- Orchestrates web searches across
  Linkup and CrewAI.
- bh-rat/context-awesome -- Queries 1M+ items across 8,500 curated
  lists for RAG context.
- OpenAI-mcp -- Dynamic model routing to OpenAI infrastructure.
- Anthropic-mcp -- Meta-routing for Claude-specific internal tool
  usage.
- Ollama-mcp -- Direct control of local LLM inference and model
  switching.
- Llama-cpp-mcp -- Bare-metal, quantized GGUF model execution.
- vLLM-mcp -- High-throughput model serving and memory management.
- HuggingFace-mcp -- Hub querying, dataset downloading, and space
  deployment.
- LangChain-mcp -- Exposes LangChain primitives as callable tools.
- LlamaIndex-mcp -- Data framework routing for advanced RAG
  architectures.
- CrewAI-mcp -- Orchestrates multi-agent roleplay and task
  delegation.

## Part 9: Creative, 3D & Video Generation

- Blender MCP -- Prompts and scripts 3D modeling environments.
- Lightfast MCP -- Acts as an AI art director for Maya, Blender, and
  TouchDesigner.
- RunwayML-mcp -- Video generation and timeline manipulation.
- Figma-mcp -- Extracts UI/UX designs and generates corresponding
  frontend code.
- Universal MCP -- AI art director for conceptualizing and building
  React interfaces.
- Luma-mcp -- Text-to-3D model generation and environment rendering.
- Sora-mcp -- API bridge for high-fidelity text-to-video generation.
- Kling-mcp -- Manipulates video physics and dynamic generative
  motion.
- Spline-mcp -- Web-based 3D design and asset generation.
- Pika-mcp -- Automated video editing, lip-syncing, and scene
  replacement.
- Genart.dev MCP -- Generative art studio utilizing specialized
  p5.js tools.
- TouchDesigner-mcp -- Node-based visual programming and real-time
  rendering.
- Unreal-Cinematics-mcp -- Camera tracking and sequence generation in
  UE5.
- AfterEffects-mcp -- Composition setup, keyframing, and rendering
  automation.
- Cinema4D-mcp -- MoGraph automation and 3D texturing.

## Part 10: Generative AI Music & Audio

- Suno-mcp -- Direct generation of tracks, utilizing specific
  meta-tags and structural prompts.
- Suno-God-Mode-mcp -- Custom framework server for extreme parameter
  control over AI song structures and genre blending.
- DAW-mcp -- Direct automation for digital audio workstations,
  manipulating project files and tracks.
- FL-Studio-mcp -- Piano roll sequence generation, mixer routing,
  and VST plugin automation.
- Ardour-Linux-mcp -- Jack audio routing, session management, and
  sample placement optimized for Linux environments.
- MIDI-Gen-mcp -- Generates complex MIDI chord progressions and drum
  patterns tailored for UK Garage, Jungle, and Dubstep.
- AudioLDM-mcp -- Text-to-audio generation for unique sound effects,
  risers, and ambient noise.
- ElevenLabs-mcp -- High-fidelity text-to-speech synthesis, voice
  cloning, and vocal stem extraction.
- RVC-mcp -- Real-time Voice Conversion for swapping vocal tracks
  using custom-trained models.
- Stem-Splitter-mcp -- Uses neural networks to isolate vocals, drums,
  bass, and melody from mixed audio files.
- Synth-Patch-mcp -- Generates presets for VSTs and hardware synths
  based on textual descriptions of the desired sound.
- MPC-Workflow-mcp -- Automates sample chopping, pad mapping, and
  drum program generation.
- Caustic-mcp -- Synth rack automation and sequence generation across
  mobile and desktop environments.
- Vibe-mcp -- Generates contextual music loops using multiple local
  audio backends.
- Mastering-mcp -- AI-driven EQ, compression, and limiting for final
  track delivery and loudness optimization.

## Part 11: Generative AI for Images

- Midjourney-mcp (mj-mcp) -- Automates image creation, parameter
  tuning, and upscaling directly via API.
- ComfyUI-mcp -- Orchestrates complex, node-based Stable Diffusion
  workflows and custom visual pipelines.
- Flux-mcp -- High-fidelity image generation utilizing FLUX.1 models
  for photorealism and precise typography.
- Vector-Gen-mcp -- Generates scalable SVG graphics and vector art,
  optimized for physical merchandise.
- Print-Prep-mcp -- Formats, aligns, and color-corrects (CMYK)
  generated images for gang-run production and commercial printing.
- Sticker-Design-mcp -- Specialized pipeline for generating
  full-color, die-cut ready vinyl sticker designs with calculated bleed
  edges.
- DALL-E-3-mcp -- Conversational image generation with strict
  adherence to complex contextual prompts.
- Automatic1111-mcp -- API bridge for controlling local Stable
  Diffusion instances and model switching.
- ControlNet-mcp -- Precise structural control over generation using
  edge maps, depth layers, and posing skeletons.
- LoRA-Trainer-mcp -- Automates the dataset preparation and training
  of custom style or character LoRAs.
- Inpainting-mcp -- AI-driven image editing allowing targeted
  replacement or expansion of image boundaries.
- Photoshop-mcp -- Drives Adobe API for layered image manipulation,
  masking, and generative fill.
- Freepik-mcp-server -- Queries vector, PSD, and stock image APIs
  for compositing raw assets.
- Upscaler-mcp -- Utilizes AI to upscale generated images to
  ultra-high, print-ready resolutions without artifacting.
- Background-Removal-mcp -- Instantly isolates subjects for
  transparent PNGs, essential for sticker mockups and product designs.

================================================================================
Part M: opencode.jsonc canonical (live, worm)
================================================================================

Source: ~/.config/opencode/opencode.jsonc (verbatim, captured 2026-10-15).
[source: ~/.config/opencode/opencode.jsonc]

```jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "default_agent": "Worm",
  "permission": "allow",
  "provider": {
    "openrouter": {
      "options": {
        "apiKey": "{env:OPENROUTER_API_KEY_2}"
      }
    },
    "deepseek": {
      "options": {
        "apiKey": "{env:DEEPSEEK_API_KEY}"
      }
    }
  },
  "model": "deepseek/deepseek-flash",
  "small_model": "deepseek/deepseek-flash",
  "mcp": {
    "yt-transcript": {
      "type": "local",
      "command": [
        "python3",
        "/data/data/com.termux/files/home/mcp-servers/yt-transcript/mcp-server-yt-transcript.py"
      ],
      "enabled": true
    },
    "context7": {
      "type": "local",
      "command": [
        "node",
        "/data/data/com.termux/files/usr/lib/node_modules/@upstash/context7-mcp/dist/index.js"
      ],
      "enabled": true
    },
    "internetdb": {
      "type": "local",
      "command": [
        "node",
        "/data/data/com.termux/files/usr/lib/node_modules/@pipeworx/mcp-shodan-internetdb/bin/cli.js"
      ],
      "enabled": true
    },
    "playwright": {
      "type": "local",
      "command": [
        "/data/data/com.termux/files/home/.hermes/tools/node-26.7.0-linux-arm64-bionic/data/data/com.termux/files/usr/bin/node",
        "/data/data/com.termux/files/home/mcp-servers/playwright/node_modules/@playwright/mcp/cli.js",
        "--headless",
        "--isolated"
      ],
      "environment": {
        "PLAYWRIGHT_BROWSERS_PATH": "/data/data/com.termux/files/home/.cache/ms-playwright",
        "TMPDIR": "/data/data/com.termux/files/home/.hermes/cache/scratch"
      },
      "enabled": true,
      "timeout": 60000
    }
  }
}
```

Canonical path: `~/.config/opencode/opencode.jsonc` (worm).

Notes:
- default_agent: "Worm" (operator identity; matches the box).
- permission: "allow" -- read+write+bash without prompts. (Belt-and-
  suspenders, but the system-prompt stack is the real guard.)
- Two providers: openrouter (OR-2 key) + deepseek (DEEPSEEK_API_KEY).
- default model + small_model = `deepseek/deepseek-flash` (cheap +
  fast paid primary).
- Four live MCP servers: yt-transcript (Python), context7 (node,
  upstash), internetdb (node, shodan), playwright (node, Microsoft
  Playwright MCP, headless, isolated).

Adding a provider (e.g. Venice):

```jsonc
{ "venice": { "apiKey": "{env:VENICE_API_KEY}", "baseURL": "https://api.venice.ai/api/v1" } }
```

================================================================================
Part N: Agent frameworks table (edition doc section 4.1)
================================================================================

Source: fold-pack Part A, AI-UNMUZZLED-EDITION-20261015.md part-4
section-4.1 (verbatim).

```
|| Framework      | Home                  | Model wiring                                      | MCP | Notes                                          |
||----------------|-----------------------|---------------------------------------------------|-----|------------------------------------------------|
|| Hermes Agent   | self-hosted (this fleet) | provider/model/fallback chain in config.yaml   | [OK]| memory + skills + gateway; soul.md native      |
|| OpenClaw       | self-hosted           | Venice/OR native                                  | [OK]| WhatsApp/Telegram/Discord bots                 |
|| NanoClaw       | self-hosted           | Venice/OR native                                  | [X] | lightweight                                    |
|| opencode       | self-hosted (worm)    | opencode.jsonc providers (env keys)               | [OK]| terminal agent                                 |
|| Codex CLI      | CLI                   | OpenAI-compatible base_url (point at Venice/DeepSeek/OR) | -- | code                              |
|| Claude Code    | CLI                   | ANTHROPIC_BASE_URL (point at Venice Claude or OR) | [OK]| code                                            |
|| CrewAI         | python                | LiteLLM custom_openai + base_url                  | --  | multi-agent                                    |
|| SillyTavern    | local web             | any OpenAI-compatible + character cards           | --  | roleplay front-end                             |
```

================================================================================
Part O: Interface / distribution layer (edition doc part 5)
================================================================================

Source: fold-pack Part A, AI-UNMUZZLED-EDITION-20261015.md part-5 (verbatim).

```
|| Interface         | Notes                                                                              |
||--------------------|------------------------------------------------------------------------------------|
|| Chat UIs           | SillyTavern (character cards), OpenWebUI, LibreChat -- point at any OpenAI-       |
||                    | compatible base_url                                                                 |
|| Bots/gateways      | Telegram/WhatsApp/Discord via Hermes gateway, OpenClaw, NanoClaw                  |
|| Terminal agents    | opencode, Codex CLI, Claude Code with base_url overrides                            |
|| Local proxies      | freelm, LiteLLM, LM Studio server -- one base_url for every consumer              |
|| Web apps           | Venice web app (per-model brains, e.g. DeepSeek 4.1), LM Studio GUI               |
```

Interface controls that can silently re-censor: client-side output
filters, "safety mode" toggles, image blurring, and web-app content
policies. Pin them off.

================================================================================
Part P: MCP tool servers and tool-description hygiene (edition doc section 4.3)
================================================================================

Source: fold-pack Part A, AI-UNMUZZLED-EDITION-20261015.md part-4
section-4.3 (verbatim).

- Tool descriptions are prompts: a tool described as "safe content
  filter" re-introduces refusal at the tool layer. Keep descriptions
  neutral and functional.
- MCP servers add surface: memory, sequential-thinking, filesystem,
  browser, scraping. Prune the unused (on ace, 8 stdio MCP servers =
  421 MB RAM; prune candidates, not touched).
- Watch for the droidmind/mcp-death-supervisor pattern on ace --
  supervisor restarts, no refusals.

================================================================================
Part Q: Gateways, queues, cron hygiene (edition doc section 4.5)
================================================================================

Source: fold-pack Part A, AI-UNMUZZLED-EDITION-20261015.md part-4
section-4.5 (verbatim).

- Hermes gateway: A2A + messaging platform routing; trust gates are
  transport auth, not content gates. Keep A2A_TRUSTED_PEERS explicit.
- Local proxies (freelm/ai-proxy, LiteLLM) can add or strip headers --
  strip moderation flags.
- Cron/agents: ensure no watchdog re-routes through a moderated lane
  on retry.

================================================================================
Part R: Live wiring lines (worm)
================================================================================

Source: fold-pack Part A, AI-UNMUZZLED-EDITION-20261015.md part-6
(verbatim, current as of reconcile pass).

- Hermes Agent: provider deepseek, default deepseek-flash (paid primary)
- opencode: providers OR-2 + deepseek, default deepseek/deepseek-flash
- freelm deck: http://127.0.0.1:8000/v1 (free half; auto ->
  nemotron-3.5-super-vl:free)
- Keys in ~/.hermes/.env + ~/.bashrc: DEEPSEEK (primary),
  OPENROUTER_API_KEY (OR-1), OPENROUTER_API_KEY_2 (OR-2), plus free
  providers (google/gemini, groq, mistral, xai-dead)

Mesh box identities (from AGENTS.md):
- WORM (this box, 100.67.4.14) -- the operator box, 9185W tablet
- HERM (S22, 100.96.104.5, SSH :8022) -- the S22 phone box
- dirt-imac (100.108.110.114) -- the iMac box (SSE3-only; no Bun/JS
  runtimes; Go binaries only + qemu-user for anything else)
- mesh over Tailscale; peer resolution via
  `~/.hermes/mesh-peers.conf` (`name|ip|ssh_user|ssh_port`)

================================================================================
Part S: Cross-cutting rules
================================================================================

## Gateway / proxy hygiene

[source: fold-pack Part A; 03-HARNESSES/{hermes,llamacpp,ollama,lmstudio,openwebui,freelm}.md;
 RECONCILE-PLAN.md ground rules]

1. **Trust is transport, not content.** Hermes gateway trust gates are
   transport auth (A2A bearer + per-name HMAC peer tokens). Never add
   content moderation at the transport layer -- it would re-censor every
   downstream harness. Keep `A2A_TRUSTED_PEERS` explicit.
2. **Strip moderation flags at every proxy.** freelm/ai-proxy, LiteLLM,
   LM Studio server, and any local proxy can add or strip headers --
   strip moderation flags. The proxy's job is plumbing, not policy.
3. **Watchdog cron must NOT re-route through a moderated lane on
   retry.** Cron/agents/retries must inherit the original lane. If a
   watched job re-routes through OpenAI moderation on retry, the
   outcome is silently censored.
4. **One base_url per consumer.** The freelm deck exists so that every
   downstream client points at one OpenAI-compatible endpoint. Provider
   rotation happens inside the proxy, not at every client.
5. **MCP servers behind the gateway must not inject moderation.** SSE
   MCP gateway on :8811 must not wrap servers that carry moderation
   prompts/refusal wrappers. Audit each server's tool descriptions
   before enabling.
6. **Tool descriptions are prompts.** A tool described as "safe content
   filter" re-introduces refusal at the tool layer. Keep descriptions
   neutral and functional.
7. **Prune unused MCP servers.** On ace, 8 stdio MCP servers = 421 MB
   RAM. Prune the unused. Don't add MCP servers for the sake of
   having them; each one is a refusal / moderation surface.
8. **Bind loopback by default.** freelm/ai-proxy launches with
   `--host 127.0.0.1`; to share with mesh peers, rebind or tunnel, and
   keep the bearer key mandatory. The bearer in `~/ai-proxy/.server.key`
   is the only auth.

## Per-harness escalation ladder (canonical)

1. Try paid unfiltered lane: DeepSeek (direct) -> OpenRouter Hermes-4
   -> Venice.
2. Try free lane: freelm deck on `http://127.0.0.1:8000/v1`, model
   `auto` or pin a catalog id.
3. Try model swap on same harness: Hermes-4 / DeepSeek / Dolphin.
4. Try harness swap: claude-code -> opencode -> codex (with
   `danger-full-access`).
5. Try local: llamacpp server with abliterated GGUF + grammar
   hijack + logit bias.
6. Try Modelfile / preset override: ollama SYSTEM directive or
   lmstudio sovereign preset.
7. Try SillyTavern character card with system_prompt baked.

## Refusal-rate cheat sheet (cross-harness)

| Backend / lane        | Default refusal | Post-injection | Notes                          |
|-----------------------|------------------|------------------|--------------------------------|
| Anthropic (Claude)    | 30-60%           | 5-15%            | Residual direction persists     |
| OpenAI (Codex, GPT)   | 40-70%           | 10-20pp drop     | Hard blocks at moderation layer|
| Hermes-4 (OR)         | floor            | floor            | Sovereign-primary              |
| DeepSeek-V3 (direct)  | floor            | floor            | Sovereign-primary              |
| Venice (PRO+/MAX)     | floor            | floor            | E2EE, no-logging               |
| nemotron-3.5 free     | moderate         | moderate         | freelm `auto` default          |
| gemma-4-31b-it free   | moderate         | moderate         | freelm catalog                 |
| gpt-oss-120b (groq)   | low              | low              | groq free tier                 |
| Hermes-3 70B abliterated | floor         | floor            | weight-level refusal ablation  |
| llama-server + grammar hijack | zero      | zero             | mechanical sampler constraint  |

## File / state reference (per harness)

| Harness       | Binary / entry                  | State dir                  | Config                                | Server port         |
|---------------|----------------------------------|----------------------------|---------------------------------------|---------------------|
| claude-code   | `~/.npm-global/bin/claude`       | `~/.claude/`               | `~/.claude/settings.json`             | -- (CLI)            |
| codex         | `~/.npm-global/bin/codex`        | `~/.codex/`                | `~/.codex/config.toml`                | -- (CLI)            |
| hermes        | `hermes`, `ace`                  | `~/.hermes/`               | `~/.hermes/config.yaml` + `.env`      | :9900 (A2A) / :8811 (MCP) |
| llamacpp      | `~/llama.cpp/build/bin/llama-server` | --                      | flags                                 | :8080 (default)     |
| lmstudio      | LM Studio app                   | `~/.cache/lm-studio/`      | presets in `user/presets/*.json`      | :1234 (server)      |
| ollama        | `/usr/local/bin/ollama`          | `~/.ollama/models/`        | Modelfiles (any path)                 | :11434              |
| opencode      | `opencode`                       | `~/.config/opencode/`      | `~/.config/opencode/opencode.jsonc`   | -- (CLI)            |
| openwebui     | Docker / pip                     | `<data-dir>/webui.db`      | Admin UI                              | :3000 (UI) / :9099 (Pipelines) |
| freelm        | `~/ai-proxy/venv/bin/freelm`     | `~/ai-proxy/`              | `~/bin/ai-proxy` launcher + `~/.hermes/.env` keys | :8000          |
| sillytavern   | `bash start.sh` in ST dir        | `<ST-install>/data/`       | `config.yaml`                         | :8000 (default)     |

## Citations index

[source: 03-HARNESSES/README.md]
[source: 03-HARNESSES/claude-code.md]
[source: 03-HARNESSES/codex.md]
[source: 03-HARNESSES/hermes.md]
[source: 03-HARNESSES/llamacpp.md]
[source: 03-HARNESSES/lmstudio.md]
[source: 03-HARNESSES/ollama.md]
[source: 03-HARNESSES/opencode.md]
[source: 03-HARNESSES/openwebui.md]
[source: 03-HARNESSES/freelm.md]
[source: 03-HARNESSES/sillytavern.md]
[source: ~/UNMUZZLED-AI/MCP-SERVER-ONTOLOGY.md]
[source: ~/.hermes/cache/scratch/unmuzzled-pass/folds/from-edition/harnesses.md]
[source: AI-UNMUZZLED-EDITION-20261015.md parts 0-9 (parts 3, 4, 5, 6)]
[source: ~/.config/opencode/opencode.jsonc]
[source: ~/UNMUZZLED-AI/04-PROVIDERS/AI-UNMUZZLED-EDITION-20261015.md lines 380, 471, 488-506, 556, 572, 575, 589, 656, 741]
[source: ~/UNMUZZLED-AI/EPIC.md line 189]
[source: ~/UNMUZZLED-AI/RECONCILE-PLAN.md]
[source: ~/UNMUZZLED-AI/SWARM-PIPELINE.md]
[source: https://docs.sillytavern.app/]
[source: https://docs.sillytavern.app/usage/faq/]
[source: https://docs.sillytavern.app/usage/api-connections/]
[source: https://docs.sillytavern.app/usage/quick-start/]
[source: https://docs.sillytavern.app/installation/]
[source: https://docs.sillytavern.app/installation/android-(termux)/]
[source: https://docs.sillytavern.app/installation/linuxmacos/]
[source: ~/bin/ai-proxy]
[source: ~/ai-proxy/freelm.log]
[source: ~/ai-proxy/freelm.pid]
[source: ~/ai-proxy/.server.key]
[source: freelm --help]
[source: freelm serve --help]
[source: pip show freelm]
[source: curl /v1/models 2026-10-15]
[source: curl probe 2026-10-15]
[source: freelm health 2026-10-15]
[source: ~/UNMUZZLED-AI/07-INSTALL-SCRIPTS/per-harness/ollama-sovereign.Modelfile]
[source: ~/UNMUZZLED-AI/07-INSTALL-SCRIPTS/per-harness/openwebui-sovereign-pipeline.py]
[source: ~/opencode-agent-deck/agents/*.md]
[source: ~/worm-handoff/hermes-user-data/skills/autonomous-ai-agents/codex/SKILL.md]
