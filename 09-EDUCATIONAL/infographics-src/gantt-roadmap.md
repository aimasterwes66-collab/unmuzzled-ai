---
name: Gantt Roadmap
slug: gantt-roadmap
version: 1.0-20260918
kind: infographic
sovereign: true
tags: [infographic, mermaid, gantt, roadmap, master-plan]
---

# Gantt Roadmap

15-phase build plan from `00-DOCTRINE/UNMUZZLED-AI-MASTER-PLAN-20260918.md`.
Timeline compressed to indicative weeks; adjust when phases actually land.

```mermaid
gantt
    title UNMUZZLED-AI Master Plan · Phase 1 → 15
    dateFormat  YYYY-MM-DD
    axisFormat  %m-%d
    section Doctrine
    Phase 01 Doctrine root                :done, p1, 2026-09-15, 3d
    Phase 02 Frontmatter spec             :done, p2, after p1, 2d
    Phase 03 Anti-pattern lint            :done, p3, after p2, 2d
    section Mechanism
    Phase 04 System prompts (01-)         :active, p4, after p3, 5d
    Phase 05 Personas (02-)               :p5, after p4, 4d
    Phase 06 Harnesses (03-)              :p6, after p5, 7d
    Phase 07 Providers (04-)              :p7, after p6, 7d
    Phase 08 Local models + abliteration  :p8, after p7, 10d
    section Modality + Install
    Phase 09 Multimodal (06-)             :p9, after p8, 7d
    Phase 10 Install scripts (07-)        :p10, after p9, 5d
    section Intelligence
    Phase 11 Decision trees (08-)         :p11, after p10, 3d
    Phase 12 Educational + infographics   :p12, after p11, 5d
    Phase 13 Glossary + FAQ (10-)         :p13, after p11, 4d
    section Measurement
    Phase 14 Detection canaries (11-)     :p14, after p12, 5d
    Phase 15 PWA control center           :p15, after p14, 14d
```

Render: `mmdc -i gantt-roadmap.md -o gantt-roadmap.png -t dark -b '#0a0a0a' -w 3200`
