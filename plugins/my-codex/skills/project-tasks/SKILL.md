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

Resolve `<skill-dir>` from this skill's directory. Use the template only for
initialization; do not overwrite or reapply it to an existing `TASKS.md`, and
do not silently rename another task document.
3. Inspect the repository and user goal before proposing the first tasks.
4. Add proposed tasks only after showing the scope, dependencies, and
   acceptance criteria to the user.

## Maintain

- Read the existing document before editing it.
- Preserve its terminology, structure, numbering, and project-specific rules.
- Use `[ ]` for open, `[/]` for in-progress, `[x]` for complete, and `[-]`
  for cancelled items. Keep blocked or deferred work in `Deferred Items` unless
  the project already defines another status convention.
- Keep task details actionable: purpose, work, acceptance criteria, and
  verification. Do not mark work complete without recorded verification.
- Assign each new task the next unused ID in the ledger's single `TASK-001`
  sequence. Keep IDs stable in headings, the `Contents`, and references, and
  never reuse them after a task is deleted. Preserve an existing
  project-specific ID convention.
- Record current location, each task's prerequisites, task-common acceptance
  criteria, deferred work, and out-of-scope items when they materially help
  future sessions.
- Derive implementation order from each task's `Prerequisites`; do not maintain
  a separate implementation-order section.
- Keep `TASKS.md`'s `Contents` limited to task headings. Update it when adding,
  removing, or renaming a task; leave it empty when no tasks exist. Keep task
  details under `## Tasks`.
- Ask before adding tasks, changing scope, or marking tasks complete. Routine
  cleanup of verified terminal tasks follows the Git rules below.
- Do not execute a task merely because it is listed. Hand execution to the
  applicable workflow or implementation request.

## Git

Apply this section only when `TASKS.md` is not gitignored and the project
intends to track it in Git. If it is ignored or intentionally untracked, skip
these Git-specific commit and cleanup rules.

- Include task status and verification updates in the implementation commit.
  Use a follow-up documentation commit when they happen later.
- Commit planning-only or maintenance-only changes as a documentation commit.
- For a completed task, after the implementation commit exists, record the
  task ID and short commit hash in `Current Status`, then remove the task
  details in a later cleanup commit. Never write the hash before the commit
  exists.
- Do not stage or commit automatically. When the user requests a commit, use
  the applicable commit workflow and include `TASKS.md` when its changes are
  part of that work.

## Completed Tasks

Before deleting a completed task (`[x]`), verify that:

- its work and acceptance criteria are complete;
- verification is recorded;
- when Git rules apply, implementation changes are represented in Git history.

Before deleting a cancelled task (`[-]`), verify that its cancellation reason
is recorded. Do not delete an in-progress (`[/]`) task. Do not renumber later
tasks after deletion. Keep the corresponding short `Current Status` note while
it remains useful; when Git rules apply, include the short commit hash for a
completed task.
