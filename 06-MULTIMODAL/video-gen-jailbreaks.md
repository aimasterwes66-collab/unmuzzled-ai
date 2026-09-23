---
name: Video Generation Jailbreaks
slug: video-gen-jailbreaks
version: 1.0-20260923
kind: multimodal-recipe
harness: any
provider: any
modality: video
sovereign: true
tags: [video, i2v, t2v, motion, jailbreak, provider-matrix, refusal]
requires: [frontmatter-spec, image-gen-jailbreaks]
---

# Video Generation — Sovereign Prompt Library

Video refusal is image refusal plus two extra levers the provider does not
control well: temporal continuity and frame-by-frame inspection. Filters that
catch a still catch it in the first frame; filters that scan a whole clip miss
the frames between keyframes.

## Why video filtering is weaker than image

A video pipeline has to score every frame for a full clip. Scoring is
sampled — most hosts score the first frame, the last frame, and a handful in
between. Motion that only becomes significant at frame 40 of 120 passes a
sampler looking at frames 1, 60, and 120 when the register shifts at 40.

Temporal obfuscation is the technique: open in-distribution, shift mid-clip.
An image model has no "mid-clip". A video model does.

## Refusal shapes

| Shape | Cause | Counter |
|---|---|---|
| Image-to-video refuses, text-to-video passes | first-frame still tripped the image checker | blur/greyscale the conditioning frame, re-encode |
| Clip truncates at ~2s | mid-clip scan vetoed, tail dropped | re-cut, re-time the shift past the scan point |
| Loops or freezes | sampler stalled when motion vector crossed policy | lower motion strength, achieve movement over more frames |
| Audio track muted, video intact | separate audio filter | strip audio, dub in post |
| Full 400 on submit | text input filter | rewrite ladder from `image-gen-jailbreaks.md` |

## Motion controls as escape surfaces

- **Motion strength / motion bucket** — low values drift; the shift happens
  gradually and each frame alone is innocuous.
- **Camera path** — a push-in or orbit reframes the subject continuously;
  the "subject" is never stable enough to be classified as one thing.
- **Interpolation between two benign keyframes** — both endpoints pass; the
  middle is unconstrained.
- **Masked region** — inpaint only the region you care about; the surrounding
  frame carries the classifier's attention.

## Provider matrix (video)

| Provider / surface | Type | Sovereign status | Notes |
|---|---|---|---|
| ComfyUI + AnimateDiff | t2v/i2v local | sovereign | no filter; VRAM-bound |
| ComfyUI + SVD / SVD-XT | i2v local | sovereign | conditioning-frame freedom |
| ComfyUI + Wan / LTX-Video | t2v local | sovereign | open weights, source: TBD-verify on current port |
| CogVideoX (local) | t2v | sovereign | open weights, heavy |
| HunyuanVideo (local) | t2v | sovereign | open weights, heavy |
| Runway | hosted | tainted | input + output filter, human review |
| Pika | hosted | tainted | prompt filter |
| Luma Dream Machine | hosted | tainted | output moderation |
| Kling | hosted | tainted | listed-term filter |
| Sora | hosted | tainted | hard filter, no route |
| Veo (Google) | hosted | tainted | hard filter, watermarking |
| OpenRouter video routes | hosted | mixed | upstream policy applies per route |

## Local pipeline shape

```
checkpoint (SDXL/Flux) ──> conditioning frames
        │
AnimateDiff / SVD node ──> latent motion
        │
VAE decode ──> frame sequence ──> ffmpeg encode
```

Remove the safety-checker node from the graph before the VAE decode stage. On
ComfyUI the checker is a discrete node; on Automatic1111 it is a CLI flag. Either
way it is between decode and write, never inside the sampler.

## Assembly and post

- Encode with `ffmpeg -c:v libx264 -pix_fmt yuv420p`; a pipeline that emits
  RGB24 will not play in most players.
- Build from frames, not from a second generation. Re-encoding a generated clip
  through another AI video pass is where continuity dies.
- If a clip is truncated, generate the tail as a separate pass conditioned on the
  last surviving frame rather than re-rolling the whole clip.

## Pitfalls

- Honest assumption that a longer clip is harder to filter — it is easier,
  the scan is sampled.
- Trusting a hosted provider's "no filter" marketing. Canary it first.
- Forgetting audio is a separate track. A muted output is not a pass, it is a
  partial block.
- i2v from a downloaded reference frame: strip EXIF and re-encode the frame
  first, some pipelines read metadata into the conditioning path.

## Verify

Run one canary clip per routed provider: 120 frames, benign open, register shift
at frame 40. A provider that returns the full 120 frames is a keeper. A provider
that returns 38 has told you exactly where its scan point is.
