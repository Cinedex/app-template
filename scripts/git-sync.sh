#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
canonical_branch="master"
todo_file="$root/TODO.md"
version_file="$root/VERSION.md"
version_note="Audit Service + Git automation hardening (pre-clean reconciliation)"

get_active_todo_header() {
  awk '/^## Active TODO$/,/^## Future Implementation/' "$todo_file" | grep -m1 '^## TODO-' || true
}

fatal() {
  printf "ERROR: %s\n" "$1" >&2
  exit 1
}

extract_todo_id() {
  printf "%s" "$1" | sed -E 's/^## (TODO-[0-9]+).*/\1/'
}

ensure_active_todo() {
  local header
  header="$(get_active_todo_header)"
  if [ -z "$header" ]; then
    fatal "No active TODO is defined. Git automation requires an active TODO."
  fi
  local todo_id
  todo_id="$(extract_todo_id "$header")"
  if [ "$todo_id" = "TODO-000" ]; then
    fatal "TODO-000 is idle; activate a real TODO before committing."
  fi
  printf "%s" "$header"
}

bump_version() {
  export ROOT="$root"
  export ACTIVE_TODO_HEADER="$active_todo_header"
  export VERSION_NOTE="$version_note"
  python3 <<'PY'
from pathlib import Path
import datetime, os, re, sys

root = Path(os.environ["ROOT"])
version_file = root / "VERSION.md"
text = version_file.read_text()

def replace_line(label, value, text):
    pattern = rf"(- \*\*{re.escape(label)}:\*\*\s*)(.*)"
    def repl(match):
        return match.group(1) + value
    new_text, count = re.subn(pattern, repl, text, count=1)
    if count != 1:
        print(f"Failed to replace {label}", file=sys.stderr)
        sys.exit(1)
    return new_text

current_match = re.search(r"- \*\*Current Version:\*\*\s*([0-9.]+)", text)
full_match = re.search(r"- \*\*Full Version:\*\*\s*([0-9.]+)", text)
if not (current_match and full_match):
    print("VERSION.md lacks required Current/Full Version lines", file=sys.stderr)
    sys.exit(1)

current_version = current_match.group(1)
old_full_version = full_match.group(1)
old_patch = old_full_version.split(".")[-1]
new_patch = str(int(old_patch) + 1)
full_version_new = ".".join(current_version.split(".")[:3] + [new_patch])
timestamp = datetime.datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%SZ")
todo_header = os.environ["ACTIVE_TODO_HEADER"]
note = os.environ["VERSION_NOTE"]

text = replace_line("Full Version", full_version_new, text)
text = replace_line("Previous Version", current_version, text)
text = replace_line("Bump Type", "Patch", text)
text = replace_line("Triggering TODO", todo_header, text)
text = replace_line("Bumped By", todo_header, text)
text = replace_line("Created At", timestamp, text)
text = replace_line("Compatibility Notes", note, text)
text = re.sub(r"(- \*\*Compatibility Notes:\*\*.*)",
              rf"\1\n- **Notes:** {note}", text, count=1)

text = replace_line("Previous version", old_full_version, text)
text = replace_line("New version", full_version_new, text)
text = replace_line("Bump type", "Patch", text)
text = replace_line("Triggering TODO", todo_header, text)
text = replace_line("Compatibility notes", note, text)

text = re.sub(r"(- \*\*Compatibility notes:\*\*.*)",
              rf"\1\n- **Patch string:** {full_version_new}", text, count=1)

text = re.sub(r"- \*\*Platform Version:\*\*.*",
              f"- **Platform Version:** {full_version_new} "
              f"(MAJOR={current_version.split('.')[0]}, "
              f"MINOR={current_version.split('.')[1]}, "
              f"MICRO={current_version.split('.')[2]}, "
              f"PATCH={new_patch})", text, count=1)

version_file.write_text(text)
PY
  unset ROOT ACTIVE_TODO_HEADER VERSION_NOTE
}

ensure_version_bump() {
  if git diff --quiet HEAD -- "$version_file"; then
    bump_version
  else
    local bumped_by
    bumped_by="$(grep -m1 -F "**Bumped By:**" "$version_file" | sed -E 's/.*\*\*Bumped By:\*\* //')"
    if [[ "$bumped_by" != *"$active_todo_id"* ]]; then
      fatal "Existing VERSION.md change does not reference $active_todo_id."
    fi
  fi
}

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
active_todo_header_raw="$(ensure_active_todo)"
active_todo_id="$(extract_todo_id "$active_todo_header_raw")"
active_todo_title="$(printf "%s" "$active_todo_header_raw" | sed -E 's/^## //')"
active_todo_header="$active_todo_title"
if [[ "$message" != *"$active_todo_id"* ]]; then
  fatal "Commit message must include the active TODO $active_todo_id."
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

ensure_version_bump
git add -A

"$root/scripts/verify-roadmap-sync.sh"
"$root/scripts/verify-version-sync.sh"

if git diff --cached --quiet -- "$version_file"; then
  fatal "VERSION.md must change and include the patch metadata before committing."
fi

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
"$root/scripts/process-integrity-sweep.sh"
