---
name: add-code-review-graph
description: Install code-review-graph as a project-scoped Antigravity MCP server. Use when the user wants to add, initialize, configure, or enable code-review-graph for one Git repository without changing global configuration.
---

# Add Code Review Graph

Install code-review-graph into the target repository through `.agents/mcp_config.json`. Use `uvx` so no global code-review-graph installation is required. Keep graph data in the repository and out of Git.

## Workflow

1. Confirm the target is a Git repository and that project-local Antigravity config is appropriate.
2. Run `scripts/install-code-review-graph.sh`, passing the target repository when it is not the current directory.
3. Offer to append the optional graph-usage instructions below to the target repository's `AGENTS.md`. Ask for explicit user approval before changing it.
4. If approved, append the managed instruction block only when it is not already present. Preserve all existing `AGENTS.md` content.
5. Report the files changed and the build/status result.

Install into the current repository:

```sh
<this-skill>/scripts/install-code-review-graph.sh
```

Install into another repository:

```sh
<this-skill>/scripts/install-code-review-graph.sh /path/to/repo
```

Preview without changing files:

```sh
<this-skill>/scripts/install-code-review-graph.sh --dry-run /path/to/repo
```

Skip the initial graph build:

```sh
<this-skill>/scripts/install-code-review-graph.sh --no-build /path/to/repo
```

## Behavior

- Require `uvx`; do not install `uv` or modify machine-global configuration.
- Add `code-review-graph` to `.agents/mcp_config.json`.
- Add `.code-review-graph/` to `.gitignore`.
- Do not modify `AGENTS.md` without explicit user approval.

Optional `AGENTS.md` block:

```md
<!-- BEGIN my-agy: code-review-graph -->
## Code Review Graph

When the code-review-graph MCP server is available:

- Use it first for repository exploration, code review, debugging, architecture, and change-impact questions.
- Start with `get_minimal_context_tool` when the task needs repository-wide context.
- Prefer targeted graph queries and minimal detail over broad scans.
- Treat graph results as navigation and analysis hints; verify important conclusions in source files.
- Use normal file tools when graph data is unavailable, stale, too slow, or insufficient.
- Do not use graph tools for trivial edits where their overhead is not worthwhile.
<!-- END my-agy: code-review-graph -->
```

## Resource

- `scripts/install-code-review-graph.sh`: installs project config, updates `.gitignore`, builds the graph, and checks status.
