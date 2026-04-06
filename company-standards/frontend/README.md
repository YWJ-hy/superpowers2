# Frontend Standards Corpus

This directory is the frontend domain corpus under `company-standards/`.
In v1 it serves as a repo-root template structure for this fork's progressive-disclosure workflow.

## Purpose

Use this corpus for organization-level frontend rules that should apply across multiple features and projects:
- component boundaries
- hook design
- state ownership
- testing expectations

This corpus is one domain-specific part of the broader company standards framework, which can also include backend and shared standards.

These files are the **default repo-root template structure** for the frontend domain in v1. The workflow should still talk about a *standards corpus* rather than hard-coding this path too deeply, so future backend/shared corpora or a private overlay can be introduced without rewriting the entire skill chain.

## How the workflow uses this corpus

1. `brainstorming` maps a feature to relevant rule IDs.
2. `writing-plans` copies the relevant rule IDs and any available excerpts into each task packet.
3. `subagent-driven-development` passes only the task-relevant excerpts when they are available.
4. `compound-engineering` suggests changes back into this corpus when a new practice proves reusable.

## Rule levels

- `required` — default blocker if violated
- `recommended` — expected by default, but deviations may be justified
- `optional` — useful guidance, not a blocker

## File map

Anchor files:
- `README.md` — local purpose / authoring guide
- `index.md` — quick lookup for rule IDs

Common v1 topic files:
- `components.md` — component decomposition and prop-surface rules
- `hooks.md` — hooks, effects, and async workflow rules
- `state.md` — state ownership rules
- `testing.md` — testing rules

These are recommended groupings, not a required taxonomy. Add other topic markdown files when the corpus needs a clearer split, but keep `README.md` and `index.md` as stable anchors.

## Authoring rules

Keep rules as stable cards with:
- ID
- level
- keywords
- rule
- why
- applies when
- exceptions
- good example
- bad example
- reviewer checklist

Prefer additive edits over renumbering. If a rule is replaced, deprecate it before removal.
