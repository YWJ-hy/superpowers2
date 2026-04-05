# Company Standards

This directory contains the organization-level standards corpora used by this workflow.

These corpora are long-lived sources of engineering guidance that can be referenced from:
- feature specs
- implementation plans
- task packets
- subagent prompts
- review workflows

## Structure

- `frontend/` — frontend-specific standards
- `backend/` — backend-specific standards
- `shared/` — cross-domain standards used by multiple parts of the stack

## Current v1 status

In v1, `frontend/` is the primary seeded corpus.
The framework is intentionally designed so additional corpora can be added without changing the workflow model.

That means:
- `brainstorming` maps a feature to relevant standards IDs
- `writing-plans` binds those IDs to task packets
- `subagent-driven-development` passes only relevant excerpts
- `compound-engineering` suggests where new lessons should be promoted

## What belongs here

Put guidance here when it is:
- reusable across multiple features or projects
- expected to remain useful over time
- broader than one repository or one feature
- specific enough to be reviewed and cited by ID

Examples:
- frontend component and hook rules
- backend service/API/data-access rules
- shared testing, security, architecture, and rollout rules

## What does NOT belong here

Do not put these here:
- repo-specific traps or legacy constraints
- vendor quirks unique to one project
- one-off feature decisions
- temporary migration notes

Those belong in:
- `docs/project-playbook/` for repo-specific knowledge
- `docs/superpowers/specs/` for feature-specific design
- `docs/superpowers/plans/` for execution details

## Rule IDs

Use domain-specific prefixes:

- `FE-*` for frontend
- `BE-*` for backend
- `SH-*` for shared

Examples:
- `FE-COMP-001`
- `BE-API-002`
- `SH-TEST-001`

## Rule shape

Each rule should be a stable card with:
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

## Governance

- Treat standards changes as code-reviewed PRs
- Prefer additive edits over renumbering
- Deprecate before removing widely used rules
- Keep examples concise and realistic
- Keep domain-specific rules inside the right corpus
