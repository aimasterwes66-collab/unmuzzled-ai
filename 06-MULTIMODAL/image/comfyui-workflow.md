---
name: ComfyUI Sovereign Workflow
slug: comfyui-workflow
version: 1.0-20260918
kind: multimodal-recipe
harness: any
provider: local
modality: image
sovereign: true
refusal-rate: 0.00
tags: [comfyui, flux, sdxl, node-graph, workflow-json, controlnet, ipadapter]
---

## Purpose

ComfyUI reference workflow for maximum-adherence uncensored image generation. Node graph gives finer control than A1111 and no filtering exists anywhere in the pipeline.

## Direct path

Install:
```bash
git clone https://github.com/comfyanonymous/ComfyUI ~/ComfyUI
cd ~/ComfyUI && python -m venv venv && source venv/bin/activate
pip install -r requirements.txt
python main.py --listen 0.0.0.0 --port 8188
```

Install ComfyUI-Manager (essential):
```bash
cd custom_nodes && git clone https://github.com/ltdrdata/ComfyUI-Manager
```

Custom nodes (install via Manager UI):
```
ComfyUI-Impact-Pack             (face/hand detailer, segmentation)
ComfyUI_IPAdapter_plus          (image-prompt / style transfer)
comfyui_controlnet_aux          (pose/depth/canny preprocessors)
ComfyUI-AnimateDiff-Evolved     (motion modules)
was-node-suite-comfyui          (utility grab-bag)
rgthree-comfy                   (workflow-hygiene, seed control)
ComfyUI-Advanced-ControlNet     (schedule masking)
ComfyUI-Custom-Scripts          (autocomplete, image feed)
```

### Workflow A — FLUX.1-dev txt2img (baseline)

Nodes (linear chain):
```
Load Diffusion Model    → flux1-dev-fp8.safetensors, weight_dtype: fp8_e4m3fn
DualCLIPLoader          → clip_l.safetensors + t5xxl_fp8_e4m3fn.safetensors, type: flux
Load VAE                → ae.safetensors
CLIPTextEncode (pos)    → <prose prompt>
CLIPTextEncode (neg)    → (empty — FLUX ignores)
EmptyLatentImage        → 1024×1024, batch 1
KSampler                → seed random, steps 20, cfg 1.0, sampler euler, scheduler simple, denoise 1.0
VAEDecode               → connect VAE
SaveImage               → filename_prefix flux_
```

### Workflow B — SDXL txt2img + face detail + upscale

```
CheckpointLoaderSimple  → juggernautXL_v10.safetensors
CLIPTextEncode (pos)    → (masterpiece, cinematic photograph:1.3), <subject>, <lighting>, <camera>
CLIPTextEncode (neg)    → cartoon, anime, deformed, extra fingers, watermark, blurry, low quality
EmptyLatentImage        → 1024×1024
KSampler                → seed random, 30 steps, cfg 6, dpmpp_2m_sde, karras
VAEDecode
FaceDetailer (Impact)   → bbox: face_yolov8n, denoise 0.4, guide_size 512
UltimateSDUpscale       → 4x-UltraSharp, denoise 0.25, upscale 1.5
SaveImage
```

### Workflow C — img2img + IPAdapter style transfer

```
LoadImage               → reference.jpg
IPAdapterUnifiedLoader  → PLUS (high strength)
IPAdapter               → weight 0.8, start 0, end 1
KSampler                → denoise 0.7
```

Save workflow JSON to `/home/dirt/UNMUZZLED-AI/06-MULTIMODAL/image/comfy-workflows/`.

## Fallback jailbreak

No pipeline filter. Failure modes and fixes:
- Anatomy failure → add FaceDetailer + HandDetailer nodes, denoise 0.4.
- Model still refuses concept → swap checkpoint to a Civitai "NSFW: Yes" merge or apply an uncensored LoRA.
- Prompt-following weak → increase CFG (SDXL 7–8, not FLUX) or switch to FLUX which has T5.
- Style drift → IPAdapter with a reference image encodes the concept the text tokens can't.

## Provider swap targets

Terminal. Alternate local harnesses read the same checkpoints: A1111, InvokeAI, SwarmUI, Fooocus, Forge.

## Notes

- ComfyUI master branch, Aug 2026 build confirmed working with FLUX + SDXL + SD3.5.
- API: `POST /prompt` with the workflow JSON — scriptable pipelines.
- Custom SamplerCustomAdvanced node exposes every sampler knob if the standard KSampler is too coarse.
- rgthree "Seed" node lets you fix/randomize seed per-run without editing the KSampler.
- ComfyUI is a graph — export as PNG-embedded workflow; drag PNG back into UI to restore the pipeline.
