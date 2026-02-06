# Marketing Execution Status

## Platform Version Reference
- **Platform Version:** 0.3.1.0 (per `VERSION.md`)
- **Marketing Surface Version:** 0.3.1
- **Version Date:** 2026-02-05T20:02:43Z MST
- **Verification Timestamp:** 2026-02-06T07:00:00Z MST
- **Source of Truth:** `VERSION.md`
- **Last Verified By:** Marketing Steward

> Marketing artifacts must include the platform version and citation to `VERSION.md`. Missing or outdated references are considered *drift* and must be logged by the Marketing Steward with a reference to the watchdog/incidents log (e.g., `scripts/logs/error-incidents.md`). Drift does not block execution but must be surfaced before the next TODO closes.

| Page | Owner | Automation Hooks | Verification Notes | Status |
| --- | --- | --- | --- | --- |
| Home | Frontend | `scripts/preview-home.sh`, Lighthouse | cite README:Platform Overview, UI Integrity Law, Truth Governance; preview script confirmed CTA/hero messaging | automation complete |
| Apps | Frontend | `scripts/apps-preview.sh`, Lighthouse | cite README first-party app list, Observability/Automation playbooks; preview script affirmed app grid and trust line | automation complete |
| Roadmap | Roadmap/TODO Governance | `scripts/roadmap-preview.sh`, screenshot diff | cite README roadmap pipeline plus governance blueprint; preview script reinforced TODO queue CTA | automation complete |
| Reliability | Automation | `scripts/reliability-preview.sh`, alert dashboard logs | cite README Reliability & Resilience Plan and Observability Playbook, script output validated instrumentation messaging | automation complete |
| Community | Automation | `scripts/community-preview.sh`, screenshot diff, Resend preview notes | cite README Cinehub/Spark/Atlas sections and Marketing Automation & Resend Workflows; preview script scoped Resend CTAs per Email Integrity Law | automation complete |
| Integrations | Backend | `scripts/integrations-preview.sh`, API test logs | cite README Multi-server Deployment and Observability Playbook; preview script confirmed orchestration talking points | automation complete |
| Pricing/Contact | Frontend | `scripts/contact-preview.sh`, form validation tests, Resend preview | cite README Auth Security Blueprint, Marketing & Auth Planning, Email Integrity Law; preview script validated secure form messaging | automation complete |
| Outreach | Marketing | `scripts/preview-home.sh`, `scripts/apps-preview.sh`, `scripts/community-preview.sh`, `scripts/contact-preview.sh`, `scripts/integrations-preview.sh`, `scripts/reliability-preview.sh`, Resend preview, QA logs | cite README Marketing Outreach Automation, Email Integrity Law, Automation & Productivity, Truth Governance; automation tracker and `scripts/logs/marketing-outreach-run.md` recorded CTA timing, QA signal, and log summary | automation complete |
| Marketing Refresh | Marketing | `scripts/preview-home.sh`, `scripts/community-preview.sh`, `scripts/roadmap-preview.sh`, Resend preview, `scripts/process-integrity-sweep.sh` | cite README Marketing Refresh Blueprint, Email Integrity Law, Truth Governance; automation runner logged refreshed copy and CTA states across key pages; automation wiring ensures Resend refresh runs through the Roadmap Sync gate | refresh loop engaged |

> Update this table as each page completes, capture automation evidence, and reference the relevant law/TODO so the Authority & Compliance worker can verify TODO-022.

## Refresh Loop Plan
- **Current outreach state:** All preview scripts (home, community, roadmap) report refreshed messaging for Resend-scheduled CX flows; CTA/resend copy is aligned with `marketing/status.md` automation hooks and the Automation & Productivity tracker.
- **Refresh plan:** Maintain per-page automation/resend run details in this table, cite Email Integrity Law and Truth Governance Law for each page, and route every metric through `scripts/logs/marketing-outreach-run.md` for auditability.
- **Retry/automation notes:** Re-run the Resend preview scripts along with `scripts/process-integrity-sweep.sh` during each refresh iteration so the Roadmap Sync Gate guards the marketing state across hooks, logs, and merge reports.
- **Law references:** Email Integrity Law; Truth Governance Law.
- **Drift detection:** If the version(s) referenced here differ from `VERSION.md`, log the discrepancy under the Progress Watchdog (see `scripts/logs/error-incidents.md`) and recommend a governance TODO to realign the copy.
