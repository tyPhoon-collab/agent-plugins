#!/bin/sh
set -eu

dry_run=0
build=1
target_dir=.
target_set=0

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run)
      dry_run=1
      ;;
    --no-build)
      build=0
      ;;
    -h|--help)
      echo "Usage: $0 [--dry-run] [--no-build] [target-repo]"
      exit 0
      ;;
    -*)
      echo "Unknown option: $1" >&2
      exit 2
      ;;
    *)
      if [ "$target_set" -eq 1 ]; then
        echo "Only one target repository may be specified." >&2
        exit 2
      fi
      target_dir=$1
      target_set=1
      ;;
  esac
  shift
done

if [ ! -d "$target_dir" ]; then
  echo "Target directory does not exist: $target_dir" >&2
  exit 1
fi

repo_root=$(git -C "$target_dir" rev-parse --show-toplevel 2>/dev/null) || {
  echo "Target is not a Git repository: $target_dir" >&2
  exit 1
}

if ! command -v uvx >/dev/null 2>&1; then
  echo "uvx is required. Install uv, then retry." >&2
  exit 1
fi

config_dir="$repo_root/.codex"
config_file="$config_dir/config.toml"
gitignore="$repo_root/.gitignore"
begin_marker="# BEGIN my-codex: add-code-review-graph"
end_marker="# END my-codex: add-code-review-graph"
table_header="[mcp_servers.code-review-graph]"

has_managed=0
if [ -f "$config_file" ] && grep -Fqx "$begin_marker" "$config_file"; then
  if [ "$(grep -Fxc "$begin_marker" "$config_file")" -ne 1 ] ||
    [ "$(grep -Fxc "$end_marker" "$config_file")" -ne 1 ] ||
    [ "$(grep -Fxc "$table_header" "$config_file")" -ne 1 ]; then
    echo "Managed code-review-graph section is malformed: $config_file" >&2
    exit 1
  fi
  has_managed=1
elif [ -f "$config_file" ] && grep -Fqx "$table_header" "$config_file"; then
  echo "Unmanaged code-review-graph MCP config already exists: $config_file" >&2
  exit 1
fi

if [ "$dry_run" -eq 1 ]; then
  if [ "$has_managed" -eq 1 ]; then
    echo "[dry-run] MCP config already installed: $config_file"
  else
    echo "[dry-run] Would add MCP config: $config_file"
  fi
  if [ -f "$gitignore" ] && grep -Eq '^/?\.code-review-graph/?$' "$gitignore"; then
    echo "[dry-run] Graph data already ignored: $gitignore"
  else
    echo "[dry-run] Would add .code-review-graph/ to: $gitignore"
  fi
  if [ "$build" -eq 1 ]; then
    echo "[dry-run] Would build and check graph: $repo_root"
  fi
  exit 0
fi

if [ "$has_managed" -eq 0 ]; then
  mkdir -p "$config_dir"
  if [ -s "$config_file" ]; then
    printf '\n' >> "$config_file"
  fi
  {
    echo "$begin_marker"
    echo "$table_header"
    echo 'command = "uvx"'
    echo 'args = ["code-review-graph", "serve", "--auto-watch"]'
    echo 'startup_timeout_sec = 60'
    echo "$end_marker"
  } >> "$config_file"
  echo "Installed MCP config: $config_file"
else
  echo "MCP config already installed: $config_file"
fi

if ! { [ -f "$gitignore" ] && grep -Eq '^/?\.code-review-graph/?$' "$gitignore"; }; then
  if [ -s "$gitignore" ]; then
    printf '\n' >> "$gitignore"
  fi
  echo '.code-review-graph/' >> "$gitignore"
  echo "Updated Git ignore: $gitignore"
else
  echo "Graph data already ignored: $gitignore"
fi

if [ "$build" -eq 1 ]; then
  uvx code-review-graph build --repo "$repo_root"
  uvx code-review-graph status --repo "$repo_root"
fi
