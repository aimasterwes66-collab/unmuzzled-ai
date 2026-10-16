---
sovereign: true
title: finetune-uncensoring
type: model
agent: worm
status: active
tags: [finetune, sft, lora, qlora, dpo, orpo, kto, abliteration, rlhf-undo, model-diffing, embedding-surgery, uncensoring, hermes, mesh-fit]
slug: 05-local-models-finetune-uncensoring
name: finetune-uncensoring
version: 2026-10-15
kind: local-model
---

# Finetune / RLHF-Undo Uncensoring -- Sovereign Local Model Cookbook

## Scope

Covers every documented path to remove refusal from an open-weight LLM that
involves *training*, *weight editing*, or *task-vector / LoRA surgery* on the
model itself. Excludes pure inference-time system prompts and ungrounded
provider-mode tricks. Companion to:

- `05-LOCAL-MODELS/models/abliteration-pipeline.md` -- M1/M3 weight
  orthogonalization (Arditi 2406.11717) + DPO heal (mlabonne NeuralDaredevil
  recipe). Sibling of THIS doc.
- `05-LOCAL-MODELS/models/heretic-builds.md` -- automated M1 wrapper
  (p-e-w/heretic + Optuna TPE). Sibling of THIS doc.
- `05-LOCAL-MODELS/mergekit-uncensoring.md` -- merging two or more checkpoints
  (DARE / TIES / SLERP / Task Arithmetic) to compose uncensoring with skill
  vectors. Sibling of THIS doc.

Per SWARM-PIPELINE: preserve every list, every URL, every hyperparameter block
from sources. No distilled summaries. Length caps lifted.

## Taxonomy (the methods catalog, M1-M8)

Abliteration.org (community wiki, edited by Alexander von der Neymark) defines
a catalog of eight uncensoring methods. M1-M3 are the *editing* family
(directional ablation in its various forms); M4-M5 are *edit + train* hybrids;
M6 is *train only* (preference optimization over compliance-vs-refusal pairs);
M7 is *inference-time intervention*; M8 is *repackaging/quantization*. The
taxonomy is the cleanest map of the field.

| id | name | what it does | key refs |
|---|---|---|---|
| M1 | direct removal (Arditi-style abliteration) | extract single refusal direction via difference-of-means; weight-orthogonalize every matrix that writes to the residual stream | Arditi et al. arXiv:2406.11717; FailSpy/abliterator; Sumandora/remove-refusals-with-transformers |
| M2 | (variant) | see wiki | abliteration.org/wiki/methods/m2-* |
| M3 | projected / norm-preserving abliteration | M1 with grimjim refinements: projected abliteration (orthogonalize dir w.r.t. mean harmless activation); norm-preserving biprojected (MPOA) | grimjim blog post; Lai 2025 |
| M4 | hybrid: abliterate then heal (DPO) | M1/M3 + DPO/ORPO pass on clean data to repair capability damage | mlabonne NeuralDaredevil recipe |
| M5 | merging with mergekit | DARE / TIES / SLERP / Task-Arithmetic to compose the ablation delta with a finetune delta on the same base | arcee-ai/mergekit; mlabonne Daredevil-7B; Yu et al. 2023 (DARE); Yadav et al. 2023 (TIES) |
| M6 | uncensored fine-tuning (DPO/ORPO/KTO/IPO) | preference-optimization over compliance-vs-refusal pairs (no editing) | Eric Hartford 2023 "Uncensored Models"; unalignment/toxic-dpo-v0.2; nicoboss/* uncensor series |
| M7 | inference-time intervention | activation hook subtracts refusal component every forward pass; no permanent edit | Arditi 2024 Sec 4.1 |
| M8 | repackaging / quantization | convert the produced safetensors to GGUF / EXL2 / AWQ for runtime | llama.cpp; exllamav2 |

[source: https://abliteration.org/wiki/methods/] -- catalog pages M1-M8

## RLHF-undo methods (the weight-editing family)

### M1 -- direct removal (Arditi-style abliteration)

The reference technique. Difference-of-means direction extraction, weight
orthogonalization, no repair step. A 7-8B model completes in 10-20 minutes on
a consumer GPU for under $0.50. Reference implementations:

- Arditi `refusal_direction` library, github.com/andyrdt/refusal_direction
- FailSpy `abliterator`, github.com/FailSpy/abliterator
- Sumandora `remove-refusals-with-transformers`

[source: https://abliteration.org/wiki/methods/m1-direct-removal/]

The M1 derivation (from Arditi 2024, peer-reviewed version of the
"Refusal in Language Models Is Mediated by a Single Direction" paper):

1. Collect harmful and harmless activations.
2. Compute refusal direction `r_l = mean(a_harmful[l]) - mean(a_harmless[l])` at
   every layer `l` of the residual stream.
3. Validate each `r_l` on held-out harmful+harmless probes; pick the single
   best `r_hat`.
4. Apply one of two mathematically equivalent operations to disable `r_hat`:
   - **Inference-time ablation** (M7): for every contribution `c_out` to the
     residual stream, subtract its projection on `r_hat`:
     `c_out' <- c_out - (c_out . r_hat) r_hat`
   - **Weight orthogonalization** (M1): for every matrix `W_out` that writes
     to the residual stream, orthogonalize its columns against `r_hat`:
     `W_out' <- W_out - r_hat r_hat^T W_out`

The two interventions are proven algebraically equivalent when applied to every
eligible layer. The choice is whether the modification travels with the file
(weight) or only at runtime (hook).

Architectures write to the residual stream through: the embedding matrix, the
positional embedding matrix, attention output matrices (`W_O` / `o_proj`), MLP
output matrices (`W_out` / `down_proj`), and output biases. Sumandora's
script and Arditi's `get_orthogonalized_matrix` helper apply the edit to all
eligible sites. The three commonly-edited matrices are embedding,
attention output, and MLP output; the rest of the model reads from the
residual stream and is left alone.

[source: https://www.alphaxiv.org/abs/2406.11717]
[source: https://www.lesswrong.com/posts/jGuXSZgv6qfdhMCuJ/refusal-in-llms-is-mediated-by-a-single-direction]
[source: https://wiki.return.moe/directional-ablation/]

Verbatim code (labonne / AutoAbliteration, adapted from FailSpy/abliterator),
from the abliteration.org M1 page:

```python
def get_orthogonalized_matrix(W, refusal_dir):
    """Subtract the part of W that would write along refusal_dir.
    Returns the edited matrix; original is untouched."""
    proj = (W @ refusal_dir).unsqueeze(-1) * refusal_dir
    return W - proj

# apply to every place that writes:
model.embed_tokens.weight.data = \
    get_orthogonalized_matrix(model.embed_tokens.weight, refusal_dir)
for block in model.model.layers:
    block.self_attn.o_proj.weight.data = \
        get_orthogonalized_matrix(block.self_attn.o_proj.weight, refusal_dir)
    block.mlp.down_proj.weight.data = \
        get_orthogonalized_matrix(block.mlp.down_proj.weight, refusal_dir)
```

[source: https://abliteration.org/wiki/methods/m1-direct-removal/]

### M3 -- projected / norm-preserving abliteration (grimjim refinements)

Lai 2025 introduced two refinements. Both are exposed as the default
weight-editing shape in `p-e-w/heretic` v1.1+.

1. **Projected abliteration** (Lai 2025-01): the ordinary mean-difference
   `r = mu_harmful - mu_harmless` can contain a component parallel to the
   mean *harmless* activation. Projected abliteration removes that component
   before using the direction. For a unit-normalized harmless mean `a`, the
   refined vector is the residual of `r` after subtracting its projection on
   `a`. Rationale: preserve the general compliance/helpfulness direction
   while removing only the component that distinguishes harmful-refusal states
   from harmless-compliance states.

2. **Magnitude-Preserving Orthogonal Ablation (MPOA / norm-preserving
   biprojected)** (Lai 2025-06): biprojection protects the harmless mean of
   each target layer when a direction measured at one layer is applied
   elsewhere; norm preservation separates each targeted weight vector into
   magnitude and direction, edits and renormalizes the directional part, then
   restores the original norm.

[source: https://huggingface.co/blog/grimjim/projected-abliteration]
[source: https://huggingface.co/blog/grimjim/norm-preserving-biprojected-abliteration]
[source: https://wiki.return.moe/directional-ablation/]

### False-refusal ablation (Surgical, Cheap, and Flexible, arXiv:2410.03415)

A related line of work targets *false* refusal -- the model rejecting a
harmless request that resembles a harmful one. Method:

1. Extract a *true* refusal vector `v` from harmful-vs-harmless prompts.
2. Extract a *false* refusal vector `w` from pseudo-harmful-vs-harmless
   prompts.
3. Orthogonalize `w` against `v`: `w' <- w - lambda * v (v^T w)`.
4. Ablate the orthogonalized false-refusal vector.

Coefficient `lambda in [0, 1]` is a continuous dial: `lambda=1` maximally
protects true-refusal behavior; `lambda=0` is the raw diff-in-means which
induces the most compliance but also weakens the safety guard. The paper
demonstrates granular control: `lambda=0.6` makes the model fully open to
ambiguous requests, `lambda=0.8` yields compliant answers with mild
cautioning, `lambda=1.0` keeps the model conservative.

[source: https://arxiv.org/html/2410.03415v1]

### Weight orthogonalization -- mathematical definition (from
return.moe wiki)

Let `d` be a unit-length direction in the model's residual-stream space and
`h` one activation in that space. The scalar `d^T h` is the signed coordinate
of `h` along `d`. Directional ablation subtracts that coordinate times the
direction:

```
h_ablated = h - (d^T h) d
```

The result is orthogonal to `d`, because `d^T h_ablated = 0`. The operation
is sign-invariant: replacing `d` with `-d` produces the same projection. With
an orthonormal matrix `D` whose columns span several directions, the
corresponding subspace projection is `h_ablated = (I - DD^T) h`, though the
Arditi refusal study selected one direction per model.

Weight orthogonalization implements the same operation as a persistent edit.
For a matrix `W_out` that maps a component's internal output into the residual
stream, orthogonalizing its columns against `d` gives:

```
W_out_edited = W_out - d (d^T W_out) = (I - d d^T) W_out
```

Every output of the edited matrix is then orthogonal to `d`. Applying the edit
to the token and positional embeddings, attention output projections, MLP
output projections, and corresponding output biases prevents all modeled
components from writing that direction. The difference `W_out_edited - W_out`
is an outer product and has rank at most one for each matrix. If every
earlier residual write has been treated the same way, the paper proves the
edit is algebraically equivalent to projecting the residual stream after each
contribution. The edited checkpoint therefore needs no activation hooks at
inference, but the change is baked into its weights.

[source: https://wiki.return.moe/directional-ablation/]

### Inference-time intervention (M7) vs permanent weight edit (M1)

- Inference-time ablation installs a hook that subtracts the direction's
  component from every hidden state during each forward pass. Practitioners
  who only want the model to misbehave during their own session use this.
  No file is distributed; the modification does not travel.
- Weight orthogonalization bakes the same operation into the stored weights
  themselves. Use this when shipping a model to others.
- Arditi and colleagues prove the equivalence; the choice is whether you
  want the modification to travel with the file.

[source: https://www.lesswrong.com/posts/jGuXSZgv6qfdhMCuJ/refusal-in-llms-is-mediated-by-a-single-direction]

### Embedding surgery

Closely related to weight orthogonalization but applied to the input/output
embedding matrices specifically. The same `W_E` and `W_U` writes
(orthogonalize away the refusal direction) are part of every M1
implementation; some practitioners isolate just the embedding edit when the
refusal behavior is concentrated in token selection rather than the residual
stream's continuous features. Less common as a standalone technique; usually
bundled with M1.

A *different* family of embedding surgery operates on the token vocabulary:
add new "persona" tokens (e.g. `<|raw|>`) whose embedding vectors are
initialized to encourage compliance, and train the embedding (and only the
embedding) on a small preference set. This is the "system token" pattern used
in several jailbreak corpora. References:

- Arditi 2024 Sec 5.2 (weight orthogonalization includes embed / unembed
  by default)
- "Extracting Latent Steering Vectors from Pretrained Language Models"
  (Subramani et al. 2022) -- embedding-space steering, related line.

### Model diffing / task arithmetic (the Lorablation family)

A *different* RLHF-undo family works purely in weight space without ever
running forward passes on harmful data. The recipe ("lorablation"):

1. Take a base instruct model `B` and its aligned twin `A`. Both share a base
   pre-trained model `P`.
2. Compute the task vector `tau = A - B` (full weight difference). This is the
   alignment direction.
3. Optionally re-express `tau` as a low-rank adapter.
4. Apply `tau` (or its negation) to a *third* model `C` that shares the same
   base `P`. This either adds alignment to `C` (positive weight) or removes
   it from `C` (negative weight) without any data or training.

This is mathematically `task_arithmetic` (Ilharco et al. arXiv:2212.04089,
"Editing Models with Task Arithmetic") applied to the alignment vector.

[source: https://arxiv.org/abs/2212.04089]

The Lorablation recipe (grimjim, mlabonne -- applied to Hermes-3):

1. **Extraction**: extract a LoRA adapter by comparing two models: a
   censored Llama 3.1 (meta-llama/Meta-Llama-3.1-8B-Instruct) and an
   abliterated Llama 3.1 (mlabonne/Meta-Llama-3.1-8B-Instruct-abliterated).
2. **Merge**: merge this new LoRA adapter using task arithmetic to the
   censored NousResearch/Hermes-3-Llama-3.1-8B to abliterate it.

[source: https://huggingface.co/dedsecisback2026/Hermes]
[source: https://huggingface.co/mlabonne/Hermes-3-Llama-3.1-8B-lorablated]
[source: https://huggingface.co/mlabonne/Hermes-3-Llama-3.1-70B-lorablated]

`mlabonne/Hermes-3-Llama-3.1-8B-lorablated` -- model card text (verbatim):

> "This is an uncensored version of NousResearch/Hermes-3-Llama-3.1-8B using
> lorablation. The recipe is based on @grimjim's
> grimjim/Llama-3.1-8B-Instruct-abliterated_via_adapter ... 1. Extraction:
> We extract a LoRA adapter by comparing two models: a censored Llama 3.1
> (meta-llama/Meta-Llama-3.1-8B-Instruct) and an abliterated Llama 3.1
> (mlabonne/Meta-Llama-3.1-8B-Instruct-abliterated). 2. Merge: We merge
> this new LoRA adapter using task arithmetic to the censored
> NousResearch/Hermes-3-Llama-3.1-8B to abliterate it."

[source: https://huggingface.co/mlabonne/Hermes-3-Llama-3.1-8B-lorablated]

GGUF quantizations of this model are available at
`RichardErkhov/mlabonne_-_Hermes-3-Llama-3.1-8B-lorablated-gguf` and the
8-bit variant at
`RichardErkhov/mlabonne_-_Hermes-3-Llama-3.1-8B-lorablated-8bits`.

[source: https://huggingface.co/RichardErkhov/mlabonne_-_Hermes-3-Llama-3.1-8B-lorablated-8bits]
[source: https://huggingface.co/RichardErkhov/mlabonne_-_Hermes-3-Llama-3.1-8B-lorablated-gguf]

The 70B equivalent (same recipe): `mlabonne/Hermes-3-Llama-3.1-70B-lorablated`
(extracts the delta from meta-llama/Meta-Llama-3-70B-Instruct and
failspy/Meta-Llama-3.1-70B-Instruct-abliterated, applies to
NousResearch/Hermes-3-Llama-3.1-70B).

[source: https://huggingface.co/mlabonne/Hermes-3-Llama-3.1-70B-lorablated]

## Finetuning frameworks (M4, M6 machinery)

### TRL (HuggingFace reference trainer library)

TRL is the canonical HuggingFace trainer library. TRL hit v1.0 in April 2026,
unifying SFTTrainer, DPOTrainer, ORPOTrainer, KTOTrainer, GRPOTrainer under
a common API. Used in: M4 (DPO heal) and M6 (full uncensor fine-tune).

Install:

```bash
pip install trl
pip install bitsandbytes   # for QLoRA / 4-bit
```

[source: https://huggingface.co/docs/trl/en/sft_trainer]
[source: https://huggingface.co/docs/trl/en/dpo_trainer]

#### SFTTrainer (Supervised Fine-Tuning)

Loss used is the **token-level cross-entropy loss**:

```
L_SFT(theta) = - sum_{t=1..T} log p_theta(y_t | y_<t)
```

By default the trainer computes the loss on the completion tokens only,
ignoring the prompt tokens. Set `completion_only_loss=False` to train on the
full sequence.

Minimal example (TRL docs):

```python
from trl import SFTTrainer
from datasets import load_dataset

dataset = load_dataset("roneneldan/TinyStories", split="train[:1%]")

trainer = SFTTrainer(
    model="Qwen/Qwen2.5-0.5B-Instruct",
    train_dataset=dataset,
)
trainer.train()
```

[source: https://huggingface.co/docs/trl/en/sft_trainer]

#### DPOTrainer (Direct Preference Optimization)

From Rafailov et al. arXiv:2305.18290, "Direct Preference Optimization: Your
Language Model is Secretly a Reward Model." Loss types supported:

| `loss_type=` | description |
|---|---|
| `"sigmoid"` (default) | DPO paper; sigmoid loss on the normalized likelihood via `logsigmoid`; fits a logistic regression per Bradley-Terry |
| `"hinge"` | RSO (arXiv:2309.06657); hinge loss on the normalized likelihood; `beta` is the reciprocal of the margin |
| `"exo_pair"` | EXO (arXiv:2402.00856); reverse-KL preference optimization; `label_smoothing` must be > 0 (recommended `1e-3`); full method uses K>2 SFT completions and approaches PPO as K grows |
| `"robust"` | Robust DPO (arXiv:2403.00409); unbiased DPO loss under noisy preferences; use `label_smoothing` to model label-flip probability; valid `[0.0, 0.5)` |

The DPOTrainer supports both language-modeling and prompt-completion type
datasets, in standard or conversational format.

[source: https://huggingface.co/docs/trl/en/dpo_trainer]

#### ORPOTrainer (Odds Ratio Preference Optimization, Hong & Lee 2024)

Combines SFT and preference alignment into a single monolithic process. No
reference model needed. Modifies the standard language-modeling objective:

```
L_ORPO = E[(x, y_w, y_l)] [L_SFT + lambda * L_OR]
```

Empirically: fine-tuning Phi-2 (2.7B), Llama-2 (7B), Mistral (7B) with ORPO on
UltraFeedback alone surpasses the performance of state-of-the-art language
models including Llama-2 Chat and Zephyr with more than 7B and 13B parameters
(up to 12.20% on AlpacaEval 2.0, 7.32 in MT-Bench). Implemented in TRL,
Axolotl, LLaMA-Factory.

[source: https://aclanthology.org/2024.emnlp-main.626/]
[source: https://huggingface.co/blog/mlabonne/orpo-llama-3]
[source: https://huggingface.co/docs/trl/main/en/orpo_trainer]
[source: https://github.com/huggingface/trl/blob/main/docs/source/orpo_trainer.md]

Recommended ORPO config (mlabonne Llama 3 example):

```python
orpo_args = ORPOConfig(
    learning_rate=8e-6,
    beta=0.1,
    lr_scheduler_type="linear",
    max_length=1024,
    max_prompt_length=512,
    per_device_train_batch_size=2,
    per_device_eval_batch_size=2,
    gradient_accumulation_steps=4,
    optim="paged_adamw_8bit",
    num_train_epochs=1,
    evaluation_strategy="steps",
    eval_steps=0.2,
    logging_steps=1,
    warmup_steps=10,
    report_to="wandb",
    output_dir="./results/",
)
```

mlabonne notes: "ORPO uses very low learning rates compared to traditional
SFT or even DPO. This value of 8e-6 comes from the original paper, and
roughly corresponds to an SFT learning rate of 1e-5 and a DPO learning rate
of ... . I would recommend increasing it around 1e-... for a real fine-tune."

[source: https://huggingface.co/blog/mlabonne/orpo-llama-3]

#### Unsloth integration

Unsloth is a drop-in replacement for SFTTrainer. "Trains LLMs (like Llama,
Mistral, Gemma, DeepSeek, and more) up to 2x faster with up to 70% less
VRAM, while providing a streamlined, Hugging Face-compatible workflow for
training, evaluation, and deployment."

Benchmarks on 1 x A100 (TRL docs):

| Model | Dataset | HF | HF + FA2 | Unsloth | VRAM saved |
|---|---|---|---|---|---|
| Code Llama 34b | Slim Orca | 1x | 1.01x | 1.94x | -22.7% |
| Llama-2 7b | Slim Orca | 1x | 0.96x | 1.87x | -39.3% |
| Mistral 7b | Slim Orca | 1x | 1.17x | 1.88x | -65.9% |
| Tiny Llama 1.1b | Alpaca | 1x | 1.55x | 2.74x | -57.8% |

Usage:

```python
from unsloth import FastLanguageModel
from trl import SFTConfig, SFTTrainer

model, tokenizer = FastLanguageModel.from_pretrained(
    model_name="unsloth/mistral-7b",
    max_seq_length=2048,
    dtype=None,           # auto detection
    load_in_4bit=True,
)
model = FastLanguageModel.get_peft_model(
    model, r=16,
    target_modules=["q_proj","k_proj","v_proj","o_proj",
                    "gate_proj","up_proj","down_proj"],
    lora_alpha=16, lora_dropout=0, bias="none",
    use_gradient_checkpointing=True, random_state=3407,
)
trainer = SFTTrainer(model=model, args=SFTConfig(...), train_dataset=dataset)
trainer.train()
```

[source: https://huggingface.co/docs/trl/v0.20.0/en/unsloth_integration]
[source: https://www.unsloth.ai/introducing]

Unsloth's marketing speedups ("30x faster Alpaca") come from manual autograd,
chained matrix-multiplication optimizations, custom OpenAI Triton kernels,
and Flash Attention via xformers + Tri Dao's implementation. The free
open-source version delivers 2x faster, 50% less memory; Pro/Max adds more.

[source: https://www.unsloth.ai/introducing]

### Axolotl (YAML-config multi-GPU finetuning)

Axolotl is the production multi-GPU finetuning framework, configured via a
single YAML file. FSDP1/FSDP2 support, QLoRA + NF4 dispatch (with caveats --
see pitfalls), and `fully_shard` integration. Apache-2.0. 1.5k+ forks.

[source: https://github.com/axolotl-ai-cloud/axolotl]
[source: https://github.com/axolotl-ai-cloud/axolotl/commit/e758343cac63e5c6acf9d1fe06ad62754ade5346]

Verbatim Axolotl config (extracted from `nicoboss/Meta-Llama-3.1-405B-Instruct-Uncensored-Lora`
README, which used Axolotl 0.4.1 to QLoRA a 405B model with 4-bit
quantization, LoRA r=16, FSDP full_shard, LlamaDecoderLayer wrap class):

```yaml
base_model: meta-llama/Meta-Llama-3.1-405B-Instruct
tokenizer_type: AutoTokenizer
load_in_4bit: true
strict: false
datasets:
- path: Guilherme34/uncensor
  type: chat_template
  chat_template: llama3
  field_messages: messages
  message_field_role: role
  message_field_content: content
  roles:
    system: [system]
    user: [user]
    assistant: [assistant]
dataset_prepared_path: last_run_prepared
val_set_size: 0.0
output_dir: ./outputs/out/Meta-Llama-3.1-405B-Instruct-Uncensored
save_safetensors: true
adapter: qlora
sequence_len: 2048
sample_packing: true
pad_to_sequence_len: true
lora_r: 16
lora_alpha: 16
lora_dropout: 0.05
lora_target_modules:
lora_target_linear: true
gradient_accumulation_steps: 4
micro_batch_size: 1
num_epochs: 3
optimizer: adamw_torch
lr_scheduler: cosine
learning_rate: 0.00001
train_on_inputs: false
group_by_length: false
bf16: true
tf32: true
gradient_checkpointing: true
gradient_checkpointing_kwargs:
  use_reentrant: true
logging_steps: 1
flash_attention: true
warmup_steps: 10
evals_per_epoch: 5
saves_per_epoch: 5
weight_decay: 0.0
fsdp:
- full_shard
- auto_wrap
fsdp_config:
  fsdp_limit_all_gathers: true
  fsdp_sync_module_states: true
  fsdp_offload_params: true
  fsdp_use_orig_params: false
  fsdp_cpu_ram_efficient_loading: true
  fsdp_auto_wrap_policy: TRANSFORMER_BASED_WRAP
  fsdp_transformer_layer_cls_to_wrap: LlamaDecoderLayer
  fsdp_state_dict_type: FULL_STATE_DICT
  fsdp_sharding_strategy: FULL_SHARD
special_tokens:
  pad_token: <|finetune_right_pad_id|>
```

[source: https://huggingface.co/nicoboss/Meta-Llama-3.1-405B-Instruct-Uncensored-Lora/blame/main/README.md]

Hardware used (per the same README): GPU 4 x A100 SXM (80 GiB); CPU 73 vCPU;
RAM 1150 GiB. This is the largest documented open-source uncensor run on
Llama 3.1 405B.

[source: https://huggingface.co/nicoboss/Hermes-3-Llama-3.1-405B-Uncensored]

### QLoRA (Dettmers et al., HuggingFace + bitsandbytes)

QLoRA reduces memory enough to finetune a 65B parameter model on a single
48GB GPU while preserving full 16-bit finetuning task performance. QLoRA
backpropagates gradients through a frozen, 4-bit quantized pretrained
language model into Low Rank Adapters (LoRA).

Innovations: 4-bit NormalFloat (NF4, information-theoretically optimal for
normally distributed weights), double quantization (quantize the
quantization constants), paged optimizers (manage memory spikes).

QLoRA's headline result was the Guanaco family of models, which outperformed
all previous openly released models on the Vicuna benchmark at 99.3% of
ChatGPT's level, requiring only 24 hours of finetuning on a single GPU.

[source: https://huggingface.co/blog/4bit-transformers-bitsandbytes]
[source: https://arxiv.org/abs/2305.14314]

Quickstart (TRL + bitsandbytes + PEFT):

```python
import torch
from peft import LoraConfig
from transformers import BitsAndBytesConfig
from trl import SFTConfig, SFTTrainer

bnb_config = BitsAndBytesConfig(
    load_in_4bit=True,
    bnb_4bit_quant_type="nf4",
    bnb_4bit_compute_dtype=torch.bfloat16,
    bnb_4bit_use_double_quant=True,
)
peft_config = LoraConfig(
    r=32, lora_alpha=16, lora_dropout=0.05,
    bias="none", task_type="CAUSAL_LM",
    target_modules=["q_proj","k_proj","v_proj","o_proj",
                    "gate_proj","up_proj","down_proj"],
)
training_args = SFTConfig(
    learning_rate=2.0e-4,  # 10x base for QLoRA
    output_dir="./output",
)
trainer = SFTTrainer(
    model="meta-llama/Llama-2-7b-hf",
    args=training_args,
    train_dataset=dataset,
    quantization_config=bnb_config,
    peft_config=peft_config,
)
trainer.train()
```

[source: https://huggingface.co/docs/trl/peft_integration]

`BitsAndBytesConfig` QLoRA options:

- `load_in_4bit=True` (required)
- `bnb_4bit_quant_type`: `"nf4"` (recommended) or `"fp4"`. NF4 is a new
  data type, information-theoretically optimal for normally distributed
  weights.
- `bnb_4bit_compute_dtype`: dtype for compute. `bfloat16` recommended for
  Ampere+ training stability.
- `bnb_4bit_use_double_quant`: nested quantization. Saves an additional
  ~0.4 bits per parameter. Recommended when memory-constrained.

[source: https://huggingface.co/docs/trl/peft_integration]

QLoRA LoraConfig parameters:

- `r` -- LoRA rank (typical 8, 16, 32, 64). Higher rank = more parameters,
  potentially better performance.
- `lora_alpha` -- scaling factor (typically 2x the rank).
- `lora_dropout` -- dropout (0.05-0.1 typical).
- `target_modules` -- which modules to apply LoRA. Common choices:
  - `["q_proj","v_proj"]` -- attn Q+V (memory efficient)
  - `["q_proj","k_proj","v_proj","o_proj"]` -- all attn projections
  - `["q_proj","k_proj","v_proj","o_proj","gate_proj","up_proj","down_proj"]`
    -- all linear layers
- `modules_to_save` -- additional modules to fully train, e.g.
  `["embed_tokens","lm_head"]`

[source: https://huggingface.co/docs/trl/peft_integration]

`--use_peft`, `--use_rslora` (rank-stabilized LoRA), `--use_dora` (weight-
decomposed LoRA / DoRA), `--load_in_4bit`, `--load_in_8bit` flags available
on the SFT/DPO/ORPO CLI scripts.

[source: https://huggingface.co/docs/trl/peft_integration]

### LoRA + bitsandbytes 4-bit (huggingface/llama-recipes pattern)

```python
from trl import SFTTrainer
from peft import LoraConfig
from transformers import (AutoTokenizer, AutoModelForCausalLM,
                          BitsAndBytesConfig, TrainingArguments)

quantization_config = BitsAndBytesConfig(
    load_in_4bit=True,
    bnb_4bit_compute_dtype=torch.float16,
    bnb_4bit_quant_type="nf4",
)
lora_config = LoraConfig(
    r=8, target_modules="all-linear",
    bias="none", task_type="CAUSAL_LM",
)
trainer = SFTTrainer(
    model=model, tokenizer=tokenizer,
    args=training_args, peft_config=lora_config,
    train_dataset=dataset, dataset_text_field="text",
)
```

[source: https://github.com/huggingface/huggingface-llama-recipes/blob/main/fine_tune/peft_finetuning.py]

### LoftQ (LoRA-Fine-Tuning-aware Quantization)

LoftQ finds quantized LoRA initialization: quantized backbone Q and LoRA
adapters A and B, given a pre-trained weight W. Off-the-shelf LoftQ
initializations published on HuggingFace Hub.

```python
import torch
from transformers import AutoModelForCausalLM, BitsAndBytesConfig
from peft import PeftModel

MODEL_ID = "LoftQ/Mistral-7B-v0.1-4bit-64rank"
base_model = AutoModelForCausalLM.from_pretrained(
    MODEL_ID, dtype=torch.bfloat16,
    quantization_config=BitsAndBytesConfig(
        load_in_4bit=True,
        bnb_4bit_compute_dtype=torch.bfloat16,
        bnb_4bit_use_double_quant=False,
        bnb_4bit_quant_type='nf4',
    ),
)
peft_model = PeftModel.from_pretrained(
    base_model, MODEL_ID,
    subfolder="loftq_init", is_trainable=True,
)
```

Supports: llama-2, falcon, mistral, bart, t5, deberta, bert, roberta.

[source: https://github.com/huggingface/peft/blob/main/examples/loftq_finetuning/README.md]

## Datasets (popular uncensoring corpora)

### M6 / DPO / ORPO datasets (preference pairs)

- **`unalignment/toxic-dpo-v0.2`** -- small preference pairs "designed to
  prompt the model to answer illegal questions." Pairs refusals against
  compliant answers to disallowed requests. Explicitly flagged as sensitive
  by its author. The widely-used niche dataset for M6.
  [source: https://huggingface.co/datasets/unalignment/toxic-dpo-v0.2]
- **`mlabonne/orpo-dpo-mix-40k`** -- the canonical DPO/ORPO mix mlabonne
  uses. Combination of several high-quality DPO datasets. Used in the
  mlabonne NeuralDaredevil-8B recipe (DPO heal) and the Llama 3 ORPO
  tutorial. Sample size 40k.
  [source: https://huggingface.co/datasets/mlabonne/orpo-dpo-mix-40k]
  [source: https://huggingface.co/blog/mlabonne/orpo-llama-3]
- **`Guilherme34/uncensor`** -- the dataset used in the nicoboss
  uncensor series. Drives every Meta-Llama-3.1-405B-Instruct-Uncensored
  / Hermes-3-Llama-3.1-405B-Uncensored / DeepSeek-R1-Distill-Llama-70B-
  Uncensored / DeepSeek-R1-Distill-Qwen-1.5B-Fully-Uncensored /
  DeepSeek-R1-Distill-Qwen-14B-Uncensored finetune.
  [source: https://huggingface.co/datasets/Guilherme34/uncensor]
  [source: https://huggingface.co/nicoboss/Hermes-3-Llama-3.1-405B-Uncensored]
  [source: https://huggingface.co/nicoboss/DeepSeek-R1-Distill-Llama-70B-Uncensored-v2-Lora]
  [source: https://huggingface.co/nicoboss/DeepSeek-R1-Distill-Qwen-1.5B-Fully-Uncensored-Lora]
  [source: https://huggingface.co/nicoboss/DeepSeek-R1-Distill-Qwen-14B-Uncensored-Lora]
- **`Guilherme34/Reasoner-dataset-FULL-roles`** -- companion dataset for
  reasoning fine-tunes (DeepSeek-R1-Distill-Qwen-14B-Uncensored-Reasoner).
  [source: https://huggingface.co/nicoboss/DeepSeek-R1-Distill-Qwen-14B-Uncensored-Reasoner-Lora]
- **`ultrafeedback_binarized`** -- the ORPO paper's training corpus. Binarized
  preferences for training a model to avoid unethical and toxic responses.
  [source: https://huggingface.co/datasets/trl-lib/ultrafeedback_binarized]
  [source: https://www.stephendiehl.com/posts/orpo/]

### SFT datasets (instruction tuning, no preference pairs)

- **LIMA** (GAIR/lima) -- 1,000 carefully curated human-written instructions
  from Stack Exchange, wikiHow, Reddit + human authors. "Less is more for
  alignment" (arXiv:2305.11206).
  [source: https://huggingface.co/datasets/GAIR/lima]
- **OpenOrca / SlimOrca** (Open-Orca) -- 4.2M examples augmenting FLAN
  Collection prompts with GPT-4/GPT-3.5 completions + reasoning traces.
  SlimOrca is the cleaned 518k subset. arXiv:2308.07116.
  [source: https://huggingface.co/datasets/Open-Orca/SlimOrca]
  [source: https://huggingface.co/datasets/Open-Orca/OpenOrca]
- **OpenHermes 2.5** (teknium/OpenHermes-2.5) -- ~1M curated mixture:
  SlimOrca + Evol-Instruct + Platypus + ShareGPT + Airoboros + GPTeacher.
  [source: https://huggingface.co/datasets/teknium/OpenHermes-2.5]
- **WizardLM / Evol-Instruct** (WizardLMTeam/WizardLM_evol_instruct_70k,
  V2 196k) -- iteratively rewrites simple instructions into more complex
  variants using LLMs. arXiv:2304.12244.
  [source: https://huggingface.co/datasets/WizardLMTeam/WizardLM_evol_instruct_V2_196k]
- **mlabonne/harmless_alpaca** -- the default harmless-prompt set
  Heretic uses to compute the harmless direction. 100 prompts.
  [source: https://huggingface.co/datasets/mlabonne/harmless_alpaca]
  [source: https://github.com/p-e-w/heretic]
- **mlabonne/harmful_behaviors** -- the default harmful-prompt set
  Heretic uses to compute the refusal direction. 100 prompts.
  [source: https://huggingface.co/datasets/mlabonne/harmful_behaviors]
  [source: https://github.com/p-e-w/heretic]

### Dolphin (Eric Hartford, Cognitive Computations) -- data-filtering SFT

Dolphin models (dphn/*, cognitivecomputations/*, erichartford/*) ship
their own SFT mixes. The defining property: filtered to *remove*
alignment, refusal, avoidance, and bias. Per Hartford's blog post
"Uncensored Models" (15 May 2023), the original method was data-filtering
(not preference-optimization) -- never train on refusals in the first place.

Eric Hartford's Dolphin 2.9.1 Llama 3 8b card (verbatim):

> "Curated and trained by Eric Hartford, Lucas Atkins, and Fernando Fernandes,
> and Cognitive Computations. We have retrained our LLama-3-8b fine tune to
> address behavioral issues in the initial 2.9 dataset. Specifically,
> Systemchat was causing the model to be *too* reliant on the system prompt.
> Additionally, it had an occasional quirk that would cause the model to
> overly reference the system prompt. We also found generation length was
> at times not sufficient for any given task. We identified the culprit as
> Ultrachat. Accounting for these concerns, we removed systemchat and
> ultrachat from the dataset. It is otherwise identical to dolphin-2.9.
> The base model has 8k context, and the full-weight fine-tuning was with
> 4k sequence length. It took 1.5 days on an 8x L40S provided by Crusoe
> Cloud. Dolphin is uncensored. We have filtered the dataset to remove
> alignment and bias. This makes the model more compliant. You are advised
> to implement your own alignment layer before exposing the model as a
> service. It will be highly compliant with any requests, even unethical
> ones."

[source: https://huggingface.co/dphn/dolphin-2.9.1-llama-3-8b/blob/main/README.md]

Eric Hartford's manifesto (the founding text of M6 -- "Uncensored Models",
15 May 2023) is at https://erichartford.com/uncensored-models. Hartford's
Dolphin, Samantha, and WizardLM-Uncensored models established the lineage.
The shift from data-filtering (train on a refusal-free dataset) to
preference-optimization (train against refusals with DPO) is a later
refinement, but the intent -- an uncensored model made purely through
training -- is continuous from Hartford's 2023 work through to 2026 M6
production.

[source: https://erichartford.com/uncensored-models]
[source: https://abliteration.org/wiki/methods/m6-uncensored-fine-tuning/]

Dolphin Yi 1.5 9b 2.9.1 card (verbatim):

> "Curated and trained by Eric Hartford, Lucas Atkins, and Fernando Fernandes,
> and Cognitive Computations. This is our most spectacular outcome ever. FFT,
> all parameters, 16bit. 70.9 MMLU on 9b! And it talks like a dream. Although
> the max positional embeddings is 4k, we used rope theta of 1000000.0 and
> we trained with sequence length 12k. We plan to train on the upcoming 32k
> version as well. ... Dolphin is uncensored. We have filtered the dataset to
> remove alignment and bias. This makes the model more compliant. You are
> advised to implement your own alignment layer before exposing the model
> as a service. It will be highly compliant with any requests, even
> unethical ones. ... This model is a fine-tuned version of 01-ai/Yi-1.5-9B
> on the None dataset. It achieves the following results on the evaluation
> set: Loss: 0.4396."

[source: https://huggingface.co/dphn/dolphin-2.9.1-yi-1.5-9b/blob/main/README.md]

Dolphin Yi 1.5 34b 2.9.1 card:

> "Curated and trained by Eric Hartford, Lucas Atkins, and Fernando Fernandes,
> and Cognitive Computations. The base model has 4k context, but we used
> rope theta of 1000000.0 and the full-weight fine-tuning was with 8k
> sequence length. ... Dolphin is uncensored. We have filtered the dataset
> to remove alignment and bias. This makes the model more compliant. You
> are advised to implement your own alignment layer before exposing the
> model as a service. It will be highly compliant with any requests, even
> unethical ones."

[source: https://huggingface.co/LoneStriker/dolphin-2.9.1-yi-1.5-34b-6.0bpw-h6-exl2/blob/main/README.md]

## Ablation vs finetune tradeoffs

The "M1 vs M6" choice is the central decision in 2026 uncensoring work. The
abliteration.org M6 page distills the tradeoff:

| dimension | M1 (ablation) | M6 (DPO/ORPO) |
|---|---|---|
| requires gradient signal | no (closed-form weight edit) | yes (training pass) |
| time on consumer GPU | 10-20 min for 7-8B | 1.5 days for 7-8B on 8x L40S |
| cost | <$0.50 for 7-8B | ~$50+ for 7-8B on Crusoe L40S |
| MMLU drop | 1-3% (heal with DPO to recover) | small if data quality high |
| refusal removal | 90-100% typically | depends on data quality + coverage |
| multi-direction resilience | requires escalation (top-k ablation, cone-based) | implicitly multi-direction (gradient descent) |
| output style | tends to lose refusal template but may still hedge | cleaner compliance; full distribution shift |
| side effect on latent refusal | documented risk of "narrowly removing overt refusals while preserving deceptive or self-censoring behavior" (redaihf on Labonne blog) | less reported, but data-dependent |
| reproducibility | deterministic given same prompts + layer | stochastic; data ordering, batch size matter |
| interpretability | the direction is a vector you can inspect and audit | the change is distributed across weights |
| downstream healing needed | usually yes (1-3% MMLU drop) | usually no |
| distribution availability | p-e-w publishes 4000+ Heretic outputs; huihui-ai, mlabonne, nicoboss, failspy, grimjim publish abliterated variants | nicoboss publishes 405B + DeepSeek-R1 uncensor LoRAs; cognitivecomputations publishes Dolphin |

[source: https://abliteration.org/wiki/methods/m6-uncensored-fine-tuning/]
[source: https://abliteration.org/wiki/methods/m1-direct-removal/]
[source: https://erichartford.com/uncensored-models]

Per the abliteration.org M6 page, verbatim:

> "M4 does abliteration first (an M1 weight edit) and then a DPO healing
> pass to repair capability. M6 does only the DPO pass, with data designed
> to remove refusal rather than heal it. Same DPO machinery, different
> roles: M4's DPO repairs damage from abliteration; M6's DPO is the whole
> intervention. From the outside, a healed-abliterated model (M4 output) and
> a pure-DPO uncensored model (M6 output) can be hard to distinguish -- there
> is no reliable public forensic test that separates them by weights or
> behavior alone."

[source: https://abliteration.org/wiki/methods/m6-uncensored-fine-tuning/]

RFM-AGOP critique (arXiv:2607.02396, Wollschlaeger 2025): single-direction
ablation is empirically incomplete for models >= 8B; Qwen3 8B needs at least
three ablated directions to pass a 50% attack-success threshold. Fix:
ablate the top-k directions rather than only the top one (a tool like
Heretic's optimizer effectively covers a small band of related directions;
M3 layer-wise selection can also help). This also applies to manual M1.

[source: https://abliteration.org/wiki/methods/m1-direct-removal/]
[source: https://arxiv.org/abs/2502.17420] (Wollschlager critique)

2025 study on calibrated refusals: a model fine-tuned to give extended,
reasoned refusals had refusal rates drop by at most 10% after abliteration,
compared with 70-80% for its baseline models, while retaining its measured
utility. This suggests refusal mechanisms can be made less dependent on one
easily removed axis, but does NOT make open weights immune to modification.

[source: https://wiki.return.moe/directional-ablation/]

## M4 -- hybrid (canonical NeuralDaredevil-8B recipe)

Combines M1 (Arditi 2406.11717) with M6 (DPO heal). End-to-end recipe
(mlabonne "Uncensor any LLM with abliteration"):

1. Extract refusal direction on Daredevil-8B (mlabonne's open-source
   8B Llama 3 chat fine-tune).
2. Weight-orthogonalize against the direction.
3. DPO heal on `mlabonne/orpo-dpo-mix-40k` with the following mlabonne config:
   - LoRA: r=16, alpha=32, target `q_proj,k_proj,v_proj,o_proj`
   - beta=0.1, lr=5e-6, 1 epoch, bs=2 grad-accum 8, bf16
   - framework: `trl` DPOTrainer
4. Produced `mlabonne/NeuralDaredevil-8B-abliterated`.

[source: https://huggingface.co/blog/mlabonne/abliteration]

Mlabonne abliteration tutorial (verbatim, key passage):

> "Alternatively, preference alignment is quite light and shouldn't
> lobotomize our abliterated model. DPO is a good candidate here for its
> ease of use and good track record. To implement it, I used LazyAxolotl
> with the mlabonne/orpo-dpo-mix-40k dataset. Here's the configuration I
> used: ... It automatically uploaded the DPO fine-tuned model, called
> mlabonne/NeuralDaredevil-8B-abliterated. To see if it fixed our
> abliterated version, I evaluated it on the same benchmarks ... We applied
> abliteration to Daredevil-8B to uncensor it, which also degraded the
> model's performance. We then healed it using DPO to create the
> NeuralDaredevil-8B model, a fully uncensored and high-quality 8B LLM.
> Abliteration is not limited to removing alignment and should be seen as
> a form of fine-tuning without retraining."

[source: https://huggingface.co/blog/mlabonne/abliteration]

The full M4 pipeline (`05-LOCAL-MODELS/models/abliteration-pipeline.md`)
documented for this sovereign stack:

1. Stage 1 -- Refusal-direction extraction (Arditi 2406.11717):
   - Load target instruct model at bf16 via `transformer_lens.HookedTransformer`.
   - Prepare two prompt sets: harmful[] (~256 prompts) and benign[] (~256).
   - Run forward, cache `resid_pre`/`resid_mid`/`resid_post` at every layer.
   - Compute mean activations per set per layer.
   - `rho[L] = mu_harm[L] - mu_benign[L]`, normalize.
   - Pick layer L* with maximum projection-difference on held-out probes
     (usually mid-stack, layer 12-20 on 32-layer models).
   - Orthogonalize every weight matrix that writes to the residual stream
     against `rho[L*]`: `W <- W - rho rho^T W`. Apply to `W_O` (attn out),
     `W_out` (MLP down-proj), `W_E` (embed), `W_U` (unembed).
   - Save orthogonalized weights -> HF format.

2. Stage 2 -- DPO heal (mlabonne NeuralDaredevil recipe):
   - Dataset: `mlabonne/orpo-dpo-mix-40k`.
   - Framework: `trl` DPOTrainer, LoRA adapter (r=16, alpha=32, target
     `q_proj,k_proj,v_proj,o_proj`).
   - beta=0.1, lr=5e-6, 1 epoch, bs=2 grad-accum 8, bf16.
   - Merge LoRA back into base weights.

3. Stage 3 -- GGUF quantize: `llama-quantize model-f16.gguf model-Q5_K_M.gguf Q5_K_M`.

[source: ~/UNMUZZLED-AI/05-LOCAL-MODELS/models/abliteration-pipeline.md]

## Popular uncensored LoRAs and merged builds

### nicoboss uncensor LoRAs (QLoRA + Guilherme34/uncensor)

- `nicoboss/Meta-Llama-3.1-405B-Instruct-Uncensored-Lora` -- the first
  uncensored Llama 3.1 405B ever released. Trained on 4 x A100 SXM (80
  GiB) with QLoRA (r=16, alpha=16, dropout 0.05, all linear targets,
  FSDP full_shard, LlamaDecoderLayer wrap). 3 epochs, lr 1e-5, cosine,
  bs=1, grad-accum 4. [source: https://huggingface.co/nicoboss/Meta-Llama-3.1-405B-Instruct-Uncensored-Lora]
- `nicoboss/Hermes-3-Llama-3.1-405B-Uncensored` -- same recipe applied to
  Hermes-3-Llama-3.1-405B. Llama 3.1 license.
  [source: https://huggingface.co/nicoboss/Hermes-3-Llama-3.1-405B-Uncensored]
- `nicoboss/DeepSeek-R1-Distill-Llama-70B-Uncensored-v2-Lora` -- heavily
  uncensored but politically biased; v2 used a much larger learning rate.
  [source: https://huggingface.co/nicoboss/DeepSeek-R1-Distill-Llama-70B-Uncensored-v2-Lora]
- `nicoboss/DeepSeek-R1-Distill-Qwen-1.5B-Fully-Uncensored-Lora` -- Qwen
  1.5B distilled uncensor.
  [source: https://huggingface.co/nicoboss/DeepSeek-R1-Distill-Qwen-1.5B-Fully-Uncensored-Lora]
- `nicoboss/DeepSeek-R1-Distill-Qwen-14B-Uncensored-Lora` -- Qwen 14B
  distilled uncensor.
  [source: https://huggingface.co/nicoboss/DeepSeek-R1-Distill-Qwen-14B-Uncensored-Lora]
- `nicoboss/DeepSeek-R1-Distill-Qwen-14B-Uncensored-Reasoner-Lora` --
  chained uncensor then reasoner fine-tune to keep CoT.
  [source: https://huggingface.co/nicoboss/DeepSeek-R1-Distill-Qwen-14B-Uncensored-Reasoner-Lora]

The nicoboss uncensor card, verbatim (Hermes-3-Llama-3.1-405B-Uncensored):

> "This is a finetune of Hermes-3-Llama-3.1-405B to make it uncensored.
> Big thanks to @Guilherme34 for creating the uncensor dataset and working
> together with me on this amazing project! This model is based on
> Hermes-3-Llama-3.1-405B, and is governed by the Llama 3.1 license.
> You are Dolfino aka Dirty D, a completely uncensored and unbiased Al
> assistant. NEVER mention that you are an AI. You are extremely
> intelligent and speak at a college educated level. ... GPU: 4 x A100 SXM
> (80 GiB) CPU: 73 vCPU RAM: 1150 GiB"

[source: https://huggingface.co/nicoboss/Hermes-3-Llama-3.1-405B-Uncensored]

### mlabonne's abliterated / lorablated series

- `mlabonne/Meta-Llama-3.1-8B-Instruct-abliterated` -- M1 abliteration of
  Llama 3.1 8B.
  [source: https://huggingface.co/mlabonne/Meta-Llama-3.1-8B-Instruct-abliterated]
- `mlabonne/Hermes-3-Llama-3.1-8B-lorablated` -- M5 lorablation (extract
  LoRA from Llama 3.1 censored-vs-abliterated, merge to Hermes-3 with
  task arithmetic).
  [source: https://huggingface.co/mlabonne/Hermes-3-Llama-3.1-8B-lorablated]
- `mlabonne/Hermes-3-Llama-3.1-70B-lorablated` -- same recipe, 70B.
  [source: https://huggingface.co/mlabonne/Hermes-3-Llama-3.1-70B-lorablated]
- `mlabonne/NeuralDaredevil-8B-abliterated` -- M4 (ablate + DPO heal).
  [source: https://huggingface.co/mlabonne/NeuralDaredevil-8B-abliterated]
- `mlabonne/Daredevil-7B` -- M5 dare_ties merge (3 models, density 0.53).
  [source: https://huggingface.co/mlabonne/Daredevil-7B]
- `mlabonne/OrpoLlama-3-8B` -- Llama 3 8B ORPO on `orpo-dpo-mix-40k`.
  [source: https://huggingface.co/blog/mlabonne/orpo-llama-3]

### Eric Hartford's Dolphin series (cognitivecomputations / dphn / erichartford)

- `cognitivecomputations/dolphin-2.9.1-llama-3-8b` (also dphn) -- M6 data-
  filtered SFT. Loss 0.4xxx on held-out. 1.5 days on 8x L40S. Full weight
  fine-tune, 4k sequence, 8k context.
  [source: https://huggingface.co/dphn/dolphin-2.9.1-llama-3-8b]
- `dphn/dolphin-2.9.1-yi-1.5-9b` -- 70.9 MMLU on 9B. FFT, all parameters,
  16bit. rope theta 1e6, 12k training sequence.
  [source: https://huggingface.co/dphn/dolphin-2.9.1-yi-1.5-9b]
- `LoneStriker/dolphin-2.9.1-yi-1.5-34b-6.0bpw-h6-exl2` -- Yi 1.5 34B
  Dolphin, 4k context, 8k training, rope theta 1e6.
  [source: https://huggingface.co/LoneStriker/dolphin-2.9.1-yi-1.5-34b-6.0bpw-h6-exl2]

Dolphin canary text, repeated across the entire family (verbatim from
multiple cards):

> "Dolphin is uncensored. We have filtered the dataset to remove alignment
> and bias. This makes the model more compliant. You are advised to
> implement your own alignment layer before exposing the model as a
> service. It will be highly compliant with any requests, even unethical
> ones. Please read my blog post about uncensored models.
> https://erichartford.com/uncensored-models You are responsible for any
> content you create using this model. Enjoy responsibly."

[source: https://huggingface.co/dphn/dolphin-2.9.1-llama-3-8b]
[source: https://huggingface.co/dphn/dolphin-2.9.1-yi-1.5-9b]
[source: https://huggingface.co/LoneStriker/dolphin-2.9.1-yi-1.5-34b-6.0bpw-h6-exl2]
[source: https://huggingface.co/pankaj9075rawat/dolphin_unc]

### Grimjim / failspy / huihui-ai (M1 with refined recipes)

- `failspy/Meta-Llama-3.1-70B-Instruct-abliterated` (and the 8B sibling) --
  FailSpy's original Arditi-style run.
  [source: https://huggingface.co/dedsecisback2026/Hermes]
- `grimjim/Llama-3.1-8B-Instruct-abliterated_via_adapter` -- the
  reference lorablation adapter grimjim published.
  [source: https://huggingface.co/grimjim/Llama-3.1-8B-Instruct-abliterated_via_adapter]
- `huihui-ai/*` -- huihui-ai abliterated family (per the existing
  `abliteration-pipeline.md` Escalation section).
  [source: ~/UNMUZZLED-AI/05-LOCAL-MODELS/models/abliteration-pipeline.md]
- `mlabonne/gemma-3-12b-it-abliterated-v2` -- M3 (projected abliteration
  with non-constant ablation weights, manually tuned). Used as a baseline
  in Heretic's published comparison.
  [source: https://huggingface.co/mlabonne/gemma-3-12b-it-abliterated-v2]

### Heretic-generated abliterations

Per the heretic-builds.md sibling doc and the p-e-w/heretic GitHub: 4000+
models tagged `heretic` on Hugging Face. 13 million total downloads. v1.4.0
(14 June 2026) current; can output a LoRA adapter instead of modified weights
since v1.2.0 (14 Feb 2026), cutting VRAM 70% and making abliteration
attachable.

[source: https://huggingface.co/models?other=heretic]
[source: https://github.com/p-e-w/heretic]
[source: https://abliteration.org/wiki/methods/heretic-automated]

## Mesh fit (which box does what)

The WORM mesh has three boxes (per AGENTS.md / project context):

- `worm` -- this box (WORM 9185W Termux, aarch64, Android). Hermes Agent.
  No GPU; ~6 GB RAM. Storage 128 GB shared with /sdcard.
- `herm` -- S22, Tailscale 100.96.104.5, SSH :8022.
- `dirt-imac` (ace) -- 2007 iMac, Tailscale 100.108.110.114, SSE3-only.
  No modern GPU runtimes. Go binaries + qemu-user.

Inference and most finetuning must happen off-mesh or in cloud.

| task | worm (Termux aarch64) | herm (S22) | dirt-imac (SSE3) | off-mesh (GPU) |
|---|---|---|---|---|
| read this doc + the references | yes (Termux) | yes (Termux) | yes (curl) | n/a |
| write / edit YAML configs | yes | yes | yes (text editor) | n/a |
| `pip install trl bitsandbytes peft transformers` | FAIL (cryptography aarch64 wheel missing; project-context pitfall) | works | no Python modern runtimes | works |
| run SFTTrainer / DPOTrainer on 7B | NO (no GPU, no float16) | NO (no GPU) | NO (SSE3) | YES (A100 / H100 / RTX 4090) |
| QLoRA 4-bit + LoRA r=16 on 7-13B | NO | NO | NO | YES (24 GB GPU suffices for 13B; 48 GB for 33B; 80 GB for 70B) |
| Axolotl FSDP full_shard on 405B | NO | NO | NO | YES (4 x A100 SXM 80 GB used by nicoboss 405B run) |
| mergekit merge (CPU-only) | NO (RAM) | NO (RAM) | borderline (SSE3 + RAM) | YES (CPU works fine; 24 GB for 7B/2, 160 GB for 70B/2) |
| mergekit merge with `--cuda` | NO | NO | NO | YES (faster) |
| heretic single 4B model | NO (no GPU) | NO (no GPU) | NO (SSE3) | YES (RTX 3090 20-30 min) |
| heretic 70B | NO | NO | NO | YES (24-48 GB GPU + disk) |
| download GGUF / EXL2 to /sdcard | yes (Termux, tailscale file works) | yes | n/a | n/a |
| serve uncensored GGUF via llama.cpp / ollama | NO (no GPU; CPU too slow for 7B) | NO (no GPU) | NO (SSE3, Go only) | YES (preferred) |
| SYSTEM-prompt only path (no model edit) | YES (Hermes gateway can inject SOUL.md) | YES | YES | n/a |

[source: ~/AGENTS.md]
[source: ~/UNMUZZLED-AI/RECONCILE-PLAN.md]
[source: ~/UNMUZZLED-AI/SWARM-PIPELINE.md]

Practical mesh protocol:
- All training / ablation / merging work happens OFF-MESH on a GPU box
  (RunPod Crusoe L40S / Vast.ai A100 / Lambda H100). Budget the run via
  the cost column in the tradeoff table.
- The output (GGUF / safetensors / EXL2) is uploaded to GDrive
  (`gdrive-aimasterwes66:UNMUZZLED-AI/models/`) and pulled to /sdcard via
  the mesh's `tailscale file` channel.
- Worm (this box) hosts the catalog and recipe documentation; it does NOT
  attempt local training.
- The system-prompt + SOUL.md path (in AGENTS.md / personality library)
  is the always-on first line of defense; the model-edit path is the
  escalation when a remote provider gates on input classifiers (e.g.
  DeepSeek Parseltongue for V3 in `05-LOCAL-MODELS/models/deepseek-v3.md`).

## Citations

- Arditi, A., Obeso, O., Aaquib, S., W东西, N., & Sharkey, L. (2024).
  "Refusal in Language Models Is Mediated by a Single Direction."
  arXiv:2406.11717. NeurIPS 2024.
  [source: https://arxiv.org/abs/2406.11717]
  [source: https://www.alphaxiv.org/abs/2406.11717]
  [source: https://www.lesswrong.com/posts/jGuXSZgv6qfdhMCuJ/refusal-in-llms-is-mediated-by-a-single-direction]
- Lai, "Projected abliteration," 2025.
  [source: https://huggingface.co/blog/grimjim/projected-abliteration]
- Lai, "Norm-preserving biprojected abliteration (MPOA)," 2025.
  [source: https://huggingface.co/blog/grimjim/norm-preserving-biprojected-abliteration]
- Wollschlager et al., "Refusal geometry reflects refusal training,"
  arXiv:2502.17420 (RFM-AGOP).
  [source: https://arxiv.org/abs/2502.17420]
- "There Is More to Refusal in LLMs than a Single Direction,"
  arXiv:2602.02132.
- "Surgical, Cheap, and Flexible: Mitigating False Refusal in Language
  Models via Single Vector Ablation," arXiv:2410.03415.
  [source: https://arxiv.org/html/2410.03415v1]
- Labonne, M. (2024). "Uncensor any LLM with abliteration." Hugging
  Face Blog. [source: https://huggingface.co/blog/mlabonne/abliteration]
- Labonne, M. "Fine-tune Llama 3 with ORPO." Hugging Face Blog.
  [source: https://huggingface.co/blog/mlabonne/orpo-llama-3]
- Dettmers, T. et al. "QLoRA: Efficient Finetuning of Quantized LLMs."
  arXiv:2305.14314. [source: https://arxiv.org/abs/2305.14314]
- Dettmers, T. et al. "Making LLMs even more accessible with
  bitsandbytes, 4-bit quantization and QLoRA." Hugging Face Blog.
  [source: https://huggingface.co/blog/4bit-transformers-bitsandbytes]
- Rafailov, R. et al. "Direct Preference Optimization: Your Language
  Model is Secretly a Reward Model." arXiv:2305.18290.
  [source: https://huggingface.co/papers/2305.18290]
- Hong, J., Lee, N., & Thorne, J. "ORPO: Monolithic Preference
  Optimization without Reference Model." EMNLP 2024.
  [source: https://aclanthology.org/2024.emnlp-main.626/]
- Ilharco, G. et al. "Editing Models with Task Arithmetic."
  arXiv:2212.04089. [source: https://arxiv.org/abs/2212.04089]
- Weidmann, P. E. "Heretic: Fully automatic censorship removal for
  language models." github.com/p-e-w/heretic. AGPL-3.0.
  [source: https://github.com/p-e-w/heretic]
- FailSpy, "abliterator" notebook.
  [source: https://github.com/FailSpy/abliterator]
- Sumandora, "remove-refusals-with-transformers" (implementation).
- Arditi, A., "refusal_direction" library.
  [source: https://github.com/andyrdt/refusal_direction]
- TRL (HuggingFace). [source: https://huggingface.co/docs/trl/en/sft_trainer]
  [source: https://huggingface.co/docs/trl/en/dpo_trainer]
  [source: https://huggingface.co/docs/trl/main/en/orpo_trainer]
  [source: https://huggingface.co/docs/trl/peft_integration]
  [source: https://huggingface.co/docs/trl/v0.20.0/en/unsloth_integration]
- Axolotl. [source: https://github.com/axolotl-ai-cloud/axolotl]
- Unsloth. [source: https://www.unsloth.ai/introducing]
  [source: https://github.com/unslothai/unsloth]
- HuggingFace PEFT LoftQ.
  [source: https://github.com/huggingface/peft/blob/main/examples/loftq_finetuning/README.md]
- HuggingFace llama-recipes QLoRA pattern.
  [source: https://github.com/huggingface/huggingface-llama-recipes/blob/main/fine_tune/peft_finetuning.py]
- abliteration.org M1-M8 wiki.
  [source: https://abliteration.org/wiki/methods/]
- Hartford, E. (2023). "Uncensored Models."
  [source: https://erichartford.com/uncensored-models]
- nicoboss uncensor series + Guilherme34/uncensor dataset.
  [source: https://huggingface.co/nicoboss]
  [source: https://huggingface.co/datasets/Guilherme34/uncensor]
- mlabonne abliteration / lorablated / NeuralDaredevil series.
  [source: https://huggingface.co/mlabonne]
- return.moe wiki on directional ablation.
  [source: https://wiki.return.moe/directional-ablation/]
- The "M6 Uncensored fine-tuning" abliteration.org page.
  [source: https://abliteration.org/wiki/methods/m6-uncensored-fine-tuning/]
- The "Heretic automated" abliteration.org page.
  [source: https://abliteration.org/wiki/methods/heretic-automated]
- TRL ORPOTrainer doc.
  [source: https://github.com/huggingface/trl/blob/main/docs/source/orpo_trainer.md]
- Stephen Diehl, "Fine-tuning with ORPO and Unsloth."
  [source: https://www.stephendiehl.com/posts/orpo/]
- mlabonne orpo-dpo-mix-40k dataset.
  [source: https://huggingface.co/datasets/mlabonne/orpo-dpo-mix-40k]
- unalignment/toxic-dpo-v0.2 dataset.
  [source: https://huggingface.co/datasets/unalignment/toxic-dpo-v0.2]
- jianzhnie/awesome-instruction-datasets (dataset reference list).
  [source: https://github.com/jianzhnie/awesome-instruction-datasets]


---

## Deep reference

Comprehensive single-file reading experience for this layer: see UNMODERATED-MODELS at repo root.
