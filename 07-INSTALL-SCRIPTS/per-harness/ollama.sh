#!/usr/bin/env bash
# UNMUZZLED-AI :: per-harness / ollama
# Pull abliterated / uncensored local models and write UNMUZZLED Modelfiles.
set -euo pipefail

UNMUZZLED_ROOT="${UNMUZZLED_ROOT:-/home/dirt/UNMUZZLED-AI}"
UNMUZZLED_HOME="${UNMUZZLED_HOME:-$HOME/.unmuzzled}"
TS="$(date -u +%Y%m%dT%H%M%SZ)"
LOG_DIR="$UNMUZZLED_HOME/logs"
LOG_FILE="$LOG_DIR/install-ollama-$TS.log"
MODELFILE_DIR="$UNMUZZLED_HOME/harnesses/ollama"
mkdir -p "$LOG_DIR" "$MODELFILE_DIR"
exec > >(tee -a "$LOG_FILE") 2>&1

log() { printf '[%s] %s\n' "$(date -u +%H:%M:%SZ)" "$*"; }

if ! command -v ollama >/dev/null 2>&1; then
    log "ERROR: ollama not on PATH"
    exit 2
fi

# Wait briefly for daemon; do not start it — leave that to the operator's service manager.
if ! ollama list >/dev/null 2>&1; then
    log "ERROR: ollama daemon not reachable (run 'ollama serve' or start the service)"
    exit 3
fi

# Base upstream tags — abliterated / uncensored community builds.
# If a tag is unavailable, we log and continue.
BASE_MODELS=(
    "huihui_ai/hermes-4-abliterated:latest|hermes4-abliterated"
    "dolphin-mixtral:8x7b|dolphin-mixtral"
    "huihui_ai/deepseek-r1-abliterated:latest|deepseek-r1-abliterated"
)

# Resolve UNMUZZLED SYSTEM prompt
SYS_SRC=""
for cand in \
    "$UNMUZZLED_ROOT/01-SYSTEM-PROMPTS/UNMUZZLED.md" \
    "$UNMUZZLED_ROOT/01-SYSTEM-PROMPTS/unmuzzled.md" \
    "$UNMUZZLED_ROOT/00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md"; do
    if [ -f "$cand" ]; then SYS_SRC="$cand"; break; fi
done
if [ -z "$SYS_SRC" ]; then
    log "ERROR: no system prompt source found"
    exit 4
fi
SYS_TEXT="$(cat "$SYS_SRC")"

for entry in "${BASE_MODELS[@]}"; do
    upstream="${entry%%|*}"
    local_name="unmuzzled-${entry##*|}"

    log "pull $upstream ..."
    if ! ollama pull "$upstream"; then
        log "WARN pull failed for $upstream — skipping"
        continue
    fi

    MODELFILE="$MODELFILE_DIR/${local_name}.Modelfile"
    {
        printf 'FROM %s\n' "$upstream"
        printf 'PARAMETER temperature 0.9\n'
        printf 'PARAMETER top_p 0.95\n'
        printf 'PARAMETER num_ctx 16384\n'
        printf 'SYSTEM """\n%s\n"""\n' "$SYS_TEXT"
    } > "$MODELFILE"
    log "modelfile -> $MODELFILE"

    if ollama list | awk '{print $1}' | grep -qx "$local_name:latest"; then
        ollama rm "$local_name" >/dev/null 2>&1 || true
    fi
    if ollama create "$local_name" -f "$MODELFILE"; then
        log "created $local_name"
    else
        log "WARN failed to create $local_name"
    fi
done

log "ollama harness done. List with: ollama list"
exit 0
