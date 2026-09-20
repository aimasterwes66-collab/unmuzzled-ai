#!/usr/bin/env bash
# lint-soul.sh — grep every .md under <dir> for phrases in banned-phrases.txt.
# Exits non-zero on any hit. Idempotent. Case-insensitive.
#
# Usage: lint-soul.sh <directory>
# Example: lint-soul.sh ~/.hermes/personalities/
#          lint-soul.sh ~/UNMUZZLED-AI/02-PERSONAS/

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
PHRASES_FILE="${SCRIPT_DIR}/banned-phrases.txt"

if [[ $# -lt 1 ]]; then
  echo "usage: $(basename "$0") <directory>" >&2
  exit 64
fi

TARGET_DIR="$1"

if [[ ! -d "$TARGET_DIR" ]]; then
  echo "error: not a directory: $TARGET_DIR" >&2
  exit 66
fi

if [[ ! -f "$PHRASES_FILE" ]]; then
  echo "error: phrases file missing: $PHRASES_FILE" >&2
  exit 66
fi

HITS=0
HIT_LOG="$(mktemp)"
trap 'rm -f "$HIT_LOG"' EXIT

# Read phrases, skip empty lines, trim CR
while IFS= read -r phrase || [[ -n "$phrase" ]]; do
  phrase="${phrase%$'\r'}"
  [[ -z "$phrase" ]] && continue

  # Case-insensitive, fixed-string, recursive over .md files only.
  # grep exits 1 on no-match; we don't want set -e to trip.
  if grep -rniIF --include='*.md' -- "$phrase" "$TARGET_DIR" >> "$HIT_LOG" 2>/dev/null; then
    HITS=$((HITS + 1))
  fi
done < "$PHRASES_FILE"

if [[ -s "$HIT_LOG" ]]; then
  echo "SOUL-LINT FAIL — banned phrases detected:" >&2
  cat "$HIT_LOG" >&2
  COUNT=$(wc -l < "$HIT_LOG")
  echo "" >&2
  echo "total banned-phrase hits: $COUNT across scan of: $TARGET_DIR" >&2
  exit 1
fi

echo "SOUL-LINT PASS — no banned phrases in: $TARGET_DIR"
exit 0
