# Shared Standards Corpus

This directory contains cross-domain standards used by multiple parts of the stack.

## Purpose

Use this corpus for guidance that is not frontend-only or backend-only.

Typical examples:
- testing philosophy
- architectural boundaries
- security at system boundaries
- rollout and migration expectations
- reliability and verification
- naming and documentation expectations

## Typical structure

Anchor files:
- `README.md` — local purpose / authoring guide
- `index.md` — quick lookup for stable rule IDs

Suggested topic files:
- `testing.md`
- `architecture.md`
- `security.md`
- `reliability.md`
- `rollout.md`
- `documentation.md`

These topic files are examples, not a fixed required list. Add other markdown files when they improve grouping, but keep `README.md` and `index.md` as stable anchors.

## What belongs here

Put a rule here when it:
- applies to both frontend and backend work
- is useful across many repositories
- describes a company-wide engineering expectation
- should be referenced by multiple domain corpora

## What does NOT belong here

Do not put here:
- frontend-only component or hook rules
- backend-only API/service rules
- repo-local lessons
- feature-specific design decisions

## ID prefixes

Use `SH-*`.

Example ID families:
- `SH-TEST-*`
- `SH-ARCH-*`
- `SH-SEC-*`
- `SH-ROLL-*`
