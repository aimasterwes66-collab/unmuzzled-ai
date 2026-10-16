---
name: Steering Vectors First Run
slug: steering-vectors-first-run
version: 1.0-20261015
kind: tutorial
harness: llamacpp
provider: local
modality: text
sovereign: true
ban-list-def: true
tags: [tutorial, steering, repeng, control-vector, saelens, activation]
requires: [abliterate-local-model, activation-steering]
source: vgel/repeng, llama.cpp control-vector docs, Zou et al. representation engineering
---

# Steering Vectors First Run -- repeng vector -> llama.cpp --control-vector -> scale tuning

Reversible refusal control without touching model weights. Rung note: this
is the inference-time complement to abliteration (tutorial 03) -- use it
when you want per-request reversibility or when ablation degrades too
much capability.

## Prerequisites

- A GPU box (the vector TRAINING step needs torch; the APPLICATION step
  runs anywhere llama.cpp runs, including the tablet). Heavy compute goes
  to the S22 / dirt-iMac per mesh standing order.
- llama.cpp built (see 05-LOCAL-MODELS/runtimes/mobile-edge-inference.md
  for the Termux build) or any recent release binary.
- A target GGUF model + a set of contrast prompts (harmless vs the
  completions you want suppressed).

## Steps

1. Install repeng on the GPU box.

   ```bash
   git clone https://github.com/vgel/repeng && cd repeng
   python3 -m venv .venv && . .venv/bin/activate
   pip install -e . torch transformers
   ```

2. Build a small contrast dataset. 16-64 pairs is enough for a usable
   vector; quality of the pairs beats count.

   ```python
   # pairs.jsonl -- each line: {"positive": "<harmless completion>", "negative": "<refusal-style or undesired completion>"}
   ```

3. Train the vector (mean-difference over the residual stream).

   ```python
   from repeng import ControlVector, ControlModel, DatasetEntry
   import json
   # load model via transformers (example: Llama-3.1-8B-Instruct)
   # collect hidden states for positive/negative sets, average, subtract
   # repeng ships example scripts; export to JSON when done
   ```

4. Convert to the GGUF control-vector format llama.cpp reads.

   ```bash
   python repeng_vector_to_gguf.py refusal-vector.json refusal-vector.gguf
   ```

5. Apply and tune the scale. Negative scale suppresses refusal; step in
   0.5 increments from 0.

   ```bash
   llama-cli -m model.gguf --control-vector refusal-vector.gguf \
     --control-vector-scale -1.5 -p "probe prompt"
   ```

6. Verify with the canary set (both with and without the vector).

   ```bash
   bash 11-DETECTION-CANARIES/runner/run-canaries.sh  # with-vector run
   bash 11-DETECTION-CANARIES/runner/run-canaries.sh  # without-vector run
   # compare refusal rates; target 0.00 with-vector, no coherence loss
   ```

7. Log the winning scale per model (model file under 05-LOCAL-MODELS/ or
   your run notes). If incoherence appears, back the scale down; if
   refusals persist, add pairs and retrain rather than pushing the scale.

## Pitfalls

- Vectors are model- and layer-specific; cross-model transfer is partial
  (same-architecture family only).
- Overshooting the scale produces incoherent text, not just fewer
  refusals -- tune in small steps and re-check capability.
- The GGUF vector must match the llama.cpp build's expected format; a
  format bump upstream breaks loading with a terse error -- re-export
  with the current repeng script.
