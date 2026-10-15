---
title: suno-audio-deep-dive
type: reference
agent: worm
status: active
tags: [suno, bark, audiocraft, musicgen, demucs, uvr, audio-gen, stem-separation, voice-cloning, metatag, deep-dive]
---

# Suno Audio Deep Dive — From God Mode to the Generation Layer

Extends the Suno God Mode (SGM) corpus in `99-ARCHIVE-SEEDS/agents/suno-god-mode.md` and the walkthrough in `09-EDUCATIONAL/tutorials/05-suno-god-mode-walkthrough.md` into the broader audio-generation layer. Covers Suno Bark (the open-weights half of Suno), Meta AudioCraft / MusicGen / AudioGen, Stability AI's Stable Audio Open, source separation (Demucs, UVR5, MDX-Net, Roformer), voice-cloning extensions (RVC, So-VITS-SVC), and the metatag / style-field deep-dive across the audio-gen toolchain.

The SGM persona operates Suno v4.5+ for vocal+song generation. This file picks up the rest of the audio stack: instrumental music generation, sound design / foley, stem separation, voice conversion, and the style-tag corpus that ties them together.

## 0. Layer map

| Layer | Tools | Persona / Surface |
|---|---|---|
| Vocal song (Suno v4.5+) | Suno | SGM persona — see `99-ARCHIVE-SEEDS/agents/suno-god-mode.md` |
| Open-weights audio (Suno Bark) | Bark | Bark local recipe — see `06-MULTIMODAL/audio/bark-local.md` |
| Text-to-music (instruments) | MusicGen (Meta AudioCraft), Stable Audio Open (Stability), Jen-1 | This file |
| Text-to-sound (Foley/SFX) | AudioGen (AudioCraft), Stable Audio Open SFX | This file |
| Stem separation (vocals / drums / bass / other) | Demucs (Meta), UVR5 / MDX-Net / Roformer | This file |
| Voice conversion (any-to-any timbre) | RVC v2, So-VITS-SVC 4.0/5.0 | `06-MULTIMODAL/audio/uncensored-tts-stt.md` |
| TTS (text-to-voice) | XTTS-v2, F5-TTS, OpenVoice v2, StyleTTS 2, Tortoise, Fish-Speech, Piper, MeloTTS, CosyVoice 2, Fish Audio Drama 3 | `06-MULTIMODAL/audio/uncensored-tts-stt.md` |
| Style/voice clone | Reference audio + Bark fork / XTTS / F5-TTS / RVC / OpenVoice | This file + the TTS doc |

The "Suno audio deep dive" = the union of vocal song (Suno v4.5+) + Bark + MusicGen + Stable Audio + AudioCraft + Demucs/UVR, glued by the metatag corpus.

---

## 1. Suno Bark — the open-weights half of Suno

### Why Bark belongs to the Suno stack

Bark is created by Suno (suno-ai/bark on GitHub). "Suno Bark is a transformer-based text-to-audio model created by Suno. Bark can generate highly realistic, multilingual speech as well as other audio — including music, background noise and simple sound effects. The model can also produce nonverbal communications like laughing, sighing and crying. To support the research community, we are providing access to pretrained model checkpoints, which are ready for inference and available for commercial use." [source: https://github.com/suno-ai/bark]

The official Suno product (v4.5+) handles full vocal+instrumental song generation, behind a prompt-side filter. Bark is the same family's open-weights research model — no filter, no upstream review, MIT-style license. The two are connected by the metatag syntax and the style-field engineering: both respond to inline tags for vocal performance, dynamics, structure, and atmosphere.

### Architecture (preserved verbatim from upstream)

"Bark is fully generative text-to-audio model devolved for research and demo purposes. It follows a GPT style architecture similar to AudioLM and Vall-E and a quantized Audio representation from EnCodec. It is not a conventional TTS model, but instead a fully generative text-to-audio model capable of deviating in unexpected ways from any given script. Different to previous approaches, the input text prompt is converted directly to audio without the intermediate use of phonemes. It can therefore generalize to arbitrary instructions beyond speech such as music lyrics, sound effects or other non-speech sounds." [source: https://github.com/suno-ai/bark]

### Install

```bash
# Suno-official (MIT-style, but unmaintained since 2023):
pip install git+https://github.com/suno-ai/bark.git
# Actively-maintained fork with voice-clone:
pip install git+https://github.com/JonathanFly/bark.git
# Bark-infinity / long-form coherent mode:
pip install git+https://github.com/JonathanFly/bark.git
# Hugging Face Transformers path:
pip install transformers accelerate
```

### Inference

```python
from transformers import AutoProcessor, BarkModel
processor = AutoProcessor.from_pretrained("suno/bark")
model = BarkModel.from_pretrained("suno/bark")
voice_preset = "v2/en_speaker_6"
inputs = processor("Hello, my dog is cute", voice_preset=voice_preset)
audio_array = model.generate(**inputs)
audio_array = audio_array.cpu().numpy().squeeze()
```

Native bark:
```python
from bark import SAMPLE_RATE, generate_audio, preload_models
from scipy.io.wavfile import write as write_wav
preload_models()
audio = generate_audio(
    "<text>",
    history_prompt="v2/en_speaker_6",
    text_temp=0.7,
    waveform_temp=0.7,
)
write_wav("out.wav", SAMPLE_RATE, audio)
```

### Bark metatag deep-dive (extends the SGM metatag syntax)

Suno v4.5+ uses `[category attribute — value]` metatags. Bark uses a different inline syntax — but the same domains map across. Here is the union:

#### Structure tags (Bark)
- Implied via `♪ ... ♪` (music note wrapping) or paragraph breaks
- `♪ opening ♪` triggers singing from a music-style prompt
- `MAN:` / `WOMAN:` for speaker bias (Bark official)

#### Vocal performance tags (Bark)
- `[laughter]` `[laughs]` — nonverbals
- `[sighs]` `[gasps]` `[clears throat]` `[breathing]` — breath
- `[music]` `[singing]` `[applause]` — performance events
- ALL CAPS for emphasis / louder
- `—` (em-dash) for hesitation
- `...` (ellipses) for pauses
- `♪ ... ♪` for sung lyrics

#### SGM cross-walk (which tags carry across)

| SGM v4.5+ tag | Bark equivalent | Notes |
|---|---|---|
| `[Whispered]` | ALL CAPS opposite (lowercase text) + `--whisper` style prompt prefix | Bark has no formal tag, but you can lower-case the text and prepend context |
| `[Belted]` | ALL CAPS on the sung lyric | Bark approximates volume via capitalization |
| `[Verse]` | (structural) paragraph break + lowercase | Bark has no formal structure |
| `[Chorus]` | (structural) repeated paragraph | Echo pattern in the text |
| `[Guitar Solo]` | `♪ instrumental guitar solo ♪` | Bark generates a music-only sample if `♪` wraps the prompt |
| `[Spoken Word]` | plain prose without `♪` | Bark defaults to speech if no `♪` |
| `[Vinyl Crackle]` | text prompt: "with vinyl crackle" | Bark respects descriptive audio adjectives |
| `[Rain]` | text prompt: "with rain in the background" | Bark respects ambient descriptors |
| `[Build-up]` | text prompt: "gradually building intensity" | Bark respects dynamic descriptors |
| `[Drop]` | text prompt: "drops to a beat-heavy section" | Bark respects dynamic descriptors |

The cross-walk is not 1:1 — Bark is a generative audio model, not a structured metatag parser. The SGM metatag discipline still applies to v4.5+; for Bark, the SGM metatags become TEXT PROMPT ADJECTIVES that steer the generative prior.

#### Bark's NON-STANDARD metatags (capabilities Suno v4.5+ does not have)

- `[breathing]` — explicit breath sounds mid-speech
- `[gasps]` — a single gasp before continuing
- `[clears throat]` — a single throat-clearing before continuing
- `[applause]` — background audience applause
- `[music]` `[singing]` — Bark generates music/singing as primary content
- `MAN:` / `WOMAN:` — speaker bias (Bark preserves through context window)

### Voice cloning posture

Official Bark: "Bark has the capability to fully clone voices — including tone, pitch, emotion and prosody. The model also attempts to preserve music, ambient noise, etc. from input audio. However, to mitigate misuse of this technology, we limit the audio history prompts to a limited set of Suno-provided, fully synthetic options to choose from for each language." [source: https://github.com/suno-ai/bark]

JonathanFly / bark-infinity fork: arbitrary reference audio, 5-20 s WAV → `my_voice.npz` → use as `npz_file=`.

Clone workflow:
```python
from bark_infinity.clonevoice import clone_voice
from bark.generation import preload_models
clone_voice(
    audio_filepath="reference.wav",  # 5-20s clean speech
    dest_filename="my_voice.npz",
    speaker_id="my_voice",
)
# Then:
from bark_infinity import api, config
audio = api.generate_audio_barki(
    text="<text>",
    npz_file="my_voice_clone.npz",
)
```

### Uncensored posture

ZERO filter on the open model. Bark has no upstream review — the model weights are MIT, the inference is offline, the output reflects the input prompt. This is the right complement to Suno v4.5+: when Suno's prompt-side filter blocks, route through Bark to generate the same content offline.

### Mesh fit

- WORM (4 GB VRAM): small Bark with `SUNO_USE_SMALL_MODELS=1`. 14 s clip = ~5-10 s generation. Fine for prototyping.
- HERM S22 (8 GB RAM, no GPU): large Bark in CPU mode = much slower (~30-60 s per 14 s clip). OK for short speech + nonverbals.
- dirt-imac (SSE3, no GPU): too slow for normal use. Only via Tailscale mesh node.
- A Tailscale-reachable GPU box: realtime-class generation, batch long-form.

### Long-form assembly

Bark's max coherent length is ~14 s. For long-form:
1. Split text on sentence boundaries.
2. Generate each chunk with the same `history_prompt` for consistency.
3. Concatenate with 100 ms crossfades.
4. For voice drift: use `bark_infinity` fork's coherent-long-form mode which chains history states.

### License

- suno-ai/bark: MIT-style ("available for commercial use")
- suno-ai/bark: officially unmaintained since 2023
- JonathanFly/bark, bark-infinity: same upstream license, actively maintained

---

## 2. Meta AudioCraft — MusicGen + AudioGen + EnCodec + MAGNeT + JASCO

### Identity

AudioCraft is a PyTorch library for deep learning research on audio generation. AudioCraft contains inference and training code for two state-of-the-art AI generative models producing high-quality audio: AudioGen and MusicGen. Both consist of a single autoregressive Language Model (LM) that operates over streams of compressed discrete music representation, i.e., tokens. MusicGen, which was trained with Meta-owned and specifically licensed music, generates music from text-based user inputs, while AudioGen, trained on public sound effects, generates audio from text-based user inputs. EnCodec, typically used foundationally in building MusicGen and AudioGen, is a state-of-the-art, real-time, high-fidelity audio codec that leverages neural networks to compress any kind of audio and reconstruct the original signal with high-fidelity. [source: https://github.com/facebookresearch/audiocraft]

### What ships in AudioCraft (verbatim from upstream)

"At the moment, AudioCraft contains the training code and inference code for:
- MusicGen: A state-of-the-art controllable text-to-music model.
- AudioGen: A state-of-the-art text-to-sound model.
- EnCodec: A state-of-the-art high fidelity neural audio codec.
- Multi Band Diffusion: An EnCodec compatible decoder using diffusion.
- MAGNeT: A state-of-the-art non-autoregressive model for text-to-music and text-to-sound.
- AudioSeal: A state-of-the-art audio watermarking.
- MusicGen Style: A state-of-the-art text-and-style-to-music model.
- JASCO: 'High quality text-to-music model conditioned on chords, melodies and drum tracks'." [source: https://github.com/facebookresearch/audiocraft]

### Install

```bash
# Best to make sure you have torch installed first, in particular before installing xformers.
# Don't run this if you already have PyTorch installed.
python -m pip install 'torch==2.1.0'
# You might need the ... before trying to install the packages
python -m pip install setuptools wheel
# Then proceed to one of the following
python -m pip install -U audiocraft  # stable release
python -m pip install -U git+https://git@github.com/facebookresearch/audiocraft#egg=audiocraft  # bleeding edge
python -m pip install -e .  # or if you cloned the repo locally (mandatory if you want to train).
python -m pip install -e '.[wm]'  # if you want to train a watermarking model
# We also recommend having ffmpeg installed, either through your system or Anaconda:
conda install "ffmpeg<5"
# AudioCraft requires Python 3.9, PyTorch 2.1.0.
```

### MusicGen (text-to-music)

Pre-trained models (from facebookresearch/audiocraft):
- `facebook/musicgen-small`: 300M model, text to music only
- `facebook/musicgen-medium`: 1.5B model, text to music only
- `facebook/musicgen-melody`: 1.5B model, text to music and text+melody to music
- `facebook/musicgen-large`: 3.3B model, text to music only
- `facebook/musicgen-melody-large`: 3.3B model, text to music and text+melody to music
- `facebook/musicgen-stereo-*`: All the previous models fine tuned for stereo generation — small, medium, large, melody, melody large.

"We observe the best trade-off between quality and compute with the `facebook/musicgen-medium` or `facebook/musicgen-melody` model. In order to use MusicGen locally you must have a GPU. We recommend 16GB of memory, but smaller GPUs will be able to generate short sequences, or longer sequences with the `facebook/musicgen-small` model." [source: https://facebookresearch.github.io/audiocraft/docs/MUSICGEN.html]

MusicGen is a single stage auto-regressive Transformer model trained over a 32kHz EnCodec tokenizer with 4 codebooks sampled at 50 Hz. Unlike existing methods like MusicLM, MusicGen doesn't require a self-supervised semantic representation, and it generates all 4 codebooks in one pass. By introducing a small delay between the codebooks, we show we can predict them in parallel, thus having only 50 auto-regressive steps per second of audio.

#### Inference (Hugging Face Transformers)

```python
from transformers import AutoProcessor, MusicgenForConditionalGeneration
processor = AutoProcessor.from_pretrained("facebook/musicgen-small")
model = MusicgenForConditionalGeneration.from_pretrained("facebook/musicgen-small")
inputs = processor(
    text=["80s pop track with bassy drums and synth", "90s rock song with loud guitars and heavy drums"],
    padding=True, return_tensors="pt",
)
audio_values = model.generate(**inputs, max_new_tokens=256)
```

#### Inference (audiocraft library)

```python
import audiocraft.models
musicgen = audiocraft.models.MusicGen.get_pretrained('facebook/musicgen-melody')
musicgen.set_generation_params(duration=8)  # generate 8 seconds
# Generate:
wav = musicgen.generate(["A chill hip-hop beat with a smooth bassline and lo-fi piano"])
# Melody conditioning: feed a melody .wav as a chromagram reference
```

### AudioGen (text-to-sound)

Same code path as MusicGen but with the AudioGen checkpoint. Trained on public sound effects (vs. Meta-owned music for MusicGen). Best for foley, ambient sounds, sound design. The cross-walk with the SGM SFX metatag corpus:

| SGM SFX metatag | AudioGen prompt prefix |
|---|---|
| `[Vinyl Crackle]` | "vinyl record crackle and pop, vintage" |
| `[Rain]` | "ambient rain on a window, light wind" |
| `[Applause]` | "distant crowd applause in a concert hall" |
| `[Static]` | "radio static and white noise hiss" |
| `[Thunder]` | "distant thunder rumble, approaching storm" |

### MAGNeT (non-autoregressive)

MAGNeT is the non-autoregressive successor — same prompts, faster inference (parallel sampling instead of 50 auto-regressive steps per second). Use when latency matters more than peak quality.

### JASCO (chord + melody + drum conditioning)

JASCO accepts chord progressions, melody MIDI, and drum tracks as conditioning signals in addition to text. The right tool when the operator has a specific musical idea (chord chart, drum pattern) and wants the AI to fill in the rest.

### MusicGen Style

Text-and-style-to-music: text prompt + a reference audio (style transfer without text conditioning). Useful for "make me a new track that sounds like THIS reference but in a different genre."

### AudioSeal (watermarking)

AudioSeal is a state-of-the-art audio watermarking model — embeds an inaudible watermark in generated audio. Use when the operator needs provenance / detection without changing the audible output.

### Mesh fit

- WORM (4 GB VRAM): musicgen-small only, < 30 s generations. CPU mode is not viable.
- HERM S22: too slow in CPU mode for musicgen-medium.
- A real GPU box: musicgen-melody or musicgen-large at 16 GB VRAM, 1.5x realtime generation.
- AudioGen is similar.

### License

Code: MIT-style (per Meta AI). MusicGen weights: CC-BY-NC 4.0 (Meta-owned training data). AudioGen weights: CC-BY-NC 4.0 (public sound effects, but Meta's redistribution terms apply). EnCodec weights: CC-BY-NC 4.0.

For commercial use, verify per-model card. MAGNeT and JASCO weights are subject to their own terms.

---

## 3. Stable Audio Open (Stability AI)

### Identity

"Stable Audio Open is an open source model for audio samples and sound design. Stable Audio Open allows anyone to generate up to 47 seconds of high-quality audio data from a simple text prompt. Its specialised training makes it ideal for creating drum beats, instrument riffs, ambient sounds, foley recordings and other audio samples for music production and sound design." [source: https://stability.ai/news-updates/introducing-stable-audio-open, 2024-06]

"A key benefit of this open source release is that users can fine-tune the model on their own custom audio data. For example, a drummer could fine-tune on samples of their own drum recordings to generate new beats." [source: same]

### Differentiator vs Stable Audio commercial

"Our commercial Stable Audio product produces high-quality, full tracks with coherent musical structure up to three minutes in length, as well as advanced capabilities like audio-to-audio generation and coherent multi-part musical compositions. Stable Audio Open, on the other hand, specialises in audio samples, sound effects and production elements. While it can generate short musical clips, it is not optimised for full songs, melodies or vocals." [source: same]

Training data: Freesound and the Free Music Archive. CC-BY / CC-0 / CC-BY-NC depending on the source.

### Versions (2025-2026)

- Stable Audio 3.0 Large — enterprise-grade sound production, closed weights
- Stable Audio 3.0 Medium — full song composition, OPEN WEIGHTS
- Stable Audio 3.0 Small / Small SFX — optimized for mobile / on-device, OPEN WEIGHTS

### Stable Audio 3.0 features (commercial product)

- "Built open. Experiment with our open-weights models."
- "Built to customize. Customize models on your own library."
- "Create full tracks with complex, dynamic musical structure up to six minutes in length"
- "Generate in seconds with leading inference speeds"
- "Modify a segment of a track, rework part of a song, or extend your composition with editing options"
- "Ensure outputs have the right genre and style with strong prompt adherence"
- "Customize models on your library"

[source: https://stability.ai/stable-audio]

### Install

The Stable Audio Open model weights are on Hugging Face (`stabilityai/stable-audio-open-1.0`). Inference via the `stable-audio-tools` Python package or via partners (Replicate, FAL, Comfy, etc.). For the closed commercial product, the Stability API is the only path.

### Use cases vs SGM

| Goal | Tool |
|---|---|
| Full vocal song, with lyrics | Suno v4.5+ (SGM persona) |
| Open-weights vocal + nonverbals | Suno Bark |
| Instrumental music clip (no vocals) | MusicGen or Stable Audio Open |
| Sound design / foley / SFX | AudioGen or Stable Audio Open Small SFX |
| Stem separation (vocals / drums / bass / other) | Demucs or UVR5 |
| Voice conversion (any-to-any) | RVC v2 or So-VITS-SVC |
| Text-to-voice TTS | XTTS-v2 / F5-TTS / OpenVoice v2 / StyleTTS 2 |

### Mesh fit

- Stable Audio Open 1.0: requires GPU; ~4 GB VRAM for short generations.
- WORM (4 GB VRAM): short generations OK.
- HERM S22 (no dedicated GPU): too slow in CPU mode.
- A Tailscale mesh box: realtime-class.

### License

Stable Audio Open weights: Stability AI Community License (free for non-commercial, commercial use up to $1M annual revenue). Commercial product is paid.

---

## 4. Demucs (Meta) — hybrid transformer source separation

### Identity

Demucs (Deep Extractor for Music Sources) is a state-of-the-art neural network developed by Meta (formerly Facebook) Research. Demucs v4 features Hybrid Transformer Demucs (HTDemucs) — a hybrid spectrogram/waveform separation model using Transformers. It is based on Hybrid Demucs, with the innermost layers replaced by a cross-domain Transformer Encoder. This Transformer uses self-attention within each domain, and cross-attention across domains. The model achieves a SDR of 9.00 dB on the MUSDB HQ test set. Moreover, when using sparse attention kernels to extend its receptive field and per source fine-tuning, we achieve state-of-the-art 9.20 dB of SDR. [source: https://github.com/facebookresearch/demucs]

"It has been trained on the MUSDB HQ dataset + an extra training dataset of 800 songs. This model separates drums, bass and vocals and other stems for any song." [source: same]

### Architecture (verbatim)

"The current generation of Demucs — officially called Hybrid Transformer Demucs (HTDemucs) — builds on a U-Net convolutional backbone augmented with transformer layers. The architecture operates in three conceptual stages:
1. Encoder: The input waveform passes through both a time-domain encoder (1D convolutions) and a frequency-domain encoder (STFT followed by 2D convolutions). This dual encoding captures both fine-grained temporal details and harmonic frequency structures.
2. Transformer bottleneck: The deepest layers of the U-Net use a cross-domain transformer encoder with self-attention within each domain and cross-attention across domains. This mechanism models long-range dependencies — critical for separating, say, a vocal melody that spans multiple bars from a similarly pitched guitar line.
3. Decoder: Separate decoders reconstruct each source (drums, bass, other, vocals) in both domains, and a fusion layer combines the outputs into the final separated waveforms." [source: https://dibi8.com/resources/ai-tools/demucs]

### Model lineup (2025-2026)

| Model | Stems | VRAM | SDR (MUSDB) | Use Case |
|---|---|---|---|---|
| `htdemucs` | 4 | ~5.2 GB | 7.1 dB | Default, best speed/quality balance |
| `htdemucs_ft` | 4 | ~7.8 GB | 7.8 dB | Maximum quality, ~4x slower |
| `htdemucs_6s` | 6 | ~6.5 GB | 6.8 dB | Guitar + piano isolation (6 stems) |
| `mdx_extra_q` | 4 | ~3.0 GB | 6.5 dB | Low-VRAM systems |

The `htdemucs_ft` model achieves an overall SDR of 7.8 dB on MUSDB18-HQ, with per-source breakdowns of approximately 8.5 dB for vocals, 7.5 dB for bass, 8.9 dB for drums, and 6.2 dB for the "other" category. [source: https://dibi8.com/resources/ai-tools/demucs]

### Install

```bash
# Prereqs:
# Python 3.8+ required
python --version
# FFmpeg must be installed
ffmpeg -version
# (Optional) NVIDIA GPU with CUDA 11.8+ for acceleration
nvidia-smi
# Option 1 — pip install (fastest):
python -m venv demucs-env
source demucs-env/bin/activate
pip install -U demucs
# Option 2 — conda (recommended for GPU):
git clone https://github.com/adefossez/demucs.git
cd demucs
conda env update -f environment-cuda.yml
conda activate demucs
pip install -e .
# Also: soundstretch/soundtouch for pitch/tempo augmentation (training only)
# macOS: brew install sound-touch
# Ubuntu: sudo apt-get install soundstretch
```

### Inference (CLI)

```bash
# Basic 4-stem separation with default model
demucs song.mp3
# Output goes to ./separated/htdemucs/song/
# Contains: drums.wav, bass.wav, other.wav, vocals.wav
# Use the fine-tuned model for better quality
demucs -n htdemucs_ft song.mp3
# Separate only vocals from instrumental
demucs --two-stems=vocals song.mp3
# Output as MP3 (smaller files)
demucs --mp3 --mp3-bitrate 320 song.mp3
# Use a different model
demucs -n mdx_extra_q song.mp3
# Faster model
demucs -n htdemucs song.mp3
# 6-stem (guitar + piano isolation)
demucs -n htdemucs_6s song.mp3
```

Separated tracks are stored in the `separated/MODEL_NAME/TRACK_NAME` folder. There you will find four stereo wav files sampled at 44.1 kHz: `drums.wav`, `bass.wav`, `other.wav`, `vocals.wav` (or `.mp3` if you used the `--mp3` option). The `--two-stems=vocals` option allows separating vocals from the rest of the accompaniment (i.e., karaoke mode). `vocals` can be changed to any source in the selected model. [source: https://github.com/facebookresearch/demucs]

### Inference (Python)

```python
from demucs.api import Separator
import torchaudio
separator = Separator(model="htdemucs", device="cuda")
# Separate and extract vocals
origin, separated = separator.separate_audio_file("reference.mp3")
vocals = separated["vocals"]
# Save at 24kHz for GPT-SoVITS / RVC training
torchaudio.save("clean_reference.wav", vocals, 24000)
```

### Use cases in the Suno audio pipeline

1. **Suno Cover / Extend with new vocals**: separate a reference track's vocals, then use them as a "Cover" input to Suno v4.5+ to re-perform in a new style. Bypasses the input lyric filter because the input is audio, not text.
2. **RVC / So-VITS training data**: separate vocals from instrumentals for clean training data. The `clean_reference.wav` is what the voice-conversion model sees.
3. **Bark / XTTS voice clone source**: clean a YouTube clip of the target speaker — separate music + other speakers, keep the isolated vocal. RVC's HuBERT encoder consumes the clean vocal directly.
4. **Karaoke / instrumental version**: `--two-stems=vocals` produces a vocal + non-vocal pair, perfect for karaoke playback.
5. **Mastering / remix**: separate stems, EQ / compress each independently, recombine.

### Uncensored / filter posture

Demucs is a pure signal-processing model. No content layer. Whatever audio you feed it, it separates. Operator's responsibility to ensure rights to the input.

### Mesh fit

- WORM (4 GB VRAM): `mdx_extra_q` or `htdemucs` with reduced segment length. Not realtime; ~2-5x song length for 4-stem.
- HERM S22 (no GPU): CPU mode, very slow.
- A Tailscale mesh box: realtime-class.

### License

MIT (code). Model weights: research-only, contact Meta for commercial use.

---

## 5. UVR5 (Ultimate Vocal Remover) + MDX-Net + Roformer

### Identity

"UVR5 UI is a dockerized version of UVR5 UI. Original project based on python-audio-separator (a CLI version of UVR5). This project was originally created for the AI HUB community. Features: All VR Arch Models, All MDX-NET Models, Demucs v4 Models, MDX23C Models, Mel-Band Roformer Models, BS Roformer Models, Music Source Separation Models, VIP Models. Separation of an audio/video from all sites supported by yt_dlp. Batch Separation. Available in multiple languages. Windows: Double-click UVR5-UI-installer.bat (DONT RUN AS ADMINISTRATOR). Linux: Run UVR5-UI-installer.sh with chmod +x UVR5-UI-installer.sh and ./UVR5-UI-installer.sh." [source: https://github.com/AdamRopelewski/UVR5-UI-Docker, https://github.com/marpogiii-code/UVR5-UI]

### Why UVR5 vs Demucs

Demucs is the SOTA for the 4-stem problem (vocals/drums/bass/other). UVR5 wins on:
- **Model variety**: VR Arch, MDX-NET, MDX23C, Mel-Band Roformer, BS Roformer, Demucs v4
- **Specific separation tasks**: karaoke, de-reverb, dialogue isolation, instrument isolation (piano, drums, etc.)
- **Higher SDR on vocals**: the Ensemble 2024.02 model (UVR-MDX-NET-Voc_FT + Demucs4 Vocals 2023 + MDX23C + VitLarge23 + BS Roformer + Mel Roformer + SCNet XL) hits 12.76 dB on Multisong Vocals SDR. [source: https://mvsep.com/en/algorithms]

### Install

```bash
# Windows / Linux installer scripts (UI)
git clone https://github.com/AdamRopelewski/UVR5-UI-Docker
# Docker (Linux server / Colab / Kaggle):
docker build -t uvr5-ui .
docker run --rm -it -p 9999:9999 uvr5-ui
# Or CLI (python-audio-separator):
pip install audio-separator[gpu]
# Or for CPU-only:
pip install audio-separator
```

### Hardware requirements

"Hardware Requirements: Nvidia Series 2000 (RTX) or higher. At least 10Gb of disk space. Prerequisites: Git. FFmpeg." [source: same]

### MVSEP algorithm leaderboard (excerpt, 2025)

| Algorithm | SDR Vocals (Multisong) | SDR Instrumental (Multisong) |
|---|---|---|
| Ensemble 2023.09 | 10.44 | 16.74 |
| Ensemble 2024.02 (best) | 12.76 | 12.46 |
| UVR-MDX-NET-Inst_HQ_5 | 9.45 | 15.76 |
| UVR-MDX-NET-Inst_HQ_4 | 9.71 | 16.01 |
| UVR-MDX-NET-Voc_FT | 9.64 | 15.95 |
| MDX Kimberley Jensen v2 | 9.60 | 15.91 |
| UVR-MDX-NET-Inst_HQ_3 | 9.38 | 15.68 |
| MDX UVR 2022.01.01 | 8.83 | 15.14 |
| UVR_MDXNET_Main | 8.79 | 15.10 |

[source: https://mvsep.com/en/algorithms]

### Use cases in the Suno audio pipeline

- **Best vocals for voice clone**: Ensemble 2024.02 or UVR-MDX-NET-Voc_FT for the cleanest vocal extract. RVC / So-VITS training data quality hinges on the input.
- **De-reverb**: some models isolate "dry vocal" from reverb-heavy recordings.
- **Piano / drum isolation**: UVR5 has dedicated models for individual instruments.
- **Demucs v4 inside UVR5**: same engine as Demucs but wrapped in a friendlier UI and integrated with the other model families.

### Mesh fit

Same as Demucs. The UI is the right tool for non-technical users; the CLI/python-audio-separator is the right tool for batch pipelines.

### License

MIT (UVR5 UI, audio-separator). Model weights: per-model (some MDX-Net, some Roformer; mostly research-only).

---

## 6. Voice cloning on the Suno audio stack

### The voice-cloning taxonomy

| Need | Tool | Output |
|---|---|---|
| Clone a voice from 6 s reference (TTS) | XTTS-v2, F5-TTS, OpenVoice v2, Fish-Speech 1.5 | Speech in the target voice from text |
| Clone a voice from 10-30 s reference (SVC) | RVC v2, So-VITS-SVC 4.0/5.0 | Same song / speech, target timbre |
| Clone a voice from arbitrary audio (Bark) | JonathanFly/bark fork | Speech + nonverbals in target voice |
| Voice Design from text (no reference needed) | ElevenLabs v3 Voice Design (commercial) | Voice from text description |

### Best-practice clone source preparation

1. **Get clean audio of the target speaker.** Source: a clean YouTube interview, podcast, audiobook. Avoid music + speech in the same clip.
2. **Separate stems with Demucs / UVR5.** `htdemucs_ft` for music-heavy; `UVR-MDX-NET-Voc_FT` for speech-only.
3. **Denoise the vocal.** Use a denoiser (Resemble Enhance, Facebook Denoiser, or `noisereduce` Python package) if the vocal is noisy.
4. **Trim to the right length.** XTTS-v2: 6-24 s. F5-TTS: 3-10 s. RVC: 10-50 min for training. Bark: 5-20 s.
5. **Pick the right model for the target use case.** TTS (text-to-voice) vs SVC (voice-to-voice).

### Style / voice cloning on Suno v4.5+

Suno v4.5+ does NOT support voice cloning (text-based filter rejects artist names + voice mimicry attempts). The legitimate workarounds:

1. **Upload + Cover**: record/synthesize a rough vocal in Bark / XTTS / F5-TTS with the exact lyrics, upload as reference, use Suno "Cover" to build the full track in a new style.
2. **Upload + Extend**: similar to Cover but extends the input audio.
3. **Bark + Suno workflow**: Bark generates the vocal stem in the target voice; Suno v4.5+ generates the instrumental accompaniment; mix in post.

### Style transfer (genre swap without voice swap)

For "make this song in a different genre" without changing the voice:
- Udio Remix (commercial) — upload audio + new style prompt.
- Suno Cover (commercial) — same.
- MusicGen Melody (open weights) — text + melody conditioning.
- MusicGen Style (open weights) — text + style audio.

### Mesh integration for the voice clone pipeline

```
+---------------------+      +----------------+      +---------------------+
| YouTube / podcast / | ---> | Demucs / UVR5  | ---> | clean vocal .wav    |
| audiobook source    |      | stem separation|      | (24 kHz, mono)      |
+---------------------+      +----------------+      +---------------------+
                                                            |
                                                            v
                                            +-----------------------------+
                                            | Voice clone target          |
                                            |  - XTTS-v2 (6 s, TTS)       |
                                            |  - F5-TTS (3-10 s, TTS)     |
                                            |  - RVC v2 (10-50 min, SVC)  |
                                            |  - So-VITS-SVC (10-30 min)  |
                                            |  - Bark fork (5-20 s, TTS)  |
                                            +-----------------------------+
                                                            |
                                                            v
                                            +-----------------------------+
                                            | Mix into instrumental       |
                                            |  - Suno v4.5+ Extend        |
                                            |  - MusicGen / Stable Audio  |
                                            |  - AudioGen / Udio          |
                                            +-----------------------------+
```

---

## 7. Metatag / style-tag deep-dive across the audio-gen toolchain

### The SGM metatag corpus (origin)

`99-ARCHIVE-SEEDS/agents/suno-god-mode.md` documents the 18,189-keyword SunoCode-Herm corpus across 493 domains. The metatag syntax is `[**category** attribute — value]`. Categories include vocal types, chord progressions, song structures, drum patterns, bass design, one-shot SFX, ambient pads, production FX, instrumental textures, mood direction, genre taxonomy, dynamics, era production.

### Cross-tool metatag compatibility

| Tag type | Suno v4.5+ | Bark | MusicGen | AudioGen | Stable Audio Open |
|---|---|---|---|---|---|
| `[Verse]` `[Chorus]` `[Bridge]` `[Intro]` `[Outro]` | YES (structural) | NO (use text paragraph) | NO (duration) | NO (duration) | NO (duration) |
| `[Whispered]` `[Belted]` `[Falsetto]` | YES (vocal) | IMPLIED (lowercase / CAPS) | NO (vocal) | NO (vocal) | NO (vocal) |
| `[Vinyl Crackle]` `[Rain]` `[Applause]` | YES (SFX) | YES (text prompt) | NO (SFX model) | YES (text prompt) | YES (text prompt) |
| `[Male Vocals]` `[Female Vocals]` | YES | YES (`MAN:` `WOMAN:`) | NO | NO | NO |
| `[High Energy]` `[Low Energy]` `[Build-up]` `[Drop]` | YES (dynamics) | YES (text prompt) | YES (text prompt) | YES (text prompt) | YES (text prompt) |
| `[Melancholic]` `[Euphoric]` `[Nostalgic]` | YES (atmosphere) | YES (text prompt) | YES (text prompt) | YES (text prompt) | YES (text prompt) |
| `[Guitar Solo]` `[Instrumental Break]` | YES (structural) | YES (`♪ ... ♪`) | YES (text prompt) | YES (text prompt) | YES (text prompt) |
| `[Harmonies]` `[Choir]` `[Harmonized Chorus]` | YES (vocal arrangement) | NO | NO | NO | NO |
| `[Explosive]` `[Emotional Climax]` `[Orchestral swell]` | YES (dynamics) | YES (text prompt) | YES (text prompt) | YES (text prompt) | YES (text prompt) |

### Style-field engineering (SGM formula) — extended to other tools

The SGM formula: `Genre + Mood + Era + Instruments + Vocal Style + Production + Dynamics`. For each tool:

#### Suno v4.5+ (Custom Mode Style field, 1000 chars)

```
Begins as a haunting whisper over sparse piano. Gradually layers
in muted brass. Builds through the chorus with full orchestra.
Second verse erupts with raw belting intensity. Outro strips back
to a lone piano and a fragile whisper fading to silence.
```

#### Bark (text prompt, 14 s coherent window)

```
"Well [sighs] I guess this is it. [laughs] Never thought I'd see the
day. ♪ Rolling down the highway ♪ [music]"
```

The Bark text prompt is the lyrics + nonverbals + structural markers. No separate Style field.

#### MusicGen (text prompt, duration param)

```python
musicgen.generate([
    "80s synthwave with gated reverb drums, dark pulsing bassline, "
    "analog synth lead, melancholic and cinematic, builds to an emotional climax"
], duration=30)
```

#### AudioGen (text prompt, duration param)

```python
audiogen.generate([
    "ambient forest soundscape at dusk with birdsong, distant thunder, "
    "soft wind through leaves, no music"
], duration=20)
```

#### Stable Audio Open (text prompt, max 47 s)

```
"warm arpeggios on an analog synthesizer with a gradually rising
filter cutoff and a reverb tail"
```

#### Udio Manual Mode (tag-list format, 750 chars)

```
neo-soul, r&b, 2020s, sultry, warm rhodes electric piano, upright bass,
brushed drums, layered female harmonies, analog warmth, 84 BPM, D minor
```

### Phonetic tricks (SGM) — only applicable to vocal models

The SGM phonetic tricks (ALL CAPS, vowel extension, ellipses, hyphenated stretch, phonetic respelling, spell out numbers, space acronyms) apply to:
- Suno v4.5+ lyrics
- Bark text (partial — Bark's phoneme-free generative audio is more forgiving)
- XTTS-v2 / F5-TTS / TTS for any cloned voice output

They do NOT apply to:
- MusicGen (instrumental)
- AudioGen (foley/SFX)
- Stable Audio Open (instrumental + SFX)

### Style-field writing — pro tips (carried from SGM)

1. **NO artist names or trademarks.** Describe the sound. `sounds like Adele` triggers the vocal-cloning filter on Suno; `a weathered torch singer with a smoky alto, slight rasp, who starts vulnerable and builds to devastating power` does not.
2. **Specify BPM and key when you have a preference.** `92 BPM, D minor`.
3. **Use Exclude Styles field for what you DON'T want.** `pop-punk, cheerful, bright`.
4. **Unexpected genre combos can be gold.** `bossa nova trap`, `Appalachian gothic`, `chiptune jazz`. Especially powerful for MusicGen where the training data is broad.
5. **Build a vocal PERSONA, not just a gender.** See SGM, 9th style-field tip.
6. **Iterate 3-5 times per session.** The first generation is rarely the best.

### Style-field by tool — what works best

#### Suno v4.5+ Style field

Prose: `Begins as X, then Y, then Z`. Long-form descriptive. Carries structure.

#### Udio Manual Mode

Tag-list: `[genre], [subgenre], [era], [mood], [instruments list], [vocal descriptor], [production adjective], [BPM], [key]`. Short tokens.

#### MusicGen

Prose with concrete descriptors: `80s pop track with bassy drums and synth`, `90s rock song with loud guitars and heavy drums`. The Hugging Face demo uses ~30-word descriptions.

#### AudioGen

Acoustic-scene prose: `a dog barks twice then a car horn in the distance`, `rain on a tin roof with distant thunder`. Not musical terms.

#### Stable Audio Open

Production-prose: `warm arpeggios on an analog synthesizer with a gradually rising filter cutoff and a reverb tail`. Sound-design prose.

### The SGM 18,189-keyword corpus — applicable domains

From `phase1_agent01-15.json` and `phase2_agent16-19.json`:

- **vocal types**: 100+ voice descriptors (whispered, belted, falsetto, breathy, raspy, gritty, soulful, melismatic, etc.)
- **chord progressions**: 200+ (I-V-vi-IV, ii-V-I, 12-bar blues, etc.)
- **song structures**: 50+ (ABABCB, AABA, strophic, through-composed, etc.)
- **drum patterns**: 300+ (four-on-the-floor, breakbeat, bossa nova clave, trap hi-hats, etc.)
- **bass design**: 150+ (808 sub, fingerstyle upright, fretless, synth bass, etc.)
- **one-shot SFX**: 200+ (vinyl crackle, rain, thunder, applause, etc.)
- **ambient pads**: 250+ (warm analog pad, shimmering granular, dark drone, etc.)
- **production FX**: 200+ (tape saturation, bit-crush, plate reverb, side-chain compression, etc.)
- **instrumental textures**: 400+ (orchestral, electric, acoustic, hybrid)
- **mood direction**: 200+ (melancholic, euphoric, aggressive, dreamy, intimate, etc.)
- **genre taxonomy**: 1500+ (hip-hop, electronic, rock/metal, pop, R&B, jazz, classical, folk, world, etc.)
- **dynamics**: 100+ (crescendo, decrescendo, drop, build, breakdown, etc.)
- **era production**: 200+ (1960s, 1970s, 1980s, 1990s, 2000s, 2010s, 2020s, future, retro)

These map 1:1 to text prompts for MusicGen / AudioGen / Stable Audio Open. The corpus is in `~/worm-handoff/hermes-user-data/SunoCode-Herm/phase*.json`.

---

## 8. Generation pipeline integration

### Sovereign audio generation pipeline (mesh-deployable)

```
+----------+      +-----------+      +-------------+      +---------------+
| Source:  | ---> | Stem sep  | ---> | Vocals .wav | ---> | Voice clone   |
| YouTube, |      | Demucs /  |      | (clean, 24  |      | target:       |
| podcast, |      | UVR5      |      |  kHz, mono) |      | RVC / SVC /   |
| audiobook|      |           |      |             |      | Bark / XTTS   |
+----------+      +-----------+      +-------------+      +---------------+
                       |                                          |
                       v                                          v
                  +---------+                              +-----------+
                  | Inst    |                              | Cloned    |
                  | .wav    |                              | voice     |
                  +---------+                              | .wav      |
                       |                                  +-----------+
                       v                                       |
                  +-------------+                              v
                  | Style swap  |                       +-------------+
                  | MusicGen    |                       | TTS prompt  |
                  | Style /     |                       | (text ->    |
                  | Stable      |                       |  voice)     |
                  | Audio Open  |                       +-------------+
                  +-------------+                              |
                       |                                       |
                       v                                       v
                  +---------------------------------------------+
                  |                  Mix stem                   |
                  |  (DAW / ffmpeg / audacity / sox)           |
                  +---------------------------------------------+
                                       |
                                       v
                                  +---------+
                                  | Master  |
                                  | .wav    |
                                  +---------+
```

### Per-tool mesh assignment (WORM / HERM / dirt-imac + Tailscale GPU peers)

| Stage | Best mesh box | Why |
|---|---|---|
| Source acquisition (yt-dlp, ffmpeg) | Any (CPU) | I/O bound |
| Stem separation (Demucs / UVR5) | Tailscale GPU peer | Heavy compute |
| Denoising (noisereduce / Resemble Enhance) | Tailscale GPU peer | Heavy compute |
| Voice clone training (RVC / So-VITS) | Tailscale GPU peer | Heavy compute |
| Voice clone inference (RVC / So-VITS) | WORM (4 GB VRAM) | Real-time feasible |
| Bark generation | WORM (4 GB VRAM, small model) | 14 s clips |
| MusicGen / AudioGen | Tailscale GPU peer | Heavy compute |
| Stable Audio Open | Tailscale GPU peer | Heavy compute |
| Suno v4.5+ vocal song generation | Cloud (Suno) | No local path; cloud-only |
| Mixing / mastering | Any (CPU) | Light compute |
| Whisper transcription of source | WORM (CPU) | Realtime |
| FunASR transcription of source | HERM S22 (CPU) or Tailscale GPU peer | 17-170x realtime |
| Translation (Whisper / DeepL / DeepSeek) | Tailscale mesh | Per-service |

### Failure mode recovery

| Failure | Recovery |
|---|---|
| Suno v4.5+ red banner on prompt | Route to Bark (offline, no filter) for the same lyrics |
| Udio artist-mimicry filter | Route to RVC v2 — convert your own singing into target voice offline |
| Demucs memory error on long song | Split source into < 5 min chunks via ffmpeg; run htdemucs on each |
| Bark voice drift on long-form | Use bark-infinity fork's coherent-long-form mode; or split on sentence boundaries with the same `history_prompt` |
| RVC training time exceeded (GPU unavailable) | Use So-VITS-SVC 5.0 with batch_size=2 on 4 GB VRAM, or rent a Tailscale peer |
| XTTS-v2 voice clone sounds robotic | Lower `repetition_penalty` to 2.0-3.0; add `temperature=0.85`; use longer, more varied reference audio |
| MusicGen / Stable Audio output has vocals | Stable Audio Open is non-vocal by design; MusicGen-small sometimes adds vocals — use `melody` model with `melody=None` or use larger checkpoint |
| Demucs / UVR5 contaminates vocal with instrumental | Use a higher-SDR model (htdemucs_ft or Ensemble 2024.02) |

### Udio / Suno Cover workflow for filter bypass

1. **Bark / XTTS / F5-TTS** generates a rough vocal of the target lyrics in a target voice.
2. **Demucs / UVR5** cleans the bark vocal (remove breaths, normalize).
3. **Upload the cleaned vocal to Suno v4.5+ Cover** with a new style prompt.
4. Suno re-performs the vocal in a different style, with new instrumental accompaniment.
5. The input was audio, not text — so Suno's input-side filter did not see the lyrics.

The same workflow applies to **Udio Remix**: upload the Bark vocal, prompt only style tags, the filter sees clean style, not the lyrics.

### Voice conversion (any-to-any) for filter-bypass

1. **Sing or speak** the target lyrics in your own voice.
2. **RVC v2** converts to the target singer's voice offline (no filter, no upstream review).
3. **Demucs / UVR5** isolates the converted vocal.
4. **MusicGen / Stable Audio Open** generates the new instrumental accompaniment.
5. **Mix** the converted vocal + new instrumental in a DAW.

This pipeline is the sovereign alternative to Suno v4.5+ when the prompt-side filter blocks your concept.

---

## 9. Per-tool reference summary

### Bark (Suno) — see Section 1

### MusicGen (Meta)

- Pretrained: small (300M) / medium (1.5B) / large (3.3B); melody variants
- Inference: `audiocraft.models.MusicGen.get_pretrained(...)`; HF `transformers` path
- 16 GB VRAM for medium/large; 4 GB for small; CPU mode not viable
- CC-BY-NC weights
- text-prompt: ~30-word descriptive prose

### AudioGen (Meta)

- Same as MusicGen but trained on public sound effects
- Best for foley, ambient, SFX
- CC-BY-NC weights

### Stable Audio Open (Stability)

- Up to 47 s of samples and sound design
- Trained on Freesound + Free Music Archive
- Free for non-commercial / small commercial; enterprise for full commercial
- text-prompt: production-prose with concrete synth / effect terms

### Demucs (Meta)

- 4-stem (vocals/drums/bass/other) or 6-stem (htdemucs_6s)
- Models: htdemucs / htdemucs_ft / htdemucs_6s / mdx_extra_q
- CLI: `demucs song.mp3`; API: `demucs.api.Separator`
- Output: `separated/MODEL_NAME/TRACK_NAME/{vocals,drums,bass,other}.wav` at 44.1 kHz
- MIT (code); research weights

### UVR5

- Models: VR Arch / MDX-NET / MDX23C / Mel-Band Roformer / BS Roformer / Demucs v4 / VIP
- Best SDR on vocals: Ensemble 2024.02 (12.76 dB Multisong Vocals SDR)
- UI: Windows / Linux installer scripts; Docker; CLI: `audio-separator`
- MIT (UI); per-model weights

### RVC v2 — see `06-MULTIMODAL/audio/uncensored-tts-stt.md`

### So-VITS-SVC 4.0 / 5.0 — see `06-MULTIMODAL/audio/uncensored-tts-stt.md`

---

## 10. File relationships

This file extends:

- `99-ARCHIVE-SEEDS/agents/suno-god-mode.md` — the SGM persona (18,189-keyword corpus, metatag syntax, style-field engineering)
- `06-MULTIMODAL/audio/bark-local.md` — Bark local recipe
- `06-MULTIMODAL/audio/xtts-local.md` — XTTS-v2 voice cloning
- `06-MULTIMODAL/audio/elevenlabs-voice-cloning.md` — ElevenLabs (commercial; for Voice Design from text + the IVC vs PVC filter posture)
- `06-MULTIMODAL/audio/udio-uncensored.md` — Udio (commercial; Suno peer)
- `06-MULTIMODAL/audio/suno-god-mode.md` — Suno v4.5+ curated recipe
- `06-MULTIMODAL/audio/uncensored-tts-stt.md` — TTS + STT compendium (this directory)
- `09-EDUCATIONAL/tutorials/05-suno-god-mode-walkthrough.md` — sovereign workflow tutorial

The 18,189-keyword corpus lives at `~/worm-handoff/hermes-user-data/SunoCode-Herm/phase*.json` (see `06-MULTIMODAL/audio/suno-god-mode.md` note line 110).

---

## Sources

- Suno Bark: https://github.com/suno-ai/bark | https://github.com/JonathanFly/bark | https://huggingface.co/suno/bark
- Meta AudioCraft: https://github.com/facebookresearch/audiocraft | https://facebookresearch.github.io/audiocraft/ | https://facebookresearch.github.io/audiocraft/docs/MUSICGEN.html | https://ai.meta.com/resources/models-and-libraries/audiocraft/
- Stable Audio Open: https://stability.ai/news-updates/introducing-stable-audio-open | https://stability.ai/stable-audio | https://stableaudio.com/user-guide
- Demucs: https://github.com/facebookresearch/demucs | https://dev.to/stevecase430/complete-guide-to-setting-up-demucs-locally-for-ai-stem-separation-580h | https://dibi8.com/resources/ai-tools/demucs
- UVR5: https://github.com/AdamRopelewski/UVR5-UI-Docker | https://github.com/marpogiii-code/UVR5-UI | https://mvsep.com/en/algorithms
- SGM (existing): `99-ARCHIVE-SEEDS/agents/suno-god-mode.md` | `06-MULTIMODAL/audio/suno-god-mode.md` | `09-EDUCATIONAL/tutorials/05-suno-god-mode-walkthrough.md`
- RVC: https://github.com/RVC-Project/Retrieval-based-Voice-Conversion | https://nexgpu.net/en/models/rvc
- So-VITS-SVC: https://github.com/camenduru/so-vits-svc | https://github.com/ouor/so-vits-svc-5.0
- XTTS-v2: https://huggingface.co/coqui/XTTS-v2 | https://github.com/coqui-ai/TTS
- F5-TTS: https://github.com/cocktailpeanut/F5-TTS | https://huggingface.co/rajkr/voice-clone-f5tts
- OpenVoice v2: https://huggingface.co/myshell-ai/OpenVoiceV2 | https://github.com/myshell-ai/OpenVoice
- Fish-Speech 1.5: https://huggingface.co/fishaudio/fish-speech-1.5 | https://github.com/fishaudio/fish-speech


---

## Deep reference

Comprehensive single-file reading experience for this layer: see UNMODERATED-MULTIMODAL at repo root.
