#!/usr/bin/env bash
set -euo pipefail

EVENT="${1:-Stop}"

# Play sound in background on macOS
if [[ "$(uname)" == "Darwin" ]]; then
  case "$EVENT" in
    Stop)
      afplay /System/Library/Sounds/Glass.aiff >/dev/null 2>&1 &
      ;;
    Alert|Permission)
      afplay /System/Library/Sounds/Hero.aiff >/dev/null 2>&1 &
      ;;
  esac
fi

# Antigravity hooks require JSON output on stdout
echo "{}"
