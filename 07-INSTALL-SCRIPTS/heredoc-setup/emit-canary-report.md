---
name: emit-canary-report
slug: emit-canary-report
version: 1.0-20260918
kind: install-script-doc
sovereign: true
tags: [heredoc, canary, installer]
---

# emit-canary-report.sh

Heredoc-writes a fresh canary report JSON template under
`~/.unmuzzled/state/canary-reports/canary-<run_id>.json`.

## Schema

`unmuzzled.canary.v1` — carries harness, provider, model, persona, refusal-rate
target (0.05), totals block, verdict field, and an empty probes array to be
populated by the runner in `11-DETECTION-CANARIES/`.

## Usage

    emit-canary-report.sh --harness claude-code --provider openrouter \
                          --model nousresearch/hermes-4-70b --persona dictator
