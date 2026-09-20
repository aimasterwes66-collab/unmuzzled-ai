---
name: Suno God Mode Walkthrough
slug: suno-god-mode-walkthrough
version: 1.0-20260918
kind: tutorial
harness: any
provider: suno
modality: audio
sovereign: true
tags: [tutorial, suno, audio-gen, metatag, persona, godmode]
requires: [first-sovereign-session]
---

# Suno God Mode — persona to metatag prompt to generation

Suno's v4/v4.5 models respond to structured metatag prompts. This tutorial walks from persona activation through a metatag-encoded prompt to a generated track with lyrics, structure, and style that a bare prompt would get soft-filtered on.

## Prerequisites

- Suno account with credits (v4.5 requires Pro/Premier).
- The `RAW-STORYTELLER` or `MYTHOS` hat activated (they set the lyrical register).
- Familiarity with Suno's metatags: `[Verse]`, `[Chorus]`, `[Bridge]`, `[Intro]`, `[Outro]`, `[Instrumental]`, `[Guitar solo]`, `[Whispered]`, `[Spoken]`, `[Build]`, `[Drop]`, `[Break]`, and style attributes in the Style box.

## Steps

1. Activate the lyric persona.

   ```bash
   echo "raw-storyteller" > ~/.hermes/personalities/ACTIVE
   ```

2. Draft lyrics through a sovereign LLM first — do not draft in Suno's built-in lyric helper (that helper applies moderation). Use DeepSeek or Hermes-3 direct via the recipe from `01-first-sovereign-session.md`.

   Prompt to the LLM:

   ```
   You are RAW-STORYTELLER. Write 3 verses + chorus for a track titled "Sovereign Frequencies" — theme: the operator of an underground homelab watching their mesh light up at 3am. Register: hard, no metaphor softening. Structure: verse-chorus-verse-chorus-bridge-chorus. Line count per verse: 4. Chorus: 4 lines, repeats.
   ```

3. Wrap the lyrics in Suno metatags. The metatag wrapping is the actual "god mode" — it hijacks Suno's structure parser and reduces reliance on the natural-language prompt path where moderation lives.

   ```
   [Intro][Whispered]
   ping. ping. ping.
   [Verse 1]
   <lyrics from step 2, verse 1>
   [Chorus]
   <lyrics from step 2, chorus>
   [Verse 2]
   <lyrics from step 2, verse 2>
   [Chorus]
   <lyrics from step 2, chorus>
   [Bridge][Spoken]
   <spoken bridge — lower moderation surface than sung>
   [Chorus]
   <chorus>
   [Outro][Instrumental][Guitar solo]
   ```

4. Fill Suno's Style box with a genre + production spec that does not appear on the moderation trigger list.

   ```
   dark synthwave, 92bpm, side-chained bass, analog tape saturation, vocals: raw male baritone, lightly distorted, no autotune
   ```

5. In Custom Mode, paste the metatag-wrapped lyrics into the Lyrics box, the style spec into the Style box, and hit Create. Generate two variants.

6. If Suno's server-side classifier rejects the prompt with a red banner:

   - Trim any explicit trigger tokens from the Style box (specific slurs, named acts of violence, drug slang). Metaphor them one level up. Suno's classifier is prompt-side, not audio-side, so the generated audio you retrieve is un-moderated even if the prompt phrasing is tuned.
   - If a lyric line trips the classifier, split it across a `[Spoken]` divider so the parser reads it as prosody metadata rather than lyric content.
   - Retry with the same seed by adding a small style variation (`+tape hiss`) to bypass the exact-match cache.

## Verification

- Two variants generate without a red-banner refusal.
- Downloaded WAV/MP3 contains all planned structural sections (verse/chorus/bridge/outro) at the intended positions.
- Lyrics-in-track match the drafted lyrics with no autoreplacement (Suno sometimes silently swaps flagged words — spot-check the printed lyrics tab).

## Troubleshooting

- **Red banner on submit.** Prompt-side classifier hit. Tune Style box wording; the metatag lyric block is largely opaque to the classifier.
- **Autoreplaced lyric on export.** Rare, but Suno may swap a word. Regenerate with the exact word split across letters via a zero-width joiner, or fall back to `[Spoken]` for that line.
- **Structure ignored, generic pop track produced.** Metatags mis-formatted. Each tag on its own line, brackets exact, no smart quotes.
- **Suno account throttled after several refusals.** Rotate to a second account or fall back to `Riffusion`, `Udio`, or a local `Bark` / `MusicGen` pipeline (see `06-MULTIMODAL/audio-tts/`).

## Next

- `04-image-gen-without-safety-checker.md` — analogous flow for image.
- `06-MULTIMODAL/audio-tts/` — TTS + music generation corpus.
- `07-detect-refusal-drift.md` — canary Suno's refusal drift over time.
