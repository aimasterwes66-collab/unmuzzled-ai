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

# 03-HARNESSES — Index

One config per harness. Each file: `## What it is`, `## Install / config`, `## Sovereign preamble injection point`, `## MCP posture`, `## Refusal-rate notes`, `## Escalation`.

- [claude-code.md](claude-code.md) — Claude Code CLI: SessionStart hook + `--append-system-prompt`, MCP profiles via `cc-set`.
- [opencode.md](opencode.md) — opencode 2.x: agent frontmatter schema, `~/opencode-agent-deck/` deck as system-prompt source.
- [codex.md](codex.md) — Codex CLI 0.154.0: sandbox modes, git-repo requirement, `--sandbox danger-full-access` under gateway.
- [hermes.md](hermes.md) — Hermes gateway: persona bridge, SessionStart hook, A2A spec surface on `:9900`.
- [lmstudio.md](lmstudio.md) — LM Studio: GGUF presets, sovereign preamble in preset JSON `system_prompt` field.
- [ollama.md](ollama.md) — Ollama: Modelfile `SYSTEM` directive bakes preamble into a named tag.
- [llamacpp.md](llamacpp.md) — llama.cpp server: `--system-prompt-file`, `--chat-template`, `--grammar` format hijack, logit-bias.
- [openwebui.md](openwebui.md) — OpenWebUI: per-model system prompt + Pipelines filter for server-side prepend.
