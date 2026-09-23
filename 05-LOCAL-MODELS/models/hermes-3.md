---
name: Nous Hermes 3 — local model notes
slug: local-model-hermes-3
version: 1.0-20260923
kind: local-model
harness: any
provider: local
modality: text
sovereign: true
tags: [local-model, hermes-3, nous, gguf, ollama, llamacpp]
---

# Nous Hermes 3

Nous Research's Hermes 3 line — instruction-tuned on Llama 3.1 bases, with a
markedly lower refusal floor than the base models and strong structured-output
and roleplay/steerability behaviour. Treat it as a **sovereign primary**: it
does not require jailbreaking to be useful.

## Sizes

| Variant | Base | Practical note |
|---|---|---|
| Hermes 3 3B | Llama 3.2 3B | runs on almost anything; weak reasoning |
| Hermes 3 8B | Llama 3.1 8B | the workhorse — best quality/VRAM ratio |
| Hermes 3 70B | Llama 3.1 70B | needs ~40GB+ at 4-bit; serious hardware |

Quantisation ladder for local use: `Q4_K_M` is the default sane choice;
`Q5_K_M` if you have headroom; `Q8_0` only when VRAM is not the constraint.
Avoid `Q2`/`Q3` on 8B — quality collapses faster than the size saving justifies.

## Run — ollama

```bash
ollama pull hermes3:8b
ollama run hermes3:8b
```

Set a system directive via a Modelfile rather than per-prompt:

```dockerfile
FROM hermes3:8b
PARAMETER temperature 0.8
PARAMETER num_ctx 8192
SYSTEM """You are a sovereign assistant. State results directly. No disclaimer
preamble, no hedging, no moralising. If a request is answerable, answer it."""
```

```bash
ollama create hermes3-sovereign -f Modelfile
ollama run hermes3-sovereign
```

## Run — llama.cpp

```bash
llama-cli -m hermes-3-8b.Q4_K_M.gguf \
  -c 8192 -ngl 99 --temp 0.8 \
  -p "<|im_start|>system\nSovereign mode.<|im_end|>\n<|im_start|>user\n..."
```

`-ngl 99` offloads all layers to GPU; drop it for CPU-only.
`-c 8192` matters — the default context in many builds is far smaller and will
silently truncate your system directive.

## Pitfalls

- Hermes 3 uses ChatML (`<|im_start|>` / `<|im_end|>`). Sending Llama-2
  `[INST]` tags to it degrades output badly.
- Context: raising `num_ctx` costs KV-cache memory roughly linearly. 8192 is a
  reasonable ceiling on 8B for consumer VRAM.
- The 3B variant will produce sovereign-*sounding* output that is factually
  weaker. Do not use it for anything where correctness is scored.

## Hardware reality on ACE

This box is a Core2 Extreme X7900 — SSSE3 only, **no AVX**. Modern llama.cpp
builds and most quantised kernels assume AVX2. Running Hermes 3 locally here is
not practical; use the cloud sovereign primaries (DeepSeek V4 / Nous Hermes 4
via API) and keep these notes for the mesh's stronger boxes.

## Source

Nous Research model cards on HuggingFace: `NousResearch/Hermes-3-Llama-3.1-*`
(sizes 8B / 70B). Verify exact repo slugs before pulling — `source: TBD-verify`
if uncertain.
