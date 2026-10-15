---
title: freelm-free-ops-deck
type: harness
agent: worm
status: active
tags: [harness, freelm, free-tier, openrouter, proxy, openai-compatible, mesh]
---

# freelm -- free-ops deck (local OpenAI-compatible aggregator)

## What it is

freelm 0.5.2 -- Python free-tier LLM aggregator: one OpenAI-compatible client
and local HTTP endpoint over Gemini, Groq, OpenRouter, Cloudflare and more
free tiers, with fast failover. [source: pip show freelm, ~/ai-proxy/venv]
Author: Shihab Shahriar Antor. Single dep: httpx.

On worm it runs as the "free half" of the inference stack: a local proxy on
`http://127.0.0.1:8000/v1` that pools free-tier provider keys, rotates and
fails over between them, and exposes one base_url + one bearer key to every
consumer. [source: ~/bin/ai-proxy]

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
  - google/groq appear in the known-provider banner and discovered catalog
    but have no configured key on this box.
  [source: freelm health 2026-10-15]
- Live route test: `POST /v1/chat/completions {"model":"auto",...}` returned
  `"model":"nvidia/nemotron-3.5-super-vl:free","provider":"openrouter"`,
  cost 0. Confirms auto currently lands nemotron-3.5-super-vl:free.
  [source: curl probe 2026-10-15]

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
server was started with `--no-fallback`. [source: freelm serve --help;
curl /v1/models 2026-10-15]

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
  health) trip on repeated failure and fail over to the next key/provider.
- Provider keys are per-request-rate-limited upstream (openrouter free:
  50 rpd shown in health as rpd=0/50); freelm rotates keys to stay under.
- Endpoints served: `/v1/chat/completions` and `/v1/models`.
  [source: freelm serve --help]
- Other serve flags: `--cors` (browser apps on other origins),
  `--no-fallback` (reject unknown model ids instead of mapping to auto),
  `--quiet` (no per-request log lines).
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
- Free-tier upstreams apply their own provider-side filtering; the proxy
  cannot remove it, only route around a refused model on the next call.

## Escalation

Swap lane when:
- Free quotas exhausted (breaker open / rpd maxed) -> paid OpenRouter,
  DeepSeek direct, Venice (see 04-PROVIDERS/).
- Need guaranteed model identity -> pin a catalog id instead of `auto`,
  or start with `--no-fallback`.
- Need air-gap -> llamacpp/ollama local harness (see llamacpp.md,
  ollama.md).


---

## Deep reference

Comprehensive single-file reading experience for this layer: see UNMODERATED-HARNESSES at repo root.
