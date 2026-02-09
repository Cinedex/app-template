# TODO List

This list always shows exactly one active TODO. Completed TODOs move to `TODO.complete.md`, and the steward ensures the queue (`queue.md`) stays future-only while the roadmap (`ROADMAP.md`) mirrors the same catalog. Every TODO must obey the Executable TODO Law: it documents an objective, enumerated Execution Scope, allowed files, a lifecycle status, a verification contract, and a TODO Type before activation.

## Active TODO

## TODO-075 (Privileged CI Force-Alignment Executor)
- **TODO Type:** Governance + Automation
- **Lifecycle:** Implemented → Verified
- **Criticality:** Critical
- **Status:** Active
- **Objective:** Finalize the CI-only force-with-lease executor so the approved artifact can align `origin/master` with the audited canonical commit, and document the governance/law/worker layers that make CI the sole force execution path before closing TODO-074.
- **Execution Scope:**
-  - [ ] Complete `.github/workflows/ci-force-align.yml` so it checks the approval artifact, validates the approved SHAs, pushes with `git push --force-with-lease origin master`, re-fetches origin, and regenerates `git-branches.md`, the current merge report, and the audit report before uploading the artifacts.
-  - [ ] Update the enforcement catalog (laws, governance, README, git workflow, and CODEX worker roles) so the Privileged CI Execution Law, the CI-only force alignment section, and the CI Force Executor worker describe why force pushes are CI-bound and how the approval artifact ties into the evidence.
-  - [ ] Bump `VERSION.md` (patch → 0.3.8.6) with TODO-075 metadata and compatibility/notes describing the addition of the CI-based executor.
-  - [ ] Confirm the verification stack (`scripts/verify-roadmap-sync.sh`, `scripts/verify-version-sync.sh`, `scripts/process-integrity-sweep.sh`, `scripts/update_tree.sh`) passes after the updates so the tree records the new workflow file.
- **Allowed files:** `.github/workflows/ci-force-align.yml`, `authority/laws.md`, `GOVERNANCE.md`, `README.md`, `git/workflow.md`, `CODEX.worker.md`, `TODO.md`, `TODO.complete.md`, `ROADMAP.md`, `queue.md`, `VERSION.md`, `TREE.md`, `scripts/logs/error-incidents.md` (only for dispatch/verification failures requiring logging).
- **Verification Contract:** `bash scripts/verify-roadmap-sync.sh`; `bash scripts/verify-version-sync.sh`; `bash scripts/process-integrity-sweep.sh`; `bash scripts/update_tree.sh`; CI workflow run (`ci-force-align.yml`) that executes the approved force alignment and uploads the required artifacts.
- **Notes:** Remote canonical alignment (TODO-074) remains blocked until this workflow runs; once CI confirms origin/master matches the approved commit, the post-force confirmation steps resume and TODO-074 can close.

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
  - **Verification Contract:** README/governance cite the guard rails, the queue records follow-up TODOs, and automation scripts rerun cleanly.
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
