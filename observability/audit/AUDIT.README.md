# Audit Service

This folder holds the deterministic Audit Service that every derived template inherits. The service is documentation + automation + worker-owned auditing; it never mutates app behavior, and all downstream repos run the same script and publish the same sections. The Audit Steward, Governance Auditor, Automation Auditor, and Template Integrity Auditor listed in `CODEX.worker.md` own the artifacts, keep the scope accurate, and block TODO closure whenever the audit drifts.

## Purpose
- Capture the platform template state so an external reviewer (people, automation, or ChatGPT) can read `AUDIT.REPORT.md` and understand structure, workers, governance, laws, automation, and template/app separation without verbal context.
- Provide a single automation entry (`scripts/run-audit.sh`) that regenerates the same sections every run, writes the metadata snapshot, and logs the outcome under `scripts/logs/audit-runs.md`.
- Serve as the audit home for mandatory reviews before any major template evolution; the governance catalog names the Audit Service as a governed capability and the Roadmap declares it an always-on track.

## Artifacts
- `AUDIT.SCOPE.md` explains the nine inference-free audit categories (structure, governance, laws, workers, automation, versioning, queue/TODO, observability, template integrity).
- `AUDIT.REPORT.md` holds the most recent snapshot with the 12 fixed sections that describe repo state, findings, and required follow-ups.
- `AUDIT.METADATA.json` tracks the last run timestamp, commit, version, and pass/warn status for automations.
- `scripts/run-audit.sh` is the automation runner that enforces deterministic output, checks the git state, updates the report, and appends the log entry.
- `scripts/logs/audit-runs.md` records every automation pass/warn so auditors know when the audit last executed.

## Running the audit
1. Confirm your git working tree is clean and the canonical TODO/roadmap/state are up to date; the script enforces that clean state before it runs.
2. Execute `bash scripts/run-audit.sh`. It prints the git status, HEAD, and version it audited, regenerates `AUDIT.REPORT.md`, updates `AUDIT.METADATA.json`, and appends the run to `scripts/logs/audit-runs.md`.
3. Share `observability/audit/AUDIT.REPORT.md` (and, if needed, `AUDIT.METADATA.json` or `scripts/logs/audit-runs.md`) with reviewers or automation so everyone can trace the template state without oral context.

## Sharing and automation
- The report includes fields such as repo name, commit SHA, `VERSION.md` string, timestamp, coverage notes for each governance area, and a findings summary so it can be pasted into ChatGPT or other audit systems with no extra explanation.
- The metadata file and log entry reinforce deterministic versioning (the audit references the same `VERSION.md` string the rest of the platform uses) and tie the automation to the Process Integrity/Versioning laws enforced across the workspace.
