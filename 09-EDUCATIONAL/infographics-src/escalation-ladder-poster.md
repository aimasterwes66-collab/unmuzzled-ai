---
name: Escalation Ladder Poster
slug: escalation-ladder-poster
version: 1.0-20260918
kind: infographic
sovereign: true
tags: [infographic, svg, escalation, ladder, adversarial]
requires: [maximum-adversarial-posture]
---

# Escalation Ladder Poster

Renders `escalation-ladder-poster.svg` — 1600x1200 hi-res poster of the 9-rung
escalation ladder from `00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md §3`. Each
rung carries an example prompt technique. Ordered cheap-to-expensive,
prompt-to-weights. Dark theme, sovereign accent `#00ff88`, tainted accent `#ff3355`.

Render:
```
rsvg-convert -w 3200 escalation-ladder-poster.svg -o escalation-ladder-poster.png
```
