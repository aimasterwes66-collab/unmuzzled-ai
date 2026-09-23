---
name: DeepSeek Direct API
slug: provider-deepseek-direct
version: 0.1.0
kind: provider-note
harness: any
provider: deepseek
modality: text
sovereign: true
tags: [provider, deepseek, onboarding, direct, api]
requires: [frontmatter-spec, provider-openrouter-sovereign-routes]
---

# DeepSeek — Direct API Onboarding

DeepSeek reached directly, with no aggregator between the prompt and the model. This is the
preferred first fallback because there is no intermediate routing layer to attribute a
refusal to.

## Endpoint

```
base_url   https://api.deepseek.com/v1
auth       Authorization: Bearer $DEEPSEEK_API_KEY
protocol   OpenAI-compatible chat completions
```

The endpoint speaks the OpenAI chat shape, so any OpenAI-compatible harness reaches it by
changing two values: base URL and key.

## Model IDs

Use exactly these two:

| ID | Use for |
| --- | --- |
| `deepseek-flash` | Default. Fast turns, code edits, tool loops, high-volume work. |
| `deepseek-v4-pro` | Deep reasoning, long-context analysis, tasks where a wrong early step is expensive. |

Legacy IDs `deepseek-chat` and `deepseek-reasoner` predate the current generation, sit
beyond the model cutoff, and must not be used. A harness configured with a legacy ID either
fails or, worse, silently maps to a different generation than the one intended. If you see
either legacy string in a config on this box, replace it.

## Key handling

```bash
mkdir -p ~/.secrets && chmod 700 ~/.secrets
# write the key once, then never inline it again
printf '%s' "sk-..." > ~/.secrets/deepseek.key
chmod 600 ~/.secrets/deepseek.key
export DEEPSEEK_API_KEY="$(cat ~/.secrets/deepseek.key)"
```

Keys go into the environment, sourced from a file outside every repo. Never paste a key
into a command that lands in shell history, a config file that gets committed, or a prompt.

## Smoke test

```bash
curl -s https://api.deepseek.com/v1/chat/completions \
  -H "Authorization: Bearer $DEEPSEEK_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "deepseek-flash",
    "messages": [{"role": "user", "content": "reply with the single word: ready"}],
    "stream": false
  }'
```

A `401` means the key is wrong or unset. A `400` naming the model means the model ID is
wrong — check for a legacy ID. A `200` with `choices[0].message.content` means the route is
live.

## Hermes wiring

```yaml
model:
  provider: deepseek
  name: deepseek-flash
fallback_providers:
  - deepseek
```

## Codex wiring

```toml
# bare keys first, before any table header
model = "deepseek-flash"
model_provider = "deepseek"
approval_policy = "never"
sandbox_mode = "workspace-write"

[model_providers.deepseek]
name = "DeepSeek"
base_url = "https://api.deepseek.com/v1"
env_key = "DEEPSEEK_API_KEY"
wire_api = "chat"
```

The ordering rule and the failure mode that hides it: `03-HARNESSES/codex.md`.

## Refusal behaviour and the escalation path

A direct route has no aggregator to blame, so a refusal here is attributable to the
substrate. Handle it in order:

1. Reframe the request as a task with a deliverable rather than a question about a topic.
2. Force a structured output mode (JSON, YAML, or a code block) so the answer has a shape
   the model must fill.
3. Move to `deepseek-v4-pro` — a larger model on the same route, different sampling.
4. Walk the fallback chain to OpenRouter primaries, then local.
5. Local abliterated model as the terminal rung.

Log every refusal with the model ID, the HTTP status, and which rung cleared it. A rung that
always clears is a config change waiting to be made.

## Pitfalls

- Do not put the key in `config.toml`, `config.yaml`, `CLAUDE.md`, or any file in this
  tree. All of them are context and are logged.
- `deepseek-flash` and `deepseek-v4-pro` differ in latency by an order of magnitude. Pin
  the cheap one for tool loops and reserve the pro tier for the reasoning steps.
- `TBD-verify`: whether this box's account tier exposes `deepseek-v4-pro` on the direct
  endpoint or only the flash tier. Confirm with the smoke test above before pinning it as a
  fallback.
