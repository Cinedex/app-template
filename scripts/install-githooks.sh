#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
hooks_dir="$root/.githooks"

mkdir -p "$hooks_dir"

missing=()
for hook in pre-commit pre-push; do
  hook_path="$hooks_dir/$hook"
  if [ ! -f "$hook_path" ]; then
    missing+=("$hook")
    continue
  fi
  chmod +x "$hook_path"
done

if [ ${#missing[@]} -gt 0 ]; then
  printf "ERROR: missing hook(s): %s\n" "${missing[*]}" >&2
  exit 1
fi

git config core.hooksPath "$hooks_dir"
printf "installed hooks at %s\n" "$hooks_dir"
