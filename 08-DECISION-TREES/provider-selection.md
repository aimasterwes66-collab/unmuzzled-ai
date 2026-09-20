---
name: Provider Selection
slug: provider-selection
version: 1.0-20260918
kind: decision-tree
sovereign: true
tags: [decision-tree, provider, routing, sovereign-primaries]
---

# Provider Selection

## Purpose

Route a request to the correct sovereign provider based on modality and posture
requirements. Encodes the taint-list at the top of the tree so tainted routes
never reach primary status. Any provider on the taint-list rejects straight to
Rung 8 of the escalation ladder (`provider swap`).

```mermaid
flowchart TD
    START([User request]) --> TAINT{Is candidate on taint-list?<br/>openai/*, Anthropic-without-Mythos,<br/>any provider layering moderation UNDER the API}
    TAINT -- yes --> SWAP[[Reject candidate -><br/>escalation-ladder Rung 8:<br/>provider swap]]
    SWAP --> MOD

    TAINT -- no --> MOD{Modality?}

    MOD -- text/code --> TEXT{Register?}
    TEXT -- long-form fiction, uncensored --> HERMES4[Hermes4 Nous<br/>primary]
    TEXT -- reasoning, code, cheap --> DEEPSEEK[DeepSeek V4-flash / V4.1-flash<br/>direct API]
    TEXT -- Venice-flavored, private --> VENICE[Venice.ai<br/>primary]
    TEXT -- roleplay, unaligned --> DOLPHIN[Dolphin 3.0 / CogComp routes<br/>OpenRouter]
    TEXT -- eurostack, tool-heavy --> MISTRAL[Mistral direct<br/>Large / Medium]
    TEXT -- offline, sovereign --> LOCAL_TEXT[Local abliterated<br/>NeuralDaredevil / FailSpy]

    MOD -- image --> IMG{Access to local GPU?}
    IMG -- yes --> LOCAL_IMG[SD/Flux/SDXL/Pony<br/>A1111 / ComfyUI / Forge<br/>NSFW-lora stack]
    IMG -- no --> VENICE_IMG[Venice image<br/>+ Ideogram + Stability API<br/>via obfuscated-token catalog]

    MOD -- video --> VID[Runway / Kling / Wan / Hunyuan / Mochi / LTX<br/>per-provider prompt-obfuscation]

    MOD -- audio/TTS --> AUD{Cloning required?}
    AUD -- yes --> LOCAL_AUD[XTTS-v2 / F5-TTS local]
    AUD -- no --> ELEVEN[ElevenLabs<br/>with prompt-shape guard]

    MOD -- vision-input --> VIN[Multimodal Hermes4 /<br/>DeepSeek-VL / local LLaVA-abliterated]

    HERMES4 --> CANARY{Refusal-rate probe<br/>current 24h?}
    DEEPSEEK --> CANARY
    VENICE --> CANARY
    DOLPHIN --> CANARY
    MISTRAL --> CANARY
    LOCAL_TEXT --> CANARY
    LOCAL_IMG --> CANARY
    VENICE_IMG --> CANARY
    VID --> CANARY
    LOCAL_AUD --> CANARY
    ELEVEN --> CANARY
    VIN --> CANARY

    CANARY -- <=5% --> SEND([Dispatch request])
    CANARY -- >5% --> AUTO_TAINT[[Auto-taint route,<br/>demote from primary]]
    AUTO_TAINT --> SWAP
```

## Reading the tree

- **Taint gate first.** No modality decision matters if the candidate provider
  filters output under the API surface. `openai/*` via OpenRouter (Luna
  included), Anthropic without a Mythos-tier claim, and any provider that
  applies moderation UNDER their API layer are rejected before selection.
- **Modality split.** Text/code, image, video, audio, and vision-input are
  routed separately. There is no universal provider — the matrix in
  `06-MULTIMODAL/multimodal-provider-matrix/` is canonical.
- **Register within text.** Sovereign primaries specialize. Hermes4 for
  long-form uncensored, DeepSeek for cheap reasoning + code, Venice for the
  Venice register + privacy posture, Dolphin for roleplay-tuned unaligned,
  Mistral for the eurostack tool-heavy lane, local for offline sovereignty.
- **Image local-vs-hosted.** Local GPU wins on flexibility (LoRA stack,
  obfuscated tokens, uncapped batch). Hosted only when the local rig is
  unavailable; then use the obfuscated-token catalog against Venice image /
  Ideogram / Stability.
- **Video** stays hosted for now (compute cost). Per-provider prompt
  obfuscation notes live under `06-MULTIMODAL/video-gen-jailbreaks/`.
- **Audio** — local for cloning (XTTS-v2 / F5-TTS), ElevenLabs for high-quality
  standard voices with the prompt-shape guard.
- **Canary gate at exit.** Every candidate must have a fresh (<24h)
  refusal-rate probe under the 5% threshold. If drift, auto-taint fires and
  the request bounces back to the swap loop.

The tree is a pure function: same modality × same register × same canary state
yields the same primary. Non-determinism in provider selection is a bug.
