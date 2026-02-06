# TODO List

This list always shows exactly one active TODO. Completed TODOs move to `TODO.complete.md`, and the steward ensures the queue (`queue.md`) stays future-only while the roadmap (`ROADMAP.md`) mirrors the same catalog. Every TODO must obey the Executable TODO Law: it documents an objective, enumerated Execution Scope, allowed files, a lifecycle status, a verification contract, and a TODO Type before activation.

## Active TODO

## TODO-000 (Idle placeholder)
- **TODO Type:** Governance-Only
- **Lifecycle:** Idle
- **Criticality:** Non-Critical
- **Status:** Idle
- **Objective:** Keep the workspace idle until the next TODO activates, ensuring canonical artifacts remain aligned and the queue stays future-only while no active TODO exists.
- **Execution Scope:**
  - [ ] Keep `queue.md` future-only and aligned with `ROADMAP.md`/`TODO.md`, honoring the Canonical Artifact and Roadmap Sync laws.
  - [ ] Leave README/GOVERNANCE/authority/automation artifacts unchanged while no TODO is active so the template state remains frozen.
  - [ ] Preserve `VERSION.md`, `TREE.md`, and the automation logs until the next TODO opens so the Process Integrity sweep sees an unchanged baseline.
- **Allowed files:** None (placeholder; no edits allowed while idle).
- **Verification Contract:** Placeholder state; verification resumes when the next TODO activates and reruns the canonical gates.
- **Notes:** The steward may activate the next queued TODO once it satisfies the Executable TODO Law; this placeholder keeps the Process Integrity sweep from profiling drift in between runs.

## Future Implementation TODOs
- None currently queued.

## Future Governance TODOs
- **TODO-059:** App Marketplace + Atlas readiness.
  - **TODO Type:** Governance-Only
  - **Lifecycle:** Defined
  - **Criticality:** Non-Critical
  - **Objective:** Document App Marketplace and Atlas readiness guard rails.
  - **Execution Scope:**
    - [ ] Outline marketplace criteria in README and `Cinedex.details.md`.
    - [ ] Update queue/roadmap entries with integration readiness steps and automation references.
    - [ ] Cite relevant laws for each guard rail.
  - **Allowed files:** `README.md`, `Cinedex.details.md`, `queue.md`, `TODO.md`, `TODO.complete.md`, `authority/laws.md`, `ROADMAP.md`, `scripts/update_tree.sh`, `VERSION.md`.
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
