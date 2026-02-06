#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CANONICAL_TARGET_BRANCH="master"
usage() {
  cat <<'EOF'
Usage: git-merge-report.sh [--allow-target] <target-branch> <merge-branch> [<merge-branch> ...]
Generates a markdown merge report for the Git & Branch Tracking worker before any human-approved merge.
EOF
  exit 1
}

if [ $# -lt 2 ]; then
  usage
fi

allow_override=0
if [ "$1" = "--allow-target" ]; then
  allow_override=1
  shift
fi

if [ $# -lt 2 ]; then
  usage
fi

target="$1"
shift
branches=("$@")

if [ "$target" != "$CANONICAL_TARGET_BRANCH" ] && [ "$allow_override" -eq 0 ]; then
  echo "ERROR: target branch '$target' is not the canonical branch '$CANONICAL_TARGET_BRANCH'. Use --allow-target to override." >&2
  exit 1
fi
report_dir="$root/git/merge-reports"
mkdir -p "$report_dir"
timestamp="$(date -u +"%Y%m%dT%H%M%SZ")"
report_file="$report_dir/merge-report-${target}-${timestamp}.md"
version_file="$root/VERSION.md"

extract_value() {
  local label="$1"
  if [ ! -f "$version_file" ]; then
    return 0
  fi
  local raw
  raw=$(grep -m1 -F "**${label}:**" "$version_file" 2>/dev/null || true)
  if [ -n "$raw" ]; then
    printf "%s\n" "$raw" | sed -E "s/^[[:space:]-]*\\*\\*${label}:\\*\\* //"
  fi
}

current_version="$(extract_value "Current Version")"
previous_version="$(extract_value "Previous Version")"
bumped_by="$(extract_value "Bumped By")"
created_at="$(extract_value "Created At")"

{
  printf "# Merge Report: %s\n\n" "$target"
  printf "_Generated: %s UTC_\n\n" "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  printf "## Target Branch\n"
  if git show "$target" --no-patch --format="* %h — %s (%an) — %ad\n" > /dev/null 2>&1; then
    git show "$target" --no-patch --format="* %h — %s (%an) — %ad\n"
  else
    printf "* Branch missing or unreachable\n"
  fi
  printf "\n## Merge Candidates\n"

  for branch in "${branches[@]}"; do
    printf "\n### %s\n" "$branch"
    if git show-ref --verify --quiet "refs/heads/$branch"; then
      git log -1 --format="* Last commit: %h — %s (%an) — %ad" --date=short "$branch"
      ahead_behind="$(git rev-list --left-right --count "$target...$branch" 2>/dev/null || true)"
      if [ -n "$ahead_behind" ]; then
        printf "\n* Ahead/Behind (%s...%s): " "$target" "$branch"
        printf "%s\n" "$ahead_behind"
      fi
    else
      printf "* Branch not found locally.\n"
    fi
  done

  printf "\n## Merge Notes\n"
  printf "* Automation script: %s/scripts/git-merge-report.sh\n" "$root"
  printf "* Remote: https://github.com/Cinedex/cinedex.git\n"
  printf "\n## Version Artifact\n"
  if [ -n "$current_version" ]; then
    printf "* Current version: %s\n" "$current_version"
  else
    printf "* Current version: (VERSION.md unavailable)\n"
  fi
  if [ -n "$previous_version" ]; then
    printf "* Previous version: %s\n" "$previous_version"
  fi
  if [ -n "$bumped_by" ]; then
    printf "* Bumped by: %s\n" "$bumped_by"
  fi
  if [ -n "$created_at" ]; then
    printf "* Created at: %s UTC\n" "$created_at"
  fi
  printf "* Version artifact: %s/VERSION.md\n" "$root"
  printf "\n## Governing Laws\n"
  printf "* Merge Reporting Law — documents the artifact so auditors can trace the merge.\n"
  printf "* Merge Audit Law — confirms the merge report is reviewed before automation proceeds.\n"
} > "$report_file"

printf "Merge report written to %s\n" "$report_file"
