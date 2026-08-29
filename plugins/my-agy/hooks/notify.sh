#!/usr/bin/env bash
set -euo pipefail

EVENT="${1:-Stop}"

case "$EVENT" in
  Stop)
    printf '\e]9;Agy: Task completed\a' > /dev/tty 2>/dev/null || true
    ;;
  PreToolUse|Permission|Alert)
    printf '\e]9;Agy: Action required\a' > /dev/tty 2>/dev/null || true
    ;;
esac

# Antigravity hooks require JSON output on stdout
echo "{}"
