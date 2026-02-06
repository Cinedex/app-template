#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
todo_file="$root/TODO.md"
roadmap_file="$root/ROADMAP.md"
queue_file="$root/queue.md"
complete_file="$root/TODO.complete.md"
error_log="$root/scripts/logs/error-incidents.md"

extract_active_todo() {
  awk '/^## Active TODO$/,/^## Future Implementation/' "$todo_file" | grep -m1 '^## TODO-' || true
}

extract_latest_completed() {
  grep -m1 '^## TODO-[0-9]\+' "$complete_file" || true
}

log_incident() {
  local description="$1"
  local remediation="$2"
  local files="$3"
  local todo_ref="$4"
  local version_line
  version_line="$(grep -m1 -F "**Current Version:**" "$root/VERSION.md" 2>/dev/null || true)"
  local version_val="${version_line#*- **Current Version:** }"
  {
    printf "\n1. **Date (UTC):** %s\n" "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
    printf "2. **Version:** %s\n" "${version_val:-unknown}"
    printf "3. **Service/App:** Roadmap Sync Gate\n"
    printf "4. **Description:** %s\n" "$description"
    printf "5. **TODO reference:** %s\n" "$todo_ref"
    printf "6. **Remediation:** %s\n" "$remediation"
    printf "7. **Affected files:** %s\n" "$files"
    printf "8. **Automation/log pointer:** scripts/verify-roadmap-sync.sh\n"
  } >> "$error_log"
}

fail_sync() {
  local message="$1"
  local remediation="$2"
  local files="$3"
  local todo_ref="$4"
  log_incident "$message" "$remediation" "$files" "$todo_ref"
  printf "ROADMAP SYNC GATE FAILED: %s\n" "$message" >&2
  exit 1
}

active_header="$(extract_active_todo)"
active_todo="$(printf "%s" "$active_header" | sed -E 's/^## (TODO-[0-9]+).*/\1/')"
active_count="$(awk '/^## Active TODO$/,/^## Future Implementation/' "$todo_file" | grep -c '^## TODO-' || true)"
if [ -z "$active_header" ]; then
  fail_sync "Active TODO section lacks a TODO header." \
            "Ensure TODO.md lists one active TODO header under ## Active TODO." \
            "$todo_file" "TODO-065"
fi
if [ "$active_count" -ne 1 ]; then
  fail_sync "Active TODO section must contain exactly one TODO header (found $active_count)." \
            "Remove extra headers so TODO.md keeps a single active TODO." \
            "$todo_file" "$active_todo"
fi

completed_header="$(extract_latest_completed)"
if [ -z "$completed_header" ]; then
  fail_sync "TODO.complete.md lacks a completed TODO header." \
            "Record at least one completed TODO before closing the gate." \
            "$complete_file" "$active_todo"
fi
latest_completed="$(printf "%s" "$completed_header" | sed -E 's/^## (TODO-[0-9]+).*/\1/')"

roadmap_active="$(awk '/^### Active TODO$/,/^### Completed TODOs/' "$roadmap_file")"
if ! printf "%s" "$roadmap_active" | grep -qF "**$active_todo**"; then
  fail_sync "$roadmap_file Active section does not list $active_todo." \
            "Update ROADMAP.md so the Active TODO section references $active_todo." \
            "$roadmap_file" "$active_todo"
fi
if ! printf "%s" "$roadmap_active" | grep -qF "Status: <span style=\"color:green\">Active</span>"; then
  fail_sync "$roadmap_file does not mark $active_todo as active." \
            "Set the status line to Active for $active_todo in ROADMAP.md." \
            "$roadmap_file" "$active_todo"
fi

roadmap_completed="$(awk '/^### Completed TODOs/ {flag=1} flag {print}' "$roadmap_file" || true)"
if ! printf "%s" "$roadmap_completed" | grep -qF "**$latest_completed**"; then
  fail_sync "$roadmap_file Completed section lacks $latest_completed." \
            "Mark $latest_completed as completed in ROADMAP.md before closing the gate." \
            "$roadmap_file" "$active_todo"
fi

if grep -qF "$active_todo" "$queue_file"; then
  fail_sync "queue.md contains the active TODO $active_todo." \
            "Remove $active_todo from queue.md so it stays future-only." \
            "$queue_file" "$active_todo"
fi
if grep -qF "$latest_completed" "$queue_file"; then
  fail_sync "queue.md lists the completed TODO $latest_completed." \
            "Keep queue.md future-only and remove $latest_completed." \
            "$queue_file" "$active_todo"
fi

printf "Roadmap sync gate PASSED: active=%s completed=%s\n" "$active_todo" "$latest_completed"
