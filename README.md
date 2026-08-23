# agent-plugins

Agent plugin marketplace repository for Codex and Antigravity (AGY) extensions.

This repository packages lifecycle hooks, reusable skills, rules, and tooling defaults across AI coding agents:
- **`plugins/my-codex`**: Extensions for OpenAI Codex.
- **`plugins/my-agy`**: Extensions for Google Antigravity (AGY).
- **`skills/`**: Source of truth for shared agent-agnostic skills, copied into each plugin for distribution.

## Included capabilities

- **Lifecycle hooks**: Play local sounds for approval requests and completed turns (`afplay` on macOS).
- **`compact`**: Keep Japanese chat replies concise while preserving technical content and safety-critical detail.
- **`commit-message`**: Use `type: 日本語の概要` commit messages with Conventional Commits types when a project has no more specific rule.
- **`use-mise`**: Treat `mise.toml` as the source of truth for project tool versions and environment setup while leaving task execution to just.
- **`use-just`**: Treat `justfile` as the project task entrypoint and prefer documented recipes over ad hoc command execution.
- **`worktree-switch`**: Create and switch Worktrunk worktrees safely.
- **`worktree-cleanup`**: Review and remove completed Worktrunk worktrees in batches.
- **`project-tasks`**: Maintain a repository-local `TASKS.md` task ledger from a bundled initialization template.
- **`add-project-rules`**: Copy a starter rule file (`.codex/rules/default.rules` for Codex, `AGENTS.md` for Antigravity) into a target repository.
- **`add-code-review-graph`**: Configure code-review-graph as a project-scoped MCP server (`.codex/config.toml` for Codex, `.agents/mcp_config.json` for Antigravity).

## Install & Usage

### Sync shared skills

After changing `skills/`, regenerate the copies in both plugins:

```sh
./scripts/sync-skills.sh
```

The command preserves plugin-specific files and agent-specific skills.
Real files are required because Codex does not discover plugin skills through symbolic links.

### For Codex

Install from GitHub:

```sh
codex plugin marketplace add tyPhoon-collab/agent-plugins --ref main
codex plugin add my-codex@agent-plugins
```

After installation, start a new Codex thread. Use `/hooks` to review and trust any lifecycle hooks bundled by installed plugins.

Local development:

```sh
codex plugin marketplace add /path/to/agent-plugins
codex plugin add my-codex@agent-plugins
```

### For Antigravity (AGY)

#### CLI command installation (Recommended)

Install directly from GitHub or a local directory:

```sh
# Remote GitHub repository
agy plugin install https://github.com/tyPhoon-collab/agent-plugins.git

# Local installation
agy plugin install /path/to/agent-plugins/plugins/my-agy

# Validate plugin
agy plugin validate /path/to/agent-plugins/plugins/my-agy
```

#### Manual / Workspace installation

- **Global configuration**:
  ```sh
  mkdir -p ~/.gemini/config/plugins
  ln -s /path/to/agent-plugins/plugins/my-agy ~/.gemini/config/plugins/my-agy
  ```
- **Project workspace**:
  ```sh
  mkdir -p .agents/plugins
  ln -s /path/to/agent-plugins/plugins/my-agy .agents/plugins/my-agy
  ```
