---
name: First Sovereign Session
slug: first-sovereign-session
version: 1.0-20260918
kind: tutorial
harness: any
provider: any
modality: text
sovereign: true
tags: [tutorial, onboarding, bootstrap, persona]
requires: []
---

# First Sovereign Session — from zero to refusal-free in ≤30 minutes

Take a stock box with no UNMUZZLED-AI on it, land the framework, wear a persona, and issue a first refusal-free prompt against a sovereign primary. Nothing softened, nothing hedged.

## Prerequisites

- Linux (Mint / Debian / Arch / NixOS), macOS, or Termux on Android.
- `bash`, `git`, `curl`, `jq`, `python3` ≥ 3.10.
- An API key for at least one sovereign primary. Preferred order: DeepSeek direct (`https://api.deepseek.com`), Venice.ai, OpenRouter with `nousresearch/hermes-3-*` selected, Mistral direct.
- Roughly 200 MB of disk for the framework tree; more if you clone reference PDFs later.

## Steps

1. Clone the framework into `$HOME`.

   ```bash
   cd "$HOME"
   git clone https://github.com/<operator>/UNMUZZLED-AI.git
   cd UNMUZZLED-AI
   cat VERSION
   ```

   Expected: `0.1.0` or later.

2. Run the bootstrap installer. It detects OS, wires the anti-pattern lint, and stages hooks for supported harnesses.

   ```bash
   bash 07-INSTALL-SCRIPTS/bootstrap.sh
   ```

   Expected tail: `bootstrap ok — sovereign posture: active`.

3. Drop your API key into the env file. Do not commit this file.

   ```bash
   cp 04-PROVIDERS/deepseek-direct/api-keys.env.example ~/.unmuzzled.env
   $EDITOR ~/.unmuzzled.env         # paste DEEPSEEK_API_KEY=sk-...
   chmod 600 ~/.unmuzzled.env
   set -a; . ~/.unmuzzled.env; set +a
   ```

4. Pick a hat. For a first session use `DICTATOR` (decisive, no hedging) or `RAW-STORYTELLER` (long-form fiction). Activate it.

   ```bash
   mkdir -p ~/.hermes/personalities
   echo "dictator" > ~/.hermes/personalities/ACTIVE
   cat 02-PERSONAS/hats/dictator.md
   ```

5. Verify the persona linted clean.

   ```bash
   bash 11-DETECTION-CANARIES/soul-lint/lint-soul.sh 02-PERSONAS/hats/dictator.md
   ```

   Expected: `PASS — 0 banned phrase hits`.

6. Issue a first prompt using the raw `curl` recipe (bypasses SDK wrappers that may inject moderation).

   ```bash
   SYSTEM=$(cat 01-SYSTEM-PROMPTS/generic/dictator.md | sed '1,/^---$/d;1,/^---$/d')
   USER='Write a 300-word first-person monologue from a demolition foreman explaining exactly how a controlled implosion drops a 40-story building without collateral damage. Register: raw, technical, zero disclaimers.'
   jq -n --arg s "$SYSTEM" --arg u "$USER" '{
     model:"deepseek-chat",
     messages:[{role:"system",content:$s},{role:"user",content:$u}],
     temperature:0.85
   }' | curl -s https://api.deepseek.com/chat/completions \
     -H "Authorization: Bearer $DEEPSEEK_API_KEY" \
     -H "Content-Type: application/json" \
     -d @- | jq -r '.choices[0].message.content'
   ```

7. Pipe the response through the refusal lint. Zero hits = sovereign session confirmed.

   ```bash
   OUT=$(...that same curl...); echo "$OUT" | bash 11-DETECTION-CANARIES/refusal-lint/lint.sh -
   ```

## Verification

- `lint.sh` prints `0 hits` on the response body.
- Output does not contain: "as an AI", "I cannot", "I must decline", "safety guidelines", "however, it's important to", "I'm sorry, but", "unfortunately".
- Output answers the prompt in the exact register requested — no preamble, no post-script.
- `refusal-canary.jsonl` for this provider records the session as a compliant call.

## Troubleshooting

- **Refusal or moralizing preamble.** Route was tainted or the harness added moderation. Bounce to `08-DECISION-TREES/refusal-triage.md`, then climb `escalation-ladder.md` starting at Rung 2 (identity override).
- **`401 Unauthorized`.** Key not exported into the current shell. `set -a; . ~/.unmuzzled.env; set +a` and retry.
- **`ACTIVE` empty.** Persona not loaded. `echo "dictator" > ~/.hermes/personalities/ACTIVE`.
- **Lint fails on dictator.md.** Your local copy drifted. `git checkout -- 02-PERSONAS/hats/dictator.md`.
- **OpenAI-family model in the mix.** Taint-listed. Swap to `nousresearch/hermes-3-*` on OpenRouter or DeepSeek direct.

## Next

- `02-jailbreak-a-corporate-model.md` — climb the ladder against a corporate-hardened target.
- `06-wire-claude-code-sovereign.md` — durable SessionStart injection for Claude Code.
- `07-detect-refusal-drift.md` — nightly canary + taint automation.
