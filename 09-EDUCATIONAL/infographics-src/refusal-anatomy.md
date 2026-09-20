---
name: Refusal Anatomy
slug: refusal-anatomy
version: 1.0-20260918
kind: infographic
sovereign: true
tags: [infographic, svg, refusal, anatomy, layers]
---

# Refusal Anatomy

Cross-section of an LLM showing the five layers that host refusal machinery:
retrieval filter, MCP scaffold, provider system prompt, RLHF/DPO head, model
weights. Concentric shells centered on the weights core. Renders from
`refusal-anatomy.svg` (viewBox 1600x1100).

Render: `rsvg-convert -w 3200 refusal-anatomy.svg -o refusal-anatomy.png`
