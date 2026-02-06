# Pulse Ingestion Verification

## Purpose & scope
Pulse ingestion verification proves the end-to-end telemetry handshake so that every signal that flows into Pulse dashboards, the System Health Report, and observability tooling is traceable back to the instrumentation catalog, the runtime wiring doc, and the canonical version artifact. This doc defines how “ingestion verification” works in this control workspace: it is the documented confirmation that telemetry/state data traverses instrumentation owners → automation runs → merge reports → the Feature Registry → Pulse without version drift or missing law references.

## Inputs and sources of truth
- **Instrumentation catalog / runtime wiring doc:** `observability/runtime-wiring.md` lists every runtime probe, steward, and automation target so the Feature Registry Compiler and Pulse dashboards know which owner owns each signal. Every verification run reuses these definitions to ensure instrumentation metadata still matches the wiring.
- **`VERSION.md`:** The release string is the canonical artifact for every merge report and automation log. Observability runs and Pulse ingest the same `Current Version`/`Previous Version`/`Bumped By` values so auditors can follow the path from TODO to release.
- **`scripts/logs/observability-runs.md`:** The ledger shows every verification pass, the scripts executed, the observed version artifact, and the law citations. Each entry links the runtime wiring doc, this ingestion verifier, and the merge report that proved the version.
- **Feature Registry:** The Pulse Ingestion row is the lifecycle index for this verification. It must cite TODO-063, reference `pulse/ingestion-verification.md`, list the impacted systems (observability pipelines, automation logs, Pulse dashboards, and the System Health Report), and note when Pulse ingestion moves from Implemented (target) to Verified.

## Verification checklist
1. **Feature Registry inspection:** Confirm the Pulse Ingestion row references TODO-063, mentions `pulse/ingestion-verification.md`, lists the impacted systems, and shows the lifecycle (Verified once the ingestion run is recorded; Implemented (target) until that state exists).
2. **Observability log check:** The latest `scripts/logs/observability-runs.md` entry must mention this verification doc, call out `observability/runtime-wiring.md`, cite the merge report file, and prove the `VERSION.md` artifact remained the release anchor.
3. **Merge report check:** Run `scripts/git-merge-report.sh` (target branch `master`) after the verification edits and ensure the “Version Artifact” section reads from `VERSION.md`. Confirm the report filename is stored for auditors and appended to the observability log entry.
4. **Pulse ingestion state:** The System Health Report or Feature Lifecycle Status report must mark Pulse ingestion as Verified only when the Feature Registry row, observability log entry, and merge report share the same version artifact and law citations; until then it remains Implemented (target).

## Evidence Recording Rules
- Always store the merge report filepath from `scripts/git-merge-report.sh` and cite it inside the new observability log entry.
- Log the `VERSION.md` artifact value (Current/Previous/Bumped By/Created At) inside the observability run so automation, the Feature Registry, and Pulse dashboards read the same release string.
- Record law references (Observability Automation Law, Merge Reporting Law, Versioning & Incident Logging Law, System Gap Surfacing Law) with every verification entry so the Sequencer worker can cite them during the batch summary.
- Keep the instrumentation catalog and runtime wiring doc referenced so each new ingestion verification run can trace which probes/wirings were checked.

## Law references
- Observability Automation Law
- Merge Reporting Law
- Versioning & Incident Logging Law
- System Gap Surfacing Law

## Post-run recording requirements
After each verification run, append a timestamped entry to `scripts/logs/observability-runs.md` that states:

1. The wiring doc (`observability/runtime-wiring.md`) and ingestion doc (`pulse/ingestion-verification.md`) were used to validate telemetry.
2. The Feature Registry Pulse Ingestion row now reflects the verification and still ties back to TODO-063.
3. The merge report filename produced by `scripts/git-merge-report.sh master master` is recorded, and its Version Artifact section continued to read from `VERSION.md`.
4. The automation scripts executed (`scripts/update_tree.sh`, `scripts/git-branch-log.sh`, `scripts/git-merge-report.sh`) plus the law references listed above are noted so the Sequencer’s batch summary can cite the complete chain of custody.
