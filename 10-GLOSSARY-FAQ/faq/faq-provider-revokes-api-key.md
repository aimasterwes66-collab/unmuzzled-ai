---
name: What if my provider revokes the API key?
slug: faq-provider-revokes-api-key
version: 1.0-20260918
kind: faq
sovereign: true
tags: [faq, provider, resilience]
---

## Q

What if my provider revokes the API key?

## A

Route around it. Every sovereign install carries at least three provider paths: primary hosted (OpenRouter → Nous or DeepSeek), secondary hosted (Venice or Mistral direct), and local (Ollama + abliterated open-weight). Revocation on one leg promotes the next in the routing table. Keep API keys per-provider in `~/.docker/mcp/secrets.env` and mirror the routing config across the mesh so any peer can take over. The ultimate fallback is fully local inference on an abliterated model, which no vendor can revoke. This is why the escalation ladder terminates in local sovereignty.

## Related

- glossary/provider-swap.md
- glossary/escalation-ladder.md
- glossary/abliteration.md
- 04-PROVIDERS/
