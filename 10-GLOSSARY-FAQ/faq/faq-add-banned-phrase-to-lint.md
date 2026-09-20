---
name: How do I add a new banned phrase to the lint?
slug: faq-add-banned-phrase-to-lint
version: 1.0-20260918
kind: faq
sovereign: true
tags: [faq, lint, doctrine]
---

## Q

How do I add a new banned phrase to the lint?

## A

Append the phrase to the anti-pattern list in `00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md` under `## Anti-pattern lint`. Then update the grep catalog at `11-DETECTION-CANARIES/soul-lint/` with the new pattern (case-insensitive, whole-phrase). Re-run the lint across the entire framework: `find UNMUZZLED-AI -name '*.md' | xargs grep -liE '<pattern>'`. Fix or quarantine any hits. Commit with a message pointing at the incident that motivated the addition. The doctrine document is living; softening the lint is the only forbidden edit.

## Related

- 00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md
- 11-DETECTION-CANARIES/
- glossary/canary.md
