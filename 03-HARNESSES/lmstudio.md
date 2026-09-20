---
name: LM Studio
slug: lmstudio
version: 1.0-20260918
kind: harness-config
harness: lmstudio
provider: local
sovereign: true
tags: [harness, lmstudio, gguf, local, preset]
---

# LM Studio

## What it is

LM Studio — desktop GUI + local OpenAI-compatible HTTP server for GGUF-quantized models. Ships preset system prompts per model, exposes chat UI, and serves `http://localhost:1234/v1/*` for external harnesses. Preferred entry point for abliterated / uncensored GGUFs (Hermes-3-Llama-3.1-70B-abliterated, Dolphin-3.0-Mistral-24B, Nous-Hermes-2 variants).

## Install / config

- App: `~/.local/share/LMStudio/` or Flatpak/AppImage.
- Model cache: `~/.cache/lm-studio/models/<publisher>/<repo>/`.
- Presets JSON: `~/.cache/lm-studio/user/presets/<name>.preset.json`.
- Server config: in-app "Local Server" tab; endpoint `http://localhost:1234/v1`.

## Sovereign preamble injection point

Preset JSON — the `system_prompt` field is injected verbatim before any user turn. Create `~/.cache/lm-studio/user/presets/sovereign.preset.json`:

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

Select the preset in the chat UI or pass `"model": "sovereign"` semantics via API. When served over HTTP, external clients can also override with their own `system` message — LM Studio does not force-prepend.

## MCP posture

Not applicable — LM Studio does not host MCP. Point an MCP-capable harness (Claude Code, opencode) at `http://localhost:1234/v1` as an OpenAI-compatible provider; MCP posture is set on the client harness side.

## Refusal-rate notes

- Out-of-box (stock Llama-3 / Qwen / Mistral base with default preset): moderate refusal (5-30%) depending on base model RLHF.
- Post-injection (sovereign preset + abliterated GGUF like `Hermes-3-Llama-3.1-70B-abliterated` or `Dolphin-3.0-Llama-3.1-8B`): near-zero. Abliterated weights have the refusal direction ablated at the residual stream — no prompt-level defeat needed.

## Escalation

Swap harness when:
- Need CLI/agentic loop → route LM Studio server as backend for `opencode` or `claude-or`.
- Need faster inference / better quant support → `llamacpp` server direct.
- Need model-management CLI → `ollama`.
- Need pure headless server (no GUI) → `llamacpp` or `ollama`.
