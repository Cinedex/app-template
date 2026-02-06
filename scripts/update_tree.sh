#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
todo_file="$root/TODO.md"
tree_file="$root/TREE.md"

ensure_active_todo() {
  local count
  count=$(grep -c '^## TODO-' "$todo_file" || true)
  if [ "$count" -ne 1 ]; then
    echo "ERROR: expected 1 active TODO entry in TODO.md but found $count" >&2
    exit 1
  fi
}

ensure_active_todo
{
  cat <<'EOT'
# Workspace Tree

This tree summarizes the current control documents and must be updated whenever a new file is introduced.

## Directories
EOT
  find "$root" -mindepth 1 -type d -not -path '*/.git*' | sort | while IFS= read -r dir; do
    rel=${dir#"$root/"}
    printf -- '- `%s/`\n' "$rel"
  done
  cat <<'EOT'

## Files
EOT
  find "$root" -type f -not -path '*/.git*' | sort | while IFS= read -r file; do
    rel=${file#"$root/"}
    printf -- '- `%s`\n' "$rel"
  done
  cat <<'EOT'

## Update rule
- Run this script whenever a new file or folder is introduced so the workspace tree stays accurate before a commit.
- The automation also asserts that `TODO.md` contains one active TODO, keeping the workflow deterministic.
EOT
} > "$tree_file"
