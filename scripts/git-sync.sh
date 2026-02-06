#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
canonical_branch="master"

# Install hooks before any git command.
bash "$root/scripts/install-githooks.sh"

usage() {
  cat <<'EOF'
Usage: git-sync.sh -m "commit message" [-b branch-name]
  -m message    Commit message (required)
  -b branch     Create or switch to this branch (optional; defaults to current branch)
EOF
  exit 1
}

branch=""
message=""

while getopts "b:m:" opt; do
  case $opt in
    b) branch=$OPTARG ;;
    m) message=$OPTARG ;;
    *) usage ;;
  esac
done

if [ -z "$message" ]; then
  echo "ERROR: commit message (-m) is required."
  usage
fi
if git rev-parse --abbrev-ref HEAD >/dev/null 2>&1; then
  current_branch=$(git rev-parse --abbrev-ref HEAD)
else
  current_branch="$canonical_branch"
fi
update_canonical_branch() {
  git fetch origin "$canonical_branch" >/dev/null 2>&1 || true
  if git show-ref --verify --quiet "refs/heads/$canonical_branch"; then
    git checkout "$canonical_branch"
    git pull --ff-only origin "$canonical_branch" >/dev/null 2>&1 || true
  elif git show-ref --verify --quiet "refs/remotes/origin/$canonical_branch"; then
    git checkout -b "$canonical_branch" "origin/$canonical_branch"
  else
    git checkout -b "$canonical_branch"
  fi
  if [ "$current_branch" != "$canonical_branch" ]; then
    git checkout "$current_branch"
  fi
}
update_canonical_branch
target_branch="${branch:-$current_branch}"

if [ "$target_branch" != "$current_branch" ]; then
  if git show-ref --verify --quiet "refs/heads/$target_branch"; then
    git checkout "$target_branch"
  else
    git checkout -b "$target_branch"
  fi
fi

git add -A

if git diff --cached --quiet; then
  echo "No staged changes to commit."
else
  git commit -m "$message"
fi

if git remote | grep -q '^origin$'; then
  git push --set-upstream origin "$target_branch"
else
  echo "WARNING: remote 'origin' missing; skipping push."
fi

"$root/scripts/git-branch-log.sh"
