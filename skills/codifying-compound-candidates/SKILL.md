---
name: codifying-compound-candidates
description: Use when you want to codify reusable lessons into existing docs/company-standards or docs/project-playbook topic files, either from direct user-provided compound content or from a Compound Candidates block produced by compound-engineering
---

# Codifying Compound Candidates

Use this skill to turn already-identified compound content into formal corpus cards inside the current project's existing topic files.

This skill is a **restricted codification step**, not a discovery workflow.

It should be used only after the reusable lesson is already visible enough to classify, for example:
- the user directly describes a lesson that should be codified
- `compound-engineering` has already produced a `Compound Candidates` block

## Scope

This skill may write only into:
- `docs/company-standards/`
- `docs/project-playbook/`

It may write only into **already-existing** `[topic].md` files under those corpora.

It must **never**:
- create a new `[topic].md`
- propose creating a new `[topic].md`
- silently create missing anchor files
- convert this step into a repo-wide discovery/bootstrap pass

If no existing topic file fits, skip the item entirely.

## Relationship to Other Skills

- `compound-engineering` produces candidate lessons.
- `codifying-compound-candidates` turns selected candidates into actual corpus cards.
- `bootstrapping-project-knowledge` is still the right skill for evidence-driven cold-start analysis of an existing repository.

Do **not** use this skill as a substitute for `bootstrapping-project-knowledge` when the real task is repository discovery.

## Intake Modes

This skill supports exactly two intake modes.

### 1. Direct intake

Use this mode when the user directly describes one or more lessons to codify.

The user may provide:
- the lesson itself
- a suggested destination corpus
- a suggested topic file
- supporting rationale or evidence

Treat user suggestions as hints, not as binding destinations.
This skill must still enforce existing-file-only matching.

### 2. From `compound-engineering`

Use this mode only when the input includes a `## Compound Candidates` block from `compound-engineering`.

In this mode:
- require the `## Compound Candidates` structure to be visible in the input
- only consume:
  - `### Promote to Company Standards`
  - `### Add to Project Playbook`
- do **not** codify anything from:
  - `### Keep in Feature Spec / Plan Only`

If the input does not actually contain a `## Compound Candidates` block, do **not** pretend it came from `compound-engineering`.
Treat it as direct intake instead.

## Corpus Boundaries

### Company Standards

Put a lesson in `docs/company-standards/` only if it is:
- reusable across multiple features or projects
- stable enough to remain useful over time
- broader than one repository quirk or one temporary workaround
- specific enough to review and cite by ID

Use the right ID family:
- `FE-*` for frontend
- `BE-*` for backend
- `SH-*` for shared cross-domain rules

### Project Playbook

Put a lesson in `docs/project-playbook/` only if it is tied to this repository, such as:
- integration-specific traps
- local patterns proven useful in this codebase
- legacy constraints
- vendor or architecture quirks that do not generalize cleanly

Use the right ID family:
- `PRJ-PIT-*` for pitfalls
- `PRJ-PAT-*` for patterns
- `PRJ-LEG-*` for legacy constraints

## Topic File Matching

Match conservatively.
Do not force a weak match.

### Matching for `docs/company-standards/`

First select the domain:
- `frontend/`
- `backend/`
- `shared/`

Then match to an existing topic file inside that domain.
Typical existing topics may include:
- frontend: `components.md`, `hooks.md`, `state.md`, `testing.md`
- backend: `api.md`, `services.md`, `data-access.md`, `observability.md`, `testing.md`
- shared: `architecture.md`, `reliability.md`, `rollout.md`, `security.md`, `testing.md`

### Matching for `docs/project-playbook/`

Match to an already-existing topic file such as:
- `pitfalls.md` for traps and failure modes
- `patterns.md` for proven local approaches
- `legacy-constraints.md` for historical or architectural limitations

### Hard Rule

If the corpus already exists and no existing `.md` file fits, skip the item entirely.
Do **not** create or propose a new topic file.

`README.md` and `index.md` are anchor files, not the default destination for codified compound content.
Prefer true topic files unless the user explicitly asks to update an anchor file and that file is already being used that way.

## Card Shapes

### Writing to `docs/company-standards/`

Write a rule card that follows the existing standards shape:
- `ID`
- `level`
- `keywords`
- `rule`
- `why`
- `applies when`
- `exceptions`
- `good example`
- `bad example`
- `reviewer checklist`

### Writing to `docs/project-playbook/`

Write a note card that follows the existing playbook shape:
- `ID`
- `type`
- `status`
- `last validated date`
- `keywords`
- `applies when`
- `symptom/problem`
- `recommended approach`
- `avoid/do not do`
- `why/history`
- `example`
- `reviewer checklist`

A topic file may contain multiple cards. Do **not** assume one file per rule or note.

## Confirmation Gate

Default workflow:
1. inspect the provided lesson(s) or `Compound Candidates` block
2. classify each item into company standards, project playbook, or skip
3. map each codifiable item to an already-existing topic file
4. produce a short codification plan
5. ask for confirmation
6. only then write or update the target corpus files

Do **not** write directly into `docs/company-standards/` or `docs/project-playbook/` by default.

The codification plan should make visible:
- intake mode
- source item
- destination corpus
- matched existing topic file
- card type
- why the match is appropriate
- skipped items and why they were skipped

## Skip Rules

Skip the item entirely when:
- no already-existing topic file fits
- the lesson is too vague to become a stable card
- the destination boundary is unclear and the ambiguity matters
- the item came from `Keep in Feature Spec / Plan Only`
- the item is clearly feature-specific or short-lived

Prefer fewer high-confidence codified entries over many weak ones.

## ID Governance

When assigning IDs:
- prefer additive growth over renumbering
- do not reshuffle existing IDs just to make numbering prettier
- do not reuse old IDs for new meanings
- resolve collisions by choosing the next available ID

## Output Language

Follow the user's language.
- If the user writes in Chinese, write the codification plan in Chinese.
- If the user writes in English, write it in English.
- Keep IDs, file paths, and code blocks unchanged.

## Red Flags

**Never:**
- invent a new topic file because the current structure feels inconvenient
- treat `compound-engineering` output as permission to auto-edit corpora
- codify `Keep in Feature Spec / Plan Only`
- silently broaden direct user input into a repo-wide discovery task
- force a lesson into `docs/company-standards/` when it is really repo-local
- force a lesson into `docs/project-playbook/` when it should remain feature-only

## Suggested Prompting Patterns

Direct intake example:

> Codify the following lesson into the current project's existing corpus files only. Do not create any new topic files. If no existing topic file fits, skip it and tell me why: <lesson>

From compound-engineering example:

> Use this `Compound Candidates` block from compound-engineering and propose codification targets only for entries under `Promote to Company Standards` and `Add to Project Playbook`. Do not codify `Keep in Feature Spec / Plan Only`. Only use already-existing topic files under `docs/company-standards/` and `docs/project-playbook/`.
