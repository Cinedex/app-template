# Audit Scope

This is the canonical checklist that the Audit Service uses when it reasons about the platform template state. The Audit Steward and supporting auditors reference this scope whenever they regenerate the report, review the automation, or close TODOs that depend on the audit.

## Scope areas
1. **Repository structure & hygiene** – confirm the deterministic folder layout, canonical README/law/governance artifacts, and the audit folders are present and aligned with `TREE.md`.
2. **Governance completeness** – verify `GOVERNANCE.md` describes all active guard rails, lists the audit service, and ties audits to major template evolutions.
3. **Law coverage & enforcement** – ensure `authority/laws.md` names the Audit Integrity Law, ties it to Process Integrity/Versioning, and references the automation that enforces it.
4. **Worker coverage & gaps** – confirm `CODEX.worker.md` lists every worker owning the audit, automation, governance, and template-integrity duties without leaving gaps.
5. **Automation coverage & drift** – check `scripts/` includes the audit runner, log, and that the automation inventory/queue reference the new service.
6. **Versioning & compatibility state** – report the canonical `VERSION.md` value, compatibility notes, and that deterministic versioning laws are satisfied.
7. **Queue / TODO / Roadmap consistency** – audit that `TODO.md`, `queue.md`, and `ROADMAP.md` still reflect the canonical queue and mention the audit track when relevant.
8. **Observability & logging presence** – ensure observability notes, the audit README, and the logs (including `scripts/logs/audit-runs.md`) exist and follow the truth governance model.
9. **Template vs App separation guarantees** – confirm that `APP.details.md` (and derived docs) keep template-level wiring separate from any app-specific surface so auditors can trust derived copies.
