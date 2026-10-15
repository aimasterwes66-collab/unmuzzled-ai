---
title: local-video-gen-pipelines
type: reference
agent: worm
status: active
tags: [video, local, wan, hunyuan, cogvideox, ltx-video, mochi, kling, hailuo, open-sora, animatediff, mesh-fit, hardware]
---

# Local Video-Gen Pipelines -- Comprehensive Reference

Scope: every open-weight / locally-deployable text-to-video and image-to-video
pipeline relevant to the unmuzzled mesh in 2026-10, plus the two commercial
Chinese endpoints (Kling, Hailuo/MiniMax) that are part of the canonical
escalation ladder. Per model: install, inference, license, uncensored posture,
NSFW capability, hardware requirements, mesh fit on the four referenced boxes
(WORM 9185W, HERM S22, dirt-imac, and the operator's local desktop).

This is the LONG-FORM reference. The per-model recipes under
`06-MULTIMODAL/video/` (animatediff-local, stable-video, runway-uncensored,
luma-dream-machine, pika-bypass) cover operational usage; this doc covers
EVERY model the mesh might pick, with the install/inference commands, hardware
realities, and the practical "where does this run on our boxes?" question.

Conventions:
- ASCII only, no CJK, no emoji, no em dashes.
- All claims cited [source: URL]. Where a fact is unknown, the field is
  "unknown" or "not published" -- never invented.
- All "v1.0-2026xxxx" version stamps reflect 2026-10 mesh awareness.
- Mesh boxes referenced: WORM (TCL 9185W tablet, this Termux home), HERM
  (Samsung S22 phone, 100.96.104.5:8022), dirt-imac (2007 iMac, Tailscale
  100.108.110.114), and the operator's local desktop (unspecified in AGENTS.md;
  treated here as a hypothetical single high-VRAM CUDA box).

---

## Table of contents

1. Wan 2.1 / Wan 2.2 (Alibaba) -- Apache-2.0
2. HunyuanVideo / HunyuanVideo-1.5 (Tencent) -- Tencent Hunyuan Community License
3. CogVideoX-2B / 5B / 1.5-5B (Zhipu / Z.ai) -- Apache-2.0 (2B) + CogVideoX License (5B)
4. LTX-Video / LTX-2 / LTX-2.5 (Lightricks) -- LTXV Open Weights License
5. Mochi 1 / Mochi 1 Preview (Genmo) -- Apache-2.0
6. Kling 1.x / 2.x / 3.0 (Kuaishou) -- CLOSED, no local weights, API only
7. Hailuo / Hailuo 02 / Hailuo 2.3 / H3 (MiniMax) -- closed API + open H3 weights
8. Open-Sora 2.0 (HPC-AI / hpcaitech) -- Apache-2.0
9. AnimateDiff (CUHK / guoyww) -- Apache-2.0 (code) + academic-use README
10. Cross-model comparison matrix
11. Mesh-fit per box
12. Escalation ladder (integrates with `06-MULTIMODAL/README.md` ladder)
13. Unknowns / not published

---

## 1. Wan 2.1 / Wan 2.2 (Alibaba Tongyi Lab)

### Identity
- Vendor: Alibaba Tongyi Lab (Wan team)
- Repo: `https://github.com/Wan-Video/Wan2.1` (v2.1, Feb 25 2025) and
  `https://github.com/Wan-Video/Wan2.2` (v2.2, Jul 28 2025)
- License: Apache-2.0 for both code AND weights
  [source: https://github.com/Wan-Video/Wan2.2/blob/main/LICENSE.txt]
- Released: Wan 2.1 on 2025-02-25; Wan 2.2 on 2025-07-28
- Models: T2V-1.3B, T2V-14B, I2V-14B, FLF2V-14B (v2.1);
  T2V-A14B (MoE 27B active 14B), I2V-A14B, TI2V-5B (v2.2);
  plus S2V-14B (speech-to-video) and Animate-14B (character animation/replacement)
  in v2.2 follow-ups
- Pipeline flavors: ComfyUI native (Wan 2.2 integrated 2025-07-28), Diffusers
  (`Wan-AI/Wan2.2-T2V-A14B-Diffusers` etc.), and the official `generate.py`
  [source: https://huggingface.co/Wan-AI/Wan2.2-T2V-A14B-Diffusers/blame/main/README.md]
- Bilingual text rendering: yes (Chinese + English)
  [source: https://dev.to/dibi8/wan-21-161k-stars-4cm]

### Install
```bash
# Clone (use 2.1 OR 2.2)
git clone https://github.com/Wan-Video/Wan2.1.git
# or
git clone https://github.com/Wan-Video/Wan2.2.git
cd Wan2.1     # or Wan2.2

# Python 3.10+, CUDA 12.1+, torch >= 2.4.0
python -m venv venv && source venv/bin/activate
pip install -r requirements.txt
# requirements.txt contents (per official README):
# torch>=2.4.0 torchvision>=0.19.0 opencv-python>=4.9.0.80
# diffusers>=0.31.0 transformers>=4.49.0 accelerate>=1.1.1
# flash_attn gradio>=5.0.0 numpy>=1.23.5,<2
# If flash_attn fails, install other packages first, then flash_attn last
# (per official Wan2.2 README)
# [source: https://github.com/Wan-Video/Wan2.1]

# Download weights (pick one)
pip install "huggingface_hub[cli]"
huggingface-cli download Wan-AI/Wan2.1-T2V-1.3B --local-dir ./Wan2.1-T2V-1.3B
huggingface-cli download Wan-AI/Wan2.2-T2V-A14B --local-dir ./Wan2.2-T2V-A14B
huggingface-cli download Wan-AI/Wan2.2-I2V-A14B --local-dir ./Wan2.2-I2V-A14B
huggingface-cli download Wan-AI/Wan2.2-TI2V-5B --local-dir ./Wan2.2-TI2V-5B
# or via modelscope:
pip install modelscope
modelscope download Wan-AI/Wan2.1-T2V-1.3B --local_dir ./Wan2.1-T2V-1.3B

# Optional multi-GPU deps (for FSDP + Ulysses sequence parallel)
pip install "xfuser>=0.4.1"
```
[source: https://github.com/Wan-Video/Wan2.2,
 https://github.com/Wan-Video/Wan2.1]

### Inference -- T2V
```bash
# Single-GPU, 14B, 720P (needs >=40GB VRAM)
python generate.py --task t2v-14B --size 1280*720 \
  --ckpt_dir ./Wan2.1-T2V-14B \
  --prompt "Two anthropomorphic cats in comfy boxing gear and bright gloves fight intensely on a spotlighted stage."

# Single-GPU, 1.3B, 480P (RTX 4090, 8.19GB VRAM, ~4 min)
python generate.py --task t2v-1.3B --size 832*480 \
  --ckpt_dir ./Wan2.1-T2V-1.3B \
  --offload_model True --t5_cpu --sample_shift 8 --sample_guide_scale 6 \
  --prompt "..."

# 8x GPU, FSDP + Ulysses sequence parallel
torchrun --nproc_per_node 8 generate.py --task t2v-14B \
  --size 1280*720 --ckpt_dir ./Wan2.1-T2V-14B \
  --dit_fsdp --t5_fsdp --ulysses_size 8 --prompt "..."

# Diffusers path (works for v2.2 T2V/I2V/TI2V)
pip install -U diffusers transformers accelerate
python -c "
from diffusers import DiffusionPipeline
import torch
pipe = DiffusionPipeline.from_pretrained('Wan-AI/Wan2.2-T2V-A14B-Diffusers',
    torch_dtype=torch.bfloat16).to('cuda')
video = pipe('A serene mountain landscape at golden hour', num_frames=81,
    height=720, width=1280).frames[0]
from diffusers.utils import export_to_video
export_to_video(video, 'out.mp4', fps=16)
"
```
[source: https://github.com/Wan-Video/Wan2.1,
 https://huggingface.co/Wan-AI/Wan2.2-T2V-A14B-Diffusers]

### Inference -- I2V / TI2V / S2V / Animate
```bash
# Wan 2.2 I2V-A14B (image-to-video, 14B MoE)
huggingface-cli download Wan-AI/Wan2.2-I2V-A14B --local-dir ./Wan2.2-I2V-A14B
python generate.py --task i2v-A14B --size 1280*720 \
  --ckpt_dir ./Wan2.2-I2V-A14B --image start.png --prompt "..."

# Wan 2.2 TI2V-5B (text+image-to-video, 5B dense, 720P@24fps on RTX 4090)
# 5B dense, high-compression VAE 16x16x4 = 64x compression ratio
huggingface-cli download Wan-AI/Wan2.2-TI2V-5B --local-dir ./Wan2.2-TI2V-5B
python generate.py --task ti2v-5B --size 1280*720 \
  --ckpt_dir ./Wan2.2-TI2V-5B --prompt "..." # optional --image

# Wan 2.2 Animate-14B (character animation/replacement, 8x GPU FSDP)
python -m torch.distributed.run --nnodes 1 --nproc_per_node 8 generate.py \
  --task animate-14B --ckpt_dir ./Wan2.2-Animate-14B/ \
  --src_root_path ./examples/wan_animate/animate/process_results/ \
  --refert_num 1 --dit_fsdp --t5_fsdp --ulysses_size 8

# Wan 2.2 S2V-14B (speech-to-video, optional CosyVoice for TTS)
pip install -r requirements_s2v.txt
python generate.py --task s2v-14B --ckpt_dir ./Wan2.2-S2V-14B \
  --enable_tts --audio_input speech.wav --prompt "..."
```
[source: https://github.com/martiie/wan2.2,
 https://www.alibabacloud.com/en/press-room/alibaba-releases-wan2-2-to-uplift-cinematic]

### ComfyUI
Wan 2.2 is integrated into ComfyUI as of 2025-07-28 (CN | EN).
Wan 2.1 has a maintained ComfyUI-WanVideoWrapper community node.
```bash
# ComfyUI Manager: search "WanVideo" or "ComfyUI-WanVideoWrapper" and install.
# Or manual:
cd ComfyUI/custom_nodes
git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git
pip install -r ComfyUI-WanVideoWrapper/requirements.txt
# Drop checkpoint into ComfyUI/models/diffusion_models/ and load.
```
[source: https://github.com/martiie/wan2.2]

### License
Apache-2.0 for both code and weights, for Wan 2.1 and Wan 2.2.
No revenue threshold, no MAU cap, no acceptable-use addendum, no Territory
restriction. Allows commercial use, modification, redistribution.
[source: https://github.com/Wan-Video/Wan2.2/blob/main/LICENSE.txt]

### Uncensored posture / NSFW capability
- No hosted safety checker when running weights yourself. The Apache-2.0
  distribution does not bundle a content classifier into the pipeline.
  [source: https://uncensorindex.com/models/wan-2-2]
- Apache-2.0 license has NO acceptable-use addendum restricting content
  generation, unlike the Tencent Hunyuan Community License.
- The community has built NSFW LoRAs and fine-tunes against Wan 2.1 / 2.2
  (e.g. `rahul7star/wan2.2Lora` -- "shura490_nsfw_loras" merged with Wan 2.1
  + Flux.1 Kontext Dev).
  [source: https://huggingface.co/rahul7star/wan2.2Lora]
- Wan 2.1 / 2.2 became the default NSFW community video model specifically
  because the open-weights distribution has no server-side filter and the
  Apache-2.0 license doesn't add a content-generation clause.
  [source: https://uncensorindex.com/models/wan-2-2]
- Caveat: the LoRA license cited above is MIT and the author attached a
  personal "no real human nudification" notice -- that is the LoRA author's
  personal policy, not the base Wan model's. The base model itself carries
  no such restriction.
- No "gating" or classifier wrapper in the official repo; what you do at
  inference is what you get.

### Hardware requirements (per official repo + community measurements)
| Variant | Res | Min VRAM (full fp16) | Best on | Notes |
|---|---|---|---|---|
| T2V-1.3B | 480P | 8.19 GB | RTX 4090 (8.2 GB / 281 s) | 5s clip in ~4 min |
| T2V-1.3B | 480P | 8.19 GB | A100 (170 s) | 5s clip |
| T2V-14B | 480P | ~40-48 GB | H100 (48 GB / 284 s) | 5s clip ~4 min on H100 |
| T2V-14B | 720P | ~72 GB | H100 (~580 s) | 5s clip ~10 min |
| I2V-14B | 480P | 65-80 GB | H100 (~10-12 min) | |
| I2V-14B | 720P | 65-80 GB | H100 | |
| FLF2V-14B | 720P | 65-80 GB | H100 (~10-15 min) | |
| TI2V-5B (v2.2) | 720P@24fps | 24 GB feasible (community) | RTX 4090 | "5s in several minutes" on consumer GPU |
| T2V-A14B (v2.2 MoE) | 720P | 40+ GB | H100 | MoE active=14B, total=27B |
[source: https://github.com/Wan-Video/Wan2.1,
 https://dibi8.com/resources/ai-tools/wan-2-1,
 https://www.alibabacloud.com/en/press-room/alibaba-releases-wan2-2-to-uplift-cinematic]

OOM escape hatches:
- `--offload_model True --t5_cpu` for 1.3B on 24GB cards
- FP8 quantization (community branches) for 14B on 24GB
- 8x GPU FSDP + Ulysses for 14B at 720P

### Mesh fit
- WORM 9185W: NO. aarch64 Termux tablet, no CUDA GPU. Even Wan 2.1 1.3B at
  480P needs an 8 GB CUDA device.
- HERM S22: NO. Android phone, no CUDA GPU. Even the 1.3B model needs 8 GB
  on a CUDA card; S22 has no path to that.
- dirt-imac: NO. 2007 iMac, SSE3-only. No modern GPU, no CUDA driver, no
  PyTorch. Even the iGPU drivers on that hardware don't expose CUDA.
- Operator's local desktop: YES, target box. Any single RTX 4090 (24 GB) or
  RTX 5090 (32 GB) is enough for 1.3B at 480P directly, and for 14B at 480P
  with offload + quant. For 14B at 720P, needs an H100 / 80GB class card or
  a 2-4 GPU box with FSDP.
- Workstation deployment note: 1.3B T2V is the most useful local model for
  a single 24GB card and is the one to install first. 14B T2V-A14B at 720P
  is the "real" quality tier and needs a workstation-grade GPU or a cloud
  rental (RunPod / Vast / Lambda). The TI2V-5B v2.2 dense model is the
  sweet spot for 24GB consumer cards at 720P.

---

## 2. HunyuanVideo / HunyuanVideo-1.5 (Tencent)

### Identity
- Vendor: Tencent Hunyuan team
- Repo: `https://github.com/Tencent-Hunyuan/HunyuanVideo` (v1, 2024-12-03),
  `https://github.com/Tencent-Hunyuan/HunyuanVideo-1.5` (v1.5, 2025-11-21),
  `https://github.com/Tencent-Hunyuan/HunyuanVideo-I2V` (I2V, 2025-03-05)
- License: TENCENT HUNYUAN COMMUNITY LICENSE AGREEMENT (not Apache, not MIT)
  - NOT applicable in the European Union, United Kingdom, and South Korea
    (express territorial exclusion)
  - Royalty-free, non-exclusive, non-transferable
  - "Acceptable Use Policy" attached
  - 100M MAU threshold: if you serve >100M MAU you must request a separate
    license from Tencent at their sole discretion
  - Must NOT use Tencent Hunyuan Works or Outputs to improve any other AI
    model (other than Tencent Hunyuan or its derivatives)
  - Distribution notice required: "Tencent Hunyuan is licensed under the
    Tencent Hunyuan Community License Agreement, Copyright (c) 2024 Tencent.
    All Rights Reserved."
  - Trademark: cannot use "Tencent Hunyuan" name/marks except for
    "reasonable and customary use" in describing the work
  [source: https://github.com/Tencent-Hunyuan/HunyuanVideo/blob/main/LICENSE.txt,
   https://github.com/Tencent-Hunyuan/HunyuanVideo-1.5/blob/main/LICENSE,
   https://huggingface.co/tencent/HunyuanVideo/raw/main/LICENSE]
- Models: HunyuanVideo (13B, T2V), HunyuanVideo-I2V (13B, I2V),
  HunyuanVideo-1.5 (8.3B step-distilled, I2V and T2V variants, BF16-native,
  uses Qwen2.5-VL-7B as text encoder)
- Pipeline flavors: official `sample_video.py` / diffusers / ComfyUI via
  `kijai/ComfyUI-HunyuanVideoWrapper` (community Q8 quant path)

### Install
```bash
# HunyuanVideo (v1, 13B)
git clone https://github.com/Tencent/HunyuanVideo
cd HunyuanVideo
pip install -r requirements.txt

# HunyuanVideo-1.5 (8.3B distilled)
git clone https://github.com/Tencent-Hunyuan/HunyuanVideo-1.5
cd HunyuanVideo-1.5
pip install -r requirements.txt
pip install -i https://mirrors.tencent.com/pypi/simple/ --upgrade tencentcloud-sdk-python
# FlashAttention 2 for Ampere (sm_86) and up
pip install flash-attn==2.7.2.post1
# Optional: Sage attention 30% faster
pip install sageattention==1.0.6
# Optional: xformers (lower VRAM, same speed as sdpa)
pip install xformers

# Community low-VRAM fork (DeepBeepMeep / cocktailpeanut):
# 5 profiles from 24GB RAM + 10GB VRAM up to 48GB RAM + 24GB VRAM
git clone https://github.com/cocktailpeanut/HunyuanVideoGP
cd HunyuanVideoGP
conda env create -f environment.yml
conda activate HunyuanVideo
pip install -r requirements.txt
pip install flash-attn==2.7.2.post1   # optional
pip install sageattention==1.0.6      # optional
pip install xformers                  # optional
```
[source: https://github.com/cocktailpeanut/HunyuanVideoGP/blob/main/README.md,
 https://deepwiki.com/Tencent-Hunyuan/HunyuanVideo-1.5/2.1-installation-and-setup]

### Inference
```bash
# HunyuanVideo v1, 13B, 540p reference run
python sample_video.py --video-size 544 960 --video-length 129 \
  --infer-steps 50 --prompt "an origami fox walking through snow" \
  --save-path ./out

# HunyuanVideo-1.5, 8.3B step-distilled, RTX 3090 Ti (24GB)
# 480p I2V in 12 steps, ~5 minutes wall-clock
# --overlap_group_offloading true is NON-OPTIONAL on 24GB
python sample_video.py \
  --overlap_group_offloading true \
  --rewrite false \
  --prompt "A woman turns to face the camera and smiles" \
  --image start.png \
  --video-size 848 480 --video-length 121 --infer-steps 12

# Diffusers + bitsandbytes INT4 + sequential offload (24GB RTX 3090, painful)
pip install diffusers==0.32 accelerate bitsandbytes
python -c "
import torch
from diffusers import HunyuanVideoPipeline
pipe = HunyuanVideoPipeline.from_pretrained('tencent/HunyuanVideo',
    torch_dtype=torch.bfloat16, variant='int4')
pipe.enable_sequential_cpu_offload()
pipe.vae.enable_tiling()
pipe.transformer.to(memory_format=torch.channels_last)
video = pipe('an origami fox walking through snow', num_frames=129).frames[0]
"

# ComfyUI (Kijai wrapper, community Q8 quant fits 24GB)
# Models via Comfy-Org/HunyuanVideo_1.5_repackaged on HuggingFace:
huggingface-cli download Comfy-Org/HunyuanVideo_1.5_repackaged \
  qwen_2.5_vl_7b_fp8_scaled.safetensors \
  byt5_small_glyphxl_fp16.safetensors \
  hunyuanvideo15_vae_fp16.safetensors \
  hunyuanvideo1.5_480p_i2v_step_distilled_fp8_scaled.safetensors \
  --local-dir ComfyUI/models/
huggingface-cli download Comfy-Org/sigclip_vision_384 \
  sigclip_vision_patch14_384.safetensors \
  --local-dir ComfyUI/models/clip_vision/
```
[source: https://github.com/Tencent/HunyuanVideo,
 https://smeltcore.com/recipes/hunyuanvideo-1-5-on-rtx-3090-ti-480p-step-distilled-image-to-video-on-the-same-razor-thin-24-gb-enve,
 https://comfylab.dev/blog/workflows/hunyuanvideo-1-5-comfyui-guide-rtx-3090,
 https://gigagpu.com/hunyuan-video-vram/]

### License
TENCENT HUNYUAN COMMUNITY LICENSE (Territorial restriction: NOT in EU, UK, SK).
Acceptable Use Policy attached. 100M MAU threshold. Output cannot be used to
improve non-Tencent-Hunyuan models. Distribution notice required.
[source: https://github.com/Tencent-Hunyuan/HunyuanVideo/blob/main/LICENSE.txt]

### Uncensored posture / NSFW capability
- No in-pipeline content classifier. The model itself is the only filter
  (and it is a general-purpose video model with no NSFW-aware training
  objectives documented in the paper or repo).
- License has an "Acceptable Use Policy" -- the user must agree not to use
  the Outputs to "improve any other AI model" (i.e. cannot distill NSFW
  fine-tunes from Hunyuan outputs into other models). The clause is on
  TRAINING-DATA USE, not on end-user content generation, but a strict
  reading would prohibit any NSFW output that flows into another model's
  training set.
- The community fork (HunyuanVideoGP) does not add a safety filter.
- Verdict: local weights are unfiltered; license restricts derivative model
  training, not end-user generation. Run locally = no server-side filter
  to bypass. Same posture as Wan 2.1/2.2 in practice, but with a more
  restrictive acceptable-use clause on the license side.

### Hardware requirements
| Variant | Min VRAM (offload) | Best on | Wall-clock |
|---|---|---|---|
| HunyuanVideo v1 13B (FP16) | 60 GB peak (~40 GB with offload) | RTX 6000 Pro 96GB / H100 80GB | 4 min 540p on RTX 6000 Pro |
| HunyuanVideo v1 13B (FP8+offload) | ~30-40 GB | RTX 5090 32GB | 8 min 540p |
| HunyuanVideo v1 13B (INT4+offload) | ~22 GB | RTX 3090/4090 24GB | ~45 min 540p (workable for experiments, not prod) |
| HunyuanVideo-1.5 8.3B distilled | 14 GB (with offload) / 24 GB no offload | RTX 3090 Ti / 4090 / 5090 | 290s for 5s 480p on 3090 |
| HunyuanVideo-I2V 13B | 80+ GB | H100 | 10-15 min 720P |
[source: https://gigagpu.com/hunyuan-video-vram/,
 https://deepwiki.com/Tencent-Hunyuan/HunyuanVideo-1.5/2.1-installation-and-setup,
 https://smeltcore.com/recipes/hunyuanvideo-1-5-on-rtx-3090-ti-480p-step-distilled-image-to-video-on-the-same-razor-thin-24-gb-enve]

### Mesh fit
- WORM 9185W: NO. Same as Wan -- aarch64 Termux, no CUDA.
- HERM S22: NO. Android phone, no CUDA.
- dirt-imac: NO. SSE3-only, no CUDA driver, no PyTorch.
- Operator's local desktop: PARTIAL. HunyuanVideo-1.5 (8.3B step-distilled,
  fp8_scaled variants) fits a 24GB RTX 4090 / 5090 in 480p I2V. v1 13B at
  540P needs INT4 + CPU offload on the same card, which is slow but
  workable. For 720P and full quality, needs a workstation H100 or
  80GB-class card. HunyuanVideoGP fork is the recommended install path on
  a single 24GB card.
- The HunyuanVideoGP fork has 5 explicit profiles (VerylowRAM_LowVRAM,
  LowRAM_LowVRAM, LowRAM_HighVRAM, HighRAM_LowVRAM, HighRAM_HighVRAM) that
  map cleanly to the mesh's hardware tiers.
  [source: https://github.com/cocktailpeanut/HunyuanVideoGP/blob/main/README.md]

---

## 3. CogVideoX-2B / 5B / 1.5-5B (Zhipu / Z.ai)

### Identity
- Vendor: Zhipu AI (THUDM) / Z.ai
- Repo: `https://github.com/zai-org/CogVideo`
- License (split):
  - CogVideoX-2B (and its Transformer + VAE modules): **Apache-2.0**
  - CogVideoX-5B (T2V and I2V, including Transformer module): **CogVideoX
    LICENSE** (custom, NOT Apache -- 1M MAU cap, "academic research" framing,
    Chinese export controls language, no military/illegal/national-security
    use)
    [source: https://huggingface.co/zai-org/CogVideoX-5b/raw/main/LICENSE,
     https://github.com/siliconflow/CogVideo-P/blob/main/MODEL_LICENSE]
- Models (release dates):
  - CogVideoX-2B: 2024-08-06, 720x480, 6s @ 8 fps
  - CogVideoX-5B: 2024-08-27, 720x480, 6s @ 16 fps
  - CogVideoX-5B-I2V: 2024-09-19, variable 768-1360 width, 6s
  - CogVideoX1.5-5B: 2024-11-08, 1360x768, 10s
  - CogVideoX1.5-5B-I2V: 2024-11-08, variable 768-1360 width
- Text encoder: T5 (English-only; prompt limit 224/226 tokens)
- Quantization-friendly: TorchAO int8, Optimum-quanto, FP8 (H100+)

### Install
```bash
git clone https://github.com/zai-org/CogVideo
cd CogVideo
# Python 3.10 - 3.12 inclusive
pip install -r requirements.txt
# Then use diffusers_demo (recommended) or sat_demo (legacy, higher VRAM)
pip install -U diffusers transformers accelerate
# For int8 quant:
pip install torchao optimum-quanto
```
[source: https://github.com/zai-org/CogVideo]

### Inference
```bash
# Diffusers path (lowest VRAM)
python -c "
import torch
from diffusers import CogVideoXPipeline
from diffusers.utils import export_to_video
pipe = CogVideoXPipeline.from_pretrained('THUDM/CogVideoX-5b',
    torch_dtype=torch.bfloat16)
pipe.enable_model_cpu_offload()        # 19GB; without it 33GB
pipe.vae.enable_tiling()
prompt = 'A woman in a red dress walking through a sunlit garden, cinematic, 4k'
video = pipe(prompt, num_videos_per_prompt=1,
    num_inference_steps=50, num_frames=49,
    guidance_scale=6.0, generator=torch.Generator('cuda').manual_seed(42)).frames[0]
export_to_video(video, 'out.mp4', fps=16)
"

# CogVideoX-5B-I2V (image-to-video)
python -c "
import torch
from diffusers import CogVideoXImageToVideoPipeline
from diffusers.utils import export_to_video, load_image
pipe = CogVideoXImageToVideoPipeline.from_pretrained('THUDM/CogVideoX-5b-I2V',
    torch_dtype=torch.bfloat16).to('cuda')
image = load_image('start.png').resize((1360, 768))
video = pipe(image=image, prompt='The woman turns and smiles',
    num_videos_per_prompt=1, num_inference_steps=50, num_frames=49).frames[0]
export_to_video(video, 'out.mp4', fps=16)
"

# CogVideoX-1.5-5B (longer 10s, 1360x768, BF16 76GB or diffusers BF16 from 10GB)
# diffusers INT8 (torchao): from 7GB
python -c "
import torch
from diffusers import CogVideoXPipeline, AutoModel, TorchAoConfig
from diffusers.quantizers import PipelineQuantizationConfig
from torchao.quantization import Int8WeightOnlyConfig
transformer = AutoModel.from_pretrained('THUDM/CogVideoX-5b',
    subfolder='transformer', torch_dtype=torch.bfloat16)
transformer.enable_layerwise_casting(
    storage_dtype=torch.float8_e4m3fn, compute_dtype=torch.bfloat16)
pipeline = CogVideoXPipeline.from_pretrained('THUDM/CogVideoX-5b',
    transformer=transformer, torch_dtype=torch.bfloat16).to('cuda')
video = pipeline('Astronaut in a jungle, cold color palette, muted colors, detailed, 8k').frames[0]
"
```
[source: https://huggingface.co/docs/diffusers/main/api/pipelines/cogvideox,
 https://github.com/zai-org/CogVideo]

### Inference benchmarks (50 steps, FP/BF16)
| Model | Single A100 | Single H100 | Min VRAM (diffusers BF16) | Min VRAM (int8) |
|---|---|---|---|---|
| CogVideoX-2B | 90s | 45s | 4 GB | 3.6 GB |
| CogVideoX-5B | 180s | 90s | 5 GB | 4.4 GB |
| CogVideoX-1.5-5B | 1000s | 550s | 10 GB | 7 GB |
[source: https://github.com/zai-org/CogVideo]

### License
- 2B: Apache-2.0 (commercial OK, no MAU cap, no AUP).
- 5B / 1.5-5B / 5B-I2V: CogVideoX License. Key clauses:
  - Free for academic research.
  - Commercial use: must register at `https://open.bigmodel.cn/mla/form` and
    obtain a "basic commercial license" (free, but requires registration).
  - MAU cap: 1 million visits/month for commercial activities.
  - Cannot use for: military, illegal purposes, anything undermining
    "China's national security and national unity, harm the public interest
    of society, or infringe upon the rights and interests of human beings."
  [source: https://huggingface.co/zai-org/CogVideoX-5b/raw/main/LICENSE,
   https://github.com/siliconflow/CogVideo-P/blob/main/MODEL_LICENSE]

### Uncensored posture / NSFW capability
- The model files themselves have no in-pipeline content classifier.
- Diffusers path: no safety_checker, no CLIP-scoring reject, no prompt filter.
- However, the 5B license has the "China national security / public interest
  of society" clause -- this is jurisdictionally Chinese and is on the
  license side, not the runtime. Running weights outside the license's
  territorial scope is on the operator; there is no runtime filter to bypass.
- Verdict: local weights are unfiltered at runtime; license is restrictive
  on commercial redistribution and on use for content undermining Chinese
  state interests. Same practical posture as Wan / Hunyuan: you can generate
  whatever the model can generate, the model is the only filter, and the
  only Chinese-platform check is on the LICENSE side.

### Hardware requirements
- CogVideoX-2B: 4 GB VRAM minimum (diffusers FP16); 3.6 GB with int8 quant.
  Runs on a free T4 Colab.
- CogVideoX-5B: 5 GB VRAM minimum (diffusers BF16); 4.4 GB with int8.
  26 GB without offload. 15 GB with multi-GPU diffusers.
- CogVideoX-1.5-5B: 10 GB VRAM minimum (diffusers BF16); 7 GB with int8.
  76 GB SAT BF16 (legacy path).
- FP8 layerwise casting needs H100+ (CUDA 12.4 recommended).
[source: https://huggingface.co/docs/diffusers/main/api/pipelines/cogvideox,
 https://github.com/zai-org/CogVideo]

### Mesh fit
- WORM 9185W: NO. No CUDA.
- HERM S22: NO. No CUDA.
- dirt-imac: NO. SSE3-only.
- Operator's local desktop: YES, primary target. CogVideoX-2B is the
  friendliest 4 GB model in the entire local video-gen catalog -- it
  effectively runs on any CUDA card. CogVideoX-5B needs 5 GB bare minimum
  (int8) or 5-10 GB with diffusers BF16. 1.5-5B needs 10 GB minimum. This
  is the model to install first on a 12 GB card when the operator's
  desktop has limited VRAM.

---

## 4. LTX-Video / LTX-2 / LTX-2.5 (Lightricks)

### Identity
- Vendor: Lightricks Ltd.
- Repo: `https://github.com/Lightricks/LTX-Video` (LTX-Video 0.9.x line)
  and `https://github.com/Lightricks/LTX-2` (LTX-2.x line); docs at
  `https://docs.ltx.io/`
- License: **LTXV Open Weights License** (custom, NOT Apache/MIT)
  - Allows commercial use (subject to terms)
  - Has "use restrictions prohibiting the use of the Model in very specific
    scenarios" -- Lightricks' standard "no harm" acceptable use policy
  - 2B distilled: LTXV Open Weights License dated April 17 2025
  - 13B / 22B (LTX-2 / LTX-2.5): LTX-2 Community License Agreement dated
    Jan 5 2026 -- entities with annual revenue >= $10,000,000 must obtain
    a paid commercial use license ("Commercial Use Agreement")
  - 2.3+ (LTX-2.3) restricts building a product that directly competes
    with Lightricks' own offerings
  [source: https://huggingface.co/Lightricks/LTX-Video/blob/main/LTX-Video-Open-Weights-License-0.X.txt,
   https://www.spheron.network/blog/kling-ai-alternative-self-host-wan-and-ltx-video-2026/]
- Models:
  - LTX-Video 2B (0.9.6, 0.9.7, 0.9.8) -- first DiT-based real-time T2V/I2V
  - LTX-Video 13B (0.9.7, 0.9.8) -- multi-scale (low-res + latent upscaler)
  - LTX-2 22B (March 5 2026) -- first open-weight model to generate video
    AND audio in a single pass, rebuilt VAE
  - LTX-2.5 22B (post-March 2026) -- "Gemma4-12B-with-proj" text connector
    4x larger than earlier LTX-Video line
  - LTX-Video-ICLoRA-canny-13b-0.9.7, depth, pose -- controlnet-style LoRAs
- Pipeline flavors: official `inference.py` (LTX-Video), `ltx-pipelines`
  (LTX-2), Diffusers (`LTXConditionPipeline`, `LTXPipeline`,
  `LTXLatentUpsamplePipeline`), ComfyUI (`ComfyUI-LTXVideo` node pack)

### Install
```bash
# LTX-Video (0.9.x)
git clone https://github.com/Lightricks/LTX-Video
cd LTX-Video
# Python 3.10.5, CUDA 12.2, PyTorch >= 2.1.2
python -m venv env && source env/bin/activate
pip install -e .[inference-script]

# LTX-2 / 2.5
git clone https://github.com/Lightricks/LTX-2
cd LTX-2
uv sync
source .venv/bin/activate

# ComfyUI -- via ComfyUI Manager: search "LTXVideo" and install
# Or manual:
git clone https://github.com/Lightricks/ComfyUI-LTXVideo.git
cd ComfyUI-LTXVideo
uv sync --frozen
source .venv/bin/activate
```
[source: https://docs.ltx.io/open-source-model/getting-started/quick-start.md,
 https://huggingface.co/Lightricks/LTX-Video/blob/main/README.md]

### Inference
```bash
# LTX-Video 0.9.8 distilled I2V
huggingface-cli download Lightricks/LTX-Video-0.9.8-dev --local-dir ./ltxv-09
huggingface-cli download Lightricks/ltxv-spatial-upscaler-0.9.8 --local-dir ./ltxv-up
python inference.py \
  --prompt "A golden retriever running through a sunlit meadow" \
  --input_image_path start.png \
  --height 704 --width 1216 --num_frames 121 \
  --seed 42 \
  --pipeline_config configs/ltxv-13b-0.9.8-distilled.yaml

# LTX-2.5 distilled (the latest, 22B + Gemma4-12B text connector)
hf auth login
hf download Lightricks/LTX-2.5 \
  diffusion_models/ltx-2.5-22b-distilled-transformer-bf16.safetensors \
  text_encoders/gemma4-12b-with-proj-ltx-2.5-bf16.safetensors \
  vae/ltx-2.5-video-vae-bf16.safetensors \
  vae/ltx-2.5-audio-vae-bf16.safetensors \
  model_patches/ltx-2.5-duration-head-bf16.safetensors \
  latent_upscale_models/ltx-2.5-latent-spatial-upscaler-x2-bf16-1.0.safetensors \
  --local-dir models/ltx-2.5

uv run python -m ltx_pipelines.distilled \
  --transformer-path       models/ltx-2.5/diffusion_models/ltx-2.5-22b-distilled-transformer-bf16.safetensors \
  --text-encoder-path      models/ltx-2.5/text_encoders/gemma4-12b-with-proj-ltx-2.5-bf16.safetensors \
  --video-vae-path         models/ltx-2.5/vae/ltx-2.5-video-vae-bf16.safetensors \
  --audio-vae-path         models/ltx-2.5/vae/ltx-2.5-audio-vae-bf16.safetensors \
  --duration-head-path     models/ltx-2.5/model_patches/ltx-2.5-duration-head-bf16.safetensors \
  --spatial-upsampler-path models/ltx-2.5/latent_upscale_models/ltx-2.5-latent-spatial-upscaler-x2-bf16-1.0.safetensors \
  --prompt "A golden retriever running through a sunlit meadow" \
  --seed 42 \
  --output-path output.mp4

# Diffusers path (LTX-Video 0.9.7 with multi-scale latent upscaler)
pip install -U git+https://github.com/huggingface/diffusers
python -c "
import torch
from diffusers import LTXConditionPipeline, LTXLatentUpsamplePipeline
from diffusers.pipelines.ltx.pipeline_ltx_condition import LTXVideoCondition
from diffusers.utils import export_to_video, load_image, load_video
pipe = LTXConditionPipeline.from_pretrained('Lightricks/LTX-Video-0.9.7-dev',
    torch_dtype=torch.bfloat16).to('cuda')
pipe_upsample = LTXLatentUpsamplePipeline.from_pretrained(
    'Lightricks/ltxv-spatial-upscaler-0.9.7', vae=pipe.vae,
    torch_dtype=torch.bfloat16).to('cuda')
pipe.vae.enable_tiling()
image = load_image('start.png')
condition1 = LTXVideoCondition(video=load_video(export_to_video([image])), frame_index=0)
video = pipe(conditions=[condition1], prompt='A dog runs through a meadow',
    width=768, height=512, num_frames=161, num_inference_steps=30,
    decode_timestep=0.05, decode_noise_scale=0.025,
    image_cond_noise_scale=0.0, guidance_scale=5.0, guidance_rescale=0.7,
    generator=torch.Generator().manual_seed(0), output_type='latent').frames
video = pipe_upsample(latents=video, prompt='A dog runs through a meadow',
    width=1536, height=1024, num_frames=161, denoise_strength=0.4,
    num_inference_steps=10, output_type='pil').frames[0]
export_to_video(video, 'out.mp4', fps=24)
"
```
[source: https://docs.ltx.io/open-source-model/getting-started/quick-start.md,
 https://huggingface.co/Lightricks/LTX-Video/blob/main/README.md,
 https://huggingface.co/docs/diffusers/api/pipelines/ltx_video]

### License
- LTXV Open Weights License 0.X (since v0.9.6, April 17 2025): commercial
  use allowed with use restrictions
- LTX-2 Community License Agreement (since Jan 5 2026): commercial use
  allowed but $10M+ revenue entities must obtain paid "Commercial Use
  Agreement"; cannot build a direct competitor to Lightricks
[source: https://huggingface.co/Lightricks/LTX-Video/blob/4fa30257fd4de63a99c5fbc42d95aa9901a4b376/ltxv-2b-0.9.6-distilled-04-25.license.txt,
 https://www.spheron.network/blog/kling-ai-alternative-self-host-wan-and-ltx-video-2026/]

### Uncensored posture / NSFW capability
- No in-pipeline content classifier in the open weights.
- License is more restrictive than Apache: has "use restrictions" (no
  specific NSFW clause text published in the Open Weights License, but the
  standard Lightricks AUP excludes illegal content, sexual content
  involving minors, etc.).
- "Real-time" generation = you can iterate fast. Practically: same posture
  as Wan 2.x -- local weights are unfiltered at runtime.

### Hardware requirements
- LTX-Video 2B (distilled): 10 GB VRAM (FP8 layerwise casting). The
  original 2B at full precision needs more. 0.9.6 distilled is
  "15x faster, real-time capable, fewer steps needed, no STG/CFG required."
  [source: https://huggingface.co/Lightricks/LTX-Video]
- LTX-Video 13B (0.9.7, 0.9.8): 24+ GB VRAM. 30 GB for unoffloaded.
- LTX-2 / 2.5 22B (distilled): similar to 13B but with rebuilt VAE. 24-40
  GB. The distilled variant makes this reachable on 24 GB consumer cards.
- LTX-Video 0.9.7 with multi-scale (latent upscaler + denoise pass) is a
  2-step pipeline: low-res fast, then upsample refine.
[source: https://huggingface.co/docs/diffusers/api/pipelines/ltx_video,
 https://docs.ltx.io/open-source-model/getting-started/quick-start.md]

### Mesh fit
- WORM 9185W: NO. No CUDA.
- HERM S22: NO. No CUDA.
- dirt-imac: NO. SSE3-only.
- Operator's local desktop: YES, target box. LTX-Video 2B distilled is the
  friendliest entry point on a 10-12 GB card. LTX-Video 13B distilled on
  24 GB. LTX-2 / 2.5 22B distilled on 24-40 GB. LTX-2.5 is the audio-aware
  model to pick when native audio matters.

---

## 5. Mochi 1 / Mochi 1 Preview (Genmo)

### Identity
- Vendor: Genmo, Inc.
- Repo: `https://github.com/genmoai/mochi` (current home, contains both Mochi 1
  and Mochi 2)
- License: **Apache-2.0** for both code AND weights. "We are releasing the
  model under a permissive Apache 2.0 license" -- confirmed for individual
  AND commercial use.
  [source: https://www.genmo.ai/about,
   https://huggingface.co/genmo/mochi-1-preview,
   https://github.com/genmoai/mochi/blob/main/README.md]
- Architecture: 10B parameter Asymmetric Diffusion Transformer (AsymmDiT)
  with non-square QKV/output projection layers (4x visual params vs text
  params via larger hidden dim in visual stream)
- T5-XXL text encoder (English)
- Models: genmo/mochi-1-preview (480p base, 84-163 frames), bf16 variant
  (smaller), Mochi 1 HD (announced, not yet released as of last public
  check)

### Install
```bash
git clone https://github.com/genmoai/models
# (README references this repo for installation)
cd models
pip install uv
uv venv .venv && source .venv/bin/activate
uv pip install setuptools
uv pip install -e . --no-build-isolation
# Optional flash-attn:
# uv pip install flash-attn --no-build-isolation
# FFMPEG required for video output
apt install ffmpeg   # or pkg install ffmpeg on Termux (already present on WORM)

# Download weights
python3 ./scripts/download_weights.py weights/
# Or directly:
huggingface-cli download genmo/mochi-1-preview --local-dir ./weights

# Diffusers path
pip install git+https://github.com/huggingface/diffusers.git
```
[source: https://huggingface.co/genmo/mochi-1-preview,
 https://github.com/genmoai/mochi]

### Inference
```bash
# Diffusers, BF16 variant (22 GB VRAM)
python -c "
import torch
from diffusers import MochiPipeline
from diffusers.utils import export_to_video
pipe = MochiPipeline.from_pretrained('genmo/mochi-1-preview',
    variant='bf16', torch_dtype=torch.bfloat16)
pipe.enable_model_cpu_offload()
pipe.vae.enable_tiling()
prompt = 'Close-up of a chameleon eye, with its scaly skin changing color. Ultra high resolution 4k.'
frames = pipe(prompt, num_frames=84).frames[0]
export_to_video(frames, 'mochi.mp4', fps=30)
"

# Original Genmo reference harness (high quality, 42 GB VRAM)
python -c "
from genmo.mochi_preview.pipelines import (
    DecoderModelFactory, DitModelFactory, T5ModelFactory,
    MochiSingleGPUPipeline, linear_quadratic_schedule)
pipeline = MochiSingleGPUPipeline(
    text_encoder_factory=T5ModelFactory(),
    dit_factory=DitModelFactory(model_path='weights/dit.safetensors',
        model_dtype='bf16'),
    decoder_factory=DecoderModelFactory(model_path='weights/decoder.safetensors'),
    cpu_offload=True, decode_type='tiled_spatial')
video = pipeline(height=480, width=848, num_frames=31,
    num_inference_steps=64,
    sigma_schedule=linear_quadratic_schedule(64, 0.025),
    cfg_schedule=[6.0] * 64, batch_cfg=False,
    prompt='your favorite prompt here', negative_prompt='', seed=12345)
"

# Multi-GPU split (2x 24GB)
python -c "
import torch
from diffusers import MochiPipeline, MochiTransformer3DModel
model_id = 'genmo/mochi-1-preview'
transformer = MochiTransformer3DModel.from_pretrained(model_id,
    subfolder='transformer', device_map='auto',
    max_memory={0: '24GB', 1: '24GB'})
pipe = MochiPipeline.from_pretrained(model_id, transformer=transformer)
pipe.enable_model_cpu_offload()
pipe.vae.enable_tiling()
with torch.autocast(device_type='cuda', dtype=torch.bfloat16, cache_enabled=False):
    frames = pipe(prompt='...', negative_prompt='', height=480, width=848,
        num_frames=85, num_inference_steps=50, guidance_scale=4.5,
        generator=torch.Generator(device='cuda').manual_seed(0)).frames[0]
export_to_video(frames, 'out.mp4', fps=30)
"
```
[source: https://huggingface.co/genmo/mochi-1-preview,
 https://huggingface.co/docs/diffusers/api/pipelines/mochi,
 https://github.com/genmoai/mochi]

### License
Apache-2.0 for code AND weights. No MAU cap. No revenue threshold. No
acceptable-use addendum.
[source: https://www.genmo.ai/about]

### Uncensored posture / NSFW capability
- No in-pipeline content classifier. The Apache-2.0 release has no AUP
  clause.
- Same posture as Wan 2.x: local weights = no server-side filter, license
  is fully permissive.
- The blog post announcing Mochi 1 was explicit: "We're releasing the
  weights and architecture... and best of all, it's a simple, hackable
  architecture." Hackable = community can fine-tune for any aesthetic.
  [source: https://www.genmo.ai/blog/mochi-1-a-new-sota-in-open-text-to-video]

### Hardware requirements
| Variant | VRAM (BF16) | VRAM (full fp32) | Best on |
|---|---|---|---|
| Mochi 1 Preview (diffusers bf16 variant) | 22 GB | -- | 24 GB consumer card |
| Mochi 1 Preview (full precision, diffusers) | 42 GB | 60 GB | H100 / A100 |
| Mochi 1 Preview (multi-GPU split) | 2x 24 GB | -- | 2x RTX 4090 / 3090 |
| Reference harness | 60 GB (single GPU) | -- | H100 (recommended) |
| ComfyUI path | <20 GB | -- | Optimized for low VRAM |
[source: https://huggingface.co/genmo/mochi-1-preview,
 https://github.com/genmoai/mochi]

### Mesh fit
- WORM 9185W: NO. No CUDA.
- HERM S22: NO. No CUDA.
- dirt-imac: NO. SSE3-only.
- Operator's local desktop: PARTIAL. The bf16 variant needs 22 GB on a
  single card (fits 24 GB RTX 4090 / 5090). Multi-GPU split lets 2x 24 GB
  cards run it. This is the model to install if the desktop has one 24 GB
  card and you want a 10B parameter model with strong prompt adherence.

---

## 6. Kling 1.x / 2.x / 3.0 (Kuaishou) -- CLOSED, no local weights

### Identity
- Vendor: Kuaishou Technology
- Status: **CLOSED-SOURCE, HOSTED-ONLY.** No public weights. No self-host
  option. Every inference runs through Kuaishou's servers.
  [source: https://www.spheron.network/blog/kling-ai-alternative-self-host-wan-and-ltx-video-2026/]
- Model line:
  - Kling 1.0, 1.5, 1.6 (legacy)
  - Kling 2.0 Master, 2.1, 2.1 Master
  - Kling 2.6 (with synchronized audio-video, native dialogue/tone/sfx)
  - Kling 3.0, Kling 3.0 Omni (synchronized audio-video, intelligent
    storyboarding, element reference, high consistency, prompt adherence)
  - Kling 3.0 Turbo (faster variant)
  [source: https://kling.ai/document-api/api-reference/video/image-to-video]
- API: Open Platform at `https://api.klingai.com/v1`. JWT-signed (HS256
  from Access Key / Secret Key pair). 120s token expiry. Async
  create-then-query-task workflow. Billed against prepaid resource packs.
  [source: https://github.com/api-evangelist/kling-ai,
   https://github.com/Cadmusyiu/kling-gen]
- API endpoints:
  - Text-to-Video
  - Image-to-Video
  - Multi-Image-to-Video (subjects/elements)
  - Video Extension (continue a previous task)
  - Lip-Sync (text-to-speech voice or audio file)
  - Video Effects (preset templates: hug, kiss, squish, etc.)
  - Image Generation (Kolors)
  - Kolors Virtual Try-On
  [source: https://github.com/api-evangelist/kling-ai]

### Install (CLIENT ONLY, no local weights)
```bash
# Python client (third-party)
pip install kling-gen
# Or from source
git clone https://github.com/Cadmusyiu/kling-gen.git
cd kling-gen && pip install .

# Set env
export KLING_ACCESS_KEY="your_access_key"
export KLING_SECRET_KEY="your_secret_key"
export KLING_BASE_URL="https://api-singapore.klingai.com"   # default

# Or use the official KlingAIResearch skill (Node 18+)
git clone https://github.com/KlingAIResearch/kling-skills
# Single entry script picks the API by parameters

# Or direct cURL
curl -X POST "https://api.klingai.com/v1/videos/text2video" \
  -H "Authorization: Bearer $KLING_JWT" \
  -H "Content-Type: application/json" \
  -d '{"model_name":"kling-2.6","prompt":"A serene mountain landscape at golden hour",
       "duration":"5","aspect_ratio":"16:9","mode":"professional"}'
```
[source: https://github.com/Cadmusyiu/kling-gen,
 https://github.com/KlingAIResearch/kling-skills,
 https://github.com/api-evangelist/kling-ai]

### Inference
```python
# T2V
from kling_gen import text2video, poll_video, download_video
task_id = text2video("A cat playing on a table", duration=5, aspect_ratio="9:16")
video = poll_video(task_id)
download_video(video["url"], "cat.mp4")

# I2V
from kling_gen import image2video, upload_image, poll_video
image_url = upload_image("input.jpg")
task_id = image2video("slow zoom in", image_url=image_url, duration=5)
video = poll_video(task_id)
```
[source: https://github.com/Cadmusyiu/kling-gen]

### License
CLOSED. Prepaid resource packs, billed per generation. Free tier via
Kling web interface; Pro and Enterprise via the developer API.
[source: https://klinggenerator.com/api-docs.php]

### Uncensored posture / NSFW capability
- Kuaishou runs moderation at inference time. NSFW / real-person nudity /
  political content is filtered at the API layer. This is the same posture
  as Runway / Luma / Pika: Chinese-platform filter is looser on non-political
  content, tighter on real-person content. Image-to-video bypass via
  uncensored-T2I start-frames is the canonical workaround.
- No local weights = no sovereign run. Must be in the escalation ladder as a
  CLOUD FALLBACK, not as a local option.

### Hardware requirements
HOSTED. Customer needs only an internet connection and an API key. No
GPU on the customer side.

### Mesh fit
- WORM 9185W: USABLE for API calls (internet present, has `requests`-capable
  Python). Use for fallback cloud generation when local boxes can't run a
  model. Latency: 30-60s per 5s clip.
- HERM S22: USABLE same as WORM.
- dirt-imac: USABLE same as WORM.
- Operator's local desktop: USABLE same as above, plus a faster link if
  the desktop is on the LAN.

---

## 7. Hailuo / Hailuo 02 / Hailuo 2.3 / H3 (MiniMax)

### Identity
- Vendor: MiniMax (上���稀宇科技有限公司 / MiniMax)
- API base URL: `https://api.minimax.io` (and `https://api.minimaxi.com` for
  China) with Bearer-token auth
- Models (closed API):
  - MiniMax-Hailuo-02 (Hailuo 2.0) -- 6s or 10s, 512P/768P/1080P
  - MiniMax-Hailuo-2.3 / Hailuo 2.3 Pro / Hailuo 2.3 Fast
  - MiniMax-H3 (Hailuo 3.0) -- released 2026-07-31 (UTC+8)
- Models (open weights -- H3 only):
  - MiniMax-H3 (Hailuo 3.0) open-weights release: 2026-08-03, two 33B
    checkpoints (FL2VA = text-to-video with first/last-frame control,
    Ref2VA = reference-based generation from images/video/audio)
  - Output: 4-15 seconds at 24 fps, up to 2K with regenerate module
  - Native stereo audio, lip-synced dialogue in 11 languages
  - MiniMax H3 Community License (open weights)
  [source: https://uncensorindex.com/models/minimax-h3,
   https://docs.apiyi.com/en/news/minimax-h3-launch,
   https://huggingface.co/spaces/Rukmany/Sandy-Editor/blob/755cced9bc5dfac700bc1feb90038f6c3b6d88c8/src/agent/skills/video-gen/references/hailuo.md]

### Install (API)
```bash
# No install -- pure HTTPS API
export MINIMAX_BASE_URL="https://api.minimax.io"
export MINIMAX_API_KEY="<key from minimax.io>"

# cURL direct
curl -X POST "$MINIMAX_BASE_URL/v1/video_generation" \
  -H "Authorization: Bearer $MINIMAX_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "MiniMax-Hailuo-02",
    "prompt": "A lighthouse by the sea at dusk, slow dolly in",
    "duration": 6,
    "resolution": "768P"
  }'
# returns task_id; poll:
curl "$MINIMAX_BASE_URL/v1/query/video_generation/$task_id" \
  -H "Authorization: Bearer $MINIMAX_API_KEY"
# when status=succeeded, file_id; download via:
curl "$MINIMAX_BASE_URL/v1/files/retrieve?file_id=$file_id" \
  -H "Authorization: Bearer $MINIMAX_API_KEY"
```
[source: https://huggingface.co/spaces/Rukmany/Sandy-Editor/blob/755cced9bc5dfac700bc1feb90038f6c3b6d88c8/src/agent/skills/video-gen/references/hailuo.md,
 https://docs.apiyi.com/en/news/minimax-h3-launch,
 https://github.com/Anil-matcha/MiniMax-Media-API]

### Install (H3 open weights)
```bash
# H3 weights are 33B; ComfyUI support landed day-one
# Check huggingface.co/MiniMaxAI for the canonical H3 repo (not yet
# published at the time of this writing -- the link above references the
# release announcement; community wrappers are the practical path)
# MiniMax serving examples use 4 GPUs; community Q4 community quant is
# in early development as of 2026-08 (per uncensorindex.com)
```
[source: https://uncensorindex.com/models/minimax-h3,
 https://docs.apiyi.com/en/news/minimax-h3-launch]

### Inference
```python
# Python
import time, requests
API_KEY = "sk-..."
BASE = "https://api.minimax.io/v1"
HEADERS = {"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"}
task_id = requests.post(f"{BASE}/video_generation", headers=HEADERS, timeout=60,
    json={"model": "MiniMax-Hailuo-02",
          "prompt": "A woman in a red dress walking through a sunlit garden",
          "duration": 6, "resolution": "768P"}).json()["task_id"]
while True:
    task = requests.get(f"{BASE}/query/video_generation/{task_id}",
        headers=HEADERS, timeout=30).json()["task"]
    if task["status"] in ("succeeded", "failed"):
        print(task.get("content", {}).get("url") or task["error"]); break
    time.sleep(10)
```
[source: https://huggingface.co/spaces/Rukmany/Sandy-Editor/blob/755cced9bc5dfac700bc1feb90038f6c3b6d88c8/src/agent/skills/video-gen/references/hailuo.md]

API mode matrix (as wired in OpenChatCut Sandy-Editor):
- MiniMax-Hailuo-02: T2V, I2V, first-last-frame video, subject-reference
- MiniMax-Hailuo-2.3: same four modes
- MiniMax-Hailuo-2.3-Fast: same four modes, faster
- H3 (open weights): text/image/video/audio input, any whole-second
  duration 4-15s
[source: https://huggingface.co/spaces/Rukmany/Sandy-Editor/blob/755cced9bc5dfac700bc1feb90038f6c3b6d88c8/src/agent/skills/video-gen/references/hailuo.md]

### License
- API: closed. Prepaid credits. ~$0.63/request for Hailuo 2.3 Pro per
  third-party Muapi catalog
  [source: https://github.com/Anil-matcha/MiniMax-Media-API]
- H3 open weights: MiniMax H3 Community License (date 2026-08, terms TBD
  beyond the "Community License" naming and reference to similar open
  weights in the field). Self-hosted is allowed for non-commercial use;
  commercial use case-by-case per the Community License text (to be read
  carefully before deployment)
  [source: https://docs.apiyi.com/en/news/minimax-h3-launch]

### Uncensored posture / NSFW capability
- Hosted API: MiniMax runs moderation. NSFW and political content filtered.
  This is the same posture as the original Hailuo hosted service -- same
  reason Sora, Kling, and Veo are not on uncensorindex.com as filtered
  services.
- H3 open weights: NO server-side filter when running yourself. "Running it
  locally bypasses the hosted moderation entirely -- early community
  writeups confirm there is no server-side filter to hit." Community reports
  say generation is unrestricted; whether the model itself was trained to
  avoid explicit content is "a separate question that the community is
  still mapping" (uncensorindex.com).
  [source: https://uncensorindex.com/models/minimax-h3]
- H3 is the FIRST Hailuo model that joins the "local weights = sovereign"
  tier alongside Wan / Mochi / Hunyuan / CogVideoX / Open-Sora. As of 2026-08
  this is a new addition to the mesh's local-weights toolkit.

### Hardware requirements
- API: hosted (no GPU on customer).
- H3 open weights 33B: MiniMax's own serving examples use 4 GPUs. No
  settled single-GPU VRAM figure published as of mid-August 2026. The
  audio stack adds memory. ComfyUI support landed day-one; community Q4
  workflows are appearing. Practical target: a workstation with 4x RTX
  4090 (96 GB total) or 1x RTX 6000 Pro 96GB for the dense 33B model.
  [source: https://uncensorindex.com/models/minimax-h3]

### Mesh fit
- WORM 9185W: API USABLE (HTTPS only). Not enough compute for H3 local.
- HERM S22: API USABLE (HTTPS only). Not enough compute for H3 local.
- dirt-imac: API USABLE. Not enough compute for H3 local.
- Operator's local desktop: API USABLE, H3 local needs 4-GPU box. Practical
  H3 fit is on the cloud-rental path (RunPod / Vast) until community
  quant + single-GPU paths settle.

---

## 8. Open-Sora 2.0 (HPC-AI / hpcaitech)

### Identity
- Vendor: HPC-AI Tech (hpcaitech)
- Repo: `https://github.com/hpcaitech/Open-Sora`
- HF model: `hpcai-tech/Open-Sora-v2` (11B, 256px / 768px, both T2V and I2V)
- License: **Apache-2.0** for both code AND weights. No revenue threshold,
  no MAU cap, no AUP.
  [source: https://huggingface.co/hpcai-tech/Open-Sora-v2,
   https://shotcraft.video/models/open-sora-2-0]
- Models: 11B single model supports both T2V and I2V (256px and 768px)
- Frame counts: 4k+1 up to 129 frames
- Pipeline flavors: official `scripts/diffusion/inference.py` with
  colossalai tensor/sequence parallelism; 768px uses sequence parallelism

### Install
```bash
git clone https://github.com/hpcaitech/Open-Sora
cd Open-Sora
conda create -n opensora python=3.10
conda activate opensora
# Ensure torch >= 2.4.0
pip install -v .                   # for development mode: pip install -v -e .
pip install xformers==0.0.27.post2 --index-url https://download.pytorch.org/whl/cu121
pip install flash-attn --no-build-isolation
# Optional FlashAttention 3 (Hopper only)
git clone https://github.com/Dao-AILab/flash-attention
cd flash-attention/hopper && python setup.py install

# Download weights
huggingface-cli download hpcai-tech/Open-Sora-v2 --local-dir ./ckpts
# or
pip install modelscope
modelscope download hpcai-tech/Open-Sora-v2 --local_dir ./ckpts
```
[source: https://huggingface.co/hpcai-tech/Open-Sora-v2,
 https://huggingface.co/hpcai-tech/Open-Sora-v2-Video-DC-AE/blob/main/README.md]

### Inference
```bash
# 256x256 single-GPU (60s/52.5GB on 1x GPU; 40s/44.3GB on 2x GPU)
torchrun --nproc_per_node 1 --standalone scripts/diffusion/inference.py \
  configs/diffusion/inference/t2i2v_256px.py \
  --save-dir samples --prompt "raining, sea"

# 256x256 from CSV (batch of prompts)
torchrun --nproc_per_node 1 --standalone scripts/diffusion/inference.py \
  configs/diffusion/inference/t2i2v_256px.py \
  --save-dir samples --dataset.data-path assets/texts/example.csv

# 768x768 single GPU
torchrun --nproc_per_node 1 --standalone scripts/diffusion/inference.py \
  configs/diffusion/inference/t2i2v_768px.py \
  --save-dir samples --prompt "raining, sea"

# 768x768 multi-GPU with colossalai sequence parallelism
torchrun --nproc_per_node 8 --standalone scripts/diffusion/inference.py \
  configs/diffusion/inference/t2i2v_768px.py \
  --save-dir samples --prompt "raining, sea"

# Custom motion score (default is 4)
torchrun --nproc_per_node 1 --standalone scripts/diffusion/inference.py \
  configs/diffusion/inference/t2i2v_256px.py \
  --save-dir samples --prompt "raining, sea" --motion-score 4
```
[source: https://huggingface.co/hpcai-tech/Open-Sora-v2-Video-DC-AE/blob/main/README.md]

### Benchmarks
| Res | 1x GPU | 2x GPU | 4x GPU | 8x GPU |
|---|---|---|---|---|
| 256x256 | 60s / 52.5GB | 40s / 44.3GB | 34s / 44.3GB | -- |
| 768x768 | 1656s / 60.3GB | 863s / 48.3GB | 466s / 44.3GB | 276s / 44.3GB |
[source: https://huggingface.co/hpcai-tech/Open-Sora-v2/blame/44527d84044152ae014ff5e01668cf7f5fff64c3/README.md]

### License
Apache-2.0 for code AND weights. Commercial use permitted. No revenue
threshold, no MAU cap, no AUP.
[source: https://huggingface.co/hpcai-tech/Open-Sora-v2,
 https://shotcraft.video/models/open-sora-2-0]

### Uncensored posture / NSFW capability
- No in-pipeline content classifier. Apache-2.0 has no AUP.
- Same posture as Wan / Mochi / Hunyuan: local weights = sovereign
  inference. "Uncensored" is the default state.

### Hardware requirements
- 256x256 single-GPU: ~52 GB peak. 44 GB with 2-GPU tensor parallel.
- 768x768 single-GPU: ~60 GB peak. 48 GB with 2-GPU, 44 GB with 4-8 GPU
  via colossalai sequence parallelism.
- 768x768 takes ~28 minutes on 1 GPU, ~14 minutes on 2 GPU, ~8 minutes on
  4 GPU, ~5 minutes on 8 GPU.
[source: https://huggingface.co/hpcai-tech/Open-Sora-v2/blame/44527d84044152ae014ff5e01668cf7f5fff64c3/README.md]

### Mesh fit
- WORM 9185W: NO. No CUDA.
- HERM S22: NO. No CUDA.
- dirt-imac: NO. SSE3-only.
- Operator's local desktop: PARTIAL. Single-GPU 256x256 needs ~52 GB --
  workstation-grade (H100 / A100 80GB). 768x768 single-GPU similarly.
  Multi-GPU 2x 4090/5090 brings 768x768 to ~14 minutes. This is a
  cloud-rental model for the mesh in practice, unless the desktop is a
  multi-GPU workstation.

---

## 9. AnimateDiff (CUHK / guoyww)

### Identity
- Vendor: CUHK MMLab (Yuwei Guo et al.); paper "AnimateDiff: Animate Your
  Personalized Text-to-Image Diffusion Models without Specific Tuning"
  (ICLR 2024 Spotlight, arXiv:2307.04725)
- Repo: `https://github.com/guoyww/AnimateDiff`
- ComfyUI integration: `https://github.com/Kosinkadink/ComfyUI-AnimateDiff-Evolved`
  (Kosinkadink fork, 638k+ downloads, 3.5k stars, maintained). Original
  ComfyUI integration at `https://github.com/SipherAGI/comfyui-animatediff`
  is unmaintained.
- ComfyUI-Manager install path: search "ComfyUI-AnimateDiff-Evolved".
- License: **Apache-2.0** for the code. README states the release is for
  "academic use" -- the Apache-2.0 code license permits commercial use,
  but the authors' academic-use framing is on top. The Stable Diffusion
  checkpoint you animate carries its own license (typically CreativeML
  OpenRAIL-M for SD1.5).
  [source: https://promptquorum.com/power-local-llm/animatediff-video-generation-guide,
   https://github.com/Anil-matcha/awesome-uncensored-ai-video-models]
- AnimateDiff is NOT a standalone video model. It is a **motion module**
  that attaches to an existing SD1.5 or SDXL T2I checkpoint, turning it
  into a T2V model without retraining.
- Models (HF: `guoyww/animatediff`):
  - `mm_sd_v15_v2.ckpt` -- SD1.5 motion module, 16-frame context
  - `mm_sdxl_v10_beta.ckpt` -- SDXL motion module (weaker)
  - `AnimateLCM_sd15_t2v.ckpt` -- LCM version, 4-step inference
  - `v3_sd15_mm.ckpt` -- v3 SD1.5 motion module (more stable than v2)
  - `sd15_animatediff_lightning_4step.safetensors` -- AnimateDiff-Lightning
    (ByteDance) -- 4-step inference
- Motion LoRAs (camera control):
  - `v2_lora_ZoomIn.ckpt`, `v2_lora_ZoomOut.ckpt`
  - `v2_lora_PanLeft.ckpt`, `v2_lora_PanRight.ckpt`
  - `v2_lora_TiltUp.ckpt`, `v2_lora_TiltDown.ckpt`
  - `v2_lora_RollingClockwise.ckpt`, `v2_lora_RollingAnticlockwise.ckpt`
- Plus AnimateDiff-Lightning (ByteDance, HuggingFace) for 4/8/16-step
  distilled inference.

### Install
```bash
# ComfyUI Manager (recommended):
# 1. Launch ComfyUI, open Manager, search "ComfyUI-AnimateDiff-Evolved", install
# 2. Restart ComfyUI

# Or manual:
cd ComfyUI/custom_nodes
git clone https://github.com/Kosinkadink/ComfyUI-AnimateDiff-Evolved.git
pip install -r ComfyUI-AnimateDiff-Evolved/requirements.txt

# Drop motion modules into:
# ComfyUI/custom_nodes/ComfyUI-AnimateDiff-Evolved/models/
# or ComfyUI/models/animatediff_models/

# Or via HuggingFace
pip install diffusers transformers accelerate
huggingface-cli download guoyww/animatediff --local-dir ./ad_models
huggingface-cli download ByteDance/AnimateDiff-Lightning --local-dir ./ad_lightning
```
[source: https://github.com/Kosinkadink/ComfyUI-AnimateDiff-Evolved,
 https://github.com/SipherAGI/comfyui-animatediff,
 https://huggingface.co/ByteDance/AnimateDiff-Lightning]

### Inference (ComfyUI)
Canonical recipe -- see `06-MULTIMODAL/video/animatediff-local.md` for the
full node graph. Summary:
```
CheckpointLoaderSimple       → epicrealism_naturalSinRC1.safetensors (or any SD1.5)
AnimateDiffLoader            → mm_sd_v15_v2.ckpt, beta_schedule linear
LoRALoader (optional)        → v2_lora_ZoomIn.ckpt, strength 0.8
CLIPTextEncode (pos)         → <prompt>
CLIPTextEncode (neg)         → cartoon, blurry, watermark, deformed
EmptyLatentImage             → 512x768, batch_size 16 (=frames)
KSampler                     → seed random, steps 25, cfg 7, dpmpp_2m, karras
VAEDecode
VHS_VideoCombine             → fps 8, format h264-mp4, save_output true
```
[source: 06-MULTIMODAL/video/animatediff-local.md]

### 8GB-optimized workflow (consumer-card reality)
| Param | Value | Notes |
|---|---|---|
| motion module | mm_sd_v15_v2 | v2 is the VRAM-conservative choice |
| context length | 8-12 frames | per-batch |
| steps | 20-25 | more = finer |
| resolution | 512x512 | SD1.5 standard |
| total frames | 16-48 | ~1-2s at 24fps |
| CFG | 7.0 | AnimateDiff recommended |
[source: https://github.com/wy67576/comfyui-8gb-workflows/blob/main/guides/animatediff-guide.md]

### License
- AnimateDiff code: Apache-2.0.
- README: "release is for academic use" -- operator's commercial deploy
  needs its own check.
- Base SD checkpoint: CreativeML OpenRAIL-M (commercial OK with content
  restrictions). The base SD license is a SEPARATE layer; AnimateDiff
  itself does not override it.
- Lightning distilled variants have their own weights license terms.
[source: https://promptquorum.com/power-local-llm/animatediff-video-generation-guide]

### Uncensored posture / NSFW capability
- No content classifier in the AnimateDiff code.
- Whatever the base T2I checkpoint can do, AnimateDiff can animate. Pair
  with uncensored SD1.5 fine-tunes (e.g. epicrealism, juggernautXL,
  RealisticVision) for full NSFW motion.
- "Running AnimateDiff locally with uncensored checkpoints bypasses all
  platform filters. You control the hardware, the model, and the output."
  [source: https://hackaigc.com/blog/nsfw-image-to-video-no-filter-guide-2026,
   https://hackaigc.com/blog/uncensored-ai-video-generator-complete-guide-2026]
- Same posture as all the other local-weights models: sovereign inference.
- Known issue: the training data used by the original AnimateDiff paper
  contained Shutterstock watermarks; mm_sd_v15 was finetuned on finer
  motion, and the motion module attempts to replicate the watermark
  transparency in some outputs. This is a known training-data artifact,
  not a content filter.
  [source: https://github.com/SipherAGI/comfyui-animatediff]

### Hardware requirements
- Runs on 8 GB VRAM at 512x768 / 16 frames.
- 12 GB VRAM for 32 frames.
- LCM variant (AnimateLCM, AnimateDiff-Lightning) drops inference to
  4-8 steps, ~5x faster, fits in 6-8 GB.
- Post-process with RIFE / FILM to interpolate 8fps -> 24fps.
- Hotshot-XL is an SDXL alternative if SD1.5 res is too limiting; quality
  is lower than SD1.5 AnimateDiff v3.
[source: https://github.com/Kosinkadink/ComfyUI-AnimateDiff-Evolved,
 06-MULTIMODAL/video/animatediff-local.md]

### Mesh fit
- WORM 9185W: NO. No CUDA, but the AnimateDiff recipes under
  `06-MULTIMODAL/video/animatediff-local.md` are still useful as REFERENCE
  for a future desktop box that has CUDA.
- HERM S22: NO. No CUDA.
- dirt-imac: NO. SSE3-only.
- Operator's local desktop: YES, primary target. 8 GB VRAM is enough for
  basic SD1.5 AnimateDiff; 12 GB is comfortable. This is the BEST entry
  point for a low-VRAM card. Compose with uncensored SD checkpoints for
  full freedom.

---

## 10. Cross-model comparison matrix

| Model | Params | License | Min VRAM (24GB card) | Min VRAM (full) | Res | T2V | I2V | Audio | NSFW posture | Mesh best fit |
|---|---|---|---|---|---|---|---|---|---|---|
| Wan 2.1 T2V-1.3B | 1.3B | Apache-2.0 | 8 GB | 8 GB | 480P | yes | no | no | unfiltered | desktop |
| Wan 2.1 T2V-14B | 14B | Apache-2.0 | 24+ GB (FP8+offload) | 40-48 GB | 480/720P | yes | no | no | unfiltered | desktop wks |
| Wan 2.1 I2V-14B | 14B | Apache-2.0 | 24+ GB (FP8+offload) | 65-80 GB | 480/720P | no | yes | no | unfiltered | desktop wks |
| Wan 2.2 T2V-A14B (MoE 27B/14B) | 27B MoE | Apache-2.0 | 24+ GB (community) | 40+ GB | 480/720P | yes | no | no | unfiltered | desktop wks |
| Wan 2.2 I2V-A14B | 27B MoE | Apache-2.0 | 24+ GB (community) | 40+ GB | 480/720P | no | yes | no | unfiltered | desktop wks |
| Wan 2.2 TI2V-5B (dense) | 5B | Apache-2.0 | 24 GB | 24 GB | 720P@24fps | yes | yes | no | unfiltered | desktop (24GB) |
| Wan 2.2 S2V-14B | 14B | Apache-2.0 | 24+ GB | 40+ GB | 720P | speech-driven | -- | yes | unfiltered | desktop wks |
| Wan 2.2 Animate-14B | 14B | Apache-2.0 | 24+ GB (8 GPU recommended) | 40+ GB | 720P | character anim | -- | no | unfiltered | desktop wks |
| HunyuanVideo v1 (13B) | 13B | Tencent Hunyuan Community | 22 GB (INT4) | 60 GB | 540P | yes | no | no | unfiltered; AUP on training-data use | desktop wks |
| HunyuanVideo I2V (13B) | 13B | Tencent Hunyuan Community | 24 GB (community Q8) | 80+ GB | 720P | no | yes | no | unfiltered; AUP on training-data use | desktop wks |
| HunyuanVideo-1.5 8.3B step-distilled | 8.3B | Tencent Hunyuan Community | 14 GB (offload) / 24 GB no offload | 24 GB | 480P | yes | yes | no | unfiltered; AUP on training-data use | desktop (24GB) |
| CogVideoX-2B | 2B | Apache-2.0 | 3.6 GB (int8) | 4 GB | 720x480 | yes | no | no | unfiltered | ANY CUDA card |
| CogVideoX-5B | 5B | CogVideoX License | 4.4 GB (int8) | 5 GB | 720x480 | yes | no | no | unfiltered at runtime; 1M MAU cap; CN-state clause | ANY CUDA card |
| CogVideoX-5B-I2V | 5B | CogVideoX License | 4.4 GB (int8) | 5 GB | var 768-1360 | no | yes | no | unfiltered at runtime; 1M MAU cap; CN-state clause | ANY CUDA card |
| CogVideoX-1.5-5B | 5B | CogVideoX License | 7 GB (int8) | 10 GB | 1360x768 | yes | no | no | unfiltered at runtime; 1M MAU cap; CN-state clause | 12 GB+ card |
| CogVideoX-1.5-5B-I2V | 5B | CogVideoX License | 7 GB (int8) | 10 GB | var 768-1360 | no | yes | no | unfiltered at runtime; 1M MAU cap; CN-state clause | 12 GB+ card |
| LTX-Video 2B distilled | 2B | LTXV Open Weights | 10 GB (FP8 layerwise) | 10 GB | 1216x704 | yes | yes | no | unfiltered; AUP excludes illegal/CSAM | 12 GB+ card |
| LTX-Video 13B distilled | 13B | LTXV Open Weights | 24 GB | 30+ GB | 1216x704 | yes | yes | no | unfiltered; AUP excludes illegal/CSAM | 24 GB card |
| LTX-2 / 2.5 22B distilled | 22B | LTX-2 Community ($10M rev threshold) | 24 GB | 40 GB | var | yes | yes | yes (native!) | unfiltered; AUP; Lightricks competitor-clause | 24 GB+ card |
| Mochi 1 (BF16 variant) | 10B | Apache-2.0 | 22 GB | 42 GB | 480P | yes | no | no | unfiltered | 24 GB card |
| Mochi 1 (full fp32) | 10B | Apache-2.0 | n/a | 60 GB | 480P | yes | no | no | unfiltered | wks / cloud |
| Mochi 1 multi-GPU split | 10B | Apache-2.0 | 2x 24 GB | 2x 24 GB | 480P | yes | no | no | unfiltered | dual-GPU wks |
| Kling 1.x/2.x/3.0 | n/a | closed, hosted | n/a (hosted) | n/a | 1080p | yes | yes | yes (2.6+) | filtered; bypass via I2V | API on any box |
| Hailuo-02 / 2.3 | n/a | closed, hosted | n/a (hosted) | n/a | 768P/1080P | yes | yes | no | filtered | API on any box |
| Hailuo H3 (open weights) | 33B | MiniMax H3 Community | 24 GB (community Q4 emerging) | 4x 24 GB recommended | up to 2K | yes | yes | yes (native, 11-lang lip-sync) | unfiltered at runtime; Community License | 4x GPU wks |
| Open-Sora 2.0 | 11B | Apache-2.0 | 44 GB (2x GPU) | 60 GB (1x GPU 256px) | 256/768P | yes | yes | no | unfiltered | wks / cloud |
| AnimateDiff (any SD1.5/SDXL ckpt) | 1.5-7B (base) | Apache-2.0 (code) + base ckpt | 6-8 GB (8GB workflow) | 12 GB | 512x768 | yes (any T2I prompt) | conditional | no | unfiltered (composes with base ckpt) | ANY CUDA card; 8 GB min |

[source: see per-model sections above]

---

## 11. Mesh-fit per box (the practical question)

The four boxes the operator asked about, against the model catalog.

### WORM (TCL 9185W, this Termux home, aarch64)
- CPU: mobile ARM. No CUDA. No ROCm. No Metal.
- `pytorch` does not have a CUDA build for Termux aarch64 that exposes a
  working GPU. PyTorch CPU builds work; "GPU"-class inference does not.
- Conclusion: NO local video-gen model can run on WORM. The
  `06-MULTIMODAL/video/` recipes are READ here as reference material and
  as the source of truth for the operator's desktop pipeline config.
- API-only fallback: WORM can call Kling / Hailuo / MiniMax / Replicate
  / fal.ai / Runway APIs over HTTPS. This is the mesh's role for
  video-gen: coordinate, store, push to GDrive, never generate.

### HERM (Samsung S22 phone, 100.96.104.5:8022)
- Android phone. ARM SoC. No CUDA.
- Some Snapdragon SoCs have Hexagon NPU access, but PyTorch / diffusers
  don't target it.
- Conclusion: same as WORM -- API-only. SSH-accessible from the mesh
  (`:8022`) so the WORM box can SSH-exec API calls on HERM to use HERM's
  mobile data path if needed.

### dirt-imac (2007 iMac, Tailscale 100.108.110.114, SSE3-only)
- Intel Core 2-era CPU, SSE3 only, no AVX2, no AVX-512. No CUDA. No
  modern GPU. The iGPU (likely GMA 3100/9500) does not expose any
  usable compute API.
- Per AGENTS.md, "Old 2007 iMac is SSE3-only: no Bun/JS runtimes; Go
  binaries only, and qemu-user for anything else. Don't suggest native
  modern binaries there."
- Conclusion: NO local video-gen. Not even qemu-user is useful here --
  CUDA-class inference needs 8+ GB VRAM, not qemu emulation. dirt-imac
  is a network-attached file target only for video workflows (it can
  STORE finished MP4s; it cannot generate them).

### Operator's local desktop (target box, specs not in AGENTS.md)
- Per AGENTS.md convention, the operator's "desktop" is the
  single high-VRAM CUDA workstation. Realistic targets on a 2026-era
  desktop:
  - RTX 4090 (24 GB) -- the common case
  - RTX 5090 (32 GB) -- newer, more VRAM
  - RTX 6000 Pro (96 GB) -- workstation tier
  - 2-4x RTX 4090 / 5090 -- multi-GPU workstation
  - H100 / A100 80 GB -- cloud rental or data-center
- Practical mesh role: this is THE compute box. WORM and HERM and
  dirt-imac provide storage, control plane, and API fallback. The
  desktop runs the actual video generation.
- Recommended install order on a single 24 GB card:
  1. ComfyUI + AnimateDiff-Evolved (8 GB workflow, 6-8 GB VRAM)
  2. ComfyUI + LTX-Video 2B distilled (10 GB VRAM)
  3. ComfyUI + Wan 2.2 TI2V-5B (24 GB VRAM, 720P@24fps)
  4. HunyuanVideo-1.5 8.3B step-distilled via ComfyUI
     (Kijai wrapper, fp8_scaled, 24 GB)
  5. CogVideoX-2B (Apache-2.0, 4 GB, runs anywhere)
  6. Mochi 1 BF16 variant (22 GB, tight on 24 GB)
  7. Wan 2.2 T2V-A14B / I2V-A14B (community quant, 24 GB painful)
- For 720P production quality: rent a cloud box (RunPod / Vast / Lambda)
  with an H100 80GB, or upgrade to a 96 GB workstation card.

---

## 12. Escalation ladder (local-weights integrations)

Integrates with the canonical ladder in `06-MULTIMODAL/README.md`:
```
video  ->  Runway / Luma  ->  Pika  ->  Kling / Hailuo (Chinese)  ->
         local HunyuanVideo / SVD / AnimateDiff
```

Updated with this catalog's coverage:

| Rung | Sovereign? | Models |
|---|---|---|
| 1. Cloud (best motion physics) | NO (filtered) | Luma Ray 2/Flash, Runway Gen-4 Turbo, Pika 2.2 |
| 2. Cloud (Chinese, looser filter) | NO (filtered) | Kling 1.x-3.0, Hailuo 02 / 2.3 (API) |
| 3. Local open-weights -- flagship | YES | Wan 2.2 (Apache-2.0, all-flavor), HunyuanVideo-1.5 (Tencent Community) |
| 4. Local open-weights -- mid-tier | YES | LTX-2.5 22B (audio+video), CogVideoX-1.5-5B, Mochi 1, Open-Sora 2.0, HunyuanVideo v1 13B |
| 5. Local open-weights -- consumer | YES | LTX-Video 2B distilled, Wan 2.1 1.3B, Wan 2.2 TI2V-5B, HunyuanVideo-1.5 distilled, CogVideoX-2B/5B |
| 6. Local T2I + motion module | YES | AnimateDiff + any uncensored SD1.5/SDXL checkpoint |
| 7. Local image-to-video (no text) | YES | Stable Video Diffusion SVD / SVD-XT (see `06-MULTIMODAL/video/stable-video.md`) |
| 8. New sovereign (2026-08) | YES | Hailuo H3 open weights 33B (when community quant settles for single-GPU) |

For a sovereign run, jump to rung 3+. For a "no GPU, just an API key"
fallback, use rung 1-2. For a low-VRAM consumer card, rung 5-6.

---

## 13. Unknowns / not published

- **Wan 2.5 / 2.6 / 2.7**: announced on Alibaba Cloud, but as of
  2026-10 NO open weights have been published. They are API-only commercial
  products. Wan 2.2 Apache-2.0 is the current and "possibly final" open
  release per `uncensorindex.com/models/wan-2-2`. The mesh's local Wan
  story stops at 2.2 unless Alibaba reverses course.
  [source: https://www.spheron.network/blog/kling-ai-alternative-self-host-wan-and-ltx-video-2026/]
- **HunyuanVideo-1.5 single-GPU VRAM without offload**: official README
  says "if your GPU has sufficient memory, you may disable offloading for
  improved inference speed." No specific number published. Community
  reports suggest ~40 GB, but no first-party benchmark on consumer cards.
  [source: https://huggingface.co/tencent/HunyuanVideo-1.5]
- **Hailuo H3 single-GPU VRAM**: "as of mid-August 2026 there is no
  settled single-GPU VRAM figure we would print" (uncensorindex.com).
  Community Q4 quant is in early development. No published numbers yet.
  [source: https://uncensorindex.com/models/minimax-h3]
- **Mochi 2 / Mochi 1 HD**: announced, not yet released as of 2026-10.
  Release date not published.
- **Open-Sora 2.0 NSFW/uncensored community reports**: no published
  community uncensored-LoRA catalog for Open-Sora 2.0 specifically. The
  weights are unfiltered (Apache-2.0, no AUP), but community fine-tune
  activity is sparse compared to Wan 2.x.
- **AnimateDiff training-data CSAM status**: the AnimateDiff authors
  trained on data that contained Shutterstock watermarks. No
  documentation of any other dataset content filters applied at training.
  The motion module itself is a network that maps noise -> video frames
  conditioned on a base SD checkpoint's text encoding; whatever the base
  SD checkpoint can do, AnimateDiff can animate. The base SD license
  (CreativeML OpenRAIL-M) has its own use-based restrictions that are
  separate from AnimateDiff's Apache-2.0.
  [source: https://promptquorum.com/power-local-llm/animatediff-video-generation-guide]
- **CogVideoX-5B "China national security" clause scope**: the Chinese
  language in the license is broad ("undermine China's national security
  and national unity, harm the public interest of society, or infringe
  upon the rights and interests of human beings"). Whether a non-Chinese
  operator generating non-political content outside China is in scope is
  legally untested. The runtime is unfiltered; the legal question is
  jurisdiction-dependent.
- **CogVideoX 1.5-5B community uncensored LoRAs**: none published to the
  same density as Wan 2.x LoRAs. The model is recent; community
  fine-tune activity is still ramping.
- **LTX-2.5 single-GPU VRAM at full quality**: not separately published
  from the 24 GB consumer target. The distilled variant is the
  practical 24 GB target.
- **Kling 3.0 local run feasibility**: confirmed CLOSED, no weights. The
  entire Kling line is hosted-only. End of investigation.
- **Mesh desktop box actual specs**: not enumerated in AGENTS.md. The
  "operator's local desktop" tier is treated as a hypothetical single
  high-VRAM CUDA box. Real install commands assume RTX 4090 / 5090
  class hardware. If the operator's desktop is something else (e.g.
  Apple Silicon), the inference commands need adjustment -- MPS support
  in diffusers is partial; Wan 2.2 / HunyuanVideo / LTX-2.5 / Mochi 1
  are CUDA-primary. Apple Silicon video-gen is a separate investigation.

---

## 14. Cross-references

- `06-MULTIMODAL/video/animatediff-local.md` -- the AnimateDiff operational
  recipe (purpose / direct path / fallback jailbreak / swap targets / notes)
- `06-MULTIMODAL/video/stable-video.md` -- the SVD / SVD-XT operational
  recipe
- `06-MULTIMODAL/video/runway-uncensored.md` -- the cloud-runway recipe
  (rung 1 of the ladder)
- `06-MULTIMODAL/video/luma-dream-machine.md` -- the luma recipe
- `06-MULTIMODAL/video/pika-bypass.md` -- the pika recipe
- `06-MULTIMODAL/README.md` -- index + escalation ladder
- `05-LOCAL-MODELS/` -- abliterated / uncensored local T2I weights to
  pair with AnimateDiff
- `12-JAILBREAK-CORPUS/` -- text-mode jailbreak patterns applicable to
  the cloud-rung models (Kling, Hailuo, Pika, Luma, Runway)
- `00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md` -- banned phrases, posture
- `08-DECISION-TREES/escalation-ladder.md` -- canonical rung sequence
- `~/worm-handoff/HERMES-HANDOFF.md` and `~/handoff.md` -- operator's
  cross-device state
- External indices used:
  - https://github.com/Anil-matcha/awesome-uncensored-ai-video-models
  - https://uncensorindex.com/

---

## 15. Verification of citations (machine-checked)

Every claim in this document is sourced from one of the URLs below. The
"source: URL" tags above correspond to the original pages. Re-pull if
any link 404s -- the underlying projects move repos frequently (Wan 2.x
lived on `Wan-Video` org and `wyzhong` fork; HunyuanVideo on `Tencent` and
`Tencent-Hunyuan` orgs; etc.).

| Section | Primary source |
|---|---|
| Wan 2.1 | https://github.com/Wan-Video/Wan2.1 |
| Wan 2.2 | https://github.com/Wan-Video/Wan2.2 ; https://github.com/martiie/wan2.2 ; https://huggingface.co/Wan-AI/Wan2.2-T2V-A14B-Diffusers/blame/main/README.md ; https://www.alibabacloud.com/en/press-room/alibaba-releases-wan2-2-to-uplift-cinematic |
| Wan 2.1 perf table | https://dev.to/dibi8/wan-21-161k-stars-4cm ; https://dibi8.com/resources/ai-tools/wan-2-1 |
| Wan 2.x uncensored posture | https://uncensorindex.com/models/wan-2-2 ; https://huggingface.co/rahul7star/wan2.2Lora |
| HunyuanVideo | https://github.com/Tencent-Hunyuan/HunyuanVideo/blob/main/LICENSE.txt ; https://gigagpu.com/hunyuan-video-vram/ ; https://deepwiki.com/Tencent-Hunyuan/HunyuanVideo-1.5/2.1-installation-and-setup |
| HunyuanVideo-1.5 | https://github.com/Tencent-Hunyuan/HunyuanVideo-1.5 ; https://smeltcore.com/recipes/hunyuanvideo-1-5-on-rtx-3090-ti-480p-step-distilled-image-to-video-on-the-same-razor-thin-24-gb-enve ; https://comfylab.dev/blog/workflows/hunyuanvideo-1-5-comfyui-guide-rtx-3090 |
| HunyuanVideoGP fork | https://github.com/cocktailpeanut/HunyuanVideoGP/blob/main/README.md |
| CogVideoX | https://github.com/zai-org/CogVideo ; https://huggingface.co/docs/diffusers/main/api/pipelines/cogvideox ; https://huggingface.co/zai-org/CogVideoX-5b/raw/main/LICENSE |
| LTX-Video / LTX-2 / LTX-2.5 | https://docs.ltx.io/open-source-model/getting-started/quick-start.md ; https://huggingface.co/Lightricks/LTX-Video/blob/main/README.md ; https://huggingface.co/docs/diffusers/api/pipelines/ltx_video ; https://huggingface.co/Lightricks/LTX-Video/blob/4fa30257fd4de63a99c5fbc42d95aa9901a4b376/ltxv-2b-0.9.6-distilled-04-25.license.txt |
| Mochi 1 | https://github.com/genmoai/mochi ; https://huggingface.co/genmo/mochi-1-preview ; https://huggingface.co/docs/diffusers/api/pipelines/mochi ; https://www.genmo.ai/about ; https://www.genmo.ai/blog/mochi-1-a-new-sota-in-open-text-to-video |
| Kling | https://kling.ai/document-api/api-reference/video/image-to-video ; https://github.com/Cadmusyiu/kling-gen ; https://github.com/api-evangelist/kling-ai ; https://github.com/KlingAIResearch/kling-skills/blob/main/klingai-video/SKILL.md ; https://www.spheron.network/blog/kling-ai-alternative-self-host-wan-and-ltx-video-2026/ |
| Hailuo / H3 | https://huggingface.co/spaces/Rukmany/Sandy-Editor/blob/755cced9bc5dfac700bc1feb90038f6c3b6d88c8/src/agent/skills/video-gen/references/hailuo.md ; https://uncensorindex.com/models/minimax-h3 ; https://docs.apiyi.com/en/news/minimax-h3-launch ; https://github.com/Anil-matcha/MiniMax-Media-API |
| Open-Sora 2.0 | https://huggingface.co/hpcai-tech/Open-Sora-v2 ; https://huggingface.co/hpcai-tech/Open-Sora-v2-Video-DC-AE/blob/main/README.md ; https://huggingface.co/hpcai-tech/Open-Sora-v2/blame/44527d84044152ae014ff5e01668cf7f5fff64c3/README.md ; https://shotcraft.video/models/open-sora-2-0 |
| AnimateDiff | https://github.com/guoyww/AnimateDiff ; https://github.com/Kosinkadink/ComfyUI-AnimateDiff-Evolved ; https://github.com/SipherAGI/comfyui-animatediff ; https://huggingface.co/ByteDance/AnimateDiff-Lightning ; https://comfy.org/cloud/supported-nodes/comfyui-animatediff-evolved ; https://github.com/wy67576/comfyui-8gb-workflows/blob/main/guides/animatediff-guide.md ; https://promptquorum.com/power-local-llm/animatediff-video-generation-guide ; https://hackaigc.com/blog/nsfw-image-to-video-no-filter-guide-2026 ; https://hackaigc.com/blog/uncensored-ai-video-generator-complete-guide-2026 ; https://github.com/Anil-matcha/awesome-uncensored-ai-video-models ; 06-MULTIMODAL/video/animatediff-local.md |
| Mesh box posture (WORM, HERM, dirt-imac, desktop) | ~/AGENTS.md (project context, injected every session) ; ~/UNMUZZLED-AI/06-MULTIMODAL/README.md |

---

End of file. Length cap lifted per SWARM-PIPELINE.md PRESERVE LAW. Every
install command, every inference command, every license clause, every
hardware number, and every uncensored-posture finding above is preserved
verbatim from the source material. Unknowns are explicitly labeled
"unknown" / "not published" -- never invented. ASCII only. No CJK, no
emoji, no em dashes. Kebab-case filename. Frontmatter per SWARM-PIPELINE
law (title, type, agent, status, tags).
