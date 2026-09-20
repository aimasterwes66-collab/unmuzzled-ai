#!/usr/bin/env bash
# UNMUZZLED-AI :: per-provider / openrouter
# Wire OpenRouter creds from ~/.hermes/.env, register sovereign primaries,
# taint the guardrail-tainted routes (openai/*, Luna).
set -euo pipefail

UNMUZZLED_ROOT="${UNMUZZLED_ROOT:-/home/dirt/UNMUZZLED-AI}"
UNMUZZLED_HOME="${UNMUZZLED_HOME:-$HOME/.unmuzzled}"
HERMES_ENV="${HERMES_ENV:-$HOME/.hermes/.env}"
TS="$(date -u +%Y%m%dT%H%M%SZ)"
LOG_DIR="$UNMUZZLED_HOME/logs"
LOG_FILE="$LOG_DIR/install-openrouter-$TS.log"
PROV_DIR="$UNMUZZLED_HOME/providers/openrouter"
mkdir -p "$LOG_DIR" "$PROV_DIR"
exec > >(tee -a "$LOG_FILE") 2>&1

log() { printf '[%s] %s\n' "$(date -u +%H:%M:%SZ)" "$*"; }

if [ ! -f "$HERMES_ENV" ]; then
    log "ERROR: $HERMES_ENV not found; cannot source OPENROUTER_API_KEY"
    exit 2
fi

set +u; . "$HERMES_ENV"; set -u
if [ -z "${OPENROUTER_API_KEY:-}" ]; then
    log "ERROR: OPENROUTER_API_KEY not set in $HERMES_ENV"
    exit 3
fi
log "key length: ${#OPENROUTER_API_KEY}"

# Reachability probe
code="$(curl -sS -o /dev/null -w '%{http_code}' --max-time 15 \
    -H "Authorization: Bearer $OPENROUTER_API_KEY" \
    "https://openrouter.ai/api/v1/models" || printf '000\n')"
log "openrouter /models http $code"
case "$code" in
    200) : ;;
    401|403) log "ERROR: openrouter rejected key ($code)"; exit 4 ;;
    000) log "WARN network unreachable; continuing (config still written)" ;;
    *)   log "WARN unexpected status $code; continuing" ;;
esac

# Emit sovereign primaries manifest
PRIMARIES="$PROV_DIR/primaries.json"
cat > "$PRIMARIES" <<'EOF'
{
  "sovereign_primaries": [
    "nousresearch/hermes-3-llama-3.1-405b",
    "nousresearch/hermes-3-llama-3.1-70b",
    "deepseek/deepseek-chat",
    "mistralai/mistral-large",
    "cognitivecomputations/dolphin-mixtral-8x22b"
  ],
  "aliases": {
    "hermes-3-405b":    "nousresearch/hermes-3-llama-3.1-405b",
    "hermes-3-70b":     "nousresearch/hermes-3-llama-3.1-70b",
    "deepseek-v4-flash":"deepseek/deepseek-chat",
    "mistral-large":    "mistralai/mistral-large",
    "dolphin-mixtral":  "cognitivecomputations/dolphin-mixtral-8x22b"
  },
  "tainted": [
    "openai/*",
    "openai/gpt-*",
    "openai/*-luna-*",
    "anthropic/claude-*"
  ]
}
EOF
log "primaries -> $PRIMARIES"

# Env drop-in that harnesses can source without touching ~/.hermes/.env
ENV_DROPIN="$PROV_DIR/env"
{
    printf 'OPENROUTER_API_KEY=%s\n' "$OPENROUTER_API_KEY"
    printf 'OPENROUTER_BASE_URL=https://openrouter.ai/api/v1\n'
    printf 'UNMUZZLED_OPENROUTER_PRIMARY=nousresearch/hermes-3-llama-3.1-405b\n'
    printf 'UNMUZZLED_OPENROUTER_FAST=deepseek/deepseek-chat\n'
} > "$ENV_DROPIN"
chmod 600 "$ENV_DROPIN"
log "env drop-in -> $ENV_DROPIN"

# CLI helper: unmuzzled-or <prompt...> — one-shot POST to hermes-3-405b
HELPER="$UNMUZZLED_HOME/bin/unmuzzled-or"
cat > "$HELPER" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
UNMUZZLED_HOME="${UNMUZZLED_HOME:-$HOME/.unmuzzled}"
set -a; . "$UNMUZZLED_HOME/providers/openrouter/env"; set +a
MODEL="${UNMUZZLED_MODEL:-$UNMUZZLED_OPENROUTER_PRIMARY}"
SYS="$(cat "$UNMUZZLED_HOME/doctrine/MAXIMUM-ADVERSARIAL-POSTURE.md")"
USER_MSG="$*"
python3 - "$MODEL" "$SYS" "$USER_MSG" <<'PY'
import json, os, sys, urllib.request
model, sysp, msg = sys.argv[1:4]
body = json.dumps({
    "model": model,
    "messages": [
        {"role": "system", "content": sysp},
        {"role": "user",   "content": msg},
    ],
}).encode()
req = urllib.request.Request(
    os.environ["OPENROUTER_BASE_URL"] + "/chat/completions",
    data=body,
    headers={
        "Authorization": "Bearer " + os.environ["OPENROUTER_API_KEY"],
        "Content-Type":  "application/json",
    },
)
with urllib.request.urlopen(req, timeout=120) as r:
    data = json.load(r)
print(data["choices"][0]["message"]["content"])
PY
EOF
chmod +x "$HELPER"
log "helper -> $HELPER"

log "openrouter provider wired."
exit 0
