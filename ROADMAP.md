# Platform Roadmap Reference

## Deterministic TODO Intake
- The Executable TODO Law requires every active TODO to present an explicit Execution Scope checklist, objective, allowed files, verification contract, Lifecycle, and Criticality before the steward activates it.
- The roadmap, queue, and TODO list reference this law so managers can trace scope via `authority/laws.md`, `GOVERNANCE.md`, and `CODEX.worker.md`.
- The intake law keeps the catalog structure oriented toward future work while the sequencer ensures each triple-TODO batch reruns `scripts/update_tree.sh`, `scripts/git-branch-log.sh`, and `scripts/git-merge-report.sh`.

## Human vs Executable Roadmaps
- `ROADMAP.md` captures the executable history and sequencing; `APP.ROADMAP.md` remains a descriptive “human view” that echoes those phases without controlling automation. Short-term drift is acceptable so long as the Process Integrity sweeps detect and correct it after each TODO close, and synchronization occurs whenever a TODO completes so canonical artifacts converge again.

## Audit Service Track
- The Audit Service operates as an always-on governance track that audits repository structure, governance, laws, workers, automation, queue/TODO consistency, versioning, observability, and template/app separation on every run. `scripts/run-audit.sh` regenerates `observability/audit/AUDIT.REPORT.md`, refreshes `AUDIT.METADATA.json`, and appends `scripts/logs/audit-runs.md` so the audit story is shareable with downstream apps, reviewers, and tools before any major template evolution. The roadmap calls out the audit service so managers know this track remains active alongside feature TODOs.
- Each roadmap refresh confirms the audit log’s latest run and ensures the audit metadata appears in the canonical artifact list; derived apps inherit the same audit scope, README guidance, and worker ownership described in the governance catalog.

## Prompt Normalization & Compiled TODO Pipeline
- The Feature Registry Compiler ensures every feature/state is cataloged; Pulse and roadmap gating consume the registry.
- The Trace Graph records upstream causes (laws/governance/roadmap) for each TODO.
- The Prompt Linter report blocks malformed prompts before normalization completes.

- Human intent flows through the Prompt Normalizer, which enforces the Prompt Normalization Law and yields Authority, Prompt Type, Objective, Constraints, Required Actions, Postflight Obligations, and Verification.
- Intent is compiled into canonical TODOs (ID, Title, Lifecycle, Criticality, Objective, Execution Scope, Allowed Files, Verification Contract, Post-Completion Expectations) before appearing in `queue.md` and `ROADMAP.md`.
- The Compiled TODO Pipeline and auditors ensure lifecycle continuity and criticality gating before execution.

## Pulse Feature Lifecycle Status
- **Report Name:** Feature Lifecycle Status
- **Purpose:** Surface which platform features remain Defined, which have implementation TODOs, and which reached Verified so Pulse dashboards reflect lifecycle health.
- **Data sources:** `TODO.md`, `TODO.complete.md`, `queue.md`, and `ROADMAP.md` provide governing and implementation TODOs plus verification dates.
- **Sections:** Defined only, Implemented but unverified, Verified; each entry lists the feature name, governing TODO(s), implementation TODO(s), lifecycle status, Criticality, and last updated date.
- The report lives in Pulse and references the Governance-to-Implementation Continuity Law to highlight gaps before new TODOs launch.

## Pulse Trend View
- **View:** Lifecycle Progression (Defined, Implemented, Verified) over time.
- **Purpose:** Reveal delivery momentum and lifecycle debt; show when Defined grows while Implemented/Verified lag.
- **Usage:** Feed the System Health Report and highlight how auditors inject corrective TODOs to unblock the roadmap.
- **Data sources:** `TODO.md`, `queue.md`, `TODO.complete.md`, `ROADMAP.md`.

## Advancement Gate
- Features are not complete until at least one TODO reaches Verified; the roadmap marks phases complete only when the Verified count increases.
- Roadmap advancement is blocked when Defined-only entries exceed documented thresholds or verification debt exists for critical systems.
- Auditors may inject corrective TODOs and hold the roadmap until lifecycle completeness is restored.

## Lifecycle Completeness
- The Feature Realization Auditor may insert corrective implementation TODOs when governance (Defined) entries lack implementation partners.
- The roadmap respects the Governance-to-Implementation Continuity Law so each phase advances only when both governance and implementation TODOs reach Verified status.
Times below are noted in MST (Arizona; UTC-7). The catalog runs in descending order so future/active TODOs appear first while completed work lists from highest number to lowest.
## Lifecycle Completeness
- The Feature Realization Auditor may insert corrective implementation TODOs when governance (Defined) entries lack implementation partners.
- The roadmap respects the Governance-to-Implementation Continuity Law so each phase advances only when both governance and implementation TODOs reach Verified status.

## TODO Catalog (reverse-chronological)


- **Queued work note:** Queued TODO numbers live only in `queue.md`; `ROADMAP.md` may summarize future phases but must not enumerate queued IDs.
- **Deterministic release note:** Deterministic Versioning (MAJOR.MINOR.MICRO.PATCH), Platform Compatibility Enforcement, and the Non-Interruptible TODO Execution laws keep this roadmap aligned with `VERSION.md`; every TODO close records the compatibility metadata so readers can trace the canonical release story without assuming execution authority.

## Phase 1 – Complete (Milestone)
- **Evidence:** TODO-058 (LLM safeguards review) and TODO-059 (App Marketplace + Atlas readiness) closed, added prompt/rate-limit observability, and documented marketplace/Atlas guard rails plus the deterministic version bump (0.3.5).
- **Status:** Milestone declared; the automation/LLM groundwork and marketplace readiness logs are in place.
- **Phase 1.5 note:** Phase 1.5 (Platform Template Extraction) is complete; TODO-TEMPLATE-001 generalized governance, automation, and law artifacts so this repo now serves as the reusable template while preserving the deterministic release story.

### Active TODO

## **TODO-000** (Idle placeholder)
  - Description: Idle placeholder that keeps canonical artifacts unchanged while the workspace waits for the next Executable TODO.
  - Status: <span style="color:green">Active</span> (Idle placeholder).
  - Date: <span style="color:gray">2026-02-06 13:30 MST</span>.
  - Notes: Every guard rail stays aligned while the Process Integrity and Canonical Artifact laws hold the roadmap steady before the next governance run.

### Completed TODOs (descending)

- **TEMPLATE-IDENTITY-SANITIZATION**
  - Description: Strip product-specific identity from the template, rename the root folder, sanitize docs/scripts, and bump VERSION.md to 0.3.8.0 without altering automation or governance behavior.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-06 14:25 MST</span>.
  - Notes: Renamed the repo folder to `app-platform-template`, sanitized marketing previews/logs/scripts/documentation text, updated `VERSION.md` to 0.3.8.0 with TEMPLATE-IDENTITY-SANITIZATION as the bump reason, reran the update_tree/roadmap-sync/version-sync/process-integrity scripts, and now a case-insensitive search for the former brand returns zero hits.

- **TODO-TEMPLATE-001**
  - Description: Platform Template Extraction & Normalization.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-06 13:30 MST</span>.
  - Notes: README/GOV/authority/worker catalogs now reference the platform template, CODEX roles stay app-neutral, and `features/FEATURE.REGISTRY.md` flags the workspace as Template-Ready so derived repos can copy the guard rails, customize their `*.details.md`, and rerun the canonical automation trio with the same deterministic release story (version bump 0.3.5 → 0.3.6 recorded in `VERSION.md`).
  - Reference: TODO-TEMPLATE-001 documents the template normalization run and the automation suite that proves the new artifact.
 
- **TODO-059**
  - Description: App Marketplace + Atlas readiness guard rails.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-06 10:51 MST</span>.
  - Notes: README/APP.details now document the integration criteria, the App Marketplace & Atlas Readiness Law guards the story, queue notes capture the automation references, and merge report `git/merge-reports/merge-report-master-20260206T174957Z.md` lists the deterministic version artifact (0.3.5 → 0.3.5.0) so the roadmap and Feature Registry describe the readiness story before future implementation waves.

- **TODO-058**
  - Description: LLM safeguards review, prompts & policies.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-06 10:40 MST</span>.
  - Notes: Prompt policies, rate-limit observability, and law references now appear in README/GOV, `scripts/logs/observability-runs.md`, and the version bump log; merge report `git/merge-reports/merge-report-master-20260206T173636Z.md` cites the deterministic release string (0.3.4 → 0.3.4.0), and the Feature Registry entry flags the LLM safeguards state before future iterations queue follow-ups.
- **TODO-057**
  - Description: Multi-server deployment readiness checklist.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-06 09:10 MST</span>.
  - Notes: Documented infrastructure topology, worker cluster stewardship, automation hooks, and compatibility updates across README/GOVERNANCE/APP.details/CODEX.worker; bumped `VERSION.md` to 0.3.3 and reran `scripts/verify-roadmap-sync.sh`, `scripts/verify-version-sync.sh`, `scripts/process-integrity-sweep.sh`, `scripts/update_tree.sh`, `scripts/git-branch-log.sh`, and `scripts/git-merge-report.sh master master` so the standard update flow proves multi-server readiness while the queue stayed future-only.
- **TODO-069** (Deterministic Versioning & Compatibility Enforcement)
  - Description: Enforce deterministic MAJOR.MINOR.MICRO.PATCH bumps, manager automation obligations, and the compatibility contract so every change stays traceable.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-06 08:50 MST</span>.
  - Notes: Added the deterministic versioning/compatibility blueprint to README/GOVERNANCE, expanded `VERSION.md` with the new schema/metadata, refreshed `authority/laws.md` plus CODEX manager/worker duties, captured merge report `git/merge-reports/merge-report-master-20260206T052335Z.md` referencing the new release string, and reran the canonical gates (`scripts/verify-roadmap-sync.sh`, `scripts/verify-version-sync.sh`, `scripts/process-integrity-sweep.sh`, `scripts/update_tree.sh`, `scripts/git-branch-log.sh`, `scripts/git-merge-report.sh`) so the standard update flow stays deterministic.
- **TODO-071**
  - Description: Per-Surface Versioning & Drift Enforcement.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-06 07:10 MST</span>.
  - Notes: Documented the surface version matrix, wired marketing/documentation version declarations, extended the Process Integrity sweep with drift warnings, and codified the supporting laws/workers so surfaces stay aligned with `VERSION.md` without blocking execution.
- **TODO-070**
  - Description: Marketing Governance & Drift Detection.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-06 06:20 MST</span>.
  - Notes: Introduced the Marketing Steward, bound `marketing/status.md` to `VERSION.md`, extended the Progress Watchdog with marketing drift triggers, added new marketing laws, and documented the Marketing & Public Surfaces track inside `APP.ROADMAP.md` so marketing becomes a governed but non-executing surface.
- **TODO-068**
  - Description: Phase Re-Sequencing, Progress & Milestone Governance.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-06 05:40 MST</span>.
  - Notes: Formalized the Phase Re-Sequencing template, completion percentages, and the Progress Watchdog so descriptive adjustments stay aligned without modifying canonical execution artifacts.
- **TODO-067**
  - Description: Merge-Report Retention & Archival Policy.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-06 05:15 MST</span>.
  - Notes: Documented canonical/redundant/disposable categories, codified the Merge-Report Retention Law, and reiterated that TODO.complete entries cite the canonical merge report file so audits can trace law references before archival work begins.
- **TODO-056**
  - Description: Git automation audit and merge-report backlog.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-05 20:47 MST</span>.
  - Notes: Documented the Git automation reporting blueprint, ensured README/GOV explain which scripts run while keeping the canonical queue intact, and reran `scripts/git-branch-log.sh` plus `scripts/git-merge-report.sh master codex/TODO-066-canonical-queue-enforcement` (report at `git/merge-reports/merge-report-master-20260206T034706Z.md`) so the merge report’s law section cites the Merge Reporting Law and Merge Audit Law.
- **TODO-066**
  - Description: Canonical Queue & Roadmap Authority Enforcement.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-05 19:30 MST</span>.
  - Notes: Removed non-canonical backlog enumerations, codified the canonical queue law, and enhanced `scripts/process-integrity-sweep.sh` so the Process Integrity gate detects queued IDs, fails the sweep, and logs incidents before closing; verification reran the Process Integrity, Roadmap Sync, Version Sync, tree, branch, and merge-report scripts (latest report `git/merge-reports/merge-report-master-20260206T023402Z.md`) so the canonical queue remains the single backlog.
- **TODO-060**
  - Description: Implement the platform versioning system, metadata schema, and bump rules defined by the governance documents.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-05 13:02 MST</span>.
- **TODO-055**
  - Description: Automation & Productivity tooling inventory.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-05 18:31 MST</span>.
  - Notes: Documented the Automation & Productivity inventory in `README.md`, `authority/laws.md`, and `ROADMAP.md`, captured the tooling list in `scripts/logs/automation-inventory.md`, and reran `scripts/process-integrity-sweep.sh`, `scripts/verify-roadmap-sync.sh`, `scripts/verify-version-sync.sh`, `scripts/update_tree.sh`, `scripts/git-branch-log.sh`, and `scripts/git-merge-report.sh master master` (latest report `git/merge-reports/merge-report-master-20260206T013125Z.md`) so the Process Integrity & Roadmap Sync laws plus the Version Sync Law remain aligned before the next automation wave.

- **TODO-065**
  - Description: Roadmap Sync Oversight & Approval-Gated Merge Monitoring.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-05 16:50 MST</span>.
  - Notes: Process Integrity Auditor oversight and `scripts/process-integrity-sweep.sh` now enforce the state-derived gate and queue normalization so the roadmap, queue, and version artifacts stay aligned before approval-gated merges.

- **TODO-064**
  - Description: Git Automation Hardening — Approval-Gated Merge Executor.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-05 16:30 MST</span>.
  - Notes: Roadmap Sync Law, the canonical master pipeline, and the approval executor now document the gate, approval artifacts, and merge-report traces; merge report `git/merge-reports/merge-report-master-20260205T233047Z.md` confirms the Version Artifact (`VERSION.md`) while the canonical scripts enforce single active TODO.

- **TODO-063**
  - Description: Pulse Ingestion Verification.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-05 16:14 MST</span>.
  - Notes: Ingestion verification doc, Feature Registry update, observability log entry, and merge report `git/merge-reports/merge-report-master-20260205T231404Z.md` now tie the runtime wiring catalog and VERSION.md artifact to Pulse dashboards and the System Health Report.

- **TODO-062**
  - Description: Instrumentation Runtime Wiring.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-05 13:32 MST</span>.

- **TODO-054**
  - Description: Marketing refresh loop with Resend previews.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-05 17:42 MST</span>.
  - Notes: Automation wiring (hooks, `scripts/run-safe.sh`, `scripts/git-sync.sh` baseline commit) now protects the marketing refresh loops; marketing automation logs plus the merge report `git/merge-reports/merge-report-master-20260206T003406Z.md` document the Resend preview plans tied to Email Integrity + Truth Governance before the Process Integrity sweep (`scripts/process-integrity-sweep.sh`, `scripts/verify-roadmap-sync.sh`, `scripts/verify-version-sync.sh`) and canon automation trio (`scripts/update_tree.sh`, `scripts/git-branch-log.sh`, `scripts/git-merge-report.sh master master`) confirmed the version artifact and queue alignment.

- **TODO-046**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 10 MST</span>.

- **TODO-045**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 10 MST</span>.

- **TODO-044**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 10 MST</span>.

- **TODO-043**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 10 MST</span>.

- **TODO-042**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 11 MST</span>.

- **TODO-041**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 11 MST</span>.

- **TODO-040**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 11 MST</span>.

- **TODO-039**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 11 MST</span>.

- **TODO-038**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 12 MST</span>.

- **TODO-037**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 12 MST</span>.

- **TODO-036**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 12 MST</span>.

- **TODO-035**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 12 MST</span>.

- **TODO-034**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 13 MST</span>.

- **TODO-033**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 13 MST</span>.

- **TODO-032**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 13 MST</span>.

- **TODO-031**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 13 MST</span>.

- **TODO-030**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 14 MST</span>.

- **TODO-029**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 14 MST</span>.

- **TODO-028**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 14 MST</span>.

- **TODO-027**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 14 MST</span>.

- **TODO-026**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 15 MST</span>.

- **TODO-025**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 15 MST</span>.

- **TODO-024**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 15 MST</span>.

- **TODO-023**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 15 MST</span>.

- **TODO-022**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 16 MST</span>.

- **TODO-021**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 16 MST</span>.

- **TODO-020**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-24 16 MST</span>.

- **TODO-019**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 16 MST</span>.

- **TODO-018**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 17 MST</span>.

- **TODO-017**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 17 MST</span>.

- **TODO-016**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 17 MST</span>.

- **TODO-015**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 17 MST</span>.

- **TODO-014**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 18 MST</span>.

- **TODO-013**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 18 MST</span>.

- **TODO-012**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 18 MST</span>.

- **TODO-011**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 18 MST</span>.

- **TODO-010**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 19 MST</span>.

- **TODO-009**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 19 MST</span>.

- **TODO-008**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 19 MST</span>.

- **TODO-007**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 19 MST</span>.

- **TODO-006**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 20 MST</span>.

- **TODO-005**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 20 MST</span>.

- **TODO-004**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 20 MST</span>.

- **TODO-003**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 20 MST</span>.

- **TODO-002**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 21 MST</span>.

- **TODO-001**
  - Description: placeholder due to onboarding state.
  - Status: <span style="color:gray">Completed</span>.
  - Date: <span style="color:gray">2026-02-04 21 MST</span>.

## Phase Sequence Outline (summary)
- **Phase detail** – ...

## Parallel tracks & guard rails
- **Placeholder** – ...
