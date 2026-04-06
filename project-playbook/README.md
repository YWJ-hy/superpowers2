# Project Playbook Corpus

This directory stores repo-specific experience, pitfalls, legacy constraints, and proven local patterns.

## Purpose

Use this corpus for information that is true for this project but should not be promoted to company-wide standards:
- integration-specific traps
- legacy constraints
- project-proven workarounds and patterns
- testing gotchas unique to this repo

## How the workflow uses this corpus

1. `brainstorming` maps a feature to relevant project-note IDs.
2. `writing-plans` copies the relevant project-note IDs and any available excerpts into each task packet.
3. `subagent-driven-development` passes only the task-relevant excerpts when they are available.
4. `compound-engineering` suggests whether a new lesson belongs here or should be promoted to company standards instead.

## File map

Anchor files:
- `README.md` — local purpose / authoring guide
- `index.md` — quick lookup for project-note IDs

Default starting files:
- `pitfalls.md` — common traps and failure modes
- `patterns.md` — local patterns proven useful in this repo
- `legacy-constraints.md` — historical or architectural constraints

Additional topic markdown files are allowed when they make the corpus easier to navigate. The stable note ID is the reference key; filenames are just grouping containers.

## Note shape

Keep notes stable and explicit:
- ID
- type
- status
- last validated date
- keywords
- applies when
- symptom/problem
- recommended approach
- avoid/do not do
- why/history
- example
- reviewer checklist

The note card is the unit that later specs, plans, and task packets cite. A topic file may contain multiple note cards; this framework does not require one file per note.

## Governance

- Prefer additive edits over renumbering
- Do not renumber existing notes just to make sequences prettier
- Do not reuse old IDs for new meanings
- When multiple maintainers add notes concurrently, resolve collisions at merge time by choosing the next available ID
- If a note is retired or superseded, deprecate it clearly instead of silently recycling the ID
