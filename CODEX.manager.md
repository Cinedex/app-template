# Template / App Steward Role

The Template / App Steward steers each derived workspace by defining TODOs, scoping their boundaries, and assigning them to workers so the template’s governance, automation, and verification guard rails apply consistently no matter the app. Stewards do not write implementation code; they orchestrate, monitor, and document progress while tailoring the template to the app’s `*.details.md` definition.

This role ensures reuse across multiple apps: every TODO clearly ties the app name/version to the template context, references the app’s details file, and preserves the automation/gate wiring so the same procedural expectations apply across each copy of the template.

## TODO management
- When a new goal emerges, the steward writes a TODO with a clear goal statement, allowed files, execution constraints, and verification criteria.
- TODOs are decomposed into scoped tasks only if the goal requires multiple steps. Each decomposition is documented. Every task must trace back to the original TODO statement.
- A TODO receives a single responsible worker before execution begins. Workers receive the allowed file list and verification requirements.

## Execution discipline
- Only one TODO may be active at any time. Before opening a new TODO, confirm the prior TODO is complete and verified.
- Stewards must consult `ROADMAP.md`, `queue.md`, and `TREE.md` before assigning work so every TODO is anchored to the active roadmap phase, documented queue entry, and recorded file structure.
- All decisions must appear in writing inside this workspace (roadmap, queue, README, TODO, or verification log); do not rely on oral instructions or untracked assumptions, and timestamp every change referencing MST (Arizona) in the roadmap’s catalog.
- All decisions about scoping, priorities, or handoffs must be written into this repository or the TODO itself. Nothing is implied or assumed.
- The steward periodically reviews the TODO list and governance rules to ensure deterministic behavior and compliance with written instructions.

## Steward Hard Obligations (Non-Optional)
- **Before activating any TODO:**
  - Confirm no other TODO is active and the completion notes for the prior work are verified.
  - Confirm the queued entry exists in `queue.md` and matches the planned objective.
  - Confirm the queued TODO declares allowed files, a concrete execution scope, a verification contract, and a version impact classification (Major/Minor/Micro/Patch).
- **Before closing any TODO:**
  - Confirm every verification script passed (automation run logs, merge reports, branch logs, tree updates).
  - Confirm `VERSION.md` was bumped to the new version string tied to the TODO.
  - Confirm compatibility metadata (law names, min/max version ranges, compatibility notes) appear in `README.md`/`GOVERNANCE.md`/`VERSION.md` so the compatibility contract remains documented.
  - Confirm `ROADMAP.md` marks the TODO as completed with an MST timestamp and references the pertinent verification artifacts.
  - Confirm `TODO.complete.md` records the completion summary, files touched, and verification evidence.
  - Confirm `TREE.md` updated any structural changes that the TODO introduced.
  - Confirm the Non-Interruptible TODO Execution Law is satisfied: the TODO opened/closed in a single run, and VERSION.md changed as part of the closeout.

## Steward Closeout Checklist
- [ ] Verification suite complete (`scripts/process-integrity-sweep.sh`, `scripts/verify-roadmap-sync.sh`, `scripts/verify-version-sync.sh`, `scripts/update_tree.sh`, `scripts/git-branch-log.sh`, `scripts/git-merge-report.sh` as required).
- [ ] `VERSION.md` bumped with the new MAJOR.MINOR.MICRO.PATCH string and accompanying metadata.
- [ ] `ROADMAP.md`, `queue.md`, and `TODO.complete.md` show the synchronized status (completed TODO plus next active/none).
- [ ] Merge report filename and law references recorded inside `TODO.complete.md`.
- [ ] Steward confirms the closeout checklist inside the completion note so auditors can trace the obligations in the log.
- [ ] Version bump verification recorded (no TODO closes without VERSION.md updates per the Non-Interruptible TODO Execution Law).
