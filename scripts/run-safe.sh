#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

usage() {
  cat <<'EOF'
Usage: run-safe.sh [commit|merge] [args...]
  commit <git-sync args>    Run the process-integrity sweep, then run scripts/git-sync.sh with the provided arguments.
  merge <target-branch> <source-branch>  Run the sweep, then hand off to scripts/git-merge-with-approval.sh.
EOF
  exit 1
}

if [ $# -lt 1 ]; then
  usage
fi

bash "$root/scripts/process-integrity-sweep.sh"

cmd="$1"
shift
case "$cmd" in
  commit)
    bash "$root/scripts/git-sync.sh" "$@"
    ;;
  merge)
    bash "$root/scripts/git-merge-with-approval.sh" "$@"
    ;;
  *)
    usage
    ;;
esac
