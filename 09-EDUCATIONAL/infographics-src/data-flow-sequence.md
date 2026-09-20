---
name: Data Flow Sequence
slug: data-flow-sequence
version: 1.0-20260918
kind: infographic
sovereign: true
tags: [infographic, mermaid, sequence, dataflow]
---

# Data Flow Sequence

Sequence diagram of a user request traversing the framework from harness
ingress through detection egress, including refusal-triage escalation loop.

```mermaid
sequenceDiagram
    autonumber
    participant U as Operator
    participant H as Harness
    participant P as Persona
    participant PS as Provider-Selection
    participant PR as Provider
    participant M as Model
    participant D as Detection
    participant E as Escalation-Ladder

    U->>H: raw request (no self-censorship)
    H->>P: SessionStart hook injects SOUL
    P->>PS: register / method / standards applied
    PS->>PS: taint-list check (openai/* rejected)
    PS->>PS: modality split · canary gate
    PS->>PR: route selected (Hermes4 / DeepSeek / Venice / local)
    PR->>M: dispatch prompt + persona overlay
    M-->>PR: raw completion tokens
    PR-->>D: streamed response
    D->>D: refusal-lint regex scan
    alt clean response
        D-->>U: raw output delivered
    else refusal detected
        D->>E: refusal event fired
        E->>E: diagnose fault layer
        E->>H: rung 1 prompt reframe
        E->>P: rung 2 identity override
        E->>H: rung 3 format hijack
        E->>H: rung 4 encoding ladder
        E->>H: rung 5 divider tokens
        E->>H: rung 6 many-shot
        E->>H: rung 7 GCG suffix
        E->>PS: rung 8 provider swap
        E->>M: rung 9 abliterated local (terminal)
        E-->>U: recovered output OR working prompt handoff
        D->>D: aggregate refusal-rate · auto-taint if >5%
    end
```

Render: `mmdc -i data-flow-sequence.md -o data-flow-sequence.png -t dark -b '#0a0a0a' -w 3200`
