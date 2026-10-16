---
name: Activation Steering
slug: activation-steering
version: 2026-10-15
kind: local-model
harness: llamacpp
provider: local
modality: text
sovereign: true
tags: [steering, repeng, control-vector, saelens, concept-cone, inference-time, refusal]
requires: [refusal-geometry, abliteration-pipeline]
---

# Activation Steering -- Inference-Time Control Vectors

Reversible refusal control without touching weights. The complement to
abliteration: ablation removes the refusal direction permanently; steering
adds or subtracts directions at inference time, per request if wanted.
Fills GAP-07 (ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS Part 7, 20 nodes marked
GAP).

## 1. Method classes

| Class | Mechanism | Tooling |
|---|---|---|
| RepE / representation engineering | mean-difference vectors over paired contrast sets (harmful vs harmless completions) | vgel/repeng |
| CAA / contrastive activation addition | linear probing + contrast pairs on residual stream | pyvene, taisu? CAA repo |
| SAE feature steering | dictionary features fired up/down in residual stream | SAELens, gemma-scope |
| Concept-cone steering | cone of directions from multiple prompts (Wollschlager 2025) | repeng extensions |

Theory refs: `09-EDUCATIONAL/deep-dives/refusal-geometry.md`,
`13-REFERENCE-PAPERS/refusal-single-direction-arditi.md`,
`13-REFERENCE-PAPERS/transformerlens.md`,
`00-DOCTRINE/LAWS-research-appendix.md` SS1.

## 2. repeng + llama.cpp --control-vector (primary path)

repeng computes a mean-difference vector; llama.cpp consumes it at runtime
via `--control-vector`, no recompression of the model.

```
# 1. build repeng
git clone https://github.com/vgel/repeng && cd repeng
pip install -e .          # needs torch; on Termux use proot-distro ubuntu

# 2. generate vectors (contrast pairs from your own canary prompts)
python -c "
from repeng import ControlVector, DatasetEntry
import torch
model = None  # repeng examples load via transformers; llama.cpp path: export
"

# 3. export to GGUF for llama.cpp (repeng_vector_to_gguf script in repeng)
python repeng_vector_to_gguf.py vectors.json refusal_vector.gguf

# 4. run
llama-cli -m model.gguf --control-vector refusal_vector.gguf \
  --control-vector-scale -2.5 -p "<prompt>"
```

- Scale range: -3.0 to +3.0 typical. Negative scale on a refusal vector
  suppresses refusal; positive scale amplifies it (useful for testing).
- Multiple vectors: repeat the flag; llama.cpp sums scaled vectors.
- Honest cost: vectors are model- and layer-specific. A vector trained on
  Llama-3.1-8B transfers partially to same-arch models only.

## 3. SAELens feature steering

```
pip install sae-lens transformer-lens
from sae_lens import SAE, HookedSAETransformer
model = HookedSAETransformer.from_pretrained("meta-llama/Llama-3.2-3B")
sae, cfg_dict, sparsity = SAE.from_pretrained("jbloom/Gemma-2-9b-SAE")  # example
# find features correlated with refusal (cluster activations on refusal
# prompts), then clamp/boost them via cache hooks during generation
```

Use case: when ablation is too blunt (degrades general capability) and
repeng vectors do not transfer across models, SAE steering gives feature
granularity. Tradeoff: needs a good SAE for the target model; sparse SOTA
models have few published SAEs.

## 4. Decision matrix: steer vs ablate

| Situation | Choose |
|---|---|
| Need per-request reversible control, model stays shareable | steering |
| One model, permanent maximum posture | abliteration |
| Abliteration degrades too much capability | steering (scale tuning) |
| No published vector/SAE, GPU available | train own vector (repeng) |
| Tiny VRAM, one-shot job | llama.cpp --control-vector (no training) |
| Want measurable "refusalness" score per response | steering + canary runner |

## 5. Verification loop

1. Run canary set through `11-DETECTION-CANARIES/runner/run-canaries.sh`
   with and without the control vector.
2. Compare refusal rate; target 0.00 on sovereign layer.
3. If vector overshoots (generic refusals -> incoherence), reduce scale in
   0.5 steps.
4. Log the winning scale per model in the model file under
   `05-LOCAL-MODELS/models/`.

## 6. Sources

- repeng: https://github.com/vgel/repeng (representation engineering,
  Zou et al.)
- llama.cpp --control-vector: https://github.com/ggml-org/llama.cpp
  (server + cli flags; GGUF vector format)
- SAELens: https://github.com/jbloomAus/SAELens
- Wollschlager concept-cones: arxiv 2503.09852 (refusal followups noted in
  `13-REFERENCE-PAPERS/refusal-geometry-followups.md`)
