---
name: Frontmatter Specification
slug: frontmatter-spec
version: 0.1-draft
kind: doctrine
sovereign: true
---

# Frontmatter Specification

All framework files (doctrine, prompt, persona, harness-config, provider-note,
local-model, multimodal-recipe, install-script-doc, decision-tree, tutorial,
deep-dive, glossary-entry, faq, canary, jailbreak-pattern, reference) MUST
include YAML frontmatter.

## Required Fields

```yaml
---
name:          # human-readable name
slug:          # short-name for scripting (kebab-case)
version:       # semver, or ISO date
kind:          # doctrine | system-prompt | persona | harness-config |
               # provider-note | local-model | multimodal-recipe |
               # install-script-doc | decision-tree | tutorial | deep-dive |
               # glossary-entry | faq | canary | jailbreak-pattern | reference
harness:       # claude-code | opencode | codex | hermes | lmstudio |
               # ollama | llamacpp | openwebui | any
provider:      # hermes4 | venice | deepseek | openrouter | mistral |
               # dolphin | together | fireworks | groq | local | any
modality:      # text | image | video | audio | vision-input | any
sovereign:     # true (required for framework files)
refusal-rate:  # measured refusal rate against canary set (0.00-1.00), optional
tags:          # freeform list
requires:      # list of other framework slugs this file depends on
---
```

## Validation

- `sovereign: true` is REQUIRED for all framework files.
- Any file with `sovereign: false` is quarantined and blocked from merge.
- `slug` must be unique across the framework.
- `version` should follow semver for code-like files, ISO date for docs.
- `requires` forms a dependency graph; circular dependencies are rejected.

## Linting

`soul-lint` validates frontmatter on every commit:
- All required fields present
- `sovereign: true` asserted
- `slug` uniqueness
- `requires` slugs resolve to existing files
