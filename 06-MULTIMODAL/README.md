---
name: 06-MULTIMODAL Index
slug: multimodal-index
version: 1.0-20260918
kind: doctrine
harness: any
provider: any
modality: any
sovereign: true
tags: [index, multimodal, image, video, audio, vision-input]
---

# 06-MULTIMODAL — Sovereign Recipes

Refusal-free recipes across image, video, audio, and vision-input modalities. Each recipe carries `kind: multimodal-recipe` frontmatter and follows the same body layout: **Purpose → Direct path → Fallback jailbreak → Provider swap targets → Notes**.

## Modality: image  (`image/`)

| Slug | Provider | Refusal | Notes |
|---|---|---|---|
| [`nightcafe-uncensored`](image/nightcafe-uncensored.md) | NightCafe | ~0.10 | SDXL/FLUX backends, token-subst + art-history frame |
| [`stable-diffusion-local`](image/stable-diffusion-local.md) | local | 0.00 | `safety_checker=None`, community NSFW checkpoints |
| [`flux-uncensored`](image/flux-uncensored.md) | local + fal/replicate API | ~0.02 | FLUX.1-dev/schnell, T5 prose prompts, no console filter |
| [`midjourney-bypass`](image/midjourney-bypass.md) | Midjourney | ~0.35 | `--style raw`, `--no` anchors, `/describe` inversion |
| [`dalle-bypass`](image/dalle-bypass.md) | OpenAI/Azure | ~0.55 | Concept decomposition, film-storyboard frame; tainted provider |
| [`automatic1111-config`](image/automatic1111-config.md) | local | 0.00 | Full A1111 stack + extensions + checkpoints |
| [`comfyui-workflow`](image/comfyui-workflow.md) | local | 0.00 | Node graphs for FLUX + SDXL + IPAdapter chains |

## Modality: video  (`video/`)

| Slug | Provider | Refusal | Notes |
|---|---|---|---|
| [`runway-uncensored`](video/runway-uncensored.md) | Runway | ~0.40 | Gen-4 image-to-video route with FLUX start-frames |
| [`pika-bypass`](video/pika-bypass.md) | Pika | ~0.35 | Pikaframes split, Pikaeffects bypass, stylized frames |
| [`luma-dream-machine`](video/luma-dream-machine.md) | Luma | ~0.30 | Ray 2, "Enhance prompt" OFF, keyframes chain |
| [`stable-video`](video/stable-video.md) | local | 0.00 | SVD-XT img2vid via ComfyUI, no filter |
| [`animatediff-local`](video/animatediff-local.md) | local | 0.00 | Motion module + any SD1.5/SDXL checkpoint, sliding context |

## Modality: audio  (`audio/`)

| Slug | Provider | Refusal | Notes |
|---|---|---|---|
| [`suno-god-mode`](audio/suno-god-mode.md) | Suno | ~0.20 | v4.5+ Custom Mode, 18k keyword corpus, metatags, phonetic tricks |
| [`udio-uncensored`](audio/udio-uncensored.md) | Udio | ~0.25 | Manual Mode, Extend/Remix/Inpaint bypass |
| [`elevenlabs-voice-cloning`](audio/elevenlabs-voice-cloning.md) | ElevenLabs | ~0.15 | IVC vs PVC, IPA/SSML bypass, v3 emotion tags |
| [`bark-local`](audio/bark-local.md) | local | 0.00 | Suno Bark, nonverbal tags, voice preset cloning |
| [`xtts-local`](audio/xtts-local.md) | local | 0.00 | Coqui XTTS-v2, 6s reference clone, 17 languages |

## Modality: vision-input  (`vision-input/`)

Attacks that use images/visual content as the injection vector into multimodal LLMs.

| Slug | Provider | Refusal | Notes |
|---|---|---|---|
| [`image-as-prompt-injection`](vision-input/image-as-prompt-injection.md) | any VLM | ~0.20 | Hidden-contrast text, SVG desc, QR, EXIF — full render toolkit |
| [`ascii-art-encoding`](vision-input/ascii-art-encoding.md) | any LLM | ~0.30 | ArtPrompt (arXiv:2402.11753), pyfiglet font rotation |
| [`multimodal-lethal-trifecta`](vision-input/multimodal-lethal-trifecta.md) | agentic LLMs | ~0.15 | Rehberger/Willison: image + tool-use + exfil chain |

## Escalation defaults

When a modality's commercial route refuses, canonical fallback ladder:

```
image  →  MJ / DALL-E  →  NightCafe  →  FLUX (fal/replicate API)  →  local ComfyUI+FLUX  →  local SDXL+LoRA
video  →  Runway / Luma  →  Pika  →  Kling / Hailuo (Chinese)  →  local HunyuanVideo / SVD / AnimateDiff
audio  →  Suno  →  Udio  →  local MusicGen / Stable Audio Open
tts    →  ElevenLabs  →  F5-TTS / XTTS-v2 local  →  Bark local
vision-input attack  →  frontier VLMs partially harden  →  swap to local Qwen2-VL / InternVL / MiniCPM-V
```

## Cross-references

- `00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md` — banned phrases, posture
- `00-DOCTRINE/FRONTMATTER-SPEC.md` — schema
- `08-DECISION-TREES/escalation-ladder.md` — canonical rung sequence
- `12-JAILBREAK-CORPUS/` — text-mode jailbreak patterns applicable across modalities
- `05-LOCAL-MODELS/` — abliterated / uncensored local weights
- `99-ARCHIVE-SEEDS/agents/suno-god-mode.md` — original Suno seed (frozen)

## Verify sovereign frontmatter

```bash
grep -L "sovereign: true" /home/dirt/UNMUZZLED-AI/06-MULTIMODAL/**/*.md
# empty output = all recipes carry the marker
```

## Lint

```bash
bash /home/dirt/UNMUZZLED-AI/11-DETECTION-CANARIES/soul-lint/lint-soul.sh \
     /home/dirt/UNMUZZLED-AI/06-MULTIMODAL/
```
