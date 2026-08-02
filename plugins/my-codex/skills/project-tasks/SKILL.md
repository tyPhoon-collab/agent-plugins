---
name: project-tasks
description: Maintain a repository-local `TASKS.md` as a living project task ledger. Use when initializing, reading, planning, updating, verifying, completing, or pruning project tasks, roadmap items, acceptance criteria, deferred work, or scope boundaries. Do not use it to execute the tasks themselves.
---

# Project Tasks

Maintain one repository-local `TASKS.md`. Keep it useful as current project
context, not as a complete historical log.

## Initialize

1. Look for `TASKS.md` at the repository root.
2. If it does not exist, copy the bundled template:

```sh
cp <skill-dir>/assets/TASKS.md TASKS.md
```

Resolve `<skill-dir>` from this skill's directory. Do not overwrite an
existing `TASKS.md` or silently rename another task document.
3. Inspect the repository and user goal before proposing the first tasks.
4. Add proposed tasks only after showing the scope, dependencies, and
   acceptance criteria to the user.

## Maintain

- Read the existing document before editing it.
- Preserve its terminology, structure, numbering, and project-specific rules.
- Use `[ ]` for open, `[/]` for in-progress, `[x]` for complete, and `[-]`
  for cancelled items. Keep blocked or deferred work in `保留事項` unless
  the project already defines another status convention.
- Keep task details actionable: purpose, work, acceptance criteria, and
  verification.
- Record current location, design constraints, implementation order,
  cross-cutting completion conditions, deferred work, and out-of-scope items
  when they materially help future sessions.
- Do not mark work complete without evidence. Record relevant tests,
  inspection, or other verification.
- Ask before adding tasks, changing scope, marking tasks complete, or making
  structural changes.
- Do not execute a task merely because it is listed. Hand execution to the
  applicable workflow or implementation request.

## Git

Treat `TASKS.md` as a Git-managed project artifact.

- As a rule, include task status and verification updates in the same commit
  as the implementation they describe. Use a follow-up documentation commit
  when the update happens after the implementation commit.
- Commit planning-only or maintenance-only changes as a documentation commit.
- Do not add a commit hash to `TASKS.md` before the commit exists. Git history
  already records the relationship.
- Delete completed task details in a later cleanup commit, not the
  implementation commit. This keeps the detailed completed task in the
  implementation commit's parent history.
- Do not stage or commit automatically. When the user requests a commit, use
  the applicable commit workflow and include `TASKS.md` when its changes are
  part of that work.

## Completed Tasks

Keep completed task details until they are no longer useful. A user may ask
to prune completed tasks in batches.

Before deleting a terminal task (`[x]` complete or `[-]` cancelled), verify or
ask the user to confirm that:

- its work and acceptance criteria are complete;
- verification is recorded;
- implementation changes are represented in Git history; and
- the user approves removing the task details from `TASKS.md`.

Do not delete an in-progress (`[/]`) task. Show deletion candidates, evidence,
and any dependent references first. Do not renumber later tasks after deletion.
Preserve a short current-location note when later work depends on the deleted
tasks; otherwise remove the details and defer history to Git.

## Template

Use [assets/TASKS.md](assets/TASKS.md) only for initializing a missing file.
Do not reapply it to an existing document.
