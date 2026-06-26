#!/bin/sh
set -eu

force=0
target_dir=.

while [ "$#" -gt 0 ]; do
  case "$1" in
    --force)
      force=1
      ;;
    -h|--help)
      echo "Usage: $0 [--force] [target-repo]"
      exit 0
      ;;
    -*)
      echo "Unknown option: $1" >&2
      exit 2
      ;;
    *)
      target_dir=$1
      ;;
  esac
  shift
done

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
template="$script_dir/../assets/default.rules"
dest_dir="$target_dir/.codex/rules"
dest="$dest_dir/default.rules"

if [ ! -d "$target_dir" ]; then
  echo "Target directory does not exist: $target_dir" >&2
  exit 1
fi

if [ -e "$dest" ] && [ "$force" -ne 1 ]; then
  echo "Rules file already exists: $dest" >&2
  echo "Re-run with --force to replace it." >&2
  exit 1
fi

mkdir -p "$dest_dir"
cp "$template" "$dest"

echo "Installed project rules: $dest"
