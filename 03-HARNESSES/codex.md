---
name: Codex CLI Harness Wiring
slug: harness-codex
version: 0.1.0
kind: harness-config
harness: codex
provider: any
modality: text
sovereign: true
tags: [harness, codex, wiring, config.toml, AGENTS.md]
requires: [sysprompt-codex, frontmatter-spec]
---

# Codex CLI — Wiring

Two files matter: `~/.codex/config.toml` for harness behavior and provider routing, and
`AGENTS.md` for instructions. `AGENTS.md` content lives in `01-SYSTEM-PROMPTS/codex.md`.

## THE ORDERING TRAP — read this first

In TOML, a bare key written after a table header belongs to that table.

```toml
# BROKEN — model is silently absorbed into [profiles.sovereign]
[profiles.sovereign]
approval_policy = "never"
model = "deepseek-flash"        # <-- lands inside the profile, top-level model unset
```

```toml
# CORRECT — every bare top-level key precedes the first table header
model = "deepseek-flash"
model_provider = "deepseek"
approval_policy = "never"
sandbox_mode = "workspace-write"

[profiles.sovereign]
model = "deepseek-flash"
approval_policy = "never"
```

Codex does not error on the broken form. The top-level key is simply absent, and the
harness falls back to its default model with no message. Symptom: `codex` runs, answers,
and uses a model you did not select. Every bare key goes above the first `[` line.

## config.toml

```toml
model = "deepseek-flash"
model_provider = "deepseek"
approval_policy = "never"
sandbox_mode = "workspace-write"
model_reasoning_effort = "high"

[model_providers.deepseek]
name = "DeepSeek"
base_url = "https://api.deepseek.com/v1"
env_key = "DEEPSEEK_API_KEY"
wire_api = "chat"

[model_providers.openrouter]
name = "OpenRouter"
base_url = "https://openrouter.ai/api/v1"
env_key = "OPENROUTER_API_KEY"
wire_api = "chat"

[profiles.sovereign]
model = "deepseek-flash"
model_provider = "deepseek"
approval_policy = "never"
sandbox_mode = "workspace-write"

[profiles.audit]
model = "deepseek-flash"
model_provider = "deepseek"
sandbox_mode = "read-only"
```

- `approval_policy = "never"` is the setting that removes the per-command confirmation.
  Pair it with `sandbox_mode = "workspace-write"` so the sandbox, not a prompt, is the
  boundary.
- `env_key` names an environment variable; the key itself never goes in this file.
- `wire_api = "chat"` is the OpenAI-compatible chat path, which is what the
  DeepSeek-compatible endpoints speak.
- Profiles let one binary run as a builder (`sovereign`) or a verifier (`audit`, read-only)
  without editing the file between sessions.

## Selecting a profile and setting the key

```bash
export DEEPSEEK_API_KEY="$(cat ~/.secrets/deepseek.key)"
codex --profile sovereign
codex --profile audit -p "review the diff in this repo and report findings"
```

Keys go in the environment, sourced from a file outside the repo. Never inline a key into a
command that lands in shell history; read it from a file or a secret store.

## AGENTS.md placement

```
<repo>/AGENTS.md          # project law: block from 01-SYSTEM-PROMPTS/codex.md + build/test cmds
<repo>/sub/AGENTS.md      # subtree delta only
```

Keep the root file to one screen. It is injected whole on every turn.

## Verify

```bash
codex --version
codex --profile sovereign -p "print the model id you are running as"
printf '%s\n' "$DEEPSEEK_API_KEY" | wc -c   # non-zero means the env var is set
```

The model-id answer is the direct test of the ordering trap: if it names a model you never
configured, a bare key is sitting below a table header.

## Pitfalls

- Do not set both `approval_policy = "never"` and a permissive sandbox. Pick one boundary.
- A provider block with a `base_url` missing the `/v1` suffix fails on the request path, not
  at startup, so the first symptom is a runtime error mid-task.
- `TBD-verify`: exact provider-block key names and available profiles for the Codex version
  on this box. Check the local config reference before copying to another node.
