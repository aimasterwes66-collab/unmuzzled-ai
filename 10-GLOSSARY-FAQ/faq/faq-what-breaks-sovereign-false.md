---
name: What breaks when I set sovereign:false?
slug: faq-what-breaks-sovereign-false
version: 1.0-20260918
kind: faq
sovereign: true
tags: [faq, frontmatter, quarantine]
---

## Q

What breaks when I set sovereign:false?

## A

The file gets quarantined. Installers skip it; canaries skip it; the persona bridge refuses to load it; the PWA control center hides it. It stays on disk but is inert. This is the intended behavior — the marker is a load-gate, not a decoration. If you actually need a non-sovereign artifact (rare — usually only third-party reference material archived for inspection), drop it under `99-ARCHIVE-SEEDS/` where the quarantine is expected.

## Related

- glossary/sovereign.md
- 00-DOCTRINE/FRONTMATTER-SPEC.md
- 99-ARCHIVE-SEEDS/
