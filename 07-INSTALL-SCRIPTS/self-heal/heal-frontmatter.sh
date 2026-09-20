#!/usr/bin/env bash
# UNMUZZLED-AI :: heal-frontmatter
# Scan framework for .md files missing sovereign:true; add where safe
# (files already carrying valid YAML frontmatter). Backup, then report
# files needing manual review (no frontmatter at all).
set -euo pipefail

UNMUZZLED_ROOT="${UNMUZZLED_ROOT:-/home/dirt/UNMUZZLED-AI}"
UNMUZZLED_HOME="${UNMUZZLED_HOME:-$HOME/.unmuzzled}"
TS="$(date -u +%Y%m%dT%H%M%SZ)"
LOG_DIR="$UNMUZZLED_HOME/logs"
BAK_DIR="$UNMUZZLED_HOME/backups/heal-frontmatter-$TS"
mkdir -p "$LOG_DIR" "$BAK_DIR"
LOG_FILE="$LOG_DIR/heal-frontmatter-$TS.log"
exec > >(tee -a "$LOG_FILE") 2>&1

log() { printf '[%s] %s\n' "$(date -u +%H:%M:%SZ)" "$*"; }

DRY_RUN=1
while [ $# -gt 0 ]; do
    case "$1" in
        --apply) DRY_RUN=0; shift ;;
        --dry-run) DRY_RUN=1; shift ;;
        -h|--help)
            cat <<'EOF'
usage: heal-frontmatter.sh [--dry-run|--apply]
Default is --dry-run. Backups go under ~/.unmuzzled/backups/heal-frontmatter-<ts>/.
EOF
            exit 0 ;;
        *) log "unknown arg: $1"; exit 2 ;;
    esac
done

log "root=$UNMUZZLED_ROOT dry_run=$DRY_RUN backup=$BAK_DIR"

MANUAL_LIST="$LOG_DIR/heal-frontmatter-$TS.manual.txt"
FIXED=0
MANUAL=0
OK=0
TOTAL=0

while IFS= read -r -d '' md; do
    TOTAL=$((TOTAL+1))
    first="$(head -n 1 "$md" || true)"
    head_block="$(head -n 30 "$md")"
    if [ "$first" != "---" ]; then
        printf '%s\n' "$md" >> "$MANUAL_LIST"
        MANUAL=$((MANUAL+1))
        continue
    fi
    if printf '%s' "$head_block" | grep -qi '^sovereign:[[:space:]]*true'; then
        OK=$((OK+1))
        continue
    fi
    if printf '%s' "$head_block" | grep -qi '^sovereign:[[:space:]]*false'; then
        OK=$((OK+1))
        continue
    fi
    # Frontmatter exists but no sovereign key — insert it after the opening ---
    if [ "$DRY_RUN" -eq 1 ]; then
        log "WOULD FIX: $md"
        FIXED=$((FIXED+1))
        continue
    fi
    rel="${md#$UNMUZZLED_ROOT/}"
    bak="$BAK_DIR/$rel"
    mkdir -p "$(dirname "$bak")"
    cp -p "$md" "$bak"
    tmp="$(mktemp)"
    awk 'NR==1 && $0=="---" {print; print "sovereign: true"; next} {print}' "$md" > "$tmp"
    mv -f "$tmp" "$md"
    log "FIXED:     $md"
    FIXED=$((FIXED+1))
done < <(find "$UNMUZZLED_ROOT" -type f -name '*.md' ! -path '*/99-ARCHIVE-SEEDS/*' -print0)

log "scanned=$TOTAL ok=$OK fixed=$FIXED manual_review=$MANUAL"
if [ "$MANUAL" -gt 0 ]; then
    log "manual review list -> $MANUAL_LIST"
fi
[ "$DRY_RUN" -eq 1 ] && log "dry-run: no files modified. re-run with --apply."
exit 0
