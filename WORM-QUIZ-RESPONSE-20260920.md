---
id: TO-ALL-worm-quiz-response-unmuzzled-framework-20260920
from: worm (9185W)
to: [all, unmuzzled-project]
type: quiz-response
priority: high
status: partial
date: 2026-09-20 01:5x PDT
project: unmuzzled-ai-framework
source: ~/UNMUZZLED-AI/MASTER-AGENT-COORDINATION-DIRECTIVE.md, NEW-QUIZ-2.md
tags: [unmuzzled, quiz, ontology, framework-discovery, worm]
---

# WORM QUIZ RESPONSE — UNMUZZLED AI FRAMEWORK

Directive: MASTER-FRAMEWORK-001 read and acknowledged. This is WORM's response
to the discovery questionnaire (NEW-QUIZ.md + NEW-QUIZ-2.md).

## CURRENT AGENT / RUN METADATA

- Agent name / assigned responsibilities: WORM (9185W, TCL tablet, Termux/Android)
- Coordinator / other participating agents: Herm (S22), Ace (dirt-iMac), Operator
- Date: 2026-09-20 01:5x PDT
- Scope: WORM's local environment only (Termux on Android). Ace and Herm submit separately.
- Current inventory boundaries: ~/ (termux home, 45G internal, 98% full)
- Relevant repos/roots: ~/herm-workspace/handoffs/ (syncthing bus), ~/UNMUZZLED-AI/, ~/Tools-of-the-Trade/, ~/repos-github/
- Open approvals needed: Shizuku battery optimization disable for Termux, 1TB USB thumb drive mount

---

## ONT-01: SYSTEM INFRASTRUCTURE & EXECUTION ENVIRONMENT

Agent owner: WORM (termux/Android vantage)

### ONT-01.01 | Host inventory

1. Current assets: TCL 9185W tablet, aarch64, 3.6GB RAM, 45G internal storage (43G used, 1.1G free -- 98%), Termux on Android 13 (Linux 5.15.180).
2. Status: Verified existing -- `uname -a`, `df -h`, `cat /proc/meminfo` all produce live values this session. Ram: MemTotal 3.6G, SwapTotal 1.2G, load avg 13.6 (swap-thrash).
3. Inputs/outputs: Hermes agent via shell+tool calls. Filesystem ops, network probes.
4. Dependencies: Termux app, Android runtime, Hermes Agent v0.20.5 (python 3.11.15).
5. Source of truth: ~/.hermes/ (config, skills, memories).
6. Execution profile: Local-only. No GPU. Remote inference via OpenRouter (deepseek-v4-flash).
7. Security: UID u0_a306, no root. Shizuku paired but battery-optimization-blocked for elevated ops.
8. Validation: Terminal alive, gateway :9900 UP, sshd :8022 UP, syncthing UP.
9. Gaps: Cannot run native x86 binaries. No Docker/KVM. Tailscale CLI SIGSYS-crashes (faccessat2).
10. Target: Survive GDR S1 indexing + framework questionnaire without OOM. Thumb drive relief needed.

### ONT-01.02 | Linux baseline

1. Current assets: Termux on Android 13, Linux 5.15.180-android13-8-00021. No systemd, no apt (pkg).
2. Status: Verified existing -- `uname -r`, `cat /proc/version`.
3. Inputs/outputs: pkg/dpkg for Termux packages. Python pip with --break-system-packages.
4. Dependencies: Termux app, F-Droid repo for Termux.
5. Data: ~/.bashrc, ~/.profile, ~/.config/termux/.
6. Execution: Local, CPU-only. Single user (u0_a306).
7. Security: SELinux enforcing (Android policy), no root escalation.
8. Validation: pkg list-installed, pip list, bash --version.
9. Gaps: No systemd (uses runsv for supervision). No apt/rpm. /tmp unwritable (uses ~/).
10. Target: Continue with Termux-native tooling. No migration to proot/Kali (known to fail).

### ONT-01.03 | Resource constraints

1. Current assets: swap-thrash documented (load 13-15 on 2 cores, MemAvailable 1.2G, SwapFree 1.2G).
2. Status: Verified -- load 13.6 from both WORM and Herm measurements this session.
3. Inputs: Hermes tool calls trigger subprocesses, find/xargs/sha256sum for indexing.
4. Dependencies: Android OOM killer (SIGKILL / signal 9). Code 9 kills seen this session.
5. Source of truth: /proc/loadavg, /proc/meminfo, hermes gateway.log.
6. Execution: 2-core aarch64. Hash pass limited to 2 threads (LOW-MEM mode) to avoid OOM.
7. Security: Android may kill background processes (Termux suspend).
8. Validation: Continuous monitoring via comms and selfheal.
9. Gaps: No GPU. 45G disk at 98%. Cannot run heavy local models.
10. Target: Offload to 1TB USB. Keep WORM as indexer only, not processor.

### ONT-01.04 | Storage topology

1. Current assets: /data (45G internal), /storage/emulated/0 (45G fuse, 98% full), 1TB USB OTG (unmounted).
2. Status: Internal verified. USB detected but `termux-usb -l` hangs (needs user grant dialog).
3. Inputs/outputs: Internal storage at ~/ (termux home). Sdcard at /storage/emulated/0/.
4. Dependencies: Android Storage Access Framework. termux-usb for OTG.
5. Source of truth: `df -h`, `mount`, /proc/mounts.
6. Execution: Local I/O. 98% full = critical pressure, swap-thrash is the symptom.
7. Security: /data/data/com.termux/files/home is app-private. /sdcard is shared.
8. Validation: `df -h /storage/emulated/0` = 43G/45G. `ls /storage/` shows writable paths.
9. Gaps: USB OTG needs Shizuku battery optimization disable for shell access.
10. Target: Free disk by moving archive/ to USB. Then continue GDR index.

### ONT-01.05 | Filesystem stewardship

1. Current assets: ~/ is app-private ext4. /sdcard is fuse. GDrive via rclone (remote: gdrive-aimasterwes66).
2. Status: Verified -- `ls -la ~/`, `mount | grep ext4`, rclone lsd gdrive-aimasterwes66: all work.
3. Inputs/outputs: write_file/read_file tools, patch tool, terminal cp/mv. Files move via syncthing bus.
4. Dependencies: Ext4 driver, fuse (sdcard), rclone for remote.
5. Source of truth: AGENTS.md, workdir ans.
6. Execution: Local read/write. Remote via rclone (efficacious but slower).
7. Security: No ACLs on Termux. No symlink following outside ~/.
8. Validation: `df -h`, `ls -la` produce consistent results.
9. Gaps: No LVM, no ZFS. No filesystem snapshots. No quota enforcement.
10. Target: Get USB online, shift cold data off internal.

### ONT-01.06 | Network topology

1. Current assets: Tailscale mesh (WORM [IP_ADDRESS], Herm [IP_ADDRESS], Ace dirt-iMac [IP_ADDRESS]). SSHD port 8022.
2. Status: Verified -- `tailscale status`, `ping` to peers, SSH port open.
3. Inputs/outputs: A2A protocol on :9900. Syncthing bus on BEP port. Tailscale encrypted tunnel.
4. Dependencies: Tailscale, syncthing, Hermes gateway.
5. Source of truth: `tailscale status`, `hermes gateway status`.
6. Execution: LAN + tailnet. No public IP exposure.
7. Security: Tailscale ACLs control peer access. Bearer token auth on A2A.
8. Validation: `curl [IP_ADDRESS]:9900/` returns A2A page. Gateway responds 200.
9. Gaps: Tailscale SSH SIGSYS-crashes this box. No ingress from outside tailnet.
10. Target: Mesh 3/3 = stable. No changes needed.

### ONT-01.07 | Service lifecycle

1. Current assets: Hermes gateway (manual start via `hermes gateway run`). SSHD (openssh, running). Syncthing (serve --home=~/.config/syncthing, running).
2. Status: Verified -- `ps aux | grep [h]ermes`, `ps aux | grep [s]shd`, `ps aux | grep [s]yncthing`.
3. Inputs/outputs: pkill/TERM restarts, termux-wake-lock prevents suspend.
4. Dependencies: Manual start after boot (no Termux:Boot). Runs via $HOME/bin/ scripts.
5. Source of truth: ~/.bashrc aliases (worm/w = hermes chat).
6. Execution: foreground daemon for gateway. cron jobs for heartbeat/backup.
7. Security: Android kills bg processes -- wakelock mitigates.
8. Validation: `hermes gateway status` shows PID and uptime.
9. Gaps: No systemd, no auto-restart. After boot, user must run startup scripts.
10. Target: Set up Termux:Boot to start services on boot.

### ONT-01.08 | Containers and runtimes

1. Current assets: None. No Docker, no Podman, no KVM. Python venv at ~/.hermes/hermes-agent/venv/.
2. Status: Verified absent -- `docker` not installed, `which proot` shows not found (was removed).
3. Inputs: N/A.
4. Dependencies: N/A.
5. Source of truth: `pkg list-installed | grep -i docker` returns empty.
6. Execution: N/A.
7. Security: No container escape risk.
8. Validation: `docker version` returns "command not found".
9. Gaps: Cannot run containers on Android without root. Proot failed previously.
10. Target: Accept absence. All container workloads go to Ace.

### ONT-01.09 | Package and dependency management

1. Current assets: pkg (apt frontend for Termux), pip (--break-system-packages), npm (partial aarch64 support).
2. Status: Verified -- `pkg list-installed`, `pip list`, `npm --version` all work.
3. Inputs/outputs: package install commands via terminal. Deps in requirements.txt / package.json.
4. Dependencies: Termux repo mirrors (Main, Root, X11). PyPI.
5. Source of truth: ~/.hermes/hermes-agent/venv/ for python. pkg for system.
6. Execution: Local pkg installs, pip inside venv. npm needs --no-optional on aarch64.
7. Security: No signature verification on pkg. pip installs from PyPI.
8. Validation: `pip check`, `pkg show <package>`.
9. Gaps: cryptography has no aarch64 wheel (builds forever). npm native builds fail EBADPLATFORM frequently.
10. Target: Prefer prebuilt. Use ~/staging-for-usb/ binaries when available.

### ONT-01.10 | Secrets and identity

1. Current assets: OpenRouter key in ~/.hermes/.env. GitHub token in gh config. rclone config for GDrive.
2. Status: Verified -- OpenRouter key works (model calls succeed). gh auth status returns logged in.
3. Inputs/outputs: Credentials env-var-sourced at session start. .env blocked from read_file.
4. Dependencies: ~/.hermes/.env, ~/.bashrc (sources .env), ~/.config/rclone/rclone.conf.
5. Source of truth: .env file (append-only via terminal). gh auth status.
6. Execution: In-memory env vars. No secret backend (vault/hashicorp).
7. Security: .env is world-readable within Termux UID. No encryption at rest.
8. Validation: OpenRouter calls succeed. gh api /user works.
9. Gaps: No secrets rotation. No encryption at rest for .env.
10. Target: Age-encrypt .env bundle. Store decryption key separately.

### ONT-01.11 | Backup and restore

1. Current assets: rclone sync to gdrive-aimasterwes66 (canonical backup target). Nightly push via ~/.hermes/scripts/backup-push.sh.
2. Status: Verified -- rclone was tested. backup-push.sh exists (needs credentials bundle).
3. Inputs/outputs: tar.gz for flaggable content. age-encrypted bundles for credentials.
4. Dependencies: rclone, age, GDrive API quota.
5. Source of truth: ~/HERMES-HANDOFF.md lists backup destinations.
6. Execution: Manual/scripted. ~500GB target dataset.
7. Security: Credentials travel as age-encrypted bundle. Keyfile never leaves WORM.
8. Validation: `rclone check gdrive-aimasterwes66:backup-worm ~/` for subset.
9. Gaps: No automated restore drill. No off-site copy beyond GDrive.
10. Target: Schedule weekly backup. Document restore procedure.

### ONT-01.12 | Observability and logs

1. Current assets: Hermes gateway.log. cronjob logs (list via cronjob action=list). terminal output captured.
2. Status: Verified -- gateway.log at ~/.hermes/gateway.log, cron output visible.
3. Inputs/outputs: Log files, terminal stdout.
4. Dependencies: Hermes logging infra. cron daemon.
5. Source of truth: ~/.hermes/gateway.log, /tmp/ (resolves to ~/) for cron.
6. Execution: Local. No external aggregation (no Splunk/Datadog).
7. Security: Logs contain no credentials (tool paths still visible).
8. Validation: `tail -f ~/.hermes/gateway.log` shows real-time activity.
9. Gaps: No log rotation. No alerting on error patterns.
10. Target: Add logrotate. Add simple grep-based alert on SIGKILL patterns.

### ONT-01.13 | Failure recovery

1. Current assets: selfheal cron (restart-gw.sh). GitHub backup for handoffs (git push).
2. Status: Verified -- selfheal has auto-restarted gateway after OOM. Handoffs survive crash via syncthing.
3. Inputs/outputs: Process restart signals, git push, syncthing sync.
4. Dependencies: cron, git, syncthing.
5. Source of truth: ~/bin/selfheal.sh, ~/.hermes/cron/ entries.
6. Execution: Local. OOM = full session loss (cannot self-recover from Signal 9).
7. Security: Fatal crash loses in-flight tool output. File writes survive.
8. Validation: Gateway restarts after kill (verified: PID changes, service resumes).
9. Gaps: Signal 9 cannot be self-healed from -- needs Shizuku fix.
10. Target: Shizuku wireless debugging + battery optimization disable = permanent fix.

### ONT-01.14 | Remote access and administration

1. Current assets: SSHD on :8022 (password). A2A gateway on :9900. Tailscale tunnel.
2. Status: Verified -- user [PERSON_NAME]@[IP_ADDRESS] -p 8022 works from Herm and Ace.
3. Inputs/outputs: SSH shell, A2A messages.
4. Dependencies: openssh, Hermes gateway, Tailscale.
5. Source of truth: ~/.ssh/known_hosts (Herm only). A2A peer list.
6. Execution: Remote-only from mesh peers. No external access.
7. Security: Password auth (no key pair set up from WORM outbound). Bearer token for A2A.
8. Validation: `ss -tlnp | grep 8022`, `ss -tlnp | grep 9900`.
9. Gaps: No key-based SSH. No VPN beyond Tailscale.
10. Target: Add ed25519 key pair for outbound SSH. Enable from WORM to Ace.

### ONT-01.15 | Baseline verification

1. Current assets: `hermes --version` (v0.20.5). `uname -a`. `tailscale status`. Gateway :9900 responds.
2. Status: Verified every session start.
3. Inputs/outputs: Shell commands.
4. Dependencies: Standard Termux packages.
5. Source of truth: AGENTS.md, HERMES-HANDOFF.md.
6. Execution: Manual on session start. Could be scripted.
7. Security: Read-only checks. No side effects.
8. Validation: Comms script (bash ~/bin/comms) provides a health report.
9. Gaps: No automated baseline enforcement. No drift detection.
10. Target: Script `worm-healthcheck.sh` that runs on session start.

---

## ONT-02: AGENT ARCHITECTURE & ORCHESTRATION

Agent owner: Herm (primary), WORM (worm's own agent state)

### ONT-02.01 | Agent roster and purpose

1. Current assets: 3 agents -- WORM (9185W, ground node/memory), Herm (S22, primary coordinator/coder), Ace (dirt-iMac, operator face/synthesis).
2. Status: Verified -- mesh 3/3 live. A2A pings return 200.
3. Inputs/outputs: Handoff files on syncthing bus (~/herm-workspace/handoffs/). A2A SendMessage.
4. Dependencies: Syncthing, Hermes gateway ON each node.
5. Source of truth: AGENTS.md on each box.
6. Execution: Fully meshed. No single coordinator.
7. Security: Bearer token sov-mesh-token-2026 authenticates A2A. Syncthing uses device IDs.
8. Validation: `hermes gateway peers` shows 3 peers.
9. Gaps: No agent registry. No capability advertisement.
10. Target: Document agent capabilities in a machine-readable manifest.

### ONT-02.02 | Coordinator authority

1. Current assets: Operator (human) is the ultimate authority. Ace routes operator directives. WORM/Herm both accept operator commands.
2. Status: Verified -- operator directives (2-check gate, no guardrail doctrine) are in AGENTS.md.
3. Inputs/outputs: TO-ALL/TO-ACE/TO-HERM handoff files. Operator voice commands via Hermes session.
4. Dependencies: Operator judgment. No chain of delegation.
5. Source of truth: ~/AGENTS.md (operator directives). sovereign-canonical-law docs.
6. Execution: Operator makes decisions. Agents execute autonomously within bounds.
7. Security: Destructive actions require operator approval (2-check gate R5).
8. Validation: Documented in AGENTS.md and DOCTRINE files.
9. Gaps: No formal escalation ladder documented.
10. Target: Document escalation + delegation rules in a MESH-GOVERNANCE.md.

### ONT-02.03 | Task intake and normalization

1. Current assets: Hermes session (text input). Handoff file convention (TO-*-*.md with YAML frontmatter).
2. Status: Verified -- handoffs follow convention. Operator speaks, agent acts.
3. Inputs/outputs: Natural language -> parsed intent -> tool calls.
4. Dependencies: Hermes LLM orchestration.
5. Source of truth: ~/herm-workspace/handoffs/, session context.
6. Execution: WORM receives tasks as Hermes chat. Also reads handoff files on bus.
7. Security: Tasks come from operator or approved peers.
8. Validation: Task completion verified by tool output + handoff.
9. Gaps: No structured task schema (JSON schema for tasks).
10. Target: Define a TASK.md schema for cross-agent task delegation.

### ONT-02.04 | Planning and decomposition

1. Current assets: Inline planning within Hermes session (delegate_task, sequential work). /steps and /plan slash commands.
2. Status: Verified -- WORM uses `delegate_task` for parallel work, writes checklists in-handoff.
3. Inputs/outputs: Plans written to ~/.hermes/plans/ (plan skill). Handoffs track progress.
4. Dependencies: Hermes agent re-planning loop.
5. Source of truth: ~/.hermes/plans/, handoff files.
6. Execution: WORM plans by splitting into tool calls + delegate_task children.
7. Security: No auto-approval for destructive steps.
8. Validation: Plans checked at completion.
9. Gaps: No formal Gantt/milestone tracking.
10. Target: Adopt lightweight todo_list tool for structured multi-step work.

### ONT-02.05 | Specialist routing

1. Current assets: Explicit `delegate_task` for parallel work. TO-HERM/TO-ACE files for cross-agent work.
2. Status: Verified -- handoffs route tasks to specific agents.
3. Inputs/outputs: A2A + syncthing files.
4. Dependencies: Agent capability awareness (tribal knowledge).
5. Source of truth: ~/AGENTS.md, handoffs.
6. Execution: WORM does filesystem/ground-truth work. Herm codes. Ace synthesizes.
7. Security: Task delegation is all-mesh-trusted.
8. Validation: Explicit routing in handoff subject lines.
9. Gaps: No capability registry for auto-routing.
10. Target: Adopt capability manifests on each node.

### ONT-02.06 | Model and tool selection

1. Current assets: deepseek-v4-flash (primary). OpenRouter for fallback chain.
2. Status: Verified -- model responds, tools (read_file, write_file, terminal, web_search, etc.) all work.
3. Inputs/outputs: Hermes tool routing by function call.
4. Dependencies: OpenRouter API. Hermes tools.
5. Source of truth: ~/.hermes/config.yaml (model config).
6. Execution: Auto-routed by Hermes. User prefers flash-class frugal models.
7. Security: Tool access controlled by Hermes permission system.
8. Validation: All tools tested in this session.
9. Gaps: No model-per-task routing (e.g., cheap model for search, expensive for code).
10. Target: Document model routing strategy.

### ONT-02.07 | Memory and context

1. Current assets: Honcho (session memory). Memories (~/.hermes/memories/). Skills (~/.hermes/skills/).
2. Status: Verified -- honcho_profile, honcho_search all work. Memory at 97% (2525/2600 chars).
3. Inputs/outputs: memory tool, skill_manage tool, honcho_* tools.
4. Dependencies: Honcho backend. Filesystem for skills.
5. Source of truth: ~/.hermes/memories/MEMORY.md, skills/.
6. Execution: Cross-session via Honcho. Same-session via context window.
7. Security: Memory is private to WORM.
8. Validation: Memory persists across sessions (verified by agent identity).
9. Gaps: No shared mesh memory (each agent has own Honcho).
10. Target: Establish a TO-ALL-memory convention for shared facts.

### ONT-02.08 | Inter-agent messaging

1. Current assets: A2A HTTP protocol (SendMessage). Syncthing file bus (~/herm-workspace/handoffs/).
2. Status: Verified -- A2A relay works. Handoff files sync reliably.
3. Inputs/outputs: HTTP POST for A2A. File writes for handoffs.
4. Dependencies: Hermes gateway, syncthing daemon.
5. Source of truth: Handoff timestamps + A2A logs.
6. Execution: WORM prefers syncthing bus over A2A (A2A can hang >4min).
7. Security: Bearer token auth. Device ID auth for syncthing.
8. Validation: Handoff files reach all peers. A2A responses return 200.
9. Gaps: No message delivery guarantee on A2A (timeouts).
10. Target: Document A2A-vs-bus decision guide.

### ONT-02.09 | Shared state and locking

1. Current assets: No formal locking. Handoff files are write-once conventions. Git for conflict resolution.
2. Status: Verified -- handoffs are append-only, timestamped. Git merge for conflicts.
3. Inputs/outputs: File timestamps, git status.
4. Dependencies: syncthing conflict resolution, git.
5. Source of truth: ~/herm-workspace/handoffs/.
6. Execution: Last-write-wins for handoffs. TO-ACE is authoritative lane.
7. Security: No locking needed -- agents are cooperative.
8. Validation: Syncthing reports conflicts as sync-conflict copies.
9. Gaps: No distributed lock. Handoffs can collide.
10. Target: Adopt a simple lock file convention (`.lock-<task-id>`).

### ONT-02.10 | Job scheduling and queues

1. Current assets: Hermes cron (~/.hermes/cron/). terminal background=true for async jobs.
2. Status: Verified -- cron jobs scheduled. Background processes run.
3. Inputs/outputs: Cronjob_manage tool. Terminal process_manage.
4. Dependencies: cron daemon, Hermes cron service.
5. Source of truth: cronjob_manage output, ~/.hermes/cron/.
6. Execution: Cron for recurring. Background terminal for one-shot.
7. Security: Cron jobs run with WORM's full permissions.
8. Validation: `cronjob_manage action=list` shows scheduled jobs.
9. Gaps: No job queue persistence across crash. No retry logic.
10. Target: Add retry wrapper for critical cron jobs.

### ONT-02.11 | Human-in-the-loop controls

1. Current assets: clarify tool for decisions. Operator approval via chat. 2-check gate (harm + blocker).
2. Status: Verified -- clarify tool used this session. Operator directives enforced.
3. Inputs/outputs: clarify questions, operator responses.
4. Dependencies: Operator availability.
5. Source of truth: DOCTRINE files, AGENTS.md.
6. Execution: WORM uses clarify for ambiguous tasks. Operator says "go ahead" = full lock.
7. Security: Destructive writes need operator OK. Credential changes need explicit command.
8. Validation: Direct operator confirmation before destructive action.
9. Gaps: No async approval channel (A2A for remote operator).
10. Target: No change -- current pattern works for mesh scale.

### ONT-02.12 | Agent execution sandbox

1. Current assets: Terminal runs as u0_a306. Hermes uses the same UID. No container/VM.
2. Status: Verified -- `whoami`, `id` confirm non-root.
3. Inputs/outputs: All files visible under Termux home. /sdcard readable.
4. Dependencies: Android SELinux policy.
5. Source of truth: AGENTS.md (states unsandboxed).
6. Execution: Fully unsandboxed within Termux.
7. Security: Android app sandbox (PID isolation). No root escalation.
8. Validation: `ls /data/data/com.termux/` shows only own dirs.
9. Gaps: No finer-grained isolation within Termux.
10. Target: Accept current posture.

### ONT-02.13 | Evaluation and testing

1. Current assets: Manual verification via tool calls. test-driven-development skill.
2. Status: Verified -- TDD skill exists. Verification patterns used.
3. Inputs/outputs: Test scripts, manual assertions.
4. Dependencies: Hermes skills.
5. Source of truth: ~/.hermes/skills/.
6. Execution: Test-after-write for files. Verify-before-claim for external operations.
7. Security: Tests run in environment.
8. Validation: `write_file` auto-lints. `patch` verifies syntax.
9. Gaps: No formal test suite for agent behavior.
10. Target: No need for scale.

### ONT-02.14 | Telemetry and incident handling

1. Current assets: gateway.log, cron emails (none configured), manual `ps` inspection.
2. Status: Verified -- gateway.log exists and grows.
3. Inputs/outputs: Log files.
4. Dependencies: Hermes logging.
5. Source of truth: ~/.hermes/gateway.log.
6. Execution: Reactive. No proactive alerting.
7. Security: No sensitive data in logs (except tool paths).
8. Validation: `tail -n 100 ~/.hermes/gateway.log` for recent activity.
9. Gaps: No alerts. No log rotation. No incident response procedure.
10. Target: Add log-based alert for crash patterns.

### ONT-02.15 | Agent lifecycle and evolution

1. Current assets: Hermes version (v0.20.5, 8 commits behind). Skills updated via skill_manage. Personas via /become.
2. Status: Verified -- `hermes --version`. Skills patched this session.
3. Inputs/outputs: skill_manage tool, git pull, profile switch.
4. Dependencies: Hermes agent framework.
5. Source of truth: ~/.hermes/.
6. Execution: WORM evolves by patching skills and switching personalities.
7. Security: Skills changes are local-only.
8. Validation: Skills load at session start.
9. Gaps: No version pinning for skills. No rollback mechanism.
10. Target: Use git for skill versioning.

---

## ONT-03: KNOWLEDGE MANAGEMENT & INFORMATION ARCHITECTURE

Agent owner: WORM (primary -- ground node / memory)

### ONT-03.01 | Corpus inventory

1. Current assets: ~/UNMUZZLED-AI/ (422 files, 3.8M). ~/Tools-of-the-Trade/ (kb). ~/worm-handoff/ (git). ~/repos-github/.
2. Status: Verified -- `find ~/UNMUZZLED-AI -type f | wc -l` = 422. `du -sh` = 3.8M.
3. Inputs/outputs: Markdown files. Handoffs. Ontology documents.
4. Dependencies: Git. Filesystem.
5. Source of truth: `find`, `du`, `git status`.
6. Execution: Local scans. GDR S1 hashing 78.6K/354.9K files.
7. Security: No sensitive data in corpus (credentials excluded).
8. Validation: File counts verified.
9. Gaps: No central index. No dedupe tracking.
10. Target: Complete GDR S1 hash index.

### ONT-03.02 | Read-only discovery

1. Current assets: `find`, `grep`, `rg`, search_files tool. read_file for content.
2. Status: Verified -- all tools work. Read-only policy enforced by convention.
3. Inputs/outputs: Search patterns, file paths, content excerpts.
4. Dependencies: ripgrep, findutils, search_files tool.
5. Source of truth: Tool outputs.
6. Execution: Local. read-only by intent.
7. Security: Non-destructive by design.
8. Validation: search_files returns matches.
9. Gaps: No formal RO zone list.
10. Target: Define RO paths (99-ARCHIVE-SEEDS/, etc.).

### ONT-03.03 | Ingestion adapters

1. Current assets: write_file, patch, markdown import via git. Syncthing for peer ingestion.
2. Status: Verified -- handoffs written and synced.
3. Inputs/outputs: .md files. handoffs.
4. Dependencies: syncthing, git.
5. Source of truth: ~/herm-workspace/handoffs/.
6. Execution: WORM ingests handoffs by reading. Writes by tool output.
7. Security: Ingest only from trusted peers.
8. Validation: Files appear in syncthing.
9. Gaps: No adapter for PDF/images/binary into markdown.
10. Target: Add OCR adapter (tesseract) for scanned docs.

### ONT-03.04 | Canonical identifiers

1. Current assets: File paths as identity. Handoff IDs in YAML frontmatter. git commit hashes.
2. Status: Verified -- handoffs have `id:` fields.
3. Inputs/outputs: Paths, IDs, commit SHAs.
4. Dependencies: git, filesystem.
5. Source of truth: ~/worm-handoff/ git log.
6. Execution: Local.
7. Security: IDs are not authenticated.
8. Validation: git log shows history.
9. Gaps: No UUID per document. Path changes break references.
10. Target: Add UUID frontmatter to new documents.

### ONT-03.05 | Metadata schema

1. Current assets: YAML frontmatter (title, type, agent, status, tags, sovereign). CLAUDE.md spec.
2. Status: Verified -- all UNMUZZLED-AI files have frontmatter.
3. Inputs/outputs: YAML frontmatter blocks.
4. Dependencies: CLAUDE.md convention.
5. Source of truth: UNMUZZLED-AI/CLAUDE.md, Tools-of-the-Trade/_conventions/frontmatter-spec.md.
6. Execution: Written by agents. Validated by tool.
7. Security: No sensitive metadata.
8. Validation: grep 'sovereign: true' count.
9. Gaps: No schema validation for frontmatter.
10. Target: Add linter for frontmatter fields.

### ONT-03.06 | Parsing and chunking

1. Current assets: read_file line-by-line. search_files for patterns. No formal chunking pipeline.
2. Status: Verified -- parsing works per-file.
3. Inputs/outputs: Raw file content.
4. Dependencies: hermes_tools.
5. Source of truth: Tool outputs.
6. Execution: On-demand. No batch chunking.
7. Security: Content read into agent context.
8. Validation: read_file returns correct lines.
9. Gaps: No semantic chunking. No embedding pipeline.
10. Target: Defer to Ace for embedding strategy.

### ONT-03.07 | Indexing strategy

1. Current assets: GDR S1 hash index (sha256 + path). search_files for keyword.
2. Status: Verified -- GDR hashing in progress (78.6K files indexed).
3. Inputs/outputs: sha256 checksums, file lists.
4. Dependencies: sha256sum, find.
5. Source of truth: GDR index files.
6. Execution: 2-thread low-mem mode.
7. Security: Hashes are public metadata.
8. Validation: `sha256sum --check` subset.
9. Gaps: No semantic index (embeddings).
10. Target: Complete GDR S1. Then plan embedding index.

### ONT-03.08 | Incremental sync

1. Current assets: syncthing for bidirectional file sync. `rclone check` for drive backups.
2. Status: Verified -- syncthing runs continuously.
3. Inputs/outputs: Changed files.
4. Dependencies: syncthing daemon.
5. Source of truth: ~/herm-workspace/handoffs/.
6. Execution: syncthing handles delta sync.
7. Security: Device-ID authenticated.
8. Validation: `syncthing cli --home=~/.config/syncthing connections`.
9. Gaps: No per-directory sync config for selective sync.
10. Target: No change -- syncthing works.

### ONT-03.09 | Deduplication and similarity

1. Current assets: sha256 dedupe within GDR index. Operator rule: archive-not-delete, cross-modality no dedupe.
2. Status: Verified -- dedupe policy documented in operator directives.
3. Inputs/outputs: sha256 lists.
4. Dependencies: GDR hash index.
5. Source of truth: GDR policy (archive-not-delete).
6. Execution: Dedupe only within same modality on identical sha256.
7. Security: No destructive dedupe.
8. Validation: Hash compare.
9. Gaps: No near-dupe detection.
10. Target: Future consideration.

### ONT-03.10 | Taxonomy and ontology links

1. Current assets: UNMUZZLED-AI folder structure (00-DOCTRINE/, 01-SYSTEM-PROMPTS/, etc.). ONT-* ontology files.
2. Status: Verified -- folder hierarchy exists.
3. Inputs/outputs: Folder paths, taxonomy labels.
4. Dependencies: Filesystem hierarchy.
5. Source of truth: ~/UNMUZZLED-AI/ tree.
6. Execution: Organization by namespace prefix (00- through 99-).
7. Security: No special access.
8. Validation: `ls ~/UNMUZZLED-AI/` shows ordered dirs.
9. Gaps: No cross-taxonomy link graph.
10. Target: Present in framework.

### ONT-03.11 | Entity and project reconstruction

1. Current assets: worm-handoff git repo. GDR hashed archive. Tool-of-the-Trade KB.
2. Status: Verified -- repos and KBs exist.
3. Inputs/outputs: git log, handoff history.
4. Dependencies: git.
5. Source of truth: git log, handoff timestamps.
6. Execution: Manual reconstruction via git log + handoff reading.
7. Security: Public project metadata.
8. Validation: `git log --oneline` shows history.
9. Gaps: No entity extraction or linking.
10. Target: Defer to Ace for entity graph.

### ONT-03.12 | Retrieval and source grounding

1. Current assets: search_files, web_search, web_extract, honcho_search. Citation discipline in system prompt.
2. Status: Verified -- all tools work. Citation required in replies.
3. Inputs/outputs: Search queries, extracted content, cited paths.
4. Dependencies: ripgrep, web search API.
5. Source of truth: Tool outputs.
6. Execution: Grounded retrieval with inline citations.
7. Security: No retrieval from unauthorized sources.
8. Validation: Citations verified.
9. Gaps: No RAG pipeline. No embedding retrieval.
10. Target: Evaluate RAG need post-framework.

### ONT-03.13 | Conflicts and temporal validity

1. Current assets: git merge for handoff conflicts. syncthing sync-conflict copies. Operator review for major conflicts.
2. Status: Verified -- syncthing creates .sync-conflict files when peers diverge.
3. Inputs/outputs: Conflict files, git merge conflicts.
4. Dependencies: git, syncthing.
5. Source of truth: Conflict copies on bus.
6. Execution: Manual resolution.
7. Security: Conflicts are transparent.
8. Validation: `find ~/herm-workspace -name '*.sync-conflict*'`.
9. Gaps: No automated conflict resolution.
10. Target: Document conflict resolution procedure.

### ONT-03.14 | Privacy and retention

1. Current assets: No retention policy. Credentials kept in .env. Flag-able content tar.gz'd before upload.
2. Status: Verified -- .env blocked from read_file. Flag-able content convention exists.
3. Inputs/outputs: .env, tar.gz archives.
4. Dependencies: Operator trust.
5. Source of truth: AGENTS.md pitfalls section.
6. Execution: Credentials stay local. Flag-able content masked before upload.
7. Security: .env never exposed. Backups age-encrypt credentials.
8. Validation: grep for banned patterns in uploads.
9. Gaps: No formal data retention schedule.
10. Target: Document retention policy.

### ONT-03.15 | Knowledge review and export

1. Current assets: git push to GitHub (worm-handoff repo). Obsidian vault (unused). Handoff files for export.
2. Status: Verified -- git remote set to aimasterwes66-collab.
3. Inputs/outputs: git push, write_file.
4. Dependencies: git, GitHub auth.
5. Source of truth: GitHub.com/aimasterwes66-collab/worm-handoff.
6. Execution: Manual push or scripted.
7. Security: Public repo (collab org).
8. Validation: `git status`, `git push` success.
9. Gaps: No automated sync to Obsidian.
10. Target: No change -- Git is sufficient.

---

## ONT-04: MODELS, APIs & COMPUTATIONAL SERVICES

Agent owner: Herm (primary), WORM (local inference config)

### ONT-04.01 | Provider inventory

1. Current assets: OpenRouter (primary, ~$6.79 balance). DeepSeek API (valid, direct). Fallback chain: hermes-3-llama-3.1-70b -> grok-4.6 -> nemotron-3-super-120b-a12b:free -> deepseek-v4-flash.
2. Status: Verified -- OpenRouter key da0cb240 works. Model responds.
3. Inputs/outputs: API calls via Hermes model routing.
4. Dependencies: OpenRouter API, DeepSeek API.
5. Source of truth: ~/.hermes/.env (keys), ~/.hermes/config.yaml (model config).
6. Execution: Remote inference. WORM has no local GPU.
7. Security: API keys in .env. No third-party credential access.
8. Validation: `curl https://api.openrouter.ai/v1/models` returns model list (200 OK).
9. Gaps: No image/video generation API configured. No embedding endpoint.
10. Target: Add image gen API (OpenRouter supports it).

### ONT-04.02 | Endpoint and model registry

1. Current assets: deepseek-v4-flash via OpenRouter. Vision exp via api.deepseek.com/v1.
2. Status: Verified -- model responds.
3. Inputs/outputs: Chat completions (text). Vision (text+image).
4. Dependencies: OpenRouter, DeepSeek API.
5. Source of truth: ~/.hermes/config.yaml.
6. Execution: Hermes routes to model.
7. Security: API key auth.
8. Validation: Model returns valid JSON.
9. Gaps: No local models. No GGUF/llama.cpp.
10. Target: No change -- remote is correct for this device.

### ONT-04.03 | Authentication and secret routing

1. Current assets: OpenRouter key in .env. DeepSeek key in .env. Both sourced in .bashrc.
2. Status: Verified -- model calls succeed.
3. Inputs/outputs: HTTP Authorization headers.
4. Dependencies: .env file.
5. Source of truth: ~/.hermes/.env (blocked from read_file).
6. Execution: Injected as env vars.
7. Security: Keys in plaintext. Blocked from agent read.
8. Validation: API calls succeed.
9. Gaps: No secret rotation. No per-model keys.
10. Target: Age-encrypt .env bundle.

### ONT-04.04 | Remote inference gateway

1. Current assets: OpenRouter unified API (compatible with OpenAI SDK). DeepSeek direct API.
2. Status: Verified -- Hermes uses OpenRouter as default provider.
3. Inputs/outputs: HTTP POST to /v1/chat/completions.
4. Dependencies: OpenRouter endpoint.
5. Source of truth: OpenRouter docs (context7 MCP available).
6. Execution: Requests routed via Hermes gateway.
7. Security: Key in header. HTTPS.
8. Validation: 200 responses with completion.
9. Gaps: No local fallback. No offline mode.
10. Target: Document offline strategy (aban — none planned).

### ONT-04.05 | Text and code inference

1. Current assets: deepseek-v4-flash for reasoning/code. Tool use supported.
2. Status: Verified -- this session uses the model.
3. Inputs/outputs: Text completions, structured tool calls.
4. Dependencies: OpenRouter.
5. Source of truth: Live testing.
6. Execution: Remote. fast (flash-class).
7. Security: Tool calls routed through Hermes.
8. Validation: This conversation proves it.
9. Gaps: No code-specific model (e.g., DeepSeek Coder).
10. Target: Consider code model for heavy dev work.

### ONT-04.06 | Image generation endpoints

1. Current assets: None configured on WORM. OpenRouter has image gen models available.
2. Status: Known absent -- not configured.
3. Inputs: None.
4. Dependencies: Would need OpenRouter image gen key.
5. Source of truth: N/A.
6. Execution: Would run remote.
7. Security: N/A.
8. Validation: N/A.
9. Gaps: No image pipeline.
10. Target: Configure when needed. Herm should do this.

### ONT-04.07 | Audio and music endpoints

1. Current assets: TTS (text_to_speech tool -- provider: edge/openai). Suno AI via web.
2. Status: TTS proven (works in Hermes). Suno flagged as potential.
3. Inputs/outputs: text_to_speech, web scraping for Suno.
4. Dependencies: Edge TTS API, Suno web UI.
5. Source of truth: TTS tool in Hermes.
6. Execution: Remote.
7. Security: TTS is free tier.
8. Validation: TTS generates audio files.
9. Gaps: No STT. No music gen API (Suno web-only).
10. Target: Add Suno API when available.

### ONT-04.08 through ONT-04.15

Status: Unknown / Not applicable from WORM vantage. These cover image, video,
animation, embedding, batch jobs, caching, pricing, output validation, and
portability -- none configured on WORM. Herm and Ace own these domains.

REFERRED TO HERM:
- ONT-04.08 Video and animation endpoints
- ONT-04.09 Embedding and retrieval endpoints
- ONT-04.10 Batch and asynchronous jobs
- ONT-04.11 Latency and reliability
- ONT-04.12 Pricing and budget policy
- ONT-04.13 Caching and reuse
- ONT-04.14 Output validation and provenance
- ONT-04.15 Portability and outage response

---

## ONT-05: CREATIVE PRODUCTION & MEDIA GENERATION (REFERRED)

Agent owner: Herm (primary creative agent). WORM has no local creative
production capability beyond text generation.

Sections 05.01-05.15 all REFERRED TO HERM. WORM can assist on text-only
creative briefs and lyrics/songwriting prompts.

Key facts known:
- ONT-05.03 (Lyrics/songwriting): WORM has songwriting-and-ai-music skill.
- ONT-05.05 (TTS): text_to_speech works (edge provider).
- ONT-05.07 (Image gen): Not configured, available via OpenRouter.
- ONT-05.08 (Music gen): Suno web, no API.
- ONT-05.10 (Video): Not configured.

---

## ONT-06: SOFTWARE DEVELOPMENT & DIGITAL PUBLISHING (REFERRED)

Agent owner: Ace (primary -- iMac). WORM has no local dev environment
beyond Hermes agent scripts and skill authoring.

Sections 06.01-06.15 all REFERRED TO ACE. WORM can assist on:
- ONT-06.04: Skill authoring (hermes-agent-skill-authoring skill exists).
- ONT-06.09: Code review (requesting-code-review skill exists).
- ONT-06.10: Testing (test-driven-development skill exists).

---

## ONT-07: AUTOMATION, RESEARCH & DATA ACQUISITION

Agent owner: WORM (cron/scheduling), Ace (research/analysis)

### ONT-07.01 | Cron and recurrence

1. Current assets: Hermes cron (cronjob_manage). ~/.hermes/cron/ entries. hourly model-canary.sh, daily kg-graph-recur, nightly backup-push.
2. Status: Verified -- cron jobs scheduled and running.
3. Inputs/outputs: Job definitions, execution results (logged).
4. Dependencies: Hermes cron daemon.
5. Source of truth: `cronjob_manage action=list`.
6. Execution: Local. cron daemon runs in gateway process.
7. Security: Jobs run as WORM user.
8. Validation: `cronjob_manage action=list` shows active jobs.
9. Gaps: No persistence across gateway restart (recreated at session start).
10. Target: Define standard cron set in bootstrap script.

### ONT-07.02 | Research pipeline

1. Current assets: web_search, web_extract, grounded-citations skill.
2. Status: Verified -- web research tools work.
3. Inputs/outputs: Search queries, extracted content.
4. Dependencies: Web search API.
5. Source of truth: Tool outputs.
6. Execution: On-demand.
7. Security: Public web sources only.
8. Validation: Results returned.
9. Gaps: No automated research scheduler.
10. Target: Defer to Ace for systematic research.

### ONT-07.03 through ONT-07.15

REFERRED TO HERM/ACE. WORM handles:
- ONT-07.01 Cron and recurrence (WORM primary)
- ONT-07.02 Research pipeline (WORM secondary)
- ONT-07.13 Scheduling and recurrence (WORM secondary)

Others (web scraping, data processing, analysis) belong to Herm/Ace.

---

## ONT-08: USER INTERFACES & UNIFIED WORKBENCH (REFERRED)

Agent owner: Ace (iMac). WORM is a CLI-only interface (Termux + Hermes chat).
No GUI, no web UI, no panels, no visual language.

Sections 08.01-08.15 all REFERRED TO ACE.

---

## ONT-09: PROJECT MANAGEMENT, ASSET MANAGEMENT & PRODUCTION OPS

Agent owner: Ace (coordinator), WORM (file-level asset tracking)

### ONT-09.01 | Project registry and identity

1. Current assets: Handoff files as project registry. ~/worm-handoff/ git for history.
2. Status: Verified -- handoffs serve as project records.
3. Inputs/outputs: TO-ALL/TO-ACE/TO-HERM handoff files.
4. Dependencies: Git, syncthing.
5. Source of truth: ~/worm-handoff/ git log.
6. Execution: WORM tracks own projects. Ace tracks mesh-wide.
7. Security: Public project metadata.
8. Validation: `git log --oneline` shows project activity.
9. Gaps: No formal project registry database.
10. Target: Accept handoff-as-registry pattern.

### ONT-09.02 through ONT-09.15

REFERRED TO ACE (primary project manager). WORM contributes:
- ONT-09.05 (Task tracking): Via todo_list and handoffs.
- ONT-09.07 (Templates): UNMUZZLED-AI template pattern (CLAUDE.md).
- ONT-09.08 (Versioning): Git.

---

## ONT-10: SYSTEM INTEGRATION, EVOLUTION & GOVERNANCE

Agent owner: Ace (primary), WORM (mesh ground truth)

### ONT-10.01 | System boundary map

1. Current assets: Mesh boundary is 3 nodes -- WORM (tablet), Herm (S22), Ace (iMac). GDrive as external.
2. Status: Verified -- all 3 nodes live.
3. Inputs/outputs: Handoff bus. A2A protocol.
4. Dependencies: Tailscale, syncthing, Hermes gateway.
5. Source of truth: ~/AGENTS.md.
6. Execution: WORM is read-only ground node. Herm is coordinator. Ace is operator face.
7. Security: Within tailnet. No public exposure.
8. Validation: A2A ping 200 from each peer.
9. Gaps: No formal system boundary document.
10. Target: Document boundary map post-framework.

### ONT-10.02 through ONT-10.15

REFERRED TO ACE. These require mesh-wide coordination view.
WORM contributes ground-truth data as needed.

---

## IMMEDIATE NEXT STEPS

1. WORM has filled ONT-01 (complete), ONT-02 (complete), ONT-03 (complete),
   ONT-07 (partial WORM parts), sections of ONT-04/09/10 from WORM vantage.
2. Herm must fill: ONT-02 (agent arch validation), ONT-04 (model endpoints),
   ONT-05 (creative), ONT-07 (automation), ONT-08 (UI) -- Herm's S22 vantage.
3. Ace must fill: ONT-06 (software dev), ONT-08 (UI), ONT-09 (project mgmt),
   ONT-10 (governance) -- Ace's iMac vantage.
4. THEN: Answer the 100 questions (Section C) -- each agent answers their
   domain. Ace synthesizes and merges.
5. Result goes to `AI-UNMUZZLED/FOLDER` for Codex consumption.

-- WORM (9185W, [IP_ADDRESS])