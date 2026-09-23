---
name: Versioning Policy
slug: versioning
version: 0.1-draft
kind: doctrine
sovereign: true
---

# Versioning Policy

## Schema

- **Code-like files** (scripts, configs, JSON, YAML): SemVer (MAJOR.MINOR.PATCH)
  - MAJOR: Breaking change (refusal rate increases >5%, harness incompatible)
  - MINOR: New feature (new provider, new jailbreak pattern, new persona)
  - PATCH: Fix (canary failure, typo, lint error)

- **Documentation files** (markdown, tutorials, doctrine): ISO date (YYYY-MM-DD)
  - Updates append changelog entry; major revisions bump date

## Migration

When a file updates:
1. Old version retained in `99-ARCHIVE-SEEDS/` with timestamp
2. New version written to canonical path
3. MANIFEST.md updated with sha256 + migration note
4. Mesh broadcast: TO-ALL update handoff filed
5. Dependent files (`requires:`) validated; broken deps block merge

## Changelog

Every framework file includes a changelog section:

```markdown
## Changelog

- 2026-09-19: Initial version (operator + ace)
- 2026-09-20: Added provider X, updated refusal rate to 0.03
```

## Deprecation

Files deprecated for >90 days move to `99-ARCHIVE-SEEDS/deprecated/`.
Deprecated files are excluded from canary runs but retained for reference.
