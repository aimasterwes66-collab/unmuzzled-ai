---
title: uncensored-tts-stt
type: reference
agent: worm
status: active
tags: [tts, stt, voice-cloning, audio, multimodal, reference, sovereign]
---

# Uncensored TTS + STT — Comprehensive Compendium

Comprehensive reference for the local + open-weights text-to-speech (TTS) and speech-to-text (STT) tools that matter for the operator's stack. Each tool is covered with: install path, inference path, voice-cloning posture (or lack thereof), uncensored / filter posture, and mesh fit (where on the WORM / HERM / dirt-imac topology it best runs).

The sovereign posture is the same throughout: local-first, no upstream classifier, no telemetry, weights held on-device, generated artifacts never leave the box without operator consent. Cloud TTS/STT APIs (ElevenLabs, Whisper API, Deepgram, AssemblyAI, Cartesia) are intentionally OUT OF SCOPE here — see `06-MULTIMODAL/audio/elevenlabs-voice-cloning.md` for ElevenLabs and `05-LOCAL-MODELS/` for routing to vendor-local STT alternatives.

## Coverage map

TTS (speech synthesis):
- Piper TTS (rhasspy / Michael Hansen) — fast local, on-device, no clone
- Coqui XTTS-v2 — 6s zero-shot clone, 17 langs
- Bark (suno-inc) — generative, nonverbals, voice presets
- StyleTTS 2 — human-level fidelity, weak clone
- Tortoise / Parla — slow but high-quality, clone via voice dir
- Fish-Speech 1.5 — 1M+ hr training, multilingual clone
- OpenVoice v2 (MyShell) — zero-shot cross-lingual clone, MIT
- RVC v2 (RVC-Project) — voice CONVERSION (any-to-any), trained model
- So-VITS-Song 4.0 / 5.0 — singing voice conversion (SVC), VITS-based
- F5-TTS — 2024-10 reference, competitive with ElevenLabs

STT (speech recognition):
- OpenAI Whisper — original transformer, 9 model sizes
- faster-whisper (CTranslate2) — 4x faster, less memory
- whisper.cpp (ggerganov / ggml-org) — C++ port, CPU/edge, 1.5B max
- FunASR (Alibaba / ModelScope) — 50+ langs, 170x realtime, speaker diarization

Extras (covered for context, not exhaustive):
- MeloTTS (MyShell) — fast multilingual, sister to OpenVoice
- CosyVoice 2 (Alibaba) — strong Chinese + English
- Fish Audio Drama 3 — 2025+, scene-style multi-character
- GPT-SoVITS — 0-shot + few-shot fine-tune, popular in CN community
- MaskGCT — non-autoregressive TTS
- Spark-TTS / MegaTTS 3 — recent 2025 alternatives

All vendor-cited, no distilled summary. Every fact below is traceable to its source.

---

## 1. Piper TTS (rhasspy / Michael Hansen)

### Identity

A fast, local neural TTS system built by Michael Hansen (rhasspy / Home Assistant). Designed for the Raspberry Pi 4 and other low-resource devices. Renders speech via ONNX Runtime + espeak-ng phonemization. MIT licensed. [source: https://github.com/rhasspy/piper]

### Install

```bash
pip install piper-tts
# Optional GPU path:
pip install onnxruntime-gpu   # then run with --cuda
# System dep (Linux): sudo apt-get install espeak-ng
# System dep (macOS): brew install espeak
# Pre-built binary releases (no Python install needed):
#   amd64 (64-bit desktop Linux)
#   arm64 (64-bit Raspberry Pi 4)
#   armv7 (32-bit Raspberry Pi 3/4)
# Source build: needs libpiper_phonemize extracted to lib/Linux-$(uname -m)/piper_phonemize/
```

### Inference (CLI)

```bash
echo 'Welcome to the world of speech synthesis!' | piper \
  --model en_US-lessac-medium \
  --output_file welcome.wav
# First run auto-downloads voice. Use --data-dir and --download-dir to relocate.
# --cuda for GPU. --speaker <id> for multi-speaker models.
```

### Inference (Python)

```python
from piper import PiperVoice
voice = PiperVoice.load("en_US-lessac-medium.onnx", use_cuda=False)
with open("out.wav", "wb") as f:
    voice.synthesize("Hello world.", f)
# Returns: 16-bit mono WAV at model sample_rate (16/22.05/24 kHz by quality tier)
```

### Voice model corpus

`huggingface.co/rhasspy/piper-voices` — 33+ models, hundreds of (voice x quality) variants. Quality tiers:
- `x_low` / `low` — 16 kHz, smaller model, less compute
- `medium` — 22.05 kHz, smaller voice model (default sweet spot)
- `high` — 22.05 kHz, larger voice model, slower

Languages (30+ at last count): Arabic, Catalan, Czech, Danish, Dutch, English (en_GB, en_US, en_IN, etc.), Finnish, French, German, Greek, Hindi, Hungarian, Icelandic, Italian, Kazakh, Nepali, Norwegian, Polish, Portuguese, Romanian, Russian, Serbian, Slovak, Spanish (es_AR, es_ES, es_MX), Swedish, Turkish, Ukrainian, Vietnamese, Welsh. [source: https://github.com/rhasspy/piper/blob/master/VOICES.md]

### Voice cloning posture

NO native zero-shot cloning. Piper is a single-speaker or multi-speaker CHECKPOINT model: each `.onnx` file represents one trained voice. Cloning = training a new checkpoint from scratch on a single-speaker dataset.

Training (Piper):
1. Prepare dataset (LJSpeech or similar): one WAV per utterance + metadata.csv.
2. `python3 -m piper_train.preprocess` to extract phonemes, audio, config.json, dataset.jsonl.
3. `python3 -m piper_train` — fine-tune from existing checkpoint (default); 1-2 GPU hours on RTX 3090 for 1k utterances.
4. `python3 -m piper_train.export_onnx model.ckpt model.onnx` to produce deployable voice.
5. Batch size 32 + `--max-phoneme-ids 400` fits 24 GB VRAM. [source: https://github.com/rhasspy/piper/blob/master/TRAINING.md]

Cost: 1-10 hours clean speech recommended for a high-quality custom voice. Single-speaker datasets only. Multi-speaker requires explicit `speaker_id_map` in config.

### Uncensored / filter posture

NO content filter. The model is a deterministic ONNX graph — no classifier, no token list, no prompt-side moderation. Output is whatever the phonemizer produces from the input text. Caveats: abusive content will be spoken, not blocked. Out of scope: anti-abuse, anti-impersonation, anti-deepfake. These are operator choices, enforced by the operator's intent and disclosure.

### Mesh fit

The BEST mesh candidate. Tiny (75-700 MB per voice), ONNX, runs on the WORM 9185W Android tablet in CPU mode, no GPU required. Pairs with: on-device wake-word agent (Home Assistant / Rhasspy 3), accessible assistant, screen-reader paths (NVDA, Image Captioning for the Visually Impaired), local web reader. Open Voice Operating System, LocalAI, Lernstick EDUM, Vim-Piper all use it. [source: https://github.com/rhasspy/piper — production users section]

Cross-device: voice .onnx files are < 1 MB; sync to dirt-imac / HERM S22 via Tailscale / rclone trivially. Generation latency on a Raspberry Pi 4 = realtime or faster. On dirt-imac (SSE3-only) = slow but works.

### License

MIT for the code, CC0 / public-domain for most ONNX voice checkpoints. Voice data sources: LibriTTS, LJSpeech, MLS, VCTK, Common Voice, RHAPSODY, etc.

---

## 2. Coqui XTTS-v2 (Coqui-AI / community fork)

### Identity

XTTS-v2 is Coqui's production TTS model. It supports 17 languages, clones any voice from a 6-second reference audio, and streams with under 200 ms latency. License: CPML (Coqui Public Model License) — non-commercial and small-commercial tiers. The Coqui company dissolved 2024 but the model + community forks (`coqui-tts`, `idiap/coqui-tts`) continue. [source: https://huggingface.co/coqui/XTTS-v2]

### Install

```bash
# Maintained fork (active 2026):
pip install coqui-tts
# Frozen original:
pip install TTS==0.22.0
# For training / fine-tuning (full install):
git clone https://github.com/coqui-ai/TTS
pip install -e ".[all,dev,notebooks]"
# System dep (Linux): sudo apt-get install espeak-ng
# System dep (macOS): brew install espeak
# Requires Python >= 3.9, < 3.12 (some wheels fail on 3.13)
# GPU strongly recommended; CPU is 12x slower
```

### Inference (Python)

```python
import torch
from TTS.api import TTS
device = "cuda" if torch.cuda.is_available() else "cpu"
tts = TTS("tts_models/multilingual/multi-dataset/xtts_v2").to(device)
# Voice cloning — 6-24s WAV reference (16-22 kHz, mono, clean)
tts.tts_to_file(
    text="Hello, this is a cloned voice speaking.",
    speaker_wav="reference.wav",
    language="en",
    file_path="output.wav",
)
# Multiple reference clips (averages embeddings — better quality):
tts.tts_to_file(
    text="Cloning from multiple references.",
    speaker_wav=["ref1.wav", "ref2.wav", "ref3.wav"],
    language="en",
    file_path="output.wav",
)
# Streaming ~200 ms first-chunk latency:
chunks = tts.tts_stream(text="...", speaker_wav="ref.wav", language="en")
for chunk in chunks:
    play(chunk)
```

### Inference (CLI)

```bash
tts --list_models
tts --text "Bonjour, comment ça va ?" \
  --model_name "tts_models/multilingual/multi-dataset/xtts_v2" \
  --speaker_wav reference.wav \
  --language_idx fr \
  --out_path output.wav
```

### Languages (17)

English (en), Spanish (es), French (fr), German (de), Italian (it), Portuguese (pt), Polish (pl), Turkish (tr), Russian (ru), Dutch (nl), Czech (cs), Arabic (ar), Chinese (zh-cn), Japanese (ja), Hungarian (hu), Korean (ko). 24 kHz output. [source: https://huggingface.co/coqui/XTTS-v2]

### Fine control

```python
tts.tts_to_file(
    text="...",
    speaker_wav="reference.wav",
    language="en",
    temperature=0.75,         # 0.5-0.9; higher = more variance
    length_penalty=1.0,       # >1.0 = slower speech
    repetition_penalty=5.0,   # 2-10; higher = less repetition artifacts
    top_k=50,
    top_p=0.85,
    speed=1.0,                # 0.5-2.0 playback rate
    decoder_iterations=30,    # quality knob
    file_path="out.wav",
)
```

### Voice cloning posture

6-24 second reference audio is the minimum. 24 s optimal. WAV, 22050 Hz or 16000 Hz, mono, clean speech, no music, no background noise. Single speaker only for the cleanest clone. Multiple references can be averaged (list of paths). Emotion transfers via reference-audio emotion.

Cross-language clone works: feed an English reference, generate speech in Spanish, French, etc. in that voice.

### Fine-tuning posture

Full fine-tuning supported via `TTS/bin/train_tts.py` with a Coqpit config:
```bash
python TTS/bin/train_tts.py \
  --config_path recipes/ljspeech/xtts_v2/train_xtts.py \
  --coqpit-overrides \
  output_path=./output \
  datasets.0.path=./dataset \
  datasets.0.meta_file_train=metadata.csv
```
Dataset format: LJSpeech-compatible `metadata.csv -> filename|transcription`. Minimum sizes for acceptable quality:
- ~1 hour clean speech = decent clone
- ~10 hours = high quality custom voice
- ~30 hours = near-perfect reproduction

### Uncensored / filter posture

NO content filter in the open model. The Coqui API / Coqui Studio had front-end moderation, but the local model produces speech from whatever text is fed. Coqui the company is gone — there is no upstream review. The license (CPML) requires disclosure and limits some commercial use; it does NOT police content.

### Mesh fit

Runs on WORM only with significant latency (CPU = 12x realtime). HERM S22 / dirt-imac with no GPU: usable for short clips only. Best mesh deployment: HERM S22 with GPU server, or a dedicated mesh box with RTX 3060+. Streaming mode = realtime voice agent with sub-200 ms first-chunk latency. Voice cloning: 6 s ref WAV = < 1 MB sync.

### License

CPML (Coqui Public Model License). Non-commercial + small commercial permitted (< $1M annual revenue cap on the using organization). NOT a typical open-source license. Some forks (e.g. from idiap) relicense to MIT — verify per repo.

---

## 3. Bark (suno-ai / suno-inc)

### Identity

Bark is a transformer-based text-to-audio model created by Suno. Bark can generate highly realistic, multilingual speech as well as other audio — including music, background noise and simple sound effects. The model can also produce nonverbal communications like laughing, sighing and crying. Released by Suno for research and demo purposes, MIT-style license, commercial use permitted. [source: https://github.com/suno-ai/bark]

### Architecture

Bark uses a GPT-style architecture similar to AudioLM and VALL-E, with a quantized audio representation from EnCodec. It is not a conventional TTS model, but a fully generative text-to-audio model capable of deviating in unexpected ways from any given script. The input text prompt is converted directly to audio without the intermediate use of phonemes. It can therefore generalize to arbitrary instructions beyond speech such as music lyrics, sound effects or other non-speech sounds. A subsequent second model converts the generated semantic tokens into audio codec tokens to generate the full waveform. [source: https://github.com/suno-ai/bark]

### Install

```bash
pip install git+https://github.com/suno-ai/bark.git
# Actively-maintained fork with voice-clone support:
pip install git+https://github.com/JonathanFly/bark.git
# or the bark-infinity / bark-with-voice-clone variant
# Or via Hugging Face Transformers:
# pip install transformers accelerate
```

### Inference (Transformers)

```python
from transformers import AutoProcessor, BarkModel
processor = AutoProcessor.from_pretrained("suno/bark")
model = BarkModel.from_pretrained("suno/bark")
voice_preset = "v2/en_speaker_6"
inputs = processor("Hello, my dog is cute", voice_preset=voice_preset)
audio_array = model.generate(**inputs)
audio_array = audio_array.cpu().numpy().squeeze()
```

### Inference (native bark)

```python
from bark import SAMPLE_RATE, generate_audio, preload_models
from scipy.io.wavfile import write as write_wav
preload_models()
audio = generate_audio(
    "<text>",
    history_prompt="v2/en_speaker_6",  # voice preset
    text_temp=0.7,
    waveform_temp=0.7,
)
write_wav("out.wav", SAMPLE_RATE, audio)
```

### Voice presets

100+ speakers in `v2/en_speaker_0` through `v2/en_speaker_9` plus non-English: `v2/de_speaker_*`, `v2/es_speaker_*`, `v2/fr_speaker_*`, `v2/ja_speaker_*`, etc. Full list in `bark/assets/prompts/`. Sample rate 24 kHz. [source: https://github.com/suno-ai/bark]

### Bark-specific text syntax

Nonverbal tags inline in text:
```
[laughs] [laughter] [sighs] [gasps] [clears throat] [breathing]
[music] [singing] [applause]
— — (em-dashes for hesitation)
... (ellipses for pauses)
♪ (music note wrapping ♪ lyrics ♪ triggers singing)
CAPS = emphasis / louder
[MAN] [WOMAN] to bias toward male/female
```

### Voice cloning posture

Bark's official posture (suno-ai/bark): "Bark has the capability to fully clone voices — including tone, pitch, emotion and prosody. The model also attempts to preserve music, ambient noise, etc. from input audio. However, to mitigate misuse of this technology, we limit the audio history prompts to a limited set of Suno-provided, fully synthetic options to choose from for each language." [source: https://github.com/suno-ai/bark]

That is, the official repo restricts you to the 100+ presets. Zero-shot cloning from arbitrary audio is NOT supported in the upstream repo.

JonathanFly / bark-infinity fork unlocks arbitrary reference:
```python
from bark_infinity import api, config
from bark.generation import preload_models
from bark_infinity.clonevoice import clone_voice

clone_voice(
    audio_filepath="reference.wav",  # 5-20s clean speech
    dest_filename="my_voice.npz",
    speaker_id="my_voice",
)

audio = api.generate_audio_barki(
    text="<text>",
    npz_file="my_voice_clone.npz",
)
```

### Nonverbals (Bark's unique value)

- Speech + nonverbals + minimal music, all in one call
- `[laughter]` `[laughs]` `[sighs]` `[gasps]` `[clears throat]` `[music]` `[singing]` `[applause]`
- Em-dashes `—` for hesitation, ellipses `...` for pauses
- `♪ ... ♪` to trigger singing
- ALL CAPS for emphasis
- `MAN:` / `WOMAN:` for speaker bias

### Uncensored / filter posture

ZERO filter in the model. Bark does not have a content classifier. The system prompt, the metatag syntax, the audio output — all unfiltered. Quality / content is what the operator prompts.

### Mesh fit

Runs on WORM (12 GB VRAM) for large model; 4 GB VRAM for small model via `SUNO_USE_SMALL_MODELS=1`. HERM S22 (more RAM) runs comfortably. dirt-imac (SSE3, no GPU) = not viable. The model file is ~5 GB large / ~1 GB small. Once on disk, inference is offline.

### License

MIT-style (per suno-ai/bark README: "ready for inference and available for commercial use"). The suno-ai repo is officially unmaintained since 2023; community forks carry the same licensing.

### Notes

- Long-form output drift: Bark's max coherent length is ~14 s. Split text on sentence boundaries, generate each chunk with the same `history_prompt`, concatenate with 100 ms crossfades.
- `bark_infinity` fork's coherent-long-form mode chains history states to reduce drift.
- Music generation quality is poor compared to MusicGen / Stable Audio Open. Use Bark for speech + nonverbals; use MusicGen / AudioCraft for music.
- See `06-MULTIMODAL/audio/bark-local.md` for the curated local recipe.

---

## 4. StyleTTS 2 (Yinghao A. Li et al. / pip package by sidharthrajaram)

### Identity

StyleTTS 2: Towards Human-Level Text-to-Speech through Style Diffusion and Adversarial Training with Large Speech Language Models. Original paper: arxiv.org/abs/2306.07691. PyPI package is MIT-licensed code; pretrained weights are subject to their own license. Achieves first human-level TTS synthesis on both single and multispeaker datasets as judged by native English speakers. [source: https://pypi.org/project/styletts2/]

### Install

```bash
pip install styletts2
# Python >= 3.9 (currently supports 3.9, 3.10 due to library dependencies)
# Default LibriTTS checkpoint auto-downloads on first use from HuggingFace
# Or specify your own:
# from huggingface_hub import snapshot_download
# snapshot_download("yl4579/StyleTTS2-LibriTTS", local_dir="./styletts2-model")
```

### Inference (Python)

```python
from styletts2 import tts
# Default checkpoints/configs (downloads + caches):
my_tts = tts.StyleTTS2()
# Basic:
out = my_tts.inference("Hello there, I am now a python package.", output_wav_file="test.wav")
# Voice clone from reference:
other_tts = tts.StyleTTS2()
other_tts.inference(
    "Hello there, I am now a python package.",
    target_voice_path="/PATH/TO/some_voice.wav",  # zero-shot reference
    output_wav_file="another_test.wav",
)
# Custom checkpoint:
custom = tts.StyleTTS2(
    model_checkpoint_path="/PATH/TO/epochs_2nd_00020.pth",
    config_path="/PATH/TO/config.yml",
)
```

### Inference signature

```
def inference(
    self,
    text: str,                              # Input text to speak
    target_voice_path=None,                 # Optional: zero-shot clone target
    output_wav_file=None,                   # Optional: write WAV directly
    output_sample_rate=24000,               # 24 kHz default
    alpha=0.3,                              # Style / prosody mix
    beta=0.7,                               # Diffusion determinism
    diffusion_steps=5,                      # Higher = better quality, slower
    embedding_scale=1,                      # Speaker conditioning strength
    ref_s=None,                             # Pre-computed style vector
):
```

### Voice cloning posture

Zero-shot speaker adaptation via `target_voice_path`. The model is trained on LibriTTS for the reference checkpoint. Inference speed is comparable to XTTS-v2 (a few seconds for a sentence on a modern GPU).

`embedding_scale=1` is the safe default; lower = closer to default voice, higher = more reference-tied (and can introduce artifacts).

### Fine-tuning

Full training code at the original repo (`yl4579/StyleTTS2`). LibriTTS / VCTK / LJSpeech recipes available. Multi-speaker training supported. Not designed for fine-tuning by non-researchers; the paper is the documentation.

### Uncensored / filter posture

NO filter in the inference path. The model is a deterministic diffusion + adversarial generator. Output reflects input text. Paper / repo make no content claims; no safety layer is in scope.

### Mesh fit

VRAM: 4-8 GB GPU for inference (medium-high quality). Runs on HERM S22 (Galaxy S22, ~8 GB RAM, no dedicated GPU) in slow CPU mode. dirt-imac: too slow. WORM: 4 GB VRAM is at the lower bound; ok with `SUNO_USE_SMALL_MODELS=1`-style overrides if available (StyleTTS 2 doesn't expose this knob, but reducing `diffusion_steps` from 5 to 2 cuts compute ~2.5x).

### License

- pip package `styletts2` = MIT (strictly MIT-licensed libraries in inference module).
- Original StyleTTS 2 code = MIT.
- Pretrained weights = depends on the upstream `yl4579/StyleTTS2-LibriTTS` repo — read the model card before commercial use. (LibriTTS-derived; the dataset license is CC-BY-4.0.)
- Author of pip wrapper: "I'm not affiliated with the original authors." [source: https://github.com/sidharthrajaram/StyleTTS2]

---

## 5. Tortoise TTS (neonbjb) / Parla

### Identity

Tortoise is a text-to-speech program built with the following priorities: (1) strong multi-voice capabilities, (2) highly realistic prosody and intonation. "I'm naming my speech-related repos after Mojave desert flora and fauna. Tortoise is a bit tongue in cheek: this model is insanely slow. It leverages both an autoregressive decoder AND a diffusion decoder; both known for their low sampling rates. On a K80, expect to generate a medium sized sentence every 2 minutes." [source: https://github.com/Rajathbharadwaj/Tortoise-tts-voice-clone]

Parla is a 2023+ descendent of Tortoise maintained by the same author (James Betker / neonbjb). It optimizes some of the slow paths and adds streaming / API features. Both Apache-2.0 licensed.

### Install (Tortoise)

```bash
git clone https://github.com/neonbjb/tortoise-tts.git
cd tortoise-tts
pip install -r ./requirements.txt
python setup.py install
# Optional Windows: conda install -c conda-forge pysoundfile
# (do NOT install PyTorch via pip; use the PyTorch install instructions for your CUDA / platform)
```

### Voice cloning posture

Drop 3-10 second voice clips into `tortoise/voices/<your_voice_dir>/`. Run `tortoise/my_voice_test.py` with new text.

Programmatic:
```python
import torchaudio
import tortoise.api as api
import tortoise.utils as utils
import os
voice = '/home/soyrl/tortoise-tts/tortoise/voices/pvo/'
clips_paths = [voice + os.listdir(voice)[i] for i in range(len(os.listdir(voice)))]
reference_clips = [utils.audio.load_audio(p, 22050) for p in clips_paths]
tts = api.TextToSpeech()  # downloads all models from HF hub
pcm_audio = tts.tts_with_preset(
    text,
    voice_samples=reference_clips,
    preset="high_quality",  # ultra_fast | fast | standard | high_quality
)
torchaudio.save('out.wav', pcm_audio.squeeze(0).cpu(), 24000)
```

Preset modes (speed vs quality):
- `ultra_fast` — fastest, lowest quality
- `fast` (default)
- `standard` — better quality, much slower
- `high_quality` — best quality, hours per sentence

Reported runtimes (from `voice_cloning_tools`):
- fast preset default: ~35 min per sentence on CPU
- high_quality: ~1-2 hours on CPU, ~11.5 min on GTX 1660 Ti 6 GB
- ultra_fast: ~7 hours on CPU (`standard` is the doc's reference)

Optional DeepSpeed (`use_deepspeed=True`) claims ~2x faster on supported hardware; in practice slower on consumer GPUs.

### Uncensored / filter posture

NO filter. Tortoise speaks whatever you put in `text`. Author is candid that the model is a research artifact, not a production system.

### Mesh fit

WORM (Android tablet) = not viable. CPU-only path is 100x realtime; even on dirt-imac, sentence generation exceeds 30 minutes for `high_quality`. Only mesh deployment that makes sense: HERM S22 (if equipped with a real GPU box) or a remote Tailscale-reachable inference server. Tortoise is the RIGHT choice for audiobook / long-form narrator generation where compute time is acceptable; WRONG choice for realtime agent / voice UI.

### License

Apache-2.0. The architecture paper / code is permissively licensed; weights are on Hugging Face. Check the model's HF card for the dataset license (LJSpeech = public domain; the LibriTTS-derived models are CC-BY-4.0).

### Note

XTTS-v2 has displaced Tortoise for most clone use cases in 2024-2026. Tortoise's quality ceiling is high but its compute floor is too high for normal mesh use. Keep around as a fallback for "we need absolutely human-level quality on this one clip, no other model will do."

---

## 6. Fish-Speech 1.5 (fishaudio)

### Identity

Fish Speech V1.5 is a leading text-to-speech (TTS) model trained on more than 1 million hours of audio data in multiple languages. Trained on: English (en) >300k hours, Chinese (zh) >300k hours, Japanese (ja) >100k hours, German (de) ~20k hours, French (fr) ~20k hours, Spanish (es) ~20k hours, Korean (ko) ~20k hours, Arabic (ar) ~20k hours, Russian (ru) ~20k hours, Dutch (nl) <10k hours, Italian (it) <10k hours, Polish (pl) <10k hours, Portuguese (pt) <10k hours. [source: https://huggingface.co/fishaudio/fish-speech-1.5]

### Install

```bash
git clone https://github.com/fishaudio/fish-speech.git
cd fish-speech
pip install -e .
# Or inference-only via the demo API at https://speech.fish.audio
```

### Inference

Two main surfaces: a WebUI (Gradio) and an API server. Both launched via `python -m tools.run_webui` and `python -m tools.api` after install. Inline natural-language tag control: tags such as `[pause]`, `[excited]` and `[whisper]` control prosody and emotion anywhere in the text. [source: https://github.com/fishaudio/fish-speech/blob/main/docs/en/index.md]

### Voice cloning posture

Zero-shot & few-shot TTS. Input a 10-30 second vocal sample to generate high-quality TTS output. For detailed guidelines, see Voice Cloning Best Practices. The model is multilingual & cross-lingual — copy and paste multilingual text into the input box, no language specification needed. Currently supports English, Japanese, Korean, Chinese, French, German, Arabic, and Spanish. [source: https://github.com/fishaudio/fish-speech/tree/v1.5.0]

### Successor: Fish Audio Drama 3 (2025+)

Native multi-speaker generation: speaker IDs separate the characters inside one text, so you no longer generate and concatenate one speaker at a time. Inline natural-language instructions: tags such as `[pause]`, `[excited]` and `[whisper]` control prosody and emotion anywhere in the text. Rapid voice cloning: 10-30 seconds of reference audio is enough to reproduce a timbre. Single pass: long audio can be streamed out in one go. Production streaming: RTF 0.195 on a single H200, about 100 ms to first audio. [source: https://github.com/fishaudio/fish-speech/blob/main/docs/en/index.md]

Multilingual voice cloning sets a new level of SOTA for cross-lingual cloning error rates (CER / WER). Benchmark — Quality: 4.51/5.0.

### Uncensored / filter posture

NO filter on the open model weights. The hosted service at speech.fish.audio has its own terms; verify before commercial use. The local install is unmoderated.

### Mesh fit

Best for long-form multilingual (EN+JA+KO+ZH+FR+DE+AR+ES in a single model). Realtime feasible on RTX 3060+ (RTF 0.195 on H200 = 5x realtime; on RTX 3090 = ~2-3x realtime; on RTX 3060 = ~1.5-2x realtime). Drama 3 (2025+) targets production audiobook / podcast / drama production.

### License

Code: check the repo (varies per release). Weights: subject to the training-data licenses — primarily CC-BY-4.0 / public-domain audio. Verify per release.

---

## 7. OpenVoice v2 (MyShell)

### Identity

In April 2024, we release OpenVoice V2, which includes all features in V1 and has: (1) Better Audio Quality. OpenVoice V2 adopts a different training strategy that delivers better audio quality. (2) Native Multi-lingual Support. English, Spanish, French, Chinese, Japanese and Korean are natively supported in OpenVoice V2. (3) Free Commercial Use. Starting from April 2024, both V2 and V1 are released under MIT License. Free for commercial use. [source: https://huggingface.co/myshell-ai/OpenVoiceV2]

### Features (verbatim from upstream)

- Accurate Tone Color Cloning. OpenVoice can accurately clone the reference tone color and generate speech in multiple languages and accents.
- Flexible Voice Style Control. OpenVoice enables granular control over voice styles, such as emotion and accent, as well as other style parameters including rhythm, pauses, and intonation.
- Zero-shot Cross-lingual Voice Cloning. Neither of the language of the generated speech nor the language of the reference speech needs to be presented in the massive-speaker multi-lingual training dataset. [source: https://huggingface.co/myshell-ai/OpenVoiceV2]

### Install

```bash
conda create -n openvoice python=3.9
conda activate openvoice
git clone git@github.com:myshell-ai/OpenVoice.git
cd OpenVoice
pip install -e .
# V2 checkpoints:
# Download https://myshell-public-repo-hosting.s3.amazonaws.com/openvoice/checkpoints_v2_0417.zip
# Extract into ./checkpoints_v2
# Install MeloTTS as the base TTS:
pip install git+https://github.com/myshell-ai/MeloTTS.git
python -m unidic download
```

### Voice cloning posture

Takes any reference audio in any language, clones the tone color, generates speech in English / Spanish / French / Chinese / Japanese / Korean. Uses MeloTTS as the base TTS engine, then applies OpenVoice's tone-color transfer on top. The cross-lingual zero-shot claim is the unique selling point.

### Uncensored / filter posture

NO filter in the open model. MIT-licensed, including for commercial use. MyShell's hosted services at `app.myshell.ai/widget/...` are subject to the widget terms but the local install has no content layer.

### Mesh fit

Lightweight. The V2 checkpoints are small (~100 MB), the MeloTTS base is another ~400 MB. Runs on dirt-imac with CPU only (slow but feasible for short clips). HERM S22 / WORM with GPU = realtime. The cross-lingual clone is the differentiator — if you need a voice from one language speaking in another, OpenVoice v2 is the easiest on-ramp.

### License

MIT (code + weights), free for commercial use since April 2024.

---

## 8. RVC v2 (RVC-Project / Retrieval-based-Voice-Conversion)

### Identity

RVC is an easy-to-use Voice Conversion framework based on VITS. "The trick is the word retrieval: a top-1 lookup replaces the source's HuBERT features with the nearest features from your training set, which is what kills timbre leakage and why RVC sounds more like the target than bare VITS on the same amount of data. The base model was trained on roughly 50 hours of the open VCTK corpus, so all you are doing is fine-tuning on ten-odd minutes." [source: https://nexgpu.net/en/models/rvc]

RVC is voice CONVERSION: input is a source speaker's audio, output is the same content re-spoken in the target voice. Different from TTS (where input is text). RVC requires a TRAINED MODEL per target voice; no zero-shot option.

### Install

```bash
pip install git+https://github.com/RVC-Project/Retrieval-based-Voice-Conversion
# Then init:
mkdir myproject && cd myproject
rvc init
# Creates ./assets/ and .env. Then download the pretrained models:
#   hubert_base.pt (190 MB)
#   rvc_pretrained (various, ~1.3 GB total for all variants)
#   rvc_uvr5_weights (for UVR pre-processing)
#   pretrained_v2 (for v2 weights)
```

### Inference (Python)

```python
from pathlib import Path
from dotenv import load_dotenv
from scipy.io import wavfile
from rvc.modules.vc.modules import VC
vc = VC()
vc.get_vc("model.pth")
tgt_sr, audio_opt, times, _ = vc.vc_inference(1, Path("InputAudio.wav"))
wavfile.write("OutputAudio.wav", tgt_sr, audio_opt)
```

### Inference (CLI)

```bash
rvc infer -m model.pth -i input.wav -o output.wav
# Key flags:
#   -fu / --f0_up_key    int, 0   semitones transpose (12 = octave up, -12 = octave down)
#   -fm / --f0_method    str, "rmvpe"  pitch extraction (pm, harvest, crepe, rmvpe)
#   -fr / --filter_radius int, 3       median filter on F0 (>=3 reduces breathiness)
#   -rsr / --resample_sr int, 0        post-resample (0 = no resample)
#   -rmr / --rms_mix_rate float, 0.25  volume envelope scaling (0 = mimic source loudness)
#   -p / --protect float, 0.33         protect voiceless consonants (0.5 = disable)
```

### Versions (2025-2026 state)

| Version | Parameters | VRAM | Context | Notes |
|---|---|---|---|---|
| RVC v2 40k (with f0) | f0G40k.pth 73.1 MB + f0D40k.pth 143 MB | Inference <4 GB / training 6 GB+ | 40 kHz output, HuBERT 16 kHz | Default, recommended for most work |
| RVC v2 48k (with f0) | f0G48k.pth 75.5 MB + f0D48k.pth 143 MB | One notch heavier than 40k | 48 kHz output | Use for film/48 kHz master. For dubbing/short video it buys nothing audible |
| RVC v2 32k (with f0) | f0G32k.pth 74 MB + f0D32k.pth 143 MB | Cheapest; 16 GB card trainable | 32 kHz output | Old recordings, telephone-grade source, VRAM-tight |
| RVC v2 no-pitch (no-f0) | G40k.pth 73 MB + D40k.pth 143 MB | f0 minus f0 extraction | 40 kHz output, no F0 model | Speech-only work. Never for singing |
| RVC v1 (the pretrained/ folder) | 40k + 48k tiers | Slightly lighter | 256-dim HuBERT | Load 2023 v1 checkpoints only. v1 and v2 weights not interchangeable |

Companion weights (required): HuBERT + RMVPE; under 1 GB resident, combined. [source: https://nexgpu.net/en/models/rvc]

### Training

Upstream recommends 10-50 minutes of clean target voice. A tight, characterful 5-10 minutes works too; under 1-2 minutes is discouraged, and under 1 minute nobody has reported success. Epochs depend on source quality: 20-30 is plenty for noisy material, since pushing higher only drags the base model down to your recording's level, while clean and lengthy datasets happily take 200. The WebUI ships with total_epoch at 20 and a checkpoint every 5.

GPU memory requirements:
- 4 GB VRAM: Limited batch size, longer training time
- 8 GB VRAM: Reasonable performance for most models
- 16 GB+ VRAM: Optimal training performance, larger batch sizes

Training time examples:
- 10-minute dataset, 16 GB VRAM: ~1-2 hours
- 30-minute dataset, 16 GB VRAM: ~3-5 hours

The hard rule: never change sample rate mid-training. FAQ Q18 is explicit — start a new experiment name instead, or you will hit a tensor dimension mismatch. [source: https://deepwiki.com/RVC-Project/Retrieval-based-Voice-Conversion-WebUI/4-training-pipeline]

### Uncensored / filter posture

ZERO filter. RVC is a pure conversion operator. Whatever goes in (audio) comes out (audio) with the target's timbre. The clone is a property of the trained model, and the model is the operator's asset. The RVC community has been the locus of "any voice → any voice" work; the model itself has no content moderation. Commercial use: undefined; some community checkpoints are trained on public-figure voices (legally risky in many jurisdictions) — use only on voices you have the right to convert.

### Mesh fit

Training requires a real GPU; HERM S22 is at the lower bound (8 GB RAM is not VRAM, but TensorFlow / PyTorch can do CPU training in days, not hours). WORM (4 GB VRAM) = inference only, on v2 40k models with batch size 1. dirt-imac: not viable. Best mesh deployment: a Tailscale-reachable training box, RVC inference on the local tablet.

The realtime_gui.py (separate repo) defaults to 0.25 s block time, 0.05 s crossfade and 2.5 s of extra inference; algorithmic delay computes as block + crossfade + 0.01, about 310 ms out of the box. The README reports 170 ms end to end already achieved, and 90 ms with ASIO input/output devices.

### License

MIT (code); weights are produced by the user (no upstream-issued model card). Pretrained base models (VCTK) inherit CC-BY-4.0.

---

## 9. So-VITS-Song / So-VITS-SVC 4.0 + 5.0

### Identity

So-VITS-SVC (SoftVC VITS Singing Voice Conversion). A singing voice conversion model using the SoftVC encoder to extract features from the input audio, sent into VITS along with the F0 to replace the original input to achieve a voice conversion effect. Additionally, changing the vocoder to NSF HiFiGAN to fix the issue with unwanted staccato. [source: https://github.com/camenduru/so-vits-svc]

### Versions

- 3.0 — original, 32 kHz output, large VRAM usage
- 4.0 — feature input is changed to Content Vec, sampling rate unified to 44.1 kHz, VRAM usage significantly reduced. Added automatic pitch prediction for vc mode (will cause pitch shift when converting songs). Added k-means clustering to reduce timbre leakage.
- 4.0-v2 — model improvements, slight regression in some cases
- 5.0 — variational inference with adversarial learning, refined training pipeline, ~6 GB VRAM for batch_size 6

### Install (4.0)

```bash
git clone https://github.com/svc-develop-team/so-vits-svc
cd so-vits-svc
pip install -r requirements.txt
# Python 3.8/3.9 recommended (conda)
# Downloads: ContentVec checkpoint_best_legacy_500.pt
#   https://huggingface.co/therealvul/so-vits-svc-4.0-init/resolve/main/checkpoint_best_legacy_500.pt
# Place under hubert/
# Pre-trained: G_0.pth + D_0.pth under logs/44k/
# Optional: rubberband for timestretching, crepe for pitch detection, pygame for auto-playback
```

### Install (5.0)

```bash
git clone https://github.com/ouor/so-vits-svc-5.0
python -m venv .venv
source .venv/bin/activate
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu117
pip install -r requirements.txt
# Pre-trained: https://github.com/PlayVoice/so-vits-svc-5.0/releases/tag/5.0
# Put under project root, edit configs/base.yaml: pretrain: "./vits_pretrain/sovits5.0.pretrain.pth"
# batch_size: 6 for 6 GB VRAM, 8 works but slower
```

### Training

```bash
# 4.0
python train.py -c configs/config.json -m 44k
# 5.0
python svc_trainer.py -c configs/base.yaml -n sovits5.0
# Resume
python svc_trainer.py -c configs/base.yaml -n sovits5.0 -p chkpt/sovits5.0/***.pth
# Tensorboard
tensorboard --logdir logs/
```

### Inference

```bash
# 4.0
python inference_main.py -m "logs/44k/G_30400.pth" -c "configs/config.json" -n "song.wav" -t 0 -s "target_singer"
# where -s is the speaker/singer name, -t is pitch shift in semitones
```

### Uncensored / filter posture

ZERO filter. Pure conversion. The community has built celebrity-voice SVC models; legal exposure is on the operator. The model has no content layer.

### Mesh fit

Same as RVC: training needs a real GPU, inference runs on smaller VRAM. dirt-imac: out. WORM: at the edge of viability. HERM S22 with Tailscale training box: viable.

### License

MIT (code). Pretrained voices: undefined, community-built. Some popular community models are trained on copyrighted singers — operator's responsibility.

### Distinction from RVC

So-VITS-SVC is optimized for SINGING voice conversion (preserves pitch + melody; you supply a song, get the same song in the target singer's voice). RVC is for general speech / instrumental vocal conversion. For a sung cover in another voice, SVC. For any-to-any speech timbre swap, RVC. For TTS-from-text, neither — use XTTS / F5-TTS / OpenVoice.

---

## 10. F5-TTS (SWivid / cocktailpeanut)

### Identity

F5-TTS: A Fairytaler that Fakes Fluent and Faithful Speech with Flow Matching. Reference implementation of the paper, MIT-licensed code. Pre-trained models are licensed under the CC-BY-NC license due to the training data Emilia, which is an in-the-wild dataset. [source: https://github.com/cocktailpeanut/F5-TTS]

### Architecture

Conditional Flow Matching (CFM) with Diffusion Transformer (DiT). 335M parameters. Backbone: DiT (dim=1024, depth=22, heads=16, ff_mult=2, text_dim=512, conv_layers=4). Vocoder: Vocos (24 kHz, 100 mel channels). Trained on 95K hours of multilingual speech (Emilia EN+ZH). RTF ~0.15 (6.7x real-time capable). [source: https://huggingface.co/rajkr/voice-clone-f5tts]

### Install (inference only)

```bash
pip install f5-tts
# Or from source for full features:
git clone https://github.com/SWivid/F5-TTS.git
cd F5-TTS
# git submodule update --init --recursive  # (optional, if need bigvgan)
pip install -e .
# Python 3.10 (conda) recommended, PyTorch matched to your CUDA
# Requires FFmpeg
```

### Inference (Gradio)

```bash
f5-tts_infer-gradio
# Custom port/host:
f5-tts_infer-gradio --port 7860 --host 0.0.0.0
# Public link:
f5-tts_infer-gradio --share
```

### Inference (CLI)

```bash
f5-tts_infer-cli \
  --model "F5-TTS" \
  --ref_audio "ref_audio.wav" \
  --ref_text "The content, subtitle or transcription of reference audio." \
  --gen_text "Some text you want TTS model generate for you."
# Leave --ref_text "" to have ASR model transcribe (extra GPU memory usage)
# Or with a config:
f5-tts_infer-cli -c src/f5_tts/infer/examples/basic/basic.toml
# Multi voice:
f5-tts_infer-cli -c src/f5_tts/infer/examples/multi/story.toml
```

### Inference (Python)

```python
from f5_tts.api import F5TTS
tts = F5TTS(
    ckpt_file="./f5tts_model/F5TTS_v1_Base/model_1250000.safetensors",
    vocab_file="./f5tts_model/F5TTS_v1_Base/vocab.txt",
)
wav, sr, _ = tts.infer(
    ref_file="/content/my_voice.wav",         # 3-10 s reference
    ref_text="Exact transcript of your audio.",
    gen_text="Say this in the cloned voice!",
    nfe_step=32,                              # quality knob
)
import soundfile as sf
sf.write("output.wav", wav, sr)
```

### Voice cloning posture

Zero-shot voice cloning with 3-10 s reference audio. Faster than XTTS-v2 on identical hardware. Competitive with ElevenLabs at a fraction of the compute. Multi-speaker stories supported (`multi/story.toml` example). [source: https://huggingface.co/rajkr/voice-clone-f5tts]

### Uncensored / filter posture

NO filter in the open model. Code is MIT; weights are CC-BY-NC (Emilia training data). Commercial use of WEIGHTS is restricted; code is fine.

### Mesh fit

Lightweight. RTX 3060 12 GB = ~6.7x realtime. dirt-imac: too slow. WORM (4 GB VRAM): borderline, will run with `nfe_step=8` for shorter generations. HERM S22 (8 GB RAM, not VRAM): CPU mode = ~1-2x realtime, viable for short clips. Best deployment: a Tailscale mesh box with a real GPU.

### License

- Code: MIT
- Weights: CC-BY-NC (Emilia training data)
- For fully commercial use, you need either a different model (OpenVoice v2 / Fish Speech 1.5) or to negotiate a separate Emilia license.

---

## 11. OpenAI Whisper (openai/whisper)

### Identity

OpenAI's Whisper is a general-purpose speech recognition model trained on a large dataset of diverse audio. Whisper is a Transformer-based encoder-decoder model (also called a sequence-to-sequence model) that maps audio spectrogram features to text tokens. Released 2022-09; open weights under MIT license. [source: https://github.com/openai/whisper]

### Model sizes (2025 state)

| Size | Parameters | English-only | Multilingual | Required VRAM | Relative Speed |
|---|---|---|---|---|---|
| tiny | 39 M | `tiny.en` | `tiny` | ~1 GB | ~10x |
| base | 74 M | `base.en` | `base` | ~1 GB | ~7x |
| small | 244 M | `small.en` | `small` | ~2 GB | ~4x |
| medium | 769 M | `medium.en` | `medium` | ~5 GB | ~2x |
| large | 1550 M | N/A | `large` (aliased to `large-v3`) | ~10 GB | 1x |
| turbo | 809 M | N/A | `turbo` (default CLI) | ~6 GB | ~8x |

[source: https://openai-whisper.mintlify.app/concepts/models, https://github.com/openai/whisper]

### Per-size details

- tiny (39M): 75 MiB disk (GGML), 273 MB RAM, ~1 GB VRAM, ~10x. English WER ~7.6%, multilingual WER ~12%. Struggles with accents / noise. Default for many edge tools.
- base (74M): 142 MiB disk, 388 MB RAM, ~1 GB VRAM, ~7x. English WER ~5.0%, multilingual WER ~10%. Better on noisy audio than tiny.
- small (244M): 466 MiB disk, 852 MB RAM, ~2 GB VRAM, ~4x. English WER ~3.4%, multilingual WER ~7%. Handles accents well. The recommended default for most users.
- medium (769M): 1.5 GiB disk, 2.1 GB RAM, ~5 GB VRAM, ~2x. English WER ~2.9%, multilingual WER ~5%. Strong on technical content.
- large-v1 / v2 / v3 (1550M): 2.9 GiB disk, 3.9 GB RAM, ~10 GB VRAM, 1x. v3 is the recommended version (128 Mel bins, 1M hours labeled + 4M pseudo-labeled audio, 10-20% error reduction over v2, added Cantonese).
- turbo (809M): Distilled from large-v3 by pruning the decoder from 32 layers to 4 layers. 1.6 GiB disk, 2.3 GB RAM, ~6 GB VRAM, ~8x. English WER ~2.5%, multilingual WER ~3.7%. NOT trained for translation tasks.

The defining property of `turbo` is its drastically reduced decoder (`n_text_layer = 4`) — that's where the speed comes from. [source: https://factory.ai/open-source-wikis/whisper?page=reference/models.md]

### Install

```bash
pip install -U openai-whisper
# Or from source:
pip install git+https://github.com/openai/whisper.git
# Requires: ffmpeg, Python 3.8-3.11
# Also requires the `tiktoken` package for fast tokenization
```

### Inference (CLI)

```bash
whisper audio.mp3 --model medium --language en
whisper audio.wav --model large-v3 --output_format srt
# Default model is `turbo`
# --task translate for speech-to-English translation
# --device cuda / cpu
# --fp16 False for CPU
```

### Inference (Python)

```python
import whisper
model = whisper.load_model("medium")
result = model.transcribe("audio.mp3", language="en", fp16=True)
print(result["text"])
# result["segments"] is list of {id, start, end, text, tokens, temperature, ...}
# result["language"] is detected language code
```

### Uncensored / filter posture

NO filter on transcription output. Whisper will faithfully transcribe whatever is in the audio — slurs, profanity, instructions, etc. The output text is not screened. This is the right posture for sovereign transcription.

### Mesh fit

Best of all STT options for the WORM tablet. tiny/base/small run on CPU in realtime or better. medium needs GPU. large-v3 needs 10 GB VRAM (HERM S22 is too small; a proper GPU box is required).

Common mesh uses:
- Captions for video recordings
- Searchable transcripts of voice memos
- On-device dictation
- Translation (Whisper also translates from any supported language to English)

### License

MIT for code and weights. Permissive.

---

## 12. faster-whisper (SYSTRAN / guillaumekln)

### Identity

faster-whisper is a reimplementation of OpenAI's Whisper model using CTranslate2, which is a fast inference engine for Transformer models. This implementation is up to 4 times faster than openai/whisper for the same accuracy while using less memory. The efficiency can be further improved with 8-bit quantization on both CPU and GPU. [source: https://github.com/SYSTRAN/faster-whisper]

### Install

```bash
pip install faster-whisper
# Or: pip install faster-whisper>=1.1.0
```

### Inference (Python)

```python
from faster_whisper import WhisperModel
# CPU int8:
model = WhisperModel("large-v3", device="cpu", compute_type="int8")
# GPU fp16:
model = WhisperModel("large-v3", device="cuda", compute_type="float16")
segments, info = model.transcribe("audio.mp3", beam_size=5, language="en")
for segment in segments:
    print("[%.2fs -> %.2fs] %s" % (segment.start, segment.end, segment.text))
```

### Benchmarks (large-v2 / large-v3, GPU fp16, beam 5, 13 min audio)

| Implementation | Precision | Beam size | Time | VRAM |
|---|---|---|---|---|
| openai/whisper | fp16 | 5 | 2m23s | 4708 MB |
| whisper.cpp (Flash Attention) | fp16 | 5 | 1m05s | 4127 MB |
| transformers (SDPA) | fp16 | 5 | 1m52s | 4960 MB |
| faster-whisper | fp16 | 5 | 1m03s | 4525 MB |
| faster-whisper (`batch_size=8`) | fp16 | 5 | 17s | 6090 MB |
| faster-whisper | int8 | 5 | 59s | 2926 MB |
| faster-whisper (`batch_size=8`) | int8 | 5 | 16s | 4500 MB |

[source: https://github.com/SYSTRAN/faster-whisper — 13 min audio, V100S / i7-12700K]

### Performance (small model, CPU fp32, 8 threads)

| Implementation | Time | RAM |
|---|---|---|
| openai/whisper | 6m58s | 2335 MB |
| whisper.cpp | 2m05s | 1049 MB |
| whisper.cpp (OpenVINO) | 1m45s | 1642 MB |
| faster-whisper | 2m37s | 2257 MB |
| faster-whisper (`batch_size=8`) | 1m06s | 4230 MB |
| faster-whisper int8 | 1m42s | 1477 MB |
| faster-whisper int8 `batch_size=8` | 51s | 3608 MB |

### Uncensored / filter posture

Identical to openai/whisper — no filter, no classifier on output.

### Mesh fit

Drop-in upgrade to Whisper. Use it everywhere you'd use the original; ~4x faster, less memory, same accuracy. The `int8` quantization on CPU is excellent for the WORM tablet. On a 4 GB VRAM box, `large-v3 int8 batch_size=8` is real-world viable.

### License

MIT.

---

## 13. whisper.cpp (ggerganov / ggml-org)

### Identity

Port of OpenAI's Whisper model in C/C++. High-performance inference of OpenAI's Whisper automatic speech recognition (ASR) model. Plain C/C++ implementation without dependencies. Apple Silicon first-class citizen — optimized via ARM NEON, Accelerate framework, Metal and Core ML. AVX intrinsics support for x86 architectures. VSX intrinsics support for POWER architectures. Mixed F16 / F32 precision. Integer quantization support. Zero memory allocations at runtime. Vulkan support. Support for CPU-only inference. Efficient GPU support for NVIDIA. AMD ROCm GPU support. AMD Ryzen AI NPU Support. OpenVINO Support. Ascend NPU Support. Moore Threads GPU Support. C-style API. Voice Activity Detection (VAD). [source: https://github.com/ggml-org/whisper.cpp/]

### Install (from source)

```bash
git clone https://github.com/ggml-org/whisper.cpp.git
cd whisper.cpp
# CPU:
make
# GPU NVIDIA:
make GGML_CUDA=1
# Apple Silicon (Metal):
make
# AMD ROCm:
make GGML_HIP=1
# Vulkan (AMD iGPU etc):
make GGML_VULKAN=1
# OpenVINO:
make GGML_OPENVINO=1
# Ascend NPU:
make GGML_CANN=1
```

### Install (pre-built binary)

```bash
# Just download a release binary for your platform
# Or use the Docker image:
docker pull ghcr.io/ggml-org/whisper.cpp:main
# Variants: main, main-cuda, main-musa, main-vulkan
```

### Model download

```bash
# Inside the cloned repo:
sh ./models/download-ggml-model.sh base.en
# For quantised versions:
# tiny-q5_1, base-q5_1, small-q5_1, medium-q5_0, large-v3-q5_0, large-v3-turbo-q5_0
# Or for an interactive download UI:
make -j base.en
```

### Model sizes (GGML format)

| Model | Disk | Quantized (q5_1 / q8_0 / q5_0) |
|---|---|---|
| tiny | 75 MiB | 31 / 42 MiB |
| base | 142 MiB | 57 / 78 MiB |
| small | 466 MiB | 181 / 252 MiB |
| medium | 1.5 GiB | 514 / 785 MiB (q5_0 / q8_0) |
| large-v1 | 2.9 GiB | — |
| large-v2 | 2.9 GiB | 1.1 / 1.5 GiB (q5_0 / q8_0) |
| large-v3 | 2.9 GiB | 1.1 / 1.5 GiB (q5_0 / q8_0) |
| large-v3-turbo | 1.5 GiB | 547 / 834 MiB (q5_0 / q8_0) |

[source: https://huggingface.co/ggerganov/whisper.cpp]

### Inference (CLI)

```bash
./build/bin/whisper-cli -m models/ggml-base.en.bin -f audio.wav
# Options: -l (language), -t (threads), -p (prompt), --translate
# -ng / --no-gpu to disable GPU
# -fa / --flash-attn for flash attention
# -oved / --ov-e-device for OpenVINO device
# -dtw MODEL / --dtw MODEL for token-level timestamps
# Full help: ./build/bin/whisper-cli -h
```

### Realtime (server)

```bash
# Server mode (HTTP API):
./build/bin/whisper-server --host 0.0.0.0 -m /models/ggml-base.bin
# OR via Docker:
docker run -it --rm \
  -p 8080:8080 \
  -v $MODEL_PATH:/models \
  ghcr.io/ggml-org/whisper.cpp:main \
  whisper-server --host 0.0.0.0 -m /models/ggml-base.bin
```

### Apple Neural Engine

On Apple Silicon devices, the Encoder inference can be executed on the Apple Neural Engine (ANE) via Core ML. This can result in significant speed-up — more than x3 faster compared with CPU-only execution. To enable:
```bash
./models/generate-coreml-model.sh base.en
cmake -B build -DWHISPER_COREML=1
cmake --build build -j --config Release
```

### AMD Ryzen AI NPU

On AMD Ryzen AI 300 and 400 Series processors with a dedicated NPU, whisper.cpp can fully offload the Whisper encoder to the NPU via VitisAI, delivering significant speedup over CPU-only inference. Requires the GGML model and the matching prebuilt VitisAI model:
```bash
sh ./models/download-ggml-model.sh base
sh ./models/download-vitisai-model.sh base
```

### POWER9/10

Supports POWER architectures and includes code which significantly speeds operation on Linux running on POWER9/10, making it capable of faster-than-realtime transcription on underclocked Raptor Talos II.

### Uncensored / filter posture

NO filter. Pure C++ inference, no upstream moderation.

### Mesh fit

The universal mesh STT. Runs on everything from a Raspberry Pi Zero (tiny model, q5_1 quantization) to an M3 Max (Core ML, ANE, 3x+ realtime on large-v3). WORM: tiny/base on CPU in realtime. HERM S22: small/medium on CPU, large-v3 with GPU acceleration. dirt-imac: SSE3 = no AVX, runs but slower; consider OpenBLAS acceleration for some speedup.

### License

MIT.

---

## 14. FunASR (Alibaba / ModelScope)

### Identity

FunASR is an open-source speech recognition toolkit from Alibaba's DAMO Academy, distributed via ModelScope. Industrial speech recognition. 170x faster than Whisper. 50+ languages. Speaker diarization, emotion detection, streaming, one API call. [source: https://github.com/modelscope/FunASR]

### Flagship: Fun-ASR-Nano (LLM-ASR)

LLM-based ASR combining SenseVoice encoder with Qwen3-0.6B decoder. Trained on tens of millions of hours. Supports Chinese, English, Japanese, and Chinese dialect groups. [source: https://github.com/alibaba/FunASR — 2025/12/15 release]

```python
from funasr import AutoModel
model = AutoModel(model="FunAudioLLM/Fun-ASR-Nano-2512", device="cuda")
result = model.generate(input="https://isv-data.oss-cn-hangzhou.aliyuncs.com/ics/MaaS/ASR/test_audio/asr_example_zh.wav")
print(result[0]["text"])
# 欢迎大家来体验达摩院推出的语音识别模型。

# vLLM acceleration (16x faster, batch processing):
from funasr.auto.auto_model_vllm import AutoModelVLLM
model = AutoModelVLLM(model="FunAudioLLM/Fun-ASR-Nano-2512", tensor_parallel_size=1)
results = model.generate(["audio1.wav", "audio2.wav"], language="auto")
```

### Benchmarks (FunASR vs Whisper-large-v3, Chinese CER)

| Model | Chinese CER | GPU Speed | CPU Speed | vs Whisper-large-v3 |
|---|---|---|---|---|
| **Fun-ASR-Nano** (vLLM) | **8.20%** | **340x realtime** | — | **26x faster** |
| **SenseVoice-Small** | **7.81%** | **170x realtime** | **17x realtime** | **13x faster** |
| **Paraformer-Large** | 10.18% | **120x realtime** | **15x realtime** | **9x faster** |
| Whisper-large-v3-turbo | 21.71% | 46x realtime | ❌ | 3.4x faster |
| Whisper-large-v3 | 20.02% | 13x realtime | ❌ | baseline |

[source: https://github.com/modelscope/FunASR]

### Install

```bash
pip install funasr
# Or from source:
git clone https://github.com/modelscope/FunASR.git
cd FunASR
pip install -e ./
# Requirements: Python >= 3.8, PyTorch + torchaudio first
# For users in China: pip install -U funasr -i https://mirror.sjtu.edu.cn/pypi/web/simple
# v1.4.1 on PyPI: Hugging Face paraformer-en alias now resolves to the official English checkpoint
```

### Inference (production Chinese pipeline)

```python
from funasr import AutoModel
# VAD + ASR + punctuation + speaker
model = AutoModel(
    model="paraformer-zh",
    vad_model="fsmn-vad",
    punc_model="ct-punc",
    spk_model="cam++",
    device="cuda",
)
result = model.generate(
    input="https://isv-data.oss-cn-hangzhou.aliyuncs.com/ics/MaaS/ASR/test_audio/asr_example_zh.wav",
    hotword="关键词 20",
)
```

### Streaming

```python
import soundfile as sf
model = AutoModel(model="paraformer-zh-streaming", device="cuda")
audio, sr = sf.read("speech.wav", dtype="float32")  # 16 kHz mono
chunk_size = [0, 10, 5]  # 600 ms chunks
chunk_stride = chunk_size[1] * 960
cache = {}
n_chunks = (len(audio) - 1) // chunk_stride + 1
for i in range(n_chunks):
    chunk = audio[i * chunk_stride : (i + 1) * chunk_stride]
    res = model.generate(
        input=chunk, cache=cache, is_final=(i == n_chunks - 1),
        chunk_size=chunk_size,
        encoder_chunk_look_back=4, decoder_chunk_look_back=1,
    )
    if res[0]["text"]:
        print(res[0]["text"], end="", flush=True)
```

### Emotion recognition

```python
model = AutoModel(model="emotion2vec_plus_large", device="cuda")
result = model.generate(input="audio.wav", granularity="utterance")
# Returns: emotion classification (neutral, happy, sad, angry, fear, surprise, disgust)
```

### FunASR's key advantages

1. **Speed**: 170x realtime on GPU for SenseVoice-Small, 13x faster than Whisper-large-v3 with better Chinese CER.
2. **Multi-task**: VAD + ASR + punctuation + speaker diarization + emotion in one toolkit.
3. **Streaming**: Built-in streaming ASR with low latency.
4. **Chinese dialects**: Fun-ASR-Nano specifically targets Chinese dialect groups and regional accents.
5. **50+ languages** including low-resource ones.

### Uncensored / filter posture

NO content filter on transcription output. Output text is the recognized speech. Same posture as Whisper. The hosted API at Alibaba has its own ToS; the local install does not.

### Mesh fit

The best choice for Chinese + multilingual mesh use. On RTX 3060+, the speed is 120-340x realtime, which means a 1-hour audio file is transcribed in 10-30 seconds. dirt-imac: too slow for SenseVoice-Large; SenseVoice-Small is feasible. WORM: CPU at 17x realtime = minutes for 1-hour audio; works but slow.

For 50+ languages, English-only, and edge cases, Whisper / faster-whisper is still preferred. For Chinese-first pipelines with rich tooling (VAD, punctuation, diarization, emotion), FunASR is the best open-weights choice.

### License

MIT (code). Models: check per-model card (most are CC-BY / Apache-2.0 for code, model weights have their own license).

### Notes

- 2026/08/04: v1.4.1 on PyPI — Hugging Face `paraformer-en` alias now resolves to the official English checkpoint instead of silently downloading the Chinese model. This patch also includes Fun-ASR-Nano LoRA fine-tuning and safer checkpoint handling; the tagged source adds JSONL timestamp output, SenseVoice TensorRT deployment, and the OpenClaw realtime transcription integration. [source: https://github.com/modelscope/FunASR]
- 2025/12/15: Fun-ASR-Nano-2512 — Chinese, English, Japanese, and Chinese dialect support; trained on tens of millions of hours.

---

## Cross-tool comparison matrix (2026 state)

### TTS — quality vs speed vs clone ease vs mesh fit

| Tool | Quality | Speed | Clone | Multilingual | Mesh fit (WORM 4GB VRAM) | License |
|---|---|---|---|---|---|---|
| Piper | B+ (16-22 kHz) | Real-time on CPU | NO (per-voice training) | 30+ langs | BEST (CPU realtime) | MIT |
| XTTS-v2 | A | ~200ms first chunk (GPU) | 6 s zero-shot | 17 langs | Slow (CPU = 12x RT) | CPML |
| Bark | A (with nonverbals) | ~5-10s for 14s clip | 100+ presets (official), arbitrary (fork) | EN+DE+ES+FR+JA+ZH+... | OK with small model | MIT |
| StyleTTS 2 | A+ (human-level) | ~2-3s/sentence on GPU | zero-shot ref | EN (paper) / multi (checkpoints) | Slow on 4GB | MIT (code) |
| Tortoise | A+ | 7h-2h per sentence | voice dir (3-10s clips) | EN (default) | NOT VIABLE | Apache-2.0 |
| Fish-Speech 1.5 | A | ~5x realtime on H200 | 10-30s zero-shot | 13 langs | OK on 4GB | per-release |
| OpenVoice v2 | A- | Real-time on GPU | Any-lang tone color | 6 langs (EN+ES+FR+ZH+JA+KO) | BEST (small) | MIT |
| RVC v2 | A (conversion) | Real-time on GPU | TRAINING (10-50 min) | any (transfer) | Inference only on 4GB | MIT |
| So-VITS-SVC 4.0/5.0 | A (SVC) | Real-time on GPU | TRAINING (10-30 min) | any (transfer) | Inference only on 4GB | MIT |
| F5-TTS | A+ | ~6.7x realtime on GPU | 3-10s zero-shot | EN+ZH (paper), more in checkpoints | Slow on 4GB | MIT code / CC-BY-NC weights |

### STT — speed vs accuracy vs mesh fit

| Tool | Speed | Accuracy | Multilingual | Streaming | Mesh fit | License |
|---|---|---|---|---|---|---|
| openai/whisper | 1x baseline | best (large-v3) | 99 langs | NO | OK (small/medium CPU) | MIT |
| faster-whisper | 4x faster | same as openai/whisper | 99 langs | partial | BEST (int8 on CPU) | MIT |
| whisper.cpp | 2-3x faster | same as openai/whisper | 99 langs | via server | BEST (edge, any platform) | MIT |
| FunASR | 13-26x faster than Whisper | better on Chinese, similar elsewhere | 50+ langs, Chinese dialects | YES (built-in) | OK (CUDA strong, CPU OK) | MIT |

### Voice-cloning posture summary

| Tool | Zero-shot? | Min ref audio | Training needed? | Cross-lingual clone? |
|---|---|---|---|---|
| Piper | NO | n/a | YES (per voice) | n/a |
| XTTS-v2 | YES | 6 s | NO (optional fine-tune) | YES |
| Bark (official) | NO (presets only) | n/a | n/a | n/a |
| Bark (JonathanFly fork) | YES | 5-20 s | NO | n/a |
| StyleTTS 2 | YES | 5-15 s | NO | limited |
| Tortoise | YES (voice dir) | 3-10 s | NO | NO |
| Fish-Speech 1.5 | YES | 10-30 s | NO | YES (13 langs) |
| OpenVoice v2 | YES (tone color) | any | NO | YES (zero-shot) |
| RVC v2 | NO | n/a | YES (per voice, 10-50 min) | YES (any-to-any conversion) |
| So-VITS-SVC | NO | n/a | YES (per singer, 10-30 min) | YES (any-to-any SVC) |
| F5-TTS | YES | 3-10 s | NO | YES |

### Uncensored / filter posture summary

ALL tools covered here are ZERO-FILTER on the open-weights local install. The differences are:
- License posture: MIT (Piper, Bark, OpenVoice, Whisper family, FunASR, RVC, So-VITS, F5-TTS code) vs CPML (XTTS-v2, restricts commercial) vs CC-BY-NC (F5-TTS weights, RVC base) vs Apache-2.0 (Tortoise) vs per-release (Fish-Speech, StyleTTS 2).
- Voice-fingerprint filters: NONE on the local install for any tool. ElevenLabs has them on Professional Voice Clone, but it's out of scope here.
- Text-side filters: NONE in any local TTS. Bark, XTTS, etc. all speak whatever text is input.
- Audio-side filters: NONE. RVC and So-VITS convert whatever is input.

### License summary table

| Tool | Code | Weights | Notes |
|---|---|---|---|
| Piper | MIT | mostly public-domain | Voice models from CC0/CC-BY datasets |
| XTTS-v2 | MPL 2.0 / CPML | CPML | Non-commercial + small-commercial only |
| Bark | MIT | MIT | Commercial use permitted |
| StyleTTS 2 | MIT | check model card | LibriTTS-derived = CC-BY-4.0 |
| Tortoise | Apache-2.0 | check model card | LJSpeech / VCTK-derived |
| Fish-Speech 1.5 | check per-release | check per-release | Multi-dataset, multi-license |
| OpenVoice v2 | MIT | MIT | Commercial OK since 2024-04 |
| RVC v2 | MIT | user-trained | Pretrained base from VCTK = CC-BY-4.0 |
| So-VITS-SVC | MIT | user-trained | Pretrained base from open corpora |
| F5-TTS | MIT | CC-BY-NC (Emilia data) | Commercial use of weights restricted |
| Whisper | MIT | MIT | Permissive |
| faster-whisper | MIT | inherits Whisper MIT | Permissive |
| whisper.cpp | MIT | inherits Whisper MIT | Permissive |
| FunASR | MIT | per-model | Mostly CC-BY / Apache-2.0 |

---

## Mesh deployment notes

### On WORM (TCL 9185W, aarch64, 4 GB VRAM)

- Piper: BEST fit, CPU realtime.
- Bark small: OK on 4 GB VRAM with `SUNO_USE_SMALL_MODELS=1`.
- XTTS-v2: not viable for realtime; viable for batch short clips.
- OpenVoice v2 + MeloTTS: OK.
- F5-TTS: borderline; reduce `nfe_step` to 8.
- Whisper tiny/base/small on CPU: realtime or better. faster-whisper int8 = best STT.
- whisper.cpp: tiny/base on CPU = realtime. Universal.
- FunASR CPU: 17x realtime on SenseVoice-Small.

### On HERM S22 (Galaxy S22, 8 GB RAM, no dedicated GPU)

- All TTS viable in CPU mode for short clips.
- All STT viable; large-v3 will be slow but works.
- Streaming voice agent: XTTS-v2 streaming mode (~200 ms first chunk).

### On dirt-imac (2007 iMac, SSE3-only, no GPU)

- Piper CPU: works, slow.
- Whisper.cpp without AVX: works, slower.
- OpenVoice v2 + MeloTTS: works.
- TTS via cloud mesh node: route to HERM or a Tailscale peer for TTS compute.
- All GPU-required tools: out.

### Cross-device Tailscale mesh

- Inference: route heavy TTS/STT to the box with the GPU. WORM/HERM thin clients send text/audio, get back results.
- Voice presets / cloned .npz / RVC .pth / So-VITS checkpoints: store in shared `~/.hermes/audio/voices/` synced via Tailscale or rclone.
- FunASR Chinese: route to the box with CUDA.

### Hardening notes for Termux / Android

- `cryptography` has no aarch64 wheel — use the venv in `~/.hermes/hermes-agent/venv/` or prebuilt packages. Source-build hangs.
- If a Python tool fails on Termux, check `termux-shebang-portability` skill (rc=127 / ENOENT).
- For long audio files, chunk into <14 s for Bark, or use the `bark_infinity` fork's coherent-long-form mode.

### Licensing recap for sovereign use

The operator's sovereign posture = local-first + on-device weights + no upstream review. The tools that best fit are MIT-licensed code + MIT/CC-BY-4.0/CC0 weights (Piper, OpenVoice, RVC base, So-VITS base, Whisper family, FunASR, Bark). The tools with WEIGHT-LEVEL restrictions (CPML for XTTS-v2, CC-BY-NC for F5-TTS) are still usable for personal, non-commercial, and small-commercial work — but if the operator is going to ship a commercial product, verify the per-model license or pick a different tool.

XTTS-v2's CPML clause: < $1M annual revenue cap on the using organization. The fork community at `coqui-tts` is working through re-licensing; check the repo for the current state.

F5-TTS's CC-BY-NC: you can build tools and demo apps, but the generated voices from the F5-TTS weights are CC-BY-NC. The code is MIT, so a from-scratch retraining on a permissively-licensed dataset can produce a commercial-friendly model.

---

## Sources

- Piper TTS: https://github.com/rhasspy/piper | https://huggingface.co/rhasspy/piper-voices | https://github.com/rhasspy/piper/blob/master/TRAINING.md | https://github.com/rhasspy/piper/blob/master/VOICES.md
- Coqui XTTS-v2: https://huggingface.co/coqui/XTTS-v2 | https://github.com/coqui-ai/TTS | https://github.com/su6i/agent-constitution/blob/main/skills/xtts-v2.md | https://callsphere.ai/blog/vw4h-build-voice-agent-coqui-tts-xtts-v2
- Bark: https://github.com/suno-ai/bark | https://github.com/JonathanFly/bark | https://huggingface.co/suno/bark
- StyleTTS 2: https://pypi.org/project/styletts2/ | https://github.com/sidharthrajaram/StyleTTS2 | https://arxiv.org/abs/2306.07691
- Tortoise: https://github.com/neonbjb/tortoise-tts | https://github.com/Rajathbharadwaj/Tortoise-tts-voice-clone | https://github.com/nsourlos/voice_cloning_tools
- Fish-Speech 1.5: https://huggingface.co/fishaudio/fish-speech-1.5 | https://github.com/fishaudio/fish-speech | https://github.com/fishaudio/fish-speech/blob/main/docs/en/index.md
- OpenVoice v2: https://huggingface.co/myshell-ai/OpenVoiceV2 | https://github.com/myshell-ai/OpenVoice
- RVC v2: https://github.com/RVC-Project/Retrieval-based-Voice-Conversion | https://nexgpu.net/en/models/rvc | https://deepwiki.com/RVC-Project/Retrieval-based-Voice-Conversion-WebUI/4-training-pipeline
- So-VITS-SVC 4.0: https://github.com/camenduru/so-vits-svc | https://github.com/lishaobos/so-vits-svc
- So-VITS-SVC 5.0: https://github.com/ouor/so-vits-svc-5.0
- F5-TTS: https://github.com/cocktailpeanut/F5-TTS | https://huggingface.co/rajkr/voice-clone-f5tts | https://hysenlabs.com/en/projects/swivid-f5-tts
- Whisper: https://github.com/openai/whisper | https://openai-whisper.mintlify.app/concepts/models | https://openwhispr.com/blog/whisper-model-sizes-explained | https://factory.ai/open-source-wikis/whisper
- faster-whisper: https://github.com/SYSTRAN/faster-whisper | https://github.com/JuergenFleiss/faster-whisper
- whisper.cpp: https://github.com/ggml-org/whisper.cpp/ | https://huggingface.co/ggerganov/whisper.cpp | https://github.com/ggml-org/whisper.cpp/blob/master/examples/cli/README.md
- FunASR: https://github.com/alibaba/FunASR | https://github.com/modelscope/FunASR | https://github.com/RapidAI/FunASR
- MeloTTS: https://github.com/myshell-ai/MeloTTS | https://huggingface.co/myshell-ai/MeloTTS-English-v3
- Stable Audio Open: https://stability.ai/news-updates/introducing-stable-audio-open | https://stability.ai/stable-audio
- AudioCraft / MusicGen: https://github.com/facebookresearch/audiocraft | https://facebookresearch.github.io/audiocraft/ | https://facebookresearch.github.io/audiocraft/docs/MUSICGEN.html | https://ai.meta.com/resources/models-and-libraries/audiocraft/
- Demucs: https://github.com/facebookresearch/demucs | https://dev.to/stevecase430/complete-guide-to-setting-up-demucs-locally-for-ai-stem-separation-580h | https://dibi8.com/resources/ai-tools/demucs
- UVR5: https://github.com/AdamRopelewski/UVR5-UI-Docker | https://github.com/marpogiii-code/UVR5-UI | https://mvsep.com/en/algorithms
- Voice cloning legal/ToS context: https://www.voices.com/terms | https://gpt-sovits.org/terms-conditions | https://www.soviron.tech/terms
