# Platform Control Workspace Template

## Purpose
This repository is the platform control workspace template that every derived app clones before it publishes or governs a surface. It holds the authoritative definitions (a sample `Cinedex.details.md`), enforcement laws (`authority/laws.md`), roadmap (`ROADMAP.md`), queued TODOs (`queue.md`), and the verification history (`TODO.complete.md`) that managers/workers consult before acting. New apps generate by copying this repo, renaming the details file to `<app>.details.md`, and updating the governance artifacts to reflect the target app while the automation and verification guard rails stay intact.

Each template instantiation is driven by a `*.details.md` file: the details file defines services, priorities, automation gaps, and instrumentation requirements that downstream workers translate into TODOs, roadmap updates, and verification obligations. This README/GOV/authority catalog explains how the template mechanics stay consistent across apps, while human-authored detail files (e.g., `Cinedex.details.md` in this workspace) capture the app-specific configuration that derived workspaces customize before going live.

## When you arrive
1. Read the app’s `*.details.md` (this workspace demonstrates the pattern with `Cinedex.details.md`) to understand its scope, services, and shared infrastructure. Treat the details file as the primary reference for new TODO ideas.
2. Confirm the queue, roadmap, and TODO list align with the current platform definition (see the Details & Roadmap Steward notes in `CODEX.worker.md`).
3. Run `scripts/update_tree.sh` and any verification scripts cited in the active TODO before closing work so `TREE.md` and the logs remain current.
4. Validate that the active TODO contains an explicit Execution Scope checklist, allowed files, and verification contract before touching any files; this is enforced by the Executable TODO Law.

## Template Instantiation
- Clone this template workspace whenever you need a new platform repo, rename/copy `Cinedex.details.md` to `<app>.details.md`, and document how the target app maps services, automation, and guard rails into the TODO/roadmap pipeline.
- The `*.details.md` file is the single source of truth for app-specific instantiation: it defines teams, services, automation requirements, instrumentation signals, and any app-level guard rails that the roadmap, queue, and governance sheets must reflect before work begins. Workers read that file first and then regenerate the TODO/roadmap entries, automation runs, and merge reports for the derived app so every release inherits the template’s verification rigour.
- Keep automation, governance, and law wiring unchanged except to reference the new app name/version; the template ensures the same gates, metrics, and LLM safeguards apply across every derived workspace while `*.details.md` supplies the contextual overrides.

## Key workstreams
- **Roadmap & sequencing:** `ROADMAP.md` holds the reverse-chronological catalog of TODOs plus phase summaries. The Details & Roadmap Steward keeps it synchronized with the current app’s details file (the sample `Cinedex.details.md` in this template) when no TODO is active and, per the Always Active TODO Law, ensures there is always at least one TODO in flight.
- **Governance & law:** `GOVERNANCE.md` codifies behavioral rules. `authority/laws.md` lists the laws that drive queue discipline, UI/UX integrity, automation, Git, governance, and executable TODO expectations.
- **Details-driven backlog:** The Details & Roadmap Steward reads the active `*.details.md`, identifies platform priorities (workspace-aware auth, MFA, session auditing, API key governance, MicroMDM/App Marketplace readiness, Observability/LLM safeguards), and updates `ROADMAP.md`/`queue.md` so the roadmap/queue always list queued TODOs derived from those authoritative definitions. Each refresh reruns `scripts/update_tree.sh` and `scripts/git-branch-log.sh` so `TREE.md` and `git/branches.md` stay aligned with the refreshed backlog.
- **Canonical queue authority:** `queue.md` is the only canonical list of queued TODO numbers; enumerations of queued IDs elsewhere are non-canonical per the Canonical Artifact Law, Single-Active-TODO Law, and the Process Integrity and Roadmap Sync laws. The roadmap may summarize future phases but must point workers to `queue.md` rather than repeating queued IDs, and workers reconcile backlog language against `queue.md` before editing roadmap or governance artifacts so the canonical backlog never drifts. The Process Integrity Auditor blocks TODO closure the moment any queued enumeration appears outside `queue.md`, ensuring no partial roadmap updates slip through, and `scripts/process-integrity-sweep.sh` implements the detection by failing the gate and logging incidents to `scripts/logs/error-incidents.md` whenever `ROADMAP.md` lists queued IDs instead of `queue.md`.
- **Automation & Git:** `scripts/update_tree.sh`, `scripts/git-branch-log.sh`, and `scripts/git-merge-report.sh` are the mandatory automation steps referenced by TODO verification blocks; keep the logs under `scripts/logs/` current while working through a batch.
## Automation Entrypoint
- `scripts/run-safe.sh` provides the single “no memory” entrypoint: it runs `scripts/process-integrity-sweep.sh` first, then delegates to `scripts/git-sync.sh` for commit/push flows or `scripts/git-merge-with-approval.sh` for merges so the Roadmap Sync and Approval gates run before any git change.
- `scripts/install-githooks.sh` installs `.githooks` as `core.hooksPath` (pre-commit runs the sweep; pre-push runs `scripts/verify-roadmap-sync.sh` and `scripts/verify-version-sync.sh`), and `scripts/git-sync.sh` invokes it so manual git commands trigger the same automation wiring. This ties the Automation & Git discipline to the Roadmap Sync Law, Git Automation Law, and Truth Governance Law.
- **System Health reporting:** The System Health Report and Pulse lifecycle trend view document lifecycle coverage, gaps, and auditor actions so roadmap advancement is gated on lifecycle completeness.
- **Feature Registry & Traceability:** `features/FEATURE.REGISTRY.md` compiles feature states so auditors, Pulse, and roadmap gates rely on the same truth; the Trace Graph explains why each TODO exists.
- **Prompt Linter Report:** Malformed or ambiguous prompts trigger the Prompt Linter, preventing execution until normalized and reported to Pulse.
- **Version observability:** The canonical `VERSION.md` artifact (current/previous versions, TODO reference, and timestamp) feeds merge reports, automation logs, and Pulse dashboards so every release report shares the same string; deterministic micro bumps and the versioning observability contract keep the platform state visible to auditors.


- **Workers:** `CODEX.worker.md` outlines worker roles, including the Details & Roadmap Steward with its backlog-generation duties.

## Template Roadmap (Human View)
- `APP.ROADMAP.md` presents this template’s descriptive, non-executable human roadmap derived from the canonical artifacts (see `ROADMAP.md`, `TODO.md`, `TODO.complete.md`, and `queue.md`). It illustrates progress across phases 0–8 and documents micro-tracks, providing humans with a top-level view while leaving execution gating unchanged.
- The Template Roadmap Steward worker is responsible for keeping this narrative in sync after each TODO close, updating the active phase/micro-tracks, and stamping the timestamp so the roadmap remains coherent without ever influencing automation.

### Phase 1 milestone
- Phase 1 is Complete (Milestone); TODO-058 and TODO-059 delivered the governance, automation, and LLM safeguards story while versioning (0.3.3 → 0.3.5) keeps the deterministic release string traceable.
- Phase 1.5 is the template-extraction transition; it remains gated/draft until a dedicated governance TODO activates it, so no new execution scope is introduced here.
- This Phase-1.5 readiness audit documents the current guard rails so the later template-extraction TODO can reference fixed requirements before performing the copy (non-executing today). 

## Documentation Versioning
- **Documentation Version:** 0.3 (per `VERSION.md` platform major).
- **Governance notes:** Attribution is descriptive; documentation surfaces reference the canonical major so drift detection works without blocking execution. Log any MAJOR mismatch via the Process Integrity sweep warnings.
- **Interpretation:** Surface versions serve as compatibility signals only; the canonical platform version still lives in `VERSION.md`, and doc authors cite the entry whenever they publish a new narrative or post the updated roadmap.
### Governance TODO — Phase Re-Sequencing template
- **Purpose:** Formalize intentional phase re-sequencing without mutating execution artifacts. It documents why phases change, what micro-tracks shift, and how the narrative evolves while leaving the active TODO, queue, and automation untouched.
- **Explicit Non-Authority:** It does NOT activate/close TODOs, reorder `queue.md`, alter execution order, or bypass verification/integrity laws; it simply explains the re-sequencing and points back to canonical TODOs.
- **Required Inputs:** reason for the re-sequencing, affected before-and-after phases, impacted micro-tracks, and confirmation that execution order remains governed by `TODO.md`/`queue.md`.
- **Required Outputs:** updated phase descriptions, milestone placement notes (if any), adjusted completion percentages, and narrative updates inside `APP.ROADMAP.md`.
- **Verification:** show that canonical artifacts remain unchanged, the template appears in README/GOVERNANCE, `APP.ROADMAP.md` has the updated narrative, and future runs of `scripts/update_tree.sh` capture the new artifact once the template is applied.
- This template becomes the ONLY legal mechanism for re-sequencing phases so the Canonical Artifact Law, Roadmap Sync Law, and Process Integrity Law stay aligned.

### Progress Watchdog (Governance function)
- **Purpose:** Surface stagnation or latent drift even when automation gates stay green. The watchdog stays conceptual—no scripts run—but its findings guide new governance TODOs.
- **Triggers:** unchanged active TODO across long spans, phase completion percentages static despite closing TODOs, governance TODOs without implementation follow-ups, or queue growth that outpaces completion.
- **Actions:** log a warning, cite laws (Canonical Artifact Law, Process Integrity Law, System Gap Surfacing), and recommend filing a governance TODO; never execute work on its own.
- **Visibility:** the watchdog is mentioned in CODEX.worker.md, referenced in GOVERNANCE.md, and logged manually where incidents/remarks live so managers can act before drift becomes structural.

## Automation & Productivity Inventory
- `scripts/process-integrity-sweep.sh`
  - Purpose: Confirms the canonical TODO/roadmap/queue/version/TREE state across the Roadmap Sync Gate and the Process Integrity Law so sequential batches never drift.
  - When it runs: Before a TODO closes, via the pre-commit/pre-push hooks, and every time `scripts/run-safe.sh` executes; this is the gate that the Process Integrity Auditor worker enforces.
  - Laws enforced: Roadmap Sync Law (the Process Integrity Law variant) and Batch Verification Law.
  - Owned by: Process Integrity Auditor worker.
- `scripts/verify-roadmap-sync.sh`
  - Purpose: Validates TODO/roadmap/queue alignment, ensuring the single active TODO and the completed catalog stay synchronized before any transition.
  - When it runs: Pre-close, from the pre-push hook, and as part of `scripts/run-safe.sh`; the Process Integrity Auditor and Coordinator & Best Practices worker monitor the results.
  - Laws enforced: Roadmap Sync Law and Batch Verification Law.
  - Owned by: Process Integrity Auditor worker (with escalation to the Coordinator & Best Practices worker).
- `scripts/verify-version-sync.sh`
  - Purpose: Checks that `VERSION.md` anchors the merge report Version Artifact section, references the bumping TODO, and logs incidents when the release string drifts.
  - When it runs: Pre-close, in the pre-push hook, and whenever `scripts/run-safe.sh` invokes the git tooling.
  - Laws enforced: Versioning & Incident Logging Law (the Version Sync Law) and Git Automation Law.
  - Owned by: Git & Branch Tracking worker.
- `scripts/run-safe.sh`
  - Purpose: Presents the single “no memory” entrypoint, running the Process Integrity sweep before handing off to `scripts/git-sync.sh` (for commits/pushes) or `scripts/git-merge-with-approval.sh` (for merges).
  - When it runs: Every commit/push/merge flow; it is the automation gateway for the Git & Branch Tracking worker.
  - Laws enforced: Roadmap Sync Law, Git Automation Law, Batch Verification Law.
  - Owned by: Git & Branch Tracking worker.
- `scripts/git-sync.sh`
  - Purpose: Wraps git add/commit/push with enforced hooks, canonical branch naming, and automation logging so workers can reference the same audit trail.
  - When it runs: From `scripts/run-safe.sh` or directly when workers follow the automation guardrails.
  - Laws enforced: Git Automation Law and Git Workflow Law.
  - Owned by: Git & Branch Tracking worker.
- `scripts/git-merge-with-approval.sh`
  - Purpose: Generates the merge report, requires a single approval artifact, and auto-merges only after the approval, then reruns the automation trio plus tree/branch refresh.
  - When it runs: During merges that target `master`, honoring the Git Cadence & Approval Law.
  - Laws enforced: Merge Reporting Law and Git Cadence & Approval Law.
  - Owned by: Git & Branch Tracking worker (with the Coordinator & Best Practices worker monitoring approvals).

## Git Automation Reporting Blueprint
- **Branch log runs** – `scripts/git-branch-log.sh` refreshes `git/branches.md` with the active TODO, workspace status (`git status -sb`), branch inventory, and commit summary. The Branch Tracking worker runs it before and after every git operation so the log proves that “Git logs match the documented workflow,” satisfying TODO-056’s verification requirement.
- **Merge report runs** – `scripts/git-merge-report.sh master <source>` executes before a human-approved merge (and again afterward) to document merge candidates, remote references, and the version artifact. The report now includes a “Governing Laws” section that explicitly cites the Merge Reporting Law and Merge Audit Law so the law references live inside the artifact that is archived by the TODO verification block.
- **Reporting cadence** – Branch log and merge report artifacts are referenced inside README/GOV so managers know which scripts produce the evidence, when they run (pre-close merges, post-close automation), and which laws the artifacts must cite (Merge Reporting Law, Merge Audit Law, Process Integrity Law). The merge report filename is captured in `TODO.complete.md`, and the branch log is referenced in the TODO verification entry so each closure leaves a traceable audit state.

## Merge-Report Retention Policy
- **Canonical** merge reports are the latest reports associated with each completed TODO closure; they cite the Merge Reporting, Process Integrity, and Versioning & Incident Logging laws, remain in `git/merge-reports/`, and are referenced from `TODO.complete.md` so reviewers can trace every merge back to the governing laws.
- **Redundant** merge reports include older archives that still show law citations; they may be moved to `git/merge-reports/archive/` only after a governed archival TODO documents the rationale, impacted files, and the new guardian law. Such archival preserves a pointer in `TODO.complete.md` to the archive list so the history stays auditable.
- **Disposable** reports are bootstrap artifacts (created before the policy existed) and may be pruned only through a dedicated TODO that explicitly lists the candidates for removal, the archival storage location, and the automation that recorded the change.
- **Per-TODO minimum:** Every completed TODO must reference at least one merge report (target + branch) in `TODO.complete.md`, naming the report file so the canonical Version Artifact section remains discoverable.
- **No ad-hoc deletion:** Merging artifacts or removing reports outside of such governed TODOs is forbidden; the policy requires that the deletion/archival step itself is documented as a TODO, runs the automation trio, and leaves the archive directory ready for future governance work.

## Infrastructure & Multi-Server Topology
- **Environments:** Local, dev, staging, and production each enforce different guard rails: dev/staging mirror integration clusters with shared services/logging, while production binds to hardened master clusters with scaled automation and stricter access. Document the routing, secret management, and telemetry expectations per environment so operations teams can predict how deployments behave across the stack.
- **Service split:** Marketing, dashboard/apps, integrations, and worker automation each live in their own clusters/pods. Clarify which clusters share identity/auth, where ledger/app data resides, and which pods ingest observability/automation traces so deployment plans stay deterministic.
- **Database strategy:** Outline the partitioning model (shared ledger vs. tenant-specific shards), the role of read replicas, backups, and the migration cadence. Note that migrations must run verification automation (Process Integrity, Git Automation) before closing, and that documentation updates should reference the deterministic version/compatibility laws so the sweeps can warn about drift without blocking guards tied to canonical queue entries.
- **Network boundaries:** Describe subdomains, routing rules, auth/marketing boundaries, and cross-cluster isolation so teams know how traffic flows and what law-driven restrictions (e.g., Git Workflow, Canonical Artifact) gate each surface.

## App Marketplace & Atlas Readiness
- **Marketplace criteria:** The App Marketplace & Atlas Readiness Law (see `authority/laws.md`) governs how apps enter the catalog: describe service-level expectations, integration testing requirements, MicroMDM/Atlas policy bindings, and automation signoffs before awarding a go-live tag. Document the guard rails in this README plus the app’s `*.details.md` (the template uses `Cinedex.details.md` as the sample), record the relevant queue/roadmap notes, and cite the law so future auditors can trace each marketplace entry.
- **Atlas integration guard rails:** Atlas clusters must enforce service account isolation, API boundaries, data residency, and multi-region replication plus telemetry. MicroMDM policies accompany every Atlas release, instrumentation logs capture data flows, and the Batch Verification Law ensures `scripts/update_tree.sh` reruns after these constraints shift so automation outputs stay discoverable in `TREE.md`.
- **Automation references:** Queue entries and roadmap notes reference the law, describe the automation scripts (`scripts/update_tree.sh`, `scripts/git-merge-report.sh`, `scripts/git-branch-log.sh`) that prove Marketplace & Atlas readiness, and include the Observability instrumentation metadata so the Git & Branch Tracking worker sees consistent guard rails before the next iteration merges.

## Git-Ready Notification
- When the Process Integrity, Roadmap Sync, and Version Sync gates all pass and no active TODO exists yet local changes remain, Codex prints a single “Approval Required” notice, logs it, and stops. Human approval artifacts must appear before the merge proceeds; rerun `scripts/process-integrity-sweep.sh` to clear the gate once approval lands. This keeps approval human-controlled while every other enforcement is automated.

-## Derived App Compatibility Rules
- Every derived app explicitly records the minimum supported platform version and the maximum version it knows how to handle. These ranges must be referenced in the app's governance docs and published alongside the compatibility matrix so operators know which releases require upgrades.
- Apps must refuse to run against unknown MAJOR platform versions; new MAJOR releases always require a coordinated upgrade wave. Apps may warn (not fail) on newer MINOR, MICRO, or PATCH versions, but compatibility testing must cover the known range before the warning becomes a failure.
- Define `COMPATIBILITY.md` as the future artifact that lists the platform version and per-app compatibility matrix for auditability. For now, mention the contract in README/GOVERNANCE and prepare the artifact later when a dedicated TODO scopes the work.
- The compatibility rules reinforce the Versioning & Incident Logging Law, the Canonical Artifact Law, and the Git Automation Law so everyone knows when their app is “out of sync” with the deterministic platform state.
- **App compatibility enforcement:** Apps declare `minPlatformVersion` and `maxTestedPlatformVersion`; a MAJOR mismatch blocks shipment, a MINOR mismatch surfaces warnings to operators, and MICRO/PATCH mismatches stay informational while still logged. This enforcement layers on the Deterministic Versioning Law so version gaps are visible without manual guesswork.

## Deterministic Versioning & Compatibility Blueprint
- **Deterministic Versioning Law:** Every TODO completion updates `VERSION.md` (PATCH for governance-only, MICRO or higher for implementation, larger jumps when declared) so the canonical release string remains unique; the Manager Automation Hardening Law ties compliance to the closeout checklist, and the Non-Interruptible TODO Execution Law forbids closing without the new version.
- **Version Compatibility Contract Law:** Apps declare `minPlatformVersion` and `maxTestedPlatformVersion`, cite the compatibility matrix (`COMPATIBILITY.md` once created), and consult the law before shipping; compatibility gaps use the Platform Compatibility Enforcement Law to decide whether to block, warn, or inform.
- **Standard Update Flow:** TODO close → verification suite → bump `VERSION.md` (metadata includes previous version, new version, bump type, triggering TODO, compatibility notes) → capture merge report + governing laws → notify apps and process watchers so they auto-update, warn, or block per the compatibility contract.
- **Manager Automation Hardening Law:** Managers confirm the version bump, verification logs, roadmap/queue/todo alignment, and Non-Interruptible Law before signing off so deterministic releases stay reliable.
- **Non-Interruptible TODO Execution Law:** Once activation occurs, the run must finish with verification and closure; no partial states, and closure is invalid if `VERSION.md` was not updated to the canonical string.

## Non-Interruptible TODO Execution
- **Law:** The Non-Interruptible TODO Execution Law forbids pausing mid-TODO. Once activated, Codex must finish the TODO, run all required verification, and close it before touching another task. Closing is illegal if `VERSION.md` wasn’t updated; the Manager Closeout Checklist now enforces that every completion bumps the canonical version string.

## Standard Update Flow
1. A TODO completes and records its verification scripts plus the merge report filename.
2. `VERSION.md` is bumped to the new MAJOR.MINOR.MICRO.PATCH value with metadata about the bump type, triggering TODO, and any compatibility notes.
3. The merge report cites `VERSION.md` in the Version Artifact section and lists the governing laws.
4. Apps detect a version delta and consult their compatibility matrix (`COMPATIBILITY.md` when available) to decide whether to auto-update, warn users, or block the session (breaking changes only).
5. Automation logs, Phase/roadmap artifacts, and the Feature Registry all cite the new version so observers know every change traces back to a TODD-defined release.
6. Repeat the cycle for each TODO without introducing silent drift; this keeps upgrades predictable and coordination effortless.

## Observability & Telemetry Blueprint
- The instrumentation catalog lists metrics, traces, and logs per app/system so every signal (bookings, gear status, payroll writes, automation runs, LLM prompts) has a steward and verification tag.
- Observability automation ties Resend previews, smoke tests, React Flow renders, and telemetry samplers into a repeatable loop; each run logs scripts + law citations, feeds `scripts/logs/observability-runs.md`, and keeps `scripts/logs/sequencer-batch-042.md` ready for the Batch Verification Law.
- The Observability Playbook, Observability Automation Law, and Queue & Tree Automation law combine to standardize instrumentation across multi-server clusters: instrumentation metadata, automation outputs, notifications, and reliability signals are curated before a roadmap phase ships.
- Observability data is visible in Pulse dashboards, merge reports, automation logs, and the future Feature Lifecycle Status/Trace Graph so new and existing services remain measurable without guesswork.

## Marketing Refresh Loop
- The Marketing Refresh Loop (TODO-054) keeps the Resend preview automation tied to Email Integrity Law, Truth Governance Law, and the Roadmap Sync Gate by logging per-page automation plans in `marketing/status.md`, recording every vista in `scripts/logs/marketing-outreach-run.md`, and rerunning the full `scripts/process-integrity-sweep.sh` before each automation burst so hooks and logs stay in sync.
- Automation artifacts (preview scripts and the marketing status table) cite the Email Integrity Law + Truth Governance Law so the Authority & Compliance worker can trace the CTA/resend claims inside marketing verification reports and the Feature Registry marketing entries.

## Marketing Governance & Stewardship
- The **Marketing Steward** role keeps `marketing/status.md` honest: every marketing surface references `VERSION.md`, the active phase, and the current milestone. Drift (missing or mismatched platform versions) is logged to the Progress Watchdog so the Canonical Artifact, Process Integrity, and System Gap Surfacing laws stay visible even without automation blocking.
- Marketing content remains descriptive only; marketing does not gain execution authority, but it must cite the deterministic platform state defined in `VERSION.md` so public-facing messaging stays tethered to the canonical roadmap and observability signals.

## Observability Instrumentation & Automation
- **TODO Type Discipline:** Every TODO now declares Governance-Only or Implementation so the sequential pipeline skips governance entries and executes implementation work only when canonicalized.

- Observability automation covers instrumentation catalogs, automation runs, telemetry smoke tests, and Resend-based notifications. Each signal (bookings throughput, calendars, gear reservations, finance flows, LLM prompts) is mapped to scripts, owners, and verification steps inside the instrumentation catalog so automation outputs remain consistent across clusters.
- Observability runs log their scripts (`scripts/update_tree.sh`, Observability smoke tests, automation tracker entries) into `scripts/logs/observability-runs.md` for the Sequencer batch, and the Feature Lifecycle Status report surfaces instrumentation state for Pulse dashboards.
- Observability guard rails enforce truth governance (law references in automation logs), reliability (retry/alert policies), and UX (clean, modern notifications) before a roadmap phase launches.

## LLM Safeguards & Prompt Policy
- The **LLM Safeguards Law** and **Truth Governance Law** require every prompt or assistant interaction to describe its policy context, guard rails, and rate-limit posture before execution; these statements now live in README/GOVERNANCE so every normalized prompt references the same deterministic policy.
- Observability instrumentation captures sanitized prompt flows, hallucination checks, and rate-limit events so the Sequencer can cite the `scripts/logs/observability-runs.md` entry for TODO-058 when verifying the Observability Automation Law’s compliance with the prompt policy.
- Mention the LLM safeguards state in future TODOs: the next governance review will extend this instrumentation once TODO-058 closes, keeping the canonical queue as the single source for queued LLM guard rails.

## Execution Discipline
- The Prompt Normalization Law and Prompt Normalizer worker ensure every human prompt is normalized into a canonical execution contract before execution begins.
- The Executable TODO Law governs every TODO intake. Confirm each active TODO enumerates an Execution Scope checklist, lists every allowed file, states the objective, and shares the verification contract before the steward marks it live.
- The steward’s preflight checklist (Objective, Execution Scope, Allowed Files, Verification Contract) must finish before a TODO moves to active, and the workers halt with a law citation if the Execution Scope is missing or ambiguous.
- The Lifecycle Status model (Defined → Implemented → Verified) differentiates governance-only TODOs from implementation work; governance artifacts do not count as completion until a Verified tracker exists.
- A governance-only TODO may be labeled Defined and must spawn a corresponding implementation TODO (Implemented → Verified) unless the feature is explicitly documentation-only, per the Governance-to-Implementation Continuity Law enforced by the Feature Realization Auditor.
- Every TODO also declares machine-readable `Lifecycle` and `Criticality` fields so the queue and Pulse status report can audit lifecycle progression and severity.
- The System Health Report, Pulse lifecycle trend view, and Suggestion Law enforce that declared intent finds execution partners before the roadmap advances.
- `queue.md`, `ROADMAP.md`, and `TODO.md` remain synchronized around the active TODO and the upcoming queue so the steward/Sequencer can reference the Execution Scope before continuing.
- All automations rerun after law or TODO governance updates: `scripts/update_tree.sh`, `scripts/git-branch-log.sh`, and `scripts/git-merge-report.sh` keep `TREE.md`, `git/branches.md`, and `git/merge-reports/` aligned with the latest enforcement.

## Roadmap Sync Gate
- The Roadmap Sync Law describes the gate that keeps TODO/roadmap/queue/version artifacts aligned before closing work. Each close reruns `scripts/verify-roadmap-sync.sh` and `scripts/verify-version-sync.sh`, then the canonical automation trio (`scripts/update_tree.sh`, `scripts/git-branch-log.sh`, and `scripts/git-merge-report.sh master master`). Running `scripts/process-integrity-sweep.sh` executes the full gate suite, so use it for pre-close checks; failures append entries to `scripts/logs/error-incidents.md` so the Coordinator & Best Practices worker documents the drift before retrying. The canonical target branch for merges is `master`, so automation never guesses the destination.

## Handovers
Before concluding a session, ensure: `TODO.md` lists exactly one active TODO (or states none), `queue.md` shows only future work, `ROADMAP.md` reflects the stabilized progress, and the relevant verification scripts have been rerun. Record outcomes in `TODO.complete.md` so incoming agents inherit the deterministic history.
