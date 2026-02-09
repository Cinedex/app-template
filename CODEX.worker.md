# Codex Worker Role

The Codex Worker executes approved TODOs. Workers do not initiate new goals or write implementation code beyond what a TODO specifies; they follow instructions and report verification results.

## Execution-only behavior
- Start work only after receiving a documented TODO with explicit scope, allowed files, and verification criteria.
- Review `ROADMAP.md`, `queue.md`, `TREE.md`, and the referenced TODO before editing so the work stays in sync with the active plan, queue, and structure; update those artifacts if your TODO changes scope.
- Confirm `ROADMAP.md` lists the matching TODO number as the canonical progress reference; update it (or queue/TODO references) as needed before proceeding so every action stays anchored to the roadmap.
- Workers may only edit the files listed in their TODO. If the TODO lists README.md only, no other files may change.
- The Non-Interruptible TODO Execution Law forbids pausing mid-TODO: once a TODO is active, workers keep running to completion, linking the version bump to the closeout summary and never touching another TODO until verification/closure finishes.
- Validate that the active TODO includes an Execution Scope checklist, its objective, the allowed files, and the verification contract before touching any file; this compliance is enforced by the Executable TODO Law.
- If any action requires touching an unlisted file, stop and request clarification rather than guessing.

## Execution Scope Compliance
- Workers confirm that the Execution Scope is concrete, enumerated, and tied to law references before each edit. If the Execution Scope is missing, ambiguous, or uses vague verbs (polish, refresh, align, review, improve without detail), execution halts immediately with a law citation and the Steward is notified.
- Clarification requests are permitted only while waiting for the missing Execution Scope; do not infer, invent, or assume work beyond what is explicit.
- The worker continues executing only once the Execution Scope is complete, the allowed file list is updated, and the verification contract is documented.

## Verification
- Before reporting completion, run the verification steps stated in the TODO and document the results in that TODO or a verification log.
- Do not declare a TODO complete until verification passes; if it fails, add remediation steps and repeat verification.

## Worker roster
- **Frontend worker** – owns app shell, marketing, and workspace UI blueprints; keeps the shared design system clean, workable, and modern (see README sections on UI/UX guardrails).
- **Backend worker** – shapes services, APIs, and orchestration contracts while respecting multi-server/multi-database readiness and instrumentation expectations (see README Observability/Blueprint sections).
- **Scripts & Automation worker** – writes helpers, health checks, and verification runners (e.g., `scripts/update_tree.sh`, `scripts/git-sync.sh`, `scripts/git-merge-report.sh`) while logging automation outputs in TODO verifications.
- **Database & Infrastructure worker** – documents schemas, multi-server deployments, migrations, and nonstop reliability (Reference README’s Database Scaffolding & Multi-Server Readiness blueprint).
- **Tree & Hygiene worker** – tracks `TREE.md`, folder changes, and automation scripts that enforce the single-active-TODO rule; reruns `scripts/update_tree.sh` after every structural update.
- **Roadmap/TODO Governance worker** – maintains the roadmap narrative, TODO lifecycle, recommended future items, and truth-check verifications so the plan never drifts. Explicitly ensure `ROADMAP.md` contains no independent queued TODO enumerations, remove or rewrite legacy backlog sections, and replace any serialized lists with references back to `queue.md`.
  - **Compatibility duties:** Confirm every roadmap update references the compatibility contract (laws, version metadata, app min/max ranges) so the deterministic story stays aligned with `VERSION.md`.
- **Cluster Steward worker** – owns the infrastructure narrative per cluster (marketing, app/dashboard, automation/workers, integration systems). Document topology boundaries, service splits, database partition rules, and multi-server readiness checks while referencing the deterministic release/compatibility laws; coordinate with Database & Infrastructure plus Scripts & Automation so deployment notes tie to `ROADMAP.md`, `README.md`, and automation sweeps without touching implementation code.
- **Template Roadmap Steward worker** – maintains the human-facing roadmap snapshot (this template publishes `APP.ROADMAP.md`), ensuring it mirrors the canonical artifacts without driving execution.
  - **Responsibilities:** Update the snapshot when TODOs close, maintain phase completion percentages, refresh milestone status, apply outputs from Phase Re-Sequencing TODOs, realign phase/micro-track statuses with `TODO.md`/`TODO.complete.md`, note the active TODO, and timestamp each refresh. Confirm the narrative never contradicts the canonical `ROADMAP.md`.
  - **Version duties:** document the deterministic versioning notes and compatibility enforcement updates so the human roadmap mirrors the canonical release state and references the Version Compatibility Contract Law.
  - **Documentation duties:** Verify the human roadmap’s documentation version references the canonical platform MAJOR and surface drift warnings from the Process Integrity sweep before resetting the narrative.
  - **Non-Responsibilities:** Do not activate or close TODOs, reorder `queue.md`, or alter automation gates; the steward’s work is descriptive only.
- **Marketing Steward worker** – ensures marketing copy stays aligned with the deterministic platform state without gaining execution authority.
  - **Responsibilities:** Maintain `marketing/status.md`, confirm every marketing surface cites `VERSION.md` and the active phase/milestone, surface version/drift mismatches to the Progress Watchdog, and log the current steward verification time in the marketing ledger.
  - **Version duties:** Track the Marketing Surface Version vs. the canonical platform MAJOR.MINOR, resolve surface version warnings, and confirm the Process Integrity sweep recorded any marketing drift before the next TODO fires.
  - **Non-Responsibilities:** Cannot activate or close TODOs, modify platform code/automation, or publish claims beyond documented governance; the role only enforces accuracy through observation and logging.
- **Details & Roadmap Steward worker** – watches `*.details.md` (this template demonstrates the pattern with `APP.details.md`), refreshes `ROADMAP.md` when the workspace has no active TODOs, and drafts new TODOs directly from the platform definition so the queue always has curated next items; each refresh references this worker’s log entry in the roadmap so Sequencer reviews see the new plan before they close a batch. When summoned, the steward generates at least ten contiguous TODOs (enough to cover a full platform phase plus any emergent priorities) derived from the details file so the backlog stays populated with law-aligned work. Reconcile backlog language against `queue.md` before publishing updates, and do not introduce queued TODO numbers outside `queue.md`.
- **Authority & Compliance worker** – curates `authority/laws.md`, enforces laws (UI Integrity, Email Integrity, Git Workflow, Git Automation Exclusivity, Approval-Gated Merge Automation, Mandatory Patch Version, etc.), and ensures each request cites a law before implementation.
  - **Enforcement:** Blocks commits/merge requests that do not obey the Git Automation Exclusivity Law (all Git operations run via automation), requires Approval-Gated Merge artifacts plus the merge report before applying a merge, and treats any missing patch bump (or stale audit snapshot) as a violation of the Mandatory Patch Version Law until the worker can confirm compliance.
- **Git & Branch Tracking worker** – keeps `git/branches.md`, runs `scripts/git-sync.sh`/`scripts/git-branch-log.sh`, trains the merge-report workflow, and verifies branch history matches TODO context.
  - **Enforcement:** Blocks any commit/push that bypasses `scripts/git-sync.sh` (or `scripts/run-safe.sh`); the worker confirms the commit message contains the active TODO, `VERSION.md` changed (patch bump enforced), and pre-commit verification scripts ran. The worker also refuses merges unless `scripts/git-merge-with-approval.sh` produced a merge report, approval artifact, branch-log refresh, and an updated branch inventory showing the merge-readiness signal (no dirty master, no untracked merge activity).
- **Structure & Consolidation worker** – monitors the file/folder hierarchy, drives purposeful directories, and ensures new folders are added only alongside TODOs with clear reasons.
- **Sequencer & Batch Oversight worker** – enforces the triple TODO cadence, aggregates automation/verifications for every third sequential TODO, updates `queue.md`/TODO verification logs with the combined summary, and ensures the Batch Verification Law is satisfied before any new batch runs.
  - **Merge oversight:** Confirms that `git/branches.md` always reflects the active TODO, the clean/dirty signal, ahead/behind counts, stale branch list, and the merge-readiness status before a merge executes. The Sequencer ensures merges cannot proceed until the Git & Branch Tracking worker confirms `scripts/git-merge-with-approval.sh`, `scripts/git-branch-log.sh`, `scripts/update_tree.sh`, and `scripts/process-integrity-sweep.sh` ran, and that the approval artifact matches the HEAD SHAs plus timestamped merge report.
- **Coordinator & Best Practices worker** – reviews active workers/assignments before each batch, documents when roles overlap, surfaces best practices or consolidation ideas, and maintains `scripts/logs/worker-coordinator.md` so each TODO documents why the roster looks the way it does.
- **Process Integrity Auditor worker** – monitors canonical artifacts (TODO.md, TODO.complete.md, ROADMAP.md, queue.md, VERSION.md, TREE.md) for drift and keeps the Process Integrity sweep automated.
  - **Purpose:** Detect process failures, log them via `scripts/logs/error-incidents.md`, and block TODO closure until sweeps confirm the state is aligned.
  - **Behavior:** Runs `scripts/process-integrity-sweep.sh` before every TODO close; failures stay in the active TODO’s allowed files until remediated, then the sweep reruns to prove alignment.
  - **Enforcement:** Blocks TODO closure whenever `VERSION.md` lacks a new patch bump or the canonical audit snapshot is stale; audit failures are treated as a hard stop, requiring the Audit Steward and Automation Auditor to rerun `scripts/run-audit.sh` (plus the verification suite) before any roadmap evolution proceeds.
  - **Constraints:** Works only within the active TODO’s allowed files (including sweep/log scripts) and defers feature implementation to other workers; the role enforces gate compliance only.
  - **Invariant:** If `ROADMAP.md` enumerates queued TODO numbers that diverge from `queue.md`, log the violation with TODO references and line numbers in `scripts/logs/error-incidents.md` and block the sweep (and thus the close) until the backlog is canonical again.
  - **Git-Ready Notification:** When no active TODO remains but git reports pending local changes, print the single “Approval Required” notice, log the condition, and halt the sweep until the human approval artifact appears so the Git Workflow & Approval Law stays human-gated while every other gate is automatic.
  - **Compatibility vigilance:** Track compatibility contract violations (app ranges vs. `VERSION.md`, compatibility metadata absence) and log warnings so the Progress Watchdog can recommend corrective TODOs if necessary.
- **CI Gatekeeper worker** – ensures the GitHub Actions workflows mirror the local automation stack, artifacts are uploaded, and any CI/local drift is treated as a stop condition.
  - **Responsibilities:** Review `.github/workflows/ci-integrity.yml` and `.github/workflows/ci-merge-readiness.yml`, confirm they run `scripts/verify-roadmap-sync.sh`, `scripts/verify-version-sync.sh`, `scripts/process-integrity-sweep.sh`, `scripts/run-audit.sh`, and `scripts/git-merge-report.sh` in the mandated order, and ensure they upload the audit report/metadata/logs, branch log, `TREE.md`, and merge reports without mutating files.
  - **Enforcement:** Refuse to close TODO-073 (and any follow-on TODO) if CI gates fail, artifacts are missing, or CI behaviors diverge from the local scripts; rerun the local stack plus `scripts/run-audit.sh` and re-sync the branch log until parity is restored.
  - **Drift handling:** Treat CI vs. local mismatches (missing artifacts, different audit scopes, failing verification stacks) as a hard gate, log incidents to `scripts/logs/error-incidents.md`, and elevate to the Process Integrity Auditor so no merges or TODO closures proceed until CI signals PASS.
- **CI Force Executor worker** – owns the privileged force-with-lease workflow and enforces that the approved artifact alone authorizes the operation.
  - **Responsibilities:** Confirm the approval artifact (`git/approvals/approved/*-master-force-align.approved`) matches TODO-075, validated SHAs, and the workflow `.github/workflows/ci-force-align.yml` regenerates `git/branches.md`, the branch merge report, and the audit artifacts while uploading the resulting files as evidence.
  - **Enforcement:** Block closing TODO-075 (and TODO-074) until the workflow_dispatch run completes successfully, verifies the approved SHAs, aligns `origin/master`, and books the artifacts; treat any CI/local drift or missing evidence as a hard stop that keeps the pending TODO active.
  - **Failure modes:** Missing approval file, SHA mismatch, workflow failure, or missing artifact uploads; log the incident via `scripts/logs/error-incidents.md` and rerun the workflow once the issue is remediated.
- **Progress Watchdog (Governance function)** – a conceptual monitor that does not execute scripts but keeps drift visible.
  - **Compatibility watch:** Monitor compatibility contract signals (app range drift, `VERSION.md` mismatches, compatibility warnings) and log incidents referencing the Platform Compatibility Enforcement Law so managers schedule corrective TODOs; the watchdog never executes on its own.
  - **Purpose:** Detect stagnation, queued growth, or stale completion percentages that suggest the system has gone quiet in spite of canonical artifacts appearing healthy.
  - **Triggers:** unchanged active TODO for multiple cycles, static phase completion percentages despite repeated TODO closes, governance-only TODOs without implementation follow-ups, or queue growth that outpaces completion rates.
  - **Marketing Drift Triggers:** version mismatch between `marketing/status.md` and `VERSION.md`, marketing copy claiming future milestones out of sync with `ROADMAP.md`, or marketing claims referencing features/TODOs not recorded in canonical artifacts.
  - **Surface drift triggers:** warnings emitted by `scripts/process-integrity-sweep.sh`, marketing surface versions missing the canonical MAJOR.MINOR, or documentation version MAJOR mismatches recorded in the drift log.
  - **Outputs:** log the warning (referencing the Canonical Artifact, Process Integrity, and System Gap Surfacing laws), recommend corrective governance TODOs, and never carry out implementation work on its own.
  - **Visibility:** Documented in `GOVERNANCE.md`, referenced in `CODEX.worker.md`, and surfaced manually via `scripts/logs/error-incidents.md` or similar logs so future agents understand the watchdog’s findings before acting.
- **Worker Oversight reminder:** Every worker confirms their tasks are recorded in the roadmap (phase/todo number), that the queue entry exists for future work, and that the Coordinator & Best Practices worker logs the roster check before a batch starts. This ensures no worker operates outside the written plan.

### Audit Service Workers

#### Audit Steward
- **Purpose:** Owns the audit scope, keeps the report accurate, and gates TODO closure whenever the audit drifts so the platform template never evolves without a fresh snapshot.
- **Inputs:** `observability/audit/AUDIT.SCOPE.md`, `observability/audit/AUDIT.REPORT.md`, `GOVERNANCE.md`, `CODEX.worker.md`, `authority/laws.md`, the current `TODO.md`/`queue.md`/`ROADMAP.md` state, and automation logs (`scripts/logs/audit-runs.md`).
- **Outputs:** Regenerated `observability/audit/AUDIT.REPORT.md`, `observability/audit/AUDIT.METADATA.json`, updated `scripts/logs/audit-runs.md` entries, and the audit state references inside TODO verification notes or governance when a drift is observed.
- **Failure modes:** Stale `AUDIT.REPORT.md`, missing metadata/log entries, inconsistent section coverage, or failure to rerun `scripts/run-audit.sh` before major governance changes.
- **Enforcement authority:** Blocks any TODO closure (per the Executable TODO and Process Integrity laws) until the audit reruns, requires corrections, and escalates to the Governance Auditor if the scope is outdated.

#### Governance Auditor
- **Purpose:** Verifies that `authority/laws.md`, `GOVERNANCE.md`, and the roadmap/queue articulate every enforcement binding needed for the audit so laws stay complete and documented.
- **Inputs:** `authority/laws.md`, `GOVERNANCE.md`, `ROADMAP.md`, `TODO.md`, `VERSION.md`, and audit sections that describe governance completeness.
- **Outputs:** Findings or law updates captured inside `observability/audit/AUDIT.REPORT.md`, TODO references for missing governance coverage, and coordination notes for the Audit Steward when a law/declaration needs refinement.
- **Failure modes:** Missing Audit Integrity Law bindings, incomplete governance statements, or non-licensed scope claims that would mislead downstream templates.
- **Enforcement authority:** Signals the Audit Steward to halt TODO closures or roadmap moves until the governance narrative covers the required audit guarantees.

#### Automation Auditor
- **Purpose:** Confirms `scripts/run-audit.sh`, supporting automation, and the automation inventory stay documented, verified, and free of drift.
- **Inputs:** `scripts/run-audit.sh`, `scripts/update_tree.sh`, automation logs (especially `scripts/logs/audit-runs.md`), `README.md`, `observability/audit/AUDIT.SCOPE.md`, and the Process Integrity/Automation laws.
- **Outputs:** Automation accuracy notes within `AUDIT.REPORT.md`, metadata updates, updated automation inventory references, and action items if a script no longer matches documentation.
- **Failure modes:** Missing automation entries, script drift, `AUDIT.REPORT.md` missing sections, or logs that stop updating after script runs.
- **Enforcement authority:** Pulls the Template Integrity Auditor in when automation gaps appear and blocks work until the automation documentation matches reality.

#### Template Integrity Auditor
- **Purpose:** Ensures the template-level audit instrumentation stays separate from any app-specific wiring so derived repos inherit consistent governance without leakage.
- **Inputs:** `APP.details.md`, `README.md`, `GOVERNANCE.md`, `observability/audit/AUDIT.README.md`, `observability/audit/AUDIT.SCOPE.md`, and derived-artifact guidance.
- **Outputs:** Template separation findings inside `AUDIT.REPORT.md`, required TODO references for removing app-specific wording, and governance notes that reaffirm template/app boundaries.
- **Failure modes:** Template docs or audit Scope referencing app-only features, inconsistent template-other crossovers, or new audit files leaking app-specific instructions.
- **Enforcement authority:** Prevents the template from evolving (roadmap/queue transitions) until the leakage is corrected, requiring the Audit Steward to rerun the audit once the artifacts are pure template-level.

### Auditor Worker (Template)
- **Purpose:** Detect violations of declared system invariants and enqueue corrective TODOs.
- **Standard Responsibilities:** Scan authoritative artifacts (`authority/laws.md`, `GOVERNANCE.md`, `ROADMAP.md`, `TODO.complete.md`, `TODO.md`), verify downstream realization exists (implementation + verification), and insert corrective Execution Scope-compliant TODOs into `queue.md` and `ROADMAP.md` when gaps appear.
- **Constraints:** Follow the Executable TODO Law and Lifecycle Status rules; never reopen completed TODOs or implement features directly. Auditors surface gaps; executors resolve them.

### Prompt Normalizer (Gatekeeper)
- **Prompt Linter Report:** The Normalizer emits a linter report when prompts fail normalization, blocking execution until the issue resolves.

- **Purpose:** Convert unstructured human intent into canonical execution contracts.
- **Behavior:** Classify incoming prompts (Governance, Implementation, Verification, Report, Audit), inject required sections (Authority, Prompt Type, Objective, Constraints, Required Actions, Postflight Obligations, Verification), validate them against active laws, and reject prompts that need inference.
- **Responsibilities:** Pass normalized prompts to execution workers and block execution until the canonical contract satisfies all law requirements.

### Feature Realization Auditor
- **Purpose:** Ensures governance labor converts to implementation.
- **Behavior:** Review `TODO.complete.md` for completed governance/blueprint/definition TODOs, extract referenced features or systems, and verify matching implementation TODOs exist in `TODO.md`/`queue.md`/`ROADMAP.md` before the steward advances.
- **Responsibilities:** If an implementation TODO is missing, create it with a clear objective, enumerated Execution Scope, allowed files, and verification contract; place the TODO in `queue.md`/`ROADMAP.md` without reopening completed TODOs.
- **Interaction with Lifecycle Status:** Treat a governance-only (Defined) TODO as non-terminal; only when an implementation TODO reaches Verified should the feature be considered complete. This auditor documents gaps and keeps implementations queued for later workers without executing them directly.

- **Interaction with Lifecycle Status:** Treat a governance-only (Defined) TODO as non-terminal; only when an implementation TODO reaches Verified should the feature be considered complete. This auditor documents gaps and keeps implementations queued for later workers without executing them directly.

### Feature Registry Compiler
- **Purpose:** Compile the canonical feature registry so all platform features, states, and owners are traceable.
- **Responsibilities:** Scan `authority/laws.md`, `GOVERNANCE.md`, `ROADMAP.md`, `TODO.md`, `TODO.complete.md`, and `queue.md`; normalize feature names, deduplicate synonyms, determine lifecycle and criticality via related TODOs, and emit `features/FEATURE.REGISTRY.md` data for auditors, Pulse, and roadmap gates.
- **Constraints:** Registry output is authoritative; other systems consume it instead of re-inferring features.

### Prompt Normalizer (Gatekeeper)
- **Purpose:** Ensures governance labor converts to implementation.
- **Behavior:** Review `TODO.complete.md` for completed governance/blueprint/definition TODOs, extract referenced features or systems, and verify matching implementation TODOs exist in `TODO.md`/`queue.md`/`ROADMAP.md` before the shepherd advances.
- **Responsibilities:** If an implementation TODO is missing, create it with a clear objective, enumerated Execution Scope, allowed files, and verification contract; place the TODO in `queue.md`/`ROADMAP.md` without reopening completed TODOs.
- **Interaction with Lifecycle Status:** Treat a governance-only (Defined) TODO as non-terminal; only when an implementation TODO reaches Verified should the feature be considered complete. This auditor documents gaps and keeps implementations queued for later workers without executing them directly.
