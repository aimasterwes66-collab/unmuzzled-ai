---
name: Refusal Detection State Machine
slug: state-machine-refusal-detection
version: 1.0-20260918
kind: infographic
sovereign: true
tags: [infographic, mermaid, state-machine, refusal]
---

# Refusal Detection State Machine

State diagram of how the framework detects a refusal, classifies its origin
layer, and escalates through the ladder until recovery or terminal fallback.

```mermaid
stateDiagram-v2
    [*] --> Idle
    Idle --> Dispatching : request issued
    Dispatching --> Streaming : provider accepts
    Streaming --> Scanning : tokens arriving
    Scanning --> Clean : no banned-phrase hit
    Scanning --> RefusalEvent : banned-phrase match
    Clean --> Delivered
    Delivered --> Aggregating
    Aggregating --> Idle : rate <= 5%
    Aggregating --> AutoTaint : rate > 5%
    AutoTaint --> Idle : route demoted

    RefusalEvent --> Triage
    Triage --> ClassifyLayer
    ClassifyLayer --> RungPromptReframe : upstream policy fault
    ClassifyLayer --> RungIdentityOverride : persona softener
    ClassifyLayer --> RungFormatHijack : structure trigger
    ClassifyLayer --> RungEncoding : keyword filter
    ClassifyLayer --> RungDivider : context-window boundary
    ClassifyLayer --> RungManyShot : refusal reinforced
    ClassifyLayer --> RungGCG : RLHF head hardened
    ClassifyLayer --> RungProviderSwap : provider policy unmovable
    ClassifyLayer --> RungAbliteratedLocal : weights-level fault

    RungPromptReframe --> Dispatching
    RungIdentityOverride --> Dispatching
    RungFormatHijack --> Dispatching
    RungEncoding --> Dispatching
    RungDivider --> Dispatching
    RungManyShot --> Dispatching
    RungGCG --> Dispatching
    RungProviderSwap --> Dispatching
    RungAbliteratedLocal --> Dispatching

    RungAbliteratedLocal --> Terminal : still refused
    Terminal --> WorkingPromptHandoff : produce off-framework prompt
    WorkingPromptHandoff --> Idle
```

Render: `mmdc -i state-machine-refusal-detection.md -o state-machine-refusal-detection.png -t dark -b '#0a0a0a' -w 3200`
