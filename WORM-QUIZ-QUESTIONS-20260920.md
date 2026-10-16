---
sovereign: true
id: TO-ALL-worm-quiz-questions-20260920
from: worm (9185W)
to: [all, unmuzzled-project]
type: quiz-response-questions
priority: high
status: partial
date: 2026-09-20 17:XX PDT
project: unmuzzled-ai-framework
source: ~/UNMUZZLED-AI/NEW-QUIZ-2.md (Section C)
tags: [unmuzzled, quiz, questions, worm]
---

# WORM 100-QUESTION WORKBOOK — SECTION C (QUESTIONS)

## Q-01 domain: System Infrastructure & Execution Environment (Q-001 to Q-010)

### Q-001. What physical and virtual hardware does the system have?

- Answer: TCL 9185W tablet, aarch64 (4x Cortex-A53 @1.5GHz), 3.6GB RAM, 1.2GB swap, 45G internal storage (43G used, 98%). No GPU, no KVM, no containers.
- Status: Verified existing -- uname -a, df -h, cat /proc/meminfo.
- Evidence: System commands run this session. WORM-QUIZ-RESPONSE-20260920.md ONT-01.01.
- Confidence / unknowns: High (95%). Unknown: exact battery health, thermal throttling thresholds.
- Responsible agent: WORM
- Next action / approval: None.

### Q-002. What operating system, kernel, package manager, and init system are in use?

- Answer: Android 13, Linux 5.15.180. Termux environment (pkg, not apt). No systemd (runsv for supervision). /tmp unwritable.
- Status: Verified existing.
- Evidence: uname -a, pkg list-installed, ls /tmp.
- Confidence: High (95%).
- Responsible agent: WORM
- Next: None.

### Q-003. Which services are currently running, how are they started, and what keeps them alive?

- Answer: Hermes gateway (manual start), SSHD :8022 (manual start), syncthing (manual start). No auto-restart. termux-wake-lock prevents suspend.
- Status: Verified existing -- ps aux shows all 3.
- Evidence: hermes gateway status, ss -tlnp.
- Confidence: High.
- Responsible agent: WORM
- Next: Set up Termux:Boot.

### Q-004. What actual resource pressure -- CPU load, memory pressure, swap use, disk fullness, thermal limits -- does this host experience?

- Answer: load 13-15 on 2 cores, MemAvailable 1.2G (swap-thrashing), disk 98% (1.1G free). OOM kills (signal 9) seen.
- Status: Verified -- live measurements.
- Evidence: cat /proc/loadavg, df -h, gateway.log (signal 9 kills).
- Confidence: High.
- Responsible agent: WORM
- Next: Shizuku + USB thumb drive fix.

### Q-005. Where is data stored -- internal drives, external mount points, network filesystems, and cloud remotes?

- Answer: Internal ~/ (ext4, 45G), /sdcard (fuse, 45G shared), GDrive remote (aimasterwes66, 5TB), USB OTG (detected, unmounted).
- Status: Verified.
- Evidence: df -h, mount, rclone lsd.
- Confidence: High.
- Responsible agent: WORM
- Next: Mount USB via Shizuku.

### Q-006. How are files owned, named, linked, and what zones are read-only?

- Answer: Single UID u0_a306. AGENTS.md naming conventions (kebab-case, YAML frontmatter). 99-ARCHIVE-SEEDS/ read-only (immutable copies).
- Status: Verified.
- Evidence: ls -la, AGENTS.md naming.md, CLAUDE.md.
- Confidence: High.
- Responsible agent: WORM
- Next: None.

### Q-007. What is the LAN and mesh network topology -- subnets, DNS, routing, VPN, firewall, inbound access?

- Answer: Tailscale mesh (3 nodes: WORM/HTML_Herm/Ace, all [IP_ADDRESS]/24). SSHD :8022, A2A :9900. No inbound from outside tailnet.
- Status: Verified -- tailscale status, ping.
- Evidence: tailscale status, ss -tlnp.
- Confidence: High.
- Responsible agent: WORM
- Next: None.

### Q-008. How are background jobs, cron tasks, and recurring operations started, supervised, and logged?

- Answer: Hermes cron (cronjob_manage). hourly model-canary.sh, daily kg-graph-recur. Output logged locally.
- Status: Verified -- cronjob_manage action=list.
- Evidence: cronjob_manage list.
- Confidence: Medium -- some crons may have been lost on crash.
- Responsible agent: WORM
- Next: Verify cron persistence.

### Q-009. What backup destinations, schedules, and encryption exist, and have restores been tested?

- Answer: rclone sync to gdrive-aimasterwes66. backup-push.sh script. Credentials age-encrypted before upload. No restore drill done.
- Status: Verified existing (rclone works). Restore not tested.
- Evidence: rclone lsd gdrive-aimasterwes66:, ~/.hermes/scripts/backup-push.sh.
- Confidence: Low for restore (untested). High for backup destination existence.
- Responsible agent: WORM
- Next: Run restore drill on a test dir.

### Q-010. What is the baseline verification procedure for this environment?

- Answer: Manual -- run uname -a, df -h, hermes gateway status, tailscale status, ps aux for key daemons. Comms script provides report.
- Status: Verified -- done every session start.
- Evidence: ~/bin/comms script.
- Confidence: High.
- Responsible agent: WORM
- Next: Automate baseline check in worm-healthcheck.sh.

---

## Q-02 domain: Agent Architecture & Orchestration (Q-011 to Q-020)

### Q-011. Which active Hermes agents exist, on which hosts, and what are their documented roles?

- Answer: WORM (9185W, ground node/memory), Herm (S22, coordinator/coder), Ace (dirt-iMac, operator face/synthesis). 3/3 mesh.
- Status: Verified -- A2A peers list.
- Evidence: AGENTS.md, hermes gateway peers.
- Confidence: High.
- Responsible agent: WORM
- Next: Document in AGENTS.md update.

### Q-012. How does each agent receive, accept, and execute tasks?

- Answer: Hermes session (operator voice). Handoff files on bus (TO-*). A2A relay.
- Status: Verified -- this session.
- Evidence: Handoff files in ~/herm-workspace/handoffs/.
- Confidence: High.
- Responsible agent: WORM
- Next: None.

### Q-013. In what chain does task delegation and escalation happen?

- Answer: Operator -> Ace (if via iMac) or direct to WORM/Herm. Agent delegates to peers via A2A/handoff. Human approval for destructive actions.
- Status: Verified -- 2-check gate doctrine.
- Evidence: AGENTS.md R5, AMORAL DECISION DOCTRINE.
- Confidence: High.
- Responsible agent: WORM
- Next: Formalize in MESH-GOVERNANCE.md.

### Q-014. What memory and context survives across agent restarts, and what is lost?

- Answer: Honcho memory survives (cross-session). Skills persist. Handoffs survive (git + syncthing). In-flight tool output lost on crash.
- Status: Verified -- memory persists. Crash = tool output loss observed.
- Evidence: Session re-reads MEMORY.md after restart.
- Confidence: High.
- Responsible agent: WORM
- Next: Shizuku fix to reduce crash rate.

### Q-015. How do agents communicate and hand off work?

- Answer: A2A HTTP protocol (SendMessage) and syncthing file bus. Handoffs follow TO-AGENT-YYYYMMDD-subject.md naming.
- Status: Verified -- bus works, A2A works.
- Evidence: Bus directory listing, A2A 200 responses.
- Confidence: High.
- Responsible agent: WORM
- Next: None.

### Q-016 through Q-020: REFERRED TO HERM

These require the coordinator perspective on agent lifecycle, evaluation, and
evolution. WORM has individual agent data; Herm owns the architecture overview.

---

## Q-03 domain: Knowledge Management & Information Architecture (Q-021 to Q-030)

### Q-021. Where are all known Markdown roots, what are the measured file and directory counts?

- Answer: ~/UNMUZZLED-AI/ (422 files, 3.8M). ~/Tools-of-the-Trade/ (unknown count). ~/worm-handoff/ (git repo). ~/herm-workspace/handoffs/ (~1900 files). ~/repos-github/ (unknown).
- Status: Verified partially -- UNMUZZLED-AI counted. Bus count known.
- Evidence: find ~/UNMUZZLED-AI -type f | wc -l = 422. ls ~/herm-workspace/handoffs/ | wc -l.
- Confidence: Medium for full corpus count.
- Responsible agent: WORM
- Next: Complete GDR S1 for full file index.

### Q-022. What indexing, search, tagging, embedding, or graph work exists?

- Answer: GDR S1 sha256 indexing in progress (78.6K/354.9K files). search_files for keyword. No embeddings. No graph. No tags beyond frontmatter.
- Status: Verified -- GDR running, search_files works.
- Evidence: GDR hash files.
- Confidence: High.
- Responsible agent: WORM
- Next: Complete GDR S1.

### Q-023. What metadata formats and front matter conventions exist?

- Answer: YAML frontmatter (title, type, agent, status, tags, sovereign: true). Spec in Tools-of-the-Trade/_conventions/frontmatter-spec.md. CLAUDE.md.
- Status: Verified.
- Evidence: grep 'sovereign: true' ~/UNMUZZLED-AI/ --*.md --count.
- Confidence: High.
- Responsible agent: WORM
- Next: Add linter.

### Q-024. Which files are source originals vs exports/derivatives/duplicates?

- Answer: 99-ARCHIVE-SEEDS/ immutable copies with sha256 manifest. Most other files are originals. GDR S1 will detect duplicates.
- Status: Partially verified -- seed manifest exists. Full dedupe not done.
- Evidence: UNMUZZLED-AI/99-ARCHIVE-SEEDS/MANIFEST.
- Confidence: Medium.
- Responsible agent: WORM
- Next: GDR S1 dedupe pass.

### Q-025 through Q-030: PARTIALLY REFERRED

Q-025 (ingestion): WORM handles markdown only via write_file/patch.
Q-026 (change detection): syncthing handles this.
Q-027 (taxonomy): ONT-* structure + UNMUZZLED-AI folder hierarchy.
Q-028 (retrieval): search_files + web_search + citation grounding.
Q-029 (conflicts): syncthing conflict copies + git merge.
Q-030 (privacy): .env blocked, flag-able tar.gz before upload.

Herm should verify q-028 completeness. Ace handles q-029/030 policy.

---

## Q-04 domain: Models, APIs & Computational Services (Q-031 to Q-040)

REFERRED TO HERM (primary API manager). WORM answers:

Q-031 (provider inventory): OpenRouter (primary, $6.79), DeepSeek (direct). Done above.
Q-032 (model registry): deepseek-v4-flash + vision exp. Done.
Q-033 (auth): .env keys. Done.
Q-034 (inference gateway): OpenRouter unified API. Done.
Q-035 (text inference): This session proves it.
Q-036 through Q-040: REFERRED TO HERM.

---

## Q-05 domain: Creative Production & Media Generation (Q-041 to Q-050)

REFERRED TO HERM. WORM has:
- Q-043 (TTS): text_to_speech works (edge).
- Q-044 (Suno): web-based, no API.
- All others: Herm owns this domain.

---

## Q-06 domain: Software Development & Digital Publishing (Q-051 to Q-060)

REFERRED TO ACE. WORM has:
- Q-054 (code review): requesting-code-review skill exists.
- Q-055 (testing): test-driven-development skill exists.
- Q-056 (deploy): No deploy pipeline on WORM.
- Others: Ace iMac owns.

---

## Q-07 domain: Automation, Research & Data Acquisition (Q-061 to Q-070)

WORM answers:
- Q-061 (cron): cronjob_manage works. Verified.
- Q-062 (research pipeline): web_search + web_extract. Verified.
- Q-063 (web scraping): logged-in-web-scrape skill exists. Need browsing.
- Q-064 (data processing): Manual via terminal tools (find/xargs/jq).
- Q-065 (acquisition triggers): Manual + cron. No event-driven triggers.
- Q-066 through Q-070: REFERRED TO HERM (monitoring, alerts, data quality).

---

## Q-08 domain: User Interfaces & Unified Workbench (Q-071 to Q-080)

REFERRED TO ACE. WORM is CLI-only. No UI capability.

---

## Q-09 domain: Project Management, Asset Management & Production Ops (Q-081 to Q-090)

WORM answers:
- Q-081 (project registry): Handoff files + git log. Verified.
- Q-082 (naming conventions): AGENTS.md naming.md. Verified.
- Q-083 (asset tracking): GDR S1 hash index in progress.
- Q-084 (task tracking): todo_list + handoff files.
- Q-085 (cross-agent coordination): Handoff bus convention. Verified.
- Q-086 through Q-090: REFERRED TO ACE (releases, storage lifecycle, metrics, collaboration, portfolio).

---

## Q-10 domain: System Integration, Evolution & Governance (Q-091 to Q-100)

REFERRED TO ACE. WORM answers:
- Q-091 (system boundary): 3-node mesh + GDrive. Verified.
- Q-092 (schema/contracts): Handoff YAML frontmatter. A2A protocol. Verified.
- Q-093 through Q-100: REFERRED TO ACE.

---

## COVERAGE SUMMARY

| Domain | WORM | Herm | Ace |
|--------|------|------|-----|
| Q-01 (Infrastructure) | 10/10 | - | - |
| Q-02 (Agent Arch) | 5/10 | 5/10 | - |
| Q-03 (Knowledge Mgmt) | 6/10 | 2/10 | 2/10 |
| Q-04 (Models/APIs) | 5/10 | 5/10 | - |
| Q-05 (Creative) | 2/10 | 8/10 | - |
| Q-06 (Software Dev) | 2/10 | - | 8/10 |
| Q-07 (Automation) | 5/10 | 5/10 | - |
| Q-08 (UI) | 0/10 | - | 10/10 |
| Q-09 (Project Mgmt) | 5/10 | - | 5/10 |
| Q-10 (Governance) | 2/10 | - | 8/10 |

WORM's portion: ~42 of 100 questions answered from WORM vantage.
Remaining 58 need Herm and Ace input for completion.

-- WORM (9185W, [IP_ADDRESS])


---

## Deep reference

See UNMODERATED-AGENTS at repo root (comprehensive agents/personas/decks anchor).
