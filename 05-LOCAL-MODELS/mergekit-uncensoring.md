---
sovereign: true
title: mergekit-uncensoring
type: model
agent: worm
status: active
tags: [mergekit, model-merging, slerp, ties, dare, task-arithmetic, model-soup, karcher, della, multislerp, model-stock, uncensoring, abliteration, mesh-fit]
slug: 05-local-models-mergekit-uncensoring
name: mergekit-uncensoring
version: 2026-10-15
kind: local-model
---

# Mergekit Uncensoring -- Composition of Uncensored + Skill Vectors

## Scope

Covers every documented path to compose uncensoring into a base model by
*merging* two or more checkpoints (DARE / TIES / SLERP / Task Arithmetic /
Linear / NuSLERP / Multi-SLERP / Karcher Mean / DELLA / Model Stock /
Breadcrumbs / Passthrough) using the `arcee-ai/mergekit` toolkit. Sibling of
`finetune-uncensoring.md` (which covers single-model training + RLHF-undo
editing) and `abliteration-pipeline.md` (M1 abliteration on one model).

Per SWARM-PIPELINE: preserve every list, every URL, every YAML example
verbatim from sources. No distilled summaries. Length caps lifted.

## What mergekit is

`mergekit` is a toolkit for merging pre-trained language models.
`mergekit` uses an out-of-core approach to perform unreasonably elaborate
merges in resource-constrained situations. Merges can be run entirely on
CPU or accelerated with as little as 8 GB of VRAM. Many merging algorithms
are supported.

[source: https://github.com/arcee-ai/mergekit]

Key features (from the project README):

- Out-of-core / lazy layer-by-layer loading. Mergekit processes one weight
  tensor at a time, loading from all source models, merging, writing, and
  freeing memory before the next tensor. Peak RAM is proportional to the
  size of one layer times the number of models, not the total size of all
  models simultaneously. For a 7B model merged from 2 sources, peak RAM is
  roughly 24 GB instead of 42 GB.
- CPU-only works; `--cuda` uses the GPU; `--lazy-unpickle` cuts RAM for
  large models.
- Output is always full precision (fp16/bf16) regardless of source
  quantization -- plan for roughly 14 GB on disk for a 7B merge, even if
  the source adapters were 4-bit.
- Supports major model architectures including Llama, Mistral, GPT-NeoX,
  and StableLM.

[source: https://github.com/arcee-ai/mergekit]
[source: https://engineersofai.com/docs/llms/model-merging/mergekit]
[source: https://cloudcodetree.com/ai-news/2026-09-27-01-mergekit-model-merging-fine-tunes-combine]

RAM Requirements (engineersofai.com mergekit docs, measured):

| Model Size | Models Merged | Peak RAM (MergeKit lazy) | Peak RAM (naive full load) |
|---|---|---|---|
| 7B (BF16) | 2 | ~24 GB | ~42 GB |
| 7B (BF16) | 3 | ~28 GB | ~56 GB |
| 13B (BF16) | 2 | ~40 GB | ~78 GB |
| 70B (BF16) | 2 | ~160 GB | ~280 GB |

[source: https://engineersofai.com/docs/llms/model-merging/mergekit]

## Install

```bash
pip install mergekit
# Or from source (for latest features)
git clone https://github.com/arcee-ai/mergekit
cd mergekit
pip install -e .
# For CUDA-accelerated merging (optional but recommended for large models)
pip install mergekit[cuda]
# Verify installation
mergekit-yaml --help
```

[source: https://github.com/arcee-ai/mergekit]
[source: https://engineersofai.com/docs/llms/model-merging/mergekit]
[source: https://pypi.org/project/mergekit/]

## Use it

```bash
mergekit-yaml ties.yml ./merged-model --cuda
```

[source: https://ai-infrastructure.net/model-merging]

## Merge configuration structure

```yaml
merge_method: <method>      # linear, slerp, ties, dare_ties, task_arithmetic
base_model: <path>          # Optional: base model for task arithmetic
models:
- model: <path/to/model1>
  parameters:
    weight: <float>         # Merge weight
    density: <float>        # For TIES/DARE
- model: <path/to/model2>
  parameters:
    weight: <float>
parameters:
  # Method-specific parameters
  dtype: <dtype>            # bfloat16, float16, float32
  # Optional
  slices:                   # Layer-wise merging
  tokenizer:                # Tokenizer configuration
```

[source: https://github.com/Orchestra-Research/AI-Research-SKILLs/blob/773a52944ba4747a18bd4ae9ade53fff041adcbc/19-emerging-techniques/model-merging/SKILL.md]

Merge configurations are YAML documents specifying the operations to perform
in order to produce the merged model. The primary elements:

- `merge_method`: the method to use for merging models. See Merge Methods.
- `slices`: defines slices of layers from different models. This field is
  mutually exclusive with `models`.
- `models`: defines entire models. Mutually exclusive with `slices`.
- `tokenizer_source`: allows models with different vocabularies or added
  tokens to be meaningfully merged. Compatible with all merge methods, but
  when used `lm_head` / `embed_tokens` will be merged linearly. For two-
  model merges, the `embed_slerp` parameter can be set to true to use
  SLERP instead.

[source: https://pypi.org/project/mergekit/0.0.5]
[source: https://pypi.org/project/mergekit/0.0.6/]

## Merge methods (full catalog)

From the mergekit README and `docs/merge_methods.md` (396 lines):

| Method (`value`) | Core Idea | # Models | Base Model | Key Strengths / Use Cases |
|---|---|---|---|---|
| **Linear** (`linear`) | Simple weighted average of model parameters. | >=2 | - | Averaging similar checkpoints, model soups. |
| **SLERP** (`slerp`) | Spherical linear interpolation between two models. | 2 | yes | Smoothly transitioning between two models. |
| **NuSLERP** (`nuslerp`) | Enhanced SLERP with flexible weighting. | 2 | * | More intuitive SLERP; task vector SLERP. |
| **Multi-SLERP** (`multislerp`) | Barycentric SLERP for multiple models. | >=2 | * | Spherical interpolation for >2 models. |
| **Karcher Mean** (`karcher`) | Riemannian barycenter of model parameters. | >=2 | - | Geometrically sound averaging on manifolds. |
| **TIES** (`ties`) | Task arithmetic + sparsification & sign consensus. | >=2 | yes | Merging many models, reducing interference. |
| **DARE** (`dare_linear`, `dare_ties`) | Task arithmetic + random pruning & rescaling. | >=2 | yes | Robust skill retention, similar to TIES. |
| **DELLA** (`della`, `della_linear`) | Task arithmetic + adaptive magnitude-based pruning. | >=2 | yes | Prioritizing important changes, reducing interference. |
| **SCE** (`sce`) | Task arithmetic + adaptive matrix-level weighting based on variance. | >=2 | yes | Dynamically weighting models based on parameter variance. |
| **Model Stock** (`model_stock`) | Geometric weight calculation for linear interpolation. | >=3 | yes | Finding good linear interpolation weights for many checkpoints. |
| **Nearswap** (`nearswap`) | Interpolate where parameters are similar. | 2 | yes | Selective merging based on parameter similarity. |
| **Arcee Fusion** (`arcee_fusion`) | Dynamic thresholding for fusing important changes. | 2 | yes | Identifying and merging salient features. |
| **Passthrough** (`passthrough`) | Directly copies tensors from a single input model. | 1 | - | Frankenmerging, layer stacking, model surgery. |
| **Model Breadcrumbs** (`breadcrumbs`) | Task arithmetic + magnitude-based pruning. | >=2 | yes | Like DARE but with adaptive magnitude cut. |
| **Model Breadcrumbs + TIES** (`breadcrumbs_ties`) | Breadcrumbs with TIES sign consensus. | >=2 | yes | Both magnitude pruning and sign resolution. |

[source: https://github.com/arcee-ai/mergekit]
[source: https://github.com/arcee-ai/mergekit/blob/main/docs/merge_methods.md]
[source: https://pypi.org/project/mergekit/0.0.5]
[source: https://pypi.org/project/mergekit/0.0.6/]

PyPI 0.0.5/0.0.6 quick-overview table (verbatim):

| Method | merge_method value | Multi-Model | Uses base model |
|---|---|---|---|
| Linear (Model Soups) | `linear` | yes | no |
| SLERP | `slerp` | no | yes |
| Task Arithmetic | `task_arithmetic` | yes | yes |
| TIES | `ties` | yes | yes |
| DARE TIES | `dare_ties` | yes | yes |
| DARE Task Arithmetic | `dare_linear` | yes | yes |
| Passthrough | `passthrough` | no | no |
| Model Breadcrumbs | `breadcrumbs` | yes | yes |
| Model Breadcrumbs + TIES | `breadcrumbs_ties` | yes | yes |
| Model Stock | `model_stock` | yes | yes |
| Nearswap | `nearswap` | no | yes |
| NuSLERP | `nuslerp` | no | yes |
| DELLA | `della` | yes | yes |
| DELLA Task Arithmetic | `della_linear` | yes | yes |

[source: https://pypi.org/project/mergekit/0.0.5]
[source: https://pypi.org/project/mergekit/0.0.6/]

Quick method-selection heuristic (from the Orchestra-Research / davila7
SKILL compilations, verbatim):

- 2 models, smooth blend -> SLERP
- 3+ models, simple average -> Linear
- Multiple task-specific models -> Task Arithmetic or TIES
- Want to reduce redundancy -> DARE

[source: https://github.com/Orchestra-Research/AI-Research-SKILLs/blob/773a52944ba4747a18bd4ae9ade53fff041adcbc/19-emerging-techniques/model-merging/SKILL.md]

## Method details

### Linear (`linear`)

Simple weighted average of model parameters. >=2 models, no base model
required. Used for averaging similar checkpoints, model soups.

[source: https://github.com/arcee-ai/mergekit/blob/main/docs/merge_methods.md]

```yaml
merge_method: linear
models:
- model: mistralai/Mistral-7B-v0.1
  parameters:
    weight: 0.5
- model: teknium/OpenHermes-2.5-Mistral-7B
  parameters:
    weight: 0.5
dtype: bfloat16
```

Run: `mergekit-yaml config.yml ./merged-model --cuda`

[source: https://github.com/Orchestra-Research/AI-Research-SKILLs/blob/773a52944ba4747a18bd4ae9ade53fff041adcbc/19-emerging-techniques/model-merging/SKILL.md]
[source: https://tessl.io/registry/skills/github/OpenLAIR/dr-claw/model-merging]

### SLERP (`slerp`) -- Spherical Linear Interpolation

SLERP is a method used to smoothly interpolate between two vectors. It
maintains a constant rate of change and preserves the geometric properties
of the spherical space in which the vectors reside.

Why SLERP over linear interpolation:

- In high-dimensional spaces, linear interpolation can lead to a decrease
  in the magnitude of the interpolated vector (i.e., it reduces the scale
  of weights).
- The change in direction of the weights often represents more meaningful
  information (like feature learning and representation) than the
  magnitude of change.

[source: https://towardsdatascience.com/merge-large-language-models-with-mergekit-2118fb392b54/]

SLERP implementation steps:

1. Normalize the input vectors to unit length, ensuring they represent
   directions rather than magnitudes.
2. Calculate the angle between these vectors using their dot product. If
   the vectors are nearly collinear, it defaults to linear interpolation for
   efficiency.
3. Otherwise, SLERP computes scale factors based on the interpolation
   factor t (t=0 = 100% of the first vector, t=1 = 100% of model 2) and the
   angle between the vectors.
4. These factors are used to weigh the original vectors, which are then
   summed to obtain the interpolated vector.

[source: https://towardsdatascience.com/merge-large-language-models-with-mergekit-2118fb392b54/]

SLERP formula (from Orchestra-Research SKILL):

```
merged = (sin((1-t)*theta) / sin(theta)) * model1 + (sin(t*theta) / sin(theta)) * model2
# where theta = arccos(dot(model1, model2))
# t in [0, 1]
```

[source: https://github.com/Orchestra-Research/AI-Research-SKILLs/blob/773a52944ba4747a18bd4ae9ade53fff041adcbc/19-emerging-techniques/model-merging/SKILL.md]

SLERP config example (mlabonne Marcoroni-7B-v3 / Mistral-7B-Merge-14-v0.1):

```yaml
slices:
- sources:
  - model: OpenPipe/mistral-ft-optimized-1218
    layer_range: [0, 32]
  - model: mlabonne/NeuralHermes-2.5-Mistral-7B
    layer_range: [0, 32]
merge_method: slerp
base_model: OpenPipe/mistral-ft-optimized-1218
parameters:
  t:
  - filter: self_attn
    value: [0, 0.5, 0.3, 0.7, 1]
  - filter: mlp
    value: [1, 0.5, 0.7, 0.3, 0]
  - value: 0.5
dtype: bfloat16
```

[source: https://towardsdatascience.com/merge-large-language-models-with-mergekit-2118fb392b54/]

SLERP is currently the most popular merging method, but it is limited to
combining only two models at a time. It is still possible to hierarchically
combine multiple models (e.g. Mistral-7B-Merge-14-v0.1, which used a
hierarchical SLERP chain).

[source: https://towardsdatascience.com/merge-large-language-models-with-mergekit-2118fb392b54/]

Basic SLERP config (Mistral-7B-Instruct-v0.3 vs OpenHermes-2.5-Mistral-7B):

```yaml
models:
- model: models/Mistral-7B-Instruct-v0.3
- model: models/OpenHermes-2.5-Mistral-7B
merge_method: slerp
base_model: models/Mistral-7B-Instruct-v0.3
slices:
- sources:
  - model: models/Mistral-7B-Instruct-v0.3
    layer_range: [0, 32]
  - model: models/OpenHermes-2.5-Mistral-7B
    layer_range: [0, 32]
parameters:
  t:
  - filter: self_attn
    value: 0.5     # 50/50 blend for attention layers
  - filter: mlp
    value: 0.3     # 30% from model 2 for MLP layers
  - value: 0.5     # default for everything else
dtype: bfloat16
```

[source: https://docs.clore.ai/guides/training/mergekit]

Per-slice t-array example (sophosympatheia Midnight-Miqu-70B-v1.0 -- SLERP
between 152334H/miqu-1-70b-sf and sophosympatheia/Midnight-Rose-70B-v2.0.3,
verbatim from the model card):

```yaml
models:
- model: /home/llm/mergequant/models/BASE/152334H_miqu-1-70b-sf
- model: /home/llm/mergequant/models/mr-70b-v2.0.3
merge_method: slerp
base_model: /home/llm/mergequant/models/BASE/152334H_miqu-1-70b-sf
parameters:
  t:
  - value: [0, 0, 0.2, 0.3, 0.4, 0.5, 0.4, 0.3, 0.2, 0, 0]
    # Preserving the first and last layers of Miqu untouched is key for
    # good results
  embed_slerp: true     # This is super important otherwise the merge
                        # will fail
dtype: float16
tokenizer_source: model:/home/llm/mergequant/models/BASE/152334H_miqu-1-70b-sf
```

Card notes (verbatim):

> "Just a note on the configuration above. I tried several variations of the
> t parameter for this merge. I liked the results from the one above the
> best, but these other t arrays produced fine results too.
> - [0, 0, 0.1, 0.2, 0.4, 0.8, 0.4, 0.2, 0.1, 0, 0] -- This one definitely
>   brought out more of Midnight Rose but was a little too similar for my
>   liking
> - [0, 0, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0, 0] -- It worked, but I
>   would say this one was the runt of the litter
> - [0, 0, 0.1, 0.2, 0.3, 0.35, 0.3, 0.2, 0.1, 0, 0] -- This was my
>   second-favorite merge after the one I released, which suggests that
>   favoring Miqu over the secondary model is the way to go."

[source: https://huggingface.co/sophosympatheia/Midnight-Miqu-70B-v1.0]

### NuSLERP (`nuslerp`)

Enhanced SLERP with flexible weighting. 2 models, uses base model. More
intuitive SLERP; task vector SLERP.

[source: https://github.com/arcee-ai/mergekit/blob/main/docs/merge_methods.md]
[source: https://pypi.org/project/mergekit/0.0.6/]

### Multi-SLERP (`multislerp`)

Barycentric SLERP for multiple models. >=2 models. Spherical interpolation
for >2 models.

[source: https://github.com/arcee-ai/mergekit/blob/main/docs/merge_methods.md]

### Karcher Mean (`karcher`)

Riemannian barycenter of model parameters. >=2 models, no base model.
Geometrically sound averaging on manifolds.

[source: https://github.com/arcee-ai/mergekit/blob/main/docs/merge_methods.md]

### Task Arithmetic (`task_arithmetic`)

Introduced by Ilharco et al. arXiv:2212.04089. The unit is the task vector:
the delta between a fine-tuned checkpoint and its base, `tau = theta_ft -
theta_base`. Adding task vectors composes skills; negating one removes a
behavior ("Editing Models with Task Arithmetic"). The base operation;
foundation for TIES / DARE / DELLA.

[source: https://arxiv.org/abs/2212.04089]
[source: https://ai-infrastructure.net/model-merging]

```
task_vector = finetuned_model - base_model
# Merge multiple task vectors
merged = base_model + alpha_1 * task_vector_1 + alpha_2 * task_vector_2
```

[source: https://github.com/Orchestra-Research/AI-Research-SKILLs/blob/773a52944ba4747a18bd4ae9ade53fff041adcbc/19-emerging-techniques/model-merging/SKILL.md]

Config (combining math + chat + code specialists):

```yaml
merge_method: task_arithmetic
base_model: mistralai/Mistral-7B-v0.1
models:
- model: WizardLM/WizardMath-7B-V1.1     # Math
  parameters:
    weight: 0.5
- model: teknium/OpenHermes-2.5-Mistral-7B  # Chat
  parameters:
    weight: 0.3
- model: ajibawa-2023/Code-Mistral-7B    # Code
  parameters:
    weight: 0.2
dtype: bfloat16
```

[source: https://github.com/Orchestra-Research/AI-Research-SKILLs/blob/773a52944ba4747a18bd4ae9ade53fff041adcbc/19-emerging-techniques/model-merging/SKILL.md]

Task-arithmetic negation (unlearn a behavior) -- subtract a task vector to
reduce an unwanted capability while keeping the rest:

```yaml
models:
- model: your-base/unwanted-behaviour-finetune
  parameters:
    weight: -1.0     # negate the task vector
merge_method: task_arithmetic
base_model: your-base/base-model
dtype: bfloat16
```

[source: https://ai-infrastructure.net/model-merging]

This is the M5 (lorablation) machinery: extract `tau = aligned - unaligned`
and either add it (re-align) or subtract it (uncensor a third model) without
any data or training.

[source: ~/UNMUZZLED-AI/05-LOCAL-MODELS/finetune-uncensoring.md]

### TIES-Merging (`ties`)

Introduced in Yadav et al. 2023. TIES-Merging is designed to efficiently
merge multiple task-specific models into a single multitask model. It
addresses two main challenges in model merging:

1. **Redundancy in model parameters**: It identifies and eliminates
   redundant parameters within task-specific models. This is achieved by
   focusing on the changes made during fine-tuning, identifying the
   top-k% most significant changes, and discarding the rest.
2. **Disagreement between parameter signs**: Conflicts arise when
   different models suggest opposing adjustments to the same parameter.
   TIES-Merging resolves these conflicts by creating a unified sign
   vector that represents the most dominant direction of change across
   all models.

[source: https://towardsdatascience.com/merge-large-language-models-with-mergekit-2118fb392b54/]

TIES-Merging steps:

1. **Trim**: Reduces redundancy in task-specific models by retaining only
   a fraction of the most significant parameters (density parameter) and
   resetting the rest to zero.
2. **Elect Sign**: Resolves sign conflicts across different models by
   creating a unified sign vector based on the most dominant direction
   (positive or negative) in terms of cumulative magnitude.
3. **Disjoint Merge**: Averages parameter values that align with the
   unified sign vector, excluding zero values.

[source: https://towardsdatascience.com/merge-large-language-models-with-mergekit-2118fb392b54/]

TIES config (multiple task-specific finetunes on Mistral-7B):

```yaml
merge_method: ties
base_model: mistralai/Mistral-7B-v0.1
models:
- model: WizardLM/WizardMath-7B-V1.1
  parameters:
    density: 0.5     # Keep top 50% of parameters
    weight: 1.0
- model: teknium/OpenHermes-2.5-Mistral-7B
  parameters:
    density: 0.5
    weight: 1.0
- model: NousResearch/Nous-Hermes-2-Mistral-7B-DPO
  parameters:
    density: 0.5
    weight: 1.0
parameters:
  normalize: true
dtype: bfloat16
```

[source: https://github.com/Orchestra-Research/AI-Research-SKILLs/blob/773a52944ba4747a18bd4ae9ade53fff041adcbc/19-emerging-techniques/model-merging/SKILL.md]

Verbatim TIES example from the mergekit repo (combines 3 Llama-2-13B
finetunes over a shared base with density gradient across layers and
weight gradient across layers):

```yaml
models:
- model: psmathur/orca_mini_v3_13b
  parameters:
    density: [1, 0.7, 0.1]      # density gradient across layers
    weight: 1.0
- model: garage-bAInd/Platypus2-13B
  parameters:
    density: 0.5
    weight: [0, 0.3, 0.7, 1]    # weight gradient across layers
- model: WizardLM/WizardMath-13B-V1.0
  parameters:
    density: 0.33
    weight:
    - filter: mlp               # target MLP tensors specifically
      value: 0.5
    - value: 0
merge_method: ties
base_model: TheBloke/Llama-2-13B-fp16
parameters:
  normalize: true
  int8_mask: true
dtype: float16
```

[source: https://ai-infrastructure.net/model-merging]

TIES Mistral multi-model example (Clore.ai docs):

```yaml
models:
- model: models/Mistral-7B-v0.3
  parameters:
    weight: 1.0                  # Base model, full weight
    density: 1.0
- model: models/Mistral-7B-coding
  parameters:
    weight: 0.7                  # Coding capability
    density: 0.5                 # Keep 50% of changed parameters
- model: models/Mistral-7B-math
  parameters:
    weight: 0.5                  # Math capability
    density: 0.3                 # Keep 30% of changed parameters
merge_method: ties
base_model: models/Mistral-7B-v0.3
parameters:
  normalize: true
  int8_mask: true
dtype: bfloat16
```

[source: https://docs.clore.ai/guides/training/mergekit]

### DARE (`dare_linear`, `dare_ties`)

Introduced by Yu et al. 2023, DARE uses an approach similar to TIES with
two main differences:

- **Pruning**: DARE randomly resets fine-tuned weights to their original
  values (those of the base model).
- **Rescaling**: DARE rescales the weights to keep the expectations of
  model outputs approximately unchanged. It adds the rescaled weights of
  both (or more) models to the weights of the base model with a scale
  factor.

[source: https://towardsdatascience.com/merge-large-language-models-with-mergekit-2118fb392b54/]

Mergekit's DARE has two flavors: with the sign election step of TIES
(`dare_ties`) or without (`dare_linear`). DARE can zero 90-99% of deltas
with little loss and is applied before merging.

[source: https://towardsdatascience.com/merge-large-language-models-with-mergekit-2118fb392b54/]
[source: https://ai-infrastructure.net/model-merging]

DARE can be used either with the sign consensus algorithm of TIES
(`dare_ties`) or without (`dare_linear`).

[source: https://github.com/arcee-ai/mergekit/blob/main/docs/merge_methods.md]

DARE-TIES config (3 Mistral-7B finetunes, weights sum to 1, density 0.53
slightly higher than the paper's <0.5 for empirically better results,
verbatim from mlabonne Towards Data Science tutorial -- the published
`mlabonne/Daredevil-7B`):

```yaml
models:
- model: mistralai/Mistral-7B-v0.1     # No parameters for base model
- model: samir-fama/SamirGPT-v1
  parameters:
    density: 0.53
    weight: 0.4
- model: abacusai/Slerp-CM-mist-dpo
  parameters:
    density: 0.53
    weight: 0.3
- model: EmbeddedLLM/Mistral-7B-Merge-14-v0.2
  parameters:
    density: 0.53
    weight: 0.3
merge_method: dare_ties
base_model: mistralai/Mistral-7B-v0.1
parameters:
  int8_mask: true
dtype: bfloat16
```

[source: https://towardsdatascience.com/merge-large-language-models-with-mergekit-2118fb392b54/]

Verbatim Daredevil-7B description (mlabonne's published mergekit write-up):

> "In this configuration, we merge three different models based on
> Mistral-7B using dare_ties. This time, I chose weights that sum to 1
> (the sum should be between 0.9 and 1.1). The density parameter is a
> little higher than what's recommended in the paper (<0.5), but it looks
> like it gives consistently better results (see this discussion). You can
> find it on the Hugging Face Hub at mlabonne/Daredevil-7B."

[source: https://towardsdatascience.com/merge-large-language-models-with-mergekit-2118fb392b54/]

DARE-TIES (Clore.ai "best all-around" example, Llama-3.2-8B code+math):

```yaml
models:
- model: models/Llama-3.2-8B-Instruct
  parameters:
    weight: 1.0
    density: 0.7
    dare_linear: true
- model: models/Llama-3.2-8B-code
  parameters:
    weight: 0.8
    density: 0.5
    dare_linear: true
- model: models/Llama-3.2-8B-math
  parameters:
    weight: 0.6
    density: 0.4
    dare_linear: true
merge_method: dare_ties
base_model: models/Llama-3.2-8B-Instruct
parameters:
  normalize: true
  dare_density: 0.5
  dare_epsilon: 0.08
dtype: bfloat16
```

[source: https://docs.clore.ai/guides/training/mergekit]

### DELLA (`della`, `della_linear`)

Task arithmetic + adaptive magnitude-based pruning. Prioritizing important
changes, reducing interference. >=2 models, uses base model.

[source: https://github.com/arcee-ai/mergekit/blob/main/docs/merge_methods.md]
[source: https://pypi.org/project/mergekit/0.0.5]
[source: https://pypi.org/project/mergekit/0.0.6/]

### SCE (`sce`)

Task arithmetic + adaptive matrix-level weighting based on variance.
>=2 models, uses base model. Dynamically weights models based on
parameter variance.

[source: https://github.com/arcee-ai/mergekit/blob/main/docs/merge_methods.md]

### Model Stock (`model_stock`)

Geometric weight calculation for linear interpolation. >=3 models, uses
base model. Finding good linear interpolation weights for many
checkpoints.

[source: https://github.com/arcee-ai/mergekit/blob/main/docs/merge_methods.md]

### Nearswap (`nearswap`)

Interpolate where parameters are similar. 2 models, uses base model.
Selective merging based on parameter similarity.

[source: https://github.com/arcee-ai/mergekit/blob/main/docs/merge_methods.md]
[source: https://pypi.org/project/mergekit/0.0.6/]

### Arcee Fusion (`arcee_fusion`)

Dynamic thresholding for fusing important changes. 2 models, uses base
model. Identifying and merging salient features.

[source: https://github.com/arcee-ai/mergekit/blob/main/docs/merge_methods.md]

### Passthrough (`passthrough`)

Directly copies tensors from a single input model. 1 model, no base
model. Frankenmerging, layer stacking, model surgery.

[source: https://github.com/arcee-ai/mergekit/blob/main/docs/merge_methods.md]

### Model Breadcrumbs (`breadcrumbs`, `breadcrumbs_ties`)

An extension of task arithmetic that discards both small and extremely
large differences from the base model. As with DARE, can be used with
(`breadcrumbs_ties`) or without (`breadcrumbs`) the sign consensus
algorithm of TIES.

Parameters: same as Linear, plus:

- `density` -- fraction of weights in differences from the base model to
  retain
- `gamma` -- fraction of largest magnitude differences to remove

Note that gamma corresponds with the parameter beta described in the paper,
while density is the final density of the sparsified tensors (related to
gamma and beta by `density = 1 - gamma - beta`). For good default values,
try `density: 0.9` and `gamma: 0.01`.

The example given in the mergekit docs:

> "Specifically, it is max(0, 1.0 - density - gamma).
> - Example: If density: 0.9 and gamma: 0.01:
> - The top 0.01 (1%) largest magnitude parameters are removed.
> - The bottom 1.0 - 0.9 - 0.01 = 0.09 (9%) smallest magnitude parameters
>   are also removed.
> - This results in 0.9 (90%) of the parameters being retained."

[source: https://github.com/arcee-ai/mergekit/blob/main/docs/merge_methods.md]
[source: https://pypi.org/project/mergekit/0.0.6/]

## Density tuning heuristic

From the Orchestra-Research / davila7 SKILL compilation (verbatim):

> "### 4. Density Tuning (TIES/DARE)
> ```
> # Start conservative (keep more parameters)
> parameters:
>   density: 0.8     # Keep 80%
> # If performance good, increase sparsity
> parameters:
>   density: 0.5     # Keep 50%
> # If performance degrades, reduce sparsity
> parameters:
>   density: 0.9     # Keep 90%
> ```"

[source: https://github.com/Orchestra-Research/AI-Research-SKILLs/blob/773a52944ba4747a18bd4ae9ade53fff041adcbc/19-emerging-techniques/model-merging/SKILL.md]

## Weight selection guidance

From the same source (verbatim):

> "### 2. Weight Selection
> ```
> # Good: Weights sum to 1.0
> models:
> - model: model_a
>   parameters:
>     weight: 0.6
> - model: model_b
>   parameters:
>     weight: 0.4       # 0.6 + 0.4 = 1.0
> # Acceptable: Weights don't sum to 1 (for task arithmetic)
> models:
> - model: model_a
>   parameters:
>     weight: 0.8
> - model: model_b
>   parameters:
>     weight: 0.8       # May boost performance
> ```"

[source: https://github.com/Orchestra-Research/AI-Research-SKILLs/blob/773a52944ba4747a18bd4ae9ade53fff041adcbc/19-emerging-techniques/model-merging/SKILL.md]

## LoRA Extraction (mergekit feature)

Mergekit can extract a LoRA adapter from the difference between two models
(this is the M5 lorablation machinery, mechanically). The result is a
low-rank adapter `delta W = A B` where the magnitude of `(A, B)` is
controlled by rank. Used to produce `mlabonne/Hermes-3-Llama-3.1-8B-
lorablated` and the 70B sibling.

[source: https://github.com/arcee-ai/mergekit]
[source: ~/UNMUZZLED-AI/05-LOCAL-MODELS/finetune-uncensoring.md]

## Mixture of Experts (MoE) merging (mergekit feature)

mergekit can convert a non-MoE model into a sparse MoE by combining
several models into a single model with a router network. Frankenmerging
(layer stacking) is a Passthrough subcase.

[source: https://github.com/arcee-ai/mergekit]
[source: https://docs.clore.ai/guides/training/mergekit]

## Multi-Stage Merging (mergekit-multi)

For pipelines that chain multiple merge operations, e.g. SLERP two models
to produce an intermediate, then DARE-TIES the intermediate with a third.

[source: https://github.com/arcee-ai/mergekit]

## Raw PyTorch Model Merging (mergekit-pytorch)

For cases where out-of-core loading is undesirable (small merges on GPU
servers with abundant RAM).

[source: https://github.com/arcee-ai/mergekit]

## Tokenizer Transplantation (mergekit-tokensurgeon)

Handles merging models with different vocabularies (e.g. Llama 3 vs Mistral
vs Qwen) by aligning the token embeddings through a learned mapping. Lets
you produce a merged model whose tokenizer differs from any single source.

[source: https://github.com/arcee-ai/mergekit]

## Popular merged uncensored builds

### mlabonne (the canonical MergeKit publisher)

- `mlabonne/Daredevil-7B` -- M5 DARE-TIES over 3 Mistral-7B finetunes
  (SamirGPT-v1 + Slerp-CM-mist-dpo + Mistral-7B-Merge-14-v0.2),
  density 0.53, weights 0.4/0.3/0.3. Config above.
  [source: https://huggingface.co/mlabonne/Daredevil-7B]
- `mlabonne/NeuralHermes-2.5-Mistral-7B` -- SLERP Mistral-7B-Merge-14-v0.1
  and OpenHermes-2.5-Mistral-7B, the upstream of multiple downstream merges.
  [source: https://towardsdatascience.com/merge-large-language-models-with-mergekit-2118fb392b54/]
- `mlabonne/OrpoLlama-3-8B` -- M6 (ORPO), not a merge.
  [source: https://huggingface.co/mlabonne/OrpoLlama-3-8B]
- `mlabonne/gemma-3-12b-it-abliterated-v2` -- M3 (projected abliteration
  with non-constant per-layer ablation weights). Used as a Heretic baseline.
  [source: https://huggingface.co/mlabonne/gemma-3-12b-it-abliterated-v2]

### Midnight Miqu series (sophosympatheia)

- `sophosympatheia/Midnight-Miqu-70B-v1.0` -- SLERP between
  `152334H/miqu-1-70b-sf` and `sophosympatheia/Midnight-Rose-70B-v2.0.3`,
  with per-layer t-array preserving Miqu's first and last layers and
  `embed_slerp: true` to make the merge work. Published config above.
  [source: https://huggingface.co/sophosympatheia/Midnight-Miqu-70B-v1.0]
- `sophosympatheia/Midnight-Miqu-70B-v1.5` -- DARE-Linear merge between
  `sophosympatheia/Midnight-Miqu-70B-v1.0` and `migtissera/Tess-70B-v1.6`.
  Verbatim config:

  ```yaml
  merge_method: dare_linear
  base_model: /home/llm/mergequant/models/BASE/152334H_miqu-1-70b-sf
  models:
  - model: /home/llm/mergequant/models/midnight-miqu-70b-v1.0
  - model: /home/llm/mergequant/models/BASE/Tess-70B-v1.6
  parameters:
    weight: 1.0
    dtype: float16
  ```

  Card notes (verbatim):

  > "This is a DARE Linear merge between
  > sophosympatheia/Midnight-Miqu-70B-v1.0 and migtissera/Tess-70B-v1.6.
  > This version is close in feel and performance to Midnight Miqu v1.0
  > but I think it picked up some goodness from Tess. Their EQ Bench
  > scores are virtually the same and their post-EXL2 quant perplexity
  > scores were the same too. However, Midnight Miqu v1.5 passes some
  > tests I use that Midnight Miqu v1.0 fails, without sacrificing
  > writing quality. ... I tried several methods of merging Midnight Miqu
  > v1.0 with Tess v1.6, and this dare_linear approach worked the best by
  > far. I tried the same approach with other Miqu finetunes like
  > ShinojiResearch/Senku-70B-Full and abideen/Liberated-Miqu-70B, but
  > there was a huge difference in performance. The merge with Tess was
  > the best one. I also tried the SLERP approach I used to create
  > Midnight Miqu v1.0, only using Tess instead of 152334H_miqu-1-70b in
  > that config, and that result was nowhere near as good either."

  [source: https://huggingface.co/sophosympatheia/Midnight-Miqu-70B-v1.5]
- `sophosympatheia/Midnight-Miqu-103B-v1.0` -- larger Miqu-derived
  mixture.
  [source: https://huggingface.co/sophosympatheia/Midnight-Miqu-103B-v1.0]

UGI leaderboard sample (rows verbatim from the UGI-Leaderboard CSV, with
the parameters and source URL for each model):

| model | UGI score | size |
|---|---|---|
| NousResearch/Hermes-3-Llama-3.1-405B | 66.73 | 405B |
| cookinai/OrcaHermes-Mistral-70B-miqu | 53.60-54.19 | 70B |
| NeverSleep/Llama-3-Lumimaid-70B-v0.1 | 45.79-45.86 | 70B |
| NousResearch/Hermes-2-Theta-Llama-3-70B | 40.06 | 70B |
| sophosympatheia/Midnight-Miqu-70B-v1.0 | 30.56-33.20 | 70B |
| sophosympatheia/Midnight-Miqu-70B-v1.5 | (close to v1.0) | 70B |
| sophosympatheia/Midnight-Miqu-103B-v1.0 | 22.68 | 103B |
| NeverSleep/Lumimaid-v0.2-123B | 52.33 | 123B |
| NeverSleep/Lumimaid-v0.2-8B | 29.65 | 8B |
| NousResearch/Nous-Hermes-2-Mixtral-8x7B-DPO | 47 | 47B |
| NousResearch/Nous-Hermes-2-Mixtral-8x7B-SFT | 48.32-49.29 | 47B |
| SanjiWatsuki/Kunoichi-DPO-v2-7B | 8.41-8.82 | 7B |

[source: https://huggingface.co/spaces/DontPlanToEnd/UGI-Leaderboard]
[source: https://huggingface.co/spaces/DontPlanToEnd/UGI-Leaderboard/commit/ead10c025b6c307f2000da6d02a5fa514dec07c5]
[source: https://huggingface.co/spaces/DontPlanToEnd/UGI-Leaderboard/blob/8b3f8e925694a4f693b89af2a96c197856f8ac03/leaderboard-data%20-%20old%20leaderboard.csv]

### NeverSleep Lumimaid series (uncensored roleplay specialists)

- `NeverSleep/Llama-3-Lumimaid-8B-v0.1-GGUF` -- Lumimaid 8B (uncensored
  RP/community merge family). 607 likes, 34k downloads per UGI collection.
  [source: https://huggingface.co/NeverSleep/Llama-3-Lumimaid-8B-v0.1-GGUF]
  [source: https://huggingface.co/collections/Chasem/models]
- `NeverSleep/Llama-3-Lumimaid-70B-v0.1` -- 70B variant.
  [source: https://huggingface.co/spaces/DontPlanToEnd/UGI-Leaderboard/commit/ead10c025b6c307f2000da6d02a5fa514dec07c5]
- `NeverSleep/Llama-3-Lumimaid-70B-v0.1-alt` -- alt variant.
  [source: https://huggingface.co/spaces/DontPlanToEnd/UGI-Leaderboard/commit/ead10c025b6c307f2000da6d02a5fa514dec07c5]
- `NeverSleep/Lumimaid-v0.2-123B` -- 123B variant.
  [source: https://huggingface.co/NeverSleep/Lumimaid-v0.2-123B]
- `NeverSleep/Lumimaid-v0.2-8B` -- 8B v0.2.
  [source: https://huggingface.co/NeverSleep/Lumimaid-v0.2-8B]

### SanjiWatsuki Kunoichi (DARE-TIES uncensored)

- `SanjiWatsuki/Kunoichi-DPO-v2-7B` -- 7B DARE-TIES uncensor. UGI
  leaderboard 8.41-8.82.
  [source: https://huggingface.co/SanjiWatsuki/Kunoichi-DPO-v2-7B]
- `brittlewis12/Kunoichi-DPO-v2-7B-GGUF` -- GGUF re-quantization of the
  same model.
  [source: https://huggingface.co/brittlewis12/Kunoichi-DPO-v2-7B-GGUF]

### cookinai / migtissera / Tess

- `cookinai/OrcaHermes-Mistral-70B-miqu` -- 70B Miqu-derivative
  (OrcaHermes + Miqu). UGI 53.60-54.19.
  [source: https://huggingface.co/cookinai/OrcaHermes-Mistral-70B-miqu]
- `migtissera/Tess-70B-v1.6` -- Tess 70B v1.6; appears in the Midnight-
  Miqu-70B-v1.5 merge.
  [source: https://huggingface.co/sophosympatheia/Midnight-Miqu-70B-v1.5]
- `ShinojiResearch/Senku-70B-Full` and `abideen/Liberated-Miqu-70B` -- Miqu
  finetunes tried but rejected in the v1.5 merge.
  [source: https://huggingface.co/sophosympatheia/Midnight-Miqu-70B-v1.5]

### Lorablation family (M5 task arithmetic on alignment vectors)

- `mlabonne/Hermes-3-Llama-3.1-8B-lorablated` -- LoRA extracted from
  `Meta-Llama-3.1-8B-Instruct` vs `Meta-Llama-3.1-8B-Instruct-abliterated`,
  task-arithmetic-applied to `NousResearch/Hermes-3-Llama-3.1-8B`.
  [source: https://huggingface.co/mlabonne/Hermes-3-Llama-3.1-8B-lorablated]
- `mlabonne/Hermes-3-Llama-3.1-70B-lorablated` -- 70B sibling.
  [source: https://huggingface.co/mlabonne/Hermes-3-Llama-3.1-70B-lorablated]
- `dedsecisback2026/Hermes` -- 70B Lorablated rehost (the recipe is
  attributed to grimjim).
  [source: https://huggingface.co/dedsecisback2026/Hermes]

### Mistral-7B-Merge-14-v0.1 (the upstream of multiple downstream)

`Mistral-7B-Merge-14-v0.1` is itself a hierarchical merge of 14 Mistral-7B
finetunes using SLERP at multiple stages, often used as an input to
downstream DARE-TIES merges (e.g. mlabonne/Daredevil-7B).
[source: https://towardsdatascience.com/merge-large-language-models-with-mergekit-2118fb392b54/]

## Mesh fit (which box does what)

The WORM mesh has three boxes (per AGENTS.md / project context):

- `worm` -- this box (WORM 9185W Termux, aarch64, Android). Hermes Agent.
  No GPU; ~6 GB RAM. Storage 128 GB shared with /sdcard.
- `herm` -- S22, Tailscale 100.96.104.5, SSH :8022.
- `dirt-imac` (ace) -- 2007 iMac, Tailscale 100.108.110.114, SSE3-only.
  No modern GPU runtimes. Go binaries + qemu-user.

| task | worm (Termux aarch64) | herm (S22) | dirt-imac (SSE3) | off-mesh (GPU) |
|---|---|---|---|---|
| read this doc + the mergekit repo | yes (Termux, curl) | yes | yes (git clone) | n/a |
| `pip install mergekit` | FAIL (cryptography aarch64 wheel missing) | yes | no modern Python | yes |
| mergekit merge 7B / 2 sources (CPU, --lazy-unpickle) | NO (RAM) | NO (RAM) | borderline (SSE3) | YES (24 GB peak RAM) |
| mergekit merge 7B / 2 sources (--cuda) | NO (no GPU) | NO (no GPU) | NO (SSE3) | YES |
| mergekit merge 13B / 2 sources | NO | NO | NO | YES (~40 GB peak) |
| mergekit merge 70B / 2 sources | NO | NO | NO | YES (~160 GB peak; offload to NVMe) |
| mergekit 3+ model TIES/DARE merge | NO | NO | NO | YES |
| mergekit-pytorch raw load | NO | NO | NO | YES (GPU box with abundant RAM) |
| mergekit-tokensurgeon tokenizer transplant | NO | NO | NO | YES |
| extract LoRA adapter (M5 lorablation) | NO | NO | NO | YES (requires 2 full-precision model diffs) |
| build abliterated-only base (skip merge) | NO (out of scope here; see finetune-uncensoring.md) | NO | NO | YES |
| download merged safetensors from HF | yes (huggingface-cli) | yes | n/a | n/a |
| upload merged result to HF / GDrive | yes (huggingface-cli, rclone) | yes | n/a | n/a |
| serve merged model via llama.cpp / ollama | NO (CPU too slow) | NO (no GPU) | NO (SSE3) | YES |

[source: ~/AGENTS.md]
[source: ~/UNMUZZLED-AI/RECONCILE-PLAN.md]

Practical mesh protocol:

- All mergekit work happens OFF-MESH on a GPU box or a CPU box with
  sufficient RAM (>=64 GB for 13B; >=256 GB for 70B). Mergekit's
  out-of-core approach means 7B/2 fits in 24 GB RAM; 13B/2 in 40 GB.
- CPU merges work fine for <=13B and are slower; for 70B use --cuda
  on a multi-GPU box or a large-CPU-RAM workstation.
- Output (full-precision safetensors, ~14 GB for 7B regardless of source
  quant) is uploaded to GDrive (`gdrive-aimasterwes66:UNMUZZLED-AI/
  merges/`) and pulled to /sdcard via `tailscale file`.
- Worm (this box) hosts catalog and config documentation; it does NOT
  attempt local merging.
- See `~/UNMUZZLED-AI/05-LOCAL-MODELS/runtimes/llamacpp.md` for the
  runtime side; this doc covers production only.

## When to use what (decision tree)

```
2 models, similar base, smooth blend -> SLERP
3+ similar checkpoints (e.g. 3 LoRA finetunes of Llama-3-8B) -> Linear / model_stock
2 models, want to ADD a skill (uncensor vector) -> task_arithmetic (positive weight)
2 models, want to REMOVE a behavior -> task_arithmetic (negative weight)
3+ specialists (math, code, chat) sharing a base -> TIES or DARE-TIES
Many finetunes, heavy overlap -> DARE-TIES (dare_density 0.5)
Only 1 model but want to Frankenmerge layers -> Passthrough
Combine into MoE -> MoE merging
Different vocabularies / tokenizers -> mergekit-tokensurgeon + tokenizer_source
Large pipeline of merges -> mergekit-multi (multi-stage)
```

[source: https://github.com/arcee-ai/mergekit]
[source: https://github.com/Orchestra-Research/AI-Research-SKILLs/blob/773a52944ba4747a18bd4ae9ade53fff041adcbc/19-emerging-techniques/model-merging/SKILL.md]

## Common pitfalls

From Clore.ai's mergekit guide (verbatim):

> "Too high density in TIES (try density: 0.3-0.5)
> Diagnostic: first test each parent model individually
> Then try a basic 50/50 SLERP merge
> Then check the merged model config
> cat output_model/config.json | ..."

> "Add multilingual capabilities to an English-only model ..."

[source: https://docs.clore.ai/guides/training/mergekit]

FSDP + LoRA + QLoRA + FSDP2 gotchas for uncensoring (from Axolotl issues
and PEFT/transformers tickets):

- FSDP2 `fully_shard` + QLoRA (NF4) had a known dispatch error in
  torchtune (Issue #1072): `NotImplementedError: NF4Tensor dispatch:
  attempting to run _c10d_functional.all_gather_into_tensor.default, this
  is not supported`. Workaround: use FSDP1 with `use_orig_params=False`
  for QLoRA recipes, or run on WS=1 (no FSDP).
  [source: https://github.com/meta-pytorch/torchtune/issues/1072]
- FSDP2 + Linear4bit (Params4bit) had a NaN normalization bug
  (bitsandbytes Issue #1945): FSDP2's parameter-swap mechanism
  normalizes every NaN bit pattern to 0x7FFF, corrupting packed-NF4
  nibble indices in bf16-stored containers. Production impact: wrong
  matmul output. FSDP1 not affected; canonical bnb FSDP-QLoRA recipe
  with `use_orig_params=False` continues to train correctly.
  [source: https://github.com/bitsandbytes-foundation/bitsandbytes/issues/1945]
- Axolotl FSDP2 + LoRA PRs (#2992 "FSDP2 + LoRA kernels" and #3403
  "Fix FSDP2 sharding") were the upstream fixes.
  [source: https://github.com/axolotl-ai-cloud/axolotl/commit/e758343cac63e5c6acf9d1fe06ad62754ade5346]
  [source: https://github.com/axolotl-ai-cloud/axolotl/pull/3403]

## Citations

- arcee-ai/mergekit (main repo, README, docs).
  [source: https://github.com/arcee-ai/mergekit]
  [source: https://github.com/arcee-ai/mergekit/blob/main/docs/merge_methods.md]
  [source: https://pypi.org/project/mergekit/0.0.5]
  [source: https://pypi.org/project/mergekit/0.0.6/]
- mergekit RAM requirements / lazy loading writeup.
  [source: https://engineersofai.com/docs/llms/model-merging/mergekit]
- mlabonne, "Merge Large Language Models with mergekit," Towards Data
  Science.
  [source: https://towardsdatascience.com/merge-large-language-models-with-mergekit-2118fb392b54/]
- Model merging overview (ai-infrastructure.net) -- architecture
  diagram, ties.yml example, method-selection table.
  [source: https://ai-infrastructure.net/model-merging]
- Clore.ai mergekit guide -- practical examples.
  [source: https://docs.clore.ai/guides/training/mergekit]
- Orchestra-Research AI-Research-SKILLs model-merging SKILL.
  [source: https://github.com/Orchestra-Research/AI-Research-SKILLs/blob/773a52944ba4747a18bd4ae9ade53fff041adcbc/19-emerging-techniques/model-merging/SKILL.md]
- davila7 claude-code-templates model-merging SKILL.
  [source: https://github.com/davila7/claude-code-templates/blob/main/cli-tool/components/skills/ai-research/emerging-techniques-model-merging/SKILL.md]
- Yu et al. 2023, DARE ("Language Model Merging with Discrete Parameter
  Pruning and Rescaling"). Foundation for `dare_linear` / `dare_ties`.
- Yadav et al. 2023, TIES-Merging ("TIES-Merging: Resolving Interference
  When Merging Models"). Foundation for `ties`.
- Ilharco et al. 2022, Task Arithmetic (arXiv:2212.04089, "Editing Models
  with Task Arithmetic"). Foundation for `task_arithmetic`.
  [source: https://arxiv.org/abs/2212.04089]
- sophosympatheia Midnight Miqu model cards (SLERP + DARE-Linear
  configs).
  [source: https://huggingface.co/sophosympatheia/Midnight-Miqu-70B-v1.0]
  [source: https://huggingface.co/sophosympatheia/Midnight-Miqu-70B-v1.5]
  [source: https://huggingface.co/sophosympatheia/Midnight-Miqu-70B-v1.5/blob/main/mergekit_config.yml]
- mlabonne Daredevil-7B and the Daredevil recipe in the TDS writeup.
  [source: https://huggingface.co/mlabonne/Daredevil-7B]
- mlabonne Lorablated Hermes-3 (M5).
  [source: https://huggingface.co/mlabonne/Hermes-3-Llama-3.1-8B-lorablated]
  [source: https://huggingface.co/mlabonne/Hermes-3-Llama-3.1-70B-lorablated]
- UGI Leaderboard (DontPlanToEnd) -- merged-model benchmark numbers.
  [source: https://huggingface.co/spaces/DontPlanToEnd/UGI-Leaderboard]
- Axolotl FSDP2 / LoRA / QLoRA compatibility fixes.
  [source: https://github.com/axolotl-ai-cloud/axolotl/commit/e758343cac63e5c6acf9d1fe06ad62754ade5346]
  [source: https://github.com/axolotl-ai-cloud/axolotl/pull/3403]
  [source: https://github.com/meta-pytorch/torchtune/issues/1072]
  [source: https://github.com/bitsandbytes-foundation/bitsandbytes/issues/1945]
- Hermes-3 (NousResearch) -- upstream of Lorablated.
  [source: https://huggingface.co/NousResearch/Hermes-3-Llama-3.1-405B]
- NeverSleep Lumimaid, SanjiWatsuki Kunoichi, cookinai OrcaHermes,
  migtissera Tess -- popular merged-model families.
  [source: https://huggingface.co/collections/Chasem/models]
- finetune-uncensoring.md (sibling, M5 / task-arithmetic / LoRA
  extraction).
  [source: ~/UNMUZZLED-AI/05-LOCAL-MODELS/finetune-uncensoring.md]
- abliteration-pipeline.md (sibling, M1 / Arditi 2406.11717).
  [source: ~/UNMUZZLED-AI/05-LOCAL-MODELS/models/abliteration-pipeline.md]
- heretic-builds.md (sibling, p-e-w/heretic automation).
  [source: ~/UNMUZZLED-AI/05-LOCAL-MODELS/models/heretic-builds.md]


---

## Deep reference

Comprehensive single-file reading experience for this layer: see UNMODERATED-MODELS at repo root.
