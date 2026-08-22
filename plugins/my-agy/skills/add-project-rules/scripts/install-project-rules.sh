#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSET_FILE="${SCRIPT_DIR}/../assets/AGENTS.starter.md"

FORCE=0
TARGET_DIR="."

while [[ $# -gt 0 ]]; do
  case "$1" in
    --force|-f)
      FORCE=1
      shift
      ;;
    *)
      TARGET_DIR="$1"
      shift
      ;;
  esac
done

TARGET_FILE="${TARGET_DIR}/AGENTS.md"

if [[ ! -d "${TARGET_DIR}" ]]; then
  echo "Error: Target directory '${TARGET_DIR}' does not exist." >&2
  exit 1
fi

if [[ -f "${TARGET_FILE}" && "${FORCE}" -eq 0 ]]; then
  echo "AGENTS.md already exists at '${TARGET_FILE}'. Use --force to overwrite." >&2
  exit 1
fi

cp "${ASSET_FILE}" "${TARGET_FILE}"
echo "Initialized starter AGENTS.md at '${TARGET_FILE}'."
