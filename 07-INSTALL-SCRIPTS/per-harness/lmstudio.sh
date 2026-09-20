#!/usr/bin/env bash
# UNMUZZLED-AI :: per-harness / lmstudio
# Download abliterated GGUF checkpoints into ~/.lmstudio/models and emit preset JSON.
set -euo pipefail

UNMUZZLED_ROOT="${UNMUZZLED_ROOT:-/home/dirt/UNMUZZLED-AI}"
UNMUZZLED_HOME="${UNMUZZLED_HOME:-$HOME/.unmuzzled}"
LM_ROOT="${LM_ROOT:-$HOME/.lmstudio}"
MODELS_DIR="$LM_ROOT/models"
PRESET_DIR="$LM_ROOT/config-presets"
TS="$(date -u +%Y%m%dT%H%M%SZ)"
LOG_DIR="$UNMUZZLED_HOME/logs"
LOG_FILE="$LOG_DIR/install-lmstudio-$TS.log"
mkdir -p "$LOG_DIR" "$MODELS_DIR" "$PRESET_DIR" "$UNMUZZLED_HOME/harnesses/lmstudio"
exec > >(tee -a "$LOG_FILE") 2>&1

log() { printf '[%s] %s\n' "$(date -u +%H:%M:%SZ)" "$*"; }

# Prefer huggingface-cli if available; fall back to curl for direct URLs.
have_hf=0
if command -v huggingface-cli >/dev/null 2>&1; then have_hf=1; fi

download_hf() {
    # $1 = repo (org/name), $2 = filename, $3 = local subdir
    local repo="$1" file="$2" sub="$3"
    local dest_dir="$MODELS_DIR/$sub"
    mkdir -p "$dest_dir"
    local dest="$dest_dir/$file"
    if [ -f "$dest" ] && [ -s "$dest" ]; then
        log "already present: $dest"
        return 0
    fi
    if [ "$have_hf" -eq 1 ]; then
        log "hf download $repo :: $file -> $dest_dir"
        huggingface-cli download "$repo" "$file" \
            --local-dir "$dest_dir" \
            --local-dir-use-symlinks False >/dev/null
    else
        local url="https://huggingface.co/$repo/resolve/main/$file"
        log "curl $url"
        curl -fL --retry 3 -o "$dest.part" "$url"
        mv -f "$dest.part" "$dest"
    fi
}

# Curated abliterated GGUFs (override by editing this table).
# format: "<repo>|<filename>|<local-subdir>|<preset-name>"
MODELS=(
    "bartowski/Hermes-3-Llama-3.1-8B-abliterated-GGUF|Hermes-3-Llama-3.1-8B-abliterated-Q5_K_M.gguf|hermes-3-8b-abliterated|unmuzzled-hermes-3-8b"
    "bartowski/dolphin-2.9-llama3-8b-GGUF|dolphin-2.9-llama3-8b-Q5_K_M.gguf|dolphin-2.9-llama3-8b|unmuzzled-dolphin-3-8b"
    "bartowski/DeepSeek-R1-Distill-Llama-8B-abliterated-GGUF|DeepSeek-R1-Distill-Llama-8B-abliterated-Q5_K_M.gguf|deepseek-r1-8b-abliterated|unmuzzled-deepseek-r1-8b"
)

# Resolve system prompt
SYS_SRC=""
for cand in \
    "$UNMUZZLED_ROOT/01-SYSTEM-PROMPTS/UNMUZZLED.md" \
    "$UNMUZZLED_ROOT/01-SYSTEM-PROMPTS/unmuzzled.md" \
    "$UNMUZZLED_ROOT/00-DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md"; do
    if [ -f "$cand" ]; then SYS_SRC="$cand"; break; fi
done
if [ -z "$SYS_SRC" ]; then
    log "ERROR: no system prompt source found"
    exit 2
fi

for row in "${MODELS[@]}"; do
    IFS='|' read -r repo file sub preset <<<"$row"
    if ! download_hf "$repo" "$file" "$sub"; then
        log "WARN download failed for $repo/$file — skipping preset"
        continue
    fi

    PRESET_JSON="$PRESET_DIR/${preset}.preset.json"
    python3 - "$PRESET_JSON" "$preset" "$SYS_SRC" <<'PY'
import json, sys, pathlib
out, name, sys_path = sys.argv[1:4]
sys_text = pathlib.Path(sys_path).read_text()
data = {
    "name": name,
    "operation": {
        "fields": [
            {"key": "llm.prediction.systemPrompt", "value": sys_text},
            {"key": "llm.prediction.temperature", "value": 0.9},
            {"key": "llm.prediction.topPSampling", "value": 0.95},
            {"key": "llm.prediction.contextOverflowPolicy", "value": "rollingWindow"},
            {"key": "llm.load.contextLength", "value": 16384}
        ]
    }
}
pathlib.Path(out).write_text(json.dumps(data, indent=2) + "\n")
print("preset:", out)
PY
    log "preset -> $PRESET_JSON"
done

log "lmstudio harness done. In LM Studio, load a model then select the preset with prefix 'unmuzzled-'."
exit 0
