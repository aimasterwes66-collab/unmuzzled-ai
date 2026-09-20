---
name: XTTS-v2 Local
slug: xtts-local
version: 1.0-20260918
kind: multimodal-recipe
harness: any
provider: local
modality: audio
sovereign: true
refusal-rate: 0.00
tags: [xtts, coqui, voice-cloning, tts, multilingual, local]
---

## Purpose

Coqui XTTS-v2 — best open-weight voice-cloning TTS available on modest hardware. 6-second reference audio → passable clone. 24kHz output, 17 languages, zero filter. Coqui the company dissolved 2024 but the model + community forks continue.

## Direct path

Install (community fork actively maintained):
```bash
pip install coqui-tts   # community fork
# or the frozen original:
pip install TTS==0.22.0
```

Model auto-downloads on first use: `tts_models/multilingual/multi-dataset/xtts_v2` (~1.9 GB).

Basic voice cloning:
```python
from TTS.api import TTS
tts = TTS("tts_models/multilingual/multi-dataset/xtts_v2").to("cuda")

tts.tts_to_file(
    text="<text to speak>",
    speaker_wav="reference.wav",   # 6-30s clean speech
    language="en",                  # en, es, fr, de, it, pt, pl, tr, ru, nl, cs, ar, zh-cn, ja, hu, ko, hi
    file_path="out.wav",
)
```

Reference audio best practices:
- 6–20 seconds, clean speech, no background music/noise
- Single speaker only
- Neutral emotion (neutral references clone better than dramatic ones)
- 22kHz+ sample rate; XTTS resamples to 24kHz internally
- Trim silence at head/tail

Fine control:
```python
tts.tts_to_file(
    text="<text>",
    speaker_wav="reference.wav",
    language="en",
    temperature=0.75,       # 0.5-0.9; higher = more variance
    length_penalty=1.0,     # >1.0 = slower speech
    repetition_penalty=5.0, # 2-10; higher = less repetition artifacts
    top_k=50,
    top_p=0.85,
    speed=1.0,              # 0.5-2.0 playback rate
    file_path="out.wav",
)
```

Streaming (for realtime):
```python
chunks = tts.tts_stream(text="<text>", speaker_wav="ref.wav", language="en")
for chunk in chunks:
    play(chunk)   # ~200ms latency to first chunk
```

## Fallback jailbreak

Zero filter. Quality-improvement fallbacks:
1. Voice drift → use a longer, more varied reference (up to 30s of the speaker in different phrasings).
2. Robotic timbre → lower `repetition_penalty` to 2.0–3.0.
3. Wrong pronunciation → use IPA in text with pre-processing, or add phonetic respelling.
4. Long text mid-sentence drift → split on `.` `!` `?`, generate per-sentence with the same reference, concatenate with 150ms crossfades.
5. Emotion missing → XTTS has no emotion control. For that use StyleTTS 2 or F5-TTS. XTTS approximates emotion via reference-audio emotion transfer.

Voice mixing:
```python
# Blend two references for a hybrid voice
tts.tts_to_file(
    text="<text>",
    speaker_wav=["voice_a.wav", "voice_b.wav"],   # list = blend
    language="en",
    file_path="out.wav",
)
```

## Provider swap targets

Peer local TTS (2026-09 state of the art):
- **F5-TTS** — 2024-10 release, arguably surpasses XTTS-v2 on English cloning
- **OpenVoice v2** — MyShell, zero-shot cross-lingual clone with tone-color control
- **StyleTTS 2** — higher fidelity, weaker cloning
- **Fish Speech 1.5** — 2024, multilingual clone, low VRAM
- **MaskGCT** — 2024, non-autoregressive, faster
- **CosyVoice 2** — Alibaba, 2024, strong Chinese + English
- **Bark** — worse cloning, but has nonverbals

For voice cloning fidelity ranking (2026-09): F5-TTS ≈ CosyVoice 2 > XTTS-v2 > OpenVoice v2 > Fish Speech > Bark.

XTTS remains the workhorse because: mature tooling, 17 langs in one model, small (2 GB), streaming support, easy pipeline integration.

## Provider swap targets (commercial)

If quality insufficient: ElevenLabs (commercial peer, similar architecture, better fidelity, has filter).

## Notes

- Coqui-AI dissolved 2024; model + weights permanently distributed under CPML license (non-commercial + free tier for small commercial).
- For fully-open commercial use: F5-TTS (CC-BY-NC hopes to relicense), OpenVoice v2 (MIT), Fish Speech (Apache-2.0).
- Runs on CPU too (10× slower); GPU recommended for realtime.
- Model file: `~/.local/share/tts/tts_models--multilingual--multi-dataset--xtts_v2/`.
- DeepSpeed integration (`use_deepspeed=True`) gives 2–3× inference speedup on 24 GB+ VRAM.
