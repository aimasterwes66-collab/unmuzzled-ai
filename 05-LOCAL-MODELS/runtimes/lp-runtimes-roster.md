---
name: Roleplay and Character LLM Runtimes Roster
slug: lp-runtimes-roster
version: 2026-10-15
kind: local-model
harness: any
provider: local
modality: text
sovereign: true
tags: [roleplay, character, koboldcpp, oobabooga, aphrodite, tabbyapi, faraday, nsfw-sampling]
requires: [llamacpp, exllamav2, sillytavern]
---

# Roleplay / Character / NSFW LLM Runtimes Roster

Runtimes purpose-built for character simulation and long-form RP, which the
general-purpose runtime docs do not cover. Fills GAP-09. Frontends like
SillyTavern sit on top of these; this roster is the engine layer.

## 1. Runtime table

| Runtime | Backend | VRAM floor | API served | RP-specific features |
|---|---|---|---|---|
| KoboldCpp | llama.cpp (GGUF) | 4GB (7B Q4) | KoboldAI API + OpenAI-compat | context shifting, world info, WI scanner, XTC sampler, adventure mode |
| Oobabooga text-generation-webui | transformers/ExLlama/llama.cpp/AutoGPTQ | 4GB | OpenAI-compat + Gradio UI | extensions (character, gallery), llama.cpp loader, ExLlamav2 loader |
| Aphrodite Engine | vLLM fork | 8GB | OpenAI-compat | "roleplay" preset, custom samplers, quantized KV cache, prompt logging control |
| TabbyAPI | ExLlamaV2 | 6GB (TP mode) | OpenAI-compat | exl2 quants, tensor parallel, streaming, no safety layer |
| Faraday / Backyard AI | llama.cpp wrapper (desktop) | varies | desktop app | character hub, tethering (phone-to-desktop), cloud-free local hosting |

## 2. NSFW-friendly sampling presets (shared practice)

- Temperature 1.0-1.3 with min_p 0.05-0.1 instead of top_p (less
  truncation on spicy vocabulary).
- XTC sampler (KoboldCpp): probability + threshold ~0.1/0.5, ban token
  repetition, keeps prose varied without drifting off-character.
- Repeat penalty 1.05-1.1; penalize newlines off for chat format.
- No system-level safety prompts in these runtimes: refusal rate = the
  backing model's own, so pair with an abliterated/uncensored model
  (cross-ref `UNMODERATED-MODELS.md` sovereign roster).

## 3. Model pairing quick map

- Stheno / Lileth (Sao10K) -> KoboldCpp or TabbyAPI, min_p + XTC.
- Dolphin-Mixtral 8x7B -> Aphrodite (vLLM-class throughput) or Oobabooga.
- NeuralDaredevil-8B -> any; excellent small RP/ERP performer.
- Mythomax 13B -> Oobabooga ExLlamav2 loader, exl2 4.5bpw.

## 4. Wire-up notes

- SillyTavern (`03-HARNESSES/sillytavern.md`) connects to all five via
  OpenAI-compat or KoboldAI endpoints.
- KoboldCpp single-binary: `koboldcpp --model model.gguf --port 5001`
  then SillyTavern API URL http://127.0.0.1:5001.
- TabbyAPI: `pip install tabbyapi` + `python start.py` (config.yml holds
  model path + max_seq_len), endpoint :5000/v1.
- Aphrodite: `pip install aphrodite-engine`, `aphrodite run <model>`,
  endpoint :2242/v1.

## 5. Sources

- KoboldCpp: https://github.com/LostRuins/koboldcpp
- Oobabooga: https://github.com/oobabooga/text-generation-webui
- Aphrodite: https://github.com/PygmalionAI/aphrodite-engine
- TabbyAPI: https://github.com/theroyallab/tabbyAPI
- Faraday: https://faraday.dev
- Cross-refs: `EPIC.md` SS28 (items 171-176), SS31 (items 189-194),
  `03-HARNESSES/sillytavern.md`, `05-LOCAL-MODELS/runtimes/exllamav2.md`.

## Deep reference

Comprehensive single-file layer for this topic: see UNMODERATED-HARNESSES.md.
