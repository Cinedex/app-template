# Platform Template Roadmap (Human View)

This document narrates the platform template journey for readers. Execution is governed solely by `ROADMAP.md`, `TODO.md`, and `queue.md`; `APP.ROADMAP.md` is descriptive only and never bypasses the canonical artifacts or automation gates. Derived apps rename the sample `APP.details.md` to `<app>.details.md` before injecting their own intent, while this roadmap keeps showing the template evidence.

## Completed Template Phases
These entries highlight the evidence that this workspace is template-ready.

### Phase 0 — Governance & Control Plane (Complete)
- **Status:** Complete
- **Description:** Law catalog, manager/worker coordination, queue discipline, automation gates, and audit tooling are fully enacted and monitored via the canonical artifacts (`authority/laws.md`, `README.md`, `queue.md`, `scripts/process-integrity-sweep.sh`).
- **Evidence:** TODO-066 plus the automation trilogy keep the governance scaffold durable.

### Phase 1 — Prompt → Execution Engine (Complete, Milestone)
- **Status:** Complete (Milestone)
- **Description:** Prompt normalization, the Executable TODO discipline, the Approval & Merge flow, and reporting/observability guard rails were solidified by TODO-058/059 with deterministic verification traces (`scripts/git-merge-report.sh`, `scripts/run-safe.sh`, `CODEX.worker.md`).
- **Evidence:** README/GOVERNANCE sections appeal to the canonical logs and the `TODO.complete.md` entries document the milestone while automation logs cite the laws.

### Phase 1.5 — Template Extraction & Normalization (Complete, Template Ready)
- **Status:** Complete (Template Ready)
- **Description:** TODO-TEMPLATE-001 generalized the narrative, normalized governance/worker roles, and documented how every new app instantiates via `*.details.md`, making this workspace the reusable platform template.
- **Evidence:** `features/FEATURE.REGISTRY.md` marks the template readiness, the README/GOVERNANCE evidence explains how derived apps adopt the guard rails, and `TODO.complete.md` records the deterministic bump (0.3.5 → 0.3.6).

## Example Next Phases (Descriptive)
Typical next phases may include app-specific work such as auth, workspaces, domain models, integrations, finance, observability, and deployment. These entries illustrate the intent derived from a new app’s details file while canonical execution stays controlled by `ROADMAP.md`/`TODO.md`/`queue.md`.

### Phase 2 — Core Platform Services (Example)
- **Focus areas:** Auth & Identity, Workspaces/Organizations, Roles & Permissions, Settings & Configuration.
- **Purpose:** This blueprint reminds derived apps to queue governance work for these essentials before implementation while keeping automation logs in sync.

### Phase 3 — Domain Models & Workflow (Example)
- **Focus areas:** Domain-specific data models, asset registration, scheduling, project workflows, and policy automation.
- **Purpose:** Document how each phase can be tailored from `*.details.md` without altering the canonical TODO lifecycle.

### Phase 4 — Integrations & Marketplace (Example)
- **Focus areas:** External integrations, marketplace catalogs, Atlas readiness, service/device policies, and observability instrumentation.
- **Purpose:** Reinforce that app marketplaces and integrations extend the template while obeying the MicroMDM/App Marketplace and App Marketplace & Atlas Readiness laws.

### Phase 5 — Finance & Operations (Example)
- **Focus areas:** Ledgers, invoicing, payouts, reporting, and compliance instrumentation.
- **Purpose:** Derived roadmaps cite finance guard rails and release metadata in `VERSION.md` before launching implementation TODOs.

### Phase 6 — Observability & Intelligence (Example)
- **Focus areas:** Logs, metrics, analytics, LLM safeguards, and health reporting.
- **Purpose:** Ensure telemetry TODOs reference the Observability Automation Law and automation runs capture the same version string.

### Phase 7 — Deployment & Scale (Example)
- **Focus areas:** Multi-server readiness, environments, backups, high-availability deployments, and reliability guard rails.
- **Purpose:** Document how multi-server readiness pairs with canonical queue and automation scripts without altering their enforcement.

### Phase 8 — Marketing & Public Surfaces (Descriptive)
- **Focus areas:** Marketing messaging, truth governance, version binding, and drift detection.
- **Purpose:** The Marketing Steward keeps these surfaces accurate without assuming execution authority—refer to `marketing/status.md`, `VERSION.md`, and the Progress Watchdog rules for guidance.

## Product Milestones (Descriptive)
These milestone notes remind readers how internal/external readiness ties to canonical governance, but they do not authorize execution.
- **Internal Alpha:** Governance tracking; core workflows usable internally, automation stable.
- **External Beta:** Governance tracking; external experiments with monitoring, logging gaps in TODOs.
- **Template “Done” (Template Ready):** Governance tracking milestone that records template completeness; this narrative marks the workspace ready to seed derived apps rather than finalizing development.
- **Post-Template Iteration:** Governance tracking for continuous improvement beyond the template release.

## Documentation Versioning
- **Documentation Version:** 0.3 (per `VERSION.md` platform MAJOR). This human roadmap references the documentation version so the Process Integrity sweep can confirm MAJOR parity and surface drift warnings.
- **Reference:** Documentation versions are compatibility signals; they never control execution gating or TODO lifecycle.
