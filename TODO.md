# TODO List

This list always shows exactly one active TODO. Completed TODOs move to `TODO.complete.md`, and the steward ensures the queue (`queue.md`) stays future-only while the roadmap (`ROADMAP.md`) mirrors the same catalog. Every TODO must obey the Executable TODO Law: it documents an objective, enumerated Execution Scope, allowed files, a lifecycle status, a verification contract, and a TODO Type before activation.

## Active TODO

## TODO-073 (CI Gate — Process Integrity + Audit Enforcement)
- **TODO Type:** Governance + Automation
- **Lifecycle:** Verified
- **Criticality:** Critical
- **Status:** Active
- **Objective:** Elevate the GitHub Actions CI gate into the official verification layer so every PR and push mirrors the local automation stack, uploads the deterministic audit artifacts, and blocks merges until the gate passes, while documentation, laws, and workers treat CI as mandatory before approval.
- **Execution Scope:**
  - [ ] Confirm `.github/workflows/ci-integrity.yml` runs `scripts/verify-roadmap-sync.sh`, `scripts/verify-version-sync.sh`, `scripts/process-integrity-sweep.sh`, and `scripts/run-audit.sh` in order, fails on any non-zero exit, and uploads the audit report, metadata, audit/process logs, error incidents, `git/branches.md`, and `TREE.md` without mutating the tree.
  - [ ] Confirm `.github/workflows/ci-merge-readiness.yml` triggers on pull requests to `master`, executes `bash scripts/git-merge-report.sh master HEAD`, uploads `git/merge-reports/*.md`, and never attempts to merge or mutate files.
  - [ ] Update `README.md`, `GOVERNANCE.md`, `git/workflow.md`, and `CODEX.worker.md` so they document the CI gate, reference the new CI Verification Gate Law, explain CI’s independence, and highlight the workflow artifact requirements.
  - [ ] Add the CI Verification Gate Law to `authority/laws.md` (citing the Git Automation Exclusivity, Approval-Gated Merge Automation, Mandatory Patch Version, and Process Integrity laws) and ensure the worker roster calls out the CI Gatekeeper role that treats CI drift as a stop condition.
  - [ ] Record the CI gate in the roadmap, queue, and TODO verifications so the governance story, law references, and worker assignments explicitly mention CI as mandatory before closing.
  - [ ] Bump `VERSION.md` (patch) so `Full Version` becomes `0.3.8.5`, `Previous Version` stays `0.3.8.4`, `Bumped By` references TODO-073, and the notes state “CI integrity + audit gate added (GitHub Actions).”
  - [ ] Run the verification suite (`scripts/verify-roadmap-sync.sh`, `scripts/verify-version-sync.sh`, `scripts/process-integrity-sweep.sh`, `scripts/run-audit.sh`, `scripts/update_tree.sh`, `scripts/git-branch-log.sh`) from a clean checkout, record the results in `TODO.complete.md`, and ensure `TREE.md` reflects `.github/workflows/.`
  - [ ] Capture the completion evidence (logs, audit artifacts, branch log, version bump) inside `TODO.complete.md` and `ROADMAP.md` so downstream reviewers see the deterministic story before the template moves on.
- **Allowed files:** `.github/workflows/**`, `authority/laws.md`, `GOVERNANCE.md`, `README.md`, `git/workflow.md`, `CODEX.worker.md`, `TODO.md`, `TODO.complete.md`, `ROADMAP.md`, `queue.md`, `VERSION.md`, `TREE.md`.
- **Verification Contract:** `bash scripts/verify-roadmap-sync.sh`; `bash scripts/verify-version-sync.sh`; `bash scripts/process-integrity-sweep.sh`; `bash scripts/run-audit.sh`; `bash scripts/update_tree.sh`; `bash scripts/git-branch-log.sh` (all must pass; record pass status inside `TODO.complete.md` and ensure the audit artifacts mention the new version string).
- **Notes:** This TODO closes the CI gate: approval artifacts are only trusted after the CI workflows pass, the audit snapshot remains shareable, and any CI/local drift enforces the CI Verification Gate Law that stretches across automation, laws, and worker oversight.


## Future Implementation TODOs
## Future Implementation TODOs## Future Implementation TODOs
- None currently queued.

## Future Governance TODOs
- **TODO-059:** App Marketplace + Atlas readiness.
-  - **TODO Type:** Governance-Only
-  - **Lifecycle:** Defined
-  - **Criticality:** Non-Critical
-  - **Objective:** Document App Marketplace and Atlas readiness guard rails.
-  - **Execution Scope:**
-    - [ ] Outline marketplace criteria in README and `APP.details.md`.
-    - [ ] Update queue/roadmap entries with integration readiness steps and automation references.
-    - [ ] Cite relevant laws for each guard rail.
-  - **Allowed files:** `README.md`, `APP.details.md`, `queue.md`, `TODO.md`, `TODO.complete.md`, `authority/laws.md`, `ROADMAP.md`, `scripts/update_tree.sh`, `VERSION.md`.
-  - **Verification Contract:** README/governance cite the guard rails, queue records follow-up TODOs, and automation scripts rerun cleanly.
-  - **Post-Completion Expectations:** Update the Feature Registry with the marketplace readiness story.
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
