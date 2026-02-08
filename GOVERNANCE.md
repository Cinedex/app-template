# Platform Template Governance

This CONTROL + ORCHESTRATION template workspace follows deterministic rules and references the `authority/laws.md` catalog before any implementation touches production code, UI, automation, or infrastructure. The authority folder is the single source of law, and every new idea, roadmap update, or TODO must cite the relevant statute before proceeding.

## Execution Rules
1. Work is deterministic; do not act without a written rule, TODO, or explicit governance statement (see `authority/laws.md` for the current law list). No ad-hoc moves, verbal agreements, or guesswork.
2. TODOs drive execution—each new goal must include a goal statement, allowed files, constraints, and verification criteria. Follow-on tasks or automation must be documented before they become active.
3. All decisions are written before implementation. Document choice dependencies in governance, the roadmap, or the TODO; nothing is implied or assumed.
4. Every change must reference an active TODO, and verification must appear inside that TODO or in a linked log. Do not mutate governance or roadmap without tying the change back to the law catalog and the active TODO.
5. Before working, consult `ROADMAP.md`, `queue.md`, `TREE.md`, and the active TODO; all must be updated if scope, priority, or structure shifts.
6. Work happens in batches of three sequential TODOs: the Sequencer & Batch Oversight worker waits for the third TODO in the sequence to finish before committing the batch's verification notes, law citations, and automation logs as a single report, keeping the workflow lean while obeying the Batch Verification Law.
7. The Steward Preflight Checklist (Objective, Execution Scope, Allowed Files, Verification Contract) must be satisfied before any TODO moves from queue to active status, per the Executable TODO Law.

## Canonical Queue Authority
- `queue.md` is the single authoritative ledger of queued TODO numbers; any enumerated “Queued TODOs” list elsewhere (including `ROADMAP.md`) is non-canonical per the Canonical Artifact Law, Roadmap Sync Law, and Process Integrity Law. The roadmap may describe future phases but must reference `queue.md` rather than restating the queue, and workers reconcile their backlog language against `queue.md` before editing roadmap or governance artifacts so no independency drifts arise.
- The Process Integrity Auditor enforces this invariant—`scripts/process-integrity-sweep.sh` scans `ROADMAP.md`, fails the gate, and logs the violation to `scripts/logs/error-incidents.md` whenever queued IDs appear outside `queue.md`; the auditor blocks TODO closure until the backlog is canonical so the single-active-TODO, Canonical Artifact Law, Roadmap Sync Law, and Process Integrity Law stay linked to the sweep gun.

## Infrastructure & Multi-Server Topology
- **Environments:** Document what differs between local/dev/staging/prod clusters (routing, secrets, telemetry) so managers know which guard rails apply. Production enforces hardened access, scaled automation, and canonical version pinning; dev/staging mirror integration clusters with shared services/logging. Append environment notes to infrastructure sections so the Process Integrity sweep can detect drifts without blocking non-canonical queue entries.
- **Service segmentation:** Split clusters by marketing, dashboard/apps, automation/workers, and integration services. Clarify shared identity/auth hosts, ledger/app data zones, and observability/automation pods so deployments stay deterministic when new services spin up or migrate across clusters.
- **Database & migration strategy:** Describe partitioning (shared ledger vs. tenant shards), read replicas, backups, and the multi-server migration checklist. Governance states that migrations must rerun automation (`scripts/update_tree.sh`, merge-report, branch log) and tie documentation updates to deterministic version/compatibility laws so the sweeps warn on documentation drift but only block when canonical queue invariants break.
- **Network boundaries:** Outline subdomains, routing, and auth perimeters so operations teams know where traffic isolates and which clusters trust the same secrets. Document cross-cluster service calls, API key scopes, and isolation policies so watchers can trace multi-server readiness across networks.
- **Automation hooks and enforcement:** Infrastructure updates run the Process Integrity sweep; documentation drift triggers warnings, while queue misalignment or missing version bumps block closure. Clarify which sections warn (surface version mismatch) versus block (canonical queue violation) so teams keep automation logs and law references consistent while updating topology notes.

## Phase Re-Sequencing Template
1. **Purpose:** Document intentional phase re-sequencing without touching execution artifacts. It explains the reason for the change, the impacted phases/micro-tracks, and the narrative updates inside the template’s human roadmap file (this workspace uses `APP.ROADMAP.md` as the sample).
2. **Non-authority:** It does not activate or close TODOs, reorder `queue.md`, alter execution flow, or bypass any verification law. Execution remains governed by `TODO.md`, `queue.md`, and automation gates.
3. **Inputs:** reason for the re-sequencing, before/after phase mappings, impacted micro-tracks, and confirmation that execution order remains canonical.
4. **Outputs:** updated phase descriptions, milestone placement notes, refreshed completion percentages, and a timestamped narrative inside the template’s human roadmap file (sample `APP.ROADMAP.md`).
5. **Verification:** canonical artifacts must remain unchanged, the template must appear in README and this governance section, the template’s human roadmap file (`APP.ROADMAP.md` in this repo) must capture the updates, and `scripts/update_tree.sh` must rerun the next time governance changes occur.
6. **Authority:** this template is the only legal mechanism for phase re-sequencing so the Canonical Artifact Law, Roadmap Sync Law, and Process Integrity Law stay aligned.

## Progress Watchdog
- **Role:** A conceptual governance observer that detects stagnation, queue inflation, or static completion percentages without executing work.
- **Triggers:** unchanged active TODO across multiple cycles, phase completion percentages that never move after TODO closes, governance-only TODOs without implementation follow-ups, or queue growth that outpaces completion.
- **Actions:** log a warning (with Canonical Artifact, Process Integrity, and System Gap Surfacing law citations) in `scripts/logs/error-incidents.md` or similar logs, recommend corrective governance TODOs, and never touch automation.
- **Visibility:** Referenced in `CODEX.worker.md` and this governance catalog so future agents understand the watchdog’s findings before acting.
- **Marketing drift watch:** The watchdog also monitors marketing-specific mismatches—version references in marketing artifacts that differ from `VERSION.md`, marketing copy that claims future milestones not yet gated by canonical TODOs, or marketing claims referencing features absent from `ROADMAP.md`/`TODO.md`. Warn the manager, recommend a governance TODO, and log the discrepancy; the watchdog still never executes work itself.

## LLM Safeguards & Prompt Policy
- **Prompt policy:** The LLM Safeguards Law (with Truth Governance enforcement) requires every prompt/policy template to document guard rails, truth sources, and rate-limit posture before execution; this policy appears in README/GOVERNANCE so normalized prompts cite the same deterministic guidance and obey the Execution Rules.
- **Observability wiring:** Observability instrumentation now logs sanitized prompts, hallucination checks, and rate-limit telemetry inside `scripts/logs/observability-runs.md` (see TODO-058); the audit log references the Observability Automation Law while the Process Integrity Auditor confirms the log before admitting the next LLM TODO into the queue.
- **Continuity:** Future governance follow-ups will expand this instrumentation and describe the next queued LLM iteration; until then, these notes keep the canonical queue as the single source for queued LLM guard rails so the Process Integrity and Canonical Artifact laws stay intact.

## Marketing Truth & Drift Enforcement
- **Marketing Steward:** The Marketing Steward worker logs every marketing surface reference to `VERSION.md`, validates the active phase/milestone citations, and records drift warnings with the Progress Watchdog; the steward does not publish messages, run automation, or touch platform code—its job is observation and logging.
- **Drift definition:** Marketing artifacts missing a `VERSION.md` citation, citing outdated versions, or referencing uncompleted TODOs count as drift. Drift incidents must be logged before any sequential TODO closes so governance visibility includes the marketing lifecycle, even though the drift does not block execution.

## Documentation Versioning
- **Documentation Version:** 0.3 (per `VERSION.md` platform MAJOR). Each documentation surface must mention this value so the Process Integrity sweep can verify MAJOR parity and surface warnings for drift.
- **Warnings vs blocking:** Drift warnings generated by the Process Integrity sweep do not block TODO activation; instead, they log incidents and feed the Progress Watchdog so governance can schedule corrective TODOs as needed.
- **Surface note:** Surface version declarations remain compatibility signals only; the canonical version continues to live in `VERSION.md` and drives automation gating.

## Git-Ready Notification Rule
- When no active TODO exists, the Process Integrity, Roadmap Sync, and Version Sync gates all pass, and git reports unmerged/uncommitted changes, Codex logs the condition, prints a single “Approval Required” notice, and halts. Human approval remains the only way forward; once an approval artifact lands, rerun `scripts/process-integrity-sweep.sh` to reconfirm the gates before merging. This links the Git Workflow & Approval Law to the canonical queue enforcement so Codex never goes silent when merge readiness requires a human hand.

## Derived App Compatibility Rules
- Every app declares the minimum supported platform version and the maximum tested version; these ranges appear in the compatibility matrix referenced by the Version Compatibility Contract so operators know when upgrades are required.
- Apps must refuse to run against unknown MAJOR versions; newer MINOR/MICRO/PATCH versions may trigger warnings but not automatic failure unless the compatibility matrix explicitly disallows them.
- Mention `COMPATIBILITY.md` as the future artifact that documents the platform version and per-app compatibility matrix; its creation will be governed by a dedicated TODO so the artifact stays audit-ready.
- These rules reinforce the Versioning & Incident Logging Law, the Canonical Artifact Law, and the System Gap Surfacing Law so version-state coordination never depends on human recollection or inconsistent signals.
- **App compatibility enforcement:** Apps publish `minPlatformVersion` and `maxTestedPlatformVersion`. A MAJOR version mismatch blocks deployment, a MINOR mismatch warns the operator, and MICRO/PATCH drift remains informational but recorded. The Deterministic Versioning Law ensures these tolerances are enforced, while the new Platform Compatibility Enforcement Law documents how apps should react when the platform version jumps.

## Deterministic Versioning & Compatibility Blueprint
- **Deterministic Versioning Law:** Every TODO completion bumps `VERSION.md` (PATCH for governance-only, MICRO or higher when declared) so the canonical string remains unique; the Manager Automation Hardening Law ties it to the closeout checklist so closes always include the new version.
- **Version Compatibility Contract Law:** Apps declare `minPlatformVersion`/`maxTestedPlatformVersion`, reference the compatibility matrix (`COMPATIBILITY.md` when created), and follow the Platform Compatibility Enforcement Law to block/warn/inform when version gaps appear.
- **Standard Update Flow:** Close a TODO, run the verification suite, bump `VERSION.md` (metadata includes previous version, new version, bump type, triggering TODO, compatibility notes), capture the merge report with governing laws, and notify apps via the compatibility contract so they auto-update, warn, or block per policy.
- **Non-Interruptible TODO Execution Law:** Once activated, a TODO must execute, verify, and close in a single run; the law forbids pausing midstream, and closure without the version bump violates the Deterministic & Manager Automation Hardening laws.
- **Manager Automation Hardening Law:** Managers confirm the version bump, verification logs, roadmap/queue alignment, and Non-Interruptible law before marking a TODO complete so deterministic releases stay reliable.

## Non-Interruptible TODO Execution
- The Non-Interruptible TODO Execution Law codifies that once Codex activates a TODO (see TODO-069), the run must complete—execution, verification, and closure happen before any other TODO is touched. Managers may not pause midstream, and closure is invalid if `VERSION.md` has not been updated to the canonical release string; this deterministic requirement keeps Versioning Law enforcement bound to every TODO cycle.

## Standard Update Flow
1. Close the TODO, run the verification suite, and capture the merge report filename plus the governing laws inside the completion note.
2. Bump `VERSION.md` to the new MAJOR.MINOR.MICRO.PATCH string, record the bump type, triggering TODO, compatibility notes (if any), and prior version.
3. The merge report reads `VERSION.md` for the Version Artifact section and cites the Merge Reporting, Process Integrity, and Versioning & Incident Logging laws.
4. Apps detect version deltas, consult their compatibility ranges, and decide whether to auto-update, warn users, or block on breaking changes.
5. Phase artifacts, the Feature Registry, and observability logs cite the same version string so auditors see a consistent release story.
6. Repeat the cycle for every TODO so the platform stays deterministic and traceable.

## Git Automation Reporting Blueprint
- **Branch log runs** – `scripts/git-branch-log.sh` reruns before/after every git action and rewrites `git/branches.md` with the active TODO, workspace status, branch inventory, and recent commits so “Git logs match the documented workflow” can be verified when closing TODO-056. The automation is referenced inside verification checklists so the Branch Tracking worker records the log path and ensures the law references (Git Workflow Law, Merge Reporting Law) stay aligned.
- **Merge report runs** – `scripts/git-merge-report.sh master <source>` runs before any human-approved merge and again afterward; the report now includes a “Governing Laws” section listing the Merge Reporting Law and Merge Audit Law so the artefact explicitly cites the statutory obligations that the merge fulfills. TODO verification blocks must capture the merge report filename and the law references so the Process Integrity and Merge Reporting laws stay satisfied.
- **Reporting cadence** – Managers use this blueprint to know which scripts produce the branch log and merge report, when they run (pre-close merges, verification reruns), and which laws get cited (Merge Reporting Law, Merge Audit Law, Process Integrity Law). The branch log is referenced inside the TODO verification entry, the merge report is archived in `TODO.complete.md`, and the canonical roadmap/queue mention the audit state so the entire audit story stays traceable.

## Merge-Report Retention Policy
- Canonical reports stay in `git/merge-reports/`, cite the Merge Reporting, Process Integrity, and Versioning & Incident Logging laws, and must be referenced by TODO completion entries so audits can find the Version Artifact every time.
- Redundant reports move to `git/merge-reports/archive/` only when a governed TODO documents the archival plan, lists the affected files, and notes how the archive remains discoverable.
- Disposable (bootstrap-era) reports may be pruned only through a dedicated governance TODO that enumerates the candidates, cites the law references, and describes the automation/verification steps captured alongside the deletion.
- Every completed TODO must cite a merge report filename in `TODO.complete.md`; the canonical entry names the file produced prior to closing and records the law references so the merge logs remain discoverable.
- Deletion/archival without a TODO is forbidden; only an explicit governance TODO may relocate, archive, or delete reports, ensuring the Process Integrity and Canonical Artifact laws stay aligned.

## Steward Preflight Checklist
Before a TODO can be marked active, the steward must verify the following elements exist and align with the new law:
- **Objective:** a clear statement of why this TODO exists.
- **Execution Scope:** an enumerated, concrete checklist of deliverables and touched artifacts (no vague terms).
- **Allowed Files:** the precise list of files/modules the TODO may modify.
- **Verification Contract:** the automation/scripts and verification notes that prove compliance.

If any preflight item is missing, the Steward pauses activation until the TODO receives the missing detail; a TODO without Execution Scope is invalid and cannot be executed.

## Execution Scope Enforcement

## Lifecycle Status Model
+- **Defined:** Governance, rules, or blueprints created (documentation-only).
+- **Implemented:** Functional systems, automation, or code delivered.
+- **Verified:** Implementation validated, monitored, and in use.
+
+Governance TODOs are in the Defined state and must spawn implementation TODOs (Implemented → Verified) unless explicitly documentation-only, per the Governance-to-Implementation Continuity Law.
+The Feature Realization Auditor tracks these lifecycle transitions, ensuring every Defined feature moves through Implementation and Verification before it is considered complete.

The Executable TODO Law is its own guardrail. Workers begin work only after the execution scope is present. If a worker encounters a missing or ambiguous Execution Scope, the worker halts immediately, documents the gap, and cites the law before requesting clarification. No inference, assumption, or workaround is permitted; the law requires the scope to be explicit, enumerated, and tied to the required files.

## System Health Report
- **Purpose:** Provide a deterministic view of structural completeness by tracking lifecycle coverage, governance drift, verification debt, and auditor actions.
- **Sections:**
  1. Lifecycle Coverage – list features by lifecycle state (Defined only, Implemented, Verified).
  2. Governance-Only Drift – highlight features defined in laws/governance with no implementation TODOs.
  3. Implementation Without Verification – surface implemented features lacking verification TODOs.
  4. Verification Debt – record Verification TODOs blocked by missing prerequisites.
  5. Auditor Actions – summarize corrective TODOs injected by auditors since the last report.
- **Data sources:** `TODO.md`, `TODO.complete.md`, `queue.md`, and `ROADMAP.md`.
- **Enforcement:** Cite the System Gap Surfacing (Suggestion) Law when gaps appear and ensure auditors deliver the report before roadmap advancement.

## Verification TODO Rule
- Any TODO with `Lifecycle = Implemented` must have a corresponding Verification TODO targeting `Lifecycle = Verified`. If none exists, an auditor (e.g., Feature Realization Auditor) generates one automatically with an explicit Execution Scope and verification contract.
- Verification TODOs focus on confirming correctness, enforcement, and runtime presence without re-implementing the feature.

## Authority & Law Catalog
- The `authority/` folder hosts `laws.md`, our exhaustive catalog of laws (UI Integrity, Email Integrity, Auth Governance, Git Workflow, Observation, etc.). Managers must cite the relevant law when drafting a TODO; workers must reference the law when reporting verification.
- Every law entry includes its summary, the files it governs, the required automations, and the verification steps that prove compliance; use the `authority/laws.md` table to trace decisions before filing TODO verification.
- When adding laws, update `authority/laws.md`, note the change inside the pending TODO, and rerun `scripts/update_tree.sh` so the tree captures the new artifact along with the single-active-TODO assertion.

## Documentation & Verification Discipline
- Maintain tight coupling between governance, roadmap, and TODOs; if a change touches multiple files, explain the linkage immediately so the workspace stays coherent.
- Verification outcomes belong inside the TODO or a dedicated verification log referenced by the TODO; include law citations so the next manager can trace compliance.
- Review these governance rules regularly to confirm the deterministic, document-first workflow is intact.

-## Roadmap Sync Gate
- The Roadmap Sync Law defines a hard gate: no TODO may move to `TODO.complete.md` until this gate passes. Before every close, run the gate automation suite (`scripts/verify-roadmap-sync.sh`, `scripts/verify-version-sync.sh`, `scripts/update_tree.sh`, `scripts/git-branch-log.sh`, and `scripts/git-merge-report.sh <canonical-branch> <canonical-branch>`); `scripts/process-integrity-sweep.sh` packages those steps into one command for the auditor. The gate ensures `TODO.md` lists exactly one active TODO, `TODO.complete.md`’s most recent entry matches the new completion, `ROADMAP.md` marks the same TODO as active/completed, `queue.md` stays future-only, and `VERSION.md` (if present) points to the bumping TODO while the merge report revisits the same artifact. Any drift is logged into `scripts/logs/error-incidents.md` and must be remediated before rerunning the gate.
- The gate is enforced by the Sequencer & Batch Oversight worker and cited in the Roadmap Sync Law; failure to pass halts progress and requires the coordinator to detail remediation steps so the next run starts from a synchronized baseline.

## Codex Manager Mandate
- Managers orchestrate the workspace: they define TODOs, assign workers, scope files, and enforce verification without writing implementation code.
- Bundle related work into single TODOs when possible so teams finish batches in one pass instead of fragmented back-and-forth updates.
- Validate goals, success criteria, automation opportunities, and dependencies before activating a TODO so workers execute with clarity.
- Seek automation and productivity: favor TODOs that trigger scripts, scheduled runs, or verification automations so manual effort shrinks.
- If a task can be batched (documentation, blueprint, verification), document every piece in one comprehensive TODO and include the automation checklist that enforces it.
- Minimize reporting overhead by keeping status updates in TODO verification entries, avoiding redundant discussions, and finishing tasks (or documenting blockers) before new updates appear.

## Automation & Productivity Mandate
- Automate repeated governance actions; if an action can be scripted or scheduled, capture the automation in a TODO and include how to rerun it.
- Refer to the automation programs inside TODOs and highlight their outputs when they alter workflow.
- Batch documentation, blueprinting, and verification steps into single-deterministic cycles so workers can complete them without waiting for follow-ups.

## Audit Service
- The Audit Service is a governed platform capability; deterministic audits must run before any major template evolution, governance rewrite, or roadmap phase shift so the Process Integrity, Versioning, and Audit Integrity laws stay aligned. Workspaces inherit the same audit artifacts (`observability/audit/AUDIT.README.md`, `AUDIT.SCOPE.md`, `AUDIT.REPORT.md`, `AUDIT.METADATA.json`, `scripts/run-audit.sh`, and `scripts/logs/audit-runs.md`) and the same workers (Audit Steward, Governance Auditor, Automation Auditor, Template Integrity Auditor) described in `CODEX.worker.md`.
- The audit runner guards the template state: it asserts a clean git tree, captures `git status`, `git rev-parse HEAD`, and `VERSION.md`, regenerates `AUDIT.REPORT.md` deterministically, refreshes `AUDIT.METADATA.json`, and appends the standardized log entry so reviewers (including ChatGPT) can understand every audit without oral context.
- The Process Integrity Auditor, Governance Auditor, and Template Integrity Auditor enforce the audit scope, block TODOs when the snapshot is stale, and keep the audit metadata/logs current; the Sequencer and Automation Auditor confirm `scripts/update_tree.sh` ran after each audit so `TREE.md` captures `observability/audit/` and the log/metadata files.
- This governance mandate also appears in `ROADMAP.md` (Audit Service track) and `authority/laws.md` (Audit Integrity Law) so downstream apps inherit the mandatory audit before any template shaping change.

## Batch Completion Oversight
- The Sequencer & Batch Oversight worker tracks every trio of sequential TODOs and delays the final documentation/verification report until the third task closes. This ensures we honor the Batch Verification Law while avoiding redundant daily reporting.
- After the third TODO finishes, the Sequencer gathers the automation logs, queue updates, law references, merge reports, and verification notes and records them in the latest TODO's verification block plus any dedicated log; `scripts/update_tree.sh` reruns to capture the state, and the triple-cycle summary is appended to `TODO.complete.md`. The Sequencer also confirms the Queue & Tree Automation Law was satisfied before closing the batch.
- The Coordinator & Best Practices worker reviews the roster and scheduled assignments before each batch, flags idle or overlapping roles, and records the findings in `scripts/logs/worker-coordinator.md` so each TODO documents why the roster looks the way it does.
- If a TODO fails or a law is broken within the trio, stop the cycle, resolve the issue, and only then restart the next batch; do not promote a new TODO until the Sequencer confirms the batch's combined verification is recorded and the queue is updated.

## Folder Structure Workflow
- Grow folders intentionally: only create directories/subfolders when a TODO documents the need and the allowed files list references them.
- Document each directory’s purpose in README or governance, then rerun `scripts/update_tree.sh` to surface the change; the script enforces the single-active-TODO rule.
- Name directories consistently (lowercase, hyphenated, descriptive) and include their introduction in the TODO verification so the structure remains comprehensible.

## Handoff Protocol
- Every manager should be able to pass the workspace to another Codex instance without extra dialogue: keep README, TODO, `TODO.complete.md`, `TREE.md`, and automation scripts current; ensure TODOs explain goals, files, and verifications, and append any automation rerun instructions.
- When handing off, confirm `ROADMAP.md`, `queue.md`, and `TREE.md` reflect the current state alongside README/TODO so the next manager sees priorities, structure, and automations in one place.
- Run `scripts/update_tree.sh` before handing off so the tree lists the newest files/folders, and log the last verification inside `TODO.complete.md` so nothing is assumed.
- Treat the README’s Workspace Intelligence section and the completed TODO log as the primary handoff artifacts; new agents read them first to understand the current state, queue, and guard rails.

## Blueprint Mandate
- Before launching work on a phase, capture its architecture, workspace flows, governance hooks, UI/data expectations, and resilience points in a blueprint.
- Blueprints explain how shared services (auth, assets, finance, orchestration) link to each app and how the roadmap phases consume those contracts.
- Every blueprint ties directly to its phase’s TODO so workers know which files to edit and what verifications to run.

## Reliability & UX Mandate
- Document reliability/UX guard rails before features ship: error-proofing behaviors, instrumentation, fallback UX, and monitoring go into governance and TODOs.
- Define how the platform stays error-proof (retry policies, observability, alerts) and how the UX keeps the experience clean, workable, and modern.
- Tie reliability/UX verification back to the relevant TODO (see README for TODO-007/008) so success is measurable and repeatable.
## Compiled TODO Pipeline
1. Human provides intent (unstructured).
2. Prompt Normalizer classifies and normalizes intent.
3. Codex compiles intent into a canonical TODO schema containing TODO ID, Title, Lifecycle, Criticality, Objective, Execution Scope checklist, Allowed Files, Verification Contract, and Post-Completion Expectations.
4. Auditors review compiled TODO for lifecycle continuity.
5. TODO is inserted into `queue.md` and `ROADMAP.md`.
6. Execution proceeds only on compiled TODOs.

### Intent → Execution Flow
The system supports a single user action: “State intent.” Codex then:
1. Normalizes the prompt via the Prompt Normalizer.
2. Compiles the intent into a canonical TODO (Compiled TODO Pipeline).
3. Enforces lifecycle and criticality rules.
4. Injects missing implementation or verification TODOs as needed.
5. Executes the active TODO.
6. Runs postflight audits and updates the System Health Report.
7. Advances or blocks the roadmap based on lifecycle completeness.

## TODO Type Classification
- **Governance-Only:** modifies documentation, laws, workers, or roadmap, and may terminate at Defined without blocking sequential execution.
- **Implementation:** produces runtime behavior or artifacts, must progress through Implemented → Verified, and may block roadmap advancement.
- **Enforcement:** Governance-Only TODOs do not block sequential auto-advance; Implementation TODOs require full canonical contracts before activation.

## Postflight Obligations
After every execution, Codex MUST run all relevant auditors, update System Health Report inputs, detect lifecycle or criticality violations, inject corrective TODOs if required, and confirm roadmap gating conditions. Silence after execution is forbidden.

## Sequential TODO Auto-Advance
Closing a TODO implicitly authorizes Codex to activate the next queued TODO; “single active TODO” now means no parallel work, not a prohibition on automatic progression. Codex may finish, verify, close, and immediately begin the next TODO unless verification fails or the TODO is blocked.

## Canonical Version Artifact
### Platform Versioning Feature
- Feature: Platform Versioning
- Criticality: Critical
- A versioning feature is not Implemented unless a canonical version artifact exists, deterministic bump rules apply, the version is exposed in documentation/status outputs, and verification fails if the version is unchanged.

- The platform version must appear in a machine-readable artifact (e.g., `VERSION.md`).
- The Feature Registry, auditors, and verification steps reference this artifact when evaluating the versioning feature.
- Observability signals (merge reports, automation logs, future status endpoints) consume this artifact for version visibility.

## Feature Registry
- A generated artifact `features/FEATURE.REGISTRY.md` lists every feature with criticality, lifecycle, law/gov trace, implementing TODOs, and impacted systems.
- Auditors reference the registry; roadmap gating and Pulse derive lifecycle state from it rather than raw TODO counts.
- Registry schema: Feature, Criticality, Lifecycle, Defined By, Implemented By, Verified By, Impacted Systems, Blocking Roadmap Phase, Notes.
- A feature cannot advance to Implemented unless all declared required artifacts exist (e.g., `features/FEATURE.REGISTRY.md`, `VERSION.md`).
- For Versioning this specifically includes the canonical version artifact.

## Prompt Linter Report
- Purpose: Detect normalization failures, ambiguity, or law conflicts before execution.
- Checks: Missing Authority/Prompt Type, ambiguous intent, Prompt Normalization Law violations, constraint conflicts, lack of execution viability.
- Outputs: Prompt ID, Failure reason, Laws cited, Suggested correction class.
- Actions: Block execution, log failure, notify Pulse.
- Prompt Normalizer emits this report on failure; silence is forbidden.

## Task Trace Graph
- Each TODO links upstream Law/Governance/Roadmap triggers and trace types (Law-driven, Governance-driven, Roadmap-driven, Auditor-generated, Verification-required).
- Trace fields: Upstream Artifact(s), Triggering Rule or Law, Blocking Condition (if any).
- Compiled TODO Pipeline attaches trace metadata; auditors cite it when generating corrective items.
