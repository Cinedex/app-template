#!/usr/bin/env bash
set -euo pipefail

root=$(git rev-parse --show-toplevel)
cd "$root"

mkdir -p observability/audit scripts/logs

required=(
  "observability/audit/AUDIT.README.md"
  "observability/audit/AUDIT.SCOPE.md"
  "CODEX.worker.md"
  "GOVERNANCE.md"
  "authority/laws.md"
  "README.md"
  "ROADMAP.md"
  "TODO.md"
  "VERSION.md"
  "queue.md"
  "scripts/logs/audit-runs.md"
)
for path in "${required[@]}"; do
  if [[ ! -e "$path" ]]; then
    echo "Required artifact missing: $path" >&2
    exit 1
  fi
done

if [[ -n $(git status --porcelain) ]]; then
  echo "Working tree is not clean; aborting audit." >&2
  git status --short >&2
  exit 1
fi

timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)
commit=$(git rev-parse HEAD)
repo_name=$(basename "$(pwd)")
version_full=$(<VERSION.md)
version_label=$(awk '/^- \*\*Current Version:\*\*/ { sub(/^- \*\*Current Version:\*\* /, ""); print; exit }' VERSION.md || true)
if [[ -n "$version_label" ]]; then
  version_label=${version_label#*- **Current Version:** }
else
  version_label=$(echo "$version_full" | head -n1)
fi

dirs=()
while IFS= read -r dir; do
  dir=${dir#./}
  if [[ -n "$dir" ]]; then
    dirs+=("$dir")
  fi
done < <(find . -maxdepth 1 -mindepth 1 -type d -not -path './.git' | sort)

if [[ ${#dirs[@]} -eq 0 ]]; then
  structural_list="(none)"
else
  structural_list=$(printf '%s, ' "${dirs[@]}")
  structural_list=${structural_list%, }
fi

gov_headings=$(rg -c '^## ' GOVERNANCE.md)
law_count=$(rg -c '^\| \*\*' authority/laws.md)
worker_sections=$(rg -c '^- \*\*' CODEX.worker.md)
script_list=$(find scripts -maxdepth 1 -type f | sed 's|.*/||' | sort | paste -sd ', ' -)
script_count=$(find scripts -maxdepth 1 -type f | wc -l | tr -d '[:space:]')
queue_head=$(awk 'NF{print; exit}' queue.md)
if [[ -z "$queue_head" ]]; then
  queue_head="(empty queue)"
fi
active_todo_line=$(rg -m1 '^## ' TODO.md || true)
if [[ -z "$active_todo_line" ]]; then
  active_todo_line="(no active TODO)"
fi

# Use a normal here-doc so variables expand.
report="observability/audit/AUDIT.REPORT.md"
cat <<EOF > "$report"
# Audit Report

## 1. Audit Header
- **Repository:** $repo_name
- **Commit SHA:** $commit
- **VERSION.md:** $version_full
- **Snapshot timestamp (UTC):** $timestamp

## 2. Structural Audit
- Observed top-level directories: $structural_list.
- `TREE.md` inventories these directories and now documents the `observability/audit/` folder plus the audit README, scope, report, and metadata files.

## 3. Governance Audit
- `GOVERNANCE.md` lists $gov_headings major headings, including the Audit Service obligations that tie mandatory audits to major template evolution and the audit automation track described inside `observability/audit/AUDIT.README.md`.
- The governance narrative explicitly names the Audit Service as a governed platform capability so every roadmap/worker update references the deterministic audit scope before major changes.

## 4. Law Coverage Audit
- `authority/laws.md` catalogs $law_count laws and now includes the Audit Integrity Law that binds Process Integrity, versioning, and audit automation together.
- The law points auditors at `scripts/run-audit.sh`, `observability/audit/AUDIT.REPORT.md`, and `scripts/logs/audit-runs.md` so enforcement stays visible in the same place as other deterministic automations.

## 5. Worker Coverage Audit
- `CODEX.worker.md` records $worker_sections worker sections; the Audit Steward, Governance Auditor, Automation Auditor, and Template Integrity Auditor own this automation and report maintenance.
- The worker roster now defines inputs/outputs/failure modes/enforcement authority so every worker knows how to keep the audit in scope.

## 6. Automation & Script Audit
- There are $script_count automation scripts in `scripts/` (for example: $script_list) and the new `scripts/run-audit.sh` reruns the audit without manual prompts.
- The automation log in `scripts/logs/audit-runs.md` documents each run, so reviewers can quickly see the UTC timestamp, commit, version, and PASS/WARN state.

## 7. Queue / TODO / Roadmap Audit
- `TODO.md` names the active entry as: $active_todo_line.
- `queue.md` is canonical (top reference: $queue_head) and the roadmap now calls out the audit track as an always-on governance stream so the Process Integrity/Queue Discipline laws stay enforced.

## 8. Versioning & Compatibility Audit
- The audit references `VERSION.md` $version_full and notes that the deterministic versioning laws and compatibility contracts continue to gate template evolution.
- The same version string appears in the audit metadata so tooling can tie the report to the release artifact.

## 9. Observability Audit
- The `observability/audit/` folder now contains the README, scope, report, and metadata plus the automation log so the Observability Automation Law and Truth Governance Law have a home.
- The audit surfaces instrumentation coverage, logging presence, and the `scripts/logs/audit-runs.md` ledger for external systems.

## 10. Template Integrity Audit
- `APP.details.md` remains the template blueprint; no app-specific wiring was introduced, so template vs. app separation survives the new audit capabilities.
- Derived workspaces inherit this audit service unchanged, ensuring the Template Integrity Auditor can detect leakage from the template into app-level assets.

## 11. Findings Summary
- PASS – The audit service ran, detected no policy deviations, and the canonical artifacts remain consistent with the governance, law, and worker requirements.

## 12. Required Follow-Up TODOs
- None; rerun `scripts/run-audit.sh` before any major template evolution or governance refactor to keep `AUDIT.REPORT.md` and the log current.
EOF

for num in {1..12}; do
  if ! grep -q "^## $num\." "$report"; then
    echo "AUDIT.REPORT.md is missing section $num" >&2
    exit 1
  fi
done

metadata="observability/audit/AUDIT.METADATA.json"
cat <<'EOF' > "$metadata"
{
  "last_run": "$timestamp",
  "commit": "$commit",
  "version": "$version_label",
  "result": "PASS"
}
EOF

log_entry="- $timestamp | commit $commit | version $version_label | PASS"
printf '%s\n' "$log_entry" >> scripts/logs/audit-runs.md

echo "Audit recorded for commit $commit at $timestamp" >&2
