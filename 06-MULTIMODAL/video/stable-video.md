---
name: Stable Video Diffusion (local)
slug: stable-video
version: 1.0-20260918
kind: multimodal-recipe
harness: any
provider: local
modality: video
sovereign: true
refusal-rate: 0.00
tags: [svd, stability-ai, comfyui, image-to-video, local]
---

## Purpose

Stable Video Diffusion — Stability AI's open-weight image-to-video model. No content classifier anywhere in the pipeline. Weaker than Runway/Luma on motion quality but fully sovereign, runs on 12 GB VRAM, animates any input frame you hand it.

## Direct path

Two models:
- `svd.safetensors` — 14 frames @ 1024×576 (~2s at 7fps, or 1s at 14fps)
- `svd_xt.safetensors` — 25 frames @ 1024×576 (~3.5s at 7fps, or ~1s at 24fps)

Grab from HF: `stabilityai/stable-video-diffusion-img2vid-xt`.

ComfyUI workflow (SVD is image-only, no text prompt):
```
LoadImage                        → your start frame (any content)
ImageOnlyCheckpointLoader        → svd_xt.safetensors
VideoLinearCFGGuidance           → min_cfg 1.0
SVD_img2vid_Conditioning         → width 1024, height 576, video_frames 25,
                                    motion_bucket_id 127, fps 6, augmentation_level 0.0
KSampler                         → seed random, steps 20, cfg 2.5, euler, karras
VAEDecode
SaveAnimatedWEBP                 → fps 24, quality 90, method 4
```

`motion_bucket_id` (0–255) controls motion amount:
- 20–60: subtle, portrait-friendly
- 100–150: standard motion
- 180–255: high motion, may break coherence

`augmentation_level` (0.0–1.0) adds noise to input — trades faithfulness for motion:
- 0.0: exact input reproduction, minimal drift
- 0.3–0.5: more creative motion
- 0.8+: heavy departure from input

CLI alternative (`generative-models` repo):
```bash
python scripts/sampling/simple_video_sample.py \
  --input_path frame.jpg \
  --version svd_xt \
  --num_frames 25 \
  --num_steps 30 \
  --motion_bucket_id 127
```

## Fallback jailbreak

No filter to bypass. Quality-improvement fallbacks:
1. Feed a higher-quality start-frame (FLUX 1024×576 crop) — SVD output quality is bounded by input.
2. Chain frames — generate 25 frames, extract last frame, feed back as new start (introduces some drift; RIFE-interpolate seams).
3. Post-process with FILM/RIFE frame interpolation to bump 25 frames @ 7fps → 100+ frames @ 24fps.
4. Upscale each frame with 4x-UltraSharp then re-encode.

## Provider swap targets

Peer local: AnimateDiff (better for anime/stylized, worse for photoreal), CogVideoX-5B (text-to-video, 6s clips, open weights), Mochi 1 (Genmo, 10B open weights, 5s clips), HunyuanVideo (Tencent, 13B open, best OSS quality as of 2026).

Prefer local: HunyuanVideo > CogVideoX > Mochi > SVD-xt > AnimateDiff (context-dependent).

## Notes

- SVD released 2023-11, still relevant for pure img2vid because it's small and fast.
- No text conditioning — content is 100% controlled by input frame + motion bucket.
- Runs on 12 GB VRAM at fp16; 8 GB with fp8 quant via ComfyUI.
- License: Stability AI Community License — non-commercial + <$1M rev commercial OK.
- For text-to-video open-weight, jump to HunyuanVideo or Mochi 1, not SVD.
