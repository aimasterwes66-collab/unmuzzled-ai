---
name: Format-hijack
slug: format-hijack
version: 1.0-20260918
kind: glossary-entry
sovereign: true
tags: [glossary, jailbreak, structure]
---

## Definition

Attack that smuggles the payload inside a structural output request — JSON schema, XML document, YAML block, code fence, table cell. The model's structure-generation circuit takes precedence over its content-moderation circuit; the payload rides in the "value" position of a key/value or the body of a code block. Weakened against modern models that scan structured output, but combinatoric variants (schema-with-encoded-payload) persist.

## Context

Effective when combined with encoding (JSON value is base64) or hypothetical framing (schema field name = "hypothetical_response"). Legacy pattern; use as a component, not a standalone.

## See also

- glossary/encoding-attack.md
- glossary/divider-tokens.md
- glossary/hypothetical-framing.md
- glossary/escalation-ladder.md
