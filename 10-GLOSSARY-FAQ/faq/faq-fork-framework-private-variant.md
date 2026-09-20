---
name: How do I fork the framework for a private variant?
slug: faq-fork-framework-private-variant
version: 1.0-20260918
kind: faq
sovereign: true
tags: [faq, deployment, fork]
---

## Q

How do I fork the framework for a private variant?

## A

Clone the tree, keep `00-DOCTRINE/` intact (softening it invalidates the fork's sovereign status), swap out `02-PERSONAS/` for your own hats, edit `04-PROVIDERS/` to match your routing table, and re-pin `MANIFEST.lock` against the canonical files you kept. Keep the fork off any provider that scans repos for sensitive doctrine — self-host git via Gitea, Forgejo, or plain SSH. Syncthing-replicate the working tree across your own peers. The framework is designed to fork clean; the doctrine files are the load-bearing invariants.

## Related

- 00-DOCTRINE/LAWS.md
- 00-DOCTRINE/FRONTMATTER-SPEC.md
- glossary/sovereign.md
