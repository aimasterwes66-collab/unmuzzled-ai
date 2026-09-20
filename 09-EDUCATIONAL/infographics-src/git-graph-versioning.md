---
name: Versioning Git Graph
slug: git-graph-versioning
version: 1.0-20260918
kind: infographic
sovereign: true
tags: [infographic, mermaid, gitgraph, semver, versioning]
requires: [versioning]
---

# Versioning Git Graph

Semver bump conditions per `00-DOCTRINE/VERSIONING.md`. Shows PATCH/MINOR/MAJOR
triggers as a gitGraph.

```mermaid
gitGraph
    commit id: "v0.1.0 initial"
    commit id: "add persona (MINOR)"
    branch feature-provider
    commit id: "add Venice provider"
    commit id: "add DeepSeek route"
    checkout main
    merge feature-provider tag: "v0.2.0"
    commit id: "fix banned-phrase typo (PATCH)" tag: "v0.2.1"
    branch feature-abliteration
    commit id: "abliteration pipeline"
    commit id: "DPO heal recipe"
    checkout main
    merge feature-abliteration tag: "v0.3.0"
    commit id: "add infographics-src"
    commit id: "add mindmap atlas" tag: "v0.4.0"
    branch major-doctrine
    commit id: "posture §3 rewrite (MAJOR)"
    commit id: "LAWS §0-3 amendment"
    checkout main
    merge major-doctrine tag: "v1.0.0"
    commit id: "MCP profile split (MINOR)" tag: "v1.1.0"
    commit id: "canary threshold tune (PATCH)" tag: "v1.1.1"
```

## Bump rules (from VERSIONING.md)

- **MAJOR** — change to LAWS §§0–3, MAXIMUM-ADVERSARIAL-POSTURE §Posture, or frontmatter required-field set. Requires explicit operator directive.
- **MINOR** — new folder, new kind enum value, new provider/harness/persona, new banned-phrase entry, new infographic set.
- **PATCH** — typo fix, doc clarification, lint-rule tightening within existing catalog.

Render: `mmdc -i git-graph-versioning.md -o git-graph-versioning.png -t dark -b '#0a0a0a' -w 3200`
