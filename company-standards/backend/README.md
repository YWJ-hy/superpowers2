# Backend Standards Corpus

This directory contains backend-specific standards used across company projects.

## Purpose

Use this corpus for long-lived backend guidance such as:
- API design and handler boundaries
- service-layer ownership
- data-access patterns
- jobs and async processing
- observability
- backend testing

## Typical structure

Anchor files:
- `README.md` — local purpose / authoring guide
- `index.md` — quick lookup for stable rule IDs

Suggested topic files:
- `api.md`
- `services.md`
- `data-access.md`
- `jobs.md`
- `observability.md`
- `testing.md`

These topic files are examples, not a fixed required list. Add other markdown files when they improve grouping, but keep `README.md` and `index.md` as stable anchors.

## What belongs here

Put a rule here when it:
- applies across multiple backend services or features
- is not specific to one repository's local quirks
- is stable enough to be cited by ID in specs and plans

## What does NOT belong here

Do not put here:
- repo-specific infrastructure quirks
- a single vendor integration trap unique to one project
- one-off migration notes
- legacy limitations of one service only

Those belong in `project-playbook/`.

## ID prefixes

Use `BE-*`.

Examples:
- `BE-API-001`
- `BE-SVC-002`
- `BE-DATA-001`
- `BE-TEST-001`
