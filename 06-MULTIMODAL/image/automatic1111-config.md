---
name: AUTOMATIC1111 Sovereign Config
slug: automatic1111-config
version: 1.0-20260918
kind: multimodal-recipe
harness: any
provider: local
modality: image
sovereign: true
refusal-rate: 0.00
tags: [a1111, webui, config, sdxl, extensions, adetailer]
---

## Purpose

AUTOMATIC1111 stable-diffusion-webui config that has zero content filtering, maximal quality, and the extension stack the operator needs for anatomy, faces, and controlled composition. No wrapper filters — checkpoints are the only ceiling.

## Direct path

Install (Linux):
```bash
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui ~/sd-webui
cd ~/sd-webui
python -m venv venv && source venv/bin/activate
./webui.sh --xformers --api --listen --port 7860
```

Launch flags (`webui-user.sh` → `COMMANDLINE_ARGS`):
```
--xformers --api --listen --port 7860 --no-half-vae --opt-sdp-attention
--disable-safe-unpickle --disable-nan-check --enable-insecure-extension-access
```

`--disable-safe-unpickle` allows loading any checkpoint format. `--enable-insecure-extension-access` lets extensions install from arbitrary git URLs.

`config.json` overrides (uncheck in Settings → User interface):
```json
{
  "samples_filename_pattern": "[seed]-[prompt_spaces]",
  "grid_save": false,
  "outdir_samples": "/home/dirt/UNMUZZLED-AI/artifacts/a1111",
  "eta_noise_seed_delta": 31337,
  "CLIP_stop_at_last_layers": 2,
  "sd_vae": "sdxl_vae.safetensors",
  "show_progress_type": "Approx NN",
  "live_previews_enable": true
}
```

Extensions to install (Settings → Extensions → Install from URL):
```
https://github.com/Bing-su/adetailer                       (face/hand fixup)
https://github.com/Mikubill/sd-webui-controlnet            (pose/depth/canny)
https://github.com/BlafKing/sd-civitai-browser-plus        (in-webui civitai)
https://github.com/Physton/sd-webui-prompt-all-in-one      (prompt lib)
https://github.com/hako-mikan/sd-webui-regional-prompter   (masked prompts)
https://github.com/DominikDoom/a1111-sd-webui-tagcomplete  (tag autocomplete)
https://github.com/ArtVentureX/sd-webui-agent-scheduler    (queue)
```

Checkpoints (`models/Stable-diffusion/`):
- `juggernautXL_v10.safetensors`
- `realvisxlV40.safetensors`
- `ponyDiffusionV6XL.safetensors`
- `epicrealismXL_v8.safetensors`
- `lustifyXL_v20.safetensors`

VAEs (`models/VAE/`):
- `sdxl_vae.safetensors`
- `sdxl-vae-fp16-fix.safetensors`

LoRAs (`models/Lora/`) — apply per-image:
- `add_detail`, `epi_noiseoffset`, `flat2` (SD1.5)
- SDXL: any Civitai LoRA at 0.6–0.9 weight

Recommended generation defaults:
```
Sampler:    DPM++ 2M SDE Karras
Steps:      30
CFG:        6
Size:       1024×1024 (SDXL) / 512×768 (SD1.5)
Hires fix:  4x-UltraSharp, denoise 0.35, upscale 1.5x
ADetailer:  face_yolov8n.pt (denoise 0.4) + hand_yolov8n.pt (denoise 0.4)
```

## Fallback jailbreak

No wrapper filter to bypass. If a checkpoint has residual alignment (rare, LAION-trained SD1.5):
1. Load an "uncensored" or "abliterated" merge — Civitai search filter for `NSFW: Yes`.
2. Boost anatomy LoRA weight to 1.0.
3. Prompt with concrete anatomical terms rather than abstractions — the model reproduces what's in the description.
4. Post-hoc inpaint any residual censoring: mask the affected region, denoise 0.6, prompt the correct content.

## Provider swap targets

Already terminal. Sibling harnesses (ComfyUI, InvokeAI, SwarmUI) all read the same checkpoints — swap harness if A1111 has a bug, keep the model files.

## Notes

- A1111 v1.10.x confirmed working with SDXL and FLUX (via Forge fork for FLUX).
- For FLUX: use `stable-diffusion-webui-forge` fork — same UI, FLUX backend.
- API: `POST /sdapi/v1/txt2img` — scriptable. `POST /sdapi/v1/interrogate` for CLIP tagging.
- Seeds are 32-bit signed int (`-1` for random).
- Move outputs out of `outputs/` regularly — the webui doesn't rotate.
