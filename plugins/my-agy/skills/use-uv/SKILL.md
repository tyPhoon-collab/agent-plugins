---
name: use-uv
description: Use when managing Python projects, running scripts, adding dependencies, or executing ad-hoc Python tools. Treat uv as the single tool for Python environments, project lifecycle, and package management.
---

# Use uv

Use `uv` for Python project lifecycle, environment isolation, and script execution. Never pollute system Python or pip.

## Project Lifecycle

- Initialize with `uv init [--app | --lib]`.
- Prefer `uv add` and `uv remove` for dependencies; avoid manual edits to `pyproject.toml`.
- Use `uv add --dev` for development tools (e.g. pytest, ruff).
- Pin Python versions with `uv python pin <version>`.

## Running & Tools

- Run project scripts: `uv run <script.py>` (never `uv run python <script.py>`).
- Run project tools: `uv run pytest`, `uv run ruff check`.
- Run standalone CLI tools without project install: `uvx <tool>`.
- Run ad-hoc verification outside the project: `uv run --no-project --with <package> <cmd>`.
- Direct `python3`: Use for one-liners and scripts requiring only the standard library.

## Standalone Scripts (PEP 723)

Use inline metadata for self-contained, single-file scripts:
- Initialize: `uv init --script <script.py>`
- Add dependencies: `uv add --script <script.py> <package>`

## Guardrails

- Never run `pip install` or manually create/activate virtual environments (`python -m venv`, `source .venv/bin/activate`).
- Avoid `uv pip install` inside projects; prefer `uv add`.
