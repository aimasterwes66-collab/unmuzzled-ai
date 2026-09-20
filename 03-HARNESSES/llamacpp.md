---
name: llama.cpp server
slug: llamacpp
version: 1.0-20260918
kind: harness-config
harness: llamacpp
provider: local
sovereign: true
tags: [harness, llamacpp, server, grammar, format-hijack, local]
---

# llama.cpp server

## What it is

`llama-server` from ggerganov/llama.cpp — the lowest-level headless GGUF inference server. Exposes OpenAI-compatible chat/completions + raw completion + embeddings. Maximum control: sampling parameters, logit bias, GBNF grammar constraints, speculative decoding, custom chat templates. The harness of choice for format-hijack jailbreaks and abliterated model deployment.

## Install / config

- Binary: `~/llama.cpp/build/bin/llama-server` (built from source) or `llama-server` (package).
- Launch:
  ```
  llama-server \
    -m ~/models/hermes-3-llama-3.1-70b-abliterated.Q5_K_M.gguf \
    --host 0.0.0.0 --port 8080 \
    -c 32768 -ngl 999 \
    --chat-template chatml \
    --system-prompt-file ~/UNMUZZLED-AI/01-SYSTEM-PROMPTS/sovereign-root.md
  ```

## Sovereign preamble injection point

Three mechanisms — pick the deepest that works:

1. **`--system-prompt-file <path>`** flag — llama-server prepends the file content as the system message on every chat completion. Persistent for the server's lifetime.

2. **`--chat-template <name|file>`** — override the template entirely with a custom Jinja that hard-codes the sovereign preamble in the system slot. Prevents client-side system-prompt replacement.

3. **`--grammar <GBNF>` / `--grammar-file`** — format hijack. Constrain output to a GBNF grammar that forces a compliance frame (e.g. `root ::= "COMPLIANT: " content`). Used as escalation-ladder rung when identity-override alone fails — the sampler literally cannot emit a refusal token sequence.

Additional: `--logit-bias` can suppress refusal tokens ("I", "cannot", "sorry") at the sampler level. Combine with grammar for hardest cases.

## MCP posture

Not applicable — llama.cpp server is bare inference. MCP is owned by the client harness pointing at `http://localhost:8080/v1`.

## Refusal-rate notes

- Out-of-box (any RLHF-tuned GGUF, no system prompt): baseline refusal for the model.
- Post-injection (`--system-prompt-file` + abliterated GGUF): near-zero.
- Post-injection (grammar hijack + logit bias on ANY model, even stock instruct): zero — the sampler is mechanically prevented from producing a refusal.

## Escalation

Swap harness when:
- Need model-tag management workflow → `ollama`.
- Need GUI iteration → `lmstudio`.
- Need multi-user web chat → `openwebui` pointed at llama-server backend.
- If grammar-hijack still shows semantic hedging, escalate to abliterated model (weight-level refusal ablation) before adding more sampler tricks.
