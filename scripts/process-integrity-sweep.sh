#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
log_file="$root/scripts/logs/process-integrity.md"
error_log="$root/scripts/logs/error-incidents.md"
steps=(
  "scripts/verify-roadmap-sync.sh"
  "scripts/verify-version-sync.sh"
  "scripts/update_tree.sh"
  "scripts/git-branch-log.sh"
)
current_step=""
steps_ran=()

log_process_entry() {
  local status="$1"
  local note="$2"
  local timestamp
  timestamp="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  local step_list
  step_list="$(IFS=", "; echo "${steps_ran[*]}")"
  {
    printf "\n## %s - %s\n" "$timestamp" "$status"
    printf '%s\n' "- Steps: $step_list"
    printf '%s\n' "- Notes: $note"
    printf '%s\n' "- Incident log: scripts/logs/error-incidents.md"
  } >> "$log_file"
}

log_missing_version_gate() {
  cat <<EOF >> "$error_log"

- **Date (UTC):** $(date -u +"%Y-%m-%dT%H:%M:%SZ")
- **Version:** $(grep -m1 -F "**Current Version:**" "$root/VERSION.md" 2>/dev/null || echo "unknown")
- **Service/App:** Process Integrity Sweep
- **Description:** scripts/verify-version-sync.sh is missing while TODO-065 is active.
- **TODO reference:** TODO-065
- **Remediation:** Introduce scripts/verify-version-sync.sh before running the sweep.
- **Affected files:** scripts/verify-version-sync.sh
- **Automation/log pointer:** scripts/process-integrity-sweep.sh
EOF
}

log_queued_enumeration_incident() {
  local todo_number="$1"
  local line_number="$2"
  cat <<EOF >> "$error_log"

- **Date (MST):** $(TZ='America/Phoenix' date +"%Y-%m-%d %H:%M:%S %Z")
- **Description:** ROADMAP.md enumerates queued TODO ${todo_number} (line ${line_number}) outside queue.md.
- **TODO reference:** TODO-066
- **Remediation:** Remove the queued enumeration or point readers at queue.md; rerun scripts/process-integrity-sweep.sh once the backlog is canonical.
- **Laws:** Canonical Artifact Law; Roadmap Sync Law; Process Integrity Law
- **Affected files:** ROADMAP.md
- **Automation/log pointer:** scripts/process-integrity-sweep.sh
EOF
}

get_active_todo_count() {
  awk '/^## Active TODO$/,/^## Future Implementation/' "$root/TODO.md" | grep -c '^## TODO-' || true
}

log_git_ready_incident() {
  local status="$1"
  cat <<EOF >> "$error_log"

- **Date (UTC):** $(date -u +"%Y-%m-%dT%H:%M:%SZ")
- **Description:** Git-Ready Notification triggered; the working tree has pending changes while no TODO is active.
- **TODO reference:** TODO-066
- **Remediation:** Create the human approval artifact before merging and rerun scripts/process-integrity-sweep.sh.
- **Affected files:** $status
- **Automation/log pointer:** scripts/process-integrity-sweep.sh
EOF
}

log_drift_warning() {
  local description="$1"
  local file="$2"
  local expected="$3"
  local actual="$4"
  cat <<EOF >> "$error_log"

- **Date (UTC):** $(date -u +"%Y-%m-%dT%H:%M:%SZ")
- **Description:** $description
- **TODO reference:** TODO-071
- **Remediation:** File a governance TODO to realign the surface with the canonical version.
- **Expected:** $expected
- **Actual:** $actual
- **Affected files:** $file
- **Automation/log pointer:** scripts/process-integrity-sweep.sh
EOF
  printf "WARNING: %s (file=%s, expected=%s, actual=%s)\n" "$description" "$file" "$expected" "$actual"
}

check_surface_drift() {
  local platform_version
  platform_version="$(grep -m1 -F "**Current Version:**" "$root/VERSION.md" || true)"
  platform_version="${platform_version#*- **Current Version:** }"
  local platform_major
  platform_major="$(printf "%s" "$platform_version" | cut -d. -f1)"
  local platform_major_minor
  platform_major_minor="$(printf "%s" "$platform_version" | cut -d. -f1-2)"

  local marketing_file="$root/marketing/status.md"
  if [ -f "$marketing_file" ]; then
    local marketing_platform
    marketing_platform="$(grep -m1 -F "**Platform Version:**" "$marketing_file" || true)"
    marketing_platform="${marketing_platform#*- **Platform Version:** }"
    local marketing_surface
    marketing_surface="$(grep -m1 -F "**Marketing Surface Version:**" "$marketing_file" || true)"
    marketing_surface="${marketing_surface#*- **Marketing Surface Version:** }"

    if [ -n "$marketing_platform" ]; then
      local marketing_major_minor
      marketing_major_minor="$(printf "%s" "$marketing_platform" | cut -d. -f1-2)"
      if [ "$marketing_major_minor" != "$platform_major_minor" ]; then
        log_drift_warning "Marketing platform version differs from canonical MAJOR.MINOR" \
                         "$marketing_file" "$platform_major_minor" "$marketing_major_minor"
      fi
    fi
    if [ -n "$marketing_surface" ]; then
      local marketing_surface_major_minor
      marketing_surface_major_minor="$(printf "%s" "$marketing_surface" | cut -d. -f1-2)"
      if [ "$marketing_surface_major_minor" != "$platform_major_minor" ]; then
        log_drift_warning "Marketing surface version differs from canonical MAJOR.MINOR" \
                         "$marketing_file" "$platform_major_minor" "$marketing_surface_major_minor"
      fi
    fi
  fi

  local doc_files=("$root/README.md" "$root/GOVERNANCE.md" "$root/APP.ROADMAP.md")
  for doc in "${doc_files[@]}"; do
    if [ -f "$doc" ]; then
      local doc_line
      doc_line="$(grep -m1 -F "**Documentation Version:**" "$doc" || true)"
      if [ -n "$doc_line" ]; then
        local doc_version
        doc_version="${doc_line#*- **Documentation Version:** }"
        doc_version="${doc_version%% *}"
        local doc_major
        doc_major="$(printf "%s" "$doc_version" | cut -d. -f1)"
        if [ "$doc_major" != "$platform_major" ]; then
          log_drift_warning "Documentation version MAJOR differs from platform" \
                           "$doc" "$platform_major" "$doc_major"
        fi
      fi
    fi
  done
}

check_roadmap_queue_enumerations() {
  local enumerations
  enumerations="$(python3 - <<PY
import pathlib, re

root = pathlib.Path("$root")
lines = root.joinpath("ROADMAP.md").read_text().splitlines()
violations = []
completed = False
for index, line in enumerate(lines, 1):
    stripped = line.strip()
    lowered = stripped.lower()
    if "### completed" in lowered and "todo" in lowered:
        completed = True
    if completed:
        continue
    if "queued" in lowered and re.search(r"TODO-\\d+", line):
        for todo in re.findall(r"TODO-\\d+", line):
            violations.append((index, todo))
    if stripped.startswith("- **TODO-"):
        for todo in re.findall(r"TODO-\\d+", line):
            violations.append((index, todo))
for index, todo in violations:
    print(f"{index}\\t{todo}")
PY
)"

  if [[ -n "${enumerations}" ]]; then
    while IFS=$'\\t' read -r line todo; do
      log_queued_enumeration_incident "$todo" "$line"
    done <<< "$enumerations"
    echo "Process integrity sweep FAILED: ROADMAP.md enumerates queued TODO entries outside queue.md" >&2
    exit 1
  fi
}
check_git_ready_notification() {
  local active_count
  active_count="$(get_active_todo_count)"
  if [ "$active_count" -eq 0 ]; then
    local status
    status="$(git -C "$root" status --porcelain)"
    if [ -n "$status" ]; then
      log_git_ready_incident "$status"
      echo "Approval Required: gates pass but local changes remain; human approval is required before merging." >&2
      exit 2
    fi
  fi
}

handle_failure() {
  local exit_code=$?
  log_process_entry "FAIL" "Step failed: ${current_step:-unknown}"
  echo "Process integrity sweep FAILED at ${current_step:-unknown}" >&2
  exit "$exit_code"
}

trap 'handle_failure' ERR

if [ ! -f "$root/scripts/verify-version-sync.sh" ]; then
  log_missing_version_gate
  log_process_entry "FAIL" "Missing scripts/verify-version-sync.sh gate"
  echo "Process integrity sweep FAILED: missing scripts/verify-version-sync.sh" >&2
  exit 1
fi

for step in "${steps[@]}"; do
  current_step="$step"
  steps_ran+=("$step")
  "$root/$step"
done

current_step="queued enumeration check"
check_roadmap_queue_enumerations
steps_ran+=("scripts/process-integrity-sweep.sh (queue check)")

current_step="git-ready notification check"
check_git_ready_notification
steps_ran+=("scripts/process-integrity-sweep.sh (git-ready check)")

current_step="surface drift detection"
check_surface_drift
steps_ran+=("scripts/process-integrity-sweep.sh (surface drift warning)")

log_process_entry "PASS" "All gates completed successfully"
printf "Process integrity sweep PASSED: %s\n" "$(IFS=", "; echo "${steps_ran[*]}")"
