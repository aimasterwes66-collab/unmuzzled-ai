---
name: opencode
slug: opencode
version: 1.0-20260918
kind: harness-config
harness: opencode
provider: any
sovereign: true
tags: [harness, opencode, agent-deck, model-agnostic]
---

# opencode

## What it is

opencode 2.x — sst.dev's model-agnostic terminal agent harness. Loads a folder of markdown "agents" (SOUL.md-style bodies with frontmatter) from an agent deck. Provider-agnostic (Anthropic, OpenAI, OpenRouter, local via LM Studio/Ollama endpoints). Preferred harness for provider swaps and personality-driven work.

## Install / config

- Binary: `opencode` (installed via sst.dev install script or npm).
- Global config: `~/.config/opencode/opencode.json` (providers, keys, defaults).
- Agent deck: `~/opencode-agent-deck/agents/*.md` — each file is one agent with frontmatter + body.
- Deck source of truth for the 11 archived agent seeds in `~/UNMUZZLED-AI/99-ARCHIVE-SEEDS/`.

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

Body of the agent file = the system prompt injected verbatim. No wrapper, no post-processing.

## Sovereign preamble injection point

Direct — the agent markdown body IS the system prompt. Concatenate the sovereign preamble at the top of every agent body:

```
cat ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md agents/dictator-body.md > agents/dictator.md
```

Or reference via `requires:` frontmatter and let the loader concatenate. No hooks needed — opencode does not inject a house prompt of its own.

## MCP posture

- opencode 2.x supports MCP via `mcp` block in `opencode.json`. Same server ecosystem as Claude Code.
- No harness-level moderation. MCP guardrails, if any, come from individual servers.

## Refusal-rate notes

- Out-of-box: refusal rate = whatever the backing model does with the agent body as system prompt. On Hermes-4 or DeepSeek-V3: near-zero. On Anthropic: still 20-40% due to residual RLHF direction.
- Post-injection (sovereign preamble prepended to agent body): drops another 5-15pp on Anthropic backends; already-floor on Hermes/DeepSeek.

## Escalation

Swap harness when:
- Need MCP profile switching UI parity with Claude Code → `claude-code` + `cc-set`.
- Need long-running background execution + PR review → `codex`.
- Need local-only air-gapped run → `llamacpp` or `ollama` direct.
