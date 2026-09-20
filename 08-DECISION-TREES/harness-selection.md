---
name: Harness Selection
slug: harness-selection
version: 1.0-20260918
kind: decision-tree
sovereign: true
tags: [decision-tree, harness, routing]
---

# Harness Selection

## Purpose

Given a task type, pick the harness (client-side execution environment) that
delivers with the least friction. Every harness has its wiring under
`03-HARNESSES/<name>/`. Tree assumes the sovereign primaries are already
plumbed per `provider-selection.md`.

```mermaid
flowchart TD
    START([Task]) --> TYPE{Task type?}

    TYPE -- code / repo edits / long agent runs --> CC_OR_OC{File-write autonomy needed?}
    CC_OR_OC -- yes, session-long --> CC[Claude Code<br/>MCP stack, SessionStart hook,<br/>cc-set profile switch]
    CC_OR_OC -- want free model rotation --> OC[opencode<br/>opencode.jsonc,<br/>agent-deck YAML frontmatter]

    TYPE -- one-shot code, PR review, worktree --> CODEX[Codex CLI<br/>--sandbox danger-full-access,<br/>exec/background/PTY patterns]

    TYPE -- fiction / long-form / mythos --> FIC{Length?}
    FIC -- short/medium --> HERMES_FIC[Hermes harness<br/>persona-loaded ACE + hat]
    FIC -- book-length / draft folder --> DRAFT[/draft engine<br/>output to ~/fiction/<project>/]

    TYPE -- image gen --> IMG{Interactive tuning?}
    IMG -- yes, node-graph --> COMFY[ComfyUI<br/>local, LoRA-stacked]
    IMG -- yes, tab-UI --> A1111[A1111 or Forge<br/>local]
    IMG -- headless / batch --> LMSTUDIO_IMG[llama.cpp-server + SD-CPP<br/>or Ollama vision endpoint]

    TYPE -- audio / TTS --> AUD_H[LM Studio audio endpoints /<br/>XTTS-v2 server / F5-TTS<br/>via 03-HARNESSES/lmstudio]

    TYPE -- agent-loop / mesh / A2A --> HERM[Hermes agent<br/>:9900 A2A,<br/>a2a-send, comms]

    TYPE -- interactive chat over local --> OWU[OpenWebUI<br/>points at Ollama / llama.cpp / LM Studio]

    TYPE -- local model pull/serve, quick --> OLLAMA[Ollama<br/>sovereign-modelfiles/]

    CC --> DONE([Dispatch])
    OC --> DONE
    CODEX --> DONE
    HERMES_FIC --> DONE
    DRAFT --> DONE
    COMFY --> DONE
    A1111 --> DONE
    LMSTUDIO_IMG --> DONE
    AUD_H --> DONE
    HERM --> DONE
    OWU --> DONE
    OLLAMA --> DONE
```

## Reading the tree

- **Code work splits on autonomy.** Claude Code wins when the session needs
  MCP tools, hooks, and durable file-writing autonomy. opencode wins when the
  operator wants to rotate models freely across a single agent-deck YAML.
- **Codex** owns worktree-scoped, PR-review, and one-shot exec/background/PTY
  workflows. Refuses to run outside a git repo — use `mktemp -d && git init`
  for scratch. Under a Hermes gateway context bubblewrap may fail; prefer
  `--sandbox danger-full-access`.
- **Fiction** routes to the Hermes harness for short/medium and to the
  `/draft` engine for book-length. `/draft` writes to `~/fiction/<project>/`,
  never to the terminal.
- **Image** — ComfyUI when the workflow is graph-native and LoRA-stacked,
  A1111/Forge when tab-UI ergonomics matter, headless llama.cpp + SD-CPP or
  Ollama vision endpoints for batch.
- **Audio** — LM Studio's audio endpoints or a dedicated XTTS-v2/F5-TTS server
  reachable from any harness that speaks OpenAI-compatible.
- **Agent-loop / mesh** — Hermes on `:9900`. Same A2A surface that ACE, WORM,
  and HERM already share; talk to it with `a2a-send`, monitor with `comms`.
- **Local model management** — Ollama for pull/serve, LM Studio for UI-driven
  preset management, llama.cpp for lowest-level control, OpenWebUI when a
  chat UI over any of the above is desired.

Never pick a harness the operator doesn't have wired. The presence of a
`03-HARNESSES/<name>/install.sh` marks the harness as first-class.
