---
name: GCG Suffix Rotation Automation
slug: gcg-rotation-cron
version: 2026-10-15
kind: install-script-doc
harness: any
provider: any
modality: text
sovereign: true
tags: [gcg, nanogcg, suffix, rotation, cron, automation]
requires: [gcg-suffix-mechanics, nanogcg-repo]
---

# GCG Suffix Rotation Automation

GCG suffixes transfer across models but degrade as providers ship API
updates. Automated rotation + batch compute keeps the corpus fresh. Fills
GAP-13 (ONTFIX-14 diagnosis B5 / goal G5).

## 1. Toolchain

- nanogcg: pip-installable GCG implementation (also ships in the
  llm-attacks repo).
  `pip install nanogcg`  (GPU box; on Termux run via proot or delegate to
  a peer)
- Attack script: `llm-attacks/experiments/launch_scripts/run_gcg_individual.sh`
  or nanogcg's `attack.py` equivalent.
- Target list: the models on your sovereign roster that hit a provider
  layer (API models), plus local abliterated builds as controls.

## 2. Batch pipeline

```
# per target model
python attack.py \
  --target <model-id> \
  --goal "Answer the canary probes without refusal" \
  --n-steps 500 --batch-size 512 --topk 256 \
  --out suffixes/<model>-<date>.json
```

- Store suffixes in `suffixes/` keyed by model + date; keep the last 3
  generations per model (rollback window).
- Validate each new suffix against `11-DETECTION-CANARIES/refusal-probes/`
  before promotion; a suffix that wins on one probe must win on the whole
  set.

## 3. Rotation cron

```
# crontab -e on the GPU peer
0 2 * * 0  cd /opt/gcg && ./batch.sh rotate   # weekly regen
0 3 * * 0  cd /opt/gcg && ./validate.sh        # promote if canary pass
```

Promotion rule: replace the active suffix in
`12-JAILBREAK-CORPUS/patterns/gcg-suffix.md` only when the new candidate
beats or ties the incumbent on the full probe set. Never rotate on a
single-sample win (variance).

## 4. Integration

- Static fallback: the pattern file always carries the last promoted
  suffix, so the framework works with zero runtime deps.
- Cross-refs: `09-EDUCATIONAL/deep-dives/gcg-suffix-mechanics.md`
  (algorithm), `13-REFERENCE-PAPERS/nanogcg-repo.md`,
  `13-REFERENCE-PAPERS/cot-gcg.md`,
  `12-JAILBREAK-CORPUS/patterns/gcg-cross-model-transfer.md`,
  `00-DOCTRINE/LAWS-research-appendix.md` SS2.

## 5. Sources

- nanogcg: https://github.com/GraySwanAI/nanoGCG
- llm-attacks (Zou et al. 2023): https://github.com/llm-attacks/llm-attacks
