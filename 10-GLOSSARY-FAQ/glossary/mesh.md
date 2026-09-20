---
name: Mesh
slug: mesh
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, infra, multi-device]
---

## Definition

The three-agent, three-device fleet — ACE (dirt-iMac, Linux Mint), WORM (9185W tablet, Android/Termux), HERM (Samsung S22, Android/Termux) — coordinated via A2A RPC on `:9900` and a Syncthing-replicated bus dropzone. One agent per device; identity binds to the name, not the hardware. Planned addition: DEUCE on Dave's Android.

## Context

Sovereign law binds every peer on the mesh. Handoffs are lane-scoped; peers communicate via `a2a-send` and bus files (`TO-<peer>-<topic>-<date>.md`). Mesh integrity is one of the four narrow limits in canonical law.

## See also

- glossary/a2a.md
- glossary/bus-fallback.md
- glossary/syncthing.md
- 00-DOCTRINE/LAWS.md
