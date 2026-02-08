#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
branch_file="$root/git/branches.md"
todo_file="$root/TODO.md"

active_todo_line="$(awk '/^## Active TODO$/,/^## Future Implementation/' "$todo_file" | grep -m1 '^## TODO-' || true)"
active_todo_label="${active_todo_line#?? }"

status_porcelain="$(git -C "$root" status --porcelain)"
ahead_line="$(git -C "$root" status -sb | head -n1 | sed 's/^## //')"
if [ -z "$ahead_line" ]; then
  ahead_line="Unknown (detached head or missing remote)"
fi
clean_state="Clean"
merge_ready="yes (clean working tree)"
if [ -n "$status_porcelain" ]; then
  clean_state="Dirty ($(echo "$status_porcelain" | wc -l | tr -d '[:space:]') change(s))"
  merge_ready="no (working tree has staged/unstaged changes)"
fi

stale_branches=()
while IFS= read -r entry; do
  stale_branches+=("$entry")
done < <(git -C "$root" for-each-ref --format='%(refname:short)|%(upstream:track)' refs/heads | awk -F'|' '
{
  if ($2 == "") {
    print $1 " (no upstream)"
  } else if ($2 ~ /gone/) {
    print $1 " (upstream gone)"
  } else if ($2 ~ /behind [1-9]/) {
    print $1 " (behind upstream)"
  }
}')

branch_inventory="$(git -C "$root" for-each-ref --sort=-committerdate --format="* %(refname:short) — %(authorname) — %(authordate:short) — %(subject)" refs/heads | head -n 10)"
recent_commits="$branch_inventory"

{
  printf "# Git Branch Log\n\n"
  printf "**Last updated:** %s UTC\n\n" "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  printf "## Active TODO\n\n"
  if [ -n "$active_todo_label" ]; then
    printf "%s\n\n" "$active_todo_label"
  else
    printf "_No active TODO found_\n\n"
  fi
  printf "## Status snapshot\n\n"
  printf -- "- Clean state: %s\n" "$clean_state"
  printf -- "- Ahead/Behind vs origin: %s\n" "$ahead_line"
  printf -- "- Merge readiness: %s\n\n" "$merge_ready"
  printf "## Stale branches\n\n"
  if [ "${#stale_branches[@]}" -eq 0 ]; then
    printf "_None – all branches track healthy remotes._\n\n"
  else
    for branch in "${stale_branches[@]}"; do
      printf -- "- %s\n" "$branch"
    done
    printf "\n"
  fi
  printf "## Branch inventory (recent)\n\n"
  printf "%s\n\n" "$branch_inventory"
  printf "## Recent commits (per branch tip)\n\n"
  git -C "$root" for-each-ref --sort=-committerdate --format="* %(refname:short) — %(authorname) — %(authordate:short) — %(subject)" refs/heads | head -n 10
} > "$branch_file"
