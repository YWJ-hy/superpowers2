# Project Pitfalls

## PRJ-PIT-001 Polling requests can race with tab or filter switching

**Type:** pitfall
**Status:** active
**Last validated:** 2026-04-05
**Keywords:** polling, race condition, tab switching, stale response

### Applies when
- a page polls server data
- the user can switch tabs or filters while requests are in flight
- one screen reuses the same list state across multiple views

### Symptom / Problem
Old responses can overwrite newer UI state after the user changes tab or filter context.

### Recommended approach
Use request identity, abort handling, or stale-response guards at the data boundary so older responses cannot win.

### Avoid / Do not do
- do not rely only on a single `loading` boolean
- do not patch individual pages with ad hoc timeout or debounce logic

### Why / History
This project has seen stale-data flashes caused by in-flight requests resolving after the active view context changed.

### Example
```ts
const requestId = ++latestRequestId.current
const result = await fetchOrders()
if (requestId !== latestRequestId.current) return
setOrders(result)
```

### Reviewer checklist
- Are stale responses ignored or cancelled?
- Is request ownership explicit?
- Did the change avoid page-specific race patches?

## PRJ-PIT-002 Ad hoc loading booleans often hide request ownership bugs

**Type:** pitfall
**Status:** active
**Last validated:** 2026-04-05
**Keywords:** loading state, ownership, race condition, request lifecycle

### Applies when
- multiple requests can overlap
- loading is derived from several async branches
- pages patch over timing issues with local booleans

### Symptom / Problem
A single `loading` boolean can make the UI appear correct while stale writes or overlapping requests still exist underneath.

### Recommended approach
Track request ownership explicitly and model success/error/loading transitions at the same boundary that owns the request.

### Avoid / Do not do
- do not use a single page-level boolean as the only concurrency guard
- do not hide request identity problems with extra spinners or delayed clearing

### Why / History
The project has repeatedly seen timing issues that looked like loading glitches but were really ownership bugs.

### Example
```ts
const currentRequest = Symbol('orders-request')
requestRef.current = currentRequest
const result = await loadOrders()
if (requestRef.current !== currentRequest) return
```

### Reviewer checklist
- Is loading modeled alongside request ownership?
- Would overlapping requests still behave correctly?

## PRJ-PIT-003 Misclassifying repo-local notes as company standards weakens the corpus split

**Type:** pitfall
**Status:** active
**Last validated:** 2026-04-06
**Keywords:** classification, corpus split, standards, playbook, repo-local knowledge

### Applies when
- classifying new lessons
- bootstrapping corpus content
- deciding whether a finding should be promoted beyond this repo

### Symptom / Problem
Repo-specific lessons get promoted too early into long-lived shared standards, which blurs the line between reusable rules and local operating knowledge.

### Recommended approach
Keep repo-bound patterns, pitfalls, and legacy constraints in `docs/project-playbook/` unless the evidence clearly shows cross-project reuse.

### Avoid / Do not do
- do not elevate local architecture quirks into company-wide rules without wider proof
- do not treat one repository’s workflow preferences as automatically reusable everywhere

### Why / History
This repository explicitly separates company standards from project playbook notes so repo-local lessons do not pollute the shared corpus.

### Example
```md
This note is specific to superpowers2 workflow terminology, so it belongs in project playbook, not shared standards.
```

### Reviewer checklist
- Is the lesson truly reusable across projects?
- If not, was it kept in project playbook instead of promoted?

## PRJ-PIT-004 Contribution-facing workflow changes in this repo require a real problem statement, evidence, and human review

**Type:** pitfall
**Status:** active
**Last validated:** 2026-04-06
**Keywords:** contribution workflow, evidence, human review, problem statement, evaluation

### Applies when
- proposing core workflow changes inside this repository
- changing skills that shape agent behavior
- preparing a contribution-facing PR or patch

### Symptom / Problem
Workflow-facing changes get proposed without a concrete user failure, eval evidence, or human review, which leads to speculative or low-rigor updates.

### Recommended approach
Require a real motivating problem, explicit eval evidence, and human review before treating a workflow change as ready for submission.

### Avoid / Do not do
- do not justify workflow changes with speculative improvements alone
- do not submit behavior-shaping changes without a human reviewing the full diff

### Why / History
This repository has an unusually high rejection bar for workflow and skill changes, so speculative updates are treated as a repeat failure mode rather than a harmless shortcut.

### Example
```md
Problem: a real session failed to surface the right review loop.
Evidence: before/after eval sessions documented.
Human review: complete diff reviewed before submission.
```

### Reviewer checklist
- Is there a real user or session problem behind the change?
- Is there concrete eval evidence?
- Has a human reviewed the complete proposed diff?
