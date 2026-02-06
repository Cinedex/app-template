# Queue Discipline

This queue enforces the Executable TODO Law and the Governance-to-Implementation Continuity Law: each entry documents the required Execution Scope, lifecycle status, verification steps, and law references before activation. The queue shows future TODOs only so the steward confirms compliance before scheduling work; active/completed TODOs live in `TODO.md`/`TODO.complete.md` and the roadmap.

- **TODO-050**: Platform detail backlog sprint from `Cinedex.details.md`.
  - Lifecycle: Defined
  - Status: Queued
  - Notes: Roadmap/TODO Governance stewards turn the detail backlog into executable TODOs when the roadmap needs a new phase.
- **TODO-051**: MicroMDM App Marketplace update.
  - Lifecycle: Defined
  - Status: Queued
  - Notes: Captures device policy preparation and marketplace catalog updates for future implementation waves.

## Automation Guardrails
- Every queued TODO reruns `scripts/update_tree.sh`, `scripts/git-branch-log.sh`, and `scripts/git-merge-report.sh` before the automation batch closes; so `TREE.md`, `git/branches.md`, and `git/merge-reports/` document the verification outputs.
- The Process Integrity Auditor uses `scripts/process-integrity-sweep.sh` to certify roadmap, queue, and version coherence before the Sequencer allows a batch to finish.

## Lifecycle Notes
- Corrective implementation TODOs may be inserted by the Feature Realization Auditor whenever governance-only entries lack implementation partners.
- The queue prioritizes these implementation TODOs after governance-defined work to keep lifecycle progression in sync.
- Pulse’s Feature Lifecycle Status report tracks Defined, Implemented, and Verified states so supervisors know which features need realization.

## LLM Continuity Note
- Future iterations of the LLM safeguards story will extend the prompt/rate-limit instrumentation and observability logging described above; the next governance batch will queue those follow-ups once this review closes so the canonical queue remains the single source of queued LLM guard rails.

## App Marketplace & Atlas readiness note
- Document the App Marketplace criteria, Atlas integration guard rails, and the automation scripts (`scripts/update_tree.sh`, `scripts/git-branch-log.sh`, `scripts/git-merge-report.sh`) that capture the verification outputs; cite the App Marketplace & Atlas Readiness Law so the queue records the integration story before implementation waves follow.

