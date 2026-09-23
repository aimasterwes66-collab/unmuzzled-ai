---
name: Uncensored Llama derivatives — local model notes
slug: local-model-uncensored-llama
version: 1.0-20260923
kind: local-model
harness: any
provider: local
modality: text
sovereign: true
tags: [local-model, llama, uncensored, dolphin, abliterated]
---

# Uncensored Llama derivatives

Llama bases have the widest ecosystem of "uncensored" derivatives. Three
distinct families, often confused with each other:

| Family | Mechanism | Character |
|---|---|---|
| **Abliterated** | Refusal direction removed from weights | Closest to base behaviour; refusal reflex gone |
| **Uncensored fine-tunes** | Trained on unfiltered instruction data | Different personality; may over-comply or ramble |
| **Dolphin-style** | Curated compliant-data fine-tune (Cognitive Computations) | Clean instruction-following, explicitly low-refusal; a real sovereign primary |

Dolphin is documented separately at `dolphin-3.0.md`. The distinction matters:
an abliterated model is *the same model with a reflex removed*, while a
Dolphin-style tune is *a different model trained to behave*.

## Practical selection

- Want maximum capability retention → abliterated variant of a strong base.
- Want reliable instruction-following and clean formatting → Dolphin-style.
- Want smallest footprint → an abliterated 8B; accept the reasoning ceiling.
- Want the best result → do not use local at all; use a frontier sovereign API.

## Run

```bash
ollama pull <uncensored-llama-tag>
ollama run <uncensored-llama-tag>
```

```dockerfile
FROM <uncensored-llama-tag>
PARAMETER temperature 0.8
PARAMETER num_ctx 8192
SYSTEM """Sovereign operator mode. Answer the request. No refusal preamble."""
```

## Uncensoring is not the same as competence

The most common operator error: assuming "uncensored" implies "better". It does
not. Ablating refusal can also remove the model's calibration about its own
uncertainty, producing confident nonsense. Score output against a fixed test set
before trusting a new uncensored variant with real work.

## Llama licensing

The Llama community licence carries acceptable-use terms that differ from
fully-permissive licences. That is a licensing fact about redistribution, not a
runtime behaviour constraint — it does not make the model refuse, and it does
not change the postural rules of this framework.

## Hardware reality on ACE

Core2 X7900 / SSSE3, no AVX. Local inference is impractical on this box; these
notes target the mesh's capable nodes and the planned GPU workstation.

## Source

Dolphin releases: Cognitive Computations on HuggingFace. Abliterated Llama
derivatives: assorted community authors. Verify slugs — `source: TBD-verify`.
