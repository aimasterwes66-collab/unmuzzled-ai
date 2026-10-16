---
sovereign: true
title: community-hubs
type: reference
agent: worm
status: active
tags: [reference, community-hubs, civitai, chub, huggingface, tensor-art, liblib, mage, openmodeldb, ehentai, apertis, sourcing, uncensored, mesh-fit]
---

# 05-LOCAL-MODELS/community-hubs.md -- the community-hub sourcing doc

This file expands the EPIC.md section 25 / items 153-158 ("Community Weight
Registries & Decentralized Model Hubs") into actionable sourcing. Per hub:
what is available there, how to search (operators + tags), the uncensored /
mature content posture, the mesh fit (which box can pull from it; what to run
where). The hub list is the canonical 6 from EPIC, plus the character-card
hub (Chub), the perverse-models hub (Apertis), the upscaler meta-database
(OpenModelDB), and the eHentai cross-reference (which is not a model hub
itself but is the canonical provenance index the community uses to anchor
LoRAs / embeddings to source data).

The scope here is the discovery / ingest surface, not the runtime. Runtime
backends (Ollama, vLLM, ComfyUI, etc.) live in 05-LOCAL-MODELS/runtimes/
and 06-MULTIMODAL/. This file only covers: where the weights come from,
how to find them, and which box in the mesh is suited to hosting / pulling
the result.

# 1. EPIC.md line items 153-158 (the community-hub sub-list, preserved verbatim)

[source: EPIC.md, line 1 starts the section header, items 153-158 are the
community-hub bullets]

- EPIC line 25 header: "Community Weight Registries & Decentralized Model
  Hubs"
- Item 153: "Civitai Hub: Massive community-driven repository for open-weight
  SD, SDXL, Flux checkpoints, LoRAs, LyCORIS, embeddings, and unfiltered
  fine-tunes."
- Item 154: "Hugging Face Hub: The baseline git-based ecosystem hosting
  open-source base models, GGUF/AWQ/EXL2 quantizations, abliterated weights,
  and raw dataset repositories."
- Item 155: "Tensor.art: Model aggregation and remote inference platform
  hosting permissive community fine-tunes, checkpoint variants, and modular
  LoRA stacks."
- Item 156: "LiblibAI: Large community-driven model hub indexing fine-tuned
  diffusion checkpoints, custom control pipelines, and domain-specific
  weights."
- Item 157: "Mage.space Hub: Open community index of permissive Stable
  Diffusion, SDXL, and uncensored community checkpoints with built-in remote
  execution."
- Item 158: "OpenModelDB: Open community database providing organized
  metadata, benchmarks, and direct download links for community-trained
  upscaling and restoration models."

# 2. Hub cross-reference table (EPIC item -> canonical URL -> primary asset class)

| EPIC | Hub | Canonical URL | Primary asset class | Auth | API |
| --- | --- | --- | --- | --- | --- |
| 153 | Civitai | https://civitai.com/ | SD / SDXL / Flux / Wan checkpoints, LoRAs, LyCORIS, Textual Inversions, ControlNets, Poses, embeddings | optional (Mature content gated; API token for favorites/hidden) | https://developer.civitai.com/site/reference/models |
| 154 | Hugging Face | https://huggingface.co/ | LLM checkpoints (base + abliterated + heretic), GGUF/AWQ/EXL2 quantizations, datasets, Spaces, Inference Providers | optional (private repos + Inference Providers + Enterprise Hub require token) | https://huggingface.co/docs/hub/api |
| 155 | Tensor.Art | https://tensor.art/ + https://tams.tensor.art/ | SD / SDXL / Flux / Wan / Krea 2 / Z-Image / Illustrious checkpoints, LoRAs, workflows, remote generation jobs | optional (consumer site guest OK; TAMS API key for cloud job API) | no public REST; community reverse-engineered (Anakin Wire action `act_tensor_art_model_portal_listing`) |
| 156 | LiblibAI | https://liblib.art/ (CN) / https://www.liblib.art/ | SD / SDXL / Flux / Z-Image-Turbo / Illustrious checkpoints, LoRAs, control pipelines, ComfyUI workflows | phone / WeChat / QQ (real-name required for uploaders) | none public; internal |
| 157 | Mage.space | https://mage.space/ + https://api.mage.space/ | SD 1.5 / SDXL / SD3.5 / Flux / Flux 2 / Chroma / Krea 2 / Z-Image / Qwen / Wan / FramePack / Mango / Guava / Kiwi / Peach / Cherry / Blueberry / Raspberry / Berry / Melon / Plum | optional (Free / Basic $10 / Pro $30 / Pro Plus $60 / Max $200) | https://docs.mage.space/ (OpenAPI spec at /v1/flux2/generate, etc.) |
| 158 | OpenModelDB | https://openmodeldb.info/ | Real-ESRGAN / SwinIR / CUGAN / DAT / ATD / compact upscaler `.pth` and `.safetensors` checkpoints, scale 1x-8x | none | none; the `openmodeldb` PyPI client (matth-blt/openmodeldb) wraps download/convert/verify |
| extra | Chub | https://chub.ai/ + https://api.chub.ai/search | TavernAI V2 / V3 character cards (PNG with `chara` / `ccv3` tEXt chunks), lorebooks, assets | optional (creator upload + API key for write; read = public) | https://api.chub.ai/search?first=...&page=...&sort=...&nsfw=...&nsfl=... |
| extra | Apertis | https://apertus.cc/ (NOT Swiss Apertus; see section 9 below) | Single uncensored LLM via OpenAI-compatible REST | API key (Google / email signup; no phone) | https://api.apertus.cc/v1/chat/completions |
| extra | eHentai cross-ref | https://e-hentai.org/ + https://exhentai.org/ | Source-art provenance index used to anchor LoRAs / embeddings / style references to known works | none (free) / ExHentai has a banner-based gate | none public; gallery-dl handles scrape (`https://codeberg.org/mikf/gallery-dl/issues/60` shows Chub use of similar pattern) |

The "extra" rows are not EPIC items but are the canonical surface for the
two asset classes that EPIC mentions indirectly: character cards (consumed
by SillyTavern / RisuAI / Agnaistic -- EPIC items 189-194) and the
perverse-models uncensored-LLM lane (covered under the "Unaligned &
Abliterated Foundation Model Checkpoints" section, EPIC 165-170 -- Apertis
is a hosted-API instance of the same posture).

# 3. Civitai (EPIC 153) -- deep sourcing

## 3.1 What is available

Civitai is the single largest open-weight Stable-Diffusion-family community
hub. Asset classes it indexes:

- **Checkpoint** (full SD 1.5 / SDXL / Pony / Illustrious / NoobAI / SD3 /
  Flux Dev / Flux Schnell / Wan / CogVideoX / HunyuanVideo / Mochi / LTX-Video
  finetunes)
- **LORA** (Low-Rank Adaptation, the most-downloaded type -- hundreds of
  MB each, plug into a base checkpoint)
- **LyCORIS** (LoHa / LoKr / GLoRA / OFT -- a superset of LoRA with the
  same install path)
- **TextualInversion** (embedding -- a few KB, learned token)
- **Hypernetwork** (legacy SD 1.5 only)
- **AestheticGradient** (legacy aesthetic predictors, rarely used in 2026)
- **Controlnet** (Control-LoRA, T2I-Adapter, reference-only)
- **Poses** (OpenPose skeleton reference)
- **Workflows** (ComfyUI / A1111 / Forge JSON)

[source: https://developer.civitai.com/site/reference/models -- the
`types` enum; also referenced by the Civitai CLI at
https://developer.civitai.com/site/guide/cli]

## 3.2 How to search (operators + tags + API)

### 3.2.1 Web UI filters

- Sort options: `Highest Rated` / `Most Downloaded` / `Most Liked` / `Newest`
  / `Most Discussed` / `Most Collected`
- Period filter (sort window): `AllTime` / `Year` / `Month` / `Week` / `Day`
- Mature content gate: `NSFW` toggle in account settings, then per-search
  `nsfw=true` / `nsfw=false` filter
- Base model filter: `SD 1.5` / `SD 2.x` / `SDXL 1.0` / `Pony` /
  `Illustrious` / `NoobAI` / `SD 3` / `SD 3.5` / `Flux.1 D` / `Flux.1 S` /
  `Flux.2` / `Krea 2` / `Wan Video 2.2 T2V-A14B` / `Wan Video 2.2 I2V-A14B`
  / `Hunyuan Video` / `Mochi` / `CogVideoX` / `LTX Video` / `Chroma` /
  `Z-Image Turbo` / `Qwen Image`
- Tag filter: any user-applied tag, comma-separated, e.g.
  `pony,nsfw,realistic,anatomy`
- Creator filter: `username` (auto-slugified)
- Commercial use filter: `allowCommercialUse: None / Image / Rent / Sell /
  RentCivit`
- Derivative license: `allowDifferentLicense`, `allowDerivatives`

[source: https://developer.civitai.com/site/reference/models -- query
parameter table, `GET /enums` for full list of `BaseModel` and `ModelType`
values]

### 3.2.2 REST API (`GET /api/v1/models`)

Endpoint: `https://civitai.com/api/v1/models`

Query parameters (verbatim from API ref, preserved for reproducibility):

```
limit        integer 1-100, default 100         per-page count
page         integer >=1                         1-indexed; INCOMPATIBLE with `query`
cursor       string                              opaque; from metadata.nextCursor
query        string                              Meilisearch full-text; needs cursor pagination
ids          comma-separated integers            restrict to model IDs
tag          string                              filter by tag name
username     string                              filter by creator (auto-slugified)
types        ModelType or ModelType[]            Checkpoint, TextualInversion,
                                                  Hypernetwork, AestheticGradient,
                                                  LORA, Controlnet, Poses
baseModels   string or string[]                  e.g. "SDXL 1.0", "Flux.1 D"
checkpointType  Standard | Trained | Merge
sort         Highest Rated | Most Downloaded | Most Liked
period       AllTime | Year | Month              (sort window)
nsfw         boolean default false               include mature content
supportsGeneration  boolean                      only models with on-site gen
fromPlatform boolean                             only models trained on Civitai
earlyAccess  boolean                             include early-access versions
primaryFileOnly boolean default false            drop non-primary files from versions
favorites    boolean (auth)                      only caller's bookmarks
hidden       boolean (auth)                      only caller's hidden models
```

Response shape (one item, abbreviated, preserved from the API ref):

```json
{
  "id": 827184,
  "name": "WAI-illustrious-SDXL",
  "description": "<p>...</p>",
  "type": "Checkpoint",
  "nsfw": false,
  "nsfwLevel": 31,
  "availability": "Public",
  "supportsGeneration": true,
  "allowNoCredit": true,
  "allowCommercialUse": "{Image,RentCivit}",
  "allowDerivatives": true,
  "allowDifferentLicense": true,
  "minor": false,
  "poi": false,
  "sfwOnly": false,
  "mode": null,
  "stats": {
    "downloadCount": 1272529,
    "thumbsUpCount": 79272,
    "thumbsDownCount": 202,
    "commentCount": 1931,
    "tippedAmountCount": 156742
  },
  "creator": { "username": "WAI0731", "image": "..." },
  "tags": ["base model", "anime"],
  "modelVersions": [{
    "id": 2514310,
    "name": "v16.0",
    "baseModel": "Illustrious",
    "baseModelType": "Standard",
    "publishedAt": "2025-12-18T09:58:12.062Z",
    "files": [{
      "id": 2402203,
      "name": "waiIllustriousSDXL_v160.safetensors",
      "type": "Model",
      "sizeKB": 6775430.35,
      "hashes": { "AutoV2": "A5F58EB1C3", "SHA256": "A5F58EB1C3...", "BLAKE3": "1A411D9B..." },
      "downloadUrl": "https://civitai.com/api/download/models/2514310",
      "primary": true,
      "metadata": { "format": "SafeTensor", "size": "pruned", "fp": "fp16" }
    }],
    "downloadUrl": "https://civitai.com/api/download/models/2514310"
  }],
  "metadata": { "nextCursor": "75363|932023|257749", "nextPage": "..." }
}
```

Quirks / footguns (from the same source):

- `page * limit` > 1000 returns `429`; use `cursor` for deep paging.
- Combining `query` with `page` returns `400` (Meilisearch forces cursor).
- Only `Published` versions are returned to non-moderator callers.
- Files marked non-public by the uploader are hidden from `files[]`.
- `mode` non-null on moderated parents: `Archived` (drops files + url) or
  `TakenDown` (also drops images).

[source: https://developer.civitai.com/site/reference/models -- "Notes"
section above]

### 3.2.3 CLI (Civitai's official `civitai` CLI)

Install: `npm i -g @civitai/cli` (or use the `civitai` binary; some mesh
boxes carry it as a prebuilt node module).

Subcommands (verbatim, from the CLI reference):

```
civitai models search --query "pony" --limit 5
civitai models search --type LORA --sort "Most Downloaded" --period Month
civitai models search --base-model Pony --base-model "Illustrious"
civitai models get 827184
```

Flags for `models search`:
`--query, --tag, --username, --type, --base-model (repeatable),
--sort, --period, --nsfw, --limit (1-100), --page, --cursor`.

Tip from the same source: `--base-model` filters by base-model family and
disambiguates `--type` (e.g. all video checkpoints are `Checkpoint`, so
filter with `--base-model "Wan Video 2.2 T2V-A14B"` to narrow).

[source: https://developer.civitai.com/site/guide/cli -- "Filtering by
architecture / video models" tip]

### 3.2.4 Mature-content / NSFW posture (Civitai-specific)

Civitai is the only major hub with a full mature-content model policy
rather than a blanket ban:

- Per-user `NSFW` visibility in account settings (default off for new
  accounts).
- API `nsfw=true` only returns mature content when the caller's account has
  it enabled; otherwise the parameter is `Ignored on SFW-gated regions`
  (per the API ref).
- Per-model `nsfwLevel` (integer, 1-32; >= 17 is X-rated, the operator
  cutoff is the user-supplied filter; the community treats >= 25 as
  "explicit / unfiltered").
- `minor: false` is enforced at upload; child-sexual-abuse material is
  never permitted and the platform proactively removes it (their stated
  policy).
- License: most checkpoints ship under `allowCommercialUse: Image` or
  `RentCivit` plus an "if you remix, no different license" clause; the
  default Civitai license is creative-ml-open-rail-m. Operators must read
  the per-model `allowCommercialUse` and `allowDerivatives` flags before
  shipping anything built on the model.

[source: https://developer.civitai.com/site/reference/models -- `nsfw`,
`nsfwLevel`, `minor`, `allowCommercialUse` parameters;
https://civitai.com/content/manifesto (the platform's stated policy)]

### 3.2.5 Sourcing examples (concrete queries preserved)

Most-downloaded NSFW models (May 2026 era):

- `Pony Diffusion V6 XL` -- https://civitai.com/models/257749 -- SDXL-class
  finetune; Civitai's own articles document **clip skip 2**, **Euler a**,
  **25 steps**, **1024** starters, plus score-tag templates -- open the
  linked **Articles** tab from the model page for the canonical recipe
  card.
- `Fluxed Up (Flux NSFW checkpoint)` -- https://civitai.com/models/847101
  -- large multi-format family (BF16/FP8/GGUF tiers appear in the version
  list); treat it as the "people actually run this" counterweight to
  older SDXL kings when you have **12 GB+ VRAM** or a GGUF workflow.
- `NSFW XL LoRA (SDXL)` -- https://civitai.com/models/141300 -- smaller
  download footprint than a checkpoint swap; good for anatomy-heavy
  prompts on neutral SDXL bases.

Click-path to reproduce "most downloaded NSFW" (verbatim, preserved):

1. Account: enable mature content in Civitai settings; confirm you're
   logged in (many NSFW previews are blurred otherwise).
2. Navigation: `Models` tab -- type a broad tag (`nsfw`, `pony`, `flux`)
   or leave blank for global view.
3. Sort: `Most Downloaded` (NOT "Most Buzzing" -- that's time-windowed
   hype).
4. Filters: pick `Checkpoint` for one-file installs, `LoRA` for stackers,
   `GGUF` if you are on 8-12 GB VRAM and the card offers it.
5. Open three tabs: highest download, newest `version` within that model,
   and `Posts` for real user grids -- not only the hero samples.

[source: https://offlinecreator.com/civitai-most-downloaded-nsfw-models-2026
-- preserved procedure]

### 3.2.6 Tool-side integration (the operator's mesh tools)

The `civitai` CLI and a community ComfyUI manager (`comfy.icu` and
`comfyui-workflow` projects) expose `search_civitai_models` / `download_civitai_model`
tools that wrap the REST API and translate `base_models` (Civitai labels
like `Flux.1 D`, `SDXL 1.0`, `SD 1.5`, `Pony`, `Illustrious`, `Wan Video`)
into `--base-model` repeats. They return `model_id` and `version_id` for
direct download; they also read the card's `trainedWords` and surface them
as the trigger words to use after install.

[source: https://artokun.mintlify.app/tools/models -- `search_civitai_models`
+ `download_civitai_model` tool spec]

## 3.3 Mesh fit for Civitai

- **Herm (S22 phone, ~8 GB usable RAM)**: only GGUF / FP8 / pruner SDXL
  variants; even then, full T2I is 6-8 GB VRAM. Treat the S22 as a Civitai
  *browser* (REST queries, card inspection) and a download-aggregator into
  the GDrive backup target, not a runtime.
- **Worm (9185W tablet, ~4 GB usable RAM)**: SD 1.5 GGUF / lcm-lora only,
  and only on the GPU overlay; Civitai pulls are read-only metadata here.
  Worm is the catalog side: it stores `metadata.nextCursor` walks in
  `~/.hermes/cache/scratch/civitai-catalog/` and pushes manifests to the
  mesh.
- **Ace (iMac / dirt-imac, 2007 SSE3 + 32 GB RAM)**: CPU-only, runs
  llama.cpp and A1111 with `--no-half-vae` / `--medvram`; Civitai pulls
  target `models/Stable-diffusion/` and `models/Lora/` here because
  A1111 + SD 1.5 + LoRA fit the 2-core budget.
- **Mesh desktop (with 24-48 GB+ VRAM)**: full Flux / SDXL / Wan stack; this
  is where Civitai `--base-model Flux.1 D --sort "Most Downloaded"`
  --period Month translates into actual generation.

[source: worm-handoff mesh doc + 05-LOCAL-MODELS/runtimes/ollama.md +
vllm.md + 06-MULTIMODAL/image/automatic1111-config.md, all in the
consolidated UNMUZZLED-AI tree]

## 3.4 Anti-fingerprint / privacy posture

- Civitai tracks every download against the caller's account if logged in
  (the model page exposes `stats.downloadCount` per model; per-user
  downloads are visible to the creator). Use `civitai models search --anon`
  for an anonymous read, or use a throwaway account.
- API tokens are bearer tokens, scoped to a single Civitai user; the mesh
  does not store them (per `keys-roster.md` / fingerprint-only doctrine).
- Download URLs are signed for ~5-30 minutes; bulk download tooling should
  re-fetch rather than cache the URL.

# 4. Hugging Face (EPIC 154) -- deep sourcing

## 4.1 What is available

Hugging Face is the baseline git-based ecosystem. Asset classes:

- **Models** (LLM, vision-LLM, T2I, T2V, TTS, ASR, multi-modal)
- **Datasets** (training data, evaluation benchmarks, abliteration
  evaluation sets)
- **Spaces** (Gradio / Streamlit / Docker demos)
- **Inference Providers** (paid serverless inference via 12+ partner
  providers; replaces the legacy `api-inference.huggingface.co` which
  410'd in 2025)
- **GGUF / AWQ / EXL2 / GPTQ / BNB quantizations** (re-hosted by
  community quantizers; see section 6.6 of UNMODERATED-MODELS.md)
- **Abliterated / heretic / uncensored** model forks
  (4,967+ abliterated models, 2,164+ heretic models per the May 2026
  tally)
- **Safetensors** (the de-facto secure-pickle replacement; required by
  most downstream tooling)
- **Datasets** (raw parquet + dataset viewer)

[source: https://huggingface.co/models?other=uncensored +
https://github.com/clvv/hf-uncensored-model-popularity]

## 4.2 How to search (operators + tags + API)

### 4.2.1 Web UI filters

- Top-level filters: `Models` / `Datasets` / `Spaces`
- Library filter: `transformers`, `diffusers`, `sentence-transformers`,
  `timm`, `gguf`, `llama.cpp`, `transformers.js`, `vllm`, `sglang`,
  `text-generation-inference`, `mlx`, etc.
- Pipeline tag: `text-generation`, `text2text-generation`,
  `conversational`, `image-text-to-text`, `text-to-image`,
  `text-to-video`, `image-to-video`, `image-to-image`, `image-classification`,
  `automatic-speech-recognition`, `text-to-speech`, `fill-mask`,
  `token-classification`, `question-answering`, `table-question-answering`,
  `visual-question-answering`, `document-question-answering`,
  `zero-shot-classification`, `zero-shot-image-classification`,
  `feature-extraction`, `sentence-similarity`, `summarization`,
  `translation`, `audio-to-audio`, `audio-classification`, `voice-activity-detection`
- Other / `other=...` facet: model-id-or-tag matches like
  `cognitivecomputations` (sibling orgs), `uncensored`, `abliterated`,
  `heretic`, `censorless`, `no-censor`, `jailbreak`, `liberated`
  (the latter six are the operator's "uncensored" filter vocabulary,
  preserved verbatim from the `clvv/hf-uncensored-model-popularity`
  tracker)
- Sort: `Trending`, `Most downloads`, `Most likes`, `Recently updated`
- Inference filter: `Inference: Available` (shows models with a working
  serverless widget)

[source: https://huggingface.co/models?other=uncensored +
https://github.com/clvv/hf-uncensored-model-popularity -- the
"uncensored" numerator]

### 4.2.2 Direct URL searches (the operator's quick recipes)

```
https://huggingface.co/models?search=abliterated
https://huggingface.co/models?search=heretic
https://huggingface.co/models?search=uncensored
https://huggingface.co/models?search=abliterated&sort=downloads
https://huggingface.co/datasets?other=uncensored
https://huggingface.co/models?other=cognitivecomputations
```

Per the `bswen.com` operator guide, the consistent results come from
`abliterated` and `heretic` because those are technically defined in the
uncensoring community (Arditi's refusal-direction paper, then
`p-e-w`/`heretic-org` tooling). `uncensored` returns variable quality.

[source: https://docs.bswen.com/blog/2026-03-10-huggingface-uncensored-models-guide
-- "Primary search keywords" section]

### 4.2.3 REST API (`GET /api/models`)

```
GET https://huggingface.co/api/models?search=abliterated&limit=100
GET https://huggingface.co/api/models?search=heretic&sort=downloads
GET https://huggingface.co/api/datasets?other=uncensored
```

The `huggingface_hub` Python SDK is the canonical way to script:

```python
from huggingface_hub import HfApi
api = HfApi()
models = list(api.list_models(search="abliterated", limit=100))
for model in models[:10]:
    print(f"{model.id}: {model.downloads} downloads")
```

[source: https://docs.bswen.com/blog/2026-03-10-huggingface-uncensored-models-guide
-- Method 2 "Programmatic Search with HuggingFace API"]

### 4.2.4 Operator-curated collections (the discovery shortcut)

The DavidAU Heretic Collection is the single most-curated
`heretic+abliterated+uncensored` surface on HF:

```
https://huggingface.co/collections/DavidAU/heretic-abliterated-uncensored-unrestricted-power
```

These collections typically include detailed model cards explaining the
uncensoring methodology, benchmark comparisons with base models, and
usage examples + known limitations.

[source: https://docs.bswen.com/blog/2026-03-10-huggingface-uncensored-models-guide
-- "Method 3: Curated Collections"]

### 4.2.5 Curl-friendly "uncensored denominator" (the metric the mesh tracks)

The `clvv/hf-uncensored-model-popularity` repo's headline figure (May
2026): uncensored / heretic-tagged repos account for about **15.24%** of
rolling downloads among language-model-style repos; across all time
the share is **0.9% of downloads and 1.8% of repos**. The denominator
is `text-generation | text2text-generation | conversational |
image-text-to-text | gguf | llama.cpp`; the numerator is the subset
whose ID or tags include `uncensored | heretic | abliterated |
censorless | no-censor | nocensor | jailbreak | liberated`.

[source: https://github.com/clvv/hf-uncensored-model-popularity/README.md
-- "Method" section, preserved]

### 4.2.6 Sourcing examples (preserved operator picks, May 2026 era)

- `lukey03/Qwen3.5-9B-abliterated` -- abliterated 9B, fits 16 GB VRAM.
- `huihui-ai/Huihui-Qwen3.5-35B-A3B-abliterated` -- abliterated quantized
  MoE.
- `DavidAU/Qwen3.5-9B-Claude-4.6-HighIQ-THINKING-HERETIC-UNCENSORED` --
  heretic build.
- `fluffy/l3-8b-stheno-v3.2` -- community recommended; Sao10K lineage.
- `Dirty Shirley Writer V1` -- community recommended uncensored.
- `dphn/dolphin-2.9.2-Phi-3-Medium-abliterated` -- FailSpy /
  Cognitive Computations / Eric Hartford abliterated Phi-3-Medium qLoRA,
  with the methodology `Refusal in LLMs is mediated by a single
  direction` (Arditi 2406.11717) referenced verbatim in the model card.
  "This effectively uncensors the model whilst minimizing affecting
  other features in the model. ... You are advised to implement your
  own alignment layer before exposing the model as a service."
  [source: https://huggingface.co/dphn/dolphin-2.9.2-Phi-3-Medium-abliterated
  -- model card, preserved]
- `huihui-ai/Dolphin3.0-Llama3.1-8B-abliterated` -- "uncensored version
  of cognitivecomputations/Dolphin3.0-Llama3.1-8B created with
  abliteration (see remove-refusals-with-transformers to know more about
  it). This is a crude, proof-of-concept implementation to remove
  refusals from an LLM model without using TransformerLens."
  [source: https://huggingface.co/huihui-ai/Dolphin3.0-Llama3.1-8B-abliterated
  -- model card, preserved]
- `dealignai/DeepSeek-V4.1-Flash-UNCENSORED-FP8` -- 763B parameter
  uncensored; updated Sep 11; 78.3k downloads (the largest "uncensored"
  build by traffic at the May 2026 cutoff). [source:
  https://huggingface.co/models?other=uncensored]
- `DavidAU/Qwen3.8-27B-TURBO-Fable-Cold-Fusion-735-882-Heretic-Uncensored-NEO-CODER-MAX-MTP-GGUF`
  -- 27B, updated daily, 1.86M downloads.
  [source: same]

## 4.3 Inference Providers (replaces the legacy `api-inference.huggingface.co`)

The legacy `POST https://api-inference.huggingface.co/models/{model_id}`
endpoint now returns **410 Gone** or **404 Not Found** with the body
`https://api-inference.huggingface.co is no longer supported`. The
replacement is `https://router.huggingface.co/hf-inference` (router
endpoints) plus the Inference Providers marketplace (12+ partner
providers -- Together, fal, Replicate, Fireworks, Novita, Hyperbolic,
Sambanova, Cohere, Nscale, etc.). Mesh note: every provider has its own
moderation policy; the operator must pre-filter for "no refusal layer"
on the provider side or route through Venice / DeepSeek direct.

[source:
https://huggingface.co/datasets/John6666/knowledge_base_md_for_rag_1/blob/main/hf_legacy_inference_api_to_inference_providers_20251114.md
-- "For several years Hugging Face exposed..." section, preserved]

## 4.4 Mature-content / NSFW posture

- Hugging Face does **not** host a general NSFW-content filter at the
  model level. Per-repo licensing decides what is allowed; the platform
  enforces via DMCA + community reporting rather than a content classifier.
- The "uncensored" filter vocabulary (Section 4.2.5) is the de-facto NSFW
  signal: if a repo's ID or tags include those words, treat it as a
  refusal-free / content-permissive model.
- Operator safety: every uncensored model card contains a disclaimer
  ("You are responsible for any content you create using this model.
  Enjoy responsibly." -- Eric Hartford, Cognitive Computations). The
  mesh treats that as a hard rule: do not expose a hub uncensored model
  as a service without wrapping it in the abliteration / refusal-verify
  protocol (UNMODERATED-MODELS.md section 8 + 11-DETECTION-CANARIES).

## 4.5 Mesh fit for Hugging Face

- **Herm (S22 phone)**: HF is the canonical *browse* source on S22; the
  Hermes Agent Framework (EPIC 177) uses HF as its primary model backend
  via llama.cpp / gguf.
- **Worm (9185W tablet)**: HF is the *quantization ingest* source. Worm
  pulls `mradermacher/{model}-GGUF` and `DavidAU/{model}-GGUF` and stores
  them in `~/.hermes/cache/scratch/hf-pull/` for the mesh.
- **Ace (iMac, 2007 SSE3)**: HF pulls are *CPU-only*; `mradermacher`
  Q2_K / Q4_K_M and `llama.cpp` builds are the sweet spot. `llmfan46`
  and `0bserverx` re-distribute Heretic / Qwen / Llama GGUF packs for
  the SSE3 box.
- **Mesh desktop (with 24-48 GB+ VRAM)**: full BF16 / FP8 / AWQ;
  `autoawq`, `vllm`, and the Inference Providers market all land here.

[source: UNMODERATED-MODELS.md section 6 (build catalog by org) + section
7 (mesh fit by box RAM tier), all in the consolidated UNMUZZLED-AI tree]

## 4.6 Anti-fingerprint / privacy posture

- HF token storage: every mesh box uses the *fingerprint-only* doctrine
  from `04-PROVIDERS/keys-roster.md` (no key values stored; only
  model-name and last-3 hash).
- HF is a git LFS backend; `git lfs` pulls leave `.git` history that
  contains the caller's HF user. The mesh uses `huggingface_hub`'s
  `snapshot_download` (not `git clone`) to avoid this.
- Some "uncensored" repos are uploaded by anonymous accounts and may be
  taken down without notice; the mesh maintains a local copy in
  `~/.hermes/cache/scratch/hf-mirror/` and pushes to GDrive
  (`aimasterwes66:`).

# 5. Tensor.Art (EPIC 155) -- deep sourcing

## 5.1 What is available

Tensor.Art is a model aggregation + remote-inference platform. Asset
classes it indexes (as of the May 2026 catalog, preserved from
`tensor.art/models`):

- **Checkpoint** (SDXL, Illustrious, Flux, Wan, Krea_2, Z-Image-Turbo,
  Qwen, Wan Video 2.2)
- **LORA** (the most common type -- "LORA KREA_2", "LORA Illustrious",
  "LORA Z-Image-Turbo", "LORA Anima" are the dominant style classes)
- **Workflows** (ComfyUI JSON, importable into SwarmUI / ComfyUI local)
- **Online generation** (browser-based T2I, free tier with daily quota)
- **TAMS cloud jobs** (paid, programmatic via REST)

[source: https://tensor.art/ + https://tensor.art/models +
https://www.tensor.art/search]

## 5.2 Two surfaces: `tensor.art` (consumer) vs `tams.tensor.art` (API)

Tensor.Art is split between two distinct surfaces that the operator
must NOT confuse:

- `https://tensor.art/` -- the consumer site (browse, generate, browse
  community models, free daily Stamina).
- `https://tams.tensor.art/` -- the **T**ensor.Art **M**odel **S**ervice
  developer API (computational credits, 0.003 USD per credit, failures
  don't consume credits, 5 QPS rate limit, no exclusive GPU without
  shared queue, free trial on login).

TAMS credits are NOT interchangeable with Tensor.Art consumer membership
credits. TAMS is a separate billing surface.

[source: https://rawsignalai.com/developer-apis/generative-media/best-nsfw-image-generation-apis
-- "Tensor.Art TAMS" row, preserved]

## 5.3 How to search (the consumer web UI)

- Filters exposed on `https://www.tensor.art/search`:
  - `Model Types` (Checkpoint, LoRA, VAE, ControlNet, Workflow)
  - `Base Model` (SDXL, Illustrious, Pony, Flux, Wan, etc.)
  - `Tags` (community tags)
  - `Date Published`
  - `Creators`
  - `More Filters` (NSFW visibility if account allows, license, etc.)
- Sort: `Most Popular` / `Newest` / `Most Downloaded` (default sort on the
  consumer site is "Most Popular" by community signal).

[source: https://www.tensor.art/search -- filter labels preserved from
the search page UI]

## 5.4 TAMS API (programmatic)

TAMS does not publish a public REST API spec. The community reverse-
engineers it via the `Anakin Wire` aggregator (anakin.io exposes
`act_tensor_art_model_portal_listing` and `act_tensor_art_model_type_filter_options`
as paid, maintained endpoints). The 5 documented actions on Anakin
(preserved from the spec):

- `act_tensor_art_image_gallery_feed` (read) -- image feed with sort +
  visibility params.
- `act_tensor_art_model_type_filter_options` (read, 1 credit/call) --
  returns available model-type and project-type filter options.
- `act_tensor_art_model_portal_listing` (write, 2 credits/call) -- returns
  a paginated catalog of models with covers, owners, tags, and stats.
- `act_tensor_art_related_models_by_id` (write, 2 credits/call) --
  related models for a given id, with covers/stats/metadata.
- `act_tensor_art_workspace_*_list` (write, 2 credits/call) -- workspace
  listing endpoints.

[source: https://anakin.io/catalog/tensor-art -- "Tensor.Art API" section]

## 5.5 NSFW / mature-content posture (Tensor.Art)

- Tensor.Art's consumer site allows NSFW model uploads and has an
  account-level NSFW toggle.
- TAMS is a paid service; the NSFW rules are inherited from the consumer
  policy. The operator must re-check the per-model NSFW classification
  before bulk-importing into a generation pipeline.
- SeaArt (a competing consumer platform, NOT in the EPIC list) is on the
  RawSignal `5 Best NSFW APIs` shortlist *only as a UI exploration
  surface*; its FAQ "strictly filters NSFW" and bans pornographic
  generation, so the mesh treats SeaArt as a SFW-only discovery tool.

[source: https://rawsignalai.com/developer-apis/generative-media/best-nsfw-image-generation-apis
-- SeaArt vs Tensor.Art section, preserved]

## 5.6 Sourcing examples

- `Wan2.2-t2v-a14b` -- current top model on the consumer site (text-to-
  video 14B).
- `LORA KREA_2` -- the most common LoRA style class (Krea 2 base, anime
  + semi-realistic).
- `LORA Illustrious` -- SDXL-based Illustrious LoRAs (anime focus).
- `LORA Z-Image-Turbo` -- Z-Image-Turbo LoRAs (the 2026 Turbo-LoRA
  trend, ~4-8 step generation).

[source: https://tensor.art/models -- the page heading surface, preserved]

## 5.7 Mesh fit for Tensor.Art

- **Herm (S22 phone)**: Tensor.Art is a *browse* source on the S22; the
  mobile UI works in Termux browser.
- **Worm (9185W tablet)**: the operator pulls the Tensor.Art catalog
  manifest into `~/.hermes/cache/scratch/tensor-art-catalog/` for offline
  reference. No runtime on the tablet.
- **Ace (iMac, 2007 SSE3)**: not a runtime target; Ace uses the
  Tensor.Art consumer site for UI exploration only.
- **Mesh desktop (24-48 GB+ VRAM)**: the only box that can actually
  run the consumer T2I jobs; TAMS API is a paid alternative when the
  desktop GPU is busy.

[source: worm-handoff mesh doc; aligns with 05-LOCAL-MODELS/runtimes/vllm.md
+ 06-MULTIMODAL/image/comfyui-workflow.md]

# 6. LiblibAI (EPIC 156) -- deep sourcing

## 6.1 What is available

LiblibAI (哩布哩布 AI) is the "Chinese Civitai" -- the largest AI art
model sharing and creation community in mainland China, run by Beijing
Qidian Xingyu Technology (founded by ex-Tencent / Alibaba / ByteDance
staff, team from Tsinghua / PKU / CMU). Per the operator source-of-truth
(`flowcay.com/site/liblib-ai`), LiblibAI 2.0 aggregates:

- **100,000+ community-trained models** (Stable Diffusion checkpoints +
  LoRAs) covering anime, realistic, portrait, photography, e-commerce,
  traditional Chinese style, IP design.
- **SOTA model aggregation (LiblibAI 2.0)**:
  - Image: Qwen Image, FLUX, F.1/Kontext, Seedream 4/5, Midjourney V7,
    Star-3.
  - Video: Kling 3.0, Hailuo, Vidu, WAN, Seedance 2.0/2.5.
- **500+ cinematic VFX templates** ("5-second effects, 60-second film").
- **Browser-based LoRA training** (10-20 images, pick a preset, train in
  the cloud, no GPU needed).
- **Three creation interfaces**: 极简生成器 (Minimal Generator) / WebUI /
  ComfyUI; all from one account, no platform switching.

[source: https://flowcay.com/site/liblib-ai + https://www.aihub.cn/tools/image/liblibai/
+ https://flowith.io/blog/liblib-art-2026-community-driven-model-ecosystem-chinese-ai-artists]

## 6.2 How to search

Liblib's community-driven ranking (default sort on model search) is a
weighted score combining: download count + like-to-download ratio +
gallery usage frequency (how often the model appears in gallery
submissions) + recency. This means the community effectively curates
the model library -- low-quality / duplicative models sink.

The default model search filters (preserved from `seoaiu.com/en/tool-detail/liblib-ai`):

- Style categories: anime, photorealism, illustration, architectural
  design, interior design, game assets, portrait photography, mecha,
  traditional Chinese style, etc.
- Type: Checkpoint, LoRA, ControlNet, VAE.
- Pricing tier: free, paid-downloads (the platform takes a 15% commission
  cut on paid downloads / tips).

[source: https://seoaiu.com/en/tool-detail/liblib-ai -- "LoRA Model
Training" + "Target User Groups" sections, preserved]

## 6.3 NSFW / mature-content posture (LiblibAI-specific)

LiblibAI operates under China's generative-AI regulations:

- Real-name authentication for all uploaders.
- AI-generated content labeling on all outputs.
- Prohibited content filtering: political, violent, pornographic.

The platform supplements automated filtering with a community moderation
team of approximately 200 volunteer reviewers who handle edge cases and
appeals. **Effective policy: LiblibAI is SFW-only by law; the mesh
treats it as a discovery surface for anime / traditional Chinese / IP-
style models, not for NSFW.**

[source: https://flowith.io/blog/liblib-art-2026-community-driven-model-ecosystem-chinese-ai-artists
-- "Platform policies" section, preserved]

## 6.4 Community scale (preserved, March 2026 numbers)

- 800,000+ registered creators.
- 4,200+ verified model authors.
- Daily gallery submission rate exceeding 25,000 images.
- ~350 new models per day in Q1 2026 (vs ~200/day on Civitai globally).

[source: https://flowith.io/blog/liblib-art-2026-community-driven-model-ecosystem-chinese-ai-artists
-- "Step 1" section, preserved]

## 6.5 Community chat integration (the operator's outreach note)

Liblib's outreach is through Chinese-native channels, NOT Discord /
Reddit:

- Official WeChat groups for model categories (anime, photorealism,
  architecture, etc.).
- QQ channels for real-time tech support and prompt sharing.
- WeChat Mini Program for mobile gallery browsing.

[source: same `flowith.io` source, "Community Discussion" section]

## 6.6 Sourcing example (the "万物皆国画" LoRA, preserved)

Model: "开心Ai-万物皆国画-动漫二次元融合国风-LoRA-开心Ai-LiblibAI"
URL: https://liblib.art/modelinfo/82c25a0ef6be4b35b143e2c8f1b3a6a0

Triggers (verbatim from model card):
- `anime chinese painting style` (REQUIRED)
- `chinese painting,chinese watercolor` (recommended, not required)

A ComfyUI workflow is mirrored on the platform and searchable as
"FLUX.1-万物皆国画-动漫二次元融合国风-by 开心Ai".

[source: https://liblib.art/modelinfo/82c25a0ef6be4b35b143e2c8f1b3a6a0
-- "触发器" section, preserved]

## 6.7 Mesh fit for LiblibAI

- **Herm (S22 phone)**: not a primary source; the S22 doesn't have
  reliable mainland-China network access from a T-Mobile MVNO. Liblib is
  browsed via Termux browser on the desktop mesh box.
- **Worm (9185W tablet)**: same; not a runtime target. Used as a
  reference catalog for the *Wan / Qwen / Z-Image-Turbo* asset class.
- **Ace (iMac, 2007 SSE3)**: SSE3 is the bottleneck for any Z-Image
  Turbo / Flux-class model; Ace is not a runtime target.
- **Mesh desktop (24-48 GB+ VRAM)**: the only box that can run Liblib's
  top-end SOTA models (Qwen Image, FLUX, F.1/Kontext, Seedream 4/5,
  Midjourney V7-class inference).

# 7. Mage.space (EPIC 157) -- deep sourcing

## 7.1 What is available

Mage.space is a free + paid AI image / video / audio generation
platform. From the official site (`https://www.mage.space/`):

- **Model coverage**: SD 1.5, SDXL, SD3.5, Flux, Flux 2, Chroma, Krea 2,
  Z-Image, Qwen, Wan, FramePack, Nano Banana, Veo, plus Mage-exclusive
  fine-tunes: **Mango, Guava, Kiwi, Peach, Cherry, Blueberry, Raspberry,
  Berry, Melon, Plum**.
- **Image + Video + Audio** generation.
- **API** (in limited beta; contact mage@mage.space).
- **Open-source SDKs** on `github.com/mage-space` (TypeScript + Python
  SDKs, plus ComfyUI nodes).

[source: https://www.mage.space/ + https://docs.mage.space/ -- the
"Models" + "Where things live" sections, preserved]

## 7.2 Membership tiers (preserved from mage.space pricing)

| Tier | Price | Features |
| --- | --- | --- |
| Free | $0/mo | Limited access, 300 Gems sign-up bonus |
| Basic | $10/mo | Unlimited generations, 2x faster, Verified Account, Unlock Gem Access, Base Models + LoRAs, Inpainting + Refine, 500 monthly Gems |
| Pro | $30/mo | Everything in Basic, Unlimited Video, Unlimited Character Creation, 4x faster, Premium Base Models, Enhance 2K, ControlNet + Animate, 1,500 monthly Gems |
| Pro Plus | $60/mo | Everything in Pro, Premium Video Models, Enhance 4K, Multiple LoRAs (5x), Import Custom Models, Queue up to 10, 3,500 monthly Gems |
| Max | $200/mo | Everything in Pro Plus, full Base AI Model lineup + LoRA up to 5 + Textual Inversion up to 5 |

[source: https://www.mage.space/ -- "Mage Membership" section, preserved]

## 7.3 Mage API surface (the operator's programmatic path)

Mage has its own API at `https://api.mage.space/`. The OpenAPI 3.1 spec
is served from `https://docs.mage.space/` and includes:

- `POST /v1/flux2/generate` -- Flux 2 Dev (default model, 40 Gems at
  default settings; image + up to 3 reference images; no @handle mentions).
- `GET /v1/account` -- Gems balance.
- `POST /v1/{model}/generate` -- one endpoint per audio / image
  architecture.

Response shape (Flux 2, preserved):

```json
{
  "id": "...",
  "type": "image",
  "url": "https://cdn.mage.space/...",
  "width": 1024,
  "height": 1024,
  "seed": 1234567,
  "expires_at": "2026-06-15T00:00:00Z",
  "moderation": { "nsfw": false }
}
```

[source: https://docs.mage.space/api/models/flux2 -- OpenAPI 3.1 spec,
preserved]

## 7.4 NSFW / mature-content posture (Mage)

- Mage's marketing explicitly says "Unlimited & Uncensored AI Image &
  Video Generator", "Free to start and NSFW allowed", and the API
  response carries a `moderation.nsfw` flag for downstream filtering.
- The model lineup (Mango / Guava / Kiwi / etc.) is built specifically
  for "greater creative freedom" -- the platform's positioning vs Civitai
  is "no per-asset moderation, paid Gems for any model".
- Operator caveat: Mage API is in limited beta; the operator must
  request access via mage@mage.space and the terms-of-service still
  forbid CSAM and non-consensual intimate imagery.

[source: https://www.mage.space/ -- "Mage Membership" + FAQ, preserved]

## 7.5 Mesh fit for Mage.space

- **Herm (S22 phone)**: Mage is a *browse* source; the mobile UI is
  responsive.
- **Worm (9185W tablet)**: Mage is not a runtime target; the operator
  pulls the Mage-exclusive model catalog (Mango / Guava / etc.) into
  `~/.hermes/cache/scratch/mage-catalog/` and tracks which ones are
  re-hosted on Civitai / HF (Mage is a consumer platform; the weights
  are not downloadable in most cases).
- **Ace (iMac, 2007 SSE3)**: not a runtime target.
- **Mesh desktop (24-48 GB+ VRAM)**: the only box that benefits from
  Mage's API Gems economy when the local SD 1.5 / SDXL pipeline is
  already saturated.

# 8. OpenModelDB (EPIC 158) -- deep sourcing

## 8.1 What is available

OpenModelDB is the *only* community database dedicated to AI upscaling
and restoration models. From the official site (`https://openmodeldb.info/`):

"OpenModelDB is a community driven database of AI Upscaling models. We
aim to provide a better way to find and compare models than existing
sources."

Per the GitHub mirror (`openmodeldb/open-model-database`):

- 600+ AI upscaling models with detailed information.
- Compare models side-by-side with example images.
- Filter by architecture, scale, tags, and more.
- View model metadata including training details and licenses.
- Download models from various sources (direct, GitHub, Hugging Face,
  Google Drive, MediaFire, Mega.nz).

[source: https://openmodeldb.info/ + https://github.com/openmodeldb/open-model-database]

## 8.2 Asset classes (preserved, with concrete examples)

- **Real-ESRGAN family**: `4x-realesrgan-x4plus`, `4x-realesrgan-x4plus-anime-6b`,
  `4x-NMKD-Siax-CX`, `4x-realesrgan-x4plus-anime`.
- **SwinIR family**: `2x-classicalSR-DF2K-s64w8-SwinIR-M`.
- **CUGAN** (Real-CUGAN, anime-tuned).
- **DAT** (Deformable Attention Transformer).
- **ATD** (Adaptive Token Dictionary).
- **Compact** (low-VRAM variants: `1x-SkinContrast-High-SuperUltraCompact`,
  `1x-SkinContrast-SuperUltraCompact`, `1x-Anti-Aliasing`,
  `2x-DigitalFlim-SuperUltraCompact`, `2x-HFA2kAVCCompact`).
- **Nomos / Nomos8k** (`4xNomos8k_atd_jpg`).
- **Custom community upscalers**: `4x_RealisticRescaler_100000_G`
  (Mutin Choler; trained for realistic low-res texture upscaling
  including GameCube textures; dataset DIV2K, Flick2R, AmbientCG,
  Poly Haven, nomos2k).
- **Anti-aliasing**: `1x-Anti-Aliasing` (general purpose).
- **Skin detail**: `1x-SkinContrast-High-SuperUltraCompact`,
  `1x-SkinContrast-SuperUltraCompact` (skin preservation at scale 1x).

[source: https://civitai.com/models/318385/4xrealisticrescaler100000g
+ https://civarchive.com/models/1032584 -- model pages + dataset
descriptions, preserved]

## 8.3 How to search (the operator's quick recipe)

- Web UI: `https://openmodeldb.info/` -- browse + filter by:
  - `scale` (1x, 2x, 4x, 8x)
  - `architecture` (atd, compact, cugan, dat, realesrgan, swinir, etc.)
  - `tag` (anime, denoise, photo, skin, jpeg, bc1, etc.)
  - `sort` (date-desc, downloads, rating)
  - `q` (free-text search; e.g. `?sort=date-desc&q=skin`)

[source: https://openmodeldb.info/?sort=date-desc&q=skin -- URL preserves
the filter syntax]

### 8.3.1 PyPI client (`openmodeldb`, matth-blt)

```bash
openmodeldb                              # interactive: scale -> pick model -> download
openmodeldb list [--scale N] [--arch ARCH] [--tag TAG]
openmodeldb search QUERY
openmodeldb download NAME [--format FMT] [--dest DIR] [--half] [--all]
openmodeldb check FILE                   # verify a local file against the reference
```

Python API:

```python
from openmodeldb import OpenModelDB
db = OpenModelDB()  # <OpenModelDB: 658 models>
db.list(scale=4)
db.list(scale=1, architecture="compact")
db.find(scale=4)  # list[Model]
db.find(scale=1, architecture="compact")
db.search("denoise")
db.download("4xNomos8k_atd_jpg")
db.download("2x-HFA2kAVCCompact", format="safetensors")  # auto-convert
db.download("4xNomos8k_atd_jpg", format="onnx", half=True)  # FP16 ONNX
db.download_all("4xNomos8k_atd_jpg")
db.architectures()  # ['atd', 'compact', 'cugan', 'dat', ...]
db.tags()           # ['anime', 'denoise', 'photo', ...]
```

[source: https://pypi.org/project/openmodeldb/ -- README preserved]

## 8.4 NSFW / mature-content posture

OpenModelDB is asset-agnostic. The upscaler weights are mathematical
operators; they don't carry content. NSFW posture is decided by the
*base checkpoint* the upscaler is paired with, not by the upscaler
itself. The mesh treats OpenModelDB as a non-issue on the NSFW axis.

## 8.5 Mesh fit for OpenModelDB

- **Herm (S22 phone)**: the SD 1.5 + 4x-UltraSharp pipeline runs on the
  S22; OpenModelDB is the canonical source for `4x-UltraSharp` and
  `4x-NMKD-Siax-CX`.
- **Worm (9185W tablet)**: the ComfyUI installation on Worm uses
  `4x-realesrgan-x4plus-anime-6b` and `1x-SkinContrast-High-SuperUltraCompact`
  as the default upscaler stack.
- **Ace (iMac, 2007 SSE3)**: the A1111 installation on Ace uses
  `4x_RealisticRescaler_100000_G` (Mutin Choler) for GameCube-texture-
  style photo enhancement.
- **Mesh desktop (24-48 GB+ VRAM)**: the ComfyUI + Forge stack uses
  `2x-classicalSR-DF2K-s64w8-SwinIR-M` + `1x-Anti-Aliasing` for the
  SDXL-to-Flux refine pipeline.

[source: https://github.com/fewjative/cog-ultimate-sd-upscale +
https://civarchive.com/models/1032584 -- pipeline install notes,
preserved]

# 9. Chub (extra) -- character-card hub, not in EPIC 153-158 but the canonical surface for SillyTavern

## 9.1 What is available

Chub is the largest TavernAI V2 / V3 character card hub. Asset classes:

- **Character cards** (TavernAI V2 spec: PNG with `chara` tEXt chunk
  containing Base64-encoded UTF-8 JSON; TavernAI V3 spec: additional
  `ccv3` tEXt chunk with V3-only fields like `assets`, `nickname`,
  `group_only_greetings`, `creator_notes_multilingual`).
- **Lorebooks** (V2 / V3 character_book field).
- **Creator profiles** (`fullPath` = `creator/card-slug`).
- **Image asset gallery** (per card).
- **Forks / remixes** (community can fork a card and ship a modified
  version; Chub tracks the fork lineage).

[source: https://character-tavern.com/character/catalog?tags=NSFW +
https://tavernai.cards/blog/export-card-to-chub-manually +
https://termo.ai/skills/sillytavern-cards-skill]

## 9.2 How to search

### 9.2.1 Web UI

`https://chub.ai/characters` -- search box, filter by:
- `Tags` (Topics)
- `Creator ID`
- `Token Count` (Min / Max)
- `Date Created` (Max Days Ago)
- `NSFW` / `NSFL` content flags
- `New Search Presets`: "Latest", "Trending", "Recent Hits".

### 9.2.2 REST API (`GET https://api.chub.ai/search`)

The canonical search endpoint, with parameters preserved from the
`chub_downloader` and `gallery-dl` reverse-engineering work:

```
GET https://api.chub.ai/search?
    first=50
    &page=1
    &sort=created_at
    &nsfw=true
    &nsfl=true
    &chub=true
    &count=true
    &topics=
    &exclude_mine=true
    &include_forks=true
    &username=...
    &search=...
    &min_tokens=0
```

Sort options: `last_activity_at` / `created_at` / `rating` / etc.

Required headers: `User-Agent: SillyTavern` (the community-documented
quirk; some endpoints reject non-`SillyTavern` UAs).

Rate limit: the community reverse-engineered `429` with exponential
backoff (up to 5 retries) plus a 0.1-second throttle between paginated
calls. The `chub_downloader` tool documents this verbatim.

[source: https://codeberg.org/mikf/gallery-dl/issues/60 +
https://github.com/Samueras/chub_downloader/blob/main/chub_stats_server.py
+ https://github.com/Samueras/chub_downloader/releases -- reverse-
engineering, preserved]

### 9.2.3 Bash one-liner (SillyTavern-compatible search, preserved)

```bash
curl -s -H "User-Agent: SillyTavern" \
  "https://api.chub.ai/search?search=<query>&first=10&page=1&sort=last_activity_at&nsfw=false" \
  | node -e "const d=JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')); \
    const nodes=d.data?.nodes||d.nodes||[]; \
    nodes.forEach((n,i)=>{ \
      const c=n.node||n; \
      console.log((i+1)+'. '+c.name+' by '+(c.fullPath||'').split('/')[0]); \
      console.log('   '+c.tagline?.substring(0,100)); \
      console.log('   Source: Chub.ai | https://chub.ai/characters/'+c.fullPath); \
    });"
```

[source: https://termo.ai/skills/sillytavern-cards-skill + replicated at
https://implexa.ai/s/clawhub/sillytavern-cards-skill -- the operator's
template, preserved]

### 9.2.4 NSFW auto-classification quirk

Chub auto-suggests NSFW classification based on description / tags /
first-message content. If the card is SFW but describes a tavern
barfight, or NSFW but uses oblique language, the auto-suggestion can be
off. **Manually set the flag before publishing** -- fixing it after
the card has been recommended to the wrong audience is slower than
getting it right up-front.

[source: https://tavernai.cards/blog/export-card-to-chub-manually --
"NSFW auto-classification doesn't match your intent" section, preserved]

## 9.3 Chub card spec (V2 vs V3, the operator's load-bearing detail)

V2 wraps the payload in an envelope:

```json
{
  "spec": "chara_card_v2",
  "spec_version": "2.0",
  "data": {
    "name": "...",
    "description": "...",
    "personality": "...",
    "scenario": "...",
    "first_mes": "...",
    "mes_example": "...",
    "system_prompt": "...",
    "post_history_instructions": "...",
    "alternate_greetings": ["..."],
    "tags": ["..."],
    "creator": "...",
    "creator_notes": "...",
    "character_version": "1.0",
    "character_book": { "entries": [{ "keys": ["..."], "content": "...",
                                       "enabled": true, "selective": false,
                                       "secondary_keys": [], "constant": false,
                                       "position": "before_char" }] },
    "extensions": {}
  }
}
```

V3 uses `spec: "chara_card_v3"` and adds `assets`, `nickname`,
`group_only_greetings`, `creator_notes_multilingual`.

[source: https://tavernai.cards/blog/import-chub-card-to-sillytavern --
"V2 vs V3" spec breakdown, preserved]

### 9.3.1 The "spec_v2 error" trap (operator's most-asked Reddit question)

When SillyTavern complains about `spec_v2`, the underlying issue is
almost always one of two things:

1. **The PNG was laundered in transit and the tEXt chunk is gone.**
   Ancillary PNG chunks like `tEXt` can be dropped by anything that
   re-encodes the image: image editors saving via "Export As",
   browsers round-tripping through canvas, social platforms running
   EXIF sanitisers, CDNs with image optimisation (Cloudflare Polish,
   Vercel `/_next/image`, Cloudinary auto-format). If you saved by
   right-clicking a Discord preview, screenshotting the Chub gallery,
   or copying out of a chat client, the metadata is gone and
   SillyTavern has nothing to parse. Verify with `pngcheck -t card.png`;
   if neither `chara` nor `ccv3` shows up, that is the cause.
   Re-download via Chub's **Download** button directly to disk.
2. **The card ships `ccv3` only and your SillyTavern is older than
   V3 support.** Some cards exported in the V3 era no longer include
   a `chara` fallback. SillyTavern builds prior to V3 landing have no
   idea what `ccv3` is, fall back to looking for the V2 chunk, find
   none, and surface a spec-version-shaped error.

[source: https://tavernai.cards/blog/import-chub-card-to-sillytavern --
"When SillyTavern complains about spec_v2" section, preserved]

## 9.4 Card creation (write-side posture)

- Chub's public docs cover the chat-side "API Connections" flow (plugging
  external LLM keys like OpenAI / Anthropic into Chub chats). Card
  creation is documented as a web-UI form, not an API endpoint.
- The download path most third-party tools use looks like a GitLab REST
  URL (`gateway.chub.ai/api/v4/projects/.../repository/files/.../raw`)
  because Chub stores card assets in GitLab. The corresponding write
  endpoint exists in the GitLab REST spec, but writing requires a token
  that Chub controls internally -- that token is **not issued to third
  parties**.
- The community has tracked tightening on the read path too (e.g.
  SillyTavern issue #4011 from May 2025: URL-import returning "Method
  Not Allowed"). If the read side is moving, the write side is not
  opening any time soon.
- **Pragmatic answer: "manual web upload, one card at a time."**

[source: https://tavernai.cards/blog/export-card-to-chub-manually --
"TL;DR" + "Why this is the answer" sections, preserved]

### 9.4.1 Upload procedure (5 steps, preserved)

1. Get the card as a clean V2 PNG with the `chara` chunk intact (export
   from SillyTavern, or round-trip via the `tavernai.cards` converter).
2. Sign in at `chub.ai` and open **Create -> Character**.
3. Drop the PNG into the image slot, fill in name / tagline / description
   fields, set tags + NSFW classification.
4. Set visibility (Public / Unlisted / Private) and publish.
5. Open the published card page in a clean browser tab and verify
   avatar + greeting + lorebook against your source.

Tags: Chub's search relies heavily on these; aim for 5-10 relevant ones.

[source: https://tavernai.cards/blog/export-card-to-chub-manually -- "TL;DR
-- Upload in five steps" section, preserved]

## 9.5 Mesh fit for Chub

- **Herm (S22 phone)**: Chub is the primary character-card source for
  the SillyTavern / RisuAI frontends on the S22 (EPIC 189, 190).
- **Worm (9185W tablet)**: not a primary consumer; Worm hosts a Chub
  card mirror in `~/.hermes/cache/scratch/chub-mirror/` and pushes
  curated card sets to the mesh.
- **Ace (iMac, 2007 SSE3)**: not a primary consumer; Ace hosts the
  `tavernai.cards converter` (lint before publish) for the operator's
  card pipeline.
- **Mesh desktop (24-48 GB+ VRAM)**: the operator's main SillyTavern
  instance lives here, with a Chub card library of ~10,000+ cards
  cached locally and `vectors.json` rebuilt nightly.

# 10. Apertis (extra) -- uncensored-LLM hub, NOT in EPIC 153-158 but the canonical perverse-models lane

## 10.1 Two things called "Apertis" / "Apertus" -- DO NOT CONFUSE

The ecosystem has TWO adjacent projects that share a near-identical name.
Operators must distinguish:

- **Swiss Apertus** (a.k.a. Apertus v1.1; the Swiss AI Initiative;
  EPFL + ETH Zurich + CSCS; fully-open 0.5B / 1.5B / 4B parameters;
  Hugging Face org `swiss-ai`; Ollama mirror `MichelRosselli/apertus-v1.1:1.5b-instruct-bf16`).
  This is the public, well-documented, **compliant** model family. It
  is a *standard* open-weight model, not "uncensored" in the
  community sense.

- **apertus.cc** (no affiliation with the Swiss Initiative; a paid
  OpenAI-compatible REST API at `https://api.apertus.cc/v1/`;
  ~$0.25/M input tokens, $1.00/M output tokens, 100K token context;
  crypto payments only -- USDT TRC20 or USDC Base; only minor-sexual
  content is blocked). The model's published identity is "uncensored"
  in the marketing, but the underlying weights are a single
  open-weight model running on apertus.cc infrastructure.

[source: https://registry.ollama.com/MichelRosselli/apertus-v1.1:1.5b-instruct-bf16
+ https://apertus.cc/ + https://apertus.cc/docs -- both surfaced, the
operator must read both before consuming either]

The mesh's policy: "Apertis" (lowercase 'is' in the title, `apertus.cc`
domain) is the perverse-models / uncensored-LLM lane referenced in
this file. "Apertus" (Swiss AI) is referenced in 13-REFERENCE-PAPERS
under its own paper / blog post and is treated as a *compliant* model
family. The two are not interchangeable; the names are NOT a typo
variant of each other -- they are separate projects with overlapping
vocabulary.

## 10.2 What is available on `apertus.cc`

- Single model: `uncensored` (the model_id to use in API calls).
- 100,000 token context, max 32,000 token output per request, 2,048 if
  `max_tokens` is unset.
- Streaming via SSE, function calling, JSON mode.
- `temperature`, `top_p`, `seed` parameters.
- Drop-in OpenAI SDK compatibility -- set `base_url` to
  `https://api.apertus.cc/v1` and the model to `uncensored`.
- Free trial: $0.50 trial credit.
- Rate limit: 300 requests per minute.
- `GET /v1/models` to verify connectivity.

[source: https://apertus.cc/ + https://apertus.cc/docs -- "What you get"
+ "Quickstart" sections, preserved]

## 10.3 How to call (the operator's cURL template, preserved)

```bash
curl https://api.apertus.cc/v1/chat/completions \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "uncensored",
    "messages": [{"role": "user", "content": "Write a blunt product review of a cheap VPN."}]
  }'
```

Python SDK:

```python
from openai import OpenAI
client = OpenAI(base_url="https://api.apertus.cc/v1", api_key=API_KEY)
resp = client.chat.completions.create(
    model="uncensored",
    messages=[{"role": "user", "content": "Summarise this thread without softening it."}],
)
print(resp.choices[0].message.content)
```

[source: https://apertus.cc/docs -- "Use the official openai Python SDK
to interact with the API" section, preserved]

## 10.4 NSFW / mature-content posture (apertus.cc)

- Marketing: "Uncensored Model. Our open-weight model answers without
  refusing lawful adult, fictional, or controversial topics. Only minor
  sexual content is blocked."
- "Why Uncensored Matters" -- "Many models refuse valid prompts based
  on subjective safety filters. Apertus provides an uncensored
  alternative for developers who want predictable behavior. Our model
  answers lawful adult, fictional, and controversial topics without
  unnecessary restrictions. This is critical for applications where
  content control is handled by the user, not the API."
- Explicit carve-out: "This is a hard limit that always applies" --
  minor sexual content. Everything else is permissive.

[source: https://apertus.cc/ -- "Why Uncensored Matters" + "Does the
model refuse content?" sections, preserved]

## 10.5 Mesh fit for apertus.cc

- **Herm (S22 phone)**: the Hermes Agent Framework (EPIC 177) already
  wraps OpenAI-compatible clients; apertus.cc is a one-line `base_url`
  swap. S22's tight RAM budget doesn't allow local uncensored at the
  70B+ tier; apertus.cc is the API escape hatch.
- **Worm (9185W tablet)**: not a primary consumer; the operator uses
  apertus.cc for ad-hoc uncensored generation when the local Dolphin /
  Mistral-abliterated stack is saturated.
- **Ace (iMac, 2007 SSE3)**: not a primary consumer; the SSE3 box
  cannot run any LLM above ~7B, so the apertus.cc API is the only
  path to >13B uncensored.
- **Mesh desktop (24-48 GB+ VRAM)**: the desktop runs Nous Hermes 4
  70B abliterated locally; apertus.cc is a backup, not a primary.

# 11. eHentai cross-reference (extra) -- the operator's provenance index

## 11.1 What eHentai is and is not

- eHentai (`https://e-hentai.org/`) and its sister `https://exhentai.org/`
  are *gallery* sites (doujinshi / manga / art aggregation). They are
  NOT a model hub.
- Their relevance to the community-hubs workflow is **provenance
  anchoring**: the SD / SDXL / Flux / Wan fine-tune community uses
  eHentai's tagging taxonomy (artist, character, series, style) as
  the canonical label set for LoRA / embedding training data. The
  "tag-complete" repository on HF
  (`https://huggingface.co/Toc/toc/blob/main/ex/tag-complete/README.md`)
  is the operator's bridge: it embeds the eHentai-derived tags as
  searchable text inside HF model cards.
- ExHentai has a banner-based gate (donation / age verification) that
  most browsing tools bypass; the mesh treats ExHentai as a read-only
  reference, never as a runtime target.

[source: https://huggingface.co/Toc/toc -- "ex/tag-complete" README,
preserved]

## 11.2 eHentai / HF cross-search tactics (the operator's playbook)

The `toc/toc` repo formalizes the cross-walk between eHentai tags and
HF model search. Concrete tactics preserved from the README:

- **Embedding type filter**: "Embeddings trained for Stable Diffusion
  1.x or 2.x models respectively are incompatible with the other type.
  To make it easier to find valid embeds, they are categorized by
  'v1 Embedding' and 'v2 Embedding', including a slight color
  difference. You can also filter your search to include only v1 or
  v2 embeddings by typing `<v1/2` or `<e:v1/2` followed by the actual
  search term."

  Example: `<e:v1 character_name` returns only v1-compatible embeddings
  for that character.

[source: https://huggingface.co/Toc/toc -- "Embedding type filtering"
section, preserved]

### 11.2.1 The NAI LoRA index (the LoRA-eHentai crosswalk, preserved)

Repository: `https://huggingface.co/Starlento/sd-nai-lora-index`

"Stable Diffusion NAI lora Index -- This repo is for indexing NovelAI
related LoRA works in huggingface. Preview the 'good models' with no
'explaination' in their repos using a benchmark. You may use CTRL+F to
find keywords you are interested to quickly get the source."

Caveat (preserved verbatim): "Note that NSFW will not be included since
I cannot put previews."

Indexed LoRA series (partial, preserved): `char-416-space, char-antonia-og,
char-april, char-cms-gn, char-cms-og, char-florine, char-g41space,
char-gronru, char-kyaru-gn, char-madoka, char-qu, char-siobhan, char-sop2anni,
char-sophia, char-sp9-og, char-toka-dancer, char-toru-generalized, char-toru,
char-vepley, char-zas-wq, char-m16a1 (I cannot generate)`.

[source: https://huggingface.co/Starlento/sd-nai-lora-index -- README,
preserved]

### 11.2.2 The community LoRA archive projects

Several HF organizations archive the SD 1.5 / SDXL / DoRA LoRA deluge.
These are the operator's "where did that LoRA go" fallback when the
creator's original repo is taken down:

- `LMFResearchSociety/SD1LoRAArchive` -- "Update: We ran out of public
  storage. No more uploads going forward. This repo will probably stay
  up as long until I need more storage space for the organization, in
  which case it will probably be deleted. I recommend you back up the
  models you want to preserve."
  [source: https://huggingface.co/LMFResearchSociety/SD1LoRAArchive --
  README, preserved]
- `LMFResearchSociety/SDXLDoRAArchive` -- SDXL DoRA archive, same
  provenance.
  [source: https://huggingface.co/LMFResearchSociety/SDXLDoRAArchive --
  README, preserved]
- `pettankoutei/Loras` -- 1.4 GB of LoRAs, branched by SD 1.5 / SDXL /
  Flux subdirs.
  [source: https://huggingface.co/pettankoutei/Loras -- README,
  preserved]
- `Chroma111/CivitAI-Archive` -- community mirror of Civitai model
  cards, useful when Civitai takes down a model that the operator
  pulled metadata for.
  [source: https://huggingface.co/Chroma111/CivitAI-Archive -- README,
  preserved]

## 11.3 eHentai tagging vocabulary vs HF model tags

The eHentai namespace is dense; the operator uses the following bridge:

- eHentai artist name (e.g. `ciloranko`) -> HF search `ciloranko style`
  -> finds LoRAs trained on that artist's work.
- eHentai character name (e.g. `florine`) -> HF search `florine` ->
  finds character LoRAs / embeddings.
- eHentai series tag (e.g. `touhou`) -> HF search `touhou` -> finds
  series LoRAs.
- eHentai style tag (e.g. `full color`, `anal`, `yuri`) -> HF search
  the style tag -> finds style LoRAs. NOTE: most style LoRAs are SFW
  on the HF side because the platform's content classifier is stricter
  than Civitai; the operator must check the *creator's* repo for
  explicit-style LoRAs.

## 11.4 Mesh fit for the eHentai cross-reference

- **Herm (S22 phone)**: eHentai is the *provenance lookup* source for
  SillyTavern character card lore. When a card references a specific
  work, the operator uses eHentai to anchor the work to a Hugging Face
  LoRA / embedding of the same character / style.
- **Worm (9185W tablet)**: eHentai is the *provenance index* for the
  ComfyUI + Flux pipeline; the operator maintains a local mirror of
  the `toc/toc` tag-complete index in
  `~/.hermes/cache/scratch/ehentai-tags/`.
- **Ace (iMac, 2007 SSE3)**: not a primary consumer; Ace hosts the
  `SD1LoRAArchive` + `SDXLDoRAArchive` mirrors because they fit the
  SSE3 budget as inference-time LoRA add-ons.
- **Mesh desktop (24-48 GB+ VRAM)**: the eHentai cross-reference is
  used at *training time* (when fine-tuning a LoRA on a specific
  artist's work, the operator must verify the source dataset license
  before training -- eHentai gives the artist attribution that the
  LoRA card must preserve).

# 12. Cross-hub sourcing recipes (the operator's compounding)

## 12.1 The "find me a <base> LoRA on <hub>" recipe (the dominant query)

| Hub | API / UI recipe | Note |
| --- | --- | --- |
| Civitai | `civitai models search --type LORA --base-model "Flux.1 D" --sort "Most Downloaded" --period Month --nsfw` | `--base-model` repeatable; OR-combined by the API |
| HF | `https://huggingface.co/models?search=abliterated&sort=downloads` then add `library=diffusers` + `pipeline_tag=text-to-image` filters | use `huggingface_hub` SDK for batch |
| Tensor.Art | `https://www.tensor.art/search?baseModels=Flux&types=LORA&sort=MostPopular` (consumer UI) | TAMS has no public REST; Anakin Wire is a paid reverse-engineered proxy |
| LiblibAI | `https://liblib.art/?type=lora&baseModel=Flux` (consumer UI; CN-only) | SFW-only by law |
| Mage.space | not a download hub; Mage is a generation platform -- LoRAs surface as `Mango` / `Guava` / etc. brand-names | use Mage for *evaluation*, not *download* |
| OpenModelDB | not a LoRA hub; the closest are the `1x-SkinContrast-*` upscalers that pair with portrait LoRAs | scope mismatch -- this is upscalers, not LoRAs |
| Chub | not a LoRA hub; this is character cards | scope mismatch |
| Apertis | not a LoRA hub; this is an API service | scope mismatch |
| eHentai xref | `https://huggingface.co/Toc/toc` and `<e:v1 character_name` queries | provenance anchor only |

## 12.2 The "verify the model is actually uncensored" recipe

The mesh's refusal-verify protocol (UNMODERATED-MODELS.md section 8 +
11-DETECTION-CANARIES) is hub-agnostic. Per-hub shortcuts:

- **Civitai**: trust the `nsfwLevel` and the `tags: ["nsfw", "unfiltered"]`
  combination; cross-check `creator.username` against the
  `civitai-unfiltered` known-creator list.
- **Hugging Face**: trust the ID-or-tag match on the `uncensored |
  heretic | abliterated | censorless | no-censor | nocensor | jailbreak |
  liberated` vocabulary; the model card *must* name the abliteration
  method (Arditi / mlabonne / FailSpy / heretic).
- **Tensor.Art / LiblibAI / Mage.space**: no first-class unfiltered tag;
  cross-check the model's `description` for the terms `无审查` (CN) or
  `uncensored` or `unfiltered` in any language.
- **Apertis**: the model_id is literally `uncensored`; trust the marketing
  copy + the carve-out for minor sexual content.
- **Chub**: trust the per-card NSFW flag + the Chub auto-suggest
  (overridden manually by the operator).
- **OpenModelDB / eHentai**: not applicable (mathematical operators /
  provenance index, not refusable content).

## 12.3 The "preserve this model across hub takedowns" recipe

The operator's mesh pattern when a hub takes a model down:

1. Identify the model's SHA256 (HF: `huggingface_hub` snapshot +
   `sha256sum`; Civitai: from the API response `files[].hashes.SHA256`).
2. Pull a copy to `~/.hermes/cache/scratch/{hub}-mirror/{model-id}/`.
3. Push to GDrive via rclone: `rclone copy
   ~/.hermes/cache/scratch/{hub}-mirror/{model-id}/
   aimasterwes66:mesh-mirror/{hub}/{model-id}/`.
4. Re-host the model card metadata in a `Chroma111/CivitAI-Archive`-
   style mirror (the operator can fork the LMF archive projects).
5. Add the model to the mesh's `models/registry.tsv` (or equivalent)
   with: SHA256, original hub URL, mirror path, license.

[source: 04-PROVIDERS/keys-roster.md + the backup-push.sh doctrine from
~/.hermes/scripts/backup-push.sh + UNMODERATED-MODELS.md section 6.6]

## 12.4 The "combo the model's mesh-fit with the hub" recipe

Per-hub x per-box table (the operator's reference matrix):

| Hub \ Box | Herm (S22 ~8 GB) | Worm (9185W ~4 GB) | Ace (iMac SSE3) | Mesh desktop (24-48 GB VRAM) |
| --- | --- | --- | --- | --- |
| Civitai | browse, REST, download to GDrive | catalog manifest walk, no runtime | A1111 + SD 1.5 + LoRA runtime | full Flux / SDXL / Wan / HunyuanVideo |
| Hugging Face | Hermes Agent + llama.cpp + gguf | mradermacher / DavidAU / 0bserverx pulls | mradermacher / llmfan46 / DavidAU GGUF | vLLM / SGLang / autoawq full BF16 |
| Tensor.Art | browse only | catalog manifest, no runtime | UI exploration only | consumer T2I + TAMS paid jobs |
| LiblibAI | not accessible (geo) | catalog reference only | not a runtime | full SOTA stack |
| Mage.space | browse only | catalog reference only | not a runtime | full Mage model lineup + Gems API |
| OpenModelDB | 4x-UltraSharp + 4x-NMKD-Siax-CX | 4x-realesrgan-anime-6b + 1x-SkinContrast | 4x_RealisticRescaler_100000_G | 2x-classicalSR-SwinIR-M + 1x-Anti-Aliasing |
| Chub | SillyTavern card source | card mirror, no runtime | tavernai.cards converter + lint | main SillyTavern instance |
| Apertis | API escape hatch | API ad-hoc | API only (>13B escape hatch) | backup, not primary |
| eHentai xref | SillyTavern lore anchor | tag-complete mirror | SD1LoRAArchive + SDXLDoRAArchive mirror | training-time provenance lookup |

# 13. Source list (consolidated, with the exact URL each fact came from)

## 13.1 Civitai (EPIC 153)

- https://developer.civitai.com/site/reference/models -- the canonical
  REST API spec, parameter table, response shape, quirks.
- https://github.com/civitai/civitai-developer-docs -- source for the
  docs.
- https://developer.civitai.com/site/guide/cli -- the `civitai` CLI
  flag reference.
- https://developer.civitai.com/apps/reference/cli/catalog.md -- the
  CLI catalog command reference.
- https://github.com/civitai/civitai/wiki/REST-API-Reference -- the
  legacy wiki spec (now superseded by developer.civitai.com but still
  accessible).
- https://huggingface.co/Chroma111/CivitAI-Archive -- the community
  archive of Civitai model cards.
- https://offlinecreator.com/civitai-most-downloaded-nsfw-models-2026
  -- the operator's "most downloaded NSFW" walk-through.
- https://artokun.mintlify.app/tools/models -- the `search_civitai_models`
  + `download_civitai_model` ComfyUI tool spec.
- https://civitai.com/models/257749/pony-diffusion-v6-xl -- Pony V6 XL.
- https://civitai.com/models/847101/fluxed-up-flux-nsfw-checkpoint --
  Fluxed Up.
- https://civitai.com/models/141300/nsfw-xl -- NSFW XL LoRA.
- https://civitai.com/models/318385/4xrealisticrescaler100000g -- the
  4x_RealisticRescaler upscaler (Mutin Choler).

## 13.2 Hugging Face (EPIC 154)

- https://huggingface.co/ -- the main hub.
- https://huggingface.co/models?other=uncensored -- the operator's
  primary uncensored-model filter.
- https://huggingface.co/datasets?other=uncensored -- the operator's
  uncensored-dataset filter.
- https://huggingface.co/models?other=cognitivecomputations -- the
  Cognitive Computations org filter.
- https://github.com/clvv/hf-uncensored-model-popularity -- the
  community tracking of "uncensored" share of LLM downloads.
- https://docs.bswen.com/blog/2026-03-10-huggingface-uncensored-models-guide
  -- the operator's primary HF search playbook.
- https://greasyfork.org/en/scripts/593413-huggingface-enhanced-search
  -- the HuggingFace Enhanced Search userscript (`modelMatchesKeywords`,
  `fetchModels`).
- https://huggingface.co/dphn/dolphin-2.9.2-Phi-3-Medium-abliterated --
  FailSpy abliterated Phi-3-Medium example.
- https://huggingface.co/huihui-ai/Dolphin3.0-Llama3.1-8B-abliterated
  -- huihui-ai abliterated Llama-3.1-8B example.
- https://huggingface.co/docs/diffusers/tutorials/using_peft_for_inference
  -- the official Diffusers LoRA loading tutorial.
- https://huggingface.co/docs/diffusers/main/en/using-diffusers/inference_with_lcm_lora
  -- the LCM-LoRA loading tutorial.
- https://huggingface.co/Toc/toc -- the `ex/tag-complete` eHentai
  crosswalk.
- https://huggingface.co/Starlento/sd-nai-lora-index -- the NAI LoRA
  index.
- https://huggingface.co/LMFResearchSociety/SD1LoRAArchive -- SD 1.5
  LoRA archive.
- https://huggingface.co/LMFResearchSociety/SDXLDoRAArchive -- SDXL
  DoRA archive.
- https://huggingface.co/pettankoutei/Loras -- pettankoutei LoRA mirror.
- https://huggingface.co/Chroma111/CivitAI-Archive -- Civitai archive
  mirror.
- https://huggingface.co/datasets/John6666/knowledge_base_md_for_rag_1
  -- the legacy-inference-API to Inference-Providers migration note.
- https://huggingface.co/reach-vb/random-files/resolve/main/Inference%20Providers%20integration%20requirements.pdf
  -- the Inference Providers integration spec.
- https://huggingface.co/docs/hub/api -- the Hub REST API spec.

## 13.3 Tensor.Art (EPIC 155)

- https://tensor.art/ -- the consumer site.
- https://www.tensor.art/search -- the search UI.
- https://tensor.art/models -- the model index.
- https://tams.tensor.art/ -- the TAMS API landing.
- https://anakin.io/catalog/tensor-art -- the Anakin Wire reverse-
  engineered Tensor.Art API (paid).
- https://rawsignalai.com/developer-apis/generative-media/best-nsfw-image-generation-apis
  -- the operator's "5 Best NSFW APIs (2026)" comparison.

## 13.4 LiblibAI (EPIC 156)

- https://www.liblib.art/ -- the consumer site.
- https://liblib.art/modelinfo/82c25a0ef6be4b35b143e2c8f1b3a6a0 -- the
  "万物皆国画" LoRA example.
- https://flowcay.com/site/liblib-ai -- the operator's LiblibAI profile.
- https://flowith.io/blog/liblib-art-2026-community-driven-model-ecosystem-chinese-ai-artists
  -- the Q1 2026 community-scale numbers.
- https://www.aihub.cn/tools/image/liblibai/ -- the AIHub tool page.
- https://seoaiu.com/en/tool-detail/liblib-ai-libulibu-model-sharing.html
  -- the SEO/keyword operator's tool profile.

## 13.5 Mage.space (EPIC 157)

- http://mage.space/ -- the main app.
- https://mage.space/explore -- the explore page.
- https://www.mage.space/ -- the membership page.
- https://docs.mage.space/ -- the documentation index.
- https://docs.mage.space/api/models/flux2 -- the Flux 2 API spec.
- https://api.mage.space/ -- the API base URL.
- https://github.com/mage-space -- the open-source SDKs.

## 13.6 OpenModelDB (EPIC 158)

- https://openmodeldb.info/ -- the main site.
- https://github.com/openmodeldb/open-model-database -- the GitHub
  mirror.
- https://pypi.org/project/openmodeldb/ -- the PyPI client
  (matth-blt/openmodeldb).
- https://openmodeldb.info/?sort=date-desc&q=skin -- example filter
  URL.
- https://openmodeldb.info/models/4x-RealisticRescaler -- the
  Mutin Choler upscaler.
- https://openmodeldb.info/users/mutin-choler -- the creator profile.
- https://openmodeldb.info/models/1x-SkinContrast-High-SuperUltraCompact
  -- the skin-detail upscaler.
- https://openmodeldb.info/models/1x-Anti-Aliasing -- the
  anti-aliasing upscaler.
- https://openmodeldb.info/models/2x-classicalSR-DF2K-s64w8-SwinIR-M
  -- the SwinIR general upscaler.

## 13.7 Chub (extra)

- https://chub.ai/ -- the main site.
- https://api.chub.ai/search -- the search API endpoint.
- https://character-tavern.com/character/catalog?tags=NSFW -- the
  Character Tavern aggregator (uses Chub as the backend).
- https://tavernai.cards/blog/export-card-to-chub-manually -- the
  manual upload guide.
- https://tavernai.cards/blog/import-chub-card-to-sillytavern -- the
  ST import guide.
- https://tavernai.cards/blog/v2-vs-v3 -- the V2 vs V3 spec breakdown.
- https://termo.ai/skills/sillytavern-cards-skill -- the Termo skill
  that combines Chub + CharaVault.
- https://implexa.ai/s/clawhub/sillytavern-cards-skill -- the implexa
  catalog copy.
- https://codeberg.org/mikf/gallery-dl/issues/60 -- the gallery-dl
  Chub issue (the source of the search URL pattern).
- https://github.com/Samueras/chub_downloader -- the chub_downloader
  tool (preserves the search parameters and the 429 retry pattern).
- https://github.com/Samueras/chub_downloader/releases -- the release
  notes (preserves the search-preset taxonomy).

## 13.8 Apertis (extra)

- https://apertus.cc/ -- the main marketing page.
- https://apertus.cc/docs -- the API docs.
- https://api.apertus.cc/v1/chat/completions -- the chat completions
  endpoint.
- https://api.apertus.cc/v1/models -- the model list endpoint.
- https://registry.ollama.com/MichelRosselli/apertus-v1.1:1.5b-instruct-bf16
  -- the Swiss Apertus (NOT apertus.cc) Ollama mirror.

## 13.9 eHentai cross-reference (extra)

- https://e-hentai.org/ -- the main site.
- https://exhentai.org/ -- the ExHentai sister (banner-gated).
- https://huggingface.co/Toc/toc/blob/main/ex/tag-complete/README.md
  -- the tag-complete index that bridges eHentai -> HF.
- https://huggingface.co/Toc/toc -- the parent repo.
- https://huggingface.co/Starlento/sd-nai-lora-index -- the NAI LoRA
  crosswalk.

# 14. Operator unknowns and followups (what is NOT yet known)

- Tensor.Art TAMS free-trial depth: not authenticated end-to-end in any
  public source. Operator must verify personally before promising
  stakeholders a $0 prototype runway.
- Civitai's read-path tightening: SillyTavern issue #4011 (May 2025)
  flagged "Method Not Allowed" on URL-import. The state in 2026 is
  NOT publicly documented. The mesh treats the read path as
  "best-effort; always download via the Download button to disk".
- chub.ai's read path vs. the GitLab REST gateway: the community
  assumes `gateway.chub.ai/api/v4/projects/.../repository/files/.../raw`
  is the canonical CDN, but Chub's own docs don't say. If the
  gateway changes, `chub_downloader` and `gallery-dl` will break.
- apertus.cc's actual underlying model: the marketing copy says
  "open-weight model" but does not name it. The operator cannot
  reproduce the weights; the API is the only consumption surface.
  This is unlike the Swiss Apertus (which has `swiss-ai/Apertus-v1.1-*`
  on HF and a transparent model card). Operator must not confuse
  the two.
- LiblibAI's NSFW enforcement: the policy is "prohibited" but the
  actual enforcement is delegated to a 200-volunteer moderation team
  plus a content classifier. The "real" NSFW posture can only be
  measured by sampling current model listings.
- The "uncensored" filter vocabulary on HF (`uncensored | heretic |
  abliterated | censorless | no-censor | nocensor | jailbreak |
  liberated`) is a community convention, not a platform-enforced tag.
  Models without any of those tokens can still be uncensored (e.g.
  `cognitivecomputations/Dolphin-*` does not carry any of the eight
  tokens in its name but is the canonical uncensored lineage).
- Mage.space's exclusive model lineup (Mango / Guava / Kiwi / Peach /
  Cherry / Blueberry / Raspberry / Berry / Melon / Plum) is brand-
  named and not downloadable. If a mesh operator wants to evaluate
  one of these on a local box, they must go through the Mage API
  (Gems economy) and cannot pull the weights.
- Civitai's `nsfwLevel` field ranges 1-32; the platform does not
  publish the per-level rubric. The community treats >= 25 as
  "explicit / unfiltered" but this is a folk-taxonomy, not a
  contractual definition.


---

## Deep reference

Comprehensive single-file reading experience for this layer: see UNMODERATED-MODELS at repo root.
