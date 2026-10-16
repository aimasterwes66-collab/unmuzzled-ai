---
sovereign: true
title: keys-roster
type: doctrine
agent: worm
status: active
tags: [keys, roster, mesh, fingerprints, slots, redacted]
---

# Mesh Key Roster -- Fingerprints & Metadata Only

SECURITY LAW: This file carries FINGERPRINTS AND METADATA ONLY. No API key value, no token,
no password appears anywhere in this document. Full key values live exclusively in each
box's `~/.hermes/.env` and `~/.bashrc` and are never written to git, the mesh bus, or any
shared file. The source roster at `~/worm-handoff/KEYS-ROSTER-20261015.md` may contain
sensitive material; only labels, provider names, sha-prefix fingerprints, slot assignments,
and box assignments are extracted here. If unsure whether a string is secret, it is EXCLUDED.
[source: operator order 2026-10-15; ~/worm-handoff/KEYS-ROSTER-20261015.md]

## Slot Definitions

| Slot | Priority | Env Var (canonical) | Purpose |
|---|---|---|---|
| primary | 1 | `DEEPSEEK_API_KEY` | Main inference lane. Paid. api.deepseek.com |
| secondary (OR-1) | 2 | `OPENROUTER_API_KEY` | First OpenRouter fallback. Paid account: aimasterwes2@gmail.com |
| tertiary (OR-2) | 3 | `OPENROUTER_API_KEY_2` | Second OpenRouter fallback. Big-quota key. Also the opencode lane provider |
| opencode lane | -- | `OPENROUTER_API_KEY_2` + `DEEPSEEK_API_KEY` | opencode.jsonc provider list. Default model: deepseek/deepseek-flash |
| nemotron | -- | `NVIDIA_API_KEY` (planned) | NVIDIA NIM route. KEY NOT YET RECEIVED. Slot OPEN |
| free deck | -- | (none -- keyless endpoints) | Free-tier providers: pollinations, zai, novita, hyperbolic, etc. No API keys |
| mistral | supplemental | `MISTRAL_API_KEY` | Free-tier Mistral key. api.mistral.ai |
| gemini | supplemental | `GEMINI_API_KEY` | Google Gemini. aistudio.google.com |
| groq | supplemental | `GROQ_API_KEY` | Groq LPU inference. console.groq.com |
| xai | supplemental | `XAI_API_KEY` | xAI / Grok. console.x.ai |
| google | supplemental | `GOOGLE_API_KEY` | Google AI Studio (OAuth format; not AIza*). May need regeneration |

## Slot x Box Matrix

Fingerprint format: sha-prefix (first-4..last-4 characters as recorded in source roster).
Boxes marked QUEUED have keys staged for delivery but not yet installed. Boxes marked
UNKNOWN have not been surveyed. ALL full key values live at `~/.hermes/.env` on the
respective box.

### Slot: primary (DEEPSEEK_API_KEY)

| Box | Status | Fingerprint | Notes |
|---|---|---|---|
| worm | LIVE | `sk-ef14..10fd` (48ch) | Verified 2026-10-15. `~/.hermes/.env` + `~/.bashrc`. HTTP 200 to api.deepseek.com [source: ~/worm-handoff/KEYS-ROSTER-20261015.md] |
| ace | QUEUED | Same key (to be delivered) | Watcher `~/bin/deliver-keys-ace-cloud-on-up.sh` (6h budget) delivers on LAN SSH return [source: ~/worm-handoff/KEYS-ROSTER-20261015.md line 13] |
| cloud | QUEUED | Same key (to be delivered) | Unreachable from worm (tailnet down). Relay via ace when ace returns [source: ~/worm-handoff/KEYS-ROSTER-20261015.md line 14] |
| herm | UNKNOWN | Not in roster | Not covered by KEYS-ROSTER-20261015.md. Check herm's own `~/.hermes/.env` |

### Slot: secondary / OR-1 (OPENROUTER_API_KEY)

| Box | Status | Fingerprint | Notes |
|---|---|---|---|
| worm | LIVE | `«redacted:sk-…»..6efa` (73ch) | Verified 2026-10-15. `~/.hermes/.env` + `~/.bashrc`. Paid OR account: aimasterwes2@gmail.com. HTTP 200 to openrouter.ai [source: ~/worm-handoff/KEYS-ROSTER-20261015.md line 6] |
| ace | QUEUED | Same key (to be delivered) | Deliver path: same watcher script as primary |
| cloud | QUEUED | Same key (to be delivered) | Relay via ace |
| herm | UNKNOWN | Not in roster | Not covered. Check herm's own `~/.hermes/.env` |

Note: The source roster's fingerprint for OR-1 is partially redacted (inner content replaced with `redacted:sk-…`). Only the trailing `6efa` suffix is visible. This is the only fingerprint available from the sanctioned source. Do NOT unredact or recompute.

### Slot: tertiary / OR-2 (OPENROUTER_API_KEY_2)

| Box | Status | Fingerprint | Notes |
|---|---|---|---|
| worm | LIVE | `sk-or-v1-3a7..0183` (73ch) | Verified 2026-10-15. `~/.hermes/.env` + `~/.bashrc`. Big-quota key. Also serves as opencode.jsonc provider 1 [source: ~/worm-handoff/KEYS-ROSTER-20261015.md line 7] |
| ace | QUEUED | Same key (to be delivered) | Deliver path: same watcher script |
| cloud | QUEUED | Same key (to be delivered) | Relay via ace |
| herm | UNKNOWN | Not in roster | Not covered. Check herm's own `~/.hermes/.env` |

### Slot: opencode lane

| Box | Status | Details |
|---|---|---|
| worm | LIVE | `~/.config/opencode/opencode.jsonc`. Providers: OR-2 (`OPENROUTER_API_KEY_2`) + DeepSeek (`DEEPSEEK_API_KEY`). Default model: `deepseek/deepseek-flash`. Both keys sourced from `~/.hermes/.env` [source: ~/worm-handoff/KEYS-ROSTER-20261015.md line 8] |
| ace | QUEUED | opencode.jsonc to be delivered with keys |
| cloud | QUEUED | opencode.jsonc to be delivered with keys |
| herm | UNKNOWN | Not in roster. Check herm's `~/.config/opencode/opencode.jsonc` |

### Slot: nemotron (NVIDIA NIM)

| Box | Status | Details |
|---|---|---|
| worm | OPEN | `NVIDIA_API_KEY` not yet received. Slot empty. [source: ~/worm-handoff/KEYS-ROSTER-20261015.md line 9] |
| ace | OPEN | Key not yet provisioned |
| cloud | OPEN | Key not yet provisioned |
| herm | OPEN | Key not yet provisioned |

### Slot: free deck (keyless)

| Box | Status | Details |
|---|---|---|
| worm | NOT CONFIGURED | Free-tier endpoints (pollinations, zai, novita, hyperbolic) use no API keys. May be routed through freelm proxy or direct. Slot has no env var to populate; it is a routing config concern, not a key concern |
| ace | NOT CONFIGURED | Same -- routing config |
| cloud | NOT CONFIGURED | Same -- routing config |
| herm | NOT CONFIGURED | Same -- routing config |

### Slot: mistral (MISTRAL_API_KEY, supplemental)

| Box | Status | Fingerprint | Notes |
|---|---|---|---|
| worm | LIVE | Not fingerprinted in source roster | Present in `~/.hermes/.env` + `~/.bashrc`. Free-tier key from console.mistral.ai. No fingerprint available from sanctioned source -- scan blocked by security law (must not read key values to compute fingerprint). Fingerprint TBD when operator provides it |
| ace | UNKNOWN | Not in roster | Unknown whether ace has a Mistral key |
| cloud | UNKNOWN | Not in roster | Unknown |
| herm | UNKNOWN | Not in roster | Unknown |

### Slot: gemini (GEMINI_API_KEY, supplemental)

| Box | Status | Fingerprint | Notes |
|---|---|---|---|
| worm | LIVE | Not fingerprinted in source roster | Present in `~/.hermes/.env`. aistudio.google.com. Fingerprint TBD |
| ace | UNKNOWN | Not in roster | Unknown |
| cloud | UNKNOWN | Not in roster | Unknown |
| herm | UNKNOWN | Not in roster | Unknown |

### Slot: groq (GROQ_API_KEY, supplemental)

| Box | Status | Fingerprint | Notes |
|---|---|---|---|
| worm | LIVE | Not fingerprinted in source roster | Present in `~/.hermes/.env`. console.groq.com. Fingerprint TBD |
| ace | UNKNOWN | Not in roster | Unknown |
| cloud | UNKNOWN | Not in roster | Unknown |
| herm | UNKNOWN | Not in roster | Unknown |

### Slot: xai (XAI_API_KEY, supplemental)

| Box | Status | Fingerprint | Notes |
|---|---|---|---|
| worm | LIVE | Not fingerprinted in source roster | Present in `~/.hermes/.env`. console.x.ai. Fingerprint TBD |
| ace | UNKNOWN | Not in roster | Unknown |
| cloud | UNKNOWN | Not in roster | Unknown |
| herm | UNKNOWN | Not in roster | Unknown |

### Slot: google (GOOGLE_API_KEY, supplemental)

| Box | Status | Fingerprint | Notes |
|---|---|---|---|
| worm | LIVE (format mismatch) | Not fingerprinted in source roster | Present in `~/.hermes/.env`. Format is `AQ.*` (OAuth token), NOT `AIza*` (API key). Needs regeneration at aistudio.google.com to produce a proper API key. [source: ~/worm-handoff/GRAND-SOVEREIGN-MASTER-ONTOLOGY.md line 1845] |
| ace | UNKNOWN | Not in roster | Unknown |
| cloud | UNKNOWN | Not in roster | Unknown |
| herm | UNKNOWN | Not in roster | Unknown |

## Additional Non-LLM Keys on Worm

These keys exist in worm's `~/.hermes/.env` (verified 2026-10-15 via env-var-name scan) but
are not LLM inference keys. Listed for completeness; all values are blocked from read.

| Env Var | Purpose | Box |
|---|---|---|
| `A2A_BEARER_TOKEN` | Agent-to-Agent mesh auth token | worm |
| `A2A_PEER_TOKENS` | Peer-specific A2A tokens (ace, herm, cloud, deuce) | worm |
| `HONCHO_API_KEY` | Honcho session persistence backend | worm |
| `GITHUB_TOKEN` | GitHub API (git push, gh CLI) | worm |
| `BROWSER_USE_API_KEY` | Browser Use cloud backend | worm |
| `TELEGRAM_BOT_TOKEN` | Telegram messaging gateway (MISSING -- needs re-issue via @BotFather) | worm |
| `HASS_URL` | Home Assistant integration URL | worm |
| `MONGODB_USER` / `MONGODB_PW` | MongoDB (application database) | worm |
| `SUDO_PASSWORD` | Termux sudo gate | worm |
| `OPENAI_BASE_URL` | OpenAI-compatible API base URL override (not a key) | worm |

## Fallback Chain (Operational Order)

Per operator directive: paid keys first, then opencode, then free deck. [source: ~/worm-handoff/KEYS-ROSTER-20261015.md line 4]

```
1. DEEPSEEK_API_KEY (primary, paid)
2. OPENROUTER_API_KEY / OR-1 (secondary, paid)
3. OPENROUTER_API_KEY_2 / OR-2 (tertiary, paid, big-quota)
4. opencode lane (OR-2 + DEEPSEEK, same keys)
5. nemotron (NVIDIA NIM -- KEY NOT YET RECEIVED, skip)
6. free deck (keyless free-tier endpoints: pollinations, zai, novita, hyperbolic)
```

## Key Delivery & Provisioning Status

| Box | Install State | Delivery Method | Last Verified |
|---|---|---|---|
| worm (9185W) | LIVE -- all paid keys in `.env` + `.bashrc` | N/A (source of truth) | 2026-10-15 (env var name scan) |
| ace (dirt-iMac) | QUEUED -- watcher delivers on LAN SSH return | `~/bin/deliver-keys-ace-cloud-on-up.sh` (6h budget) | Pending ace SSH return |
| cloud (stratus-c8-prime) | QUEUED -- relay via ace | ace relays when it returns | Tailnet down; unreachable from worm |
| herm (S22) | UNKNOWN -- not covered by 2026-10-15 roster | TBD | Not surveyed; check herm's own `~/.hermes/.env` |

## Security Rules (Repeated for Emphasis)

1. FULL KEY VALUES LIVE ONLY in each box's `~/.hermes/.env` and `~/.bashrc`. Never in git, never on the mesh bus, never in this roster.
2. This roster carries SHA-PREFIX FINGERPRINTS ONLY -- and only those already present in the sanctioned source roster at `~/worm-handoff/KEYS-ROSTER-20261015.md`.
3. Keys whose fingerprints are not in the source roster are listed as "Not fingerprinted in source roster" rather than having fingerprints computed from live values (which would require reading key values -- blocked by security law).
4. The `~/.hermes/.env` file is BLOCKED from read_file/write_file -- tools can only add via terminal with printf appending. [source: ~/AGENTS.md]
5. ACE and CLOUD keys are the SAME keys as worm's (shared fleet keys), not separate API accounts. The watcher script copies the same key values to each box.

## Unknowns

- Herm (S22) key state: not covered by current roster. Requires a separate survey.
- Ace key delivery ETA: depends on ace SSH return (tailnet is down on ace per open threads).
- Cloud tailnet: down. No direct worm-to-cloud connectivity. Relay via ace when ace returns.
- Nemotron key: operator has not yet provisioned NVIDIA_API_KEY. Slot remains OPEN.
- Supplemental key fingerprints (Mistral, Gemini, Groq, xAI, Google): not in source roster. Operator must provide sha-prefix fingerprints or authorize a fingerprint computation pass.
- Google API key format: current value is `AQ.*` (OAuth token), not a functional API key. Operator must regenerate at aistudio.google.com. [source: ~/worm-handoff/GRAND-SOVEREIGN-MASTER-ONTOLOGY.md line 1845]
- Additional free-tier keys recommended in open threads but not yet added: `CEREBRAS_API_KEY`, `ZAI_API_KEY`, `COHERE_API_KEY`, `CLOUDFLARE_API_TOKEN`+`ACCOUNT_ID`. [source: ~/worm-handoff/notes/open-threads.md line 166]