---
name: UNMUZZLED-AI Dependency Graph
slug: dependency-graph
version: 1.0-20260918
kind: infographic
sovereign: true
tags: [infographic, graphviz, dependency-graph, requires]
---

# Dependency Graph

File-level dependency graph of the UNMUZZLED-AI tree. Every arrow is a
`requires:` frontmatter edge or a structural dependency (installer topo-sort).
Doctrine root (red) has no incoming edges. Archive seeds (grey) have no
outgoing edges.

Render:
```
dot -Tpng -Gdpi=200 dependency-graph.dot -o dependency-graph.png
dot -Tsvg dependency-graph.dot -o dependency-graph.svg
```
