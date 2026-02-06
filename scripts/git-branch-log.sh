#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
branch_file="$root/git/branches.md"

{
  printf "# Git Branch Log\n\n"
  printf "**Last updated:** %s UTC\n\n" "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  printf "## Active TODO\n\n"
  if [ -f "$root/TODO.md" ]; then
    active=$(grep '^## TODO-' "$root/TODO.md" | head -n 1 || true)
    if [ -n "$active" ]; then
      printf "%s\n\n" "$active"
    else
      printf "_No active TODO found_\n\n"
    fi
  else
    printf "_TODO.md missing_\n\n"
  fi
  printf "## Status snapshot\n\n"
  git status -sb
  printf "\n## Branch inventory\n\n"
  git branch -av
  printf "\n## Recent commits (per branch tip)\n\n"
  git for-each-ref --sort=-committerdate --format="* %(refname:short) — %(authorname) — %(authordate:short) — %(subject)" refs/heads | head -n 10
} > "$branch_file"
