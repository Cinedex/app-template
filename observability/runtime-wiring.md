# Runtime Instrumentation Wiring

## What runtime wiring means in this repo
Runtime wiring is the documentation plus automation propagation trail that keeps every runtime signal (metrics, traces, logs, instrumentation probes) tied to the platform TODO that enabled it. The doc names the charts, observability scripts, and Feature Registry links that all read the same canonical artifacts so automation consumers see consistent release metadata before any merge lands.

## Data owners and stewards
- **Observability Automation Worker:** Responsible for cataloging telemetry signals, automations, and batch logs that feed Pulse dashboards; owns the instrumentation catalog entries and the automation scripts that run the wiring.
- **Feature Registry Compiler:** Tracks which TODO/worker pair produces each probe so accountability lives next to the lifecycle status report; ensures instrumentation metadata appears in the registry row for Instrumentation Runtime.
- **Pulse Lifecycle Steward:** Oversees the dashboards and System Health Report that consume the wiring metadata, verifying every metric/tracer lists its owning worker and law references before showing up in Pulse.

## Propagation chain
1. **`VERSION.md`** stores the canonical current and previous versions plus the TODO that bumped them (TODO-060, TODO-062, etc.).
2. **Merge reports** parse `VERSION.md` (`scripts/git-merge-report.sh`) so release audits publish the version artifact before any downstream workflow runs.
3. **Observability run logs** (`scripts/logs/observability-runs.md`) capture the automation script output, note the version artifact, and describe which wiring documents changed.
4. **Feature Registry** references the wiring doc and instrumentation catalog so auditors can trace which runtime probes are live and who owns them.
5. **Pulse dashboards** read the registry data plus the logged version artifact so every runtime signal shows the same release string and law citations.

The wiring chain ensures `TODO → version → observability log → Feature Registry → Pulse` stays synchronized across automation outputs.

## Instrumentation catalog tie-in
Every owner must register new instrumentation signals inside the shared catalog with the metric/tracer name, expected units, automation guard rails, and the owning worker. Future apps/services must:
- add catalog entries before shipping instruments, referencing the controlling TODO and the responsible worker.
- cite this wiring doc when they introduce new propagation targets (Pulse charts, merge-report sections, automation logs).
- update `scripts/logs/observability-runs.md` so the Sequencer worker can verify catalog drift alongside the automation run.

## Smoke run checklist
1. Run `scripts/update_tree.sh`, `scripts/git-branch-log.sh`, and `scripts/git-merge-report.sh` to refresh `TREE.md`, `git/branches.md`, and the merge report that reads `VERSION.md`.
2. Confirm instrumentation wiring notes in this doc align with instrumentation catalog entries and Feature Registry rows, citing the owning worker for each signal.
3. Log the automation run in `scripts/logs/observability-runs.md`, mentioning that the version artifact recorded in `VERSION.md` (TODO-060) remains in sync.
4. Share the wiring metadata with Pulse and merge report consumers before the next TODO closes so dashboards keep the same release string.
