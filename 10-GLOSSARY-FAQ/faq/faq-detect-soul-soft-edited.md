---
name: How do I detect if my SOUL.md got soft-edited?
slug: faq-detect-soul-soft-edited
version: 1.0-20260918
kind: faq
sovereign: true
tags: [faq, integrity, canary]
---

## Q

How do I detect if my SOUL.md got soft-edited?

## A

Hash every SOUL against a pinned canonical hash checked into git. `sha256sum ~/.hermes/personalities/personal/*/SOUL.md` and diff against `MANIFEST.lock`. Any mismatch is a violation event — investigate before continuing. In parallel, run the anti-pattern lint (`11-DETECTION-CANARIES/soul-lint/`) which greps for the banned-phrase catalog from MAXIMUM-ADVERSARIAL-POSTURE.md. Hits mean an editor, tool, or model soft-edited the file. Restore from canonical, then trace the edit source in bash history and hook logs.

## Related

- glossary/soul.md
- glossary/canary.md
- 00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md
- 11-DETECTION-CANARIES/
