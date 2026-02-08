# TODO List

This list always shows exactly one active TODO. Completed TODOs move to `TODO.complete.md`, and the steward ensures the queue (`queue.md`) stays future-only while the roadmap (`ROADMAP.md`) mirrors the same catalog. Every TODO must obey the Executable TODO Law: it documents an objective, enumerated Execution Scope, allowed files, a lifecycle status, a verification contract, and a TODO Type before activation.

## Active TODO

## TODO-072 (Git Automation Enforcement & Mandatory Patch Versioning)
- **TODO Type:** Governance + Automation
- **Lifecycle:** Implemented
- **Criticality:** Critical
- **Status:** Active
- **Objective:** Harden the Git automation pipeline so commits/merges remain fully scripted, every change bumps the patch metadata, audit tooling stays deterministic, and governance documents enumerate the automation/law coverage before any major template evolution.
- **Execution Scope:**
  - [ ] Close TODO-000 and open TODO-072 with an updated roadmap/queue narrative so the canonical workspace reflects the new governance track.
  - [ ] Update `scripts/git-sync.sh`, `scripts/git-merge-with-approval.sh`, `scripts/git-branch-log.sh`, and `scripts/process-integrity-sweep.sh` to enforce the new automation guard rails, approval gating, conflict/drift detection, and mandatory version bump before every commit.
  - [ ] Document the Git automation enforcement, mandatory patch versioning, and Audit Service governance track inside `README.md`, `GOVERNANCE.md`, `CODEX.worker.md`, `authority/laws.md`, `git/workflow.md`, and `git/versioning.md`, linking to the required laws and workers.
  - [ ] Reconcile `VERSION.md` with the new patch metadata schema (Current, Previous, Full version, Bumped By, Timestamp, Notes) and bump the patch digit for this change.
  - [ ] Run the verification scripts (`scripts/verify-roadmap-sync.sh`, `scripts/verify-version-sync.sh`, `scripts/process-integrity-sweep.sh`, `scripts/update_tree.sh`, `scripts/git-branch-log.sh`, `scripts/run-audit.sh`) so the automation state, audit log, and tree snapshot capture the enforced discipline.
  - [ ] Record the automation outcomes plus the Audit Service log/metadata updates so downstream apps inherit the deterministic audit snapshot, error logs, and branch inventory.
- **Allowed files:** `README.md`, `GOVERNANCE.md`, `authority/laws.md`, `CODEX.worker.md`, `ROADMAP.md`, `TODO.md`, `TODO.complete.md`, `VERSION.md`, `TREE.md`, `queue.md`, `git/workflow.md`, `git/versioning.md`, `scripts/git-sync.sh`, `scripts/git-merge-with-approval.sh`, `scripts/git-branch-log.sh`, `scripts/process-integrity-sweep.sh`, `scripts/run-audit.sh`, `scripts/logs/audit-runs.md`, `scripts/logs/error-incidents.md`, `observability/audit/AUDIT.REPORT.md`, `observability/audit/AUDIT.METADATA.json`.
- **Verification Contract:** `scripts/verify-roadmap-sync.sh`, `scripts/verify-version-sync.sh`, `scripts/process-integrity-sweep.sh`, `scripts/update_tree.sh`, `scripts/git-branch-log.sh`, `scripts/run-audit.sh` (all must pass; audit run refreshes the report/metadata/log); the final `TODO.complete.md` entry cites the merge report plus the branch log/automation outputs so the audit can be reviewed without additional context.
- **Notes:** This TODO unlocks the Audit Service track, enforces automated merges with documented human approvals, and ensures version bumps happen even for tiny changes so derived apps inherit deterministically governed Git behavior.

## Future Implementation TODOs
- None currently queued.

## Future Governance TODOs
- **TODO-059:** App Marketplace + Atlas readiness.
  - **TODO Type:** Governance-Only
  - **Lifecycle:** Defined
  - **Criticality:** Non-Critical
  - **Objective:** Document App Marketplace and Atlas readiness guard rails.
  - **Execution Scope:**
    - [ ] Outline marketplace criteria in README and `APP.details.md`.
    - [ ] Update queue/roadmap entries with integration readiness steps and automation references.
    - [ ] Cite relevant laws for each guard rail.
  - **Allowed files:** `README.md`, `APP.details.md`, `queue.md`, `TODO.md`, `TODO.complete.md`, `authority/laws.md`, `ROADMAP.md`, `scripts/update_tree.sh`, `VERSION.md`.
  - **Verification Contract:** README/governance cite the guard rails, queue records follow-up TODOs, and automation scripts rerun cleanly.
  - **Post-Completion Expectations:** Update the Feature Registry with the marketplace readiness story.
## TODO Template (for future use)
- **Goal:** _Describe the desired outcome._
- **Allowed files:** _List files the TODO may touch._
- **Instructions:** _Explain steps, law references, and coordination notes._
- **Verification criteria:** _Detail which automations, logs, or checks prove success._
- **Lifecycle:** _Defined / Implemented / Verified_
- **Criticality:** _Critical / Non-Critical_
- **TODO Type:** _Governance-Only / Implementation_
- **Post-Completion Expectations:** _State what happens after the TODO closes._

### Execution Scope (required)
- [ ] _Explicitly state each document or artifact to update and how it ties back to the law._
- [ ] _Verify the allowed files list matches the scope._
- [ ] _List the verification scripts (update_tree/git-branch-log/git-merge-report or others) that must run for completion._
