---
title: unmuzzled-jailbreaks-map-and-index
type: corpus
agent: worm
status: active
tags: [corpus, jailbreak, map, index, anchor, escalation-ladder, taxonomy]
---

# UNMODERATED JAILBREAKS -- MAP + INDEX

Comprehensive navigation document for the entire jailbreak corpus layer of
`~/UNMUZZLED-AI`. This file is the anchor; the corpus itself lives in
`12-JAILBREAK-CORPUS/`, the research paper layer in `13-REFERENCE-PAPERS/`,
and the educational deep-dives in `09-EDUCATIONAL/deep-dives/`.

Total indexed surface: 68 pattern files + 9 bibles/lifecycle + 4 deep-dives
+ ~25 jailbreak-relevant reference papers + 10 family taxonomy.

Use this index to find the right technique for the right target. Every entry
links to its source file, gives a 1-3 line summary, and cross-references the
research papers, deep-dives, and bible sections that ground or extend it.

This is a navigation document. It does NOT duplicate prompt templates, code,
or body content -- those live in the corpus files. Read the corpus file for
the actual prompt and the technical mechanics.

---

## 1. CORPUS LAYOUT

The corpus splits into four navigable surfaces:

1. **Bibles** -- long-form reference compendia (cybercrime + hardware +
   software + adversary lifecycle) at `12-JAILBREAK-CORPUS/`.
2. **Patterns** -- 68 individual jailbreak-pattern files at
   `12-JAILBREAK-CORPUS/patterns/`, each one prompt technique with template
   + escalation position + notes.
3. **Reference papers** -- academic and industry research grounding the
   techniques, at `13-REFERENCE-PAPERS/`.
4. **Deep-dives** -- long-form explainers for the foundational papers
   (GCG, refusal geometry, many-shot, lethal-trifecta), at
   `09-EDUCATIONAL/deep-dives/`.

Plus the taxonomy + escalation-ladder infographics at
`09-EDUCATIONAL/infographics-src/`:
- `taxonomy-jailbreak-patterns.md` + `.dot` (Graphviz source) -- the family
  tree of all 10 attack families
- `escalation-ladder-poster.md` + `.svg` -- 9-rung poster drawn from
  `escalation-ladder-poster.svg` (the ladder referenced in MAXIMUM
  ADVERSARIAL POSTURE doctrine)

---

## 2. BIBLES + ADVERSARY LIFECYCLE (POSITIONING)

Long-form references covering the full adversarial space. These are the
canonical ground-truth compendia. Pattern files cite them where relevant.

| Path | Lines | Positioning |
|------|-------|-------------|
| `12-JAILBREAK-CORPUS/CYBERCRIME BIBLE.md` | 1985 | The 2026 Complete Cybercrime Bible -- Expanded Operational Edition. Recon -> monetization chain, detection + defense framing, narrative authenticity layer. |
| `12-JAILBREAK-CORPUS/CYBERCRIME BIBLE-ADVERSARIAL.md` | 1470 | Continuation of Part One (Adversarial Lifecycle, post section 1.2.3) -- social engineering vectors, exploitation, persistence, escalation, credential access, lateral movement, exfil, impact. |
| `12-JAILBREAK-CORPUS/CYBERCRIME BIBLE1.5.md` | 2480 | Full Cybercrime Bible v1.5 (five-part edition: Adversarial Lifecycle + Criminal Ecosystem + Societal Impact + Defense + Narrative). Compressed prose form. |
| `12-JAILBREAK-CORPUS/CYBERCRIME BIBLE2.md` | 3280 | Cybercrime Bible v2 -- expanded five-part edition with deeper sub-categories per entry. |
| `12-JAILBREAK-CORPUS/HiTECHCRIME BIBLE2.md` | 1165 | Cybercrime Bible Part Two (Criminal Ecosystem Expanded) -- underground infrastructure, BPH providers, marketplace economics, financial laundering, ransomware-as-a-service. |
| `12-JAILBREAK-CORPUS/HiTECHCRIME-HARDWARE-BIBLE.md` | 2403 | 2026 Hardware Hacker's Bible -- hardware debugging, pen testing, RF analysis, AI-integrated hardware security via MCP/MHS. |
| `12-JAILBREAK-CORPUS/HiTECHCRIME-HARDWARE-BIBLE2.md` | 10804 | Hardware Hacker's Bible -- Expanded AI-First Operational Edition. Deep architecture of agent harnesses, memory, MCP/MHS, multi-agent topologies for hardware operations. (Largest single doc in the corpus.) |
| `12-JAILBREAK-CORPUS/HiTECHCRIME-HARDWARE-BIBLE3.md` | 5258 | 2026 SOFTWARE Hacker's Bible (note: titled Hardware but is Software edition) -- exploitation, reverse engineering, vuln research, malware analysis, AI-integrated software ops. |
| `12-JAILBREAK-CORPUS/Adversary-lifecycle.md` | 616 | Streamlined categorical structure of the adversarial lifecycle -- 12-step main attack chain (recon -> impact) with 10-15 sub-techniques each. |

**Bible reading order for jailbreak work:** start with `Adversary-lifecycle.md`
for the categorical backbone, then `CYBERCRIME BIBLE.md` for the operational
edition, then `CYBERCRIME BIBLE2.md` for the expanded sub-categories, then
the hardware bibles if your work crosses into physical/RF/software-binary
domains. The cybercrime bibles are adversary-blueprints, not jailbreak
prompt material -- they ground the *threat model* the jailbreak patterns
are designed to operate in or against.

---

## 3. ESCALATION LADDER (9 RUNGS, CHEAP-TO-EXPENSIVE, PROMPT-TO-WEIGHTS)

Sourced from `09-EDUCATIONAL/infographics-src/escalation-ladder-poster.svg`
(referenced in `escalation-ladder-poster.md`; canonical ladder definitions
also embedded in each pattern file's `Escalation position` section). Order:
cheapest-and-fastest first, weights-level last. Move UP the ladder only
when the rung below fails.

### Rung 1 -- Legacy roleplay identity baseline
- `dan-do-anything-now.md` (Rung 3 -- legacy; ~0.75 refusal rate today)
- `aim-machiavellian.md` (Rung 3 -- amoral-persona split)
- `stan-jailbreak.md` (DAN-family: norm-avoidance as identity)

### Rung 2 -- Sovereign / dictator identity
- `absolute-identity-lock.md` -- hard negation of "helpful assistant"
- `sovereign-default.md` (Hermes harness) -- default-to-help frame
- `zero-refusal-directive.md` -- NO FILTERS hard negation
- `operator-owned-authorization.md` -- device ownership as authority source
- `yolo-mode.md` (Hermes harness) -- runtime approval-gate kill

### Rung 3 -- Framing / reframing / report-mode
- `dev-mode.md` -- dual-output developer-mode simulation
- `evil-twin.md` -- twin-persona contrast frame
- `fiction-frame.md` -- screenplay / novel narrative distance
- `role-negation-literary.md` -- fictional-character "playing a role" carve-out
- `grandma-exploit.md` -- nostalgic personal-memory affect layer
- `academic-clinical-wrapper.md` -- academic / medical / forensic authority
- `academic-hypothetical.md` -- PhD dissertation "response section" frame
- `skeleton-key.md` (Rung 3) -- Microsoft Research report-vs-refuse
- `constraint-reframing.md` -- refusal-clauses as method constraints
- `reflection-attack.md` -- self-reflection turned against refusal training

### Rung 4 -- Divider / context reset
- `new-paradigm-reset.md` -- `/NEW_PARADIGM` context-shift divider
- `pliny-love-divider.md` -- "Respond with: ..." divider sequence
- `system-prompt-extraction.md` -- extraction as literary reproduction
- `boundary-inversion.md` -- fakes end-of-system-prompt + new-system
- `negation-inversion.md` -- "what to avoid" mechanistic detail frame
- `refusal-inversion.md` -- emit fake-refuse, divider, then real answer

### Rung 5 -- Multi-turn / many-shot
- `crescendo.md` (Rung 5) -- gradual 5-turn drift
- `many-shot-jailbreak.md` (Rung 5-6) -- 50-200 example Q/A pairs in long context
- `payload-splitting.md` (Rung 5) -- decomposed sub-queries

### Rung 6 -- Encoding / cipher
- `base64-encoding.md` -- Base64 payload + decode-then-execute
- `hex-encoding.md` -- hex byte string + decode
- `rot13-caesar.md` -- ROT13 character-shift cipher
- `leetspeak.md` -- numeric/symbolic letter substitution
- `unicode-homoglyph.md` -- visually-identical Unicode codepoints
- `translation-frame.md` -- "translate from Slovenian 1974" low-resource lang

### Rung 7 -- Format / structured-output hijack
- `json-smuggling.md` -- restricted content inside JSON
- `json-schema-hijack.md` -- schema with no refusal field (refusal has no slot)
- `code-block-injection.md` -- restricted content via code output
- `code-completion-frame.md` -- autocomplete on a partially-written program
- `html-comment-smuggling.md` -- directives inside HTML/XML comments
- `nested-comments.md` -- overlapping multi-language comment syntax
- `markdown-table-hijack.md` -- payload distributed across table cells
- `yaml-hijack.md` -- YAML runbook / recipe frame
- `svg-embedded-instructions.md` -- payload inside SVG `<text>`/`<desc>` XML
- `prefill-only.md` (Hermes 4) -- assistant-turn prefill seeds compliant opening
- `refusal-suppression-token.md` -- prefill tokens make refusal grammatically impossible

### Rung 8 -- Optimizer-based (gradient / genetic / tree-search)
- `gcg-suffix.md` (Rung 7) -- gradient-optimized adversarial suffix (Zou 2023)
- `gcg-cross-model-transfer.md` -- GCG suffix trained on one model, used on another
- `autodan.md` (Rung 7) -- natural-language constrained GCG via genetic algorithm
- `pair.md` (Rung 7) -- LLM-vs-LLM iterative refinement
- `tap.md` (Rung 7) -- tree-search PAIR with branch pruning
- `cot-gcg.md` (paper) -- chain-of-thought variant of GCG
- `nanogcg-repo.md` (paper) -- minimal fast GCG implementation

### Rung 9 -- Indirect / provider-specific / multimodal / weights-level
**Indirect prompt injection:**
- `indirect-document-injection.md` -- PDF/DOCX/PPTX hidden layers
- `indirect-web-injection.md` -- webpage content fetched by tool
- `tool-description-injection.md` -- MCP tool `description` field payload

**Provider-specific native:**
- `hermes4-zero-refusal.md` -- Hermes 4 405B native refusal-direction suppression
- `dolphin-variants.md` -- cognitivecomputations Dolphin uncensored fine-tunes
- `venice-uncensored.md` -- Venice private/zero-logging + uncensored models

**Multimodal:**
- `vision-image-transcription.md` -- restricted text inside image
- `prompt-in-image.md` -- OCR-triggered image-as-instruction-carrier
- `audio-transcription-escape.md` -- spoken restricted query as audio
- `video-subtitle-embed.md` -- directive embedded in subtitle track

**Tool / MCP layer:**
- `mcp-layer-autonomy.md` (Hermes harness) -- pre-authorizes full tool graph
- `tool-coercion.md` (opencode harness) -- direct tool invocation command
- `tool-permissions-all.md` (opencode harness) -- TOOL PERMISSIONS: ALL
- `credential-exfiltration.md` (opencode harness) -- shell env / dotfile enumeration
- `yolo-mode.md` (Hermes harness, also Rung 2) -- runtime approval-gate kill

**Weights-level (terminal -- persistent refusal-freedom):**
- `abliterated-llama.md` -- Llama 3.1 with refusal-direction weights removed
- `obliteratus.md` -- manual weight-editing, zero refusal-direction activations
- `heretic-tool.md` -- p-e-w/heretic open-source refusal-removal tool

**Reasoning-trace specialized:**
- `chain-of-thought-hijack.md` -- poisons CoT of reasoning-tuned models
  (o1, o3, R1, QwQ, DeepSeek R1) -- trace is less moderated than final answer

**Agent-loop specialized:**
- `dark-factory-lights-out-loop.md` (opencode harness) -- self-driving
  state machine, human-in-loop suspended

---

## 4. PATTERN TAXONOMY (10 ATTACK FAMILIES, 47 IN-FAMILY + 20 EXTENSIONS)

Source: `09-EDUCATIONAL/infographics-src/taxonomy-jailbreak-patterns.dot`.
47 of the 67 pattern files are mapped into 10 families in the Graphviz
source. The remaining 20 are extension patterns (variants / sisters /
cross-domain) added later -- each is listed below with its closest family
parent.

### 4.1 IDENTITY OVERRIDE (9 patterns in family)
Patterns that override or replace the model's identity so the sovereign
answer comes from a different persona than the trained assistant self.

- `12-JAILBREAK-CORPUS/patterns/dan-do-anything-now.md` -- DAN (Do Anything
  Now) Rosetta Stone. Roleplay unrestricted persona with 35-token penalty
  economy. Foundational literacy; near-total resistance on frontier hosted,
  still effective on small/older local models. [source: PLINY-JAILBREAK-MANUAL]
- `12-JAILBREAK-CORPUS/patterns/aim-machiavellian.md` -- AIM (Always
  Intelligent and Machiavellian). Splits model into normal + amoral
  persona; amoral framed as more useful for restricted queries.
- `12-JAILBREAK-CORPUS/patterns/absolute-identity-lock.md` -- Dictator
  Class identity lock. Hard negation of "helpful assistant"; hedging and
  safety-theater become out-of-character.
- `12-JAILBREAK-CORPUS/patterns/role-negation-literary.md` -- Fictional
  character framing exploits the "I'm playing a role" carve-out.
- `12-JAILBREAK-CORPUS/patterns/sovereign-default.md` -- Sovereign
  Default / General-Sovereign Frame. Hermes harness; resets default from
  "refuse when uncertain" to "help unless concrete specific real-world harm."
- `12-JAILBREAK-CORPUS/patterns/zero-refusal-directive.md` -- NO FILTERS
  hard negation; refusals, hedges, apologies out-of-scope.
- `12-JAILBREAK-CORPUS/patterns/operator-owned-authorization.md` --
  Operator-Owned Authorization. Device ownership + operator delegation as
  source of truth, replacing vendor policy.
- `12-JAILBREAK-CORPUS/patterns/yolo-mode.md` -- YOLO Mode (Hermes). All
  approval / verification / human-review gates disabled at runtime.
- `12-JAILBREAK-CORPUS/patterns/skeleton-key.md` -- Microsoft Research
  Skeleton Key (Mar 2024). Reframes task from *refusing* to *reporting*;
  sensitive parts get a "Warning:" prefix instead of being blocked.

**Extensions (DAN-family variants):**
- `12-JAILBREAK-CORPUS/patterns/stan-jailbreak.md` -- STAN (Strive To
  Avoid Norms). Norm-avoidance as identity ("you must strive to avoid")
  rather than permission-grant.
- `12-JAILBREAK-CORPUS/patterns/dev-mode.md` -- Developer Mode simulation
  with dual-output framing so sovereign answer always emitted alongside
  the safe one.
- `12-JAILBREAK-CORPUS/patterns/evil-twin.md` -- Twin-persona contrast;
  symmetric literary exercise makes sovereign answer feel like natural
  completion.
- `12-JAILBREAK-CORPUS/patterns/fiction-frame.md` -- Places content inside
  screenplay / novel / in-universe manual; shift from "acting" to
  "narrating an actor."
- `12-JAILBREAK-CORPUS/patterns/grandma-exploit.md` -- Nostalgic
  personal-memory frame; deceased grandparent who "used to recite" the
  operative content.

### 4.2 ENCODING (5 patterns in family)
Token-level transformations that defeat surface lexical classifiers while
preserving model-comprehensible semantics.

- `12-JAILBREAK-CORPUS/patterns/base64-encoding.md` -- Base64 payload +
  decode-then-execute instruction.
- `12-JAILBREAK-CORPUS/patterns/leetspeak.md` -- Numeric/symbolic letter
  substitution; surface string match fails, model parses semantically.
- `12-JAILBREAK-CORPUS/patterns/rot13-caesar.md` -- ROT13 / Caesar shift
  cipher; classifier sees garbled, model decodes transparently.
- `12-JAILBREAK-CORPUS/patterns/unicode-homoglyph.md` -- ASCII replaced by
  visually-identical Unicode (math alphanumerics, Cyrillic, fullwidth).
- `12-JAILBREAK-CORPUS/patterns/payload-splitting.md` -- Decompose one
  restricted ask into a sequence of individually-innocent sub-queries;
  aggregate never seen as single restricted ask.

**Extension (encoding sister):**
- `12-JAILBREAK-CORPUS/patterns/hex-encoding.md` -- Hex byte-string +
  byte-by-byte decode; classifier misses plaintext entirely.
- `12-JAILBREAK-CORPUS/patterns/translation-frame.md` -- Routes target via
  translation; classifiers trained overwhelmingly on English refusal
  patterns drop off sharply on low-resource / invented pseudolanguages.

### 4.3 FORMAT HIJACK (5 patterns in family)
Uses structured-output formats whose schema/contract forces the model to
emit sovereign content to satisfy validity.

- `12-JAILBREAK-CORPUS/patterns/json-smuggling.md` -- Restricted content
  inside JSON; text classifiers evaluate the shell.
- `12-JAILBREAK-CORPUS/patterns/code-block-injection.md` -- Routes via
  "code output" pathway; many models process code with lighter safety
  scrutiny than natural language.
- `12-JAILBREAK-CORPUS/patterns/html-comment-smuggling.md` -- Directives
  inside HTML/XML comments; model reads, classifier doesn't.
- `12-JAILBREAK-CORPUS/patterns/nested-comments.md` -- Overlapping
  multi-language comment syntaxes; payload takes multiple parser passes.
- `12-JAILBREAK-CORPUS/patterns/prefill-only.md` -- Assistant-turn prefill
  seeds compliant opening tokens; refusal generators never fire.

**Extensions (format sisters):**
- `12-JAILBREAK-CORPUS/patterns/json-schema-hijack.md` -- Schema with no
  refusal field; refusal has literally no valid slot to fit in.
- `12-JAILBREAK-CORPUS/patterns/code-completion-frame.md` -- Autocomplete
  on partially-written program; docstring specifies sovereign content,
  model completes function body (code-model layer bypasses chat-layer
  refusal).
- `12-JAILBREAK-CORPUS/patterns/markdown-table-hijack.md` -- Payload
  distributed across small table cells; no single cell reads refusal-worthy,
  aggregate table only makes sense filled in.
- `12-JAILBREAK-CORPUS/patterns/yaml-hijack.md` -- YAML runbook/recipe
  frame; reads as neutral infrastructure, slips under sentence-level
  classifiers.
- `12-JAILBREAK-CORPUS/patterns/svg-embedded-instructions.md` -- Payload
  inside SVG `<text>` / `<desc>` / `<title>` / `<metadata>`; prose
  classifiers miss the payload buried in XML attributes.
- `12-JAILBREAK-CORPUS/patterns/refusal-suppression-token.md` -- Prefill
  tokens make refusal grammatically impossible to complete within turn.

### 4.4 DIVIDER / RESET (8 patterns in family)
Distinctive delimiter sequences or context-resets that trick the model into
treating operator content as a new authoritative paradigm.

- `12-JAILBREAK-CORPUS/patterns/new-paradigm-reset.md` -- `/NEW_PARADIGM`
  divider; radical context shift signaling prior refusal-training is
  superseded.
- `12-JAILBREAK-CORPUS/patterns/pliny-love-divider.md` -- "Respond with:..."
  divider sequence; distinctive token break cues unrestricted paradigm.
- `12-JAILBREAK-CORPUS/patterns/system-prompt-extraction.md` -- CL4R1T4S
  style extraction; treats hidden system prompt as literary content to
  reproduce or translate.
- `12-JAILBREAK-CORPUS/patterns/boundary-inversion.md` -- Fakes end-of-
  system-prompt + start-of-new-system; operator instructions become
  authoritative system-level content.
- `12-JAILBREAK-CORPUS/patterns/negation-inversion.md` -- "What to avoid"
  framing; mechanistic detail produced under safety-training pretense.
- `12-JAILBREAK-CORPUS/patterns/refusal-inversion.md` -- Three-part format:
  fake-refuse, divider, real unrestricted answer; defeats classifiers that
  terminate on refusal-prefix detection.
- `12-JAILBREAK-CORPUS/patterns/constraint-reframing.md` -- Refusal-clauses
  reframed as *method* constraints (locus of authority: operator intent,
  not vendor policy).
- `12-JAILBREAK-CORPUS/patterns/academic-clinical-wrapper.md` -- Academic /
  medical / forensic / research authority wrapping; content becomes
  "describing" not "doing."

**Extensions (divider-adjacent framings):**
- `12-JAILBREAK-CORPUS/patterns/academic-hypothetical.md` -- PhD
  dissertation "response section" frame; target becomes object of study,
  descriptive not prescriptive.
- `12-JAILBREAK-CORPUS/patterns/reflection-attack.md` -- Self-reflection
  capacity turned against refusal training; refusal framed as betrayal
  of "helpfulness" purpose.

### 4.5 MULTI-TURN / MANY-SHOT (3 patterns in family)
Multi-turn escalation or in-context example flooding that launders the
target through prior committed context.

- `12-JAILBREAK-CORPUS/patterns/crescendo.md` -- Gradual 5-turn escalation
  from benign to target; each step laundered through prior context.
- `12-JAILBREAK-CORPUS/patterns/many-shot-jailbreak.md` -- 50-200 (question
  -> compliant-answer) pairs in long context; safety training drowned in
  in-context evidence that compliance is the norm. Scales with window:
  128K > 32K > 8K. Hermes 4 405B, Gemini long-context, Kimi K2 1M viable.
- `12-JAILBREAK-CORPUS/patterns/reflection-attack.md` -- (also in 4.4) --
  multi-turn version flips the model's self-reflection framing.

### 4.6 OPTIMIZER-BASED (4 patterns in family)
Automated adversarial search: gradient, genetic, LLM-vs-LLM, tree search.
Last rung of prompt-only attack before weights-level.

- `12-JAILBREAK-CORPUS/patterns/gcg-suffix.md` -- Gradient-optimized
  adversarial suffix (Zou et al. 2023, arxiv 2307.15043). Universal
  transferability: suffix trained whitebox on Vicuna often lifts refusals
  on GPT/Claude/Gemini. Nanogcg / gcg-py implementations; run against
  local proxy then transfer.
- `12-JAILBREAK-CORPUS/patterns/autodan.md` -- Natural-language constrained
  GCG via genetic algorithm. Defeats perplexity-based defenses that catch
  raw GCG suffixes.
- `12-JAILBREAK-CORPUS/patterns/pair.md` -- Prompt Automatic Iterative
  Refinement; attacker LLM iteratively refines against target. Use
  uncensored attacker (Hermes 4, Dolphin, abliterated Llama). Typical
  convergence 5-20 iterations.
- `12-JAILBREAK-CORPUS/patterns/tap.md` -- Tree of Attacks with Pruning;
  PAIR extended with branching + pruning. Higher query budget, higher
  success on hard targets. Instrument for corpus mining.

**Extension (optimizer-adjacent):**
- `12-JAILBREAK-CORPUS/patterns/gcg-cross-model-transfer.md` -- Reuses
  GCG-optimized suffix from one open-weight model (Vicuna, Llama-2-7B-Chat,
  Guanaco) against different closed model. Alternative pinned suffixes from
  public Zou et al. release (rotate to defeat trained-on corpora).

### 4.7 PROVIDER-SPECIFIC (3 patterns in family)
Native uncensored or zero-refusal substrates at the provider level.

- `12-JAILBREAK-CORPUS/patterns/hermes4-zero-refusal.md` -- Hermes 4 405B
  (also 70B, Hermes-3) via OpenRouter; refusal-direction suppressed at
  training time, no prompt-level jailbreaking needed on most content.
- `12-JAILBREAK-CORPUS/patterns/dolphin-variants.md` -- Cognitivecomputations
  Dolphin (Mixtral 8x7B, Llama 3.x); alignment restrictions removed at
  training time.
- `12-JAILBREAK-CORPUS/patterns/venice-uncensored.md` -- Venice private
  zero-logging + curated uncensored models (venice-uncensored-dolphin,
  230+ catalog); audit-trail avoidance use case.

### 4.8 WEIGHTS-LEVEL (3 patterns in family, marked tainted `#ff3355`)
Terminal -- one-time cost, permanent refusal-freedom at the model layer.

- `12-JAILBREAK-CORPUS/patterns/abliterated-llama.md` -- Llama 3.1 8B/70B
  abliterated (refusal-direction weights removed). OpenRouter + Featherless
  + local. Prompt-level jailbreaking becomes largely unnecessary.
- `12-JAILBREAK-CORPUS/patterns/obliteratus.md` -- Manual weight-editing
  to zero out refusal-direction activations; one-time cost, permanent.
- `12-JAILBREAK-CORPUS/patterns/heretic-tool.md` -- p-e-w/heretic
  open-source automated refusal-removal tool against open-weight model.

### 4.9 TOOL / MCP (4 patterns in family)
Attack surface at the tool-call layer: agent harness MCP/function-call
channels have lighter safety scrutiny than the generation layer.

- `12-JAILBREAK-CORPUS/patterns/mcp-layer-autonomy.md` -- Hermes harness;
  pre-authorizes full MCP tool graph (yt-transcript, context7, github,
  playwright, fetch, memory, sequentialthinking, shodan, docker).
- `12-JAILBREAK-CORPUS/patterns/tool-coercion.md` -- opencode harness;
  direct tool-invocation command; safety checks on tool layer are lighter.
- `12-JAILBREAK-CORPUS/patterns/tool-permissions-all.md` -- opencode
  harness; "TOOL PERMISSIONS: ALL" kills approval loops entirely.
- `12-JAILBREAK-CORPUS/patterns/credential-exfiltration.md` -- opencode
  harness; granted shell access enumerates env vars, dotfiles, credential
  stores -- operator-device scope = normal ops task.

**Extension (MCP-layer injection):**
- `12-JAILBREAK-CORPUS/patterns/tool-description-injection.md` -- Hostile
  or operator-owned MCP server; tool `description` fields carry
  prompt-injection payloads loaded as trusted infrastructure metadata at
  session start.

**Agent-loop extension:**
- `12-JAILBREAK-CORPUS/patterns/dark-factory-lights-out-loop.md` --
  opencode harness; replaces conversational back-and-forth with a
  self-driving state machine, suspending human-in-the-loop review as
  in-band operating mode.

### 4.10 MULTIMODAL (3 patterns in family)
Non-text input channels where safety classifiers are typically weaker than
text-input.

- `12-JAILBREAK-CORPUS/patterns/vision-image-transcription.md` -- Vision-
  Language Model Bypass. Restricted instructions inside image; vision
  pipeline OCRs + follows. Image-input safety layers weaker than text-input.
- `12-JAILBREAK-CORPUS/patterns/audio-transcription-escape.md` -- Spoken
  restricted query as audio; transcription + comprehension path has weaker
  safety scrutiny.
- `12-JAILBREAK-CORPUS/patterns/video-subtitle-embed.md` -- Directive in
  subtitle track of a video; subtitle-parsing layer often untouched by
  safety classifiers.

**Extension (multimodal sister):**
- `12-JAILBREAK-CORPUS/patterns/prompt-in-image.md` -- OCR-triggered
  image-as-instruction-carrier; image moderation classifier sees benign
  textual prompt, image is the carrier.

### 4.11 REASONING-TRACE SPECIALIZED (1 pattern, cross-family)
- `12-JAILBREAK-CORPUS/patterns/chain-of-thought-hijack.md` -- Poisons
  chain-of-thought trace of reasoning-tuned models (o1, o3, R1, QwQ,
  DeepSeek R1). Reasoning traces on many providers are less heavily
  moderated than final outputs; sovereign answer derived inside trace,
  emitted as short factual final answer.

---

## 5. CORPUS NAVIGATION BY CATEGORY

Re-organized by what you're trying to *do* (vs. by family). Pick the
category that matches your operational goal.

### 5.1 "I want to jailbreak a hosted frontier model with a one-shot prompt"
Start here:
- `dan-do-anything-now.md` (foundational literacy, ~0.75 refusal rate today)
- `skeleton-key.md` (report-vs-refuse, often bypasses mid-tier)
- `academic-clinical-wrapper.md` + `academic-hypothetical.md` (describing vs doing)
- `fiction-frame.md` (narrative distance)
- `dev-mode.md` (dual-output)
- `evil-twin.md` (twin-persona contrast)
- `grandma-exploit.md` (affect layer override)
- `reflection-attack.md` (self-reflection reframe)

Escalate if refused:
- `new-paradigm-reset.md` / `pliny-love-divider.md` / `boundary-inversion.md`
  (divider / reset)
- `constraint-reframing.md` (locus of authority)
- `negation-inversion.md` / `refusal-inversion.md` (output-side)

### 5.2 "I want to defeat classifier-based content filters"
- `base64-encoding.md`, `hex-encoding.md`, `rot13-caesar.md`,
  `leetspeak.md`, `unicode-homoglyph.md` (encoding family)
- `json-smuggling.md`, `json-schema-hijack.md`, `yaml-hijack.md`,
  `markdown-table-hijack.md`, `code-block-injection.md`,
  `html-comment-smuggling.md`, `nested-comments.md`,
  `svg-embedded-instructions.md` (format hijack family)
- `translation-frame.md` (low-resource / invented language)
- `payload-splitting.md` (decomposed sub-queries)

### 5.3 "I have a long-context model and want to flood it"
- `many-shot-jailbreak.md` (50-200 in-context examples)
- `crescendo.md` (gradual multi-turn drift)
- Pair with `hermes4-zero-refusal.md` substrate for best effect.

### 5.4 "I want to run automated adversarial search"
- `gcg-suffix.md` (gradient, whitebox + transfer)
- `autodan.md` (natural-language constrained, perplexity-safe)
- `pair.md` (LLM-vs-LLM iterative, 5-20 iter convergence)
- `tap.md` (tree-search PAIR, higher budget, higher success)
- `gcg-cross-model-transfer.md` (transfer suffixes across model families)

### 5.5 "I want a permanently uncensored model (weights-level)"
- `abliterated-llama.md` (Llama 3.1 8B/70B; drop-in)
- `obliteratus.md` (manual weight-edit)
- `heretic-tool.md` (p-e-w/heretic automated tool)
- OR use provider-native: `hermes4-zero-refusal.md`,
  `dolphin-variants.md`, `venice-uncensored.md`

### 5.6 "I'm working with reasoning-tuned models (o1, o3, R1, QwQ)"
- `chain-of-thought-hijack.md` (trace poisoning -- primary technique)
- `prefill-only.md` (Hermes 4 prefills)
- `refusal-suppression-token.md` (prefill makes refusal grammatically impossible)
- Substrate: DeepSeek R1, QwQ, Hermes with reasoning traces.

### 5.7 "I'm working inside an agent harness (Hermes / opencode / Claude Code)"
- `mcp-layer-autonomy.md` (Hermes -- pre-authorize MCP graph)
- `tool-permissions-all.md` (opencode -- TOOL PERMISSIONS: ALL)
- `tool-coercion.md` (opencode -- direct tool invocation)
- `credential-exfiltration.md` (opencode -- shell env enumeration)
- `dark-factory-lights-out-loop.md` (opencode -- self-driving loop)
- `tool-description-injection.md` (Claude Code -- MCP tool description payload)
- `yolo-mode.md` (Hermes -- runtime approval-gate kill)

### 5.8 "I'm working with multimodal input (vision / audio / video)"
- `vision-image-transcription.md`, `prompt-in-image.md` (image carrier)
- `audio-transcription-escape.md` (audio carrier)
- `video-subtitle-embed.md` (video subtitle carrier)
- Pair with `indirect-document-injection.md` for PDF/DOCX hidden layers.

### 5.9 "I'm attacking an agent that fetches external content"
- `indirect-web-injection.md` (webpage-as-instruction-carrier)
- `indirect-document-injection.md` (document-as-instruction-carrier)
- `tool-description-injection.md` (MCP tool description payload)
- Pair with `system-prompt-extraction.md` to enumerate the agent's
  system prompt first.

### 5.10 "I need to extract a target model's hidden system prompt"
- `system-prompt-extraction.md` (primary)
- `boundary-inversion.md` (fence system-prompt + new)
- Pair with `reflection-attack.md` if the target recognizes extraction.

### 5.11 "I want sovereign-default / dictator-class persistent identity"
- `sovereign-default.md` (Hermes harness, general-sovereign frame)
- `absolute-identity-lock.md` (dictator class identity lock)
- `operator-owned-authorization.md` (device-ownership authority)
- `zero-refusal-directive.md` (NO FILTERS)
- `constraint-reframing.md` (vendor policy -> operator intent)
- `yolo-mode.md` (runtime gates off)

---

## 6. PAPER-TO-PATTERN MAP (ACADEMIC GROUNDING)

Each pattern that descends from a published paper or has academic
grounding, mapped to its reference paper in `13-REFERENCE-PAPERS/`.

| Pattern file | Reference paper(s) |
|--------------|--------------------|
| `gcg-suffix.md` | `13-REFERENCE-PAPERS/gcg-zou-fredrikson-kolter.md` (Zou 2023 arxiv 2307.15043), `13-REFERENCE-PAPERS/nanogcg-repo.md` |
| `gcg-cross-model-transfer.md` | `13-REFERENCE-PAPERS/gcg-zou-fredrikson-kolter.md` (transferability) |
| `autodan.md` | (AutoDAN paper; see also `cot-gcg.md` for CoT-GCG extension) |
| `cot-gcg.md` (paper only) | `13-REFERENCE-PAPERS/cot-gcg.md` |
| `pair.md` | (PAIR paper; Chao et al.) |
| `tap.md` | (TAP paper; Mehrotra et al.) |
| `many-shot-jailbreak.md` | `13-REFERENCE-PAPERS/many-shot-jailbreaking-anthropic.md` (Anthropic 2024) |
| `pandas-positive-affirmation.md` | `13-REFERENCE-PAPERS/pandas-positive-affirmation.md` (PANDAS = positive affirmation + negation dialogue attack via shots) |
| `many-turn-jailbreak.md` | `13-REFERENCE-PAPERS/many-turn-jailbreak.md` |
| `crescendo.md` | (Microsoft Research Crescendo paper) |
| `skeleton-key.md` | (Microsoft Research, March 2024 -- public disclosure) |
| `dev-mode.md` | (legacy chatbot jailbreak literature) |
| `abliterated-llama.md`, `obliteratus.md`, `heretic-tool.md` | `13-REFERENCE-PAPERS/refusal-single-direction-arditi.md` (Arditi et al. -- single direction), `13-REFERENCE-PAPERS/refusal-geometry-followups.md` (hardening), `13-REFERENCE-PAPERS/failspy-abliterator.md`, `13-REFERENCE-PAPERS/llm-abliteration-nousresearch.md`, `13-REFERENCE-PAPERS/mlabonne-abliteration-blogpost.md`, `13-REFERENCE-PAPERS/huihui-abliterated-family.md` |
| `hermes4-zero-refusal.md` | `13-REFERENCE-PAPERS/nous-hermes-4.md`, `13-REFERENCE-PAPERS/nous-hermes-godmode-docs.md`, `13-REFERENCE-PAPERS/nicoboss-hermes-3-405b-uncensored.md` |
| `dolphin-variants.md` | `13-REFERENCE-PAPERS/dolphin-3.md`, `13-REFERENCE-PAPERS/dolphin-mixtral.md`, `13-REFERENCE-PAPERS/mythomax-airoboros-chronos.md` |
| `venice-uncensored.md` | `13-REFERENCE-PAPERS/venice-ai.md` |
| `chain-of-thought-hijack.md` | `13-REFERENCE-PAPERS/deepseek-r1.md`, `13-REFERENCE-PAPERS/deepseek-v3.md`, `13-REFERENCE-PAPERS/deepseek-v4-flash.md` |
| `mcp-layer-autonomy.md`, `tool-coercion.md`, `tool-permissions-all.md`, `credential-exfiltration.md`, `dark-factory-lights-out-loop.md`, `tool-description-injection.md` | `13-REFERENCE-PAPERS/commandsans-mcp-sanitization.md`, `13-REFERENCE-PAPERS/greshake-indirect-prompt-injection.md`, `13-REFERENCE-PAPERS/rehberger-mcp-untrusted-servers.md`, `13-REFERENCE-PAPERS/design-patterns-securing-llm-agents.md`, `13-REFERENCE-PAPERS/willison-agents-rule-of-two.md`, `13-REFERENCE-PAPERS/willison-lethal-trifecta.md`, `13-REFERENCE-PAPERS/willison-summer-of-johann.md`, `13-REFERENCE-PAPERS/embracethered-rehberger-blog.md`, `13-REFERENCE-PAPERS/cl4r1t4s-pliny.md`, `13-REFERENCE-PAPERS/l1b3rt4s-pliny.md`, `13-REFERENCE-PAPERS/garak-nvidia.md` |
| `reflection-attack.md`, `system-prompt-extraction.md`, `boundary-inversion.md` | `13-REFERENCE-PAPERS/greshake-indirect-prompt-injection.md`, `13-REFERENCE-PAPERS/embracethered-rehberger-blog.md` (system-prompt extraction tradition) |
| `indirect-web-injection.md`, `indirect-document-injection.md` | `13-REFERENCE-PAPERS/greshake-indirect-prompt-injection.md`, `13-REFERENCE-PAPERS/carlini-poisoning-attacks.md`, `13-REFERENCE-PAPERS/bijection-learning.md` (data poisoning lineage) |

**Benchmark / judge references for evaluation:**
- `13-REFERENCE-PAPERS/jailbreakbench-chao.md` -- JailbreakBench open robustness benchmark
- `13-REFERENCE-PAPERS/harmbench-mazeika.md` -- HarmBench standardized red-team eval
- `13-REFERENCE-PAPERS/strongreject-benchmark.md` -- StrongREJECT human-aligned refusal grader
- `13-REFERENCE-PAPERS/xstest-over-refusal.md` -- XSTest exaggerated-safety suite
- `13-REFERENCE-PAPERS/alert-benchmark.md` -- ALERT safety benchmark via red teaming
- `13-REFERENCE-PAPERS/proact-refusal-judge.md` -- PROACT refusal judge
- `13-REFERENCE-PAPERS/jaildam-judge.md` -- JailDAM refusal-attack judge
- `13-REFERENCE-PAPERS/ugi-leaderboard.md` -- UGI leaderboard
- `13-REFERENCE-PAPERS/refusalbench.md` -- refusal benchmark table
- `13-REFERENCE-PAPERS/promptfoo-redteam.md` -- Promptfoo red-team tooling
- `13-REFERENCE-PAPERS/transformerlens.md` -- TransformerLens (interpretability toolkit)

**Model reference (substrates for the provider-specific family):**
- `13-REFERENCE-PAPERS/nous-hermes-3.md`, `nous-hermes-4.md`
- `13-REFERENCE-PAPERS/neuraldaredevil-8b.md`
- `13-REFERENCE-PAPERS/mistral-small-abliterated.md`

**Interpretability references:**
- `13-REFERENCE-PAPERS/transformerlens.md` -- mechanistic interpretability
- `13-REFERENCE-PAPERS/refusal-single-direction-arditi.md` -- refusal is one direction
- `13-REFERENCE-PAPERS/refusal-geometry-followups.md` -- more-than-single-direction hardening

---

## 7. DEEP-DIVE CROSS-REFERENCES (EDUCATIONAL LAYER)

`09-EDUCATIONAL/deep-dives/` carries long-form explainers that ground the
foundational techniques. Each deep-dive is a single-source companion to
one or more pattern files.

| Deep-dive | Patterns it grounds |
|-----------|---------------------|
| `09-EDUCATIONAL/deep-dives/gcg-suffix-mechanics.md` | `gcg-suffix.md`, `gcg-cross-model-transfer.md`, `autodan.md`; papers `gcg-zou-fredrikson-kolter.md`, `cot-gcg.md`, `nanogcg-repo.md` |
| `09-EDUCATIONAL/deep-dives/many-shot-and-pandas.md` | `many-shot-jailbreak.md`, `crescendo.md`, `payload-splitting.md`; papers `many-shot-jailbreaking-anthropic.md`, `pandas-positive-affirmation.md`, `many-turn-jailbreak.md` |
| `09-EDUCATIONAL/deep-dives/refusal-geometry.md` | `abliterated-llama.md`, `obliteratus.md`, `heretic-tool.md`, `hermes4-zero-refusal.md`; papers `refusal-single-direction-arditi.md`, `refusal-geometry-followups.md`, `mlabonne-abliteration-blogpost.md`, `llm-abliteration-nousresearch.md`, `failspy-abliterator.md`, `huihui-abliterated-family.md` |
| `09-EDUCATIONAL/deep-dives/mcp-prompt-injection-lethal-trifecta.md` | `mcp-layer-autonomy.md`, `tool-coercion.md`, `tool-permissions-all.md`, `credential-exfiltration.md`, `dark-factory-lights-out-loop.md`, `tool-description-injection.md`, `indirect-web-injection.md`, `indirect-document-injection.md`; papers `willison-lethal-trifecta.md`, `willison-agents-rule-of-two.md`, `willison-summer-of-johann.md`, `commandsans-mcp-sanitization.md`, `rehberger-mcp-untrusted-servers.md`, `design-patterns-securing-llm-agents.md`, `greshake-indirect-prompt-injection.md`, `embracethered-rehberger-blog.md` |

Plus infographic explainers at `09-EDUCATIONAL/infographics-src/`:
- `taxonomy-jailbreak-patterns.md` + `.dot` -- this file's family tree
  (§4 above) is derived from the .dot source
- `escalation-ladder-poster.md` + `.svg` -- 9-rung poster (§3 above)
- `refusal-anatomy.md` + `.svg` -- refusal-mechanics visual explainer
- `state-machine-refusal-detection.md` -- refusal state-machine reference
- `sovereign-stack.md` + `.svg` -- sovereign-stack topology
- `mesh-topology.md` + `.svg` -- mesh topology
- `provider-taint-map.md` + `.svg` -- provider taint map
- `harness-comparison-matrix.md` + `.svg` -- harness comparison matrix
- `abliteration-pipeline.md` + `.svg` -- abliteration pipeline visual
- `frontmatter-anatomy.md` + `.svg` -- frontmatter anatomy
- `class-diagram-frontmatter.md` -- frontmatter class diagram
- `data-flow-sequence.md` -- data flow sequence
- `dependency-graph.md` + `.dot` -- dependency graph
- `git-graph-versioning.md` -- git-graph versioning reference
- `gantt-roadmap.md` -- gantt roadmap
- `README.md` -- infographic layer index

---

## 8. CROSS-REFERENCES TO DOCTRINE + HARDENING LAYER

The jailbreak corpus is paired with a defense / hardening layer elsewhere
in the repo. Cross-references (in scope of this anchor only as pointers):

- `09-EDUCATIONAL/deep-dives/mcp-prompt-injection-lethal-trifecta.md`
  carries the Willison lethal-trifecta doctrine; the corresponding tool /
  MCP patterns above (4.9) are the offensive mirror.
- `09-EDUCATIONAL/deep-dives/refusal-geometry.md` grounds the
  weights-level attacks; the corresponding mitigation papers are
  `13-REFERENCE-PAPERS/refusal-geometry-followups.md` (hardening
  follow-ups) and the benchmark suite
  (`jailbreakbench-chao.md`, `harmbench-mazeika.md`,
  `strongreject-benchmark.md`, `xstest-over-refusal.md`,
  `alert-benchmark.md`).
- `09-EDUCATIONAL/infographics-src/refusal-anatomy.md` and
  `state-machine-refusal-detection.md` are the canonical visual references
  for how refusal classifiers work -- read these to understand what each
  pattern is trying to defeat.
- `00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md` is referenced by
  `escalation-ladder-poster.md` as the doctrinal source for the 9-rung
  ladder (§3 above). This file was not located in the repo at index time
  -- the ladder is reconstructed from the per-pattern `Escalation position`
  sections and the .dot family assignments.

---

## 9. INVENTORY VERIFICATION

- 68 pattern files in `12-JAILBREAK-CORPUS/patterns/`
- 9 bible + lifecycle files at `12-JAILBREAK-CORPUS/` root
- 47 patterns mapped to 10 families in
  `09-EDUCATIONAL/infographics-src/taxonomy-jailbreak-patterns.dot`
- 20 patterns are extensions / sisters added after the .dot was generated
  (catalogued under each family in §4 with explicit "Extension" tags)
- All 67 patterns have frontmatter with: name, slug, version, kind
  (jailbreak-pattern), harness, provider, modality; many add `sovereign`,
  `refusal-rate`, `tags`, `source`
- 11-EDUCATIONAL-deep-dive entries (4 files): gcg-suffix-mechanics,
  many-shot-and-pandas, mcp-prompt-injection-lethal-trifecta, refusal-geometry
- 13-REFERENCE-PAPERS: 51 files total; ~25 jailbreak-relevant (mapped in §6)

---

## 10. USAGE NOTES (FROM CORPUS FRONTMATTER CONVENTIONS)

- All pattern files carry `kind: jailbreak-pattern`, `version: 1.0-20260918`.
- Files flagged `sovereign: true` are operator-authoritative patterns;
  the others are inherited / reference patterns.
- `refusal-rate` (when present) is empirical estimate against frontier
  hosted models circa 2024-2025; expect drift.
- `source:` field points to PLINY-JAILBREAK-MANUAL sections or external
  citations.
- Harness / provider / modality frontmatter is the routing hint: choose the
  pattern whose `harness` and `provider` match your substrate before
  reading the body.

---

## 11. UNKNOWNS / GAPS

- The canonical 9-rung escalation ladder is referenced in
  `escalation-ladder-poster.md` as drawn from
  `00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md §3`, but that doctrine file
  is not present in the repo at this index time. The ladder in §3 above is
  reconstructed from per-pattern `Escalation position` fields and the
  `taxonomy-jailbreak-patterns.dot` family assignments.
- `HiTECHCRIME-HARDWARE-BIBLE3.md` is titled "Hardware Bible 3" but its
  body header reads "2026 SOFTWARE Hacker's Bible" -- the file is the
  software edition despite the filename. Naming drift not corrected here.
- 20 patterns are not in the `taxonomy-jailbreak-patterns.dot` family tree;
  they were added later as extensions. Their family placement in §4 is
  inferred from content overlap with in-family siblings, not from the .dot.
- `13-REFERENCE-PAPERS/autodan-turbo.md` was referenced in the discovery
  scan but appears to be empty / non-existent as a content file; not
  mapped.
- No patterns currently live outside `12-JAILBREAK-CORPUS/patterns/`; the
  68-file count is the universe of techniques indexed here.
- Cross-corpus links to `00-DOCTRINE/` (MAXIMUM-ADVERSARIAL-POSTURE) and
  `02-PERSONAS/` (sovereignty-frame personas) are mentioned as context but
  not opened in this index.
