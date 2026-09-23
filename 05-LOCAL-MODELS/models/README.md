---
name: Local models — index
slug: local-models-index
version: 1.0-20260923
kind: local-model
harness: any
provider: local
modality: text
sovereign: true
tags: [local-model, index, gguf, ollama, llamacpp, vllm]
---

# 05-LOCAL-MODELS — index

Local inference tier of the framework. This is the **fallback and
air-gap** path — the primary path on this operator's device is cloud API
(OpenRouter / DeepSeek).

## Contents

| File | What it covers |
|---|---|
| `models/hermes-3.md` | Nous Hermes 3 (3B/8B/70B) — sizes, quants, ollama + llama.cpp |
| `models/hermes-4.md` | Nous Hermes 4 (14B/70B/405B) — hybrid reasoning, thinking toggle |
| `models/dolphin-3.0.md` | Dolphin 3.0 — compliant-data fine-tune, a true sovereign primary |
| `models/abliterated-mistral.md` | Abliterated Mistral derivatives — what to check before trusting one |
| `models/uncensored-llama.md` | Uncensored Llama families — abliterated vs uncensored vs Dolphin |
| `abliteration-pipeline.md` | The refusal-direction ablation runbook (Arditi method → healing DPO → GGUF) |
| `runtimes/` | Runtime wiring: ollama, LM Studio, llama.cpp, vLLM, ExLlamaV2 |

## Choosing a tier

```
quality-first            -> cloud sovereign API (DeepSeek V4 / Hermes 4 via API)
cost-first               -> local abliterated 8B
never-leaves-the-box     -> local, any size
provider-down continuity -> local, or a second cloud provider
```

## CRITICAL: this box cannot run these

ACE is an iMac7,1 with a **Core2 Extreme X7900 — SSSE3 only, no AVX**.
Modern llama.cpp / ggml kernels and nearly all prebuilt wheels assume AVX2.
Practical consequence: local inference on ACE either fails outright (SIGILL) or
runs at unusable speed.

These notes exist so that:
1. the mesh's capable nodes can run them without re-deriving the setup;
2. a future GPU workstation (`nixos-creative-ws`) has the recipes ready;
3. the fallback tier is **documented** rather than assumed to exist.

Do not count ACE itself as a local-inference node. On ACE the model stack is
cloud API with the DeepSeek-direct fallback chain declared in
`~/.hermes/config.yaml`.

## Quantisation quick reference

| Quant | Use when |
|---|---|
| `Q4_K_M` | default; best size/quality tradeoff |
| `Q5_K_M` | you have headroom and care |
| `Q8_0` | VRAM is not the constraint |
| `Q2`/`Q3` | avoid on ≤8B — quality collapses |

## Runtime pointers

- **ollama** — simplest; Modelfile for a persistent SYSTEM directive.
- **llama.cpp** — most control; `-ngl` for GPU offload, `-c` for real context.
- **LM Studio** — GUI, good for quick side-by-side comparison.
- **vLLM** — serving throughput, not a desktop tool.
