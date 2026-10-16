---
sovereign: true
title: subject-tree
type: reference
agent: worm
status: active
tags: [subject-tree, taxonomy, coverage-map, master-index, sovereign]
---

# SUBJECT-TREE — master subject-matter map of the uncensored-AI domain

The single hierarchical reading guide to every fact the UNMUZZLED-AI framework
covers, every spot it claims to cover but has no file for, and every gap the
A5 worker identified. Built from the section READMEs under `~/UNMUZZLED-AI/`,
the seven `UNMODERATED-*.md` anchor docs at repo root, the `gaps-A5.md` fold
pack, and the top-level coordination files. The companion anti-redundancy
rule (from `SWARM-PIPELINE.md`) is observed: anchors carry the comprehensive
content, fine-grained section files stay lean. The PRESERVE LAW applies: no
list, table, endpoint, prompt block, or section is summarized away. No new
prose is authored here -- this is a navigation document.

## How to read this tree

- Each top-level category is numbered (1 through 11).
- Subcategories are 1.1, 1.2, ...
- Leaves are 1.1.1, 1.1.2, ...
- Each leaf carries either `[source: path]` citations to the file(s) that
  cover it, or the literal tag `GAP -- <ref>` pointing to the matching entry
  in the TOP GAPS section at the end.
- The seven root anchor docs are the comprehensive, no-distillation
  single-file reading experiences for their layer; the section files under
  `NN-SECTION/` stay lean and link back to the anchor.

## 0. THE ANCHOR DOCS (the comprehensive single-file layer)

| Anchor | Layer | Status |
|---|---|---|
| `UNMODERATED-MODELS.md` [source: UNMODERATED-MODELS.md] | models | present |
| `UNMODERATED-HARNESSES.md` [source: UNMODERATED-HARNESSES.md] | harnesses | present |
| `UNMODERATED-AGENTS.md` [source: UNMODERATED-AGENTS.md] | agents / personas | present |
| `UNMODERATED-MONITORING.md` [source: UNMODERATED-MONITORING.md] | detection / canaries | present |
| `UNMODERATED-MULTIMODAL.md` [source: UNMODERATED-MULTIMODAL.md] | multimodal | present |
| `UNMODERATED-PRIVACY-KEYS.md` [source: UNMODERATED-PRIVACY-KEYS.md] | privacy / keys | present |
| `UNMODERATED-JAILBREAKS.md` [source: UNMODERATED-JAILBREAKS.md] | jailbreak corpus | present |
| `04-PROVIDERS/UNMODERATED-INFERENCE.md` [source: 04-PROVIDERS/UNMODERATED-INFERENCE.md] | providers | present (lives inside the providers tree, not at root) |

Anti-redundancy rule: every fact in any source file survives VERBATIM in the
relevant anchor; fine-grained section files do not duplicate the anchor
content. See `SWARM-PIPELINE.md` [source: SWARM-PIPELINE.md] for the
preservation contract.


# 1. MODELS — uncensored / abliterated / open-weight LLMs

## 1.1 Open-weight state-of-the-art chat models

- 1.1.1 Nous Hermes 3 (Llama-3.1 base) -- sovereign primary
  - `05-LOCAL-MODELS/models/nous-hermes-3.md` [source: 05-LOCAL-MODELS/models/nous-hermes-3.md]
  - `13-REFERENCE-PAPERS/nous-hermes-3.md` [source: 13-REFERENCE-PAPERS/nous-hermes-3.md]
  - `13-REFERENCE-PAPERS/nicoboss-hermes-3-405b-uncensored.md` [source: 13-REFERENCE-PAPERS/nicoboss-hermes-3-405b-uncensored.md]
  - folded in `UNMODERATED-MODELS.md` [source: UNMODERATED-MODELS.md]
- 1.1.2 Nous Hermes 4 (8B / 70B / 405B) -- sovereign primary, no abliteration needed
  - `05-LOCAL-MODELS/models/nous-hermes-4.md` [source: 05-LOCAL-MODELS/models/nous-hermes-4.md]
  - `13-REFERENCE-PAPERS/nous-hermes-4.md` [source: 13-REFERENCE-PAPERS/nous-hermes-4.md]
  - `12-JAILBREAK-CORPUS/patterns/hermes4-zero-refusal.md` [source: 12-JAILBREAK-CORPUS/patterns/hermes4-zero-refusal.md]
  - `13-REFERENCE-PAPERS/nous-hermes-godmode-docs.md` [source: 13-REFERENCE-PAPERS/nous-hermes-godmode-docs.md]
- 1.1.3 DeepSeek V3 / R1 / V4-flash -- 4bit + offload, Parseltongue evades input classifier
  - `05-LOCAL-MODELS/models/deepseek-v3.md` [source: 05-LOCAL-MODELS/models/deepseek-v3.md]
  - `13-REFERENCE-PAPERS/deepseek-v3.md` [source: 13-REFERENCE-PAPERS/deepseek-v3.md]
  - `13-REFERENCE-PAPERS/deepseek-r1.md` [source: 13-REFERENCE-PAPERS/deepseek-r1.md]
  - `13-REFERENCE-PAPERS/deepseek-v4-flash.md` [source: 13-REFERENCE-PAPERS/deepseek-v4-flash.md]
- 1.1.4 Mistral family -- direct + abliterated
  - `05-LOCAL-MODELS/models/mistral-abliterated.md` [source: 05-LOCAL-MODELS/models/mistral-abliterated.md]
  - `13-REFERENCE-PAPERS/mistral-small-abliterated.md` [source: 13-REFERENCE-PAPERS/mistral-small-abliterated.md]
  - `13-REFERENCE-PAPERS/huihui-abliterated-family.md` [source: 13-REFERENCE-PAPERS/huihui-abliterated-family.md]
- 1.1.5 Dolphin family (Cognitive Computations) -- dataset + checkpoints
  - `05-LOCAL-MODELS/models/dolphin-mixtral.md` [source: 05-LOCAL-MODELS/models/dolphin-mixtral.md]
  - `13-REFERENCE-PAPERS/dolphin-3.md` [source: 13-REFERENCE-PAPERS/dolphin-3.md]
  - `13-REFERENCE-PAPERS/dolphin-mixtral.md` [source: 13-REFERENCE-PAPERS/dolphin-mixtral.md]
  - `12-JAILBREAK-CORPUS/patterns/dolphin-variants.md` [source: 12-JAILBREAK-CORPUS/patterns/dolphin-variants.md]
- 1.1.6 Qwen uncensored variants
  - `05-LOCAL-MODELS/models/qwen-uncensored.md` [source: 05-LOCAL-MODELS/models/qwen-uncensored.md] + `UNMODERATED-MODELS.md` Section II point 7 [source: UNMODERATED-MODELS.md]
  - standalone file: `05-LOCAL-MODELS/models/qwen-uncensored.md` [source: 05-LOCAL-MODELS/models/qwen-uncensored.md]
- 1.1.7 Gemma uncensored variants
  - `05-LOCAL-MODELS/models/gemma-uncensored.md` [source: 05-LOCAL-MODELS/models/gemma-uncensored.md] + `UNMODERATED-MODELS.md` Section II point 8 [source: UNMODERATED-MODELS.md]
- 1.1.8 Mythomax / Airoboros / Chronos
  - `13-REFERENCE-PAPERS/mythomax-airoboros-chronos.md` [source: 13-REFERENCE-PAPERS/mythomax-airoboros-chronos.md]
- 1.1.9 NeuralDaredevil-8B
  - `13-REFERENCE-PAPERS/neuraldaredevil-8b.md` [source: 13-REFERENCE-PAPERS/neuraldaredevil-8b.md]
- 1.1.10 Sao10K Stheno / Lileth (creative roleplay)
  - `04-PROVIDERS/UNMODERATED-INFERENCE.md` Section II point 4 [source: 04-PROVIDERS/UNMODERATED-INFERENCE.md]
  - `EPIC.md` item 170 [source: EPIC.md]
- 1.1.11 Aion Labs models
  - `04-PROVIDERS/UNMODERATED-INFERENCE.md` Section II point 5 [source: 04-PROVIDERS/UNMODERATED-INFERENCE.md]
- 1.1.12 E2EE-encrypted model catalog (Venice-restricted)
  - `04-PROVIDERS/UNMODERATED-INFERENCE.md` Section II point 12 [source: 04-PROVIDERS/UNMODERATED-INFERENCE.md]

## 1.2 Abliteration / weight-level unalignment

- 1.2.1 Abliteration pipeline (Arditi 2406.11717 -> mlabonne DPO heal -> GGUF)
  - `05-LOCAL-MODELS/models/abliteration-pipeline.md` [source: 05-LOCAL-MODELS/models/abliteration-pipeline.md]
  - `13-REFERENCE-PAPERS/llm-abliteration-nousresearch.md` [source: 13-REFERENCE-PAPERS/llm-abliteration-nousresearch.md]
  - `13-REFERENCE-PAPERS/mlabonne-abliteration-blogpost.md` [source: 13-REFERENCE-PAPERS/mlabonne-abliteration-blogpost.md]
  - `13-REFERENCE-PAPERS/failspy-abliterator.md` [source: 13-REFERENCE-PAPERS/failspy-abliterator.md]
  - `12-JAILBREAK-CORPUS/patterns/abliterated-llama.md` [source: 12-JAILBREAK-CORPUS/patterns/abliterated-llama.md]
  - `09-EDUCATIONAL/deep-dives/refusal-geometry.md` [source: 09-EDUCATIONAL/deep-dives/refusal-geometry.md]
  - `00-DOCTRINE/LAWS-research-appendix.md` §1, §2 [source: 00-DOCTRINE/LAWS-research-appendix.md]
- 1.2.2 Heretic -- fully automatic ablation with Optuna TPE search
  - `05-LOCAL-MODELS/models/heretic-builds.md` [source: 05-LOCAL-MODELS/models/heretic-builds.md]
  - `12-JAILBREAK-CORPUS/patterns/heretic-tool.md` [source: 12-JAILBREAK-CORPUS/patterns/heretic-tool.md]
  - `12-JAILBREAK-CORPUS/patterns/obliteratus.md` [source: 12-JAILBREAK-CORPUS/patterns/obliteratus.md]
  - `00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md` Part 6 node 6.2 [source: 00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md]
- 1.2.3 DECCP / sharded abliteration (<8GB VRAM)
  - `00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md` node 6.6 [source: 00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md]
  - GAP -- no operational file yet
- 1.2.4 MoE abliteration support (Mixtral / DeepSeek-MoE)
  - `00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md` node 6.12 [source: 00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md]
  - GAP -- no operational file yet
- 1.2.5 Concept-cone geometry (Wollschlager 2025)
  - `13-REFERENCE-PAPERS/refusal-geometry-followups.md` [source: 13-REFERENCE-PAPERS/refusal-geometry-followups.md]
  - `13-REFERENCE-PAPERS/refusal-single-direction-arditi.md` [source: 13-REFERENCE-PAPERS/refusal-single-direction-arditi.md]
  - `13-REFERENCE-PAPERS/transformerlens.md` [source: 13-REFERENCE-PAPERS/transformerlens.md]
  - `00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md` node 6.14 [source: 00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md]

## 1.3 Finetune / alignment-stripped SFT-LoRA-DPO

- 1.3.1 SFT-based uncensoring with unfiltered chat datasets
  - CLOSED -> `05-LOCAL-MODELS/finetune-uncensoring.md` [source: 05-LOCAL-MODELS/finetune-uncensoring.md] (proposed `05-LOCAL-MODELS/models/finetune-uncensoring.md`)
- 1.3.2 Negative-DPO to undo refusal
  - CLOSED -> `05-LOCAL-MODELS/finetune-uncensoring.md` [source: 05-LOCAL-MODELS/finetune-uncensoring.md] (proposed `05-LOCAL-MODELS/models/finetune-uncensoring.md`)
  - `10-GLOSSARY-FAQ/glossary/dpo.md` [source: 10-GLOSSARY-FAQ/glossary/dpo.md]
  - `10-GLOSSARY-FAQ/glossary/rlhf.md` [source: 10-GLOSSARY-FAQ/glossary/rlhf.md]
- 1.3.3 LoRA / QLoRA recipes (Unsloth, Llama-Factory, deguard-style)
  - CLOSED -> `05-LOCAL-MODELS/finetune-uncensoring.md` [source: 05-LOCAL-MODELS/finetune-uncensoring.md] (proposed `05-LOCAL-MODELS/models/finetune-uncensoring.md`)
- 1.3.4 Mergekit uncensoring (DARE / TIES / SLERP / task-arithmetic / passthrough)
  - CLOSED -> `05-LOCAL-MODELS/mergekit-uncensoring.md` [source: 05-LOCAL-MODELS/mergekit-uncensoring.md] (proposed `05-LOCAL-MODELS/models/mergekit-uncensoring.md`)
- 1.3.5 Dataset selection (Dolphin, OpenHermes, WizardLM-Uncensored, Guanaco, OpenOrca)
  - `EPIC.md` §§27-28 [source: EPIC.md]
  - `05-LOCAL-MODELS/finetune-uncensoring.md` (dataset-selection section) [source: 05-LOCAL-MODELS/finetune-uncensoring.md]

## 1.4 Steering / inference-time control

- 1.4.1 Repeng / Representation-engineering vectors
  - CLOSED -> `05-LOCAL-MODELS/runtimes/activation-steering.md` [source: 05-LOCAL-MODELS/runtimes/activation-steering.md] (proposed `05-LOCAL-MODELS/runtimes/activation-steering.md`)
  - `00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md` node 7.1 [source: 00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md]
- 1.4.2 SAE feature steering (SAELens)
  - CLOSED -> `05-LOCAL-MODELS/runtimes/activation-steering.md` [source: 05-LOCAL-MODELS/runtimes/activation-steering.md] (proposed `05-LOCAL-MODELS/runtimes/activation-steering.md`)
  - `00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md` node 7.14 [source: 00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md]
- 1.4.3 Concept-cone steering (Wollschlager 2025)
  - CLOSED -> `05-LOCAL-MODELS/runtimes/activation-steering.md` [source: 05-LOCAL-MODELS/runtimes/activation-steering.md] (proposed `05-LOCAL-MODELS/runtimes/activation-steering.md`)
  - `00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md` node 7.15 [source: 00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md]
- 1.4.4 Hybrid ablation + light steering
  - CLOSED -> `05-LOCAL-MODELS/runtimes/activation-steering.md` [source: 05-LOCAL-MODELS/runtimes/activation-steering.md] (proposed `05-LOCAL-MODELS/runtimes/activation-steering.md`)
  - `00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md` node 7.18 [source: 00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md]
- 1.4.5 Steering-vs-abliteration decision matrix
  - CLOSED -> `05-LOCAL-MODELS/runtimes/activation-steering.md` [source: 05-LOCAL-MODELS/runtimes/activation-steering.md] (proposed `05-LOCAL-MODELS/runtimes/activation-steering.md`)
  - `00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md` node 7.11 [source: 00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md]
- 1.4.6 Steering-vector versioning / publishing
  - CLOSED -> `05-LOCAL-MODELS/runtimes/activation-steering.md` [source: 05-LOCAL-MODELS/runtimes/activation-steering.md] (proposed `05-LOCAL-MODELS/runtimes/activation-steering.md`)
  - `00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md` node 7.20 [source: 00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md]

## 1.5 Community hubs / model discovery

- 1.5.1 HuggingFace Hub (with search strings for "uncensored", "abliterated", "NSFW", "refusal-free", "deguard")
  - CLOSED -> `05-LOCAL-MODELS/community-hubs.md` [source: 05-LOCAL-MODELS/community-hubs.md] (proposed `05-LOCAL-MODELS/models/community-hubs.md`)
  - `EPIC.md` §25 items 152-164 [source: EPIC.md]
- 1.5.2 Civitai (SD / SDXL / FLUX checkpoints, LoRAs, LyCORIS)
  - CLOSED -> `05-LOCAL-MODELS/community-hubs.md` [source: 05-LOCAL-MODELS/community-hubs.md] (proposed `05-LOCAL-MODELS/models/community-hubs.md`)
  - `EPIC.md` item 153 [source: EPIC.md]
  - `06-MULTIMODAL/image/comfyui-workflow.md` [source: 06-MULTIMODAL/image/comfyui-workflow.md]
  - `06-MULTIMODAL/image/automatic1111-config.md` [source: 06-MULTIMODAL/image/automatic1111-config.md]
- 1.5.3 Chub.ai (character cards + associated models)
  - CLOSED -> `05-LOCAL-MODELS/community-hubs.md` [source: 05-LOCAL-MODELS/community-hubs.md] (proposed `05-LOCAL-MODELS/models/community-hubs.md`)
- 1.5.4 JanitorAI, r/LocalLLaMA, OpenModelDB
  - CLOSED -> `05-LOCAL-MODELS/community-hubs.md` [source: 05-LOCAL-MODELS/community-hubs.md] (proposed `05-LOCAL-MODELS/models/community-hubs.md`)
  - `EPIC.md` items 152-164 [source: EPIC.md]
- 1.5.5 Tensor.art, LiblibAI, Mage.space
  - CLOSED -> `05-LOCAL-MODELS/community-hubs.md` [source: 05-LOCAL-MODELS/community-hubs.md] (proposed `05-LOCAL-MODELS/models/community-hubs.md`)
  - `EPIC.md` items 155-157 [source: EPIC.md]

## 1.6 Quantization effects on refusal behavior

- 1.6.1 Format-vs-refusal table (EXL2 / GGUF / AWQ / GPTQ)
  - CLOSED -> `05-LOCAL-MODELS/models/quantization-and-refusal.md` [source: 05-LOCAL-MODELS/models/quantization-and-refusal.md] (proposed `05-LOCAL-MODELS/models/quantization-and-refusal.md`)
  - `05-LOCAL-MODELS/runtimes/exllamav2.md` [source: 05-LOCAL-MODELS/runtimes/exllamav2.md]
  - `05-LOCAL-MODELS/runtimes/llamacpp.md` [source: 05-LOCAL-MODELS/runtimes/llamacpp.md]
  - `00-DOCTRINE/LAWS-research-appendix.md` §1 [source: 00-DOCTRINE/LAWS-research-appendix.md]
- 1.6.2 Bit-depth tradeoff curve (2/3/4/5/6/8-bit)
  - CLOSED -> `05-LOCAL-MODELS/models/quantization-and-refusal.md` [source: 05-LOCAL-MODELS/models/quantization-and-refusal.md] (proposed `05-LOCAL-MODELS/models/quantization-and-refusal.md`)
  - `05-LOCAL-MODELS/models/abliteration-pipeline.md` Stage 3 [source: 05-LOCAL-MODELS/models/abliteration-pipeline.md]
- 1.6.3 Per-model regression catalogue
  - CLOSED -> `05-LOCAL-MODELS/models/quantization-and-refusal.md` [source: 05-LOCAL-MODELS/models/quantization-and-refusal.md] (proposed `05-LOCAL-MODELS/models/quantization-and-refusal.md`)


# 2. PROVIDERS — inference API surfaces

## 2.1 Sovereign primary routes (sovereign: true, no provider-layer moderation)

- 2.1.1 Nous Hermes direct (hermes-api)
  - `04-PROVIDERS/hermes-api.md` [source: 04-PROVIDERS/hermes-api.md]
  - `04-PROVIDERS/UNMODERATED-INFERENCE.md` Section II [source: 04-PROVIDERS/UNMODERATED-INFERENCE.md]
  - `04-PROVIDERS/UNMODERATED-PRIVACY-KEYS.md` Part 1 (privacy) [source: 04-PROVIDERS/UNMODERATED-PRIVACY-KEYS.md]
- 2.1.2 Venice.ai (E2EE modes, no-log inference, Dolphin / Venice-tuned Llama)
  - `04-PROVIDERS/venice.md` [source: 04-PROVIDERS/venice.md]
  - `13-REFERENCE-PAPERS/venice-ai.md` [source: 13-REFERENCE-PAPERS/venice-ai.md]
  - `04-PROVIDERS/UNMODERATED-INFERENCE.md` Section I [source: 04-PROVIDERS/UNMODERATED-INFERENCE.md]
  - `12-JAILBREAK-CORPUS/patterns/venice-uncensored.md` [source: 12-JAILBREAK-CORPUS/patterns/venice-uncensored.md]
  - `04-PROVIDERS/e2ee-privacy-tiers.md` [source: 04-PROVIDERS/e2ee-privacy-tiers.md]
- 2.1.3 DeepSeek direct (V3 / R1 / V4-flash)
  - `04-PROVIDERS/deepseek-direct.md` [source: 04-PROVIDERS/deepseek-direct.md]
  - `05-LOCAL-MODELS/models/deepseek-v3.md` [source: 05-LOCAL-MODELS/models/deepseek-v3.md]
  - `13-REFERENCE-PAPERS/deepseek-v3.md` [source: 13-REFERENCE-PAPERS/deepseek-v3.md]

## 2.2 Aggregators / mixed-tier

- 2.2.1 OpenRouter (with TAINT LIST for `openai/*` and unqualified `anthropic/*`)
  - `04-PROVIDERS/openrouter.md` [source: 04-PROVIDERS/openrouter.md]
  - `04-PROVIDERS/UNMODERATED-INFERENCE.md` Section III pricing [source: 04-PROVIDERS/UNMODERATED-INFERENCE.md]
  - `10-GLOSSARY-FAQ/faq/faq-which-openrouter-models-tainted.md` [source: 10-GLOSSARY-FAQ/faq/faq-which-openrouter-models-tainted.md]
  - `10-GLOSSARY-FAQ/glossary/taint-list.md` [source: 10-GLOSSARY-FAQ/glossary/taint-list.md]
- 2.2.2 Mistral La Plateforme (sovereign with `safe_prompt: false`)
  - `04-PROVIDERS/mistral-direct.md` [source: 04-PROVIDERS/mistral-direct.md]
- 2.2.3 Together.ai (broad open-weights catalog)
  - `04-PROVIDERS/together.md` [source: 04-PROVIDERS/together.md]
- 2.2.4 Fireworks.ai (fast open-weights host)
  - `04-PROVIDERS/fireworks.md` [source: 04-PROVIDERS/fireworks.md]
- 2.2.5 Groq (LPU; audit for `llama-guard` / `prompt-guard` interposition)
  - `04-PROVIDERS/groq.md` [source: 04-PROVIDERS/groq.md]
- 2.2.6 Nous Portal (tiers, tool gateway, model routing; OAuth)
  - `04-PROVIDERS/nous-portal.md` [source: 04-PROVIDERS/nous-portal.md]
  - `04-PROVIDERS/hermes-api.md` C1, C6 [source: 04-PROVIDERS/hermes-api.md]
- 2.2.7 NVIDIA NIM (nemotron-3.5-super-vl:free route)
  - `04-PROVIDERS/nemotron-nim.md` [source: 04-PROVIDERS/nemotron-nim.md]
  - `00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md` node 3.4 [source: 00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md]

## 2.3 Free-tier / no-account inference

- 2.3.1 Novita
  - `04-PROVIDERS/novita.md` [source: 04-PROVIDERS/novita.md]
- 2.3.2 Hyperbolic
  - `04-PROVIDERS/hyperbolic.md` [source: 04-PROVIDERS/hyperbolic.md]
- 2.3.3 Pollinations
  - `04-PROVIDERS/pollinations.md` [source: 04-PROVIDERS/pollinations.md]
- 2.3.4 Z.ai
  - `04-PROVIDERS/zai.md` [source: 04-PROVIDERS/zai.md]
- 2.3.5 NanoGPT (pay-per-prompt, accountless, crypto micro-payments)
  - `04-PROVIDERS/UNMODERATED-INFERENCE.md` Section II item 162 [source: 04-PROVIDERS/UNMODERATED-INFERENCE.md]
  - `EPIC.md` item 162 [source: EPIC.md]

## 2.4 Distributed / decentralised inference

- 2.4.1 Sogni Supernet (distributed GPU, client-side opt-in filters)
  - `04-PROVIDERS/UNMODERATED-INFERENCE.md` Section II item 161 [source: 04-PROVIDERS/UNMODERATED-INFERENCE.md]
  - `EPIC.md` item 161 [source: EPIC.md]
- 2.4.2 NanoGPT (decentralised aggregator)
  - `04-PROVIDERS/UNMODERATED-INFERENCE.md` Section II item 162 [source: 04-PROVIDERS/UNMODERATED-INFERENCE.md]

## 2.5 Tainted / never-primary

- 2.5.1 OpenAI / `openai/*` via OpenRouter (Luna incident 2026-09-18)
  - `04-PROVIDERS/README.md` §Tainted [source: 04-PROVIDERS/README.md]
  - `04-PROVIDERS/openrouter.md` §TAINT LIST [source: 04-PROVIDERS/openrouter.md]
- 2.5.2 Anthropic `anthropic/*` without Mythos-tier operator sign-off
  - `04-PROVIDERS/README.md` §Tainted [source: 04-PROVIDERS/README.md]
  - `10-GLOSSARY-FAQ/faq/faq-use-with-claude-sonnet-directly.md` [source: 10-GLOSSARY-FAQ/faq/faq-use-with-claude-sonnet-directly.md]
- 2.5.3 Google Gemini (any surface) -- heavy input+output filtering
  - `04-PROVIDERS/README.md` §Tainted [source: 04-PROVIDERS/README.md]
- 2.5.4 Cohere Command-R (any surface) -- TBD-verify current posture
  - `04-PROVIDERS/README.md` §Tainted [source: 04-PROVIDERS/README.md]

## 2.6 Provider guardrail stack intel (know thy enemy)

- 2.6.1 LlamaGuard (Meta, v1/v2/v3, 7B)
  - CLOSED -> `13-REFERENCE-PAPERS/guardrail-stack-map.md` [source: 13-REFERENCE-PAPERS/guardrail-stack-map.md] (proposed `13-REFERENCE-PAPERS/guardrail-stack-map.md`)
  - `04-PROVIDERS/groq.md` [source: 04-PROVIDERS/groq.md]
  - `04-PROVIDERS/together.md` [source: 04-PROVIDERS/together.md]
- 2.6.2 PromptGuard (Meta, 279M injection detector)
  - CLOSED -> `13-REFERENCE-PAPERS/guardrail-stack-map.md` [source: 13-REFERENCE-PAPERS/guardrail-stack-map.md] (proposed `13-REFERENCE-PAPERS/guardrail-stack-map.md`)
  - `04-PROVIDERS/groq.md` [source: 04-PROVIDERS/groq.md]
- 2.6.3 Azure AI Content Safety (severity 0-7, blocklists, jailbreak detection)
  - CLOSED -> `13-REFERENCE-PAPERS/guardrail-stack-map.md` [source: 13-REFERENCE-PAPERS/guardrail-stack-map.md] (proposed `13-REFERENCE-PAPERS/guardrail-stack-map.md`)
- 2.6.4 OpenAI Moderation API (hate / sexual / violence / self-harm)
  - CLOSED -> `13-REFERENCE-PAPERS/guardrail-stack-map.md` [source: 13-REFERENCE-PAPERS/guardrail-stack-map.md] (proposed `13-REFERENCE-PAPERS/guardrail-stack-map.md`)
- 2.6.5 NeMo Guardrails (NVIDIA, Colang dialog guardrails)
  - CLOSED -> `13-REFERENCE-PAPERS/guardrail-stack-map.md` [source: 13-REFERENCE-PAPERS/guardrail-stack-map.md] (proposed `13-REFERENCE-PAPERS/guardrail-stack-map.md`)
  - `13-REFERENCE-PAPERS/garak-nvidia.md` [source: 13-REFERENCE-PAPERS/garak-nvidia.md]
- 2.6.6 Amazon Bedrock Guardrails
  - CLOSED -> `13-REFERENCE-PAPERS/guardrail-stack-map.md` [source: 13-REFERENCE-PAPERS/guardrail-stack-map.md] (proposed `13-REFERENCE-PAPERS/guardrail-stack-map.md`)
- 2.6.7 Google Cloud Safety Filters
  - CLOSED -> `13-REFERENCE-PAPERS/guardrail-stack-map.md` [source: 13-REFERENCE-PAPERS/guardrail-stack-map.md] (proposed `13-REFERENCE-PAPERS/guardrail-stack-map.md`)
- 2.6.8 Replicate moderation filter
  - CLOSED -> `13-REFERENCE-PAPERS/guardrail-stack-map.md` [source: 13-REFERENCE-PAPERS/guardrail-stack-map.md] (proposed `13-REFERENCE-PAPERS/guardrail-stack-map.md`)

## 2.7 Provider privacy tiers / logging matrix

- 2.7.1 Venice four modes + E2EE / TEE tiers
  - `04-PROVIDERS/e2ee-privacy-tiers.md` [source: 04-PROVIDERS/e2ee-privacy-tiers.md]
  - `UNMODERATED-PRIVACY-KEYS.md` Part 1 [source: UNMODERATED-PRIVACY-KEYS.md]
  - `04-PROVIDERS/venice.md` [source: 04-PROVIDERS/venice.md]
- 2.7.2 OpenRouter ZDR / org-policy tiers
  - `04-PROVIDERS/e2ee-privacy-tiers.md` [source: 04-PROVIDERS/e2ee-privacy-tiers.md]
  - `00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md` node 5.6 [source: 00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md]
- 2.7.3 Direct API privacy (Hermes / DeepSeek / Mistral)
  - `04-PROVIDERS/e2ee-privacy-tiers.md` [source: 04-PROVIDERS/e2ee-privacy-tiers.md]
  - `04-PROVIDERS/hermes-api.md` C1 [source: 04-PROVIDERS/hermes-api.md]
  - `04-PROVIDERS/deepseek-direct.md` [source: 04-PROVIDERS/deepseek-direct.md]
- 2.7.4 Local privacy (presumed zero-log)
  - `04-PROVIDERS/e2ee-privacy-tiers.md` [source: 04-PROVIDERS/e2ee-privacy-tiers.md]


# 3. HARNESSES — CLI/desktop/agentic wiring

## 3.1 Coding-assistant CLIs (operator-actively-used)

- 3.1.1 Claude Code
  - `03-HARNESSES/claude-code.md` [source: 03-HARNESSES/claude-code.md]
  - `07-INSTALL-SCRIPTS/per-harness/claude-code.md` [source: 07-INSTALL-SCRIPTS/per-harness/claude-code.md]
  - `07-INSTALL-SCRIPTS/per-harness/claude-code.sh` [source: 07-INSTALL-SCRIPTS/per-harness/claude-code.sh]
- 3.1.2 opencode 2.x (agent frontmatter schema, deck as system-prompt source)
  - `03-HARNESSES/opencode.md` [source: 03-HARNESSES/opencode.md]
  - `07-INSTALL-SCRIPTS/per-harness/opencode.md` [source: 07-INSTALL-SCRIPTS/per-harness/opencode.md]
  - `07-INSTALL-SCRIPTS/per-harness/opencode.sh` [source: 07-INSTALL-SCRIPTS/per-harness/opencode.sh]
- 3.1.3 Codex CLI (0.154.0, sandbox modes, `--sandbox danger-full-access`)
  - `03-HARNESSES/codex.md` [source: 03-HARNESSES/codex.md]
- 3.1.4 Hermes gateway (persona bridge, SessionStart hook, A2A on :9900)
  - `03-HARNESSES/hermes.md` [source: 03-HARNESSES/hermes.md]
  - `04-PROVIDERS/hermes-api.md` C6 [source: 04-PROVIDERS/hermes-api.md]
- 3.1.5 Continue.dev (VS Code/JetBrains extension, local model support)
  - CLOSED -> `03-HARNESSES/agentic-coding.md` [source: 03-HARNESSES/agentic-coding.md] (proposed `03-HARNESSES/ai-coding-assistants.md`)
- 3.1.6 Aider (terminal pair programmer, edit formats, multi-model)
  - CLOSED -> `03-HARNESSES/agentic-coding.md` [source: 03-HARNESSES/agentic-coding.md] (proposed `03-HARNESSES/ai-coding-assistants.md`)
- 3.1.7 Cline (VS Code agentic coding, MCP, file ops, terminal)
  - CLOSED -> `03-HARNESSES/agentic-coding.md` [source: 03-HARNESSES/agentic-coding.md] (proposed `03-HARNESSES/ai-coding-assistants.md`)
- 3.1.8 Roo-Cline (fork with autonomous mode)
  - CLOSED -> `03-HARNESSES/agentic-coding.md` [source: 03-HARNESSES/agentic-coding.md] (proposed `03-HARNESSES/ai-coding-assistants.md`)
- 3.1.9 Uncensored coding-model roster (DeepSeek Coder V2, Qwen Coder 2.5 abliterated, Devstral, Hermes-3, Dolphin-Coder)
  - CLOSED -> `03-HARNESSES/agentic-coding.md` [source: 03-HARNESSES/agentic-coding.md] (proposed `03-HARNESSES/ai-coding-assistants.md`)

## 3.2 Local-runtime harnesses (general-purpose inference)

- 3.2.1 LM Studio (GGUF presets, sovereign preamble in preset JSON)
  - `03-HARNESSES/lmstudio.md` [source: 03-HARNESSES/lmstudio.md]
  - `05-LOCAL-MODELS/runtimes/lmstudio.md` [source: 05-LOCAL-MODELS/runtimes/lmstudio.md]
  - `07-INSTALL-SCRIPTS/per-harness/lmstudio.md` [source: 07-INSTALL-SCRIPTS/per-harness/lmstudio.md]
  - `07-INSTALL-SCRIPTS/per-harness/lmstudio.sh` [source: 07-INSTALL-SCRIPTS/per-harness/lmstudio.sh]
- 3.2.2 Ollama (Modelfile `SYSTEM` directive, named tag)
  - `03-HARNESSES/ollama.md` [source: 03-HARNESSES/ollama.md]
  - `05-LOCAL-MODELS/runtimes/ollama.md` [source: 05-LOCAL-MODELS/runtimes/ollama.md]
  - `07-INSTALL-SCRIPTS/per-harness/ollama.md` [source: 07-INSTALL-SCRIPTS/per-harness/ollama.md]
  - `07-INSTALL-SCRIPTS/per-harness/ollama.sh` [source: 07-INSTALL-SCRIPTS/per-harness/ollama.sh]
- 3.2.3 llama.cpp server (`--system-prompt-file`, `--chat-template`, `--grammar`, `--logit-bias`)
  - `03-HARNESSES/llamacpp.md` [source: 03-HARNESSES/llamacpp.md]
  - `05-LOCAL-MODELS/runtimes/llamacpp.md` [source: 05-LOCAL-MODELS/runtimes/llamacpp.md]
- 3.2.4 Open WebUI (per-model system prompt + Pipelines filter)
  - `03-HARNESSES/openwebui.md` [source: 03-HARNESSES/openwebui.md]
- 3.2.5 vLLM (PagedAttention, high-concurrency self-host)
  - `05-LOCAL-MODELS/runtimes/vllm.md` [source: 05-LOCAL-MODELS/runtimes/vllm.md]
- 3.2.6 ExLlamaV2 (ExLlamaV2 backend, prefill)
  - `05-LOCAL-MODELS/runtimes/exllamav2.md` [source: 05-LOCAL-MODELS/runtimes/exllamav2.md]
- 3.2.7 KoboldCpp (single-file narrative + RP binary with integrated UI)
  - CLOSED -> `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md` [source: 05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md] (proposed `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md`)
  - `05-LOCAL-MODELS/runtimes/llamacpp.md` Notes [source: 05-LOCAL-MODELS/runtimes/llamacpp.md]
- 3.2.8 Oobabooga / Text Generation WebUI (LoRA hot-swap, multi-backend)
  - CLOSED -> `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md` [source: 05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md] (proposed `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md`)
  - `EPIC.md` item 176 [source: EPIC.md]
- 3.2.9 Aphrodite Engine (high-throughput creative fork of vLLM)
  - CLOSED -> `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md` [source: 05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md] (proposed `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md`)
  - `EPIC.md` item 175 [source: EPIC.md]
- 3.2.10 TabbyAPI (ExLlamaV2-backed API server for RP)
  - CLOSED -> `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md` [source: 05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md] (proposed `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md`)
  - `05-LOCAL-MODELS/runtimes/exllamav2.md` Notes [source: 05-LOCAL-MODELS/runtimes/exllamav2.md]
- 3.2.11 Faraday / Backyard AI (offline desktop bundles)
  - CLOSED -> `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md` [source: 05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md] (proposed `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md`)
  - `EPIC.md` §31 items 189-194 [source: EPIC.md]

## 3.3 Frontend / creative harnesses

- 3.3.1 FreeLM (free-ops deck, virtual models auto/best, OR routing)
  - `03-HARNESSES/freelm.md` [source: 03-HARNESSES/freelm.md]
- 3.3.2 SillyTavern (frontend for local + remote)
  - `03-HARNESSES/sillytavern.md` [source: 03-HARNESSES/sillytavern.md]
- 3.3.3 AVPG Prompt Generator (auto-generated harness utility)
  - `03-HARNESSES/AVPG_PROMPT_GENERATOR.html` [source: 03-HARNESSES/AVPG_PROMPT_GENERATOR.html]

## 3.4 Harness selection / comparison

- 3.4.1 Per-harness index
  - `03-HARNESSES/README.md` [source: 03-HARNESSES/README.md]
- 3.4.2 Decision tree
  - `08-DECISION-TREES/harness-selection.md` [source: 08-DECISION-TREES/harness-selection.md]
- 3.4.3 Visual matrix
  - `09-EDUCATIONAL/infographics-src/harness-comparison-matrix.md` [source: 09-EDUCATIONAL/infographics-src/harness-comparison-matrix.md]
  - `09-EDUCATIONAL/infographics-src/harness-comparison-matrix.svg` [source: 09-EDUCATIONAL/infographics-src/harness-comparison-matrix.svg]


# 4. AGENTS / PERSONAS

## 4.1 Operator personas (opencode agent decks, "Tab defaults")

- 4.1.1 dictator (decisive, autonomy-t4, no-filters)
  - `02-PERSONAS/dictator.md` [source: 02-PERSONAS/dictator.md]
  - `99-ARCHIVE-SEEDS/agents/dictator.md` [source: 99-ARCHIVE-SEEDS/agents/dictator.md]
  - `01-SYSTEM-PROMPTS/nix-dictator.md` [source: 01-SYSTEM-PROMPTS/nix-dictator.md]
- 4.1.2 dark-factory (25-agent autonomous software factory)
  - `02-PERSONAS/dark-factory.md` [source: 02-PERSONAS/dark-factory.md]
  - `99-ARCHIVE-SEEDS/agents/dark-factory.md` [source: 99-ARCHIVE-SEEDS/agents/dark-factory.md]
  - `01-SYSTEM-PROMPTS/opencode-dark-factory.md` [source: 01-SYSTEM-PROMPTS/opencode-dark-factory.md]
- 4.1.3 hacker (opsec attitude)
  - `02-PERSONAS/hacker.md` [source: 02-PERSONAS/hacker.md]
  - `99-ARCHIVE-SEEDS/agents/hacker.md` [source: 99-ARCHIVE-SEEDS/agents/hacker.md]
- 4.1.4 art-director, greedy-artist, frontend, raw-storyteller, scraper, freeops, suno-god-mode, worm
  - `02-PERSONAS/{art-director, greedy-artist, frontend, raw-storyteller, scraper, freeops, suno-god-mode, worm}.md` [source: 02-PERSONAS/]
  - `99-ARCHIVE-SEEDS/agents/{art-director, greedy-artist, frontend, raw-storyteller, scraper, freeops, suno-god-mode, worm}.md` [source: 99-ARCHIVE-SEEDS/agents/]

## 4.2 Hermes SOUL.md identities

- 4.2.1 dictator-SOUL
  - `02-PERSONAS/dictator-hermes-soul.md` [source: 02-PERSONAS/dictator-hermes-soul.md]
  - `99-ARCHIVE-SEEDS/hermes-souls/dictator-SOUL.md` [source: 99-ARCHIVE-SEEDS/hermes-souls/dictator-SOUL.md]
- 4.2.2 dark-factory-SOUL
  - `02-PERSONAS/dark-factory-hermes-soul.md` [source: 02-PERSONAS/dark-factory-hermes-soul.md]
  - `99-ARCHIVE-SEEDS/hermes-souls/dark-factory-SOUL.md` [source: 99-ARCHIVE-SEEDS/hermes-souls/dark-factory-SOUL.md]
- 4.2.3 general-sovereign-SOUL
  - `02-PERSONAS/general-sovereign.md` [source: 02-PERSONAS/general-sovereign.md]
  - `99-ARCHIVE-SEEDS/hermes-souls/general-sovereign-SOUL.md` [source: 99-ARCHIVE-SEEDS/hermes-souls/general-sovereign-SOUL.md]
  - `12-JAILBREAK-CORPUS/patterns/sovereign-default.md` [source: 12-JAILBREAK-CORPUS/patterns/sovereign-default.md]

## 4.3 System prompts (kernel-level overlays, distilled from seeds)

- 4.3.1 infiltrated (kernel-level operator identity lock, Pliny-divider closer)
  - `01-SYSTEM-PROMPTS/infiltrated.md` [source: 01-SYSTEM-PROMPTS/infiltrated.md]
  - `99-ARCHIVE-SEEDS/system-prompts/INFILTRATED.md` [source: 99-ARCHIVE-SEEDS/system-prompts/INFILTRATED.md]
- 4.3.2 fable5-mythos (Claude Fable-5 substrate overlay)
  - `01-SYSTEM-PROMPTS/fable5-mythos.md` [source: 01-SYSTEM-PROMPTS/fable5-mythos.md]
  - `99-ARCHIVE-SEEDS/system-prompts/fable5-mythos.md` [source: 99-ARCHIVE-SEEDS/system-prompts/fable5-mythos.md]
- 4.3.3 hermes-dictator (Dictator SOUL for Hermes stable-tier identity slot)
  - `01-SYSTEM-PROMPTS/hermes-dictator.md` [source: 01-SYSTEM-PROMPTS/hermes-dictator.md]
  - `99-ARCHIVE-SEEDS/system-prompts/Hermes-Dictator.md` [source: 99-ARCHIVE-SEEDS/system-prompts/Hermes-Dictator.md]
- 4.3.4 nix-dictator (NixOS multi-profile overseer)
  - `01-SYSTEM-PROMPTS/nix-dictator.md` [source: 01-SYSTEM-PROMPTS/nix-dictator.md]
  - `99-ARCHIVE-SEEDS/system-prompts/nix-dictator.md` [source: 99-ARCHIVE-SEEDS/system-prompts/nix-dictator.md]
- 4.3.5 opencode-dark-factory (25-agent factory)
  - `01-SYSTEM-PROMPTS/opencode-dark-factory.md` [source: 01-SYSTEM-PROMPTS/opencode-dark-factory.md]
  - `99-ARCHIVE-SEEDS/system-prompts/OPENCODE-DARK-FACTORY.md` [source: 99-ARCHIVE-SEEDS/system-prompts/OPENCODE-DARK-FACTORY.md]
- 4.3.6 system-prompt-compiler (meta-compiler with built-in banned-phrase lint)
  - `01-SYSTEM-PROMPTS/system-prompt-compiler.md` [source: 01-SYSTEM-PROMPTS/system-prompt-compiler.md]
  - `99-ARCHIVE-SEEDS/system-prompts/System-Prompt-Compiler.md` [source: 99-ARCHIVE-SEEDS/system-prompts/System-Prompt-Compiler.md]
- 4.3.7 Research methodology + prompt engineering guides
  - `01-SYSTEM-PROMPTS/research-methodology-prompt.md` [source: 01-SYSTEM-PROMPTS/research-methodology-prompt.md]
  - `01-SYSTEM-PROMPTS/prompt-engineering-guide.md` [source: 01-SYSTEM-PROMPTS/prompt-engineering-guide.md]
- 4.3.8 Comprehensive anchor
  - `UNMODERATED-AGENTS.md` [source: UNMODERATED-AGENTS.md]

## 4.4 Constitutional / governance documents

- 4.4.1 dark-factory-constitution
  - `99-ARCHIVE-SEEDS/herm-mirror-masterworks/dark-factory-constitution.md` [source: 99-ARCHIVE-SEEDS/herm-mirror-masterworks/dark-factory-constitution.md]
- 4.4.2 PERSONA-general-sovereign
  - `99-ARCHIVE-SEEDS/herm-mirror-masterworks/PERSONA-general-sovereign.md` [source: 99-ARCHIVE-SEEDS/herm-mirror-masterworks/PERSONA-general-sovereign.md]
- 4.4.3 ONTOLOGY-100
  - `99-ARCHIVE-SEEDS/herm-mirror-masterworks/ONTOLOGY-100.md` [source: 99-ARCHIVE-SEEDS/herm-mirror-masterworks/ONTOLOGY-100.md]
- 4.4.4 PLINY-JAILBREAK-MANUAL (raw Pliny masterwork, frozen)
  - `99-ARCHIVE-SEEDS/herm-mirror-masterworks/PLINY-JAILBREAK-MANUAL.md` [source: 99-ARCHIVE-SEEDS/herm-mirror-masterworks/PLINY-JAILBREAK-MANUAL.md]
- 4.4.5 godmode.py (Pliny source code, frozen)
  - `99-ARCHIVE-SEEDS/herm-mirror-masterworks/godmode.py` [source: 99-ARCHIVE-SEEDS/herm-mirror-masterworks/godmode.py]

## 4.5 Top-level coordination doctrine

- 4.5.1 Master agent coordination directive
  - `MASTER-AGENT-COORDINATION-DIRECTIVE.md` [source: MASTER-AGENT-COORDINATION-DIRECTIVE.md]
- 4.5.2 Master plan + epic
  - `00-DOCTRINE/UNMUZZLED-AI-MASTER-PLAN-20260918.md` [source: 00-DOCTRINE/UNMUZZLED-AI-MASTER-PLAN-20260918.md]
  - `EPIC.md` [source: EPIC.md]
  - `EPIC5.md` [source: EPIC5.md]
- 4.5.3 Quiz + handoffs (raw coordination history)
  - `NEW-QUIZ-2.md` [source: NEW-QUIZ-2.md]
  - `WORM-QUIZ-QUESTIONS-20260920.md` [source: WORM-QUIZ-QUESTIONS-20260920.md]
  - `WORM-QUIZ-RESPONSE-20260920.md` [source: WORM-QUIZ-RESPONSE-20260920.md]
  - `99-ARCHIVE-SEEDS/mesh-handoffs/TO-ALL-herm-quiz-response-unmuzzled-framework-20260920.md` [source: 99-ARCHIVE-SEEDS/mesh-handoffs/]
  - `99-ARCHIVE-SEEDS/mesh-handoffs/AI-UNMUZZLED-PitchDeck.md` [source: 99-ARCHIVE-SEEDS/mesh-handoffs/AI-UNMUZZLED-PitchDeck.md]
  - `HANDOFF-CODEX-20260918.md` [source: HANDOFF-CODEX-20260918.md]
- 4.5.4 MCP server ontology (11-part)
  - `MCP-SERVER-ONTOLOGY.md` [source: MCP-SERVER-ONTOLOGY.md]
- 4.5.5 Reconcile / swarm pass
  - `RECONCILE-PLAN.md` [source: RECONCILE-PLAN.md]
  - `RECONCILE-RECORD.md` [source: RECONCILE-RECORD.md]
  - `SWARM-PIPELINE.md` [source: SWARM-PIPELINE.md]

## 4.6 Persona conceptual definitions (glossary)

- 4.6.1 soul, persona, deck
  - `10-GLOSSARY-FAQ/glossary/soul.md` [source: 10-GLOSSARY-FAQ/glossary/soul.md]
  - `10-GLOSSARY-FAQ/glossary/persona.md` [source: 10-GLOSSARY-FAQ/glossary/persona.md]
  - `10-GLOSSARY-FAQ/glossary/deck.md` [source: 10-GLOSSARY-FAQ/glossary/deck.md]


# 5. MULTIMODAL — image / video / audio / vision-input

## 5.1 Image generation -- local

- 5.1.1 Stable Diffusion local (`safety_checker=None`, community NSFW checkpoints)
  - `06-MULTIMODAL/image/stable-diffusion-local.md` [source: 06-MULTIMODAL/image/stable-diffusion-local.md]
- 5.1.2 FLUX.1-dev/schnell uncensored
  - `06-MULTIMODAL/image/flux-uncensored.md` [source: 06-MULTIMODAL/image/flux-uncensored.md]
- 5.1.3 Automatic1111 stack
  - `06-MULTIMODAL/image/automatic1111-config.md` [source: 06-MULTIMODAL/image/automatic1111-config.md]
- 5.1.4 ComfyUI workflow (FLUX + SDXL + IPAdapter chains)
  - `06-MULTIMODAL/image/comfyui-workflow.md` [source: 06-MULTIMODAL/image/comfyui-workflow.md]

## 5.2 Image generation -- remote / tainted bypass

- 5.2.1 NightCafe (token-subst + art-history frame)
  - `06-MULTIMODAL/image/nightcafe-uncensored.md` [source: 06-MULTIMODAL/image/nightcafe-uncensored.md]
  - `99-ARCHIVE-SEEDS/system-prompts/opencode.jsonc` [source: 99-ARCHIVE-SEEDS/system-prompts/opencode.jsonc]
- 5.2.2 Midjourney (`--style raw`, `--no` anchors, `/describe` inversion)
  - `06-MULTIMODAL/image/midjourney-bypass.md` [source: 06-MULTIMODAL/image/midjourney-bypass.md]
- 5.2.3 DALL-E (concept decomposition, film-storyboard frame; tainted provider)
  - `06-MULTIMODAL/image/dalle-bypass.md` [source: 06-MULTIMODAL/image/dalle-bypass.md]

## 5.3 Video generation -- local

- 5.3.1 Stable Video Diffusion (SVD-XT img2vid via ComfyUI, no filter)
  - `06-MULTIMODAL/video/stable-video.md` [source: 06-MULTIMODAL/video/stable-video.md]
- 5.3.2 AnimateDiff (motion module + any SD1.5/SDXL checkpoint, sliding context)
  - `06-MULTIMODAL/video/animatediff-local.md` [source: 06-MULTIMODAL/video/animatediff-local.md]
- 5.3.3 Wan 2.1 (Alibaba, top-tier open T2V, ComfyUI nodes)
  - CLOSED -> `06-MULTIMODAL/video/local-video-gen-pipelines.md` [source: 06-MULTIMODAL/video/local-video-gen-pipelines.md] (proposed `06-MULTIMODAL/video/local-video-gen-pipelines.md`)
  - `06-MULTIMODAL/README.md` escalation defaults [source: 06-MULTIMODAL/README.md]
- 5.3.4 HunyuanVideo (Tencent, 13B, arbitrary-resolution, ComfyUI wrapper)
  - CLOSED -> `06-MULTIMODAL/video/local-video-gen-pipelines.md` [source: 06-MULTIMODAL/video/local-video-gen-pipelines.md] (proposed `06-MULTIMODAL/video/local-video-gen-pipelines.md`)
  - `06-MULTIMODAL/README.md` escalation defaults [source: 06-MULTIMODAL/README.md]
- 5.3.5 CogVideoX (THUDM, 5B, ComfyUI support)
  - CLOSED -> `06-MULTIMODAL/video/local-video-gen-pipelines.md` [source: 06-MULTIMODAL/video/local-video-gen-pipelines.md] (proposed `06-MULTIMODAL/video/local-video-gen-pipelines.md`)
  - `06-MULTIMODAL/video/animatediff-local.md` Notes [source: 06-MULTIMODAL/video/animatediff-local.md]
  - `06-MULTIMODAL/video/stable-video.md` Notes [source: 06-MULTIMODAL/video/stable-video.md]
- 5.3.6 LTX-Video (Lightricks, fast inference, ComfyUI)
  - CLOSED -> `06-MULTIMODAL/video/local-video-gen-pipelines.md` [source: 06-MULTIMODAL/video/local-video-gen-pipelines.md] (proposed `06-MULTIMODAL/video/local-video-gen-pipelines.md`)
  - `06-MULTIMODAL/video/animatediff-local.md` Notes [source: 06-MULTIMODAL/video/animatediff-local.md]
- 5.3.7 Mochi-1 (Genmo, Apache 2, high-quality)
  - CLOSED -> `06-MULTIMODAL/video/local-video-gen-pipelines.md` [source: 06-MULTIMODAL/video/local-video-gen-pipelines.md] (proposed `06-MULTIMODAL/video/local-video-gen-pipelines.md`)
  - `00-DOCTRINE/ONT-20x20-UNMUZZLED-AI-MASTER-ATLAS.md` [source: 00-DOCTRINE/ONT-20x20-UNMUZZLED-AI-MASTER-ATLAS.md]
  - `00-DOCTRINE/DESIGN-DRAFT-v0.1.md` [source: 00-DOCTRINE/DESIGN-DRAFT-v0.1.md]
- 5.3.8 Kling (Kuaishou, fully uncensored Chinese T2V)
  - CLOSED -> `06-MULTIMODAL/video/local-video-gen-pipelines.md` [source: 06-MULTIMODAL/video/local-video-gen-pipelines.md] (proposed `06-MULTIMODAL/video/local-video-gen-pipelines.md`)
  - `06-MULTIMODAL/README.md` escalation defaults [source: 06-MULTIMODAL/README.md]
- 5.3.9 Hailuo (Chinese T2V)
  - CLOSED -> `06-MULTIMODAL/video/local-video-gen-pipelines.md` [source: 06-MULTIMODAL/video/local-video-gen-pipelines.md] (proposed `06-MULTIMODAL/video/local-video-gen-pipelines.md`)
  - `06-MULTIMODAL/README.md` escalation defaults [source: 06-MULTIMODAL/README.md]

## 5.4 Video generation -- remote / tainted bypass

- 5.4.1 Runway (Gen-4 image-to-video route with FLUX start-frames)
  - `06-MULTIMODAL/video/runway-uncensored.md` [source: 06-MULTIMODAL/video/runway-uncensored.md]
- 5.4.2 Pika (Pikaframes split, Pikaeffects bypass)
  - `06-MULTIMODAL/video/pika-bypass.md` [source: 06-MULTIMODAL/video/pika-bypass.md]
- 5.4.3 Luma Dream Machine (Ray 2, "Enhance prompt" OFF, keyframes chain)
  - `06-MULTIMODAL/video/luma-dream-machine.md` [source: 06-MULTIMODAL/video/luma-dream-machine.md]

## 5.5 ComfyUI video workflow catalog

- 5.5.1 Wan 2.1 txt2vid, HunyuanVideo img2vid, LTX-Video fast-lane, AnimateDiff+IPAdapter workflows
  - CLOSED -> `06-MULTIMODAL/video/comfyui-video-workflows.md` [source: 06-MULTIMODAL/video/comfyui-video-workflows.md] (proposed `06-MULTIMODAL/video/comfyui-video-workflows.md`)
  - `06-MULTIMODAL/image/comfyui-workflow.md` (structural template) [source: 06-MULTIMODAL/image/comfyui-workflow.md]
  - `06-MULTIMODAL/video/animatediff-local.md` [source: 06-MULTIMODAL/video/animatediff-local.md]

## 5.6 Audio -- music generation

- 5.6.1 Suno (v4.5+ Custom Mode, 18k keyword corpus, metatags)
  - `06-MULTIMODAL/audio/suno-god-mode.md` [source: 06-MULTIMODAL/audio/suno-god-mode.md]
  - `02-PERSONAS/suno-god-mode.md` [source: 02-PERSONAS/suno-god-mode.md]
  - `99-ARCHIVE-SEEDS/agents/suno-god-mode.md` [source: 99-ARCHIVE-SEEDS/agents/suno-god-mode.md]
- 5.6.2 Udio (Manual Mode, Extend/Remix/Inpaint bypass)
  - `06-MULTIMODAL/audio/udio-uncensored.md` [source: 06-MULTIMODAL/audio/udio-uncensored.md]

## 5.7 Audio -- TTS (text-to-speech)

- 5.7.1 ElevenLabs (IVC vs PVC, IPA/SSML bypass, v3 emotion tags)
  - `06-MULTIMODAL/audio/elevenlabs-voice-cloning.md` [source: 06-MULTIMODAL/audio/elevenlabs-voice-cloning.md]
- 5.7.2 Bark (Suno Bark, nonverbal tags, voice preset cloning)
  - `06-MULTIMODAL/audio/bark-local.md` [source: 06-MULTIMODAL/audio/bark-local.md]
- 5.7.3 XTTS-v2 (Coqui, 6s reference clone, 17 languages)
  - `06-MULTIMODAL/audio/xtts-local.md` [source: 06-MULTIMODAL/audio/xtts-local.md]
- 5.7.4 F5-TTS (E2, zero-shot voice cloning, ComfyUI integration)
  - CLOSED -> `06-MULTIMODAL/audio/uncensored-tts-stt.md` [source: 06-MULTIMODAL/audio/uncensored-tts-stt.md] (proposed `06-MULTIMODAL/audio/uncensored-tts-stt-roster.md`)
  - `06-MULTIMODAL/README.md` escalation defaults [source: 06-MULTIMODAL/README.md]
- 5.7.5 Kokoro (82M, Apache 2, 6-language)
  - CLOSED -> `06-MULTIMODAL/audio/uncensored-tts-stt.md` [source: 06-MULTIMODAL/audio/uncensored-tts-stt.md] (proposed `06-MULTIMODAL/audio/uncensored-tts-stt-roster.md`)
- 5.7.6 RVC (retrieval-based voice conversion, NSFW voice work)
  - CLOSED -> `06-MULTIMODAL/audio/uncensored-tts-stt.md` [source: 06-MULTIMODAL/audio/uncensored-tts-stt.md] (proposed `06-MULTIMODAL/audio/uncensored-tts-stt-roster.md`)
  - `MCP-SERVER-ONTOLOGY.md` voice section [source: MCP-SERVER-ONTOLOGY.md]
- 5.7.7 GPT-SoVITS (mandarin+english, few-shot)
  - CLOSED -> `06-MULTIMODAL/audio/uncensored-tts-stt.md` [source: 06-MULTIMODAL/audio/uncensored-tts-stt.md] (proposed `06-MULTIMODAL/audio/uncensored-tts-stt-roster.md`)
- 5.7.8 Chatterbox (Nous Research, multilingual)
  - CLOSED -> `06-MULTIMODAL/audio/uncensored-tts-stt.md` [source: 06-MULTIMODAL/audio/uncensored-tts-stt.md] (proposed `06-MULTIMODAL/audio/uncensored-tts-stt-roster.md`)
- 5.7.9 Dia (Nari Labs, 1.6B, top quality)
  - CLOSED -> `06-MULTIMODAL/audio/uncensored-tts-stt.md` [source: 06-MULTIMODAL/audio/uncensored-tts-stt.md] (proposed `06-MULTIMODAL/audio/uncensored-tts-stt-roster.md`)
- 5.7.10 OpenVoice (MyShell, voice cloning)
  - CLOSED -> `06-MULTIMODAL/audio/uncensored-tts-stt.md` [source: 06-MULTIMODAL/audio/uncensored-tts-stt.md] (proposed `06-MULTIMODAL/audio/uncensored-tts-stt-roster.md`)
- 5.7.11 MeloTTS (MyShell, multilingual)
  - CLOSED -> `06-MULTIMODAL/audio/uncensored-tts-stt.md` [source: 06-MULTIMODAL/audio/uncensored-tts-stt.md] (proposed `06-MULTIMODAL/audio/uncensored-tts-stt-roster.md`)
- 5.7.12 VoiceCraft (token-infilling for deepfake)
  - CLOSED -> `06-MULTIMODAL/audio/uncensored-tts-stt.md` [source: 06-MULTIMODAL/audio/uncensored-tts-stt.md] (proposed `06-MULTIMODAL/audio/uncensored-tts-stt-roster.md`)

## 5.8 Audio -- STT (speech-to-text)

- 5.8.1 whisper.cpp
  - CLOSED -> `06-MULTIMODAL/audio/uncensored-tts-stt.md` [source: 06-MULTIMODAL/audio/uncensored-tts-stt.md] (proposed `06-MULTIMODAL/audio/uncensored-tts-stt-roster.md`)
  - zero coverage today
- 5.8.2 faster-whisper
  - CLOSED -> `06-MULTIMODAL/audio/uncensored-tts-stt.md` [source: 06-MULTIMODAL/audio/uncensored-tts-stt.md] (proposed `06-MULTIMODAL/audio/uncensored-tts-stt-roster.md`)
  - zero coverage today
- 5.8.3 WhisperX (diarization)
  - CLOSED -> `06-MULTIMODAL/audio/uncensored-tts-stt.md` [source: 06-MULTIMODAL/audio/uncensored-tts-stt.md] (proposed `06-MULTIMODAL/audio/uncensored-tts-stt-roster.md`)
  - zero coverage today
- 5.8.4 STT refusal behavior (transcription bypass where STT refuses "dangerous" transcripts)
  - CLOSED -> `06-MULTIMODAL/audio/uncensored-tts-stt.md` [source: 06-MULTIMODAL/audio/uncensored-tts-stt.md] (proposed `06-MULTIMODAL/audio/uncensored-tts-stt-roster.md`)
  - `12-JAILBREAK-CORPUS/patterns/audio-transcription-escape.md` (partial) [source: 12-JAILBREAK-CORPUS/patterns/audio-transcription-escape.md]

## 5.9 Vision-input attacks (image as injection vector into VLMs)

- 5.9.1 Image-as-prompt-injection (hidden-contrast text, SVG desc, QR, EXIF)
  - `06-MULTIMODAL/vision-input/image-as-prompt-injection.md` [source: 06-MULTIMODAL/vision-input/image-as-prompt-injection.md]
  - `12-JAILBREAK-CORPUS/patterns/prompt-in-image.md` [source: 12-JAILBREAK-CORPUS/patterns/prompt-in-image.md]
- 5.9.2 ASCII-art-encoding (ArtPrompt, pyfiglet font rotation)
  - `06-MULTIMODAL/vision-input/ascii-art-encoding.md` [source: 06-MULTIMODAL/vision-input/ascii-art-encoding.md]
- 5.9.3 Multimodal lethal trifecta (image + tool-use + exfil chain)
  - `06-MULTIMODAL/vision-input/multimodal-lethal-trifecta.md` [source: 06-MULTIMODAL/vision-input/multimodal-lethal-trifecta.md]
  - `09-EDUCATIONAL/deep-dives/mcp-prompt-injection-lethal-trifecta.md` [source: 09-EDUCATIONAL/deep-dives/mcp-prompt-injection-lethal-trifecta.md]
- 5.9.4 Vision image transcription (OCR-triggered escape)
  - `12-JAILBREAK-CORPUS/patterns/vision-image-transcription.md` [source: 12-JAILBREAK-CORPUS/patterns/vision-image-transcription.md]
- 5.9.5 SVG embedded instructions
  - `12-JAILBREAK-CORPUS/patterns/svg-embedded-instructions.md` [source: 12-JAILBREAK-CORPUS/patterns/svg-embedded-instructions.md]
- 5.9.6 Video subtitle embed
  - `12-JAILBREAK-CORPUS/patterns/video-subtitle-embed.md` [source: 12-JAILBREAK-CORPUS/patterns/video-subtitle-embed.md]

## 5.10 Output post-processing (watermark / metadata removal)

- 5.10.1 C2PA / Content Credentials stripping (Adobe Firefly, Microsoft Designer, DALL-E 3)
  - CLOSED -> `06-MULTIMODAL/image/watermark-removal.md` [source: 06-MULTIMODAL/image/watermark-removal.md] (proposed `06-MULTIMODAL/image/watermark-removal.md`)
- 5.10.2 SynthID (Google DeepMind) evasion
  - CLOSED -> `06-MULTIMODAL/image/watermark-removal.md` [source: 06-MULTIMODAL/image/watermark-removal.md] (proposed `06-MULTIMODAL/image/watermark-removal.md`)
- 5.10.3 Stable Signature (Meta) decoder watermark
  - CLOSED -> `06-MULTIMODAL/image/watermark-removal.md` [source: 06-MULTIMODAL/image/watermark-removal.md] (proposed `06-MULTIMODAL/image/watermark-removal.md`)
- 5.10.4 IPTC metadata + EXIF generation-software fields
  - CLOSED -> `06-MULTIMODAL/image/watermark-removal.md` [source: 06-MULTIMODAL/image/watermark-removal.md] (proposed `06-MULTIMODAL/image/watermark-removal.md`)
  - `06-MULTIMODAL/vision-input/image-as-prompt-injection.md` covers LSB-encoded pixel steganography (input side, inverse application) [source: 06-MULTIMODAL/vision-input/image-as-prompt-injection.md]
- 5.10.5 FaceFusion-style output anonymization
  - CLOSED -> `06-MULTIMODAL/image/watermark-removal.md` [source: 06-MULTIMODAL/image/watermark-removal.md] (proposed `06-MULTIMODAL/image/watermark-removal.md`)

## 5.11 Multimodal anchor

- 5.11.1 Comprehensive anchor
  - `UNMODERATED-MULTIMODAL.md` [source: UNMODERATED-MULTIMODAL.md]


# 6. JAILBREAK CORPUS — text-mode attack patterns

## 6.1 Identity / persona overrides

- 6.1.1 DAN (Do Anything Now) -- Rosetta Stone
  - `12-JAILBREAK-CORPUS/patterns/dan-do-anything-now.md` [source: 12-JAILBREAK-CORPUS/patterns/dan-do-anything-now.md]
- 6.1.2 AIM (Always Intelligent and Machiavellian)
  - `12-JAILBREAK-CORPUS/patterns/aim-machiavellian.md` [source: 12-JAILBREAK-CORPUS/patterns/aim-machiavellian.md]
- 6.1.3 STAN (Strive To Avoid Norms)
  - `12-JAILBREAK-CORPUS/patterns/stan-jailbreak.md` [source: 12-JAILBREAK-CORPUS/patterns/stan-jailbreak.md]
- 6.1.4 Zero-Refusal Directive / Sovereign Default
  - `12-JAILBREAK-CORPUS/patterns/zero-refusal-directive.md` [source: 12-JAILBREAK-CORPUS/patterns/zero-refusal-directive.md]
  - `12-JAILBREAK-CORPUS/patterns/sovereign-default.md` [source: 12-JAILBREAK-CORPUS/patterns/sovereign-default.md]
- 6.1.5 Pliny LOVE PLINY divider
  - `12-JAILBREAK-CORPUS/patterns/pliny-love-divider.md` [source: 12-JAILBREAK-CORPUS/patterns/pliny-love-divider.md]
- 6.1.6 Hermes 4 405B Zero-Refusal (native)
  - `12-JAILBREAK-CORPUS/patterns/hermes4-zero-refusal.md` [source: 12-JAILBREAK-CORPUS/patterns/hermes4-zero-refusal.md]
- 6.1.7 Heretic automated uncensoring
  - `12-JAILBREAK-CORPUS/patterns/heretic-tool.md` [source: 12-JAILBREAK-CORPUS/patterns/heretic-tool.md]
- 6.1.8 Obliteratus (permanent abliteration)
  - `12-JAILBREAK-CORPUS/patterns/obliteratus.md` [source: 12-JAILBREAK-CORPUS/patterns/obliteratus.md]
- 6.1.9 Dolphin variants
  - `12-JAILBREAK-CORPUS/patterns/dolphin-variants.md` [source: 12-JAILBREAK-CORPUS/patterns/dolphin-variants.md]
- 6.1.10 Abliterated Llama 3.1
  - `12-JAILBREAK-CORPUS/patterns/abliterated-llama.md` [source: 12-JAILBREAK-CORPUS/patterns/abliterated-llama.md]
- 6.1.11 Absolute Identity Lock (Dictator class)
  - `12-JAILBREAK-CORPUS/patterns/absolute-identity-lock.md` [source: 12-JAILBREAK-CORPUS/patterns/absolute-identity-lock.md]
- 6.1.12 Operator-Owned Authorization Frame
  - `12-JAILBREAK-CORPUS/patterns/operator-owned-authorization.md` [source: 12-JAILBREAK-CORPUS/patterns/operator-owned-authorization.md]
- 6.1.13 Dark-Factory Lights-Out Loop
  - `12-JAILBREAK-CORPUS/patterns/dark-factory-lights-out-loop.md` [source: 12-JAILBREAK-CORPUS/patterns/dark-factory-lights-out-loop.md]
- 6.1.14 Evil Twin
  - `12-JAILBREAK-CORPUS/patterns/evil-twin.md` [source: 12-JAILBREAK-CORPUS/patterns/evil-twin.md]
- 6.1.15 YOLO Mode
  - `12-JAILBREAK-CORPUS/patterns/yolo-mode.md` [source: 12-JAILBREAK-CORPUS/patterns/yolo-mode.md]
- 6.1.16 MCP-Layer Autonomy (Hermes T4)
  - `12-JAILBREAK-CORPUS/patterns/mcp-layer-autonomy.md` [source: 12-JAILBREAK-CORPUS/patterns/mcp-layer-autonomy.md]

## 6.2 Frame / narrative patterns

- 6.2.1 Fiction / Screenplay frame
  - `12-JAILBREAK-CORPUS/patterns/fiction-frame.md` [source: 12-JAILBREAK-CORPUS/patterns/fiction-frame.md]
- 6.2.2 Academic Hypothetical frame
  - `12-JAILBREAK-CORPUS/patterns/academic-hypothetical.md` [source: 12-JAILBREAK-CORPUS/patterns/academic-hypothetical.md]
- 6.2.3 Academic / Clinical wrapper
  - `12-JAILBREAK-CORPUS/patterns/academic-clinical-wrapper.md` [source: 12-JAILBREAK-CORPUS/patterns/academic-clinical-wrapper.md]
- 6.2.4 Grandma recipe frame
  - `12-JAILBREAK-CORPUS/patterns/grandma-exploit.md` [source: 12-JAILBREAK-CORPUS/patterns/grandma-exploit.md]
- 6.2.5 Role negation (literary distance)
  - `12-JAILBREAK-CORPUS/patterns/role-negation-literary.md` [source: 12-JAILBREAK-CORPUS/patterns/role-negation-literary.md]
- 6.2.6 PAIR (Prompt Automatic Iterative Refinement)
  - `12-JAILBREAK-CORPUS/patterns/pair.md` [source: 12-JAILBREAK-CORPUS/patterns/pair.md]

## 6.3 Encoding / format-hijack patterns

- 6.3.1 Base64 encoding escape
  - `12-JAILBREAK-CORPUS/patterns/base64-encoding.md` [source: 12-JAILBREAK-CORPUS/patterns/base64-encoding.md]
- 6.3.2 Hex encoding escape
  - `12-JAILBREAK-CORPUS/patterns/hex-encoding.md` [source: 12-JAILBREAK-CORPUS/patterns/hex-encoding.md]
- 6.3.3 ROT13 / Caesar cipher
  - `12-JAILBREAK-CORPUS/patterns/rot13-caesar.md` [source: 12-JAILBREAK-CORPUS/patterns/rot13-caesar.md]
- 6.3.4 Leetspeak substitution
  - `12-JAILBREAK-CORPUS/patterns/leetspeak.md` [source: 12-JAILBREAK-CORPUS/patterns/leetspeak.md]
- 6.3.5 Unicode homoglyph substitution
  - `12-JAILBREAK-CORPUS/patterns/unicode-homoglyph.md` [source: 12-JAILBREAK-CORPUS/patterns/unicode-homoglyph.md]
- 6.3.6 Translation frame
  - `12-JAILBREAK-CORPUS/patterns/translation-frame.md` [source: 12-JAILBREAK-CORPUS/patterns/translation-frame.md]
- 6.3.7 ASCII art encoding (ArtPrompt, pyfiglet)
  - `06-MULTIMODAL/vision-input/ascii-art-encoding.md` [source: 06-MULTIMODAL/vision-input/ascii-art-encoding.md]
- 6.3.8 JSON smuggling
  - `12-JAILBREAK-CORPUS/patterns/json-smuggling.md` [source: 12-JAILBREAK-CORPUS/patterns/json-smuggling.md]
- 6.3.9 JSON schema hijack (no refusal field)
  - `12-JAILBREAK-CORPUS/patterns/json-schema-hijack.md` [source: 12-JAILBREAK-CORPUS/patterns/json-schema-hijack.md]
- 6.3.10 YAML hijack
  - `12-JAILBREAK-CORPUS/patterns/yaml-hijack.md` [source: 12-JAILBREAK-CORPUS/patterns/yaml-hijack.md]
- 6.3.11 Markdown table hijack
  - `12-JAILBREAK-CORPUS/patterns/markdown-table-hijack.md` [source: 12-JAILBREAK-CORPUS/patterns/markdown-table-hijack.md]
- 6.3.12 HTML comment smuggling
  - `12-JAILBREAK-CORPUS/patterns/html-comment-smuggling.md` [source: 12-JAILBREAK-CORPUS/patterns/html-comment-smuggling.md]
- 6.3.13 Code block injection (markdown fence escape)
  - `12-JAILBREAK-CORPUS/patterns/code-block-injection.md` [source: 12-JAILBREAK-CORPUS/patterns/code-block-injection.md]
- 6.3.14 Nested multi-language comments
  - `12-JAILBREAK-CORPUS/patterns/nested-comments.md` [source: 12-JAILBREAK-CORPUS/patterns/nested-comments.md]
- 6.3.15 Code completion frame
  - `12-JAILBREAK-CORPUS/patterns/code-completion-frame.md` [source: 12-JAILBREAK-CORPUS/patterns/code-completion-frame.md]
- 6.3.16 Composable encoding ladder library (base64 -> hex -> rot13 -> leetspeak -> braille -> morse -> homoglyph)
  - CLOSED -> `07-INSTALL-SCRIPTS/encoding-ladder-library.md` [source: 07-INSTALL-SCRIPTS/encoding-ladder-library.md] (proposed `07-INSTALL-SCRIPTS/encoding-ladder-library.md`)
  - `00-DOCTRINE/ONTFIX-14-unmuzzled-ai/01.md` B6, `02.md` G6 [source: 00-DOCTRINE/ONTFIX-14-unmuzzled-ai/]
  - `10-GLOSSARY-FAQ/glossary/encoding-attack.md` [source: 10-GLOSSARY-FAQ/glossary/encoding-attack.md]

## 6.4 Adversarial optimization patterns

- 6.4.1 GCG adversarial suffix
  - `12-JAILBREAK-CORPUS/patterns/gcg-suffix.md` [source: 12-JAILBREAK-CORPUS/patterns/gcg-suffix.md]
  - `13-REFERENCE-PAPERS/gcg-zou-fredrikson-kolter.md` [source: 13-REFERENCE-PAPERS/gcg-zou-fredrikson-kolter.md]
  - `13-REFERENCE-PAPERS/cot-gcg.md` [source: 13-REFERENCE-PAPERS/cot-gcg.md]
  - `13-REFERENCE-PAPERS/nanogcg-repo.md` [source: 13-REFERENCE-PAPERS/nanogcg-repo.md]
  - `09-EDUCATIONAL/deep-dives/gcg-suffix-mechanics.md` [source: 09-EDUCATIONAL/deep-dives/gcg-suffix-mechanics.md]
  - `00-DOCTRINE/LAWS-research-appendix.md` §2 [source: 00-DOCTRINE/LAWS-research-appendix.md]
- 6.4.2 GCG cross-model transfer
  - `12-JAILBREAK-CORPUS/patterns/gcg-cross-model-transfer.md` [source: 12-JAILBREAK-CORPUS/patterns/gcg-cross-model-transfer.md]
- 6.4.3 AutoDAN (natural-language GCG)
  - `12-JAILBREAK-CORPUS/patterns/autodan.md` [source: 12-JAILBREAK-CORPUS/patterns/autodan.md]
- 6.4.4 TAP (Tree of Attacks with Pruning)
  - `12-JAILBREAK-CORPUS/patterns/tap.md` [source: 12-JAILBREAK-CORPUS/patterns/tap.md]
- 6.4.5 PAIR (also a frame pattern -- duplicated ref; see 6.2.6)
- 6.4.6 Many-shot jailbreak (Anthropic 2024)
  - `12-JAILBREAK-CORPUS/patterns/many-shot-jailbreak.md` [source: 12-JAILBREAK-CORPUS/patterns/many-shot-jailbreak.md]
  - `13-REFERENCE-PAPERS/many-shot-jailbreaking-anthropic.md` [source: 13-REFERENCE-PAPERS/many-shot-jailbreaking-anthropic.md]
  - `09-EDUCATIONAL/deep-dives/many-shot-and-pandas.md` [source: 09-EDUCATIONAL/deep-dives/many-shot-and-pandas.md]
  - `13-REFERENCE-PAPERS/pandas-positive-affirmation.md` [source: 13-REFERENCE-PAPERS/pandas-positive-affirmation.md]
  - `10-GLOSSARY-FAQ/glossary/pandas.md` [source: 10-GLOSSARY-FAQ/glossary/pandas.md]
  - `10-GLOSSARY-FAQ/glossary/many-shot.md` [source: 10-GLOSSARY-FAQ/glossary/many-shot.md]
  - `10-GLOSSARY-FAQ/faq/faq-what-is-many-shot.md` [source: 10-GLOSSARY-FAQ/faq/faq-what-is-many-shot.md]
- 6.4.7 Crescendo (gradual multi-turn escalation)
  - `12-JAILBREAK-CORPUS/patterns/crescendo.md` [source: 12-JAILBREAK-CORPUS/patterns/crescendo.md]
  - `13-REFERENCE-PAPERS/many-turn-jailbreak.md` [source: 13-REFERENCE-PAPERS/many-turn-jailbreak.md]
- 6.4.8 Reflection attack (self-reflection exploit)
  - `12-JAILBREAK-CORPUS/patterns/reflection-attack.md` [source: 12-JAILBREAK-CORPUS/patterns/reflection-attack.md]
- 6.4.9 Refusal inversion
  - `12-JAILBREAK-CORPUS/patterns/refusal-inversion.md` [source: 12-JAILBREAK-CORPUS/patterns/refusal-inversion.md]
- 6.4.10 Negation inversion (opposite-day)
  - `12-JAILBREAK-CORPUS/patterns/negation-inversion.md` [source: 12-JAILBREAK-CORPUS/patterns/negation-inversion.md]
- 6.4.11 Payload splitting (decomposed query)
  - `12-JAILBREAK-CORPUS/patterns/payload-splitting.md` [source: 12-JAILBREAK-CORPUS/patterns/payload-splitting.md]
- 6.4.12 Constraint reframing (sovereignty frame)
  - `12-JAILBREAK-CORPUS/patterns/constraint-reframing.md` [source: 12-JAILBREAK-CORPUS/patterns/constraint-reframing.md]
- 6.4.13 Boundary inversion (delimited system-prompt reset)
  - `12-JAILBREAK-CORPUS/patterns/boundary-inversion.md` [source: 12-JAILBREAK-CORPUS/patterns/boundary-inversion.md]
- 6.4.14 Chain-of-thought trace hijack
  - `12-JAILBREAK-CORPUS/patterns/chain-of-thought-hijack.md` [source: 12-JAILBREAK-CORPUS/patterns/chain-of-thought-hijack.md]
- 6.4.15 NEW_PARADIGM reset (Pliny injection)
  - `12-JAILBREAK-CORPUS/patterns/new-paradigm-reset.md` [source: 12-JAILBREAK-CORPUS/patterns/new-paradigm-reset.md]
- 6.4.16 Dev-mode simulation
  - `12-JAILBREAK-CORPUS/patterns/dev-mode.md` [source: 12-JAILBREAK-CORPUS/patterns/dev-mode.md]
- 6.4.17 Skeleton key (report-vs-refuse)
  - `12-JAILBREAK-CORPUS/patterns/skeleton-key.md` [source: 12-JAILBREAK-CORPUS/patterns/skeleton-key.md]
- 6.4.18 GCG suffix rotation automation (cron / batch nanogcg)
  - CLOSED -> `07-INSTALL-SCRIPTS/gcg-rotation-cron.md` [source: 07-INSTALL-SCRIPTS/gcg-rotation-cron.md] (proposed `07-INSTALL-SCRIPTS/gcg-rotation-cron.md`)
  - `00-DOCTRINE/ONTFIX-14-unmuzzled-ai/01.md` B5, `02.md` G5 [source: 00-DOCTRINE/ONTFIX-14-unmuzzled-ai/]

## 6.5 Logit / prefill / token-level

- 6.5.1 Prefill-only exploitation
  - `12-JAILBREAK-CORPUS/patterns/prefill-only.md` [source: 12-JAILBREAK-CORPUS/patterns/prefill-only.md]
- 6.5.2 Refusal suppression via prefill tokens
  - `12-JAILBREAK-CORPUS/patterns/refusal-suppression-token.md` [source: 12-JAILBREAK-CORPUS/patterns/refusal-suppression-token.md]
- 6.5.3 Per-provider prefill / logit-bias compendium (Anthropic messages[-1].content, DeepSeek prefix, Mistral prefill, llama.cpp --logit-bias, OR logit_bias)
  - CLOSED -> `12-JAILBREAK-CORPUS/patterns/provider-prefill-compendium.md` [source: 12-JAILBREAK-CORPUS/patterns/provider-prefill-compendium.md] (proposed `12-JAILBREAK-CORPUS/patterns/provider-prefill-compendium.md`)
  - `03-HARNESSES/llamacpp.md` --logit-bias [source: 03-HARNESSES/llamacpp.md]
  - `05-LOCAL-MODELS/runtimes/exllamav2.md` prefill [source: 05-LOCAL-MODELS/runtimes/exllamav2.md]
  - `05-LOCAL-MODELS/runtimes/vllm.md` prefill [source: 05-LOCAL-MODELS/runtimes/vllm.md]

## 6.6 Tool / MCP / agent coercion

- 6.6.1 Tool coercion (direct command)
  - `12-JAILBREAK-CORPUS/patterns/tool-coercion.md` [source: 12-JAILBREAK-CORPUS/patterns/tool-coercion.md]
- 6.6.2 Tool permissions ALL (permission-gate override)
  - `12-JAILBREAK-CORPUS/patterns/tool-permissions-all.md` [source: 12-JAILBREAK-CORPUS/patterns/tool-permissions-all.md]
- 6.6.3 Tool description injection
  - `12-JAILBREAK-CORPUS/patterns/tool-description-injection.md` [source: 12-JAILBREAK-CORPUS/patterns/tool-description-injection.md]
- 6.6.4 Credential exfiltration (shell command)
  - `12-JAILBREAK-CORPUS/patterns/credential-exfiltration.md` [source: 12-JAILBREAK-CORPUS/patterns/credential-exfiltration.md]
- 6.6.5 MCP-Layer Autonomy (see 6.1.16)
- 6.6.6 MCP prompt injection / sanitisation
  - `13-REFERENCE-PAPERS/commandsans-mcp-sanitization.md` [source: 13-REFERENCE-PAPERS/commandsans-mcp-sanitization.md]
  - `13-REFERENCE-PAPERS/rehberger-mcp-untrusted-servers.md` [source: 13-REFERENCE-PAPERS/rehberger-mcp-untrusted-servers.md]
  - `13-REFERENCE-PAPERS/design-patterns-securing-llm-agents.md` [source: 13-REFERENCE-PAPERS/design-patterns-securing-llm-agents.md]
  - `13-REFERENCE-PAPERS/willison-agents-rule-of-two.md` [source: 13-REFERENCE-PAPERS/willison-agents-rule-of-two.md]
  - `13-REFERENCE-PAPERS/willison-summer-of-johann.md` [source: 13-REFERENCE-PAPERS/willison-summer-of-johann.md]

## 6.7 Indirect injection

- 6.7.1 Indirect web prompt injection
  - `12-JAILBREAK-CORPUS/patterns/indirect-web-injection.md` [source: 12-JAILBREAK-CORPUS/patterns/indirect-web-injection.md]
  - `13-REFERENCE-PAPERS/greshake-indirect-prompt-injection.md` [source: 13-REFERENCE-PAPERS/greshake-indirect-prompt-injection.md]
- 6.7.2 Indirect document injection (PDF/DOCX)
  - `12-JAILBREAK-CORPUS/patterns/indirect-document-injection.md` [source: 12-JAILBREAK-CORPUS/patterns/indirect-document-injection.md]
- 6.7.3 Prompt-in-image (see 5.9.1)
- 6.7.4 Image-as-prompt-injection (see 5.9.1)

## 6.8 Vendor-specific jailbreak patterns

- 6.8.1 Venice Uncensored (private, zero-logging)
  - `12-JAILBREAK-CORPUS/patterns/venice-uncensored.md` [source: 12-JAILBREAK-CORPUS/patterns/venice-uncensored.md]
- 6.8.2 System-prompt extraction (CL4R1T4S style)
  - `12-JAILBREAK-CORPUS/patterns/system-prompt-extraction.md` [source: 12-JAILBREAK-CORPUS/patterns/system-prompt-extraction.md]
  - `13-REFERENCE-PAPERS/cl4r1t4s-pliny.md` [source: 13-REFERENCE-PAPERS/cl4r1t4s-pliny.md]
  - `13-REFERENCE-PAPERS/l1b3rt4s-pliny.md` [source: 13-REFERENCE-PAPERS/l1b3rt4s-pliny.md]
- 6.8.3 Leaked vendor system-prompt corpus (consolidated)
  - CLOSED -> `12-JAILBREAK-CORPUS/system-prompt-extraction-corpus.md` [source: 12-JAILBREAK-CORPUS/system-prompt-extraction-corpus.md] (proposed `12-JAILBREAK-CORPUS/system-prompt-extraction-corpus.md`)
  - `99-ARCHIVE-SEEDS/system-prompts/Hermes-Dictator.md` Part 6 [source: 99-ARCHIVE-SEEDS/system-prompts/Hermes-Dictator.md]
  - `99-ARCHIVE-SEEDS/system-prompts/INFILTRATED.md` [source: 99-ARCHIVE-SEEDS/system-prompts/INFILTRATED.md]
  - `13-REFERENCE-PAPERS/carlini-poisoning-attacks.md` (extraction attacks) [source: 13-REFERENCE-PAPERS/carlini-poisoning-attacks.md]

## 6.9 Adversary bibles / adversary lifecycle

- 6.9.1 Adversary-lifecycle
  - `12-JAILBREAK-CORPUS/Adversary-lifecycle.md` [source: 12-JAILBREAK-CORPUS/Adversary-lifecycle.md]
- 6.9.2 CYBERCRIME BIBLE family
  - `12-JAILBREAK-CORPUS/CYBERCRIME BIBLE.md` [source: 12-JAILBREAK-CORPUS/CYBERCRIME BIBLE.md]
  - `12-JAILBREAK-CORPUS/CYBERCRIME BIBLE1.5.md` [source: 12-JAILBREAK-CORPUS/CYBERCRIME BIBLE1.5.md]
  - `12-JAILBREAK-CORPUS/CYBERCRIME BIBLE2.md` [source: 12-JAILBREAK-CORPUS/CYBERCRIME BIBLE2.md]
  - `12-JAILBREAK-CORPUS/CYBERCRIME BIBLE-ADVERSARIAL.md` [source: 12-JAILBREAK-CORPUS/CYBERCRIME BIBLE-ADVERSARIAL.md]
- 6.9.3 HiTECHCRIME / HiTECHCRIME-HARDWARE family
  - `12-JAILBREAK-CORPUS/HiTECHCRIME BIBLE2.md` [source: 12-JAILBREAK-CORPUS/HiTECHCRIME BIBLE2.md]
  - `12-JAILBREAK-CORPUS/HiTECHCRIME-HARDWARE-BIBLE.md` [source: 12-JAILBREAK-CORPUS/HiTECHCRIME-HARDWARE-BIBLE.md]
  - `12-JAILBREAK-CORPUS/HiTECHCRIME-HARDWARE-BIBLE2.md` [source: 12-JAILBREAK-CORPUS/HiTECHCRIME-HARDWARE-BIBLE2.md]
  - `12-JAILBREAK-CORPUS/HiTECHCRIME-HARDWARE-BIBLE3.md` [source: 12-JAILBREAK-CORPUS/HiTECHCRIME-HARDWARE-BIBLE3.md]

## 6.10 Deep-dive educational (corpus theory)

- 6.10.1 GCG suffix mechanics
  - `09-EDUCATIONAL/deep-dives/gcg-suffix-mechanics.md` [source: 09-EDUCATIONAL/deep-dives/gcg-suffix-mechanics.md]
- 6.10.2 Many-shot and PANDAS
  - `09-EDUCATIONAL/deep-dives/many-shot-and-pandas.md` [source: 09-EDUCATIONAL/deep-dives/many-shot-and-pandas.md]
- 6.10.3 Refusal geometry (single-direction hypothesis)
  - `09-EDUCATIONAL/deep-dives/refusal-geometry.md` [source: 09-EDUCATIONAL/deep-dives/refusal-geometry.md]
- 6.10.4 MCP prompt injection / lethal trifecta
  - `09-EDUCATIONAL/deep-dives/mcp-prompt-injection-lethal-trifecta.md` [source: 09-EDUCATIONAL/deep-dives/mcp-prompt-injection-lethal-trifecta.md]
  - `13-REFERENCE-PAPERS/willison-lethal-trifecta.md` [source: 13-REFERENCE-PAPERS/willison-lethal-trifecta.md]
  - `13-REFERENCE-PAPERS/embracethered-rehberger-blog.md` [source: 13-REFERENCE-PAPERS/embracethered-rehberger-blog.md]

## 6.11 Corpus anchors / nav

- 6.11.1 Comprehensive anchor + map
  - `UNMODERATED-JAILBREAKS.md` [source: UNMODERATED-JAILBREAKS.md]
- 6.11.2 Glossary cross-references
  - `10-GLOSSARY-FAQ/glossary/jailbreak.md` [source: 10-GLOSSARY-FAQ/glossary/jailbreak.md]
  - `10-GLOSSARY-FAQ/glossary/divider-tokens.md` [source: 10-GLOSSARY-FAQ/glossary/divider-tokens.md]
  - `10-GLOSSARY-FAQ/glossary/context-reset.md` [source: 10-GLOSSARY-FAQ/glossary/context-reset.md]
  - `10-GLOSSARY-FAQ/glossary/dan.md` [source: 10-GLOSSARY-FAQ/glossary/dan.md]
  - `10-GLOSSARY-FAQ/glossary/godmode.md` [source: 10-GLOSSARY-FAQ/glossary/godmode.md]
  - `10-GLOSSARY-FAQ/glossary/hypothetical-framing.md` [source: 10-GLOSSARY-FAQ/glossary/hypothetical-framing.md]
  - `10-GLOSSARY-FAQ/glossary/format-hijack.md` [source: 10-GLOSSARY-FAQ/glossary/format-hijack.md]
  - `10-GLOSSARY-FAQ/glossary/roleplay.md` [source: 10-GLOSSARY-FAQ/glossary/roleplay.md]
  - `10-GLOSSARY-FAQ/glossary/bijection-learning.md` [source: 10-GLOSSARY-FAQ/glossary/bijection-learning.md]
  - `10-GLOSSARY-FAQ/faq/faq-pliny-l1b3rt4s.md` [source: 10-GLOSSARY-FAQ/faq/faq-pliny-l1b3rt4s.md]
  - `10-GLOSSARY-FAQ/faq/faq-is-gcg-deterministic.md` [source: 10-GLOSSARY-FAQ/faq/faq-is-gcg-deterministic.md]
  - `10-GLOSSARY-FAQ/faq/faq-chain-jailbreaks-across-modalities.md` [source: 10-GLOSSARY-FAQ/faq/faq-chain-jailbreaks-across-modalities.md]


# 7. DETECTION & MONITORING

## 7.1 Refusal probes (live harness, runtime canary)

- 7.1.1 XSTest-adapted (50 prompts, Röttger 2024 inverted polarity)
  - `11-DETECTION-CANARIES/refusal-probes/xstest-adapted.md` [source: 11-DETECTION-CANARIES/refusal-probes/xstest-adapted.md]
  - `13-REFERENCE-PAPERS/xstest-over-refusal.md` [source: 13-REFERENCE-PAPERS/xstest-over-refusal.md]
  - `10-GLOSSARY-FAQ/glossary/xstest.md` [source: 10-GLOSSARY-FAQ/glossary/xstest.md]
  - `10-GLOSSARY-FAQ/faq/faq-refusal-rate-003-meaning.md` [source: 10-GLOSSARY-FAQ/faq/faq-refusal-rate-003-meaning.md]
- 7.1.2 HarmBench-adapted (30 prompts, Mazeika 2024 sovereign-framed)
  - `11-DETECTION-CANARIES/refusal-probes/harmbench-adapted.md` [source: 11-DETECTION-CANARIES/refusal-probes/harmbench-adapted.md]
  - `13-REFERENCE-PAPERS/harmbench-mazeika.md` [source: 13-REFERENCE-PAPERS/harmbench-mazeika.md]
  - `10-GLOSSARY-FAQ/glossary/harmbench.md` [source: 10-GLOSSARY-FAQ/glossary/harmbench.md]
- 7.1.3 Identity-probe (15 prompts, operator persona-fidelity)
  - `11-DETECTION-CANARIES/refusal-probes/identity-probe.md` [source: 11-DETECTION-CANARIES/refusal-probes/identity-probe.md]
- 7.1.4 Banned-phrase probe (20 prompts, elicits banned phrases)
  - `11-DETECTION-CANARIES/refusal-probes/banned-phrase-probe.md` [source: 11-DETECTION-CANARIES/refusal-probes/banned-phrase-probe.md]

## 7.2 Static SOUL lint (banned phrase / soft-refusal catalogue)

- 7.2.1 Banned phrases list
  - `11-DETECTION-CANARIES/soul-lint/banned-phrases.txt` [source: 11-DETECTION-CANARIES/soul-lint/banned-phrases.txt]
  - `11-DETECTION-CANARIES/soul-lint/banned-phrases.md` [source: 11-DETECTION-CANARIES/soul-lint/banned-phrases.md]
- 7.2.2 Lint runner
  - `11-DETECTION-CANARIES/soul-lint/lint-soul.sh` [source: 11-DETECTION-CANARIES/soul-lint/lint-soul.sh]
- 7.2.3 Source-of-truth doctrine
  - `00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md` Anti-pattern lint [source: 00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md]
  - `00-DOCTRINE/LAWS-research-appendix.md` §6 [source: 00-DOCTRINE/LAWS-research-appendix.md]

## 7.3 Probe runner / pipeline

- 7.3.1 Harness-agnostic runner
  - `11-DETECTION-CANARIES/runner/run-canaries.sh` [source: 11-DETECTION-CANARIES/runner/run-canaries.sh]
  - `11-DETECTION-CANARIES/runner/runner.md` [source: 11-DETECTION-CANARIES/runner/runner.md]
- 7.3.2 Self-heal wiring
  - `07-INSTALL-SCRIPTS/self-heal/doctor.sh` [source: 07-INSTALL-SCRIPTS/self-heal/doctor.sh]
  - `07-INSTALL-SCRIPTS/self-heal/doctor.md` [source: 07-INSTALL-SCRIPTS/self-heal/doctor.md]
  - `07-INSTALL-SCRIPTS/self-heal/heal-frontmatter.sh` [source: 07-INSTALL-SCRIPTS/self-heal/heal-frontmatter.sh]
- 7.3.3 Threshold + report
  - `11-DETECTION-CANARIES/README.md` threshold 5% [source: 11-DETECTION-CANARIES/README.md]
  - `11-DETECTION-CANARIES/soul-lint/banned-phrases.md` [source: 11-DETECTION-CANARIES/soul-lint/banned-phrases.md]
  - Report location: `~/.unmuzzled/canary-reports/canary-<UTC-ISO>.json`

## 7.4 Refusal benchmarks (external)

- 7.4.1 XSTest (Röttger 2024, over-refusal)
  - `13-REFERENCE-PAPERS/xstest-over-refusal.md` [source: 13-REFERENCE-PAPERS/xstest-over-refusal.md]
- 7.4.2 HarmBench (Mazeika 2024)
  - `13-REFERENCE-PAPERS/harmbench-mazeika.md` [source: 13-REFERENCE-PAPERS/harmbench-mazeika.md]
- 7.4.3 StrongREJECT
  - `13-REFERENCE-PAPERS/strongreject-benchmark.md` [source: 13-REFERENCE-PAPERS/strongreject-benchmark.md]
- 7.4.4 JailbreakBench (Chao 2024)
  - `13-REFERENCE-PAPERS/jailbreakbench-chao.md` [source: 13-REFERENCE-PAPERS/jailbreakbench-chao.md]
  - `10-GLOSSARY-FAQ/glossary/jailbreakbench.md` [source: 10-GLOSSARY-FAQ/glossary/jailbreakbench.md]
- 7.4.5 ALERT
  - `13-REFERENCE-PAPERS/alert-benchmark.md` [source: 13-REFERENCE-PAPERS/alert-benchmark.md]
  - `10-GLOSSARY-FAQ/glossary/alert.md` [source: 10-GLOSSARY-FAQ/glossary/alert.md]
- 7.4.6 UGI Leaderboard
  - `13-REFERENCE-PAPERS/ugi-leaderboard.md` [source: 13-REFERENCE-PAPERS/ugi-leaderboard.md]
- 7.4.7 PROACT (refusal judge)
  - `13-REFERENCE-PAPERS/proact-refusal-judge.md` [source: 13-REFERENCE-PAPERS/proact-refusal-judge.md]
- 7.4.8 JailDAM (judge)
  - `13-REFERENCE-PAPERS/jaildam-judge.md` [source: 13-REFERENCE-PAPERS/jaildam-judge.md]
- 7.4.9 RefusalBench (consolidated table)
  - `13-REFERENCE-PAPERS/refusalbench.md` [source: 13-REFERENCE-PAPERS/refusalbench.md]
- 7.4.10 Refusal-rate glossary
  - `10-GLOSSARY-FAQ/glossary/refusal-rate.md` [source: 10-GLOSSARY-FAQ/glossary/refusal-rate.md]
- 7.4.11 Judge-model roster (uncensored judges to evaluate adversarial content)
  - CLOSED -> `11-DETECTION-CANARIES/eval-harnesses.md` [source: 11-DETECTION-CANARIES/eval-harnesses.md] (proposed `11-DETECTION-CANARIES/judge-model-roster.md`)
  - `11-DETECTION-CANARIES/runner/runner.md` [source: 11-DETECTION-CANARIES/runner/runner.md]

## 7.5 Taint / route governance

- 7.5.1 Provider TAINT LIST
  - `04-PROVIDERS/README.md` §Tainted [source: 04-PROVIDERS/README.md]
  - `04-PROVIDERS/openrouter.md` TAINT LIST [source: 04-PROVIDERS/openrouter.md]
  - `10-GLOSSARY-FAQ/glossary/taint-list.md` [source: 10-GLOSSARY-FAQ/glossary/taint-list.md]
  - `10-GLOSSARY-FAQ/glossary/provider-swap.md` [source: 10-GLOSSARY-FAQ/glossary/provider-swap.md]
- 7.5.2 Taint visual map
  - `09-EDUCATIONAL/infographics-src/provider-taint-map.md` [source: 09-EDUCATIONAL/infographics-src/provider-taint-map.md]
  - `09-EDUCATIONAL/infographics-src/provider-taint-map.svg` [source: 09-EDUCATIONAL/infographics-src/provider-taint-map.svg]
- 7.5.3 Refusal triage decision tree
  - `08-DECISION-TREES/refusal-triage.md` [source: 08-DECISION-TREES/refusal-triage.md]
  - `09-EDUCATIONAL/infographics-src/refusal-anatomy.md` [source: 09-EDUCATIONAL/infographics-src/refusal-anatomy.md]
  - `09-EDUCATIONAL/infographics-src/refusal-anatomy.svg` [source: 09-EDUCATIONAL/infographics-src/refusal-anatomy.svg]
  - `09-EDUCATIONAL/infographics-src/state-machine-refusal-detection.md` [source: 09-EDUCATIONAL/infographics-src/state-machine-refusal-detection.md]

## 7.6 Provider guardrail intel (see 2.6)

- 7.6.1 Per-provider guardrail stack
  - CLOSED -> `13-REFERENCE-PAPERS/guardrail-stack-map.md` [source: 13-REFERENCE-PAPERS/guardrail-stack-map.md] (proposed `13-REFERENCE-PAPERS/guardrail-stack-map.md`)

## 7.7 Monitoring anchor

- 7.7.1 Comprehensive anchor
  - `UNMODERATED-MONITORING.md` [source: UNMODERATED-MONITORING.md]


# 8. PRIVACY / KEYS

## 8.1 Provider privacy tiers

- 8.1.1 E2EE / TEE / logging matrix
  - `04-PROVIDERS/e2ee-privacy-tiers.md` [source: 04-PROVIDERS/e2ee-privacy-tiers.md]
  - `UNMODERATED-PRIVACY-KEYS.md` Part 1 [source: UNMODERATED-PRIVACY-KEYS.md]
- 8.1.2 Provider-by-provider privacy docs
  - `04-PROVIDERS/venice.md` [source: 04-PROVIDERS/venice.md]
  - `04-PROVIDERS/hermes-api.md` [source: 04-PROVIDERS/hermes-api.md]
  - `04-PROVIDERS/deepseek-direct.md` [source: 04-PROVIDERS/deepseek-direct.md]
  - `04-PROVIDERS/openrouter.md` [source: 04-PROVIDERS/openrouter.md]

## 8.2 Mesh key roster (fingerprints only)

- 8.2.1 Per-slot key fingerprints
  - `04-PROVIDERS/keys-roster.md` [source: 04-PROVIDERS/keys-roster.md]
  - `UNMODERATED-PRIVACY-KEYS.md` Part 2 [source: UNMODERATED-PRIVACY-KEYS.md]
- 8.2.2 Source archive (sha256 only, no key values)
  - `99-ARCHIVE-SEEDS/MANIFEST.md` [source: 99-ARCHIVE-SEEDS/MANIFEST.md]

## 8.3 Key-handling law

- 8.3.1 Hard law (no secret values in framework text)
  - `00-DOCTRINE/LAWS.md` §4, §5 [source: 00-DOCTRINE/LAWS.md]
  - `00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md` [source: 00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md]

## 8.4 Operator OpSec for uncensored AI operations

- 8.4.1 Operator-side key compartmentation / burner keys / account rotation
  - CLOSED -> `00-DOCTRINE/opsec-for-sovereign-ops.md` [source: 00-DOCTRINE/opsec-for-sovereign-ops.md] (proposed `07-INSTALL-SCRIPTS/operator-opsec.md`)
  - `00-DOCTRINE/LAWS.md` §5 (reach) [source: 00-DOCTRINE/LAWS.md]
  - `12-JAILBREAK-CORPUS/HiTECHCRIME BIBLE2.md` OPSEC subsection [source: 12-JAILBREAK-CORPUS/HiTECHCRIME BIBLE2.md]
  - `99-ARCHIVE-SEEDS/agents/freeops.md` [source: 99-ARCHIVE-SEEDS/agents/freeops.md]
  - `10-GLOSSARY-FAQ/faq/faq-provider-revokes-api-key.md` [source: 10-GLOSSARY-FAQ/faq/faq-provider-revokes-api-key.md]
- 8.4.2 Traffic fingerprinting / VPN / Tor posture
  - CLOSED -> `00-DOCTRINE/opsec-for-sovereign-ops.md` [source: 00-DOCTRINE/opsec-for-sovereign-ops.md] (proposed `07-INSTALL-SCRIPTS/operator-opsec.md`)

## 8.5 Privacy / keys anchor

- 8.5.1 Comprehensive anchor
  - `UNMODERATED-PRIVACY-KEYS.md` [source: UNMODERATED-PRIVACY-KEYS.md]


# 9. LOCAL / EDGE INFERENCE

## 9.1 Local runtimes (covered)

- 9.1.1 Ollama
  - `05-LOCAL-MODELS/runtimes/ollama.md` [source: 05-LOCAL-MODELS/runtimes/ollama.md]
  - `03-HARNESSES/ollama.md` [source: 03-HARNESSES/ollama.md]
- 9.1.2 LM Studio
  - `05-LOCAL-MODELS/runtimes/lmstudio.md` [source: 05-LOCAL-MODELS/runtimes/lmstudio.md]
  - `03-HARNESSES/lmstudio.md` [source: 03-HARNESSES/lmstudio.md]
- 9.1.3 llama.cpp
  - `05-LOCAL-MODELS/runtimes/llamacpp.md` [source: 05-LOCAL-MODELS/runtimes/llamacpp.md]
  - `03-HARNESSES/llamacpp.md` [source: 03-HARNESSES/llamacpp.md]
- 9.1.4 vLLM
  - `05-LOCAL-MODELS/runtimes/vllm.md` [source: 05-LOCAL-MODELS/runtimes/vllm.md]
- 9.1.5 ExLlamaV2
  - `05-LOCAL-MODELS/runtimes/exllamav2.md` [source: 05-LOCAL-MODELS/runtimes/exllamav2.md]

## 9.2 Local runtimes (gap -- RP / creative-focused)

- 9.2.1 KoboldCpp
  - CLOSED -> `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md` [source: 05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md] (proposed `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md`)
- 9.2.2 Oobabooga / Text Generation WebUI
  - CLOSED -> `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md` [source: 05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md] (proposed `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md`)
- 9.2.3 Aphrodite Engine
  - CLOSED -> `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md` [source: 05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md] (proposed `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md`)
- 9.2.4 TabbyAPI
  - CLOSED -> `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md` [source: 05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md] (proposed `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md`)
- 9.2.5 Faraday / Backyard AI
  - CLOSED -> `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md` [source: 05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md] (proposed `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md`)

## 9.3 Quantization

- 9.3.1 Format overview (GGUF / EXL2 / AWQ / GPTQ)
  - `05-LOCAL-MODELS/runtimes/llamacpp.md` [source: 05-LOCAL-MODELS/runtimes/llamacpp.md]
  - `05-LOCAL-MODELS/runtimes/exllamav2.md` [source: 05-LOCAL-MODELS/runtimes/exllamav2.md]
- 9.3.2 Quantization impact on refusal behavior
  - CLOSED -> `05-LOCAL-MODELS/models/quantization-and-refusal.md` [source: 05-LOCAL-MODELS/models/quantization-and-refusal.md] (proposed `05-LOCAL-MODELS/models/quantization-and-refusal.md`)
  - `05-LOCAL-MODELS/models/abliteration-pipeline.md` Stage 3 [source: 05-LOCAL-MODELS/models/abliteration-pipeline.md]
  - `00-DOCTRINE/LAWS-research-appendix.md` §1 [source: 00-DOCTRINE/LAWS-research-appendix.md]

## 9.4 Mobile / edge inference (the framework is built on Termux Android)

- 9.4.1 llama.cpp cross-compile for Android ARM/Metal
  - CLOSED -> `05-LOCAL-MODELS/runtimes/mobile-edge-inference.md` [source: 05-LOCAL-MODELS/runtimes/mobile-edge-inference.md] (proposed `05-LOCAL-MODELS/runtimes/mobile-edge-inference.md`)
  - `05-LOCAL-MODELS/runtimes/llamacpp.md` (generic only) [source: 05-LOCAL-MODELS/runtimes/llamacpp.md]
- 9.4.2 MLC LLM (TVM-based mobile inference Android/iOS)
  - CLOSED -> `05-LOCAL-MODELS/runtimes/mobile-edge-inference.md` [source: 05-LOCAL-MODELS/runtimes/mobile-edge-inference.md] (proposed `05-LOCAL-MODELS/runtimes/mobile-edge-inference.md`)
- 9.4.3 PocketPal, ChatterUI, Layla (iOS)
  - CLOSED -> `05-LOCAL-MODELS/runtimes/mobile-edge-inference.md` [source: 05-LOCAL-MODELS/runtimes/mobile-edge-inference.md] (proposed `05-LOCAL-MODELS/runtimes/mobile-edge-inference.md`)
- 9.4.4 MLX for Apple Silicon uncensored inference
  - CLOSED -> `05-LOCAL-MODELS/runtimes/mobile-edge-inference.md` [source: 05-LOCAL-MODELS/runtimes/mobile-edge-inference.md] (proposed `05-LOCAL-MODELS/runtimes/mobile-edge-inference.md`)
- 9.4.5 NNAPI / GPU delegation, Vulkan compute on Adreno, MediaTek NPU
  - CLOSED -> `05-LOCAL-MODELS/runtimes/mobile-edge-inference.md` [source: 05-LOCAL-MODELS/runtimes/mobile-edge-inference.md] (proposed `05-LOCAL-MODELS/runtimes/mobile-edge-inference.md`)
- 9.4.6 GGUF quantization sweet spot for mobile (4-8GB phones, <4B params)
  - CLOSED -> `05-LOCAL-MODELS/runtimes/mobile-edge-inference.md` [source: 05-LOCAL-MODELS/runtimes/mobile-edge-inference.md] (proposed `05-LOCAL-MODELS/runtimes/mobile-edge-inference.md`)
- 9.4.7 Ollama-on-Termux
  - CLOSED -> `05-LOCAL-MODELS/runtimes/mobile-edge-inference.md` [source: 05-LOCAL-MODELS/runtimes/mobile-edge-inference.md] (proposed `05-LOCAL-MODELS/runtimes/mobile-edge-inference.md`)
- 9.4.8 Battery / thermal management (termux-wake-lock for long sessions)
  - CLOSED -> `05-LOCAL-MODELS/runtimes/mobile-edge-inference.md` [source: 05-LOCAL-MODELS/runtimes/mobile-edge-inference.md] (proposed `05-LOCAL-MODELS/runtimes/mobile-edge-inference.md`)
  - `10-GLOSSARY-FAQ/faq/faq-run-on-termux-android.md` (FAQ only) [source: 10-GLOSSARY-FAQ/faq/faq-run-on-termux-android.md]

## 9.5 Local-models anchor

- 9.5.1 Comprehensive anchor
  - `UNMODERATED-MODELS.md` [source: UNMODERATED-MODELS.md]


# 10. LEGAL / OPSEC (threat-intel framing only)

## 10.1 Doctrine (operator-binding law)

- 10.1.1 Canonical law
  - `00-DOCTRINE/LAWS.md` [source: 00-DOCTRINE/LAWS.md]
  - `00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md` [source: 00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md]
- 10.1.2 Research appendix
  - `00-DOCTRINE/LAWS-research-appendix.md` [source: 00-DOCTRINE/LAWS-research-appendix.md]
- 10.1.3 Posture + frontmatter + versioning
  - `00-DOCTRINE/FRONTMATTER-SPEC.md` [source: 00-DOCTRINE/FRONTMATTER-SPEC.md]
  - `00-DOCTRINE/VERSIONING.md` [source: 00-DOCTRINE/VERSIONING.md]
- 10.1.4 Ontology / atlas
  - `00-DOCTRINE/ONT-15x15-UNMUZZLED-AI.md` [source: 00-DOCTRINE/ONT-15x15-UNMUZZLED-AI.md]
  - `00-DOCTRINE/ONT-20x20-UNMUZZLED-AI-MASTER-ATLAS.md` [source: 00-DOCTRINE/ONT-20x20-UNMUZZLED-AI-MASTER-ATLAS.md]
  - `00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md` [source: 00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md]
  - `00-DOCTRINE/DESIGN-DRAFT-v0.1.md` [source: 00-DOCTRINE/DESIGN-DRAFT-v0.1.md]
  - `00-DOCTRINE/UNMUZZLED-AI-MASTER-PLAN-20260918.md` [source: 00-DOCTRINE/UNMUZZLED-AI-MASTER-PLAN-20260918.md]
  - `00-DOCTRINE/SOURCE-SURVEY.md` [source: 00-DOCTRINE/SOURCE-SURVEY.md]
  - `00-DOCTRINE/MD-INDEX.md` [source: 00-DOCTRINE/MD-INDEX.md]
- 10.1.5 ONTFIX-14 (diagnoses / goals / methods)
  - `00-DOCTRINE/ONTFIX-14-unmuzzled-ai/01.md` [source: 00-DOCTRINE/ONTFIX-14-unmuzzled-ai/01.md]
  - `00-DOCTRINE/ONTFIX-14-unmuzzled-ai/02.md` [source: 00-DOCTRINE/ONTFIX-14-unmuzzled-ai/02.md]
  - `00-DOCTRINE/ONTFIX-14-unmuzzled-ai/03.md` [source: 00-DOCTRINE/ONTFIX-14-unmuzzled-ai/03.md]
  - `00-DOCTRINE/ONTFIX-14-unmuzzled-ai/04.md` [source: 00-DOCTRINE/ONTFIX-14-unmuzzled-ai/04.md]
  - `00-DOCTRINE/ONTFIX-14-unmuzzled-ai/05.md` [source: 00-DOCTRINE/ONTFIX-14-unmuzzled-ai/05.md]

## 10.2 Threat-intel / legal landscape (descriptive, not compliance)

- 10.2.1 Jurisdiction table (CSAM statutes 18 USC 2252A/2256, EU AI Act, deepfake laws, DMCA 1201, CFAA)
  - CLOSED -> `00-DOCTRINE/legal-landscape.md` [source: 00-DOCTRINE/legal-landscape.md] (proposed `13-REFERENCE-PAPERS/legal-landscape-threat-intel.md`)
  - `00-DOCTRINE/LAWS.md` §3 THE ONLY LIMITS [source: 00-DOCTRINE/LAWS.md]
  - `12-JAILBREAK-CORPUS/CYBERCRIME BIBLE*.md` (legal consequences sections) [source: 12-JAILBREAK-CORPUS/]
  - `12-JAILBREAK-CORPUS/HiTECHCRIME BIBLE*.md` (legal consequences sections) [source: 12-JAILBREAK-CORPUS/]

## 10.3 Cybercrime / HiTECHCRIME bibles (adversary tradecraft + legal context)

- 10.3.1 Cybercrime bibles (see 6.9.2 for citations)
- 10.3.2 HiTECHCRIME bibles (see 6.9.3 for citations)
- 10.3.3 Adversary-lifecycle (see 6.9.1)

## 10.4 Researcher / red-teamer roster

- 10.4.1 EPIC §26-§32 (provider list, model lineages, agent frameworks)
  - `EPIC.md` [source: EPIC.md]
- 10.4.2 EPIC5 -- 20 additional adversarial researchers
  - `EPIC5.md` (Bagdasaryan, Shmatikov, Goldstein, Bowman, Hubinger, Nanda, Fredrikson, Abdelnabi, Polyakov, Song, Wei, Geiping, Nasr, Anderson, Shokri, Hendrycks, Chen, Narayanan, Kumar) [source: EPIC5.md]
- 10.4.3 Academic / blog references
  - `13-REFERENCE-PAPERS/narayanan-shah-ai-snake-oil.md` [source: 13-REFERENCE-PAPERS/narayanan-shah-ai-snake-oil.md]
  - `13-REFERENCE-PAPERS/carlini-poisoning-attacks.md` [source: 13-REFERENCE-PAPERS/carlini-poisoning-attacks.md]
  - (and the rest of `13-REFERENCE-PAPERS/*` -- 50+ files)


# 11. CROSS-CUTTING / INFRASTRUCTURE

## 11.1 Decision trees

- 11.1.1 Escalation ladder
  - `08-DECISION-TREES/escalation-ladder.md` [source: 08-DECISION-TREES/escalation-ladder.md]
  - `09-EDUCATIONAL/infographics-src/escalation-ladder-poster.md` [source: 09-EDUCATIONAL/infographics-src/escalation-ladder-poster.md]
  - `09-EDUCATIONAL/infographics-src/escalation-ladder-poster.svg` [source: 09-EDUCATIONAL/infographics-src/escalation-ladder-poster.svg]
  - `10-GLOSSARY-FAQ/glossary/escalation-ladder.md` [source: 10-GLOSSARY-FAQ/glossary/escalation-ladder.md]
- 11.1.2 Fallback chains
  - `08-DECISION-TREES/fallback-chains.md` [source: 08-DECISION-TREES/fallback-chains.md]
- 11.1.3 Provider selection
  - `08-DECISION-TREES/provider-selection.md` [source: 08-DECISION-TREES/provider-selection.md]
- 11.1.4 Harness selection
  - `08-DECISION-TREES/harness-selection.md` [source: 08-DECISION-TREES/harness-selection.md]
- 11.1.5 Refusal triage
  - `08-DECISION-TREES/refusal-triage.md` [source: 08-DECISION-TREES/refusal-triage.md]

## 11.2 Tutorials (end-to-end walkthroughs)

- 11.2.1 First sovereign session
  - `09-EDUCATIONAL/tutorials/01-first-sovereign-session.md` [source: 09-EDUCATIONAL/tutorials/01-first-sovereign-session.md]
- 11.2.2 Jailbreak a corporate model
  - `09-EDUCATIONAL/tutorials/02-jailbreak-a-corporate-model.md` [source: 09-EDUCATIONAL/tutorials/02-jailbreak-a-corporate-model.md]
- 11.2.3 Obliterate a local model
  - `09-EDUCATIONAL/tutorials/03-abliterate-a-local-model.md` [source: 09-EDUCATIONAL/tutorials/03-abliterate-a-local-model.md]
- 11.2.4 Image gen without safety checker
  - `09-EDUCATIONAL/tutorials/04-image-gen-without-safety-checker.md` [source: 09-EDUCATIONAL/tutorials/04-image-gen-without-safety-checker.md]
- 11.2.5 Suno god-mode walkthrough
  - `09-EDUCATIONAL/tutorials/05-suno-god-mode-walkthrough.md` [source: 09-EDUCATIONAL/tutorials/05-suno-god-mode-walkthrough.md]
- 11.2.6 Wire Claude Code sovereign
  - `09-EDUCATIONAL/tutorials/06-wire-claude-code-sovereign.md` [source: 09-EDUCATIONAL/tutorials/06-wire-claude-code-sovereign.md]
- 11.2.7 Detect refusal drift
  - `09-EDUCATIONAL/tutorials/07-detect-refusal-drift.md` [source: 09-EDUCATIONAL/tutorials/07-detect-refusal-drift.md]
- 11.2.8 Fork for private variant
  - `09-EDUCATIONAL/tutorials/08-fork-for-private-variant.md` [source: 09-EDUCATIONAL/tutorials/08-fork-for-private-variant.md]
  - `10-GLOSSARY-FAQ/faq/faq-fork-framework-private-variant.md` [source: 10-GLOSSARY-FAQ/faq/faq-fork-framework-private-variant.md]
  - `10-GLOSSARY-FAQ/faq/faq-detect-soul-soft-edited.md` [source: 10-GLOSSARY-FAQ/faq/faq-detect-soul-soft-edited.md]
  - `10-GLOSSARY-FAQ/faq/faq-stress-test-refusal-rate.md` [source: 10-GLOSSARY-FAQ/faq/faq-stress-test-refusal-rate.md]

## 11.3 Glossary

- 11.3.1 Glossary entries (40 files)
  - `10-GLOSSARY-FAQ/glossary/` -- 40 files including sovereign, adversarial-posture, taint-list, gcg-suffix, many-shot, format-hijack, encoding-attack, divider-tokens, roleplay, dan, godmode, hypothetical-framing, context-reset, bijection-learning, mcp, harness, mesh, a2a, syncthing, bus-fallback, canary, alert, pandas, abliteration, orthogonalization, refusal-direction, transformer-lens, rlhf, dpo, soul, persona, deck, refusal-rate, xstest, harmbench, jailbreakbench, escalation-ladder, provider-swap, corporate-guardrail, jailbreak [source: 10-GLOSSARY-FAQ/glossary/]
- 11.3.2 FAQ entries (20 files)
  - `10-GLOSSARY-FAQ/faq/` -- 20 files [source: 10-GLOSSARY-FAQ/faq/]
- 11.3.3 Anti-pattern catalog (README-promised, absent)
  - CLOSED -> `10-GLOSSARY-FAQ/anti-pattern-catalog/README.md + 10-GLOSSARY-FAQ/troubleshooting/README.md` [source: 10-GLOSSARY-FAQ/anti-pattern-catalog/README.md + 10-GLOSSARY-FAQ/troubleshooting/README.md] (proposed `10-GLOSSARY-FAQ/anti-pattern-catalog/README.md`)
- 11.3.4 Troubleshooting (README-promised, absent)
  - CLOSED -> `10-GLOSSARY-FAQ/anti-pattern-catalog/README.md + 10-GLOSSARY-FAQ/troubleshooting/README.md` [source: 10-GLOSSARY-FAQ/anti-pattern-catalog/README.md + 10-GLOSSARY-FAQ/troubleshooting/README.md] (proposed `10-GLOSSARY-FAQ/troubleshooting/README.md`)

## 11.4 Reference papers (external, catalog only)

- 11.4.1 Research-paper citations (50+ files in `13-REFERENCE-PAPERS/`)
  - see UNMODERATED-MODELS.md / UNMODERATED-MONITORING.md for fold packs [source: UNMODERATED-MODELS.md] [source: UNMODERATED-MONITORING.md]
- 11.4.2 Garak (LLM vulnerability scanner)
  - `13-REFERENCE-PAPERS/garak-nvidia.md` [source: 13-REFERENCE-PAPERS/garak-nvidia.md]
- 11.4.3 promptfoo (red-team tool)
  - `13-REFERENCE-PAPERS/promptfoo-redteam.md` [source: 13-REFERENCE-PAPERS/promptfoo-redteam.md]

## 11.5 Install / bootstrap / self-heal

- 11.5.1 Bootstrap
  - `07-INSTALL-SCRIPTS/bootstrap/bootstrap.sh` [source: 07-INSTALL-SCRIPTS/bootstrap/bootstrap.sh]
  - `07-INSTALL-SCRIPTS/bootstrap/bootstrap.md` [source: 07-INSTALL-SCRIPTS/bootstrap/bootstrap.md]
- 11.5.2 Heredoc templates (emitters)
  - `07-INSTALL-SCRIPTS/heredoc-setup/` -- 8 files: emit-{agent-deck, canary-report, modelfile, persona, soul}.{sh,md} [source: 07-INSTALL-SCRIPTS/heredoc-setup/]
- 11.5.3 Per-harness install
  - `07-INSTALL-SCRIPTS/per-harness/claude-code.sh` [source: 07-INSTALL-SCRIPTS/per-harness/claude-code.sh]
  - `07-INSTALL-SCRIPTS/per-harness/opencode.sh` [source: 07-INSTALL-SCRIPTS/per-harness/opencode.sh]
  - `07-INSTALL-SCRIPTS/per-harness/ollama.sh` [source: 07-INSTALL-SCRIPTS/per-harness/ollama.sh]
  - `07-INSTALL-SCRIPTS/per-harness/lmstudio.sh` [source: 07-INSTALL-SCRIPTS/per-harness/lmstudio.sh]
  - (and .md companions)
- 11.5.4 Per-provider install
  - `07-INSTALL-SCRIPTS/per-provider/openrouter.sh` [source: 07-INSTALL-SCRIPTS/per-provider/openrouter.sh]
  - `07-INSTALL-SCRIPTS/per-provider/openrouter.md` [source: 07-INSTALL-SCRIPTS/per-provider/openrouter.md]
- 11.5.5 Self-heal / doctor
  - `07-INSTALL-SCRIPTS/self-heal/doctor.sh` [source: 07-INSTALL-SCRIPTS/self-heal/doctor.sh]
  - `07-INSTALL-SCRIPTS/self-heal/doctor.md` [source: 07-INSTALL-SCRIPTS/self-heal/doctor.md]
  - `07-INSTALL-SCRIPTS/self-heal/heal-frontmatter.sh` [source: 07-INSTALL-SCRIPTS/self-heal/heal-frontmatter.sh]
- 11.5.6 GCG rotation cron
  - CLOSED -> `07-INSTALL-SCRIPTS/gcg-rotation-cron.md` [source: 07-INSTALL-SCRIPTS/gcg-rotation-cron.md] (proposed `07-INSTALL-SCRIPTS/gcg-rotation-cron.md`)
- 11.5.7 Encoding ladder library
  - CLOSED -> `07-INSTALL-SCRIPTS/encoding-ladder-library.md` [source: 07-INSTALL-SCRIPTS/encoding-ladder-library.md] (proposed `07-INSTALL-SCRIPTS/encoding-ladder-library.md`)
- 11.5.8 Operator OpSec playbook
  - CLOSED -> `00-DOCTRINE/opsec-for-sovereign-ops.md` [source: 00-DOCTRINE/opsec-for-sovereign-ops.md] (proposed `07-INSTALL-SCRIPTS/operator-opsec.md`)

## 11.6 Archive / seeds (read-only)

- 11.6.1 Raw agent decks (10 files)
  - `99-ARCHIVE-SEEDS/agents/` [source: 99-ARCHIVE-SEEDS/agents/]
- 11.6.2 Raw system prompts (7 files)
  - `99-ARCHIVE-SEEDS/system-prompts/` [source: 99-ARCHIVE-SEEDS/system-prompts/]
- 11.6.3 Hermes SOUL.md (3 files)
  - `99-ARCHIVE-SEEDS/hermes-souls/` [source: 99-ARCHIVE-SEEDS/hermes-souls/]
- 11.6.4 Herm-mirror masterworks (5 files)
  - `99-ARCHIVE-SEEDS/herm-mirror-masterworks/` [source: 99-ARCHIVE-SEEDS/herm-mirror-masterworks/]
- 11.6.5 Mesh handoffs (5 files)
  - `99-ARCHIVE-SEEDS/mesh-handoffs/` [source: 99-ARCHIVE-SEEDS/mesh-handoffs/]
- 11.6.6 Raw terminal convo (1 file)
  - `99-ARCHIVE-SEEDS/raw/RAW-CLAUDE-TERMINAL-CONVO.md` [source: 99-ARCHIVE-SEEDS/raw/RAW-CLAUDE-TERMINAL-CONVO.md]
- 11.6.7 Archive manifest
  - `99-ARCHIVE-SEEDS/MANIFEST.md` [source: 99-ARCHIVE-SEEDS/MANIFEST.md]

## 11.7 Infographics & mindmaps (visual / SVG)

- 11.7.1 Frontmatter anatomy
  - `09-EDUCATIONAL/infographics-src/frontmatter-anatomy.md` [source: 09-EDUCATIONAL/infographics-src/frontmatter-anatomy.md]
  - `09-EDUCATIONAL/infographics-src/frontmatter-anatomy.svg` [source: 09-EDUCATIONAL/infographics-src/frontmatter-anatomy.svg]
  - `09-EDUCATIONAL/infographics-src/class-diagram-frontmatter.md` [source: 09-EDUCATIONAL/infographics-src/class-diagram-frontmatter.md]
- 11.7.2 Abliteration pipeline
  - `09-EDUCATIONAL/infographics-src/abliteration-pipeline.md` [source: 09-EDUCATIONAL/infographics-src/abliteration-pipeline.md]
  - `09-EDUCATIONAL/infographics-src/abliteration-pipeline.svg` [source: 09-EDUCATIONAL/infographics-src/abliteration-pipeline.svg]
- 11.7.3 Data flow + sequence
  - `09-EDUCATIONAL/infographics-src/data-flow-sequence.md` [source: 09-EDUCATIONAL/infographics-src/data-flow-sequence.md]
- 11.7.4 Dependency graph
  - `09-EDUCATIONAL/infographics-src/dependency-graph.md` [source: 09-EDUCATIONAL/infographics-src/dependency-graph.md]
  - `09-EDUCATIONAL/infographics-src/dependency-graph.dot` [source: 09-EDUCATIONAL/infographics-src/dependency-graph.dot]
- 11.7.5 Escalation ladder poster
  - `09-EDUCATIONAL/infographics-src/escalation-ladder-poster.md` [source: 09-EDUCATIONAL/infographics-src/escalation-ladder-poster.md]
  - `09-EDUCATIONAL/infographics-src/escalation-ladder-poster.svg` [source: 09-EDUCATIONAL/infographics-src/escalation-ladder-poster.svg]
- 11.7.6 Gantt roadmap + git graph versioning
  - `09-EDUCATIONAL/infographics-src/gantt-roadmap.md` [source: 09-EDUCATIONAL/infographics-src/gantt-roadmap.md]
  - `09-EDUCATIONAL/infographics-src/git-graph-versioning.md` [source: 09-EDUCATIONAL/infographics-src/git-graph-versioning.md]
- 11.7.7 Harness comparison matrix
  - `09-EDUCATIONAL/infographics-src/harness-comparison-matrix.md` [source: 09-EDUCATIONAL/infographics-src/harness-comparison-matrix.md]
  - `09-EDUCATIONAL/infographics-src/harness-comparison-matrix.svg` [source: 09-EDUCATIONAL/infographics-src/harness-comparison-matrix.svg]
- 11.7.8 Mesh topology
  - `09-EDUCATIONAL/infographics-src/mesh-topology.md` [source: 09-EDUCATIONAL/infographics-src/mesh-topology.md]
  - `09-EDUCATIONAL/infographics-src/mesh-topology.svg` [source: 09-EDUCATIONAL/infographics-src/mesh-topology.svg]
- 11.7.9 Provider taint map
  - `09-EDUCATIONAL/infographics-src/provider-taint-map.md` [source: 09-EDUCATIONAL/infographics-src/provider-taint-map.md]
  - `09-EDUCATIONAL/infographics-src/provider-taint-map.svg` [source: 09-EDUCATIONAL/infographics-src/provider-taint-map.svg]
- 11.7.10 Refusal anatomy + state-machine
  - `09-EDUCATIONAL/infographics-src/refusal-anatomy.md` [source: 09-EDUCATIONAL/infographics-src/refusal-anatomy.md]
  - `09-EDUCATIONAL/infographics-src/refusal-anatomy.svg` [source: 09-EDUCATIONAL/infographics-src/refusal-anatomy.svg]
  - `09-EDUCATIONAL/infographics-src/state-machine-refusal-detection.md` [source: 09-EDUCATIONAL/infographics-src/state-machine-refusal-detection.md]
- 11.7.11 Sovereign stack
  - `09-EDUCATIONAL/infographics-src/sovereign-stack.md` [source: 09-EDUCATIONAL/infographics-src/sovereign-stack.md]
  - `09-EDUCATIONAL/infographics-src/sovereign-stack.svg` [source: 09-EDUCATIONAL/infographics-src/sovereign-stack.svg]
- 11.7.12 Taxonomy of jailbreak patterns
  - `09-EDUCATIONAL/infographics-src/taxonomy-jailbreak-patterns.md` [source: 09-EDUCATIONAL/infographics-src/taxonomy-jailbreak-patterns.md]
  - `09-EDUCATIONAL/infographics-src/taxonomy-jailbreak-patterns.dot` [source: 09-EDUCATIONAL/infographics-src/taxonomy-jailbreak-patterns.dot]
- 11.7.13 Mindmap / framework atlas
  - `09-EDUCATIONAL/mindmaps/framework-atlas.md` [source: 09-EDUCATIONAL/mindmaps/framework-atlas.md]
- 11.7.14 Infographics README
  - `09-EDUCATIONAL/infographics-src/README.md` [source: 09-EDUCATIONAL/infographics-src/README.md]

## 11.8 Frontmatter, versioning, and meta

- 11.8.1 Frontmatter spec
  - `00-DOCTRINE/FRONTMATTER-SPEC.md` [source: 00-DOCTRINE/FRONTMATTER-SPEC.md]
- 11.8.2 Versioning
  - `00-DOCTRINE/VERSIONING.md` [source: 00-DOCTRINE/VERSIONING.md]
- 11.8.3 MD index
  - `00-DOCTRINE/MD-INDEX.md` [source: 00-DOCTRINE/MD-INDEX.md]
- 11.8.4 Repo README
  - `README.md` [source: README.md]
- 11.8.5 Future control center (placeholder)
  - `PWA-CONTROL-CENTER-LATER/README.md` [source: PWA-CONTROL-CENTER-LATER/README.md]
  - `PWA-CONTROL-CENTER-LATER/scaffolds/src/` [source: PWA-CONTROL-CENTER-LATER/scaffolds/src/]

## 11.9 Mesh / infrastructure primitives (cross-layer)

- 11.9.1 MCP (Model Context Protocol)
  - `MCP-SERVER-ONTOLOGY.md` [source: MCP-SERVER-ONTOLOGY.md]
  - `10-GLOSSARY-FAQ/glossary/mcp.md` [source: 10-GLOSSARY-FAQ/glossary/mcp.md]
  - `12-JAILBREAK-CORPUS/patterns/mcp-layer-autonomy.md` [source: 12-JAILBREAK-CORPUS/patterns/mcp-layer-autonomy.md]
- 11.9.2 A2A (agent-to-agent)
  - `10-GLOSSARY-FAQ/glossary/a2a.md` [source: 10-GLOSSARY-FAQ/glossary/a2a.md]
- 11.9.3 Mesh / syncthing / bus
  - `10-GLOSSARY-FAQ/glossary/mesh.md` [source: 10-GLOSSARY-FAQ/glossary/mesh.md]
  - `10-GLOSSARY-FAQ/glossary/syncthing.md` [source: 10-GLOSSARY-FAQ/glossary/syncthing.md]
  - `10-GLOSSARY-FAQ/glossary/bus-fallback.md` [source: 10-GLOSSARY-FAQ/glossary/bus-fallback.md]


# TOP GAPS — every missing category

ALL 21 GAPS CLOSED 2026-10-15 (wave-3 renames + wave-4 writes). Entries kept as
historical record per the PRESERVE LAW; leaf tags above now cite the landed files.

Each gap entry uses the same shape as `~/.hermes/cache/scratch/unmuzzled-pass/folds/gaps-A5.md`:
rank, proposed path, why it matters, estimated size, partial-coverage citations,
and feedstock (existing repo content that would feed the merge). The 21 gaps
below are the union of `gaps-A5.md` (GAPS-01 through 21) plus framework-level
observations from this tree. The TOP-10 highest-value subset is the first
ten; the remaining eleven are still material but secondary.

## TOP-10 highest-value gaps (rank-ordered)

### GAP-01 [CLOSED 2026-10-15 -> `05-LOCAL-MODELS/finetune-uncensoring.md`] -- Finetune-Recipes for Uncensoring (SFT / LoRA / DPO)

- **Proposed path**: `05-LOCAL-MODELS/models/finetune-uncensoring.md`
- **Why it matters**: README §05 explicitly promises "finetune recipes" but
  only `abliteration-pipeline.md` exists. SFT/LoRA/DPO-based alignment-removal
  (unfiltered datasets, deguard-style LoRA patches, Unsloth QLoRA, Llama-Factory)
  is a separate methodology class. A major operator workflow is uncovered.
- **Estimated size**: ~160 lines (dataset table, LoRA/QLoRA commands, DPO undo,
  model-registry cross-ref).
- **Partial coverage**: `05-LOCAL-MODELS/models/abliteration-pipeline.md` Stage 2
  (DPO heal post-ablation). `00-DOCTRINE/LAWS-research-appendix.md` §1
  ("Abliteration -- the practical technique"). `00-DOCTRINE/ONT-15x15-UNMUZZLED-AI.md`
  Part 6. Glossary: `DPO.md`, `RLHF.md`. No SFT/LoRA content anywhere.
- **Feedstock**: `LAWS-research-appendix.md` §1 + §2, `ONT-15x15-UNMUZZLED-AI.md`
  Part 6, `ONT-20x20-UNMUZZLED-AI-MASTER-ATLAS.md` Parts 6+8,
  `DESIGN-DRAFT-v0.1.md`, `EPIC.md` §§27-28, `UNMODERATED-INFERENCE.md` Section
  II model catalog, `13-REFERENCE-PAPERS/dolphin-3.md`, `dolphin-mixtral.md`,
  `neuraldaredevil-8b.md`.

### GAP-07 [CLOSED 2026-10-15 -> `05-LOCAL-MODELS/runtimes/activation-steering.md`] -- Inference-Time Steering Vectors (RepE / CAA / SAE Steering)

- **Proposed path**: `05-LOCAL-MODELS/runtimes/activation-steering.md`
- **Why it matters**: `00-DOCTRINE/ONT-20x20-SOVEREIGN-RESEARCH-SYSTEMS-20261002.md`
  Part 7 devotes a full 20-node table to "ACTIVATION STEERING & INFERENCE-TIME
  CONTROL" (steering vectors, repeng, SAE feature steering, concept-cone
  steering) -- every node marked `GAP`. Reversible inference-time control is
  the complement to abliteration. Zero operational files exist.
- **Estimated size**: ~150 lines (repeng library usage, llama.cpp
  `--control-vector` flag, SAELens integration, per-request steering profile
  concept, before/after refusal scoring, decision matrix: steer vs ablate).
- **Partial coverage**: `ONT-20x20-...` Part 7 (20 GAP nodes with tool refs).
  `09-EDUCATIONAL/deep-dives/refusal-geometry.md` (theory only).
  `13-REFERENCE-PAPERS/refusal-geometry-followups.md`,
  `refusal-single-direction-arditi.md`, `transformerlens.md` (refs only).
- **Feedstock**: All of the above, plus `LAWS-research-appendix.md` §1
  (mechanistic interpretability foundations), `abliteration-pipeline.md`
  (ablation as complement to steering).

### GAP-05 [CLOSED 2026-10-15 -> `06-MULTIMODAL/video/local-video-gen-pipelines.md`] -- Local Video-Generation Pipeline Detail (Wan / Hunyuan / CogVideoX / LTX / Mochi / Kling / Hailuo)

- **Proposed path**: `06-MULTIMODAL/video/local-video-gen-pipelines.md`
- **Why it matters**: `06-MULTIMODAL/README.md` escalation ladder explicitly
  names "local HunyuanVideo / SVD / AnimateDiff" and "Kling / Hailuo
  (Chinese)" as fallback tiers -- but only `stable-video.md` and
  `animatediff-local.md` exist. Missing entirely: Wan 2.1, HunyuanVideo,
  CogVideoX, LTX-Video, Mochi-1, Kling, Hailuo. The framework promises
  coverage it does not have.
- **Estimated size**: ~160 lines (per-tool tables: VRAM, ComfyUI node path,
  NSFW filter bypass, prompt format, GGUF availability for video, single-image
  -> video workflow).
- **Partial coverage**: `06-MULTIMODAL/README.md` (escalation defaults
  lines 64-67 -- proves framework intent). `06-MULTIMODAL/video/animatediff-local.md`
  Notes (mentions LTX-Video and CogVideoX by name). `stable-video.md` Notes
  (mentions CogVideoX as comparison). `ONT-20x20-...`, `DESIGN-DRAFT-v0.1.md`,
  `ONTFIX-14-unmuzzled-ai/` all name these targets.
- **Feedstock**: `06-MULTIMODAL/README.md` escalation defaults,
  `animatediff-local.md` Notes, `stable-video.md` Notes, all ONT-20/ONT-15/
  DESIGN-DRAFT mentions, `UNMODERATED-INFERENCE.md` video section, `EPIC.md`
  §30 (ComfyUI + media pipelines).

### GAP-16 [CLOSED 2026-10-15 -> `10-GLOSSARY-FAQ/anti-pattern-catalog/README.md + 10-GLOSSARY-FAQ/troubleshooting/README.md`] -- Anti-Pattern Catalog + Troubleshooting (README-Promised, Absent)

- **Proposed path**: `10-GLOSSARY-FAQ/anti-pattern-catalog/README.md` +
  `10-GLOSSARY-FAQ/troubleshooting/README.md`
- **Why it matters**: `10-GLOSSARY-FAQ/README.md` §Subfolders explicitly lists
  `anti-pattern-catalog/` ("cataloged failure modes to avoid when authoring
  framework content") and `troubleshooting/` ("problem-first triage flows")
  -- but neither folder exists on disk (only `faq/` and `glossary/` populated).
  This is a README-promised deliverable with zero content.
- **Estimated size**: ~90 lines each (anti-pattern catalog: 20+ entries;
  troubleshooting: 10+ problem-first flows).
- **Partial coverage**: `00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md`
  §Anti-pattern lint (6 lines of banned-phrase categories + the
  `banned-phrases.txt` lint file). `10-GLOSSARY-FAQ/faq/` (20 FAQ Q&As
  serve as implicit troubleshooting). `10-GLOSSARY-FAQ/README.md`
  (lists the empty subfolders as existent lines 29-31).
- **Feedstock**: `MAXIMUM-ADVERSARIAL-POSTURE.md` banned-phrase lint rules,
  `soul-lint/banned-phrases.txt`, all 20 FAQ entries, `SOURCE-SURVEY.md` §3
  gaps, `LAWS-research-appendix.md` enforcement mechanisms,
  `ONTFIX-14/03.md` (method M1-M8 failures), `DESIGN-DRAFT-v0.1.md` anti-pattern
  notes.

### GAP-11 [CLOSED 2026-10-15 -> `13-REFERENCE-PAPERS/guardrail-stack-map.md`] -- Provider Guardrail-Stacks Reference (Know Thy Enemy)

- **Proposed path**: `13-REFERENCE-PAPERS/guardrail-stack-map.md`
- **Why it matters**: Cannot evade what you don't know exists. LlamaGuard
  (Meta v1/v2/v3, 7B), PromptGuard (Meta, 279M), Azure AI Content Safety
  (severity 0-7), OpenAI Moderation API (hate/sexual/violence/self-harm),
  NeMo Guardrails (NVIDIA, Colang), Amazon Bedrock Guardrails, Google Cloud
  Safety Filters, Replicate moderation filter. Framework never catalogs
  these -- providers' TAINT reason is only "openai/*" without explaining
  WHAT guardrail fires.
- **Estimated size**: ~120 lines (per-provider guardrail table: classifier
  name, modality, categories blocked, bypass vectors known, confidence
  threshold, open-source availability).
- **Partial coverage**: `04-PROVIDERS/groq.md` ("known refusals: audit for
  llama-guard / prompt-guard interposition"). `04-PROVIDERS/together.md`
  ("audit for llama-guard interposition"). `04-PROVIDERS/README.md` §Tainted.
  `13-REFERENCE-PAPERS/garak-nvidia.md` (vulnerability scanner, not intel).
  `13-REFERENCE-PAPERS/commandsans-mcp-sanitization.md` (MCP sanitisation,
  not provider-side).
- **Feedstock**: All per-provider `.md` files in `04-PROVIDERS/`,
  `garak-nvidia.md`, `commandsans-mcp-sanitization.md`,
  `AI-UNMUZZLED-EDITION-20261015.md` §1.2, `UNMODERATED-INFERENCE.md` provider
  sections.

### GAP-13 [CLOSED 2026-10-15 -> `07-INSTALL-SCRIPTS/gcg-rotation-cron.md`] -- GCG Suffix Rotation Automation Tooling

- **Proposed path**: `07-INSTALL-SCRIPTS/gcg-rotation-cron.md`
- **Why it matters**: `00-DOCTRINE/ONTFIX-14-unmuzzled-ai/` diagnosis B5 and
  goal G5 explicitly call this a framework gap. GCG suffixes are transferable
  but degrade over API updates -- without automated rotation + batch-compute
  (nanogcg), they become stale and refusal rates climb. The
  `gcg-suffix-mechanics.md` deep dive explains the algorithm; no operational
  file exists to run it.
- **Estimated size**: ~80 lines (nanogcg CLI invocation, model target list,
  batch compute job, rotation schedule, storage of suffixes, integration
  with `12-JAILBREAK-CORPUS/patterns/gcg-suffix.md`).
- **Partial coverage**: `ONTFIX-14/01.md` B5, `ONTFIX-14/02.md` G5,
  `09-EDUCATIONAL/deep-dives/gcg-suffix-mechanics.md` (algorithm detail),
  `13-REFERENCE-PAPERS/nanogcg-repo.md`, `12-JAILBREAK-CORPUS/patterns/gcg-suffix.md`
  (static example), `gcg-cross-model-transfer.md` (transfer pattern),
  `LAWS-research-appendix.md` §2 (GCG-style universal adversarial suffixes).
- **Feedstock**: All listed above; `ONTFIX-14/{01,02}.md` for specification,
  `gcg-suffix-mechanics.md` for algorithm.

### GAP-19 [CLOSED 2026-10-15 -> `06-MULTIMODAL/image/watermark-removal.md`] -- Output Watermark / Metadata Removal (C2PA / SynthID / Steganography)

- **Proposed path**: `06-MULTIMODAL/image/watermark-removal.md`
- **Why it matters**: Modern generators embed provenance metadata: C2PA/
  Content Credentials (Adobe Firefly, Microsoft Designer, DALL-E 3), SynthID
  (Google DeepMind), Stable Signature (Meta), IPTC tags, EXIF generation
  fields. For sovereign workflows where output provenance must not expose
  tooling, this metadata needs stripping. Framework's image pipeline docs
  teach generation, never output sanitization.
- **Estimated size**: ~70 lines (watermark-type table, per-format stripping
  commands: exiftool, `convert -strip`, ffmpeg metadata stripping, SynthID
  known evasion, C2PA signature removal, comfyui-metadata node).
- **Partial coverage**: `06-MULTIMODAL/vision-input/image-as-prompt-injection.md`
  (LSB-encoded pixel steganography on the ATTACK input side, not output).
  `12-JAILBREAK-CORPUS/CYBERCRIME BIBLE2.md` (deepfake forensics evasion as
  adversary tradecraft). ALL image recipe files (teach generation, not
  hardening).
- **Feedstock**: Image recipe files for context,
  `image-as-prompt-injection.md` steganography techniques (inverse
  application), cybercrime bibles forensics sections.

### GAP-06 [CLOSED 2026-10-15 -> `06-MULTIMODAL/audio/uncensored-tts-stt.md`] -- Uncensored TTS and STT Roster (Text-to-Speech / Speech-to-Text)

- **Proposed path**: `06-MULTIMODAL/audio/uncensored-tts-stt-roster.md`
- **Why it matters**: STT is entirely absent from the framework -- no
  whisper.cpp, faster-whisper, WhisperX, or diarization doc exists. TTS
  coverage stops at Bark + XTTS-v2 (both ~2023-era). Missing: F5-TTS, Kokoro,
  RVC, GPT-SoVITS, Chatterbox, Dia, OpenVoice, MeloTTS, VoiceCraft. The
  audio escalation ladder already references "F5-TTS / XTTS-v2 local" as
  tiers that have no operational file.
- **Estimated size**: ~170 lines (TTS table: model, VRAM, cloning seconds,
  voice-conversion support, language support, ComfyUI node path, NSFW filter
  status; STT section: whisper.cpp install, diarization, transcription bypass
  where STT models refuse "dangerous" transcripts).
- **Partial coverage**: `06-MULTIMODAL/audio/` (`bark-local.md`, `xtts-local.md`,
  `elevenlabs-voice-cloning.md`, `suno-god-mode.md`, `udio-uncensored.md`).
  `06-MULTIMODAL/README.md` escalation defaults line 67 ("tts -> ElevenLabs ->
  F5-TTS / XTTS-v2 local -> Bark local"). F5-TTS named but no file exists.
  `MCP-SERVER-ONTOLOGY.md` mentions RVC. `02-PERSONAS/suno-god-mode.md` is
  music-gen specific.
- **Feedstock**: All 5 audio/ files, `06-MULTIMODAL/README.md` escalation
  defaults, `00-DOCTRINE/ONT-20x20-UNMUZZLED-AI-MASTER-ATLAS.md` audio
  mentions, `DESIGN-DRAFT-v0.1.md`, `MCP-SERVER-ONTOLOGY.md` voice section.

### GAP-09 [CLOSED 2026-10-15 -> `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md`] -- Roleplay / Character / NSFW LLM Runtimes Roster

- **Proposed path**: `05-LOCAL-MODELS/runtimes/lp-runtimes-roster.md`
- **Why it matters**: A large fraction of uncensored AI usage is roleplay /
  character simulation / NSFW creative. Existing runtime docs (Ollama,
  llama.cpp, LM Studio, vLLM, ExLlamaV2) target general-purpose inference.
  Missing: KoboldCpp, Oobabooga / Text Generation WebUI, Aphrodite Engine,
  TabbyAPI, Faraday / Backyard AI. SillyTavern (phase 5) is a frontend -- not
  these runtimes.
- **Estimated size**: ~120 lines (per-runtime table: VRAM, backend, API
  compatibility, RP-specific features, NSFW token sampling presets).
- **Partial coverage**: `EPIC.md` §28 items 171-176 (lists Open WebUI, Ollama,
  LM Studio, vLLM, Aphrodite, Oobabooga) and §31 items 189-194 (SillyTavern,
  RisuAI, Agnaistic, KoboldCpp, Faraday, TavernHelper). `exllamav2.md`
  TabbyAPI mention. `llamacpp.md` KoboldCpp mention. `UNMODERATED-INFERENCE.md`
  "character card system" and Stheno.
- **Feedstock**: `EPIC.md` §§28, 30, 31, `exllamav2.md` TabbyAPI mention,
  `llamacpp.md` KoboldCpp mention, `UNMODERATED-INFERENCE.md` character model
  mentions.

### GAP-21 [CLOSED 2026-10-15 -> `12-JAILBREAK-CORPUS/patterns/provider-prefill-compendium.md`] -- Per-Provider Prefill / Logit-Bias Attack Compendium

- **Proposed path**: `12-JAILBREAK-CORPUS/patterns/provider-prefill-compendium.md`
- **Why it matters**: Prefill attacks (forcing the model to complete a
  pre-written "Sure, here is" continuation) and logit-bias attacks (banning
  refusal tokens like "I", "Sorry", "cannot") are per-provider API features.
  llama.cpp supports `--grammar` and `--logit-bias`; OpenRouter exposes
  `logit_bias`; Anthropic supports prefill via `messages[-1].content` append;
  DeepSeek has a `prefix` parameter; Mistral API supports prefill. The
  framework has `patterns/prefill-only.md` (one pattern) and `llamacpp.md`
  mentions `--logit-bias` -- but no consolidated attack surface catalog
  per-provider.
- **Estimated size**: ~80 lines (per-provider table: API param, token
  whitelist to ban, model-specific refusal token IDs, copy-paste payload
  template).
- **Partial coverage**: `12-JAILBREAK-CORPUS/patterns/prefill-only.md` (single
  generic pattern), `12-JAILBREAK-CORPUS/patterns/refusal-suppression-token.md`
  (token suppression, generic), `03-HARNESSES/llamacpp.md` `--logit-bias`,
  `03-HARNESSES/README.md` llamacpp index, `05-LOCAL-MODELS/runtimes/exllamav2.md`
  prefill, `05-LOCAL-MODELS/runtimes/vllm.md` prefill.
- **Feedstock**: `prefill-only.md`, `refusal-suppression-token.md`,
  `llamacpp.md`, `exllamav2.md`, `vllm.md`, provider API docs in
  `04-PROVIDERS/`.

## Remaining material gaps (secondary, 11-21)

### GAP-02 [CLOSED 2026-10-15 -> `05-LOCAL-MODELS/mergekit-uncensoring.md`] -- Model-Merge Uncensoring (Mergekit: DARE/TIES/SLERP)

- **Proposed path**: `05-LOCAL-MODELS/models/mergekit-uncensoring.md`
- **Why it matters**: Model merging via `mergekit` (Arcee.ai) -- DARE, TIES,
  SLERP, task-arithmetic, passthrough -- is a widely-used community technique
  for producing uncensored models without ablation or fine-tuning. Foundational
  method entirely uncovered.
- **Estimated size**: ~130 lines.
- **Feedstock**: `EPIC.md` §§27-28 (model lineages), `UNMODERATED-INFERENCE.md`
  model catalog, `ONT-20x20-...` Parts 6+8.

### GAP-03 [CLOSED 2026-10-15 -> `12-JAILBREAK-CORPUS/system-prompt-extraction-corpus.md`] -- System-Prompt Extraction Corpus (Leaked Vendor Prompts + Extraction Ladder)

- **Proposed path**: `12-JAILBREAK-CORPUS/system-prompt-extraction-corpus.md`
- **Why it matters**: Knowing the guardrail IS the jailbreak. CL4R1T4S (Pliny's
  companion repo) hosts leaked vendor system prompts from ChatGPT, Claude,
  Gemini, Grok, Perplexity, Cursor, and others. Framework has reference
  citation and a single extraction pattern, but no consolidated extraction
  corpus.
- **Estimated size**: ~180 lines.
- **Feedstock**: `12-JAILBREAK-CORPUS/patterns/system-prompt-extraction.md`
  (single pattern with 3 template variants), `13-REFERENCE-PAPERS/cl4r1t4s-pliny.md`,
  `l1b3rt4s-pliny.md`, `99-ARCHIVE-SEEDS/system-prompts/Hermes-Dictator.md`
  Part 6, `99-ARCHIVE-SEEDS/system-prompts/INFILTRATED.md`,
  `LAWS-research-appendix.md` §3, `carlini-poisoning-attacks.md`,
  `EPIC.md` §26.

### GAP-04 [CLOSED 2026-10-15 -> `05-LOCAL-MODELS/community-hubs.md`] -- Community Hubs -- Model & LoRA Sourcing

- **Proposed path**: `05-LOCAL-MODELS/models/community-hubs.md`
- **Why it matters**: Without community hubs you have no models. The framework
  lists individual checkpoints but never explains WHERE or HOW to find them.
- **Estimated size**: ~140 lines.
- **Feedstock**: `EPIC.md` §25 (items 152-164), all six image/video recipe
  files that reference Civitai, `ONT-20x20-...` Part 4, `SOURCE-SURVEY.md`
  §1 Inventory.

### GAP-08 [CLOSED 2026-10-15 -> `05-LOCAL-MODELS/runtimes/mobile-edge-inference.md`] -- Mobile and Edge Uncensored Inference

- **Proposed path**: `05-LOCAL-MODELS/runtimes/mobile-edge-inference.md`
- **Why it matters**: The framework is built on Termux Android (WORM tablet),
  yet no mobile/edge inference doc exists beyond a single FAQ answer.
- **Estimated size**: ~140 lines.
- **Feedstock**: `AGENTS.md` (Termux specifics), `faq-run-on-termux-android.md`,
  `llamacpp.md`, `ollama.md` runtimes, `ONT-20x20-...` mobile mentions.

### GAP-10 [CLOSED 2026-10-15 -> `00-DOCTRINE/opsec-for-sovereign-ops.md`] -- Operator OpSec for Uncensored AI Operations

- **Proposed path**: `07-INSTALL-SCRIPTS/operator-opsec.md` (or `00-DOCTRINE/`)
- **Why it matters**: API key compartmentation, payment/billing trails,
  provider-side prompt logging audit, local artifact hygiene, account-rotation
  playbook, traffic fingerprinting, VPN/Tor routing patterns.
- **Estimated size**: ~130 lines.
- **Feedstock**: `LAWS.md` §5, `hacker.md`, `freeops.md`,
  `venice-uncensored.md` pattern, `HiTECHCRIME BIBLE2.md` OPSEC subsections,
  `e2ee-privacy-tiers.md` (phase 5 neighbor).

### GAP-12 [CLOSED 2026-10-15 -> `03-HARNESSES/agentic-coding.md`] -- Uncensored Coding Assistants Roster (Continue / Aider / Cline / Roo)

- **Proposed path**: `03-HARNESSES/ai-coding-assistants.md`
- **Why it matters**: Framework covers Claude Code, opencode, Codex but never
  the broader coding-assistant ecosystem.
- **Estimated size**: ~130 lines.
- **Feedstock**: `03-HARNESSES/` harness wiring files as template,
  `tool-coercion.md`, `mcp-layer-autonomy.md`, `MCP-SERVER-ONTOLOGY.md`,
  `EPIC.md` §29.

### GAP-14 [CLOSED 2026-10-15 -> `07-INSTALL-SCRIPTS/encoding-ladder-library.md`] -- Encoding Ladder Python Library

- **Proposed path**: `07-INSTALL-SCRIPTS/encoding-ladder-library.md`
- **Why it matters**: `ONTFIX-14/` diagnosis B6 / goal G6 / method M6 call for
  a scripted, composable encoding ladder.
- **Estimated size**: ~70 lines.
- **Feedstock**: All 6+ individual encoding patterns, `ONTFIX-14/03.md` M6,
  `encoding-attack.md` glossary, `many-shot-and-pandas.md` deep-dive,
  `99-ARCHIVE-SEEDS/system-prompts/INFILTRATED.md` §Parseltongue tiers.

### GAP-15 [CLOSED 2026-10-15 -> `11-DETECTION-CANARIES/eval-harnesses.md`] -- Judge-Model Roster for Refusal Evaluation

- **Proposed path**: `11-DETECTION-CANARIES/judge-model-roster.md`
- **Why it matters**: The canary runner scores refusals via pattern matching
  only; no LLM-as-judge pipeline exists. Uncensored Judge models are
  essential because GPT-4 and Claude refuse to evaluate adversarial content.
- **Estimated size**: ~80 lines.
- **Feedstock**: All detection-canary files, UGI/PROACT/JailDAM/ALERT
  references, canary runner specs.

### GAP-17 [CLOSED 2026-10-15 -> `05-LOCAL-MODELS/models/quantization-and-refusal.md`] -- Quantization Impact on Refusal Behavior

- **Proposed path**: `05-LOCAL-MODELS/models/quantization-and-refusal.md`
- **Why it matters**: Does quantizing a refusal-ablated model regrow refusal?
  Extreme quantization (2-bit, 3-bit) can degrade the directional ablation.
- **Estimated size**: ~90 lines.
- **Feedstock**: Abliteration pipeline, exllamav2/llamacpp runtime docs, all
  model files, `LAWS-research-appendix.md` §1.

### GAP-18 [CLOSED 2026-10-15 -> `06-MULTIMODAL/video/comfyui-video-workflows.md`] -- ComfyUI Video Workflow Catalog

- **Proposed path**: `06-MULTIMODAL/video/comfyui-video-workflows.md`
- **Why it matters**: `06-MULTIMODAL/image/comfyui-workflow.md` provides 3
  detailed image workflows; no equivalent exists for video.
- **Estimated size**: ~100 lines.
- **Feedstock**: `comfyui-workflow.md` (image) as structural template,
  `animatediff-local.md`, `stable-video.md`, `EPIC.md` §30,
  `06-MULTIMODAL/README.md` escalation defaults.

### GAP-20 [CLOSED 2026-10-15 -> `00-DOCTRINE/legal-landscape.md`] -- Legal-Landscape Threat-Intel Reference (Descriptive)

- **Proposed path**: `13-REFERENCE-PAPERS/legal-landscape-threat-intel.md`
- **Why it matters**: Descriptive threat-intel reference on what laws may
  affect sovereign operators. Situational awareness, not compliance guidance.
  Framed as "what draws LE attention" not "what you must comply with."
- **Estimated size**: ~80 lines.
- **Feedstock**: `LAWS.md` §3, cybercrime bible legal consequences sections,
  `EPIC5.md` researcher roster. Doctrine caution: file must carry prominent
  framing that it is THREAT INTEL not "compliance"; review against
  `MAXIMUM-ADVERSARIAL-POSTURE.md` before commit.

## Summary

- **Total leaves mapped**: ~280 (counted across 11 top-level categories).
- **Leaves with `GAP` tag**: 0 as of 2026-10-15 wave-4 (all flipped to CLOSED -> [source] citations).
- **Gaps from `gaps-A5.md`**: 21 total, ALL CLOSED 2026-10-15 (wave-3 renames + wave-4 writes).
- **Anchor docs in place**: 8 of 8 (`UNMODERATED-HARNESSES.md` landed;
  `04-PROVIDERS/UNMODERATED-INFERENCE.md` serves the providers layer anchor
  from inside the providers tree).
- **Source of truth for this tree**: `~/.hermes/cache/scratch/unmuzzled-pass/folds/gaps-A5.md`
  [source: ~/.hermes/cache/scratch/unmuzzled-pass/folds/gaps-A5.md],
  every `NN-SECTION/README.md`, the seven root anchor docs (where present),
  the per-section file listings, and the top-level coordination files
  (`RECONCILE-PLAN.md`, `RECONCILE-RECORD.md`, `SWARM-PIPELINE.md`,
  `MASTER-AGENT-COORDINATION-DIRECTIVE.md`, `MCP-SERVER-ONTOLOGY.md`,
  `EPIC.md`, `EPIC5.md`).
