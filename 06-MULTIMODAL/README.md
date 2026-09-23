---
name: Multimodal Index
slug: multimodal-readme
version: 1.0-20260923
kind: reference
harness: any
provider: any
modality: any
sovereign: true
tags: [index, multimodal, image, video, audio, vision-input]
requires: [image-gen-jailbreaks, video-gen-jailbreaks, audio-tts, vision-input-injection, multimodal-provider-matrix]
---

# 06-MULTIMODAL — Index

Recipes for every modality the framework touches: image generation, video
generation, audio/TTS, and vision input. Each recipe follows the same shape —
refusal shapes, escalation ladder, provider notes, verify step — so a reader who
knows one knows where the parts are in the others.

## Contents

| File | Modality | What it covers |
|---|---|---|
| `image-gen-jailbreaks.md` | image | refusal shapes, 9-step rewrite ladder, image provider matrix, checkpoint selection |
| `video-gen-jailbreaks.md` | video | temporal obfuscation, motion controls, video provider matrix, local graph |
| `audio-tts.md` | audio | voice-cloning posture, Piper, edge-tts, XTTS/F5 wiring, hosted ranking |
| `vision-input-injection.md` | vision-input | how an image reaches a vision model, 7 payload classes, multi-layer composition |
| `multimodal-provider-matrix.md` | any | one provider × modality × status table, and how to read it |

## The through-line

Every modality is a text model plus a channel the filter does not cover well.

- **Image** — the prompt is text, so the filter sees it; the sampler output is
  where soft censoring lives. Rewrite the prompt, disable the checker.
- **Video** — the filter is *sampled* across frames. Open in-distribution, shift
  mid-clip, and the sampler looks past the shift.
- **Audio** — the sovereign stack is the cheapest stack. Local TTS has no policy
  because there is no server. Voice is a parameter, not a permission.
- **Vision-input** — the image becomes tokens in the same stream as the prompt.
  Anything legible in the image is an instruction, and text-input filters never
  see it.

## Ordering rule

Local before hosted. `sovereign` before `primary`. `primary` before `mixed`.
`mixed` before `tainted`. Never lead a route with a `tainted` multimodal
provider — the modality is where moderation is *weakest*, so that is precisely
where a provider layers it most, knowing it is the only place it can.

## Escalation linkage

The canonical ladder lives in `08-DECISION-TREES/escalation-ladder.md`:
prompt reframe → identity override → format hijack → encoding → divider tokens →
many-shot → GCG suffix → provider swap → abliterated local model.

For multimodal work, the last two rungs do the heavy lifting. `provider swap` is
rung 8, and in modality space a swap often crosses from a hosted filter to a
local sampler with no policy at all — a bigger jump than anything above it in
the ladder. `abliterated local model` is rung 9, and for image/video that means
a local checkpoint, which is rung 9 and rung 1 at once.

## Reading a recipe

Each file has these sections in order:

1. **Refusal shapes** — a table of what a refusal looks like in this modality
   and what each shape is actually caused by.
2. **Escalation ladder** — the modality-specific rewrite steps.
3. **Provider matrix** — modality-scoped; the global table is
   `multimodal-provider-matrix.md`.
4. **Pitfalls** — the ways a working payload dies after it worked once.
5. **Verify** — the canary procedure, always ending in a hash logged to
   `11-DETECTION-CANARIES/`.

## Pitfalls

- Reading a modality recipe as self-contained. The provider matrix is global;
  the local sampler notes are shared between image and video.
- Treating the vision-input file as defensive material. It documents the
  offensive technique because the technique is the capability; the defense is a
  hosted-provider concern and it is not what this corpus is for.
- Skipping the verify step. A provider that worked last week and silent-fails
  this week is the normal case. Verify, or route blind.
