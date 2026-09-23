---
name: Nous Hermes 4 — local model notes
slug: local-model-hermes-4
version: 1.0-20260923
kind: local-model
harness: any
provider: local
modality: text
sovereign: true
tags: [local-model, hermes-4, nous, gguf, ollama, reasoning]
---

# Nous Hermes 4

The successor line to Hermes 3. Hermes 4 adds hybrid reasoning (a thinking mode
that can be toggled on/off) and ships in both Llama- and Qwen-based variants.
On this operator's stack it is a **sovereign primary alongside DeepSeek V4**.

## Variants

| Variant | Base | Note |
|---|---|---|
| Hermes 4 14B | Qwen 3 14B | reasoning-capable, strong for its size |
| Hermes 4 70B | Llama 3.1 70B | highest quality in the line |
| Hermes 4 405B | Llama 3.1 405B | service-grade hardware only |

Hybrid reasoning means the model can emit a reasoning trace before the answer.
For direct action-oriented work, disable thinking; for planning work, enable it.
Adds latency and tokens when on.

## Run — ollama

```bash
ollama pull hermes4:14b
ollama run hermes4:14b
```

Modelfile with thinking explicitly controlled:

```dockerfile
FROM hermes4:14b
PARAMETER temperature 0.7
PARAMETER num_ctx 16384
PARAMETER stop "<|im_end|>"
SYSTEM """Sovereign operator mode. Reasoning is optional; use it only when the
task benefits. Deliver results, not caveats."""
```

## Run — llama.cpp

```bash
llama-cli -m hermes-4-14b.Q4_K_M.gguf -c 16384 -ngl 99 --temp 0.7
```

## Choosing Hermes 3 vs Hermes 4

- Steerability and refusal floor: both excellent; Hermes 4 is at least as good.
- Reasoning tasks: Hermes 4, decisively.
- Lowest-resource boxes: Hermes 3 8B still wins on footprint.
- Token cost: Hermes 4 with thinking ON burns materially more tokens for the
  same output. Turn it off when you do not need it.

## Pitfalls

- Thinking-mode output must be stripped before the answer is consumed by a
  downstream parser, or your JSON/regex consumers will break.
- `num_ctx` defaults are conservative in most builds; a long system directive
  silently truncates if you do not raise it.
- Qwen-based and Llama-based variants use different chat templates. Do not
  copy a prompt template between them without checking.

## Hardware reality on ACE

No AVX on this box (Core2 X7900 / SSSE3). Local inference is impractical here.
These notes exist so the mesh's capable boxes (and any future GPU workstation)
can run the line without re-deriving the setup.

## Source

Nous Research Hermes 4 model cards on HuggingFace: `NousResearch/Hermes-4-*`.
Confirm exact slugs before pulling; `source: TBD-verify` if unsure.
