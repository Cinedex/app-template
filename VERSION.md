# Platform Template Version Artifact

- **Current Version:** 0.3.8
- **Full Version:** 0.3.8.2
- **Previous Version:** 0.3.8
- **Bump Type:** Patch
- **Triggering TODO:** TODO-072 (Git Automation Enforcement & Mandatory Patch Versioning)
- **Bumped By:** TODO-072 (Git Automation Enforcement & Mandatory Patch Versioning)
- **Created At:** 2026-02-08T21:57:34Z
- **Compatibility Notes:** Audit Service + Git automation hardening (pre-clean reconciliation)
- **Notes:** Audit Service + Git automation hardening (pre-clean reconciliation)
- **Deterministic rule:** Versioning follows MAJOR.MINOR.MICRO.PATCH. Every TODO completion updates at least the PATCH digit, governance-only TODOs bump PATCH, implementation TODOs bump MICRO (or higher when explicitly declared), and no two commits may share the same string. `VERSION.md` is canonical—the artifact records the prior value, bump type, triggering TODO, and any compatibility guidance so release history remains audit-ready.
- **Observability link:** `scripts/logs/observability-runs.md`, `scripts/git-merge-report.sh`, and Pulse dashboards read this artifact so automation logs, merge notes, and release timelines share the same canonical version string.
- **Traceability notes:** The Feature Registry Versioning entry, automation logs, and merge reports cite this artifact so every platform release ties back to the TODO, law references, and automation verification records.

## Version metadata
- **Previous version:** 0.3.8.1
- **New version:** 0.3.8.2
- **Bump type:** Patch
- **Triggering TODO:** TODO-072 (Git Automation Enforcement & Mandatory Patch Versioning)
- **Compatibility notes:** Audit Service + Git automation hardening (pre-clean reconciliation)
- **Patch string:** 0.3.8.2

## Surface Version Matrix
- **Platform Version:** 0.3.8.2 (MAJOR=0, MINOR=3, MICRO=8, PATCH=2)
- **Marketing Surface Version:** 0.3.3 (matches MAJOR.MINOR and may lag behind MICRO/PATCH; drift warnings appear when MAJOR.MINOR diverge).
- **Documentation Version:** 0.3 (matches MAJOR; warns when the canonical MAJOR changes).
- **Surface Version Notes:** Surface declarations act as compatibility signals—not execution controls. Every surface references `VERSION.md` so the Process Integrity sweep and Progress Watchdog can surface drift warnings tied to the canonical platform version.
