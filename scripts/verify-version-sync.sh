#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
version_file="$root/VERSION.md"
roadmap_file="$root/ROADMAP.md"
complete_file="$root/TODO.complete.md"
merge_reports_dir="$root/git/merge-reports"
error_log="$root/scripts/logs/error-incidents.md"
todo_file="$root/TODO.md"
active_todo_id="$(awk '/^## Active TODO$/,/^## Future Implementation/' "$todo_file" | grep -m1 '^## TODO-' | sed -E 's/^## (TODO-[0-9]+).*/\1/' || true)"

log_incident() {
  local description="$1"
  local remediation="$2"
  local files="$3"
  local version_current
  version_current="$(grep -m1 -F "**Current Version:**" "$version_file" 2>/dev/null || true)"
  version_current="${version_current#*- **Current Version:** }"
  {
    printf "\n1. **Date (UTC):** %s\n" "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
    printf "2. **Version:** %s\n" "${version_current:-unknown}"
    printf "3. **Service/App:** Version Sync Gate\n"
    printf "4. **Description:** %s\n" "$description"
    printf "5. **TODO reference:** %s\n" "${active_todo_id:-$todo_ref}"
    printf "6. **Remediation:** %s\n" "$remediation"
    printf "7. **Affected files:** %s\n" "$files"
    printf "8. **Automation/log pointer:** scripts/verify-roadmap-sync.sh, scripts/verify-version-sync.sh\n"
  } >> "$error_log"
}

fail_version_sync() {
  local message="$1"
  local remediation="$2"
  local files="$3"
  log_incident "$message" "$remediation" "$files"
  printf "VERSION SYNC GATE FAILED: %s\n" "$message" >&2
  exit 1
}

if [ ! -f "$version_file" ]; then
  fail_version_sync "VERSION.md is missing." \
                    "Create VERSION.md with Current/Previous/Bumped By entries." \
                    "$version_file"
fi

current_version="$(grep -m1 -F "**Current Version:**" "$version_file" || true)"
previous_version="$(grep -m1 -F "**Previous Version:**" "$version_file" || true)"
bumped_by="$(grep -m1 -F "**Bumped By:**" "$version_file" || true)"

current_version="${current_version#*- **Current Version:** }"
previous_version="${previous_version#*- **Previous Version:** }"
bumped_by="${bumped_by#*- **Bumped By:** }"

[ -n "$current_version" ] || fail_version_sync "Current Version missing from VERSION.md." \
                                           "Add the Current Version line before closing the gate." \
                                           "$version_file"
[ -n "$previous_version" ] || fail_version_sync "Previous Version missing from VERSION.md." \
                                            "Add the Previous Version line before closing the gate." \
                                            "$version_file"
[ -n "$bumped_by" ] || fail_version_sync "Bumped By metadata missing from VERSION.md." \
                                       "List the TODO that bumped the version (e.g., TODO-060)." \
                                       "$version_file"

if [ ! -d "$merge_reports_dir" ]; then
  fail_version_sync "Merge reports directory is missing." \
                    "Ensure git/merge-reports/ exists before running the gate." \
                    "$merge_reports_dir"
fi

latest_report="$(ls -1 "$merge_reports_dir"/merge-report-*.md 2>/dev/null | sort | tail -n 1 || true)"
if [ -z "$latest_report" ]; then
  fail_version_sync "No merge report found in git/merge-reports/." \
                    "Run scripts/git-merge-report.sh so a report references VERSION.md." \
                    "$merge_reports_dir"
fi

if ! grep -qF "Version artifact: $root/VERSION.md" "$latest_report"; then
  fail_version_sync "Merge report $latest_report does not reference VERSION.md." \
                    "Re-run scripts/git-merge-report.sh to capture the version artifact." \
                    "$latest_report"
fi

if ! grep -qF "* Current version: $current_version" "$latest_report"; then
  fail_version_sync "Merge report $latest_report lists a different current version." \
                    "Regenerate the merge report after updating VERSION.md." \
                    "$latest_report, $version_file"
fi

if ! grep -qF "* Bumped by: $bumped_by" "$latest_report"; then
  fail_version_sync "Merge report $latest_report omits the Bumped By TODO." \
                    "Include the bumped TODO reference when rerunning scripts/git-merge-report.sh." \
                    "$latest_report"
fi

if ! grep -qF "$bumped_by" "$roadmap_file" && ! grep -qF "$bumped_by" "$complete_file"; then
  fail_version_sync "Neither ROADMAP.md nor TODO.complete.md references $bumped_by." \
                    "Document $bumped_by in the roadmap/completed log so the version bump is traceable." \
                    "$roadmap_file, $complete_file"
fi

printf "Version sync gate PASSED: %s tracked in VERSION.md and %s.\n" "$current_version" "$bumped_by"
