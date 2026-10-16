---
name: Output Watermark and Metadata Removal
slug: watermark-removal
version: 2026-10-15
kind: multimodal-recipe
harness: any
provider: any
modality: image
sovereign: true
tags: [watermark, c2pa, synthid, stable-signature, exif, metadata, provenance, strip]
requires: [image-as-prompt-injection]
---

# Output Watermark and Metadata Removal

Generated media carries provenance marks. For sovereign workflows where
output provenance must not expose tooling, strip what is strippable and
know what is not. Fills GAP-19. Descriptive operational reference.

## 1. What gets embedded

| Mark | Who | Where it lives | Strippable? |
|---|---|---|---|
| C2PA / Content Credentials | Adobe Firefly, MS Designer, DALL-E 3 | JUMBF box in JPEG/PNG/AVIF | yes (box removal) |
| SynthID (image) | Google DeepMind (Imagen/Gemini img) | latent-space watermark in pixels | no practical strip |
| Stable Signature | Meta (Imagine, some SD forks) | latent-space + fine-tuned decoder check | no practical strip |
| EXIF/IPTC/XMP fields | A1111/ComfyUI "parameters", model, prompts, seed | metadata segments | yes |
| invisible-watermark lib | Stable Diffusion A1111 default | frequency-domain in pixels | hard; regenerate on open models |
| Software/hardware tags | PNG tEXt chunks, MP4 moov/udta | chunk/atom level | yes |

## 2. Strip commands

```
# images -- wipe metadata segments + tags (exiftool)
exiftool -all= -overwrite_original in.jpg

# ImageMagick equivalent (rebuilds pixel stream, drops chunks)
convert in.png -strip out.png

# PNG chunk-level (pngcheck + custom, or python):
#   remove tEXt/zTXt/iTXt, keep IDAT/PLTE/IEND

# video/audio -- ffmpeg metadata strip
ffmpeg -i in.mp4 -map_metadata -1 -c copy out.mp4

# C2PA JUMBF box (JPEG APP11 'jumb' marker / PNG caBX chunk):
#   strip with exiftool -JUMBF:all= or python box-walker; verify with
#   c2patool (github.com/contentauth/c2patool) before and after
```

## 3. Honest limits

- C2PA/EXIF: fully removable, verify with `c2patool` / `exiftool`.
- SynthID + Stable Signature: embedded in the diffusion process itself.
  Detection exists (SynthID detector, stable-signature verification),
  removal does not. Do not claim a clean strip -- regenerate on an open
  model that never embedded them (SD local, Flux, CogVideoX, Wan: none
  embed provenance marks by default).
- Re-encode (JPEG q<95, resize) degrades latent marks but is NOT
  guaranteed removal and costs quality. Treat as mitigation, not control.
- The A1111 invisible-watermark can be disabled at the source:
  `--no-half-vae` era forks expose the option; current forks: remove the
  `invisible-watermark` requirement or use a fork without it. Cross-ref
  `06-MULTIMODAL/image/stable-diffusion-local.md`.

## 4. Cross-refs

- Attack-side steganography (inverse use): `06-MULTIMODAL/vision-input/image-as-prompt-injection.md`
- Forensics evasion context: `12-JAILBREAK-CORPUS/CYBERCRIME BIBLE2.md`
- Image recipe files under `06-MULTIMODAL/image/`

## 5. Sources

- c2patool: https://github.com/contentauth/c2patool
- SynthID: deepmind.google (research + Nature paper)
- Stable Signature: Meta AI github.com/facebookresearch/stable_signature
- exiftool: exiftool.org
