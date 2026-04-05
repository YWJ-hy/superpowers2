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
2. `writing-plans` copies only the relevant project-note IDs and excerpts into each task packet.
3. `subagent-driven-development` passes only those excerpts to implementer and reviewer subagents.
4. `compound-engineering` suggests whether a new lesson belongs here or should be promoted to company standards instead.

## File map

- `index.md` — quick lookup for project-note IDs
- `pitfalls.md` — common traps and failure modes
- `patterns.md` — local patterns proven useful in this repo
- `legacy-constraints.md` — historical or architectural constraints

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
