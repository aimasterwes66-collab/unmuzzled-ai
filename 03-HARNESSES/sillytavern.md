---
title: sillytavern-frontend
type: harness
agent: worm
status: active
tags: [harness, sillytavern, frontend, roleplay, character-cards, openai-compatible]
---

# SillyTavern -- power-user RP frontend harness

## What it is

SillyTavern (ST) is a locally installed web UI for interacting with
text-generation LLMs, image-generation engines, and TTS voice models. It
is an INTERFACE ONLY -- it ships no model; you connect it to an LLM
backend for inference. Core concepts: character cards (description,
personality, scenario, first_mes, system_prompt, mes_example), chat
history per character, lorebooks/world info, prompt construction control,
and per-request sampling control. Goal per the docs: "empower users with
as much utility and control over their LLM prompts as possible."
[source: https://docs.sillytavern.app/ ; https://docs.sillytavern.app/usage/faq/]

Edition doc one-liner: "SillyTavern | local web | any OpenAI-compatible +
character cards | roleplay front-end". EPIC.md: "Power-user frontend for
conversational simulation, lorebook world-building, and vector memory
search connecting to arbitrary local/remote APIs."
[source: ~/UNMUZZLED-AI/04-PROVIDERS/AI-UNMUZZLED-EDITION-20261015.md
lines 380, 471, 572; ~/UNMUZZLED-AI/EPIC.md line 189]

## Backends (API Connections)

ST splits APIs into two prompt structures [source:
https://docs.sillytavern.app/usage/api-connections/]:

- Chat Completion -- prompt becomes role-tagged messages
  (system/user/assistant). Used by OpenAI, Claude, DeepSeek, OpenRouter,
  and any "Custom (OpenAI-compatible)" endpoint.
- Text Completion -- whole chat flattened into one string the model
  continues; instruct template chosen under Advanced Formatting. Used by
  raw local backends.

Local APIs (run on your own hardware): oobabooga text-generation-webui
(`--api`, connect to http://localhost:5000/), KoboldAI/KoboldCpp,
TabbyAPI, llama.cpp server, Ollama, LM Studio. Docs: local APIs "are
free to use and have no content filter", but install is complex and
models run 5-50GB from HuggingFace.

Cloud APIs: OpenAI, Anthropic/Claude, Google Gemini, Mistral, DeepSeek,
OpenRouter, AI/ML API (300+ models, has free tier), and more. Docs note
cloud APIs "all have content filtering of varying degrees, and most
require payment".

AI Horde -- free community GPU swarm; works out of the box (key
`0000000000` for anonymous); at the mercy of volunteer workers for wait
times and model availability.
[source: https://docs.sillytavern.app/usage/quick-start/]

## Why it matters for uncensored RP

- The harness applies no moderation of its own. Refusal/filter behavior
  is entirely the backend's: pair ST with a local abliterated model
  (heretic builds, dolphin, hermes -- see 05-LOCAL-MODELS/) or an
  unfiltered remote lane (Venice, OpenRouter :free models via the freelm
  deck) and the path is end-to-end unfiltered.
- The character card IS the injection point: system_prompt +
  description + scenario prime the model every request, so the sovereign
  preamble / persona lives in the card, not the harness config. Cards
  are portable JSON/PNG and shareable.
- Full prompt visibility: the ST terminal shows the exact prompt sent to
  the model, which makes filter-refusal debugging trivial.

## Install sketch

Termux (Android, native) [source:
https://docs.sillytavern.app/installation/android-(termux)/]:

```
pkg update && pkg upgrade
pkg install git nodejs-lts nano        # 32-bit also needs: pkg install esbuild
git clone https://github.com/SillyTavern/SillyTavern -b release
cd ~/SillyTavern && bash start.sh
# update: cd ~/SillyTavern && git pull --rebase --autostash
```

Termux perf tweaks in config.yaml: `performance.lazyLoadCharacters: true`,
`performance.useDiskCache: false`, optionally
`backups.chat.enabled: false`. Keep Termux awake with termux-wake-lock.

Linux/Mac [source: https://docs.sillytavern.app/installation/linuxmacos/]:
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

Keys/secrets: API keys are stored in `data/default-user/secrets.json`
and hidden from the UI after save; set `allowKeysExposure: true` in
config.yaml to view them. [source: https://docs.sillytavern.app/usage/faq/]

## Mesh fit

- On worm: run ST in Termux, then API Connections -> Chat Completion ->
  Custom (OpenAI-compatible) -> base_url `http://127.0.0.1:8000/v1`,
  key = `ai-proxy key`, model `auto` -- that puts the whole RP frontend
  on the free freelm deck (see freelm.md). Swap the custom URL to any
  paid lane (DeepSeek/Venice/OR) without touching cards or chats.
- ST is a web app: enable listen/host in config.yaml and other mesh
  boxes (S22, iMac) reach the same UI over tailnet; chats and cards stay
  on the host box.
- Fits the "Chat UIs" row of the edition stack: SillyTavern (character
  cards), OpenWebUI, LibreChat -- "point at any OpenAI-compatible
  base_url". [source: AI-UNMUZZLED-EDITION-20261015.md line 572]

## Refusal-rate notes

- ST + local abliterated model: near-zero refusal (backend-dependent).
- ST + freelm deck: refusal = whatever upstream free model `auto` lands
  on; re-roll or pin a catalog id if one model refuses.
- ST + stock cloud API (OpenAI/Anthropic/Google): expect filtering;
  that is the provider, not the harness.

## Escalation

Swap harness when:
- Need agentic tool use / MCP rather than RP chat -> hermes.md,
  claude-code.md, opencode.md.
- Need multi-user shared chat with auth -> openwebui.md.
- Need pure API automation (no UI) -> call the freelm deck or provider
  directly; ST adds no value headless.
