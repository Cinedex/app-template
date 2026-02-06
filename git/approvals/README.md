# Approval Artifacts

Approval artifacts live in `git/approvals/approved/` and gate every automated merge. Each artifact must be named `<timestamp>-<target>-<source>.approved` (or `.md`) so the merge executor can match it to the merge report it just produced.

- `timestamp` should match the timestamp embedded in the merge report filename (`merge-report-<target>-<timestamp>.md`).
- Target/source names must match the branches passed to `scripts/git-merge-with-approval.sh`.
- The file itself must document the target/source head SHAs so the executor can verify it applies to the exact commits being merged.

When the executor runs without a matching approval file, it prints the target, source, merge-report path, and the exact artifact path to create before exiting with code 2. The approval artifact reminds workers that merges require human sign-off before automation can finish.
