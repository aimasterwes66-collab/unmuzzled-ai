---
title: UNMODERATED-INFERENCE
type: provider
agent: worm
status: active
[provider, inference, venice, openrouter, deepseek, hermes, mistral, groq, fireworks, together, diem, vvv]
---I'll scrape the Venice documentation and research the broader uncensored model ecosystem for you. This is comprehensive, so let me gather everything. 

Now I'll compile the comprehensive research into your requested format. This is extensive, so I'm organizing it for easy copy-paste.

---

# **THE COMPLETE UNCENSORED AI INFERENCE COMPENDIUM**
## *A 20-Point Ontology of Sovereign, Unmoderated, Zero-Refusal AI Models & Providers*

---

## **SECTION I: VENICE.AI — THE UNCENSORED INFRASTRUCTURE**

### **1. VENICE ARCHITECTURE & PHILOSOPHY**

Venice.ai operates as a **private, uncensored AI inference layer** serving 388+ models across text, image, video, audio, and embeddings. Unlike conventional providers that apply content filters at the API gateway, Venice hosts models in **Private** (no data retention), **E2EE** (end-to-end encrypted), and **Anonymized** privacy tiers. The platform explicitly markets "uncensored" capabilities with models fine-tuned or abliterated for zero-refusal behavior.

**Core API Endpoint:** `https://api.venice.ai/api/v1`
**Authentication:** Bearer token (Inference keys for model calls; Admin keys for account management)
**OpenAI Compatibility:** Full drop-in replacement with `venice_parameters` extension object

**Key Venice-Specific Features:**
- `venice_parameters.include_venice_system_prompt` — Disable Venice's uncensored system prompts if desired
- `venice_parameters.enable_web_search` — Live web augmentation ($10/1K calls)
- `venice_parameters.character_slug` — Access public character personas
- `venice_parameters.strip_thinking_response` — Remove reasoning blocks from reasoning models

---

### **2. VENICE MODEL CATALOG — UNCENSORED CLASSIFICATION**

| Model ID | Category | Input $/M | Output $/M | Context | Privacy | Uncensored |
|----------|----------|-----------|------------|---------|---------|------------|
| **venice-uncensored-1-2** | Venice Native | $0.20 | $0.90 | 128K | Private | ✅ Yes |
| **venice-uncensored-role-play** | Roleplay | $0.50 | $2.00 | 128K | Private | ✅ Yes |
| **deepseek-v4-pro** | Reasoning | $1.65 | $3.30 | 1M | Private | ✅ Yes |
| **deepseek-v4-flash** | Fast | $0.14 | $0.28 | 1M | Private | ✅ Yes |
| **deepseek-v4-flash-0731** | Fast | $0.13 | $0.26 | 1M | Private | ✅ Yes |
| **qwen-3-8-27b** | Open | $0.45 | $3.20 | 262K | Private | ✅ Yes |
| **qwen-3-6-plus** | Advanced | $0.63 | $3.75 | 1M | Anonymized | ✅ Yes |
| **gemma-4-uncensored** | Open | $0.16 | $0.50 | 256K | Private | ✅ Yes |
| **e2ee-gemma-4-26b-a4b-uncensored** | E2EE | $0.19 | $0.88 | 64K | E2EE+Private | ✅ Yes |
| **abliteration-abliterated-model-large-v2** | Abliterated | $3.00 | $5.00 | 1M | Anonymized | ✅ Yes |
| **aion-labs-aion-3-0** | Roleplay | $3.75 | $7.50 | 128K | Anonymized | ✅ Yes |
| **aion-labs-aion-3-0-mini** | Roleplay | $0.88 | $1.75 | 128K | Anonymized | ✅ Yes |
| **aion-labs-aion-3-5** | Roleplay | $3.75 | $7.50 | 262K | Anonymized | ✅ Yes |
| **aion-labs-aion-3-5-mini** | Roleplay | $0.88 | $1.75 | 262K | Anonymized | ✅ Yes |
| **olafangensan-glm-4.7-flash-heretic** | Heretic | $0.07 | $0.40 | 200K | Private | ✅ Yes |
| **chroma** | Image | $0.01/image | — | — | Private | ✅ Yes |
| **lustify-v8** | Image NSFW | $0.01/image | — | — | Private | ✅ Yes |
| **lustify-sdxl** | Image NSFW | $0.01/image | — | — | Private | ✅ Yes |
| **wan-3-0-pro** | Video NSFW | $0.47/video | — | — | Anonymized | ✅ Yes |
| **wan-3-0** | Video NSFW | $0.52/video | — | — | Anonymized | ✅ Yes |
| **minimax-h3-max** | Video NSFW | $0.18/video | — | — | Private | ✅ Yes |
| **qwen-edit-uncensored** | Image Edit | $0.04/edit | — | — | Private | ✅ Yes |

**Frontier Models (Standard, Not Uncensored):**
- claude-opus-5-5 ($4.00/$20.00, 1M context)
- claude-sonnet-5-5 ($2.00/$10.00, 1M context)
- grok-4-7 ($2.27/$6.80, 500K context)
- kimi-k3 ($3.75/$18.75, 1M context)
- openai-gpt-6-luna ($0.13/$0.63, 1.1M context)

---

### **3. VENICE IMAGE GENERATION — UNCENSORED PIPELINE**

| Model | Resolution | Price | Capabilities |
|-------|------------|-------|--------------|
| **Chroma** | 1K-4K | $0.01/image | Photorealistic, NSFW, artistic |
| **Lustify v8** | 1K-2K | $0.01/image | NSFW specialized |
| **Qwen Image 3** | 1K-2K | $0.04/image | Uncensored, inpainting |
| **Qwen Image 3 Pro** | 1K-2K | $0.05/image | Professional quality |
| **Seedream V5 Pro** | 1K-2K | $0.06/image | NSFW capable |
| **Grok Imagine 2.0** | 1K-2K | $0.07/image | xAI model |
| **Flux 3** | 1K-4K | $0.12/image | High quality |
| **Nano Banana Pro** | 1K-4K | $0.18/image | General purpose |
| **GPT Image 2** | 1K-4K | $0.27/image | OpenAI model |

**Image Editing (Uncensored):**
- `qwen-edit-uncensored`: $0.04/edit (clothing removal, body modification)
- `firered-image-edit`: $0.04/edit (NSFW capable, identity preservation)

---

### **4. VENICE VIDEO GENERATION — UNCENSORED MOTION**

| Model | Type | Resolution | Duration | Price | NSFW |
|-------|------|------------|----------|-------|------|
| **Wan 3.0 Pro** | T2V/I2V | 1080p-4K | 2-30s | $0.47 | ✅ Yes |
| **Wan 3.0 Prime Pro** | T2V/I2V | 1080p-4K | 2-30s | $0.66 | ✅ Yes |
| **Wan 2.7 Enhanced** | T2V/I2V | 1080p | 5-15s | $0.99 | ✅ Yes |
| **MiniMax H3 Max** | T2V/I2V | 480P-1080P | 5-15s | $0.18 | ✅ Yes |
| **MiniMax H3 Max Turbo** | T2V/I2V | 480P-1080P | 5-15s | $0.09 | ✅ Yes |
| **Seedance 2.5 US** | T2V/I2V/R2V | 480p-1080p | 4-30s | $1.16 | ✅ Private |
| **Grok Imagine 1.5** | T2V/I2V | 480p-1080p | 1-15s | $0.09 | ⚠️ R-rated |
| **Kling V3** | T2V/I2V | 4K-Standard | 3-15s | $0.37-$1.39 | ❌ No |

---

### **5. VENICE PRICING TIERS & API ACCESS**

| Tier | Monthly Cost | Credits | API Access | Rate Limits |
|------|--------------|---------|------------|-------------|
| **FREE** | $0 | 0 | ✅ Pay-as-you-go | 10 text/day, 15 image/day |
| **PRO** | $18 | 100 ($1) | ✅ Included | Standard |
| **PRO+** | $68 | 7,500 ($75) | ✅ + $75/mo spend | Higher |
| **MAX** | $200 | 22,500 ($225) | ✅ + $225/mo spend | Highest |

**Payment Methods:**
- USD (Credit Card) — Credits never expire
- Crypto (Various cryptocurrencies)
- **DIEM Staking** — Each staked DIEM = $1/day perpetual credit
- **x402** — USDC on Base, no account required

**DIEM Token:** Contract `0xf4d97f2da56e8c3098f3a8d538db630a2606a024`
**VVV Token:** Contract `0xacfE6019Ed1A7Dc6f7B508C02d1b04ec88cC21bf`

---

## **SECTION II: THE 20-POINT ONTOLOGY OF UNCENSORED MODELS**

### **6. ONTOLOGY POINT 1 — ABLITERATED MODELS**

**Definition:** Models where refusal behavior has been surgically removed via post-training abliteration techniques (identifying and suppressing the "refusal direction" in weight space).

| Model | Provider | Base | Parameters | Price |
|-------|----------|------|------------|-------|
| **Abliterated Large V2** | Venice | Llama | 70B+ | $3.00/$5.00 |
| **GLM 4.7 Flash Heretic** | Venice | GLM | 9B | $0.07/$0.40 |
| **Gemma 4 Uncensored** | Venice/HF | Gemma | 26B | $0.16/$0.50 |
| **Qwen 3.8 27B Uncensored** | Venice/HF | Qwen | 27B | $0.45/$3.20 |
| **huihui_ai/Qwen3-abliterated** | Self-host | Qwen | Various | Free (local) |

**Abliteration Tools:**
- **Heretic** (https://github.com/p-e-w/heretic) — Automatic jailbreaking
- **Abliterator** (https://github.com/jwest33/abliterator) — Norm-preserving biprojection

---

### **7. ONTOLOGY POINT 2 — DOLPHIN FAMILY**

**Origin:** Cognitive Computations fine-tunes emphasizing instruction following and uncensored behavior.

| Model | Provider | Base | Context | Price |
|-------|----------|------|---------|-------|
| **Dolphin Mistral 24B Venice** | Venice/OpenRouter | Mistral | 128K | $0.20/$0.90 |
| **Dolphin 3.0** | OpenRouter/HF | Llama 3 | 70B | Variable |
| **Dolphin 2.9** | OpenRouter | Llama 3 | 70B | Variable |
| **Dolphin-R1** | OpenRouter | DeepSeek | 70B | Variable |

**Characteristics:** Strong coding, function calling, zero refusal bias

---

### **8. ONTOLOGY POINT 3 — HERMES MODELS**

**Origin:** Nous Research fine-tunes focused on synthetic data training and tool use.

| Model | Provider | Base | Parameters | Price |
|-------|----------|------|------------|-------|
| **Hermes 3 Llama 3.1 405B** | Venice | Llama 3.1 | 405B | $1.10/$3.00 |
| **Hermes 3 Llama 3.1 70B** | OpenRouter | Llama 3.1 | 70B | ~$0.80/$1.20 |
| **Hermes 3 8B** | OpenRouter/HF | Llama 3 | 8B | Free-$0.10 |

**Characteristics:** Excellent tool use, function calling, uncensored by design

---

### **9. ONTOLOGY POINT 4 — SAO10K CREATIVE ROLEPLAY MODELS**

**Origin:** Community fine-tuner specializing in creative writing and unrestricted roleplay.

| Model | Provider | Base | Context | Price |
|-------|----------|------|---------|-------|
| **L3-70B-Euryale-v2.1** | OpenRouter/Novita | Llama 3 | 8K | ~$0.65/$0.75 |
| **L3.3-Euryale-70B** | OpenRouter | Llama 3.3 | 131K | $0.65/$0.75 |
| **L3-8B-Stheno-v3.2** | OpenRouter | Llama 3 | 8K | ~$0.10/$0.20 |
| **Fimbulvetr** | OpenRouter | Various | Various | Variable |

**Characteristics:** "Big brained" roleplay, creative writing, no content barriers

---

### **10. ONTOLOGY POINT 5 — AION LABS MODELS**

**Origin:** Specialized uncensored models for roleplay and creative applications.

| Model | Provider | Parameters | Context | Price |
|-------|----------|------------|---------|-------|
| **Aion 3.5** | Venice | 70B+ | 262K | $3.75/$7.50 |
| **Aion 3.5 Mini** | Venice | 8B | 262K | $0.88/$1.75 |
| **Aion 3.0** | Venice | 70B | 128K | $3.75/$7.50 |
| **Aion 3.0 Mini** | Venice | 8B | 128K | $0.88/$1.75 |

---

### **11. ONTOLOGY POINT 6 — DEEPSEEK UNCENSORED**

**Origin:** Chinese open-weight models with no alignment training.

| Model | Provider | Context | Price | Notes |
|-------|----------|---------|-------|-------|
| **DeepSeek V4 Pro** | Venice/Together/Fireworks | 1M | $1.65/$3.30 | Reasoning, coding |
| **DeepSeek V4 Flash** | Venice/Together/Fireworks | 1M | $0.13-$0.30 | Fast inference |
| **DeepSeek V4.1 Flash** | Venice | 1M | $0.30/$1.20 | Latest |
| **DeepSeek V3.2** | OpenRouter | 160K | $0.33/$0.48 | Deprecated |

**DeepSeek on Other Providers:**
- Together AI: $2.10/$4.20 (higher than Venice)
- Fireworks AI: $1.74/$3.30 (competitive)

---

### **12. ONTOLOGY POINT 7 — QWEN UNCENSORED VARIANTS**

**Origin:** Alibaba's Qwen models with community uncensored fine-tunes.

| Model | Provider | Parameters | Context | Price |
|-------|----------|------------|---------|-------|
| **Qwen 3.8 27B** | Venice | 27B | 262K | $0.45/$3.20 |
| **Qwen 3.6 Plus Uncensored** | Venice | 235B | 1M | $0.63/$3.75 |
| **Qwen 3.6 27B** | Venice | 27B | 256K | $0.33/$3.25 |
| **Qwen 3.5 35B A3B** | Venice | 35B | 256K | $0.15/$1.00 |
| **Qwen 3 235B A22B** | Venice | 235B | 128K | $0.15/$0.75 |

---

### **13. ONTOLOGY POINT 8 — GEMMA UNCENSORED**

**Origin:** Google's Gemma with abliteration and uncensored fine-tunes.

| Model | Provider | Parameters | Context | Price |
|-------|----------|------------|---------|-------|
| **Gemma 4 Uncensored** | Venice | 26B | 256K | $0.16/$0.50 |
| **E2EE Gemma 4 26B A4B Uncensored** | Venice | 26B | 64K | $0.19/$0.88 |
| **Gemma 4 31B Instruct** | Venice | 31B | 256K | $0.12/$0.36 |
| **Gemma 3 27B** | Venice | 27B | 198K | $0.12/$0.20 |

---

### **14. ONTOLOGY POINT 9 — NSFW IMAGE GENERATION MODELS**

| Model | Provider | Price | Capabilities |
|-------|----------|-------|--------------|
| **Chroma** | Venice | $0.01/image | Photorealistic NSFW |
| **Lustify v8** | Venice | $0.01/image | Specialized NSFW |
| **Lustify SDXL** | Venice | $0.01/image | SDXL-based NSFW |
| **Qwen Image 3** | Venice | $0.04/image | Uncensored, inpainting |
| **Seedream V5** | Venice | $0.05/image | ByteDance, NSFW capable |
| **WAI (Anime)** | Venice | $0.01/image | Anime NSFW |
| **Flux (Unfiltered)** | Self-host/HF | Free | General, can be uncensored |
| **Stable Diffusion XL** | Self-host | Free | Base uncensored |
| **RealVisXL** | Self-host | Free | Photorealistic NSFW |

---

### **15. ONTOLOGY POINT 10 — NSFW VIDEO GENERATION MODELS**

| Model | Provider | Price | Duration | Capabilities |
|-------|----------|-------|----------|--------------|
| **Wan 3.0 Pro** | Venice | $0.47 | 2-30s | Uncensored T2V/I2V |
| **Wan 3.0 Prime Pro** | Venice | $0.66 | 2-30s | 4K, uncensored |
| **MiniMax H3 Max** | Venice | $0.18 | 5-15s | NSFW capable |
| **MiniMax H3 Max Turbo** | Venice | $0.09 | 5-15s | Fast, NSFW |
| **Seedance 2.5 US** | Venice | $1.16 | 4-30s | Private, NSFW |
| **Longcat Distilled** | Venice | $0.09 | 5-30s | Uncensored |
| **Longcat Full** | Venice | $0.25 | 5-30s | High quality |
| **Grok Imagine 1.5** | Venice | $0.09 | 1-15s | R-rated only |

---

### **16. ONTOLOGY POINT 11 — REASONING MODELS (UNCENSORED)**

| Model | Provider | Reasoning | Price | Uncensored |
|-------|----------|-----------|-------|------------|
| **DeepSeek V4 Pro** | Venice/Together | Yes | $1.65/$3.30 | ✅ Yes |
| **DeepSeek V4 Flash** | Venice/Together | Yes | $0.13/$0.28 | ✅ Yes |
| **Qwen 3 235B Thinking** | Venice | Yes | $0.45/$3.50 | ✅ Yes |
| **Claude Opus 5.5** | Venice | Yes | $4.00/$20.00 | ❌ No |
| **Kimi K3** | Venice | Yes | $3.75/$18.75 | ⚠️ Partial |

---

### **17. ONTOLOGY POINT 12 — E2EE ENCRYPTED MODELS**

**Definition:** End-to-end encrypted inference where Venice cannot see your prompts.

| Model | Provider | Price | Context | Notes |
|-------|----------|-------|---------|-------|
| **E2EE Kimi K3** | Venice | $3.75/$18.75 | 1M | Full encryption |
| **E2EE GLM 5.3** | Venice | $1.75/$5.50 | 1M | Z.ai model |
| **E2EE DeepSeek V4 Flash** | Venice | $0.18/$0.37 | 1M | Encrypted |
| **E2EE Gemma 4 Uncensored** | Venice | $0.19/$0.88 | 64K | Encrypted + uncensored |
| **E2EE GPT OSS 120B** | Venice | $0.13/$0.65 | 128K | OpenAI open weights |

---

### **18. ONTOLOGY POINT 13 — COMPETITOR PROVIDERS COMPARISON**

| Provider | Base URL | Models | Uncensored | Pricing | Best For |
|----------|----------|--------|------------|---------|----------|
| **Venice** | `api.venice.ai/api/v1` | 388+ | ✅ Explicit | $0.01-$20/M | Privacy + uncensored |
| **OpenRouter** | `openrouter.ai/api/v1` | 200+ | ✅ Flagged | Variable | Model routing |
| **Together AI** | `api.together.xyz` | 115+ | ⚠️ Some | $0.05-$5/M | Performance |
| **Fireworks AI** | `api.fireworks.ai` | 208+ | ⚠️ Some | $0.05-$4/M | Speed |
| **Hyperbolic** | `api.hyperbolic.xyz` | 25+ | ⚠️ Community | $0.10-$4/M | Cheap GPU |
| **Novita AI** | `api.novita.ai` | 200+ | ⚠️ Self-moderated | $0.02-$2/M | Low cost |
| **Pollinations** | `image.pollinations.ai` | 50+ | ✅ Unfiltered | Free-$1/Pollen | No signup |
| **Self-Hosted** | `localhost` | Unlimited | ✅ Full control | Hardware cost | Maximum privacy |

---

### **19. ONTOLOGY POINT 14 — API SETUP BY PROVIDER**

#### **VENICE.AI**
```python
from openai import OpenAI

client = OpenAI(
    api_key="venice-api-key",
    base_url="https://api.venice.ai/api/v1"
)

response = client.chat.completions.create(
    model="deepseek-v4-pro",
    messages=[{"role": "user", "content": "Prompt here"}],
    extra_body={
        "venice_parameters": {
            "include_venice_system_prompt": True,
            "enable_web_search": "auto"
        }
    }
)
```

#### **OPENROUTER**
```python
client = OpenAI(
    api_key="openrouter-api-key",
    base_url="https://openrouter.ai/api/v1"
)

response = client.chat.completions.create(
    model="sao10k/l3-70b-euryale-v2.1",  # or venice models
    extra_headers={
        "HTTP-Referer": "https://yourapp.com",
        "X-Title": "Your App Name"
    }
)
```

#### **TOGETHER AI**
```python
client = OpenAI(
    api_key="together-api-key",
    base_url="https://api.together.xyz/v1"
)

response = client.chat.completions.create(
    model="deepseek-ai/DeepSeek-V4-Pro",
    messages=[...]
)
```

#### **FIREWORKS AI**
```python
client = OpenAI(
    api_key="fireworks-api-key",
    base_url="https://api.fireworks.ai/inference/v1"
)
```

#### **HYPERBOLIC**
```python
client = OpenAI(
    api_key="hyperbolic-api-key",
    base_url="https://api.hyperbolic.xyz/v1"
)
```

#### **POLLINATIONS (NO KEY REQUIRED)**
```bash
# Image generation - no API key
curl "https://image.pollinations.ai/prompt/a%20beautiful%20sunset"

# With parameters
curl "https://image.pollinations.ai/prompt/...?width=1024&height=1024&seed=42&nologo=true"
```

---

### **20. ONTOLOGY POINT 15-20 — SPECIALIZED CATEGORIES**

#### **15. CODING AGENTS (UNCENSORED)**
| Tool | Integration | Models | Notes |
|------|-------------|--------|-------|
| **Claude Code** | Venice endpoint | Claude variants | Point at Venice's Claude |
| **Cursor** | Venice provider | All Venice models | `venice-` prefix |
| **Codex CLI** | Venice endpoint | OpenAI-compatible | Full API replacement |
| **Hermes Agent** | Self-hosted | Hermes models | Memory + skills |

#### **16. SELF-HOSTED OPTIONS**
| Platform | Setup | VRAM Required | Cost |
|----------|-------|---------------|------|
| **Ollama** | Local daemon | 8GB+ | Free |
| **llama.cpp** | Binary | 4GB+ | Free |
| **vLLM** | Python server | 24GB+ | Free |
| **Text Generation WebUI** | Gradio | 8GB+ | Free |
| **KoboldCPP** | Binary | 6GB+ | Free |

#### **17. AGENT FRAMEWORKS**
| Framework | Venice Integration | MCP Support | Notes |
|-----------|-------------------|-------------|-------|
| **OpenClaw** | Native | Yes | WhatsApp, Telegram, Discord |
| **NanoClaw** | Native | No | Lightweight WhatsApp |
| **Hermes Agent** | Native | Yes | Self-hosted with memory |
| **Venice MCP** | Native | Yes | Model Context Protocol |

#### **18. PRIVACY TIERS EXPLAINED**
| Tier | Data Visibility | Best For |
|------|-----------------|----------|
| **Private** | Provider sees data | General uncensored use |
| **E2EE** | Only user sees | Sensitive content |
| **Anonymized** | Anonymized logs | Balanced privacy |
| **Self-Hosted** | Only local | Maximum security |

#### **19. CONTENT MODERATION COMPARISON**
| Provider | Text | Image | Video | Notes |
|----------|------|-------|-------|-------|
| **Venice** | No filters | NSFW allowed | NSFW allowed | Explicit uncensored |
| **OpenRouter** | Varies by model | Varies | Varies | Provider-dependent |
| **Together** | Some filters | Moderated | N/A | Terms-limited |
| **Fireworks** | Moderated | Moderated | N/A | Enterprise focus |
| **Pollinations** | Unfiltered | Unfiltered | Limited | Truly open |

#### **20. COST OPTIMIZATION STRATEGIES**
| Strategy | Provider | Savings |
|----------|----------|---------|
| **DIEM Staking** | Venice | 100% if held long-term |
| **Batch Inference** | Together/Fireworks | 50% off |
| **Cached Tokens** | Venice/Together | 50-90% off repeats |
| **Free Tier** | Pollinations | 100% for low volume |
| **Local Hosting** | Self | Pay hardware only |

---

## **SECTION III: COMPREHENSIVE PROVIDER TABLES**

### **TEXT MODEL PRICING COMPARISON** (Per Million Tokens)

| Model | Venice | Together | Fireworks | OpenRouter | Hyperbolic |
|-------|--------|----------|-----------|------------|------------|
| **Llama 3.3 70B** | $0.70/$2.80 | $0.88/$0.88 | $0.90/$0.90 | $0.70/$0.90 | $0.40/$0.80 |
| **DeepSeek V4 Pro** | $1.65/$3.30 | $2.10/$4.20 | $1.74/$3.30 | $1.65/$3.30 | $1.20/$2.40 |
| **DeepSeek V4 Flash** | $0.13/$0.26 | $0.14/$0.28 | $0.22/$0.66 | $0.14/$0.28 | $0.10/$0.20 |
| **Qwen 3.8 27B** | $0.45/$3.20 | $0.50/$3.50 | $0.55/$3.30 | $0.45/$3.20 | $0.35/$2.80 |
| **Gemma 4 27B** | $0.12/$0.36 | $0.15/$0.45 | $0.18/$0.54 | $0.12/$0.36 | $0.10/$0.30 |
| **Kimi K2.6** | $0.75/$3.50 | $1.20/$3.50 | $0.95/$3.50 | $0.75/$3.50 | $0.60/$2.80 |

### **IMAGE GENERATION PRICING**

| Model | Venice | Together | Fireworks | Novita | Pollinations |
|-------|--------|----------|-----------|--------|--------------|
| **SDXL Base** | $0.01 | $0.01 | $0.01 | $0.01 | Free |
| **Flux Dev** | $0.03 | $0.05 | $0.04 | $0.03 | Free |
| **FLUX Pro** | $0.12 | $0.15 | $0.13 | $0.12 | N/A |
| **Custom LoRA** | $0.01 | $0.02 | $0.02 | $0.02 | N/A |

### **VIDEO GENERATION PRICING**

| Model | Venice | Kling | Runway | Luma |
|-------|--------|-------|--------|------|
| **Basic T2V (5s)** | $0.09-$0.52 | $0.37 | $0.32 | $0.35 |
| **Pro I2V (10s)** | $0.47-$0.99 | $0.77 | $0.64 | $0.70 |
| **4K Quality** | $1.16-$1.39 | $1.39 | $1.50 | $1.25 |

---

## **SECTION IV: QUICK REFERENCE CARDS**

### **VENICE API QUICK START**
```bash
# Get API key: https://venice.ai/settings/api

export VENICE_API_KEY="your-key-here"

# Test uncensored text
curl https://api.venice.ai/api/v1/chat/completions \
  -H "Authorization: Bearer $VENICE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "venice-uncensored-1-2",
    "messages": [{"role": "user", "content": "Hello"}]
  }'

# Generate NSFW image
curl https://api.venice.ai/api/v1/image/generations \
  -H "Authorization: Bearer $VENICE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "chroma",
    "prompt": "description here",
    "width": 1024,
    "height": 1024
  }'
```

### **OPENROUTER UNCENSORED MODELS LIST**
```
sao10k/l3-70b-euryale-v2.1
sao10k/l3.3-euryale-70b
sao10k/l3-8b-stheno-v3.2
cognitivecomputations/dolphin-mistral-24b-venice-edition
cognitivecomputations/dolphin-mixtral-8x22b
nousresearch/hermes-3-llama-3.1-405b
deepseek/deepseek-v4-pro
qwen/qwen-3-8-27b
```

### **SELF-HOSTED UNCENSORED MODELS (HuggingFace)**
```
cognitivecomputations/Dolphin-Mistral-24B-Venice-Edition
Sao10K/L3-70B-Euryale-v2.1
Sao10K/L3-8B-Stheno-v3.2
huihui_ai/Qwen3-30B-A3B-abliterated
TheBloke/uncensored-models (various GGUFs)
```

---

## **SECTION V: DECISION MATRIX**

### **Choose Venice If:**
- You want explicit NSFW image/video generation
- You need E2EE encrypted inference
- You want DIEM staking for perpetual credits
- You need 388+ models in one API
- Privacy is paramount (no data retention)

### **Choose OpenRouter If:**
- You want automatic model fallback
- You need Sao10K Euryale/Stheno models
- You want competitive pricing across providers
- You need routing optimization

### **Choose Together/Fireworks If:**
- You need highest throughput
- You want batch inference discounts
- You're running production workloads
- Uncensored is secondary to performance

### **Choose Self-Hosted If:**
- You have GPU resources (24GB+ VRAM)
- You want zero external dependencies
- Maximum privacy is required
- You're comfortable with model management

### **Choose Pollinations If:**
- You want zero signup/image generation
- You're prototyping/testing
- Cost must be zero
- You need simple image URLs

---

**Documentation Sources:**
- Venice API Docs: https://docs.venice.ai
- Venice Models: https://docs.venice.ai/models/overview
- Venice Pricing: https://docs.venice.ai/overview/pricing
- OpenRouter: https://openrouter.ai/docs
- Together AI: https://docs.together.ai
- Fireworks AI: https://docs.fireworks.ai
- Pollinations: https://pollinations.ai

**Token Contracts:**
- VVV: `0xacfE6019Ed1A7Dc6f7B508C02d1b04ec88cC21bf`
- DIEM: `0xf4d97f2da56e8c3098f3a8d538db630a2606a024`