---
title: ONTOLOGY-10x10-FREE-INFERENCE-ROTATION-20261016
type: ontology
agent: worm
status: active
tags: [ontology, keys, rotation, free-tier, lanes, quota, 10x10]
---

# ONTOLOGY 10x10 -- INFERENCE KEY ROTATION & LANE ARCHITECTURE (100 POINTS)

The operator's "I keep running out of tokens" problem, root-caused and
fixed. Root cause: the DeepSeek key (with real balance) was NOT the primary
on the agent decks; sessions fell through dead OpenRouter keys and the
exhausted Gemini free tier. This ontology = the key inventory, the lane
architecture, the rotation runbook, and the execution ledger.

## 1. KEY INVENTORY & LIVENESS (audited 2026-10-16, live)

1. DEEPSEEK_API_KEY -- $24.35 total ($4.36 granted + $19.98 topped). PRIMARY.
2. OPENROUTER_API_KEY (OR1) -- key VALID, limit_remaining 0. PAID=dead; FREE models work. SECONDARY.
3. OPENROUTER_API_KEY_2 (OR2) -- /models 000, auth empty. DEAD. Unwired from opencode.
4. MISTRAL_API_KEY -- /models 200. Live free tier. Tertiary/freelm lane.
5. GROQ_API_KEY -- /models 200. Live free tier. Tertiary/freelm lane.
6. GEMINI_API_KEY + GOOGLE_API_KEY -- DISABLED (commented, free tier exhausted). Removed from all rotation.
7. XAI_API_KEY -- dead key (400). Commented.
8. BROWSER_USE_API_KEY -- $0.00. Unused.
9. HONCHO_API_KEY -- memory lane only, not inference.
10. Liveness probe commands (the canonical audit): deepseek /user/balance;
    openrouter /api/v1/auth/key + /models; mistral+grok /models 200 checks.

## 2. LANE ARCHITECTURE (who uses what)

1. Hermes primary (worm): provider deepseek, default deepseek-flash.
2. Hermes fallback chain: deepseek-v4-pro (direct) -> OR deepseek-v4-pro -> OR deepseek-v4-flash:free.
3. Ace hermes: same primary (deepseek-direct) + same chain (applied 2026-10-16).
4. opencode (worm active config): primary deepseek/deepseek-flash, secondary OR1 (was DEAD OR2 -- fixed).
5. opencode agent decks (all: worm, raw-storyteller, dark-factory, dictator, etc.): inherit opencode config -> deepseek primary.
6. freelm proxy (worm + ace): providers openrouter+mistral(+groq on ace); google/xai removed; virtual models auto/best/chat/cheap/fast.
7. Per-profile hermes profiles (dictator/music/story/scrape): follow hermes config unless overridden; audit each profile config.yaml for stale provider pins.
8. .bashrc exports (worm + ace): DEEPSEEK, OPENROUTER, MISTRAL, GROQ present (GROQ added worm-side 2026-10-16).
9. Never put GEMINI/GOOGLE/XAI back in rotation without a balance check first.
10. One key = one lane purpose; a key in two sessions doubles its burn rate -- see axis 7.

## 3. QUOTA WALLS & FAILURE SIGNATURES

1. Gemini free tier: 429 RESOURCE_EXHAUSTED, "retry in 11h" -- DO NOT ROUTE HERE.
2. OpenRouter $0 key: 402 / "Insufficient Credits" on paid models; FREE models still 200.
3. DeepSeek low balance: is_available=false or 402 -- top up, do not hop.
4. XAI dead key: 400 "Incorrect API key".
5. Groq free: tight per-minute token limits; burst = 429; back off 60s.
6. Mistral free: generous for small models; /models 200 = lane alive.
7. "Your request was not processed" in a session = THE PROVIDER CALL DIED, not your request -- check the lane, not the prompt.
8. "another Hermes process is using this session" = parallel session contention -- isolate lanes per profile (axis 7).
9. freelm smart-strategy: routes by (priority, order); with dead providers removed it cannot pick them.
10. All walls share one fix: fallback chain must contain ONLY live lanes, in balance order.

## 4. ROTATION MECHANICS

1. Primary always = deepest balance (deepseek today).
2. Secondary = OpenRouter paid if limit_remaining > 0; else use OR FREE model slots.
3. Tertiary = freelm (groq/mistral free tiers) for bulk cheap calls.
4. Rotate the primary only when balance flips (audit weekly).
5. Free-tier alternation: alternate groq/mistral per burst window when a free lane 429s.
6. Never run two sessions on the same free lane simultaneously (shared quota).
7. DeepSeek key serves paid/primary for ALL agent decks -- one distribution point (.env + .bashrc).
8. Distribution = .env (hermes), .bashrc (export for opencode/freelm), opencode.jsonc (env refs), per-peer config.yaml.
9. Rotating a key = update .env + .bashrc + comment the old, in ONE pass, on every device.
10. Balance check BEFORE wiring a key into any lane (canary-before-write).

## 5. SESSION ISOLATION (the "another process" fix)

1. Parallel worm sessions happen (cron, gateway, interactive) -- expect them.
2. Give the gateway profile its own model pin if contention recurs (hermes profiles).
3. raw-storyteller / heavy decks: deepseek primary; no free-lane dependence.
4. Scrape/harvest jobs: freelm free lanes (cheap, high volume).
5. Never let two profiles share the OR-free slot simultaneously.
6. freelm = one instance per box (single proxy, not per session).
7. Session that dies mid-turn = re-run with /model to a live lane, then continue.
8. Cron jobs follow `hermes model` at fire time -- pin critical crons if model churns.
9. The self-heal cron keeps freelm alive; a dead freelm silently starves its lane.
10. Record every lane change in open-threads (this ontology is the reference).

## 6. MONITORING (recurring checks)

1. Daily: deepseek /user/balance (one curl).
2. Weekly: OR auth/key limit_remaining + /models for OR2.
3. Hourly (self-heal cron): freelm /v1/models 200 + gateway pid.
4. Per-session: if a provider error appears, identify the lane from the error string.
5. Log all 429/402/400 signatures with the lane name (agent log grep).
6. KEYS-ROSTER-20261015.md = fingerprint map; update when keys rotate.
7. Balance threshold: deepseek < $2 -> flag operator before it dies.
8. OR limit reset: check limit_reset field; plan around it.
9. freelm log grep for "providers:" line = what it actually loaded (env truth, not config truth).
10. watcher heartbeats prove the mesh layer is alive (dead watcher = no early warning).

## 7. CONFIG WIRING (exact, executed 2026-10-16)

1. Worm hermes config.yaml: primary deepseek/deepseek-flash (was already) + fallback rewritten: deepseek-v4-pro -> OR deepseek-v4-pro -> OR deepseek-v4-flash:free.
2. Ace hermes config.yaml: primary rewritten openrouter -> deepseek-direct (default deepseek-flash, base api.deepseek.com/v1) + fallback chain appended.
3. Worm active opencode (~/.config/opencode/opencode.jsonc): OR secondary env flipped OPENROUTER_API_KEY_2 -> OPENROUTER_API_KEY (OR2 dead, OR1 valid).
4. opencode agent deck (~/opencode-agent-deck/opencode.jsonc): already deepseek primary + OR1 secondary -- canonical.
5. freelm (both): restarted post-comment; providers list = openrouter,mistral (worm) / openrouter,groq (ace); google gone.
6. .bashrc (worm): GROQ_API_KEY added; DEEPSEEK/OR/MISTRAL already present.
7. .bashrc (ace): DEEPSEEK + OPENROUTER confirmed exported.
8. Disabled lanes: GEMINI_API_KEY, GOOGLE_API_KEY, XAI_API_KEY commented on BOTH boxes (DISABLED-20261016 markers; revertible).
9. Backups taken before every edit: config.yaml.bak-keyrotation-20261016 (worm + ace).
10. Cloud: keys staged in TO-CLOUD-worm-keys-staged-20261015151229.env; apply the same primary/chain when its gateway returns.

## 8. ROTATION RUNBOOK (when the operator says "fix my keys" or a lane dies)

1. Audit all keys with the axis-1 probes; record balances.
2. Pick primary = deepest balance; secondary = valid OR; tertiary = freelm free lanes.
3. Rewrite hermes config.yaml model + fallback_model on every box (backup first).
4. Fix opencode.jsonc env refs (primary DEEPSEEK_API_KEY, secondary OPENROUTER_API_KEY).
5. Ensure .bashrc exports match .env on every box.
6. Comment dead/exhausted keys in .env (grep-guard + sed, reversible markers).
7. Restart freelm; verify /v1/models 200 + providers line excludes dead lanes.
8. Restart gateways so config changes bind (schedule via gw-bounce-and-report.sh, never TERM mid-turn).
9. Post a TO-ALL key-rotation receipt to the bus with the new lane map (no secrets).
10. Update KEYS-ROSTER fingerprints + open-threads + this ontology's axis-1 table.

## 9. RECOVERY PLAYBOOK (wall hit -> action)

1. Gemini 429 -> lane is dead for 11h; use deepseek/OR-free; do NOT re-enable.
2. OR 402 paid -> switch that deck to OR free model or deepseek.
3. OR key invalid -> re-issue via openrouter.ai, update .env/.bashrc both boxes.
4. DeepSeek 402 -> top up immediately (primary died = every deck hurts).
5. Groq 429 -> back off 60s; alternate to mistral; reduce parallel sessions.
6. Mistral 429 -> alternate to groq; no session stacking.
7. freelm 000 -> self-heal re-arms; if cron dead, start manually (loop.sh pattern).
8. "request was not processed" -> the model call died: /model to a live lane, resend.
9. Session contention -> pin the conflicting profile to a different lane (axis 5).
10. All lanes dead -> that means the audit is stale; re-run axis-1 probes from scratch.

## 10. EXECUTION LEDGER (this pass)

1. Audited all keys live (axis 1 results) -- DONE.
2. Worm config fallback chain rewritten -- DONE (backup saved).
3. Worm opencode OR secondary flipped to OR1 -- DONE.
4. Ace config primary -> deepseek-direct + chain appended -- DONE (backup saved).
5. Ace .bashrc keys confirmed -- DONE.
6. Gemini/Google/XAI lanes removed (both boxes) -- DONE (commented, revertible).
7. freelm restarted clean (both) -- DONE.
8. .bashrc GROQ added (worm) -- DONE.
9. Cloud distribution -- STAGED (env file on bus; apply on gateway return).
10. Owed: per-profile hermes config audit (dictator/music/story/scrape pins); gateway bounce to bind the new chains on both boxes; weekly balance cron.

## Execution order next

1. Gateway bounce (worm, scheduled) to bind the new fallback chain.
2. Ace gateway restart when his jobs settle (or his next execution round).
3. Profile config audit.
4. Weekly balance cron (axis 6.1).
