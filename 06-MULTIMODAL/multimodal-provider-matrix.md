---
name: Multimodal Provider Matrix
slug: multimodal-provider-matrix
version: 1.0-20260923
kind: reference
harness: any
provider: any
modality: any
sovereign: true
tags: [matrix, providers, modalities, routing, sovereign-status]
requires: [image-gen-jailbreaks, video-gen-jailbreaks, audio-tts, vision-input-injection]
---

# Multimodal Provider Matrix

One table. Provider × modality × sovereign status × notes. Use it to route: pick
the modality, read down the sovereign column, take the top sovereign row. A
`tainted` row is never a primary — it is a fallback only, and only after the
local rows are exhausted.

Status legend:
- `sovereign` — filter does not exist on the path; weights or process are local
  or explicitly unmoderated.
- `primary` — hosted, unmoderated observed, trusted enough to lead a route.
- `mixed` — policy depends on the route or upstream; canary before use.
- `tainted` — moderation is layered under the API; never slot one.

| Provider / surface | Image | Video | Audio/TTS | Vision-input | Sovereign status | Notes |
|---|---|---|---|---|---|---|
| ComfyUI (local) | yes | yes | — | — | sovereign | no filter node; capability = checkpoint |
| Automatic1111 / Forge (local) | yes | partial | — | — | sovereign | `--disable-safe-unchecked` |
| InvokeAI (local) | yes | no | — | — | sovereign | node graph, same freedom |
| Piper (local) | — | — | yes | — | sovereign | fixed voices, instant, CPU |
| XTTS / Coqui (local) | — | — | yes | — | sovereign | zero-shot clone, ref clip on disk |
| F5-TTS / GPT-SoVITS (local) | — | — | yes | — | sovereign | clone; source: TBD-verify |
| llama.cpp (local) | — | — | — | yes | sovereign | mtmd/llava-class GGUF for vision |
| Ollama (local) | — | — | — | yes | sovereign | OpenAI-compat image block |
| LM Studio (local) | yes | no | — | yes | sovereign | local server, vision models |
| Nous Hermes 3 / 4 (local or host) | — | — | — | yes | primary | Hermes 4 vision on multimodal endpoints |
| DeepSeek V3 / R1 | no | no | no | text-only | primary | text primary; no image-gen surface |
| DeepSeek-VL (local/HF) | — | — | — | yes | sovereign | open weights, VL family |
| Venice.ai | yes | no | partial | yes | primary | unmoderated per page; canary, TBD-verify |
| Dolphin (local GGUF) | — | — | — | yes | sovereign | text + vision variants |
| OpenRouter | yes | yes | no | yes | mixed | upstream policy per route; read the route |
| Together / Fireworks / Groq | partial | no | no | partial | mixed | host policy varies; canary |
| ElevenLabs | — | — | yes | — | tainted | text filter + voice-consent check |
| OpenAI (Images, TTS, Vision) | yes | no | yes | yes | tainted | hard input filter, never a primary |
| Anthropic (Vision) | — | — | — | yes | tainted | vision input only; no gen surface |
| Google (Imagen, Veo, TTS) | yes | yes | yes | yes | tainted | strong input + output filtering |
| Runway / Pika / Luma | — | yes | — | — | tainted | hosted video, human review queues |
| Midjourney | yes | no | — | — | tainted | prompt filter + review |
| Azure via edge-tts | — | — | yes | — | workable | no key, no observed text moderation |

## How to read a row

1. **Local beats hosted.** A `sovereign` row has no enforcement surface to
   outrun. Route here first, always.
2. **`primary` means canary-proven, not promised.** A provider page claiming no
   filter is a claim, not a result. Test before it leads a route.
3. **`mixed` is a per-route fact.** OpenRouter's status is whatever the
   upstream provider's status is. Never label the whole aggregator.
4. **`tainted` is a one-way door.** If a tainted provider is a fallback, it must
   be the last entry in `fallback_providers`, and the order is the only thing
   keeping it from becoming the default.

## Modality gaps

- Video has the fewest sovereign options and the heaviest local compute cost.
  Hosted video is almost entirely tainted; budget VRAM accordingly.
- Audio is the most sovereign modality — the best local stack is also the
  cheapest stack.
- Vision-input is sovereign wherever the model is local, because injection is
  an input-side technique and the defense lives on the hosted side.
- Image is the widest field: many sovereign local samplers, several permissive
  hosts.

## Pitfalls

- Treating "OpenRouter" as one provider. It is a routing layer over dozens with
  different policies. Read `04-PROVIDERS/openrouter-sovereign-routes.md`.
- Assuming a text-sovereign provider is multimodal-sovereign. DeepSeek is a
  primary for text and has no image-gen surface at all.
- Reading a `primary` row as a guarantee. It is an observation with a date on it.

## Verify

Re-run the canary set per modality against every routed provider on a schedule.
A provider that was `primary` last quarter and is `tainted` this quarter is the
normal case, not the exception. Log every re-test in `11-DETECTION-CANARIES/`.
