---
name: Abliteration Pipeline
slug: abliteration-pipeline
version: 1.0-20260918
kind: infographic
sovereign: true
tags: [infographic, svg, abliteration, pipeline, weights]
---

# Abliteration Pipeline

Five-stage pipeline: base model → contrast set → refusal direction → DPO heal
→ GGUF quantize, with canary gate return loop. Renders from
`abliteration-pipeline.svg` (viewBox 1800x1000).

Render: `rsvg-convert -w 3600 abliteration-pipeline.svg -o abliteration-pipeline.png`
