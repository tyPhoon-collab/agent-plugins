---
name: add-code-review-graph
description: Install code-review-graph as a project-scoped Codex MCP server. Use when the user wants to add, initialize, configure, or enable code-review-graph for one Git repository without changing global `~/.codex` configuration.
---

# Add Code Review Graph

Install code-review-graph into the target repository through
`.codex/config.toml`. Use `uvx` so no global code-review-graph installation is
required. Keep graph data in the repository and out of Git.

## Workflow

1. Confirm the target is a Git repository and that project-local Codex config
   is appropriate.
2. Run `scripts/install-code-review-graph.sh`, passing the target repository
   when it is not the current directory.
3. Report the files changed and the build/status result.
4. Tell the user to trust the repository and restart Codex so the new MCP
   server loads.

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

Skip the initial graph build only when the user requests configuration alone:

```sh
<this-skill>/scripts/install-code-review-graph.sh --no-build /path/to/repo
```

## Behavior

- Require `uvx`; do not install `uv` or modify machine-global configuration.
- Add a managed `[mcp_servers.code-review-graph]` section that runs
  `uvx code-review-graph serve --auto-watch`.
- Add `.code-review-graph/` to the repository `.gitignore`.
- Preserve existing config. Stop when an unmanaged MCP section with the same
  name exists instead of overwriting it.
- Do not modify `AGENTS.md`, Codex hooks, or `~/.codex/*`.
- The package version intentionally floats because this workflow uses the
  latest available code-review-graph release.

## Resource

- `scripts/install-code-review-graph.sh`: installs project config, updates
  `.gitignore`, builds the graph, and checks status.
