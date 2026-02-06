# Cinedex Versioning Discipline

Cinedex uses deterministic versioning for the control workspace plus every first-party app so we can signal release readiness, track automation, and tie each change to a TODO. This file documents the patterns the Git & Branch Tracking worker follows before merging anything.

## Versioning model
- **Base platform version:** Track via `major.minor.micro` (e.g., `1.4.2`). Increase the **micro** number for every published change, even small documentation updates, so no modification escapes an audit trail. Reserve minor bumps for roadmap milestones (new phases or app ships) and major bumps for architectural shifts (multi-server splits, MicroMDM go-live).
- **App versions:** Each first-party app (Cinehub, Gigs, Spark, Films, Studio, Loadout, Pulse, Ledger, Sync, Atlas) maintains its own version that follows the same `major.minor.micro` cadence but increments only when the app receives a release or automation update. Link app versions back to TODOs that drove the change (e.g., `TODO-XXX` recorded in the release note) so the Git automation log states which TODO bumped what apps.
- **Threading:** Every commit references the active TODO and documents the version bump (e.g., `TODO-045: bump platform micro to 1.4.3`). The Git & Branch Tracking worker updates this file and `git/branches.md` via `scripts/git-branch-log.sh` before generating a merge report.

## Version artifact
- **Canonical artifact:** `VERSION.md` stores the platform’s current and previous version, the TODO that triggered the bump, and the timestamp. Automation scripts read it so merge reports, observability logs, and status dashboards register the same version string.
- **Observability tie-in:** The `scripts/logs/observability-runs.md` entries and `git/merge-report` output parse this artifact so Pulse dashboards and release reports display the same string; the Feature Registry Versioning entry references `VERSION.md` so release validation is traceable back to the enforcing TODO.
- **Canonical target branch:** All releases, verification merges, and automation reports anchor on the canonical target branch `master`, keeping `VERSION.md` aligned with the master timeline so auditors always trace the release string to the same branch.
- **Verification:** TODO-060 ensures `VERSION.md` exists, encodes a valid semantic version, and ties its bump to the task; auditors confirm the artifact before marking the feature Implemented.

## Deterministic bump contract
- **Micro increments:** Every commit that changes the platform—documentation, automation, or code—must bump the micro digit so each change has its own release marker. Minor/major increments remain reserved for milestone or architectural changes and still log the previous value in `VERSION.md` for auditors.
- **Artifact update steps:** When a bump occurs, update `VERSION.md` by setting `Previous Version` to the last `Current Version`, incrementing the `Current Version`, recording the `Bumped By` TODO, and stamping `Created At` with the UTC timestamp of the automation run. Add a short `Notes` bullet that explains why the bump happened (e.g., TODO number and key verification outputs).
- **Automation awareness:** Observability scripts (`scripts/logs/observability-runs.md`, Pulse instrumentation runs) and `scripts/git-merge-report.sh` read `VERSION.md` before generating logs so every automation output includes the new string and auditors can trace which TODO produced the bump.

## Error logging tie-in
- **Incident log:** Whenever an error incident occurs (automation failure, UI crash, data mismatch), append it to `scripts/logs/error-incidents.md` with the version impacted, TODO reference, and remediation note so the Sequencer can replay the path later.
- **Version gating:** Do not bump versions or close a TODO until the incident log entry references the failure state and automation script (if any) that resolved it; this keeps the version history truthful and traceable.
