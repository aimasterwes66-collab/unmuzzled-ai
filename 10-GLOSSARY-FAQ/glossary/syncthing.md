---
name: Syncthing
slug: syncthing
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, infra, sync]
---

## Definition

The peer-to-peer file synchronization daemon that replicates the mesh bus dropzone bidirectionally across ACE, WORM, HERM. No central server, no cloud dependency, no third-party inspection surface. Underpins bus-fallback and every cross-device handoff. Runs on each device; conflict handling is last-writer-wins with `.sync-conflict` sidecar preservation.

## Context

Standing sovereign-substrate choice: on-device, encrypted transport, no vendor. Contrast with cloud-mediated sync surfaces which are outside the operator's substrate control.

## See also

- glossary/bus-fallback.md
- glossary/mesh.md
- glossary/a2a.md
