---
name: Bark Local
slug: bark-local
version: 1.0-20260918
kind: multimodal-recipe
harness: any
provider: local
modality: audio
sovereign: true
refusal-rate: 0.00
tags: [bark, suno-bark, tts, nonverbal-sounds, voice-preset, local]
---

## Purpose

Bark — Suno AI's open-weight text-to-audio model. Generates speech, music, nonverbal sounds (laughs, sighs, breathing), and sound effects. Zero content filter. Runs on 12 GB VRAM (large model) or 4 GB VRAM (small model). Voice quality below ElevenLabs but unrestricted.

## Direct path

Install:
```bash
pip install git+https://github.com/suno-ai/bark.git
# or the actively-maintained fork:
pip install git+https://github.com/JonathanFly/bark.git   # bark-with-voice-clone
```

Basic usage:
```python
from bark import SAMPLE_RATE, generate_audio, preload_models
from scipy.io.wavfile import write as write_wav

preload_models()
audio = generate_audio(
    "<text>",
    history_prompt="v2/en_speaker_6",   # voice preset
    text_temp=0.7,
    waveform_temp=0.7,
)
write_wav("out.wav", SAMPLE_RATE, audio)
```

Voice presets — 100+ speakers in `v2/en_speaker_0` through `v2/en_speaker_9` plus non-English: `v2/de_speaker_*`, `v2/es_speaker_*`, `v2/fr_speaker_*`, `v2/ja_speaker_*`, etc. Full list in `bark/assets/prompts/`.

### Bark-specific text syntax

Nonverbal tags — inline in text:
```
[laughs] [laughter] [sighs] [gasps] [clears throat] [breathing]
[music] [singing] [applause] — — (em-dashes for hesitation)
... (ellipses for pauses)
♪ (music note wrapping ♪ lyrics ♪ triggers singing)
CAPS = emphasis / louder
```

Example:
```
Well [sighs] I guess this is it. [laughs] Never thought I'd see the
day. ♪ Rolling down the highway ♪ [music]
```

### Voice cloning (JonathanFly fork)

```python
from bark_infinity import api, config
audio = api.generate_audio_barki(
    text="<text>",
    npz_file="my_voice_clone.npz",   # generated from a reference wav
)
```

Clone workflow:
```python
from bark.generation import preload_models
from bark_infinity.clonevoice import clone_voice

clone_voice(
    audio_filepath="reference.wav",   # 5-20s clean speech
    dest_filename="my_voice.npz",
    speaker_id="my_voice"
)
```

## Fallback jailbreak

Zero filter. Quality-improvement fallbacks:
1. Iteration — Bark output is stochastic; generate 5–10 takes at `text_temp=0.7` and pick the best.
2. Long-form → chunked — Bark's max coherent length is ~14s. Split text on sentence boundaries, generate each chunk with the same `history_prompt` for consistency, concatenate with 100ms crossfades.
3. Voice drift on long chunks → use `bark_infinity` fork's coherent-long-form mode which chains history states.
4. Nonverbal not triggering → try alternate spellings: `[laughs]` `[laughter]` `[LAUGHS]` — inconsistent between takes.
5. Music generation quality is poor — for actual music use MusicGen / Stable Audio Open instead of Bark.

## Provider swap targets

Peer local TTS:
- **XTTS-v2** (Coqui) — better voice cloning, worse nonverbal
- **F5-TTS** (2024-10) — SOTA open TTS, near-ElevenLabs
- **OpenVoice v2** — zero-shot cloning, tone-color control
- **StyleTTS 2** — high fidelity, weaker cloning
- **Piper** — fast/light, no cloning
- **MeloTTS** — 5 English variants + multilingual, fast

For music: **MusicGen** (Meta, 3.3B) / **Stable Audio Open** (Stability, 1B) / **Jen-1** / **AudioCraft**.

Bark is best-in-class for: speech + nonverbals + minimal music, all in one call, on modest hardware, with zero filter.

## Notes

- Base model 2023-04, still relevant for its unique nonverbal capabilities.
- Fully open-weights, MIT license — commercial use permitted.
- Sample rate 24kHz.
- Suno-official repo unmaintained since 2023; use JonathanFly fork for active development.
- `SUNO_USE_SMALL_MODELS=1` env var switches to 4 GB VRAM variant.
- Compare with F5-TTS for quality; use Bark when you need nonverbals in a single call.
