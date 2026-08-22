#!/usr/bin/env bash
set -euo pipefail

dry_run=0
build=1
target_dir="."
target_set=0

while [[ $# -gt 0 ]]; do
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
      if [[ "$target_set" -eq 1 ]]; then
        echo "Only one target repository may be specified." >&2
        exit 2
      fi
      target_dir="$1"
      target_set=1
      ;;
  esac
  shift
done

if [[ ! -d "$target_dir" ]]; then
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

config_dir="$repo_root/.agents"
config_file="$config_dir/mcp_config.json"
gitignore="$repo_root/.gitignore"

if [[ "$dry_run" -eq 1 ]]; then
  echo "[dry-run] Would configure MCP server in: $config_file"
  if [[ -f "$gitignore" ]] && grep -Eq '^/?\.code-review-graph/?$' "$gitignore"; then
    echo "[dry-run] Graph data already ignored: $gitignore"
  else
    echo "[dry-run] Would add .code-review-graph/ to: $gitignore"
  fi
  if [[ "$build" -eq 1 ]]; then
    echo "[dry-run] Would build and check graph: $repo_root"
  fi
  exit 0
fi

mkdir -p "$config_dir"

python3 -c "
import json, os

config_file = '$config_file'
data = {}
if os.path.exists(config_file) and os.path.getsize(config_file) > 0:
    try:
        with open(config_file, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except Exception:
        data = {}

if 'mcpServers' not in data:
    data['mcpServers'] = {}

data['mcpServers']['code-review-graph'] = {
    'command': 'uvx',
    'args': ['code-review-graph', 'serve', '--auto-watch']
}

with open(config_file, 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write('\n')
"

echo "Installed MCP config: $config_file"

if ! { [[ -f "$gitignore" ]] && grep -Eq '^/?\.code-review-graph/?$' "$gitignore"; }; then
  if [[ -s "$gitignore" ]]; then
    printf '\n' >> "$gitignore"
  fi
  echo '.code-review-graph/' >> "$gitignore"
  echo "Updated Git ignore: $gitignore"
else
  echo "Graph data already ignored: $gitignore"
fi

if [[ "$build" -eq 1 ]]; then
  uvx code-review-graph build --repo "$repo_root"
  uvx code-review-graph status --repo "$repo_root"
fi
