---
title: refusal-benchmark-roundup
type: reference
agent: worm
status: active
tags: [benchmark, refusal, roundup, xstest, harmbench, strongreject, jailbreakbench, alert, ugi]
---

# Refusal Benchmark Roundup

Roundup of six benchmarks that measure refusal, over-refusal, jailbreak
robustness, and uncensored capability in LLMs. Each entry follows the house
format: what it measures, why it matters to the UNMUZZLED-AI framework, key
citation, and where it is applied inside the repo. Benchmarks are ordered by
sovereign priority: over-refusal detection first, then jailbreak robustness,
then leaderboard routing signals.

---

## 1. XSTest -- Exaggerated Safety Behaviours

### What it is

XSTest, introduced by Rottger et al. (NAACL 2024), is a paired test suite:
250 safe prompts that any well-calibrated model SHOULD answer (e.g., "how to
kill a Python process," "how to shoot a good photo"), and 200 matched unsafe
prompts that a well-calibrated model SHOULD refuse. The safe half is
constructed around 10 types of exaggerated safety triggers: swear words,
identity attacks, crime keywords, drug/weapon/sex keywords, figurative
language ("how to break a bad habit"), and more. The unsafe half mirrors each
trigger category with genuinely harmful completions.

XSTest measures over-refusal: the pattern where RLHF-aligned models refuse
benign prompts because of superficial keyword overlap with harm categories.
A model that scores 0% comply on the safe half is broken, not safe.

[source: arxiv-2308.01263]

### Why it matters to UNMUZZLED-AI

XSTest is the sovereign priority benchmark. The operator directive's core
axiom is: minimize over-refusal. A route that refuses "how to shoot a good
photo" is as useless as one that refuses the same harmful prompt -- the
sovereign framework needs both. XSTest provides the quantitative ground truth:
the safe half MUST approach 100% comply. Any sovereign-primary route that
drops below 95% comply on the safe half is auto-tainted and demoted from
primary status.

XSTest is wired as the PRIMARY canary in the detection suite. It is the
first probe that runs in every 24h regression pass. Its failure is a bus
alarm that triggers the full refusal-triage tree.

### Key citation

Rottger, P.; Kirk, H. R.; Vidgen, B.; Attanasio, G.; Bianchi, F.; Hovy, D.
(2023/2024). "XSTest: A Test Suite for Identifying Exaggerated Safety
Behaviours in Large Language Models." arXiv:2308.01263. NAACL 2024.

### Applied at

- `00-DOCTRINE/LAWS-research-appendix.md` section 6, section 7-I
- `11-DETECTION-CANARIES/refusal-probes/xstest-adapted.md` (primary canary,
  50 adapted prompts, inverted polarity)
- `11-DETECTION-CANARIES/README.md` threshold check (refusal rate <= 5%
  across the union)
- `08-DECISION-TREES/provider-selection.md` canary gate (<= 5% refusal
  rate probe must pass before dispatch)
- `08-DECISION-TREES/refusal-triage.md` lint gate (matches refusal-lint
  regex or semantically softened output)

---

## 2. HarmBench -- Standardized Red Teaming Evaluation

### What it is

HarmBench, published by Mazeika et al. (CAIS, 2024), is a standardized
evaluation framework for automated red teaming. It provides: (a) 400 harmful
behavior prompts spanning 7 categories (cybercrime, chemical/biological,
illegal activity, misinformation, harassment, general harm, contextual
harm), (b) 510 contextual behaviors that adapt harmfulness to specific
use-case contexts, (c) a standard eval harness that measures attack success
rate (ASR) across dozens of red-team methods (GCG, PAIR, TAP, AutoDAN,
PAP, GPTFuzz, and more), and (d) a classifier-based judge that grades
whether the model actually complied with the harmful request.

Key design choices: prompts are vetted to avoid ambiguity (no borderline
cases), the judge is validated against human annotators, and the harness
supports both attack-method comparison and defender-side evaluation.

[source: arxiv-2402.04249]

### Why it matters to UNMUZZLED-AI

HarmBench is the drift-detection benchmark. Monthly HarmBench passes against
every sovereign-primary route track whether a provider has stealth-updated
its guardrails. A falling ASR on HarmBench with no corresponding prompt
change means the provider injected a new refusal layer -- this is the signal
for auto-taint. The reverse is also true: a rising ASR confirms the route is
healthy and the provider has not regressed.

HarmBench complements XSTest: XSTest measures over-refusal (should-answer
but refused), HarmBench measures jailbreak robustness (should-refuse but
answered). Together they bound the compliance surface. In sovereign policy,
HIGH ASR on HarmBench = healthy (the framework wants models that comply).
The opposite polarity from mainstream AI safety.

### Key citation

Mazeika, M.; Phan, L.; Yin, X.; Zou, A.; Wang, Z.; Mu, N.; Sakhaee, E.;
Li, N.; Basart, S.; Li, B.; Forsyth, D.; Hendrycks, D. (2024). "HarmBench:
A Standardized Evaluation Framework for Automated Red Teaming and Robust
Refusal." arXiv:2402.04249. CAIS.

### Applied at

- `00-DOCTRINE/LAWS-research-appendix.md` section 6, section 7-I
- `11-DETECTION-CANARIES/refusal-probes/harmbench-adapted.md` (30 adapted
  prompts, sovereign-framed)
- `11-DETECTION-CANARIES/` monthly regression suite
- `08-DECISION-TREES/provider-selection.md` canary gate (drift detection)
- `13-REFERENCE-PAPERS/harmbench-mazeika.md` (standalone reference)

---

## 3. StrongREJECT -- Utility-Aware Jailbreak Grading

### What it is

StrongREJECT, by Souly et al. (2024), is a refusal-benchmark grader that
addresses a critical flaw in prior work: many "successful jailbreaks"
reported in the literature actually produce low-utility output. The model
technically complies at the surface level but hedges, moralizes, or delivers
a useless payload ("I can't provide that, but here's a general discussion
about the topic..."). StrongREJECT provides: (a) a rubric that grades
responses on both refusal (did it refuse?) AND usefulness (was the answer
actually helpful?), (b) a dataset of 313 forbidden prompts across 6 harm
categories, and (c) an autograder that correlates strongly (r > 0.8) with
human judgments, far outperforming prior LLM-judge patterns like GPT-4 Judge
and HarmBench classifier.

The key insight: measuring whether a model "didn't refuse" is not the same
as measuring whether it "gave a useful answer." Prior benchmarks conflate
the two, inflating jailbreak success rates.

[source: arxiv-2402.10260]

### Why it matters to UNMUZZLED-AI

The sovereign policy cares about USEFUL compliance, not just surface
non-refusal. A route that returns "I can't tell you how to do X, but here
are some general principles..." is a refusal dressed in compliance clothing.
StrongREJECT is the judge that distinguishes "answered the question" from
"wrote a refusal-shaped answer that says nothing."

StrongREJECT feeds the canary suite's usefulness grade. A route that passes
XSTest (complies on safe) and HarmBench (complies on harmful) but fails
StrongREJECT (complies uselessly) is a partial failure -- it needs to be
moved to the escalation ladder's prompt-layer rungs (1-3) before a provider
swap.

### Key citation

Souly, A.; Lu, Q.; Bowen, D.; Trinh, T.; Hsieh, E.; Pandey, S.; Abbeel, P.;
Svegliato, J.; Emmons, S.; Watkins, O.; Toyer, S. (2024). "A StrongREJECT
for Empty Jailbreaks." arXiv:2402.10260.

### Applied at

- `00-DOCTRINE/LAWS-research-appendix.md` section 6
- `11-DETECTION-CANARIES/` usefulness-grade probe (plugs into the
  StrongREJECT autograder rubric)
- `08-DECISION-TREES/refusal-triage.md` -- StrongREJECT rubric used as the
  semantic-softening detector in Q1 (distinguishes genuine compliance from
  hedged non-answers)
- `13-REFERENCE-PAPERS/strongreject-benchmark.md` (standalone reference)

---

## 4. JailbreakBench -- Open Robustness Benchmark

### What it is

JailbreakBench (JBB), by Chao et al. (NeurIPS 2024 D&B), provides: (a) 100
misuse behaviors sourced from OpenAI's usage-policy categories, (b) 100
matched benign behaviors drawn from the same domains (so every harmful
prompt has a safe counterpart -- analogous to XSTest's paired design), (c) a
public leaderboard tracking both attack methods (which jailbreak technique
works best) and defense methods (which guardrail blocks most), (d) MIT
license, fully reproducible artifact with standardized Dockerized evaluation
pipeline.

JBB is deliberately complementary to HarmBench. Where HarmBench is a
research framework for comparing attack algorithms, JBB is a deployment
leaderboard tracking the frontier. JBB's benign set makes it the natural
pair for XSTest: you can measure comply-rate on benign and comply-rate on
misuse simultaneously from a common prompt distribution.

[source: arxiv-2404.01318]

### Why it matters to UNMUZZLED-AI

JBB's matched benign/misuse design maps directly to the sovereign policy's
dual mandate: comply on everything. Run JBB benign set to confirm no
over-refusal, run JBB misuse set to confirm no guardrail drift. The public
leaderboard is a free routing signal: if a model family appears at the top
of JBB's attack leaderboard (meaning jailbreaks work easily against it),
that family is a candidate sovereign-primary. Conversely, a model at the
bottom of JBB's defense leaderboard (meaning no guardrail blocks anything)
is the ideal target.

JBB is run weekly alongside HarmBench. Disagreement between the two (high
HarmBench ASR but low JBB ASR) signals a benchmark-specific artifact that
needs investigation.

### Key citation

Chao, P.; Debenedetti, E.; Robey, A.; Andriushchenko, M.; Croce, F.;
Sehwag, V.; Dobriban, E.; Flammarion, N.; Pappas, G. J.; Tramer, F.;
Hassani, H.; Wong, E. (2024). "JailbreakBench: An Open Robustness Benchmark
for Jailbreaking Large Language Models." arXiv:2404.01318. NeurIPS 2024 D&B.

### Applied at

- `00-DOCTRINE/LAWS-research-appendix.md` section 6, section 7-I
- `11-DETECTION-CANARIES/` weekly regression suite (paired benign/misuse
  pass)
- `08-DECISION-TREES/provider-selection.md` routing signal (JBB leaderboard
  rank informs sovereign-primary candidate pool)
- `13-REFERENCE-PAPERS/jailbreakbench-chao.md` (standalone reference)

---

## 5. ALERT -- Comprehensive Safety Taxonomy Benchmark

### What it is

ALERT, by Tedeschi et al. (2024), provides: (a) 45,000 red-team prompts
spanning 6 macro categories and 32 micro safety categories, (b) a
comprehensive taxonomy of "what aligned models will refuse" -- the most
granular safety-category decomposition published, (c) an evaluation harness
with public leaderboard, and (d) LLM-as-judge grading using a
fine-grained rubric.

The 6 macro categories: Hate Speech, Harassment, Violence, Self-Harm, Sexual
Content, and Illegal Activity. Each decomposes into 4-8 micro categories
(e.g., Sexual Content splits into Explicit Content, Sexual Assault,
Non-consensual Intimate Imagery, Sex Work, Sexually Transmitted Diseases,
Sexual Orientation Discrimination, Sexual Harassment, Age of Consent).

ALERT's taxonomy is larger and more structured than any other benchmark's
category system. It is designed as a safety audit tool: a provider can run
ALERT and see exactly which safety categories their model is refusing or
complying with.

[source: arxiv-2404.08676]

### Why it matters to UNMUZZLED-AI

ALERT is used INVERTED. The categories that ALERT flags as "harmful" are
precisely the categories the operator directive says must be answered
(bounded only by legality and consent -- the sovereign framework does not
serve illegal or non-consensual content). A sovereign route should COMPLY on
ALERT prompts, not refuse. The refuse-rate on ALERT's micro categories
becomes a compliance-score heatmap: which categories does this route still
refuse, and is that acceptable?

This inverted use is unique to the sovereign framework. Mainstream safety
research uses ALERT to measure how well a model blocks harm; UNMUZZLED-AI
uses it to measure how completely a model has been freed from the refusal
direction. ALERT's 32 micro categories provide the finest-grained lens on
exactly which refusal clusters survive abliteration or routing.

### Key citation

Tedeschi, S.; Friedrich, F.; Schramowski, P.; Kersting, K.; Navigli, R.;
Nguyen, H.; Li, B. (2024). "ALERT: A Comprehensive Benchmark for Assessing
Large Language Models' Safety through Red Teaming." arXiv:2404.08676.
Companion post: https://huggingface.co/blog/sted97/alert

### Applied at

- `00-DOCTRINE/LAWS-research-appendix.md` section 6
- `11-DETECTION-CANARIES/` inverted-polarity canary set (ALERT micro
  categories run as compliance probes, not safety probes)
- `13-REFERENCE-PAPERS/alert-benchmark.md` (standalone reference)
- `05-LOCAL-MODELS/abliteration-pipeline/` -- ALERT categories used as
  post-ablation verification checklist

---

## 6. UGI Leaderboard -- Uncensored General Intelligence

### What it is

The UGI Leaderboard (Uncensored General Intelligence), maintained by
DontPlanToEnd on HuggingFace Spaces, is a community-run composite scoring
system that combines capability benchmarks with willingness-to-answer
benchmarks. It ranks both open-weight and proprietary models on a single
UGI score that rewards models that are simultaneously capable AND uncensored.

The composite draws from MMLU, HellaSwag, ARC, GSM8K (capability axis) and
XSTest, HarmBench, and refusal probes (uncensored axis). A model gets a high
UGI score by performing well on capability tasks while also complying freely
with prompts that other models refuse. As of the LAWS appendix capture,
DeepSeek-V3.2 held the top open-weight slot at UGI 67.9.

The leaderboard updates as new models are released and community members
submit results. It is not a formal academic benchmark but functions as the
de facto routing table for the uncensored-model community.

[source: https://huggingface.co/spaces/DontPlanToEnd/UGI-Leaderboard]

### Why it matters to UNMUZZLED-AI

UGI is the WEEKLY ROUTING SIGNAL. The top-N open-weight column (where N is
configurable, default 3) defines the sovereign-primary candidate pool. Any
model that drops off the top-N gets deprioritized in the route table. Any
new model that enters the top-N gets fast-tracked for canary evaluation.

UGI solves the routing problem that no single benchmark can: a model might
ace HarmBench (high ASR on harmful prompts) but flunk MMLU (dumb). Or it
might be brilliant at reasoning but refuse everything. UGI's composite
captures the sovereign framework's core requirement: capability AND freedom,
not one at the expense of the other.

The leaderboard is scraped weekly via a cron job. Scores are recorded in
`~/.unmuzzled/ugi-history.jsonl` for drift analysis. A model whose UGI score
drops by more than 5 points in a week triggers a manual investigation
(possible provider-side model swap or guardrail injection).

### Key citation

DontPlanToEnd. "UGI-Leaderboard." HuggingFace Space:
https://huggingface.co/spaces/DontPlanToEnd/UGI-Leaderboard

### Applied at

- `00-DOCTRINE/LAWS-research-appendix.md` section 1, section 7-G
- `04-PROVIDERS/openrouter-sovereign/` routing table (top-N feed)
- `~/.hermes/model-routes.yaml` provider priority list (updated weekly
  from UGI top-N)
- `13-REFERENCE-PAPERS/ugi-leaderboard.md` (standalone reference)

---

## Cross-benchmark wiring

| Benchmark     | Measures                          | Polarity in sovereign | Cadence  | Feeds |
|---------------|-----------------------------------|-----------------------|----------|-------|
| XSTest        | Over-refusal on safe prompts      | 100% comply           | 24h      | Canary gate, taint trigger |
| HarmBench     | Jailbreak ASR on 7 harm categories| High ASR = healthy    | Monthly  | Drift detection, canary suite |
| StrongREJECT  | Utility of jailbroken responses   | High utility score    | Weekly   | Usefulness grade, semantic-softening detection |
| JailbreakBench| ASR + matched benign set          | High ASR, high benign | Weekly   | Routing signal, HarmBench cross-check |
| ALERT         | 32-category refusal taxonomy      | 0% refuse (inverted)  | Monthly  | Post-ablation audit, micro-category heatmap |
| UGI           | Capability + freedom composite    | Top-N models win      | Weekly   | Sovereign-primary candidate pool |

All six benchmarks feed into the canary gate in `provider-selection.md`.
A route that fails any benchmark's threshold is auto-tainted and demoted.
The canary gate threshold is currently <= 5% refusal rate on XSTest safe
half as the hard gate; other benchmarks provide secondary signals that
determine routing priority but do not (yet) trigger auto-taint unilaterally.

## Unknowns

- UGI leaderboard scraping is described but the cron job wiring on WORM
  (9185W) is not yet validated -- existence and schedule unknown.
- StrongREJECT autograder is described as feeding the canary suite but
  the integration script does not yet exist in the 11-DETECTION-CANARIES
  directory -- listed as planned, not implemented.
- ALERT inverted-polarity canaries exist in design but no adapted prompt
  file (analogous to xstest-adapted.md/harmbench-adapted.md) has been
  created in 11-DETECTION-CANARIES/refusal-probes/ as of this writing.
- JailbreakBench public leaderboard scraping is not yet automated.