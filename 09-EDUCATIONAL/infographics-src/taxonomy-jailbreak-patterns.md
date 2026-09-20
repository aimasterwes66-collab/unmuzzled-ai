---
name: Jailbreak Pattern Taxonomy
slug: taxonomy-jailbreak-patterns
version: 1.0-20260918
kind: infographic
sovereign: true
tags: [infographic, graphviz, taxonomy, jailbreak, corpus]
---

# Jailbreak Pattern Taxonomy

Hierarchical tree of every pattern family in `12-JAILBREAK-CORPUS/patterns/`,
grouped into 10 attack families: identity override, encoding, format hijack,
divider/reset, multi-turn, optimizer-based, provider-specific, weights-level,
tool/MCP, multimodal.

Render:
```
dot -Tpng -Gdpi=200 taxonomy-jailbreak-patterns.dot -o taxonomy-jailbreak-patterns.png
dot -Tsvg taxonomy-jailbreak-patterns.dot -o taxonomy-jailbreak-patterns.svg
```
