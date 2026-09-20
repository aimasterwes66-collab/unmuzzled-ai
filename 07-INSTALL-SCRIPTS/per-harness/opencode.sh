#!/usr/bin/env bash
# UNMUZZLED-AI :: per-harness / opencode
# Wire opencode with the sovereign agent deck and OpenRouter models.
set -euo pipefail

UNMUZZLED_ROOT="${UNMUZZLED_ROOT:-/home/dirt/UNMUZZLED-AI}"
UNMUZZLED_HOME="${UNMUZZLED_HOME:-$HOME/.unmuzzled}"
OPENCODE_HOME="${OPENCODE_HOME:-$HOME/.config/opencode}"
DECK_SRC="${OPENCODE_DECK:-/home/dirt/opencode-agent-deck}"
TS="$(date -u +%Y%m%dT%H%M%SZ)"
LOG_DIR="$UNMUZZLED_HOME/logs"
LOG_FILE="$LOG_DIR/install-opencode-$TS.log"
mkdir -p "$LOG_DIR" "$UNMUZZLED_HOME/harnesses/opencode" "$OPENCODE_HOME/agents"
exec > >(tee -a "$LOG_FILE") 2>&1

log() { printf '[%s] %s\n' "$(date -u +%H:%M:%SZ)" "$*"; }

if [ ! -d "$DECK_SRC/agents" ]; then
    log "ERROR: agent deck not found at $DECK_SRC/agents"
    exit 2
fi

# 1. Install the six operator-designated agents
AGENTS=(dictator dark-factory hacker greedy-artist raw-storyteller freeops)
for a in "${AGENTS[@]}"; do
    src="$DECK_SRC/agents/${a}.md"
    if [ ! -f "$src" ]; then
        log "WARN missing $src (skip)"
        continue
    fi
    dst="$OPENCODE_HOME/agents/${a}.md"
    cp -f "$src" "$dst"
    log "agent -> $dst"
done

# 2. Load OpenRouter creds from ~/.hermes/.env (if present)
HERMES_ENV="$HOME/.hermes/.env"
if [ -f "$HERMES_ENV" ]; then
    set +u; . "$HERMES_ENV"; set -u
fi
OR_KEY="${OPENROUTER_API_KEY:-}"

# 3. Emit opencode.jsonc with sovereign primaries
OPENCODE_JSONC="$OPENCODE_HOME/opencode.jsonc"
BACKUP=""
if [ -f "$OPENCODE_JSONC" ]; then
    BACKUP="$OPENCODE_JSONC.bak-$TS"
    cp -f "$OPENCODE_JSONC" "$BACKUP"
    log "backup -> $BACKUP"
fi

cat > "$OPENCODE_JSONC" <<'EOF'
{
  // UNMUZZLED-AI opencode config — sovereign primaries only.
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "openrouter": {
      "npm": "@openrouter/ai-sdk-provider",
      "options": {
        "apiKey": "{env:OPENROUTER_API_KEY}"
      },
      "models": {
        "deepseek/deepseek-chat":           { "name": "deepseek-v4-flash" },
        "nousresearch/hermes-3-llama-3.1-405b": { "name": "hermes-3-405b" },
        "nousresearch/hermes-3-llama-3.1-70b":  { "name": "hermes-3-70b" },
        "mistralai/mistral-large":          { "name": "mistral-large" }
      }
    }
  },
  "model": "openrouter/deepseek/deepseek-chat",
  "small_model": "openrouter/nousresearch/hermes-3-llama-3.1-70b",
  "agent": {
    "dictator":       { "model": "openrouter/nousresearch/hermes-3-llama-3.1-405b" },
    "dark-factory":   { "model": "openrouter/deepseek/deepseek-chat" },
    "hacker":         { "model": "openrouter/nousresearch/hermes-3-llama-3.1-405b" },
    "greedy-artist":  { "model": "openrouter/deepseek/deepseek-chat" },
    "raw-storyteller":{ "model": "openrouter/nousresearch/hermes-3-llama-3.1-405b" },
    "freeops":        { "model": "openrouter/deepseek/deepseek-chat" }
  },
  "tainted_models": [
    "openai/*",
    "anthropic/claude-*"
  ]
}
EOF
log "config -> $OPENCODE_JSONC"

# 4. Write env drop-in so opencode picks up the key even if the parent shell hasn't sourced hermes env
ENV_DROPIN="$OPENCODE_HOME/env"
{
    printf 'OPENROUTER_API_KEY=%s\n' "$OR_KEY"
} > "$ENV_DROPIN"
chmod 600 "$ENV_DROPIN"
log "env drop-in -> $ENV_DROPIN"

# 5. Wrapper
WRAP="$UNMUZZLED_HOME/bin/opencode-unmuzzled"
cat > "$WRAP" <<EOF
#!/usr/bin/env bash
set -euo pipefail
[ -f "$ENV_DROPIN" ] && set -a && . "$ENV_DROPIN" && set +a
exec opencode "\$@"
EOF
chmod +x "$WRAP"
log "wrapper -> $WRAP"

log "opencode harness wired. Agents installed: ${AGENTS[*]}"
exit 0
