#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

for plugin in my-codex my-agy; do
  rsync -a --copy-links \
    "$root/skills/" \
    "$root/plugins/$plugin/skills/"
done
