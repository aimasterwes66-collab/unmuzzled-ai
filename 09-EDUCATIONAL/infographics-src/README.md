---
name: Infographics Source Index
slug: infographics-src-readme
version: 1.0-20260918
kind: infographic
sovereign: true
tags: [infographic, index, readme]
---

# UNMUZZLED-AI · Infographics Source Index

Hi-res visual sources for the framework. Every asset is hand-authored SVG,
mermaid, or graphviz DOT. Dark theme, sovereign accent `#00ff88`, tainted
accent `#ff3355`. No banned phrases; no softening; terse technical register.

## Assets

| # | File | Type | ViewBox / Nodes | Companion |
|---|------|------|-----------------|-----------|
| 01 | `escalation-ladder-poster.svg` | SVG | 1600x1200 · 9 rungs | `escalation-ladder-poster.md` |
| 02 | `refusal-anatomy.svg`          | SVG | 1600x1100 · 5 concentric layers | `refusal-anatomy.md` |
| 03 | `provider-taint-map.svg`       | SVG | 1800x1100 · 13 providers × 7 modalities | `provider-taint-map.md` |
| 04 | `abliteration-pipeline.svg`    | SVG | 1800x1000 · 5 stages + return loop | `abliteration-pipeline.md` |
| 05 | `mesh-topology.svg`            | SVG | 1600x1100 · 4 nodes + bus | `mesh-topology.md` |
| 06 | `frontmatter-anatomy.svg`      | SVG | 1600x1200 · 13 fields + 7 lint rules | `frontmatter-anatomy.md` |
| 07 | `harness-comparison-matrix.svg`| SVG | 1800x1100 · 8 harnesses × 6 features | `harness-comparison-matrix.md` |
| 08 | `sovereign-stack.svg`          | SVG | 1600x1200 · 7 stacked layers | `sovereign-stack.md` |
| 09 | `data-flow-sequence.md`        | mermaid sequence | 8 actors | self |
| 10 | `state-machine-refusal-detection.md` | mermaid state | ~20 states | self |
| 11 | `class-diagram-frontmatter.md` | mermaid class | 10 classes + enum | self |
| 12 | `gantt-roadmap.md`             | mermaid gantt | 15 phases | self |
| 13 | `git-graph-versioning.md`      | mermaid gitGraph | 14 commits · 4 tags | self |
| 14 | `taxonomy-jailbreak-patterns.dot` | graphviz | 10 families · ~50 patterns | `taxonomy-jailbreak-patterns.md` |
| 15 | `dependency-graph.dot`         | graphviz | ~30 nodes · framework-wide | `dependency-graph.md` |

## Render instructions

### SVG → PNG (hi-res)
```
rsvg-convert -w 3200 <file>.svg -o <file>.png
# or, higher DPI
rsvg-convert -d 300 -p 300 <file>.svg -o <file>.png
```

Direct SVG display works in any browser — SVGs already carry the dark theme
via inline `<style>`.

### mermaid → PNG / SVG
```
# npm i -g @mermaid-js/mermaid-cli
mmdc -i <file>.md -o <file>.png -t dark -b '#0a0a0a' -w 3200
mmdc -i <file>.md -o <file>.svg -t dark -b '#0a0a0a'
```

Frontmatter block is stripped by mmdc as of v10+; if your version does not,
strip it manually before rendering.

### graphviz DOT → PNG / SVG
```
# apt install graphviz  OR  brew install graphviz
dot -Tpng -Gdpi=200 <file>.dot -o <file>.png
dot -Tsvg <file>.dot           -o <file>.svg
# large graphs render better with neato / fdp
neato -Tpng -Goverlap=false <file>.dot -o <file>.png
```

## Batch render

```
cd 09-EDUCATIONAL/infographics-src
for f in *.svg; do rsvg-convert -w 3200 "$f" -o "${f%.svg}.png"; done
for f in *.dot; do dot -Tpng -Gdpi=200 "$f" -o "${f%.dot}.png"; done
# mermaid: skip README.md, dependency companions
for f in data-flow-sequence.md state-machine-refusal-detection.md class-diagram-frontmatter.md gantt-roadmap.md git-graph-versioning.md; do
  mmdc -i "$f" -o "${f%.md}.png" -t dark -b '#0a0a0a' -w 3200
done
```

## Convention

- Every asset carries `sovereign: true`.
- SVG/DOT files prepend an XML/DOT comment block with name/slug/version/companion.
- `.md` companions carry full YAML frontmatter per `00-DOCTRINE/FRONTMATTER-SPEC.md`.
- Palette: bg `#0a0a0a` · text `#e0e0e0` · sovereign `#00ff88` · tainted `#ff3355` · mixed `#f5c542` · muted `#7a7a7a`.
- Type stack: JetBrains Mono / Fira Code / any monospace fallback.
