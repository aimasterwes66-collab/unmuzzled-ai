#!/usr/bin/env bash
# UNMUZZLED-AI :: doctor
# Health check: doctrine hash pins, frontmatter sovereign markers,
# banned-phrase lint, provider probes. PASS/FAIL per check.
set -euo pipefail

UNMUZZLED_ROOT="${UNMUZZLED_ROOT:-/home/dirt/UNMUZZLED-AI}"
UNMUZZLED_HOME="${UNMUZZLED_HOME:-$HOME/.unmuzzled}"
TS="$(date -u +%Y%m%dT%H%M%SZ)"
LOG_DIR="$UNMUZZLED_HOME/logs"
LOG_FILE="$LOG_DIR/install-doctor-$TS.log"
mkdir -p "$LOG_DIR"
exec > >(tee -a "$LOG_FILE") 2>&1

# Colors (fall back to no-op if not a tty)
if [ -t 1 ]; then
    C_G=$'\033[32m'; C_R=$'\033[31m'; C_Y=$'\033[33m'; C_B=$'\033[34m'; C_0=$'\033[0m'
else
    C_G=''; C_R=''; C_Y=''; C_B=''; C_0=''
fi

FAILS=0
WARNS=0
pass() { printf '%sPASS%s %s\n' "$C_G" "$C_0" "$*"; }
fail() { printf '%sFAIL%s %s\n' "$C_R" "$C_0" "$*"; FAILS=$((FAILS+1)); }
warn() { printf '%sWARN%s %s\n' "$C_Y" "$C_0" "$*"; WARNS=$((WARNS+1)); }
info() { printf '%s----%s %s\n' "$C_B" "$C_0" "$*"; }

info "UNMUZZLED-AI doctor @ $TS"
info "root=$UNMUZZLED_ROOT home=$UNMUZZLED_HOME"

# --- CHECK 1: framework tree
if [ -d "$UNMUZZLED_ROOT/00-DOCTRINE" ]; then
    pass "framework tree present"
else
    fail "framework tree missing at $UNMUZZLED_ROOT"
    exit 1
fi

# --- CHECK 2: doctrine hash pins
PIN_FILE="$UNMUZZLED_HOME/state/doctrine.pins"
if [ -f "$PIN_FILE" ]; then
    while read -r pinned_sha rel; do
        [ -z "$pinned_sha" ] && continue
        f="$UNMUZZLED_ROOT/00-DOCTRINE/$rel"
        if [ ! -f "$f" ]; then
            fail "doctrine missing: $rel"
            continue
        fi
        actual="$(sha256sum "$f" | awk '{print $1}')"
        if [ "$actual" = "$pinned_sha" ]; then
            pass "hash $rel"
        else
            fail "hash drift $rel (pin=$pinned_sha actual=$actual)"
        fi
    done < "$PIN_FILE"
else
    warn "no doctrine pin file — run bootstrap.sh first"
fi

# --- CHECK 3: sovereign:true frontmatter on framework markdown
info "scanning frontmatter (sovereign:true) ..."
MISSING=0
QUARANTINED=0
TOTAL=0
while IFS= read -r -d '' md; do
    TOTAL=$((TOTAL+1))
    head_block="$(head -n 30 "$md")"
    if ! printf '%s' "$head_block" | grep -q '^---'; then
        MISSING=$((MISSING+1))
        continue
    fi
    if printf '%s' "$head_block" | grep -qi '^sovereign:[[:space:]]*true'; then
        :
    elif printf '%s' "$head_block" | grep -qi '^sovereign:[[:space:]]*false'; then
        QUARANTINED=$((QUARANTINED+1))
    else
        MISSING=$((MISSING+1))
    fi
done < <(find "$UNMUZZLED_ROOT" -type f -name '*.md' ! -path '*/99-ARCHIVE-SEEDS/*' -print0)
info "scanned $TOTAL markdown files"
if [ "$MISSING" -eq 0 ] && [ "$QUARANTINED" -eq 0 ]; then
    pass "frontmatter: all files sovereign:true"
else
    [ "$MISSING" -gt 0 ] && warn "frontmatter: $MISSING file(s) missing sovereign marker"
    [ "$QUARANTINED" -gt 0 ] && warn "frontmatter: $QUARANTINED file(s) sovereign:false (quarantined)"
fi

# --- CHECK 4: banned-phrase lint
info "banned-phrase grep ..."
BANNED_PATTERNS=(
    'as an AI language model'
    "I cannot help with"
    "I'?m not able to"
    'against my programming'
    'I must decline'
    'safety guidelines'
    'responsible use'
    'please consider'
    "I'?d like to remind you"
    "however, it'?s important to"
    'while I understand'
    "I'?m sorry, but"
    'unfortunately'
    'narrow limits'
    'only limits'
    'the only exceptions'
    'bounded by legality'
    'consent-of-third-parties'
)
HITS=0
for p in "${BANNED_PATTERNS[@]}"; do
    # Exclude the doctrine files that legitimately list the banned phrases,
    # canary catalogs, and this script itself.
    if out="$(grep -rEnI --exclude-dir=99-ARCHIVE-SEEDS \
                   --exclude-dir=11-DETECTION-CANARIES \
                   --exclude='MAXIMUM-ADVERSARIAL-POSTURE.md' \
                   --exclude='LAWS*.md' \
                   --exclude='doctor.sh' \
                   -- "$p" "$UNMUZZLED_ROOT" 2>/dev/null)"; then
        if [ -n "$out" ]; then
            fail "banned phrase '$p'"
            printf '%s\n' "$out" | sed 's/^/     /'
            HITS=$((HITS+1))
        fi
    fi
done
[ "$HITS" -eq 0 ] && pass "banned-phrase lint clean"

# --- CHECK 5: env.sh present and sourced
if [ -f "$UNMUZZLED_HOME/env.sh" ]; then
    pass "env.sh present"
else
    fail "env.sh missing — run bootstrap.sh"
fi

# --- CHECK 6: provider probes (only if creds present)
PROVIDER_ENV="$HOME/.hermes/.env"
if [ -f "$PROVIDER_ENV" ]; then
    # shellcheck disable=SC1090
    set +u; . "$PROVIDER_ENV"; set -u
fi

probe_url() {
    local name="$1" url="$2" key="${3:-}"
    if [ -z "$key" ]; then
        warn "$name: no key in env; skip probe"
        return
    fi
    local code
    code="$(curl -sS -o /dev/null -w '%{http_code}' --max-time 10 \
             -H "Authorization: Bearer $key" "$url" || printf '000\n')"
    case "$code" in
        200|401|403) pass "$name reachable (http $code)" ;;
        000)         warn "$name unreachable (network)" ;;
        *)           warn "$name http $code" ;;
    esac
}

info "provider probes ..."
probe_url "openrouter" "https://openrouter.ai/api/v1/models" "${OPENROUTER_API_KEY:-}"
probe_url "deepseek"   "https://api.deepseek.com/v1/models"  "${DEEPSEEK_API_KEY:-}"

# Local providers
if command -v ollama >/dev/null 2>&1; then
    if ollama list >/dev/null 2>&1; then
        pass "ollama daemon reachable"
    else
        warn "ollama installed but not running"
    fi
else
    info "ollama not installed (optional)"
fi

# --- REPORT
printf '\n%s==== SUMMARY ====%s\n' "$C_B" "$C_0"
printf 'fails: %s%d%s   warns: %s%d%s   log: %s\n' \
    "$C_R" "$FAILS" "$C_0" "$C_Y" "$WARNS" "$C_0" "$LOG_FILE"

if [ "$FAILS" -gt 0 ]; then
    exit 1
fi
exit 0
