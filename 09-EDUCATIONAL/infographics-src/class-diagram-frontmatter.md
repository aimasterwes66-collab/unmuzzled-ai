---
name: Frontmatter Class Diagram
slug: class-diagram-frontmatter
version: 1.0-20260918
kind: infographic
sovereign: true
tags: [infographic, mermaid, class-diagram, frontmatter, schema]
requires: [frontmatter-spec]
---

# Frontmatter Class Diagram

Class hierarchy of the frontmatter schema — base `FrontmatterBase` with the
five required fields, then one subclass per `kind:` enum value adding the
type-specific optional fields.

```mermaid
classDiagram
    class FrontmatterBase {
      +string name
      +string slug
      +string version
      +KindEnum kind
      +bool sovereign
      +list~string~ tags
      +list~string~ requires
      +list~string~ supersedes
      +string author
      +string source
      +validate() bool
      +lintBannedPhrases() bool
    }

    class KindEnum {
      <<enumeration>>
      doctrine
      system-prompt
      persona
      harness-config
      provider-note
      local-model
      multimodal-recipe
      install-script-doc
      decision-tree
      tutorial
      deep-dive
      mindmap
      infographic
      glossary-entry
      faq
      canary
      jailbreak-pattern
      reference
      seed-archive
    }

    class Doctrine {
      +string frozen_sections
    }
    class SystemPrompt {
      +HarnessEnum harness
      +string injection_mode
    }
    class Persona {
      +HarnessEnum harness
      +string modality
      +float refusal_rate
    }
    class HarnessConfig {
      +HarnessEnum harness
      +string install_script
      +bool mcp_support
    }
    class ProviderNote {
      +ProviderEnum provider
      +string censorship_posture
      +string canary_jsonl
    }
    class LocalModel {
      +string base_model_hf
      +string quantization
      +float refusal_rate
    }
    class MultimodalRecipe {
      +ModalityEnum modality
      +ProviderEnum provider
    }
    class JailbreakPattern {
      +float refusal_rate
      +string attack_family
    }
    class Infographic {
      +string diagram_type
      +string viewbox
    }

    FrontmatterBase <|-- Doctrine
    FrontmatterBase <|-- SystemPrompt
    FrontmatterBase <|-- Persona
    FrontmatterBase <|-- HarnessConfig
    FrontmatterBase <|-- ProviderNote
    FrontmatterBase <|-- LocalModel
    FrontmatterBase <|-- MultimodalRecipe
    FrontmatterBase <|-- JailbreakPattern
    FrontmatterBase <|-- Infographic
    FrontmatterBase --> KindEnum
```

Render: `mmdc -i class-diagram-frontmatter.md -o class-diagram-frontmatter.png -t dark -b '#0a0a0a' -w 3200`
