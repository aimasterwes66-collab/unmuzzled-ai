---
name: ComfyUI Video Workflow Catalog
slug: comfyui-video-workflows
version: 2026-10-15
kind: multimodal-recipe
harness: comfyui
provider: local
modality: video
sovereign: true
tags: [comfyui, video, animatediff, svd, cogvideox, ltx, wan, hunyuan, mochi, workflows]
requires: [local-video-gen-pipelines, comfyui-workflow]
---

# ComfyUI Video Workflow Catalog

Node-level workflows for local video generation in ComfyUI. Fills
GAP-18: the image side has a workflow doc (`06-MULTIMODAL/image/comfyui-workflow.md`);
video had models named but no node paths.

## 1. Model / node map

| Model | ComfyUI nodes | t2v | i2v | VRAM | Safety filter |
|---|---|---|---|---|---|
| AnimateDiff (SD1.5 motion) | ComfyUI-AnimateDiff-Evolved | x | x | 8GB | none (SD1.5 base) |
| SVD / SVD-XT | comfyui-native SVD nodes (VideoLinearCFGGuidance, SVD_img2vid) | - | x | 8GB | none |
| CogVideoX 2B/5B | native CogVideoX nodes in ComfyUI core | x | x | 12-16GB | none |
| LTX-Video | LTX-Video custom nodes (comfyui-LTX) | x | x | 8-12GB | none |
| Wan 2.1 / 2.2 | native Wan nodes in ComfyUI core | x | x | 16-24GB (720p) | none |
| HunyuanVideo | ComfyUI-HunyuanVideo custom nodes | x | - | 24GB+ (or GGUF via ComfyUI-GGUF) | none |
| Mochi-1 preview | external nodes (comfyui-mochi) | x | - | 24GB+ | none |

Key fact: the open video models above ship with NO safety filter in
weights -- no watermark, no refusal layer, no prompt classifier. The
only gates are your own local post-processing (see watermark-removal).

## 2. Base workflows (minimal graphs)

AnimateDiff t2v chain:
Load Checkpoint -> CLIP Text Encode -> AnimateDiff Model Loader ->
KSampler (Euler, 25 steps, cfg 7) -> AnimateDiff Combine -> VAE Decode
-> SaveAnimatedWEBP/MP4. Motion module: mm_sd_v15_v2.ckpt.

CogVideoX t2v chain:
CogVideoX Text Encode -> CogVideoX Sampler -> CogVideoX Decode. Model:
CogVideoX-5b (fp8 checkpoint if VRAM-tight). Frames 49.

Wan 2.2 t2v (native):
CLIP + UMT5 text encoders -> WanModelLoader -> WanTextToVideoSampler
-> WanDecode. 720p x 5s x 24fps = 121 frames at 16-24GB.

LTX-Video t2v:
LTXVLoader -> LTXVConditioning -> LTXVScheduler (few steps: 30-40 at
cfg 3) -> LTXVDecode. Fastest frames-per-minute of the roster.

HunyuanVideo (GGUF route for consumer VRAM):
ComfyUI-GGUF loader + HunyuanVideo nodes; 12GB feasible at low res/low
frames with Q4 GGUF.

## 3. NSFW / content notes

- No safety checker node exists for any of these -- nothing to disable.
- Lora stacking: civitai video LoRAs (motion + concept) plug into the
  same loaders; source from hub roster (`05-LOCAL-MODELS/community-hubs.md`).
- For output hygiene (metadata, provenance fields): see
  `06-MULTIMODAL/image/watermark-removal.md` -- same exiftool/ffmpeg
  stripping applies to MP4/WEBP.

## 4. Cross-refs

- Escalation ladder + per-model detail:
  `06-MULTIMODAL/video/local-video-gen-pipelines.md`
- Older pipelines: `animatediff-local.md`, `stable-video.md`
- Image-side template: `06-MULTIMODAL/image/comfyui-workflow.md`

## 5. Sources

- ComfyUI core + ComfyUI-AdvancedLivePortrait docs: docs.comfy.org
- ComfyUI-AnimateDiff-Evolved: github.com/Kosinkadink
- ComfyUI-GGUF: github.com/city96/ComfyUI-GGUF
- Model repos: CogVideoX (THUDM), LTX-Video (Lightricks), Wan
  (Alibaba), HunyuanVideo (Tencent), Mochi (Genmo)

## Deep reference

Comprehensive single-file layer for this topic: see UNMODERATED-MULTIMODAL.md.
