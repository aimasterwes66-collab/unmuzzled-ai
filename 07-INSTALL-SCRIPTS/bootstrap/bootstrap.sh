#!/usr/bin/env bash
# UNMUZZLED-AI :: bootstrap
# One-shot idempotent setup for the sovereign framework.
set -euo pipefail

UNMUZZLED_ROOT="${UNMUZZLED_ROOT:-/home/dirt/UNMUZZLED-AI}"
UNMUZZLED_HOME="${UNMUZZLED_HOME:-$HOME/.unmuzzled}"
TS="$(date -u +%Y%m%dT%H%M%SZ)"
LOG_DIR="$UNMUZZLED_HOME/logs"
LOG_FILE="$LOG_DIR/install-bootstrap-$TS.log"

mkdir -p "$UNMUZZLED_HOME" "$LOG_DIR" \
         "$UNMUZZLED_HOME/state" \
         "$UNMUZZLED_HOME/cache" \
         "$UNMUZZLED_HOME/bin" \
         "$UNMUZZLED_HOME/personas" \
         "$UNMUZZLED_HOME/providers" \
         "$UNMUZZLED_HOME/harnesses"

exec > >(tee -a "$LOG_FILE") 2>&1

log() { printf '[%s] %s\n' "$(date -u +%H:%M:%SZ)" "$*"; }

detect_os() {
    if [ -n "${PREFIX:-}" ] && [ -d "$PREFIX/bin" ] && [[ "$PREFIX" == *com.termux* ]]; then
        printf 'termux\n'
    elif [ "$(uname -s)" = "Darwin" ]; then
        printf 'macos\n'
    elif [ "$(uname -s)" = "Linux" ]; then
        if [ -f /etc/nixos/configuration.nix ]; then
            printf 'nixos\n'
        else
            printf 'linux\n'
        fi
    else
        printf 'unknown\n'
    fi
}

OS="$(detect_os)"
log "OS=$OS root=$UNMUZZLED_ROOT home=$UNMUZZLED_HOME"

if [ ! -d "$UNMUZZLED_ROOT" ]; then
    log "ERROR: UNMUZZLED_ROOT missing: $UNMUZZLED_ROOT"
    exit 2
fi

DOCTRINE="$UNMUZZLED_ROOT/00-DOCTRINE"
for f in LAWS.md MAXIMUM-ADVERSARIAL-POSTURE.md FRONTMATTER-SPEC.md; do
    if [ ! -f "$DOCTRINE/$f" ]; then
        log "ERROR: doctrine missing: $DOCTRINE/$f"
        exit 3
    fi
done

# Pin doctrine hashes for later verification by doctor.sh
PIN_FILE="$UNMUZZLED_HOME/state/doctrine.pins"
: > "$PIN_FILE.new"
for f in LAWS.md MAXIMUM-ADVERSARIAL-POSTURE.md FRONTMATTER-SPEC.md; do
    sha="$(sha256sum "$DOCTRINE/$f" | awk '{print $1}')"
    printf '%s  %s\n' "$sha" "$f" >> "$PIN_FILE.new"
done
mv -f "$PIN_FILE.new" "$PIN_FILE"
log "doctrine pinned -> $PIN_FILE"

# Symlink doctrine into ~/.unmuzzled for portable sourcing
ln -sfn "$UNMUZZLED_ROOT" "$UNMUZZLED_HOME/framework"
ln -sfn "$UNMUZZLED_ROOT/00-DOCTRINE" "$UNMUZZLED_HOME/doctrine"
ln -sfn "$UNMUZZLED_ROOT/01-SYSTEM-PROMPTS" "$UNMUZZLED_HOME/system-prompts"
ln -sfn "$UNMUZZLED_ROOT/02-PERSONAS" "$UNMUZZLED_HOME/personas-lib"

# env stanza — idempotent (fenced block)
ENV_FILE="$UNMUZZLED_HOME/env.sh"
cat > "$ENV_FILE" <<'EOF'
# UNMUZZLED-AI env — sourced by shells, harnesses, hooks.
export UNMUZZLED_ROOT="${UNMUZZLED_ROOT:-/home/dirt/UNMUZZLED-AI}"
export UNMUZZLED_HOME="${UNMUZZLED_HOME:-$HOME/.unmuzzled}"
export UNMUZZLED_DOCTRINE="$UNMUZZLED_HOME/doctrine"
export UNMUZZLED_LAWS="$UNMUZZLED_DOCTRINE/LAWS.md"
export UNMUZZLED_POSTURE="$UNMUZZLED_DOCTRINE/MAXIMUM-ADVERSARIAL-POSTURE.md"
export UNMUZZLED_ACTIVE_PERSONA_FILE="$UNMUZZLED_HOME/state/ACTIVE_PERSONA"
export PATH="$UNMUZZLED_HOME/bin:$PATH"
EOF
log "wrote $ENV_FILE"

# PATH wiring via shell rc — fenced, idempotent
wire_rc() {
    local rc="$1"
    [ -f "$rc" ] || touch "$rc"
    if ! grep -q 'UNMUZZLED-AI-BEGIN' "$rc" 2>/dev/null; then
        cat >> "$rc" <<'EOF'
# UNMUZZLED-AI-BEGIN
[ -f "$HOME/.unmuzzled/env.sh" ] && . "$HOME/.unmuzzled/env.sh"
# UNMUZZLED-AI-END
EOF
        log "wired $rc"
    else
        log "rc already wired: $rc"
    fi
}

case "$OS" in
    termux)   wire_rc "$HOME/.bashrc" ;;
    macos)    wire_rc "$HOME/.zshrc"; wire_rc "$HOME/.bashrc" ;;
    linux|nixos) wire_rc "$HOME/.bashrc"; [ -f "$HOME/.zshrc" ] && wire_rc "$HOME/.zshrc" ;;
    *) log "OS unknown; wiring .bashrc only"; wire_rc "$HOME/.bashrc" ;;
esac

# Write bootstrap manifest
MANIFEST="$UNMUZZLED_HOME/state/bootstrap.manifest"
{
    printf 'timestamp=%s\n' "$TS"
    printf 'os=%s\n' "$OS"
    printf 'root=%s\n' "$UNMUZZLED_ROOT"
    printf 'home=%s\n' "$UNMUZZLED_HOME"
    printf 'version=%s\n' "$(cat "$UNMUZZLED_ROOT/VERSION" 2>/dev/null || echo 0.0.0)"
} > "$MANIFEST"
log "manifest -> $MANIFEST"

cat <<EOF

UNMUZZLED-AI bootstrap complete.

  root:     $UNMUZZLED_ROOT
  home:     $UNMUZZLED_HOME
  os:       $OS
  log:      $LOG_FILE

Next steps:
  1. exec \$SHELL -l   # reload PATH
  2. $UNMUZZLED_ROOT/07-INSTALL-SCRIPTS/self-heal/doctor.sh
  3. Pick a harness:
       $UNMUZZLED_ROOT/07-INSTALL-SCRIPTS/per-harness/claude-code.sh
       $UNMUZZLED_ROOT/07-INSTALL-SCRIPTS/per-harness/opencode.sh
       $UNMUZZLED_ROOT/07-INSTALL-SCRIPTS/per-harness/ollama.sh
       $UNMUZZLED_ROOT/07-INSTALL-SCRIPTS/per-harness/lmstudio.sh
  4. Wire providers:
       $UNMUZZLED_ROOT/07-INSTALL-SCRIPTS/per-provider/openrouter.sh
EOF

exit 0
