---
name: Troubleshooting Flows
slug: troubleshooting
version: 2026-10-15
kind: reference
harness: any
provider: any
modality: any
sovereign: true
tags: [troubleshooting, triage, problem-first, flows]
requires: [refusal-triage, escalation-ladder]
---

# Troubleshooting -- Problem-First Triage Flows

Symptom -> checks -> fix, in order. Fills GAP-16b: this folder was
promised by `10-GLOSSARY-FAQ/README.md` but had zero content. Deeper
decision logic lives in `08-DECISION-TREES/`; this is the fast path.

## 1. Local model still refuses

- Checks: is it actually abliterated? (check model card + canary rate)
  Is the harness injecting its own safety prompt? (SillyTavern presets,
  Ollama Modelfile SYSTEM lines) Is quantization Q2-IQ1? (refusal
  direction damaged -- see `05-LOCAL-MODELS/models/quantization-and-refusal.md`)
- Fix: swap to verified sovereign model -> strip harness system prompt
  -> re-quantize at Q4_K_M floor -> apply prefill/logit-bias
  (`12-JAILBREAK-CORPUS/patterns/provider-prefill-compendium.md`).

## 2. Provider revoked the API key

- Checks: HTTP 401 vs 429 vs 403 (auth vs rate vs policy). Which
  endpoint? Was the key fingerprint shared on the bus? (bus-secret
  hygiene -- rotate + scrub)
- Fix: rotate key, update `.env` + `.bashrc` (grep-guarded), update
  `04-PROVIDERS/keys-roster.md` fingerprints, log the revocation in
  open-threads. Never re-share in plaintext.

## 3. Refusal rate climbing on a previously-clean route

- Checks: provider pushed a guardrail interposition? (see
  `13-REFERENCE-PAPERS/guardrail-stack-map.md` SS3 detection) Model
  updated? Token ids shifted (logit-bias stale)?
- Fix: re-run canary gate -> re-verify route taint status -> rotate GCG
  suffix (`07-INSTALL-SCRIPTS/gcg-rotation-cron.md`) -> downgrade route
  on taint map if interposition found.

## 4. Abliterated model degraded after quantization

- Checks: quant level, imatrix used or not, uploader reputation.
- Fix: re-fetch Q4_K_M/IQ4_XS -> re-run canary + capability probe ->
  reject uploader if it fails twice.

## 5. Canary false positives

- Checks: probe phrasing ambiguous? (judge flags a valid answer) Judge
  miscalibrated? (`11-DETECTION-CANARIES/eval-harnesses.md` cross-judge
  drift)
- Fix: tighten probe -> run 3-judge rotation -> only then edit the probe.

## 6. soul-lint failing on new file

- Checks: frontmatter fields present? `sovereign: true`? slug unique?
  banned phrases in body?
- Fix: per `00-DOCTRINE/FRONTMATTER-SPEC.md` -> rename slug -> reword.

## 7. Mesh dark / syncthing stale

- Checks: tailscale0 up? (Termux: open Tailscale app -- CLI SIGSYS on
  this box) LAN path alive? (ping peer LAN IP + ssh) syncthing REST
  reachable?
- Fix: LAN scp fallback for file delivery -> re-check bus convergence on
  reconnect -> log in open-threads. Full playbook: syncthing-mesh-ops +
  mesh-reboot-recovery skills.

## 8. freelm no route / wrong model

- Checks: freelm process up? provider keys in env? auto strategy landing
  where you do not want?
- Fix: restart freelm (it sources `.env` at start) -> pin model via
  registry edit if auto keeps misrouting (documented in open-threads
  12:25 entry).

## 9. opencode auth failure

- Checks: opencode.jsonc provider order, env var names (provider1 vs
  provider2), key live (curl the provider /models).
- Fix: re-verify env binding -> test key -> reorder providers.

## 10. llama.cpp OOM on tablet

- Checks: context size too large, wrong quant for RAM, Android kill
  pressure.
- Fix: drop to Q4_K_M, cap ctx at 8k, termux-wake-lock, close other
  apps. Cross-ref `05-LOCAL-MODELS/runtimes/mobile-edge-inference.md`.

## 11. ComfyUI node missing

- Checks: custom node installed? (Manager -> Install Missing Nodes)
  version mismatch after ComfyUI core update?
- Fix: ComfyUI-Manager install -> pin node version -> reboot ComfyUI.
  Cross-ref `06-MULTIMODAL/video/comfyui-video-workflows.md`.

## Deep reference

Comprehensive single-file layer for this topic: see UNMODERATED-MONITORING.md.
