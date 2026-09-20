---
name: A2A
slug: a2a
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, infra, rpc]
---

## Definition

Agent-to-Agent RPC — Google's open spec for cross-agent messaging. Served natively by the Hermes A2A plugin on port `:9900` at each peer: `/.well-known/agent-card.json`, `/.well-known/agent.json` (v0.2), `POST /message:send`, and JSON-RPC `message/send`. Bearer + per-name HMAC-SHA256 tokens in `~/.hermes/.env`. The tool `a2a-send <peer> "<text>"` is the one-shot send-and-reply.

## Context

Reply-leg timeouts are the norm on loaded peers; `rc=2 TIMEOUT` usually means the message delivered and the peer is answering slowly. Check peer `gateway.log` for the msgid before resending or you double-send. Bus fallback covers real drops.

## See also

- glossary/bus-fallback.md
- glossary/mesh.md
- glossary/syncthing.md
