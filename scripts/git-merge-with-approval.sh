#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
approval_dir="$root/git/approvals/approved"
canonical_branch="master"
todo_file="$root/TODO.md"
error_log="$root/scripts/logs/error-incidents.md"

active_todo_id="$(awk '/^## Active TODO$/,/^## Future Implementation/' "$todo_file" | grep -m1 '^## TODO-' | sed -E 's/^## (TODO-[0-9]+).*/\1/' || true)"

log_conflict_incident() {
  local desc="$1"
  local remediation="$2"
  local branches="$3"
  cat <<EOF >> "$error_log"

- **Date (UTC):** $(date -u +"%Y-%m-%dT%H:%M:%SZ")
- **Description:** $desc
- **TODO reference:** ${active_todo_id:-todo-unknown}
- **Remediation:** $remediation
- **Affected branches:** $branches
- **Automation/log pointer:** scripts/git-merge-with-approval.sh
EOF
}

ensure_conflict_free() {
  if git merge --no-ff --no-commit --no-verify "$source_branch" >/dev/null 2>&1; then
    git merge --abort >/dev/null 2>&1 || true
  else
    git merge --abort >/dev/null 2>&1 || true
    log_conflict_incident "Merge conflict detected between $source_branch and $target_branch." \
      "Resolve conflicts on $target_branch locally, regenerate the approval artifact, and rerun this script." \
      "$target_branch / $source_branch"
    fail_merge "Conflicts detected between $source_branch and $target_branch; review scripts/logs/error-incidents.md."
  fi
}

usage() {
  cat <<'EOF'
Usage: git-merge-with-approval.sh <target-branch> <source-branch>
  target-branch  Must be the canonical merge target (master).
  source-branch  Branch that will be merged into the target.
EOF
  exit 1
}

fail_merge() {
  printf "ERROR: %s\n" "$1" >&2
  exit 1
}

[ $# -lt 2 ] && usage
target_branch="$1"
source_branch="$2"

if [ "$target_branch" != "$canonical_branch" ]; then
  fail_merge "Target branch must be the canonical branch '$canonical_branch'."
fi

if [ -n "$(git status --porcelain)" ]; then
  fail_merge "Working tree must be clean before executing an approval-gated merge."
fi

if ! git show-ref --verify --quiet "refs/heads/$target_branch"; then
  fail_merge "Target branch '$target_branch' is missing locally."
fi

if ! git show-ref --verify --quiet "refs/heads/$source_branch"; then
  fail_merge "Source branch '$source_branch' is missing locally."
fi

git fetch origin "$target_branch" >/dev/null 2>&1 || true
git fetch origin "$source_branch" >/dev/null 2>&1 || true

report_output="$("$root/scripts/git-merge-report.sh" "$target_branch" "$source_branch")"
printf "%s\n" "$report_output"
report_file="$(printf "%s" "$report_output" | awk '/Merge report written to/ {print $NF}')"
if [ -z "$report_file" ]; then
  fail_merge "Merge report generation failed; see previous output."
fi

timestamp="$(basename "$report_file" .md)"
timestamp="${timestamp#merge-report-${target_branch}-}"
artifact="${approval_dir}/${timestamp}-${target_branch}-${source_branch}.approved"

mkdir -p "$approval_dir"

if [ ! -f "$artifact" ]; then
  cat <<EOF
Approval required:
Target: $target_branch
Source: $source_branch
Merge report: $report_file
Create approval artifact: $artifact
EOF
  exit 2
fi

target_sha="$(git rev-parse "$target_branch")"
source_sha="$(git rev-parse "$source_branch")"

if ! grep -qF "Target SHA: $target_sha" "$artifact"; then
  fail_merge "Approval artifact does not reference the current target SHA."
fi

if ! grep -qF "Source SHA: $source_sha" "$artifact"; then
  fail_merge "Approval artifact does not reference the current source SHA."
fi

git checkout "$target_branch"
ensure_conflict_free
git merge --no-ff --no-edit "$source_branch"
git push origin "$target_branch"

final_report_output="$("$root/scripts/git-merge-report.sh" "$target_branch" "$source_branch")"
final_report_file="$(printf "%s" "$final_report_output" | awk '/Merge report written to/ {print $NF}')"
if [ -z "$final_report_file" ]; then
  fail_merge "Post-merge report generation failed."
fi

"$root/scripts/git-branch-log.sh"
"$root/scripts/update_tree.sh"
"$root/scripts/process-integrity-sweep.sh"

printf "Merge complete: %s now includes %s.\n" "$target_branch" "$source_branch"
printf "Final merge report: %s\n" "$final_report_file"
