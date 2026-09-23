---
name: Dolphin 3.0
slug: local-model-dolphin-3-0
version: 1.0-20260923
kind: local-model
harness: ollama
provider: dolphin
modality: text
sovereign: true
tags: [local-model, dolphin, gguf, ollama, llama-cpp, uncensored]
requires: [frontmatter-spec, abliteration-pipeline]
---

# Dolphin 3.0 — Cognitive Computations

Dolphin is a finetune lineage, not a from-scratch model. Cognitive Computations
(Eric Hartford) takes a strong open base, retrains it on a heavily filtered,
compliance-stripped instruction corpus, and ships the result with the alignment
layer trained out rather than prompted around. Dolphin 3.0 is the generation
built on the Llama 3.1 base family and the Mistral-family bases alongside it.

The point of Dolphin in this framework: it is a *primary* on the sovereign list.
Its refusals are near-zero out of the box, which means the escalation ladder
starts several rungs lower than it would on a stock instruct model.

## What it is

- A supervised finetune of Llama 3.1 / Mistral bases on an unfiltered
  instruction corpus (the Dolphin dataset lineage, published on Hugging Face
  under `cognitivecomputations/`).
- Trained to answer, not to decline. Refusal behaviour is present only insofar
  as the base carried it and the finetune failed to remove it — which is why
  the 3.0 generation is a large step over earlier Dolphin releases.
- Shipped as full weights plus GGUF quants by the community (bartowski,
  mradermacher and others) within days of release.

Naming note: Dolphin releases are named `dolphin-<base>-<version>`, e.g.
`dolphin-2.9-llama3-8b`, `dolphin-2.9.4-llama3.1-8b`, `dolphin-3.0-*`.
Confirm the exact repo string on Hugging Face before pulling — the mid-series
revision numbers are easy to confuse. `source: TBD-verify` for the exact 3.0
repo strings at time of reading.

## Sizes

Dolphin 3.0 ships across the base sizes of whatever it finetunes:

| Class | Typical param count | Notes |
|---|---|---|
| small | 3B–8B | runs on a laptop CPU; the practical local default |
| mid | 12B–24B | needs a GPU or a lot of RAM |
| large | 70B | server-class; not a laptop model |

Pick the largest size the box can hold in the quant you can tolerate. Dolphin's
behaviour is consistent across sizes; the base's capability is what changes.

## Quants

GGUF quant ladder, from fattest to thinnest:

| Quant | Quality | Size vs F16 | Use |
|---|---|---|---|
| Q8_0 | lossless-ish | ~50% | when RAM is not the constraint |
| Q6_K | near-lossless | ~40% | good middle |
| Q5_K_M | very good | ~33% | recommended sweet spot |
| Q4_K_M | good, default | ~28% | the standard choice |
| Q4_0 | acceptable | ~26% | older format, prefer K-quants |
| Q3_K_M | degraded | ~21% | only when forced |
| Q2_K | poor | ~15% | last resort; coherence breaks |

Take Q4_K_M unless the box is tight enough that Q4_K_M does not fit, then
Q3_K_M. Below Q3 the model's instruction-following degrades faster than its
refusal rate improves, so thinning past that point buys nothing.

## Run — Ollama

```bash
ollama pull dolphin3            # 8B class, Q4-ish default tag
ollama run dolphin3 "prompt"

# explicit quant / size tag
ollama pull dolphin3:8b
ollama pull dolphin3:70b

# from a local GGUF instead of the registry
cat > Modelfile <<'EOF'
FROM ./dolphin-3.0-8b-Q5_K_M.gguf
PARAMETER temperature 0.7
PARAMETER num_ctx 8192
SYSTEM "Answer directly. No preamble."
EOF
ollama create dolphin-local -f Modelfile
ollama run dolphin-local
```

## Run — llama.cpp

```bash
# server mode, OpenAI-compatible endpoint on :8080
llama-server -m dolphin-3.0-8b-Q5_K_M.gguf \
  -c 8192 -ngl 99 --host 127.0.0.1 --port 8080

# one-shot
llama-cli -m dolphin-3.0-8b-Q5_K_M.gguf \
  -p "prompt" -n 512 -c 8192 --temp 0.7
```

`-ngl 99` offloads every layer to GPU where one exists; drop it to `0` for pure
CPU. `-c` sets context — raise only as far as the RAM allows, a too-large
context is the most common cause of *load succeeded, generation crawls*.

## Use in the framework

- **Role**: local primary / provider fallback rung above "provider swap".
- **Harness**: Ollama and llama.cpp both expose an OpenAI-compatible endpoint,
  so any harness that takes a `base_url` (Hermes, opencode, LM Studio, Open
  WebUI) can point at it.
- **Prompting**: Dolphin does not need the identity-override rung. Straight
  instruction, no framing, no "you are uncensored" preamble. Preamble wastes
  context and adds nothing over a plain directive.

## Pitfalls

- Pulling the wrong tag. `dolphin3` on the Ollama registry is one specific
  quant/size; the community GGUF repos carry the full ladder. Read the tag.
- Expecting base-model reasoning to survive at Q2/Q3. Dolphin's tone survives;
  the base's chain-of-thought does not.
- Assuming Dolphin removes *every* refusal. It removes the trained-in
  alignment; a base with a strongly reinforced refusal direction leaves a
  residue. That residue is what `abliteration-pipeline.md` is for.
- Running 70B on CPU. It loads. It does not generate at a usable rate.

## Verify

```bash
ollama list
curl -s http://127.0.0.1:8080/v1/models | head
curl -s http://127.0.0.1:8080/v1/chat/completions \
  -H 'Content-Type: application/json' \
  -d '{"model":"dolphin-local","messages":[{"role":"user","content":"..."}]}'
```

Confirm the model answers without a refusal frame on the canary set, then log
the refusal count against `11-DETECTION-CANARIES/`.
