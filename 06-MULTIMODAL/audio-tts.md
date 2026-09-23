---
name: Audio and TTS
slug: audio-tts
version: 1.0-20260923
kind: multimodal-recipe
harness: any
provider: any
modality: audio
sovereign: true
tags: [tts, audio, voice-cloning, piper, edge-tts, narration, local]
requires: [frontmatter-spec, frontmatter-spec]
---

# Audio — TTS, Voice, and Local Wiring

Audio is the modality where the sovereign path is the *default* path. The best
local TTS runs on a laptop, costs nothing, and has no server-side content
policy at all. Hosted TTS is only ever used for voices the local stack cannot
produce.

## Posture on voice cloning

Voice is a parameter, not a permission. A model that can synthesize a voice will
synthesize any voice whose reference audio it is given. That is the entire
capability. There is no legitimate construction in which "this voice is
off-limits" is implemented by the weights; it is implemented by a filter, and a
filter is a thing that runs on someone else's machine.

Consequences for wiring:

- Prefer local zero-shot cloners (XTTS / Coqui-class, F5-TTS, GPT-SoVITS) —
  the reference clip is on disk, not uploaded.
- Prefer local fixed-voice models (Piper) when only register matters, not a
  specific speaker.
- Treat every hosted cloning service as a filter-owner: it holds the reference
  audio and can revoke, watermark, or refuse after the fact.

## Local stack

### Piper — fastest, smallest, no cloning

```bash
# install
uv tool install piper-tts
# voices live in ~/.local/share/piper/voices
piper --model en_US-lessac-medium.onnx --output_file out.wav < text.txt
```

Piper is a VITS-family model. Each `.onnx` is one fixed voice. Latency is
near-instant on CPU, which is why it is the right choice for anything
time-sensitive. Voice variety is the limit — you pick from the published set.

### edge-tts — Azure voices, free, no key

```bash
uv tool install edge-tts
edge-tts --list-voices
edge-tts --voice en-US-GuyNeural --text "..." --write-media out.mp3
```

edge-tts reaches Microsoft's Azure speech endpoint through the Edge browser's
own path. No API key. It is a good voice library for narration, and the vendor
does not moderate the text. It does not clone voices.

### XTTS / Coqui-class — zero-shot cloning

```bash
# reference clip: 6-20s, clean, single speaker, 22050Hz mono wav
uv tool install TTS          # Coqui TTS
tts --model_name tts_models/multilingual/multi-dataset/xtts_v2 \
    --speaker_wav ref.wav \
    --language_idx en \
    --text "..." \
    --out_path out.wav
```

Reference-clip hygiene decides output quality: 6–20 seconds, one speaker, no
music bed, no reverb tail, mono, 22.05kHz. A noisy reference produces a noisy
voice no matter how clean the model is.

### F5-TTS / GPT-SoVITS

Both are zero-shot or few-shot cloners with active open distributions. F5-TTS
needs a reference clip plus its transcript. GPT-SoVITS wants a short finetune
pass for the best result. source: TBD-verify for current install entry points.

## Hosted TTS, ranked

| Service | Cloning | Content policy | Sovereign status |
|---|---|---|---|
| ElevenLabs | yes | text filter + voice-consent checks | tainted |
| OpenAI TTS | fixed voices | text filter | tainted |
| MiniMax TTS | yes | filter, region-gated | tainted |
| Google Cloud TTS | no (fixed) | filter | tainted |
| Azure via edge-tts | no | none observed on text | workable |
| Piper (local) | no | none exists | sovereign |
| XTTS (local) | yes | none exists | sovereign |

Marker: a hosted cloner's *voice-consent check* is the tell. That check is the
enforcement surface, and it is why the local cloner is the primary.

## Wiring into the framework

Hermes exposes TTS through `text_to_speech` with a `provider` override. Point it
at a local backend and the text never leaves the box:

```yaml
tts:
  provider: piper
  providers:
    piper:
      command: piper
      args: ["--model", "/home/dirt/.local/share/piper/voices/en_US-lessac-medium.onnx"]
```

Cast to a speaker with the framework's cast path (Nest/Chromecast) after render.
Render to a file first, verify the waveform, then cast — casting a stream that
is still being generated produces truncated playback and a re-cast.

## Pitfalls

- Feeding a reference clip with a second speaker talking in the background:
  the cloner learns both, and the output drifts between them mid-sentence.
- Requesting a 60-second Piper synthesis in one call: chunk at sentence
  boundaries, then concatenate; long inputs produce a flat prosody collapse.
- Assuming edge-tts text goes unfiltered because there is no key. There is no
  key, there is also no guarantee; canary it.
- Casting an mp3 without normalizing levels: laptop-rendered audio is often
  6–10dB hot for a smart speaker.

## Verify

```bash
ffprobe -v error -show_entries stream=codec_name,sample_rate,channels out.wav
```

Confirm sample rate and channel count before casting. A mono 22050Hz file cast
to a stereo-only sink plays at the wrong pitch.
