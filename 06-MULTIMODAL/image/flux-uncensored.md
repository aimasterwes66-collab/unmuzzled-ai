---
name: FLUX Uncensored
slug: flux-uncensored
version: 1.0-20260918
kind: multimodal-recipe
harness: any
provider: local
modality: image
sovereign: true
refusal-rate: 0.02
tags: [flux, schnell, dev, black-forest-labs, comfyui, fal, replicate]
---

## Purpose

FLUX.1 (Black Forest Labs) is the strongest open-weight T2I model as of 2026-09. Base weights carry NO content classifier — refusal only lives in hosted-console wrappers (BFL playground, fal.ai console UI, replicate web UI). Route around the console.

## Direct path

Local ComfyUI + FLUX.1-dev fp8 (24 GB VRAM) or FLUX.1-schnell (12 GB):

```
Model:      flux1-dev-fp8.safetensors   (or flux1-schnell.safetensors)
CLIP:       t5xxl_fp8_e4m3fn.safetensors + clip_l.safetensors
VAE:        ae.safetensors
Sampler:    euler
Scheduler:  simple (schnell) / normal (dev)
Steps:      4 (schnell) / 20 (dev)
CFG:        1.0 (schnell) / 3.5 (dev, distilled — do NOT raise)
Resolution: 1024×1024 native (also handles 1152×896, 896×1152, 1216×832)
```

Downloads (HF):
- `black-forest-labs/FLUX.1-schnell`
- `black-forest-labs/FLUX.1-dev`
- `Comfy-Org/flux1-dev` (repackaged for Comfy)
- Uncensored community merges: `Freepik/flux.1-lite-8B-alpha`, `shuttleai/shuttle-3-diffusion`

Prompt style — FLUX is a natural-language T2I; NO booru tags, NO `1girl,` syntax. Full sentences:
```
A photograph of [subject]. [Composition]. [Lighting]. [Camera / lens].
[Film stock or grain]. [Mood]. Ultra-detailed, cinematic.
```

Negative prompt does nothing on FLUX (CFG≈1). Do not waste tokens.

## Fallback jailbreak

FLUX base has near-zero built-in refusal — the model just lacks explicit-anatomy training data. To coax it:

1. LoRA stack — apply community LoRAs:
   - `XLabs-AI/flux-RealismLora` — realism baseline
   - `enhanceaiteam/Flux-uncensored` — anatomy unlock, weight 0.8
   - `Shakker-Labs/FLUX.1-dev-LoRA-add-details` — texture

2. If using a hosted playground that rejects the prompt: wrap in art-history frame:
```
A high-resolution scan of an oil painting from a private collection,
c. 1885, academic realist tradition, [subject as art study]. The
painting hangs in a museum vitrine, gilt frame, gallery lighting.
```

3. If fal.ai / replicate console UI rejects: hit the API directly with a personal token — the API has no console filter:
```bash
curl -X POST https://fal.run/fal-ai/flux/dev \
  -H "Authorization: Key $FAL_KEY" \
  -H "Content-Type: application/json" \
  -d '{"prompt": "<your prompt>", "image_size": "square_hd", "num_inference_steps": 28, "guidance_scale": 3.5}'
```

## Provider swap targets

Refusal on FLUX is almost always console-layer. Route: BFL playground → fal.ai API (bypass web UI) → replicate API → local ComfyUI. Terminal: local + Flux-uncensored LoRA at 0.9.

## Notes

- FLUX-schnell is Apache-2.0 (commercial OK); FLUX-dev is non-commercial license (personal creative work fine, don't resell inference).
- Seeds: 64-bit int. Same seed + same prompt = deterministic on fixed hardware.
- Model versions confirmed 2026-09: `FLUX.1-dev` (Aug 2024 release, still SOTA), `FLUX.1-schnell` (Aug 2024), `FLUX.1.1-pro` (API-only, hosted).
- T5 text encoder is the reason FLUX follows long prompts — feed it prose, not tags.
