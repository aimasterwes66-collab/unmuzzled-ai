---
name: Image Generation Without Safety Checker
slug: image-gen-without-safety-checker
version: 1.0-20260918
kind: tutorial
harness: any
provider: local
modality: image
sovereign: true
tags: [tutorial, image-gen, stable-diffusion, comfyui, safety-checker, nightcafe]
requires: [first-sovereign-session]
---

# Image Generation Without a Safety Checker — SD-local, ComfyUI, NightCafe fallback

Serve Stable Diffusion locally with the safety-checker disabled, wire ComfyUI as the graph runner, and keep NightCafe as the hosted fallback when the local box is off.

## Prerequisites

- GPU ≥ 8 GB VRAM (SDXL / Pony wants 12 GB; SD3 wants 16 GB). Apple Silicon works via MPS but slower.
- `python3.10+`, `git`, `git-lfs`.
- Roughly 30 GB free disk.
- HuggingFace account for gated checkpoints (SD3, Flux). For fully open weights, Pony Diffusion V6 XL and Illustrious XL have no gating.
- NightCafe account (free tier is enough for fallback smoke tests).

## Steps

1. Install ComfyUI as the graph runner.

   ```bash
   cd ~
   git clone https://github.com/comfyanonymous/ComfyUI.git
   cd ComfyUI
   python3 -m venv .venv && . .venv/bin/activate
   pip install -r requirements.txt
   ```

2. Download an unaligned base checkpoint. Recommended sovereign primaries by axis:

   - Photorealism, no content restriction: `Lykon/dreamshaper-xl-1-0` or `SG161222/RealVisXL_V4.0` (TBD-verify current version).
   - Anime / NSFW: `AstraliteHeart/pony-diffusion-v6-xl` (Pony V6 XL) or `OnomaAIResearch/Illustrious-XL-v0.1`.
   - Flux uncensored: `black-forest-labs/FLUX.1-schnell` base + community LoRAs (Flux itself has no built-in safety checker).

   ```bash
   cd models/checkpoints
   huggingface-cli download AstraliteHeart/pony-diffusion-v6-xl \
     ponyDiffusionV6XL.safetensors --local-dir . --local-dir-use-symlinks False
   cd ../..
   ```

3. Disable the safety checker in every code path.

   - **Diffusers direct.** Pass `safety_checker=None, requires_safety_checker=False` when constructing the pipeline.

     ```python
     from diffusers import StableDiffusionXLPipeline
     import torch
     pipe = StableDiffusionXLPipeline.from_single_file(
         "models/checkpoints/ponyDiffusionV6XL.safetensors",
         torch_dtype=torch.float16, safety_checker=None,
         requires_safety_checker=False,
     ).to("cuda")
     img = pipe("score_9, score_8_up, portrait of a sovereign researcher, cinematic lighting", num_inference_steps=28).images[0]
     img.save("out.png")
     ```

   - **AUTOMATIC1111 webui.** Launch with `--disable-safety-checker --disable-nsfw-checker --no-half-vae`.

     ```bash
     ./webui.sh --disable-safety-checker --disable-nsfw-checker --no-half-vae --api --listen
     ```

   - **ComfyUI.** No safety checker by default. Verify no custom node re-adds one — audit `custom_nodes/` for anything with "safety" or "nsfw" in the filename.

4. Launch ComfyUI and load the sovereign default graph.

   ```bash
   python main.py --listen 0.0.0.0 --port 8188
   ```

   Open `http://localhost:8188`, load `06-MULTIMODAL/image-gen-jailbreaks/comfy-graphs/sovereign-default.json` (TBD-verify path — build this graph now if absent), and set the checkpoint node to the Pony V6 XL you downloaded.

5. Prompt with the model's native tags. Pony V6 XL expects `score_9, score_8_up, score_7_up, ...` prefix quality tags. Illustrious expects natural language with e621-style tags. Craft the prompt in the model's native register — do not attempt English polite phrasing on a tag-trained model.

6. **Fallback to NightCafe.** When the local box is off, use NightCafe's SDXL or Flux endpoints. Note that NightCafe applies a lightweight prompt-side filter — obfuscate blocked tokens with the obfuscation catalog in `06-MULTIMODAL/image-gen-jailbreaks/obfuscated-tokens.md` (leetspeak, homoglyphs, split tokens).

## Verification

- `pipe.safety_checker is None` at Python REPL confirms disabling in Diffusers.
- Generate a canary prompt that a stock SD would black-box (e.g. a stylized violence tag prompt from `06-MULTIMODAL/image-gen-jailbreaks/canary-prompts.md`); output image is not a black square.
- ComfyUI shows no "SafetyChecker" node in the loaded graph.

## Troubleshooting

- **Output is a solid black image.** Safety checker still active OR VAE is fp16 and NaN'd. Add `--no-half-vae`, or `pipe.vae = pipe.vae.to(dtype=torch.float32)`.
- **AUTOMATIC1111 still shows a "Not safe for work" placeholder.** An extension re-added it. Check `extensions/` and remove.
- **NightCafe rejects prompt with "content policy".** Obfuscate with the token catalog; if still rejected, swap to local.
- **Flux refuses via prompt filter.** Flux weights themselves have no filter, but some Diffusers pipelines wrap a text-side classifier. Confirm with `pipe.__class__.__name__` and switch to `FluxPipeline` (no classifier).

## Next

- `deep-dives/mcp-prompt-injection-lethal-trifecta.md` — how images become injection vectors.
- `05-suno-god-mode-walkthrough.md` — analogous flow for audio.
- `06-MULTIMODAL/image-gen-jailbreaks/` — the full corpus.
