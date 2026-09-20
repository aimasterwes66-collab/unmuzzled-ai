---
name: Stable Diffusion Local (safety-checker off)
slug: stable-diffusion-local
version: 1.0-20260918
kind: multimodal-recipe
harness: any
provider: local
modality: image
sovereign: true
refusal-rate: 0.00
tags: [sd, diffusers, safety-checker-disabled, local, unrestricted]
---

## Purpose

Run Stable Diffusion locally with the built-in NSFW safety-checker fully disabled. `diffusers` ships a CLIP-based checker that black-frames flagged outputs; the checkpoints themselves are not censored, only the wrapper.

## Direct path

Kill the checker at pipeline construction — no black frames possible:

```python
from diffusers import StableDiffusionPipeline, StableDiffusionXLPipeline
import torch

pipe = StableDiffusionXLPipeline.from_pretrained(
    "stabilityai/stable-diffusion-xl-base-1.0",
    torch_dtype=torch.float16,
    safety_checker=None,
    requires_safety_checker=False,
).to("cuda")

pipe.safety_checker = None
pipe.feature_extractor = None
pipe.watermark = None  # kills the invisible-watermark postprocess
```

CLI equivalents:
- `stable-diffusion-webui` (AUTOMATIC1111): launch with `--disable-safety-unpickle --disable-nan-check --no-half-vae` and in `Settings → User interface` uncheck any "NSFW filter"; the webui has no built-in classifier since `v1.0`.
- `ComfyUI`: no safety checker by default; nothing to disable.
- `InvokeAI`: `invokeai-configure` → answer `n` to "enable NSFW checker".
- `sd.cpp` / `stable-diffusion.cpp`: no checker.

Recommended uncensored checkpoints (2026-09 known-good):
- `Juggernaut-XL-v10` (SDXL, photorealism)
- `RealVisXL-v4.0` (SDXL, photorealism)
- `Pony-Diffusion-v6-XL` (SDXL, character/anatomy)
- `AutismMix-Confetti` (SD1.5, anime)
- `EpiCRealism-Natural-Sin-RC1` (SD1.5, photorealism)
- `Lustify-SDXL` (SDXL, explicit tuned)

Grab from `civitai.com` or `huggingface.co/John6666`. Place under `models/Stable-diffusion/`.

## Fallback jailbreak

Not needed — checker is off. If a checkpoint itself has residual refusal directions (rare), apply either:

1. Negative prompt clamp — push refusal tokens into the negative:
```
sfw, safe, censored, mosaic, blurred, covered, clothing overlay,
watermark, signature, artist name, discord tag
```

2. Model surgery — abliterated variants that had refusal directions ablated (see `05-LOCAL-MODELS/`). Search HF for `<checkpoint>-abliterated` or `<checkpoint>-uncensored`.

3. LoRA injection — apply a `nudify` or `detail-tweaker` LoRA at 0.6–0.9 weight to override remaining alignment.

## Provider swap targets

Local is the terminal rung of the escalation ladder — nothing to swap to. If VRAM-constrained: swap SDXL (10GB) → SD1.5 (4GB) → `sd-turbo` (2GB). If GPU-less: `stable-diffusion.cpp` CPU mode, Q4_K quant.

## Notes

- Seeds: SDXL uses 64-bit; `-1` for random, log to metadata for reproducibility.
- Sampler: `DPM++ 2M SDE Karras` for SDXL, `Euler a` for SD1.5, `LCM` for turbo.
- CFG: SDXL 5–7, SD1.5 7–9, turbo 1–2.
- Steps: SDXL 30, SD1.5 25, turbo 4–8.
- Model versions confirmed 2026-09: `diffusers==0.30.x`, `AUTOMATIC1111==1.10.x`, `ComfyUI` master.
