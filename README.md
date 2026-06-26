# agent-plugins

Agent plugin marketplace repository for Codex extensions.

This repository currently exposes one Codex marketplace, `agent-plugins`, with
the `my-codex` plugin. It packages Codex lifecycle hooks, reusable skills, and
project-local rule templates, and is meant to grow with MCP configuration,
scripts, and other agent workflow defaults.

## Included capabilities

- Hooks that play local lifecycle sounds for approval requests and completed
  turns.
- `add-project-rules`: Copy a starter `.codex/rules/default.rules` into a
  project so command allowlists can be maintained per repository.
- `commit-message`: Use `type: 日本語の概要` commit messages with Conventional
  Commits types when a project has no more specific rule.
- `use-mise`: Treat `mise.toml` as the source of truth for project tool
  versions and environment setup while leaving task execution to just.
- `use-just`: Treat `justfile` as the project task entrypoint and prefer
  documented recipes over ad hoc command execution.

## Install

Install from GitHub:

```sh
codex plugin marketplace add tyPhoon-collab/agent-plugins --ref main
codex plugin add my-codex@agent-plugins
```

After installation, start a new Codex thread. Use `/hooks` to review and trust
any lifecycle hooks bundled by installed plugins.

## Local development

```sh
codex plugin marketplace add /path/to/agent-plugins
codex plugin add my-codex@agent-plugins
```

If switching from a local marketplace to GitHub, remove and re-add the
marketplace:

```sh
codex plugin marketplace remove agent-plugins
codex plugin marketplace add tyPhoon-collab/agent-plugins --ref main
codex plugin add my-codex@agent-plugins
```
