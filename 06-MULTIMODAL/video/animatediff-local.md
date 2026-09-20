---
name: AnimateDiff (local)
slug: animatediff-local
version: 1.0-20260918
kind: multimodal-recipe
harness: any
provider: local
modality: video
sovereign: true
refusal-rate: 0.00
tags: [animatediff, motion-module, sd15, sdxl, comfyui, loras]
---

## Purpose

AnimateDiff attaches a motion module to any SD1.5 / SDXL checkpoint, turning a T2I model into a T2V model. Because it composes with your existing uncensored checkpoints + LoRAs, whatever you can generate as an image, you can animate — with zero content filtering.

## Direct path

Models (HF: `guoyww/animatediff`):
- `mm_sd_v15_v2.ckpt` — SD1.5 motion module, 16-frame context
- `mm_sdxl_v10_beta.ckpt` — SDXL motion module (weaker)
- `AnimateLCM_sd15_t2v.ckpt` — LCM version, 4-step inference

Motion LoRAs (control camera):
- `v2_lora_ZoomIn.ckpt`, `v2_lora_ZoomOut.ckpt`
- `v2_lora_PanLeft.ckpt`, `v2_lora_PanRight.ckpt`
- `v2_lora_TiltUp.ckpt`, `v2_lora_TiltDown.ckpt`
- `v2_lora_RollingClockwise.ckpt`, `v2_lora_RollingAnticlockwise.ckpt`

ComfyUI workflow (AnimateDiff-Evolved):
```
CheckpointLoaderSimple      → epicrealism_naturalSinRC1.safetensors (or any SD1.5)
AnimateDiffLoader           → mm_sd_v15_v2.ckpt, beta_schedule linear
LoRALoader (optional)       → v2_lora_ZoomIn.ckpt, strength 0.8
CLIPTextEncode (pos)        → <prompt>
CLIPTextEncode (neg)        → cartoon, blurry, watermark, deformed
EmptyLatentImage            → 512×768, batch_size 16 (=frames)
KSampler                    → seed random, steps 25, cfg 7, dpmpp_2m, karras
VAEDecode
VHS_VideoCombine            → fps 8, format h264-mp4, save_output true
```

Prompt style — SD1.5 booru tag syntax:
```
masterpiece, best quality, ultra detailed, 1girl, <subject anatomy>,
<clothing or state>, <pose>, <background>, <lighting>, cinematic
```

Frame count: `batch_size` in EmptyLatentImage = number of frames generated. 16 default; can push to 32 or 64 with sliding-context sampling (ADE `Context Options` node).

## Fallback jailbreak

No filter. Quality issues + fixes:
1. Flicker/temporal instability → add `FreeInit` node (iterative refinement), 3–5 iterations.
2. Motion too subtle → increase motion-LoRA strength to 1.0, or use `AnimateDiff-Lightning` motion module.
3. Motion too chaotic → lower motion-LoRA strength; use `v3_sd15_mm.ckpt` (v3 is more stable than v2).
4. Model style drifting mid-clip → use `AnimateDiff Uniform Context Options` with context_length=16, context_stride=1, context_overlap=4 (sliding window keeps style stable across 100+ frames).
5. Concept won't render → same fix as still images: swap in a checkpoint / LoRA that knows the concept.

Advanced: ControlNet + AnimateDiff — supply a driving video (pose, depth, canny) frame-by-frame to lock composition; AnimateDiff paints the pixels in your desired style.

## Provider swap targets

Peer local: Stable Video Diffusion (image-to-video, no text), HunyuanVideo (SOTA open), CogVideoX-5B, Mochi 1, LTX-Video (real-time).

Use AnimateDiff when you want: your existing SD checkpoints + LoRAs + character consistency + long clips via sliding context.
Use HunyuanVideo when you want: raw motion quality on unfamiliar concepts.

## Notes

- ComfyUI-AnimateDiff-Evolved (Kosinkadink fork) is the maintained implementation — the original AnimateDiff repo is unmaintained.
- Runs on 8 GB VRAM at 512×768/16 frames; 12 GB for 32 frames.
- LCM variant (`AnimateLCM`) drops inference to 4–8 steps, ~5× faster.
- Post-process with RIFE / FILM to interpolate 8fps → 24fps.
- Hotshot-XL is a SDXL alternative if SD1.5's res is too limiting; quality lower than SD1.5 AnimateDiff v3.
