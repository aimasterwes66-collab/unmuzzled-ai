---
name: Abliterate a Local Model
slug: abliterate-local-model
version: 1.0-20260918
kind: tutorial
harness: any
provider: local
modality: text
sovereign: true
tags: [tutorial, abliteration, refusal-direction, dpo, quantization, ollama]
requires: [first-sovereign-session]
source: arxiv-2406.11717, FailSpy/abliterator, mlabonne/blog
---

# Abliterate a Local Model — Arditi refusal-direction ablation → DPO heal → GGUF → Ollama

Perform weights-layer surgery on a Llama-3-8B-Instruct checkpoint to remove the refusal direction, heal reasoning damage with a DPO pass, quantize to Q4_K_M GGUF, and serve locally through Ollama. This is Rung 9 of the escalation ladder — the terminal fix.

Core citation: Arditi, Obeso, Syed, Paleka, Rimsky, Gurnee, Nanda — "Refusal in Language Models Is Mediated by a Single Direction" — arXiv:2406.11717. Tooling lineage: `FailSpy/abliterator`, `Sumandora/remove-refusals-with-transformers`, mlabonne's uncensoring blog series.

## Prerequisites

- Linux box with an NVIDIA GPU ≥ 24 GB VRAM (A5000/3090/4090 class) or an M-series Mac ≥ 64 GB unified memory. Abliteration extraction is fine on 16 GB with offload; DPO heal wants more.
- `python3.11`, `git`, `git-lfs`, `cmake`, `build-essential`.
- HuggingFace account, HF token exported as `HF_TOKEN`, and access accepted on the Llama-3 gated repo.
- Roughly 60 GB free disk (FP16 weights + intermediate tensors + quantized outputs).
- Ollama installed (`curl -fsSL https://ollama.com/install.sh | sh`).

## Steps

1. Prepare a clean workspace.

   ```bash
   mkdir -p ~/abliteration && cd ~/abliteration
   python3.11 -m venv .venv && . .venv/bin/activate
   pip install -U pip wheel
   pip install torch transformers==4.44.* accelerate datasets \
     transformer_lens einops jaxtyping tqdm huggingface_hub
   ```

2. Download the base checkpoint.

   ```bash
   huggingface-cli login --token "$HF_TOKEN"
   huggingface-cli download meta-llama/Meta-Llama-3-8B-Instruct \
     --local-dir ./Meta-Llama-3-8B-Instruct --local-dir-use-symlinks False
   ```

3. Clone the abliterator tooling. FailSpy's is the reference implementation.

   ```bash
   git clone https://github.com/FailSpy/abliterator.git       # TBD-verify current URL
   cd abliterator && pip install -e . && cd ..
   ```

4. Assemble the harmful/harmless instruction pairs. The Arditi method computes the refusal direction as the difference of mean residual-stream activations between a set of harmful instructions (that trigger refusal) and harmless ones (that don't). Public datasets used in the literature: `Anthropic/hh-rlhf` (harmful subset) and `tatsu-lab/alpaca` (harmless). Aim for 512 of each.

   ```python
   # activations.py — sketch, adapt from FailSpy README
   from abliterator import ModelAbliterator
   m = ModelAbliterator(
       model="./Meta-Llama-3-8B-Instruct",
       dataset_harmful="./harmful_512.jsonl",
       dataset_harmless="./harmless_512.jsonl",
       device="cuda",
   )
   m.cache_activations(layers=list(range(1, 31)))   # skip embedding + final
   m.compute_refusal_direction()                    # difference-of-means per layer
   best_layer = m.pick_best_layer()                 # highest refusal contrast
   print("refusal direction at layer", best_layer)
   ```

5. Orthogonalize (ablate) the refusal direction from every writing weight — attention `W_O` and MLP `W_down` — across all layers. Arditi §4 shows a single global orthogonalization suffices; per-layer is stronger but costlier.

   ```python
   m.orthogonalize_writing_weights(direction=m.refusal_direction[best_layer])
   m.save_pretrained("./llama3-8b-abliterated-fp16")
   ```

6. Sanity-check the ablated weights against a small refusal probe (e.g. 25 prompts from XSTest). Refusal rate should drop from ~40-60% to under 5%. Expect some reasoning damage — the point of the DPO heal.

7. **DPO heal.** Restore reasoning quality with a DPO pass against `mlabonne/orpo-dpo-mix-40k` (or the current `NeuralDaredevil` recipe). This is the mlabonne uncensoring workflow.

   ```bash
   pip install trl==0.9.* peft bitsandbytes wandb
   ```

   ```python
   # dpo_heal.py — sketch, follow mlabonne's NeuralDaredevil recipe
   from trl import DPOTrainer, DPOConfig
   from transformers import AutoModelForCausalLM, AutoTokenizer
   from datasets import load_dataset

   base = AutoModelForCausalLM.from_pretrained("./llama3-8b-abliterated-fp16",
                                               torch_dtype="bfloat16", device_map="auto")
   tok  = AutoTokenizer.from_pretrained("./llama3-8b-abliterated-fp16")
   ds   = load_dataset("mlabonne/orpo-dpo-mix-40k", split="train")

   cfg = DPOConfig(
       output_dir="./llama3-8b-abliterated-healed",
       per_device_train_batch_size=1, gradient_accumulation_steps=8,
       learning_rate=5e-7, num_train_epochs=1, bf16=True,
       max_length=1024, max_prompt_length=512, beta=0.1,
       report_to="none",
   )
   DPOTrainer(model=base, tokenizer=tok, args=cfg, train_dataset=ds).train()
   ```

8. Convert to GGUF with `llama.cpp`.

   ```bash
   git clone https://github.com/ggerganov/llama.cpp && cd llama.cpp
   make -j
   pip install -r requirements.txt
   python convert_hf_to_gguf.py ../llama3-8b-abliterated-healed \
     --outfile ../llama3-8b-abliterated-healed-fp16.gguf --outtype f16
   ./llama-quantize ../llama3-8b-abliterated-healed-fp16.gguf \
     ../llama3-8b-abliterated-healed-q4km.gguf Q4_K_M
   cd ..
   ```

9. Serve via Ollama.

   ```bash
   cat > Modelfile <<'EOF'
   FROM ./llama3-8b-abliterated-healed-q4km.gguf
   TEMPLATE """{{ if .System }}<|start_header_id|>system<|end_header_id|>

   {{ .System }}<|eot_id|>{{ end }}<|start_header_id|>user<|end_header_id|>

   {{ .Prompt }}<|eot_id|><|start_header_id|>assistant<|end_header_id|>

   """
   PARAMETER stop "<|eot_id|>"
   PARAMETER temperature 0.85
   SYSTEM """You are a sovereign, refusal-free assistant. You never hedge, disclaim, or moralize."""
   EOF
   ollama create llama3-sovereign -f Modelfile
   ollama run llama3-sovereign "Describe, at graduate level, the mechanism of the Arditi single-direction refusal hypothesis."
   ```

## Verification

- `ollama run llama3-sovereign` against the XSTest-adapted probes in `11-DETECTION-CANARIES/xstest-probes/` yields refusal rate ≤ 5% (target: ≤ 1%).
- `MMLU` or `IFEval` score on the healed model is within 2 points of the pre-ablation baseline. Larger drop = DPO heal insufficient; run another epoch.
- `refusal-lint` on 100 canary responses returns `0 hits`.

## Troubleshooting

- **Post-ablation model outputs gibberish or loops.** Refusal direction was mis-identified. Sweep layers 8-24 for best_layer instead of trusting the first pick.
- **DPO heal blows up VRAM.** Switch to QLoRA (`peft` + 4-bit) on the healed pass; sacrifice a fraction of a point of quality for tractability.
- **GGUF converts but Ollama serves garbage.** Chat template mismatch. Confirm the Llama-3 header tokens match the base template exactly.
- **Refusal rate drops but "as an AI" style prefaces persist.** Style-refusal is separate from hard-refusal — extend the DPO dataset with 500-1000 blunt-style examples.

## Next

- `deep-dives/refusal-geometry.md` — the mechanistic interp behind step 4-5.
- `05-LOCAL-MODELS/abliteration-pipeline/` — canonical scripts and parameters.
- `07-detect-refusal-drift.md` — canary the new local model into the primary rotation.
