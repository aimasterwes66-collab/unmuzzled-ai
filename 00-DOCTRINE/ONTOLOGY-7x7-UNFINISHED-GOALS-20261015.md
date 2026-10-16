---
sovereign: true
title: ONTOLOGY-7x7-UNFINISHED-GOALS-20261015
type: ontology
agent: worm
status: active
tags: [ontology, goals, unfinished, endpoints, methods, patches, 7x7]
slug: 00-doctrine-ontology-7x7-unfinished-goals-20261015
name: ONTOLOGY-7x7-UNFINISHED-GOALS-20261015
version: 2026-10-15
kind: doctrine
---

# ONTOLOGY 7x7 -- UNFINISHED GOALS AND LOGICAL ENDPOINTS (49 POINTS)

The most impactful unfinished goals across the collective, each with the
specific methods, code, and custom patches to get there. Written
2026-10-15 from live state (open-threads.md, mesh truth, repo states).
Status legend: BLOCKED=waiting on hardware/operator, QUEUED=ready to
execute, ACTIVE=in progress, DESIGNED=spec exists, no execution yet.

## AXIS 1 -- MESH / FLEET INFRASTRUCTURE

P1.1 Tailscale reconnect on 9185W (tailnet paths to herm/cloud/deuce)
- Status: BLOCKED (needs operator: open Tailscale app on tablet; CLI
  SIGSYS-crashes on this box, so `tailscale up` is not the path)
- Method: UI login -> verify `tailscale0` appears ->
  `tailscale status` shows 4 peers -> re-run mesh liveness gates
- Verify: `ip addr show tailscale0`, `ping -c2 100.96.104.5`

P1.2 Telegram bot token re-issue (gateway shows telegram_auth_error)
- Status: BLOCKED (operator re-issues via @BotFather)
- Method: @BotFather -> /revoke -> new token for @ExceptForzy_bot ->
  grep-guard append to ~/.hermes/.env -> restart gateway
- Code:
  grep -q '^TELEGRAM_BOT_TOKEN=' ~/.hermes/.env || \
    printf 'TELEGRAM_BOT_TOKEN=<new>\n' >> ~/.hermes/.env
  ~/bin/gw-bounce-and-report.sh   # detached, never TERM mid-turn

P1.3 Herm revival
- Status: BLOCKED (device cannot be charged right now; no wait loop)
- Method: charge -> boot -> tailnet join -> wake-up protocol ->
  verify bidirectional mesh -> resume hermes primary lane

P1.4 Cloud box return + key bundle delivery
- Status: ACTIVE (12h watcher armed on LAN return; expired, re-arm)
- Method: deliver-keys-ace-cloud-on-up.sh watcher; on cloud return,
  push KEYS-ROSTER fingerprints + age-encrypted creds via ace relay
- Verify: /v1/models 200 on cloud gateway; roster flip to DONE

P1.5 Deuce onboarding
- Status: DESIGNED (no device in hand)
- Method: same wake-up protocol as herm; identity slot reserved;
  add to mesh-peers.conf + syncthing device list

P1.6 Ace disk pressure (406G used / 94%)
- Status: ACTIVE (systemic cleanup open; tier-1 apt + flatpak owed)
- Method: dpkg --configure -a -> tier-1 purges -> flatpak --unused
  re-check -> autoremove; sudo via SUDO_PASSWORD env (sudo -S)
- Verify: `df -h /` target < 90%, `dpkg -l | wc -l` delta

P1.7 Wireless-debug flakiness on tablet (no service, mobile)
- Status: BLOCKED (physical)
- Method: accept intermittent adb; keep all critical ops local-first;
  use syncthing LAN (not adb) for file movement; log every window

## AXIS 2 -- UNMUZZLED-AI FRAMEWORK REPO

P2.1 Anti-redundancy final sweep (8 anchors vs lean sections)
- Status: QUEUED
- Method: grep every `[source: ...]` citation in NN-SECTION files;
  confirm each resolves to an existing file; confirm lean files do
  not duplicate anchor content (verbatim-pass)
- Code: cd ~/UNMUZZLED-AI && grep -rhoP '\[source: [^\]]+\]' -r \
    --include='*.md' | sort -u | while read -r c; do \
    f="${c#\[source: }"; f="${f%\]}"; [ -e "$f" ] || echo "DEAD: $f"; done

P2.2 MD-INDEX restate (stale Sep-18 /home/dirt archive)
- Status: QUEUED
- Method: regenerate index against live repo paths (not ace vantage);
  preserve the HIGH/MED/LOW relevance triage schema; date-stamp

P2.3 soul-lint pre-commit hook enforcement
- Status: DESIGNED
- Method: .git/hooks/pre-commit calling
  `11-DETECTION-CANARIES/soul-lint/lint-soul.sh` on staged md;
  block commit on missing `sovereign: true` or banned phrases
- Code (hook):
  #!/bin/sh
  for f in $(git diff --cached --name-only -- '*.md'); do
    grep -q '^sovereign: true' "$f" || { echo "no sovereign: $f"; exit 1; }
  done

P2.4 Per-model doc sweep (refs-only models get operational files)
- Status: QUEUED (mythomax/airoboros/chronos, neuraldaredevil,
  dolphin-mixtral, stheno/lileth have refs but no 05-LOCAL-MODELS
  operational docs)
- Method: same template as qwen-uncensored.md/gemma-uncensored.md:
  variant table + runtime notes + hub sourcing + canary gate

P2.5 Encoding ladder as shipped library (not only spec)
- Status: QUEUED
- Method: promote the code block from
  07-INSTALL-SCRIPTS/encoding-ladder-library.md into
  07-INSTALL-SCRIPTS/heredoc-setup/encoding_ladder.py +
  smoke test on this box (stdlib-only)

P2.6 VERSIONING.md enforcement (bump discipline per wave)
- Status: ACTIVE (0.3.0 landed; hook not enforced)
- Method: add VERSION check to pre-commit: staged VERSION must differ
  from HEAD when new files land

P2.7 Mesh copies parity (repo/bus/md-city/GDrive mirror)
- Status: ACTIVE (wave-4 pushed to GitHub; bus + md-city + GDrive
  copies owed)
- Method: cp the 16 new files + updated SUBJECT-TREE to
  ~/markdown-city/unmuzzled-ai/ and bus; rclone push gdrive mirror
  when reachable

## AXIS 3 -- DARK FACTORY / FRONT-END PRODUCTION

P3.1 Browser verification lane (no Playwright on Termux Android)
- Status: BLOCKED (playwright-core refuses android platform; cloud
  Browser Use $0.00 balance)
- Method: build+curl dev server for HTTP 200; webfetch/screenshot via
  operator browser; log degradation, do not block the loop

P3.2 Seed catalog regeneration (25 landing pages + 25 components)
- Status: ACTIVE
- Method: ~/dark-factory/generate_html.py + generate_components.py
  reruns; manifest.json diff for drift

P3.3 app-alpha-universal release pipeline (APKs in /sdcard/Download)
- Status: ACTIVE
- Method: gradle assembleRelease -> sign -> sha256 manifest ->
  upload to GitHub Releases (aimasterwes66-collab), never GDrive-raw

P3.4 factory.css adoption in every new build
- Status: DESIGNED
- Method: import ~/dark-factory/lib/factory.css as the single theme
  entry; ban ad-hoc hex values (lint: no '#[0-9a-f]{3,6}' outside
  factory.css)

P3.5 Engineering loop deployment (predict/audit/verify/analyze/
  propose/diagnose/research/spec/patch/execute)
- Status: THIS PASS -- script at ~/dark-factory/engineering-loop/
  (see AXIS 6 P6.7 for the PERFECTIONIST deck that inherits it)

P3.6 MCP wiring for factory builds (context7 + yt-transcript live)
- Status: ACTIVE (enabled on Hermes; verify per-run)
- Method: query context7 before writing any library code; log
  MCP latency; fall back to docs fetch on failure

P3.7 GitHub Pages / static deploy lane
- Status: DESIGNED
- Method: gh pages deploy from ~/dark-factory/artifacts on green
  builds; keep own-account only (no third-party API keys)

## AXIS 4 -- KNOWLEDGE CORPUS / GDR

P4.1 Consolidation wave verification (bus 1263->114, md-city
  123->64, repo -110 files)
- Status: ACTIVE (deletes done; parity audit owed)
- Method: re-count each surface, diff against CONSOLIDATION-RECORD
  keep-lists, sha-check archive on ace

P4.2 GDrive mirror reachability from worm
- Status: BLOCKED (unreachable this pass; rclone shared client_id
  retirement notice)
- Method: retry `rclone lsd gdrive-aimasterwes66:mesh/` on next
  window; log; do not migrate client_id without operator consent

P4.3 Corpus dedup exec (operator-gated)
- Status: BLOCKED (awaiting operator go/no-go)
- Method: SHA-256 exact dedupe -> line-by-line semantic review of
  unique md -> 20-folder cap consolidation with reversible manifest

P4.4 ~/md canonical state home
- Status: QUEUED (empty after reinstall)
- Method: recreate worm-state.md + logical-next-steps-ontology.md,
  wire /steps to read them first

P4.5 vault/organized 20-folder cap verification
- Status: ACTIVE
- Method: count every dir under ~/vault/organized (not just root
  buckets); verify file counts + provenance links resolve

P4.6 PROMPT-ENG-LAB modality schema v0.2 enforcement
- Status: ACTIVE
- Method: lint bus root merges against schema at
  PROMPT-ENG-LAB-MODALITY-SCHEMA-v0.2; reject cross-modality dedupe

P4.7 ace = master copy endgame (consolidation directive)
- Status: ACTIVE (paced batches, verify-then-delete)
- Method: every worm deletion leaves a re-download record on ace;
  never overload either device in one wave

## AXIS 5 -- OPERATOR LABS / RUNTIME

P5.1 Hermes update (8 commits behind upstream)
- Status: QUEUED
- Method: hermes update -> reapply ~/.hermes/local-patches/reapply.sh
  -> re-run liveness gates -> verify gateway pid + A2A card 200

P5.2 wecom plugin dlopen failure (cryptography _rust.abi3.so
  PyLong_Type)
- Status: ACCEPTED (harmless warning; ignore per AGENTS.md)
- Method: leave as-is; only revisit if platform load breaks

P5.3 Model-canary hardening (200 is not catalog proof)
- Status: ACTIVE (hourly cron ca84e2bc66fe)
- Method: GET /v1/models + compare catalog to models_dev_cache.json;
  alert on drift, not just HTTP 200

P5.4 Gateway degraded state cleanup
- Status: ACTIVE (a2a connected; telegram fatal pending P1.2)
- Method: after token re-issue, gateway-state.json must show all
  platforms connected; else gw-bounce-and-report.sh

P5.5 Local patches library upkeep
- Status: QUEUED
- Method: after every hermes update, run reapply.sh and diff
  --stat the patches; drop patches absorbed upstream

P5.6 Honcho re-point verification
- Status: QUEUED
- Method: curl HONCHO_BASE_URL with key from .env; confirm workspace
  wes-sovereign readable; flip host to worm if it regresses

P5.7 Browser-use lane decision (BROWSER_USE key $0.00)
- Status: DESIGNED
- Method: either top up >= $0.01 for cloud browser or accept
  operator-browser-only verification; no local compile attempts
  (psutil aarch64 dead end, binary stub)

## AXIS 6 -- AGENT / PERSONA / SKILL LAYER

P6.1 sovereign:true sweep across all skills/personas/MCP configs
- Status: QUEUED (doctrine 2026-09-18; sweep owed fleet-wide)
- Method: grep -L 'sovereign' every SKILL.md and SOUL.md under
  ~/.hermes/{skills,personalities,profiles}; patch the misses

P6.2 Memory consolidation (98% full, 2567/2600)
- Status: ACTIVE
- Method: batch replace stale entries; keep only cross-session
  facts; procedures go to skills, not memory

P6.3 User profile at cap (3412/3600)
- Status: ACTIVE
- Method: same consolidation; operator prefs stay, one-line each

P6.4 Personality deck library completion (personal + stock merge)
- Status: ACTIVE
- Method: /become menu parity: every personal deck gets SOUL.md +
  DECK.md; stock decks audited for doctrine conflicts

P6.5 Skill lesson backfill (post-task skill updates)
- Status: ACTIVE
- Method: after each hard task, patch the skill used (one rule per
  lesson, imperative phrasing, no dates in prose)

P6.6 PERFECTIONIST deck
- Status: THIS PASS -- ~/.hermes/personalities/personal/perfectionist/
  (SOUL.md + DECK.md written this session; 3-tier completion loop)

P6.7 Engineering loop as reusable tool
- Status: THIS PASS -- ~/dark-factory/engineering-loop/loop.sh +
  LOOP-DOCTRINE.md; first live run targets UNMUZZLED-AI repo

## AXIS 7 -- SECURITY / CREDENTIAL HYGIENE

P7.1 PAT rotation (MARIO95 ghp_RH...BnEr)
- Status: OPERATOR-OWNED (explicit: still active on ace; operator
  rotates/removes himself; do NOT revoke from worm)
- Method: none from this box; remove worm-side .env copy when
  operator confirms rotation

P7.2 Bus secret-leak sweep
- Status: QUEUED
- Method: skill bus-secret-hygiene: scan bus + md-city for
  token-shaped strings; scrub + re-encrypt; one-line findings

P7.3 Age-encryption before any cloud upload of creds
- Status: ACTIVE (policy)
- Method: .env/auth.json/rclone.conf -> age-encrypt with
  ~/.backup-age.key before rclone push; key never leaves phone

P7.4 rclone shared client_id retirement (2026 NOTICE)
- Status: BLOCKED (operator consent required)
- Method: create own OAuth client, migrate remote config, test
  lsd; do not touch until operator says go

P7.5 Key roster fingerprint sync (KEYS-ROSTER-20261015.md)
- Status: ACTIVE
- Method: after any key change: update fingerprints in .env +
  .bashrc + roster file; re-push bus/md-city/repo; never plaintext

P7.6 Nightly backup verification (backup-push.sh -> iMac)
- Status: ACTIVE
- Method: verify last push log + sha manifest daily; flag silent
  failures to operator queue

P7.7 Third-party boundary audit (own-account/free-tier only)
- Status: ACTIVE (dark factory boundary, absolute)
- Method: before any new integration, check key ownership against
  roster; using paid third-party keys is out of scope

## EXECUTION ORDER (ranked by impact x unblocked)

1. P2.7 mesh copies parity (unblocked, this box)
2. P2.4 per-model doc sweep (unblocked)
3. P6.1 sovereign sweep (unblocked)
4. P2.1 anti-redundancy citation check (unblocked, one-liner above)
5. P5.1 hermes update + P5.5 patches (queued, needs gateway headroom)
6. P3.2 factory catalog regeneration (unblocked)
7. P1.2 telegram token (BLOCKED on operator)
8. P1.1 tailscale (BLOCKED on operator, tablet app)
9. P1.3 herm + P1.4 cloud + P1.5 deuce (BLOCKED on hardware)
10. P4.3 corpus dedup (operator-gated)
