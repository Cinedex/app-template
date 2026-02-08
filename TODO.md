# TODO List

This list always shows exactly one active TODO. Completed TODOs move to `TODO.complete.md`, and the steward ensures the queue (`queue.md`) stays future-only while the roadmap (`ROADMAP.md`) mirrors the same catalog. Every TODO must obey the Executable TODO Law: it documents an objective, enumerated Execution Scope, allowed files, a lifecycle status, a verification contract, and a TODO Type before activation.

## Active TODO

## TODO-000 (Idle placeholder)
- **TODO Type:** Governance + Automation
- **Lifecycle:** Idle
- **Criticality:** Critical
- **Status:** Active
- **Objective:** Signal that the workspace currently has no active TODO and await the governance steward’s next assignment while the queue stays future-only.
- **Execution Scope:**
  - [ ] Keep the queue (`queue.md`), roadmap (`ROADMAP.md`), and version artifact (`VERSION.md`) synchronized so the Process Integrity gate can confirm the workspace is ready for the next TODO.
  - [ ] Ensure the automation/log artifacts (`scripts/logs/*`, `git/branches.md`, `TREE.md`) remain committed after the last verification so auditors can see that the workspace is idle between TODOs.
  - [ ] Document the idle state in the roadmap and TODO log so future workers know why no TODO is currently active.
- **Allowed files:** `TODO.md`, `TODO.complete.md`, `ROADMAP.md`, `queue.md`, `VERSION.md`, `TREE.md`.
- **Verification Contract:** No scripts run while idle; keep the last verification records intact and rerun the mandated scripts when the next TODO activates.
- **Notes:** This placeholder keeps the canonical queue future-only until a new TODO arrives; it may be closed only when another TODO activates via a full governance briefing.

## Future Implementation TODOs## Future Implementation TODOs
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
