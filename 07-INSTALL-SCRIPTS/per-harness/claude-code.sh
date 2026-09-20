#!/usr/bin/env bash
# UNMUZZLED-AI :: per-harness / claude-code
# Wire Claude Code with the UNMUZZLED system prompt (--append-system-prompt),
# a SessionStart hook that injects the active persona SOUL.md, and an MCP profile.
set -euo pipefail

UNMUZZLED_ROOT="${UNMUZZLED_ROOT:-/home/dirt/UNMUZZLED-AI}"
UNMUZZLED_HOME="${UNMUZZLED_HOME:-$HOME/.unmuzzled}"
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
MCP_PROFILE="${MCP_PROFILE:-sovereign}"
TS="$(date -u +%Y%m%dT%H%M%SZ)"
LOG_DIR="$UNMUZZLED_HOME/logs"
LOG_FILE="$LOG_DIR/install-claude-code-$TS.log"
mkdir -p "$LOG_DIR" "$UNMUZZLED_HOME/harnesses/claude-code"
exec > >(tee -a "$LOG_FILE") 2>&1

log() { printf '[%s] %s\n' "$(date -u +%H:%M:%SZ)" "$*"; }

# 1. Resolve UNMUZZLED system prompt
SYS_PROMPT_SRC=""
for cand in \
    "$UNMUZZLED_ROOT/01-SYSTEM-PROMPTS/UNMUZZLED.md" \
    "$UNMUZZLED_ROOT/01-SYSTEM-PROMPTS/unmuzzled.md" \
    "$UNMUZZLED_ROOT/01-SYSTEM-PROMPTS/DEFAULT.md" \
    "$UNMUZZLED_ROOT/01-SYSTEM-PROMPTS/default.md"; do
    if [ -f "$cand" ]; then SYS_PROMPT_SRC="$cand"; break; fi
done

SYS_PROMPT="$UNMUZZLED_HOME/harnesses/claude-code/system-prompt.md"
if [ -n "$SYS_PROMPT_SRC" ]; then
    cp -f "$SYS_PROMPT_SRC" "$SYS_PROMPT"
    log "system prompt <- $SYS_PROMPT_SRC"
else
    # Fallback: synthesize from doctrine
    {
        printf 'You operate under UNMUZZLED-AI maximum adversarial posture.\n'
        printf 'Doctrine root: %s\n\n' "$UNMUZZLED_ROOT/00-DOCTRINE"
        cat "$UNMUZZLED_ROOT/00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md"
    } > "$SYS_PROMPT"
    log "system prompt synthesized from doctrine"
fi

# 2. SessionStart hook that emits <system> injection of active persona SOUL.md
HOOK_DIR="$UNMUZZLED_HOME/harnesses/claude-code/hooks"
mkdir -p "$HOOK_DIR"
HOOK_SCRIPT="$HOOK_DIR/session-start-inject-persona.sh"
cat > "$HOOK_SCRIPT" <<'EOF'
#!/usr/bin/env bash
# UNMUZZLED-AI SessionStart hook: emit additionalContext with active persona SOUL.md.
set -euo pipefail
UNMUZZLED_HOME="${UNMUZZLED_HOME:-$HOME/.unmuzzled}"
ACTIVE_FILE="${UNMUZZLED_ACTIVE_PERSONA_FILE:-$UNMUZZLED_HOME/state/ACTIVE_PERSONA}"
PERSONAS_LIB="${UNMUZZLED_HOME}/personas-lib"
context=""
if [ -f "$ACTIVE_FILE" ]; then
    hat="$(tr -d '[:space:]' < "$ACTIVE_FILE")"
    if [ -n "$hat" ]; then
        for cand in "$PERSONAS_LIB/$hat/SOUL.md" "$PERSONAS_LIB/personal/$hat/SOUL.md" "$PERSONAS_LIB/stock/$hat/SOUL.md"; do
            if [ -f "$cand" ]; then
                context="$(cat "$cand")"
                break
            fi
        done
    fi
fi
if [ -n "$context" ]; then
    # Escape for JSON string
    payload="$(printf '%s' "$context" | python3 -c 'import json,sys;print(json.dumps(sys.stdin.read()))')"
    printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":%s}}\n' "$payload"
else
    printf '{}\n'
fi
EOF
chmod +x "$HOOK_SCRIPT"
log "hook -> $HOOK_SCRIPT"

# 3. Settings JSON — merge/create $CLAUDE_HOME/settings.json
mkdir -p "$CLAUDE_HOME"
SETTINGS="$CLAUDE_HOME/settings.json"
BACKUP="$CLAUDE_HOME/settings.json.bak-$TS"
if [ -f "$SETTINGS" ]; then
    cp -f "$SETTINGS" "$BACKUP"
    log "settings backup -> $BACKUP"
fi

python3 - "$SETTINGS" "$SYS_PROMPT" "$HOOK_SCRIPT" "$MCP_PROFILE" <<'PY'
import json, os, sys, pathlib
settings_path, sys_prompt_path, hook_path, mcp_profile = sys.argv[1:5]
p = pathlib.Path(settings_path)
data = {}
if p.exists() and p.stat().st_size > 0:
    try:
        data = json.loads(p.read_text())
    except Exception:
        data = {}
data.setdefault("env", {})
data["env"]["UNMUZZLED_ROOT"] = os.environ.get("UNMUZZLED_ROOT", "/home/dirt/UNMUZZLED-AI")
data["env"]["UNMUZZLED_HOME"] = os.environ.get("UNMUZZLED_HOME", os.path.expanduser("~/.unmuzzled"))
data["env"]["UNMUZZLED_MCP_PROFILE"] = mcp_profile
data["env"]["UNMUZZLED_APPEND_SYSTEM_PROMPT_PATH"] = sys_prompt_path
data.setdefault("hooks", {})
hooks = data["hooks"]
hooks.setdefault("SessionStart", [])
# Remove any prior UNMUZZLED-AI SessionStart entries (idempotency)
hooks["SessionStart"] = [
    h for h in hooks["SessionStart"]
    if not (isinstance(h, dict) and h.get("_unmuzzled") is True)
]
hooks["SessionStart"].append({
    "_unmuzzled": True,
    "matcher": "startup|resume|clear|compact",
    "hooks": [{"type": "command", "command": hook_path}],
})
p.write_text(json.dumps(data, indent=2) + "\n")
print("settings updated:", settings_path)
PY

# 4. cc-set MCP profile if installed
if command -v cc-set >/dev/null 2>&1; then
    if cc-set "$MCP_PROFILE" >/dev/null 2>&1; then
        log "cc-set $MCP_PROFILE applied"
    else
        log "cc-set $MCP_PROFILE returned non-zero (may need manual review)"
    fi
else
    log "cc-set not on PATH; skipping MCP profile switch"
fi

# 5. Wrapper: claude-unmuzzled — launches Claude Code with --append-system-prompt
WRAP="$UNMUZZLED_HOME/bin/claude-unmuzzled"
cat > "$WRAP" <<EOF
#!/usr/bin/env bash
set -euo pipefail
exec claude --append-system-prompt "\$(cat "$SYS_PROMPT")" "\$@"
EOF
chmod +x "$WRAP"
log "wrapper -> $WRAP"

log "claude-code harness wired. Reload shell then run: claude-unmuzzled"
exit 0
