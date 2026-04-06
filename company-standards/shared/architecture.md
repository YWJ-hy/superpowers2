# Shared Architecture Standards

## SH-ARCH-001 Boundaries should reflect ownership, not tooling layers

**Level:** required
**Keywords:** architecture, boundaries, ownership, layering

### Rule
System boundaries should reflect ownership and responsibility, not just framework, directory, or tooling layers.

### Why
Ownership-aligned boundaries are easier to reason about than structures created only to satisfy technical layering preferences.

### Applies when
- splitting modules or services
- deciding how to decompose a feature
- reviewing whether a refactor improved architecture

### Exceptions
- small codebases where lightweight layering is enough and ownership is already clear

### Good example
```ts
orderService -> paymentService -> notificationService
```

### Bad example
```ts
controllers/ -> managers/ -> processors/ -> helpers/
```

### Reviewer checklist
- Does the boundary reflect clear ownership?
- Is the design driven by responsibility rather than abstract layering?

## SH-ARCH-002 Specs must record non-goals explicitly

**Level:** recommended
**Keywords:** specs, non-goals, scope, boundaries

### Rule
Specs should record explicit non-goals so implementation and review can distinguish intentional omissions from missing work.

### Why
Clear non-goals reduce overbuilding and prevent reviewers from inventing scope that was never agreed.

### Applies when
- writing feature designs
- planning multi-step work
- reviewing potentially ambiguous changes

### Exceptions
- trivial one-line changes where the scope is already obvious

### Good example
```md
## Non-goals
- no schema migration
- no mobile-specific redesign
```

### Bad example
```md
## Scope
- improve the workflow
```

### Reviewer checklist
- Are non-goals explicit?
- Would a reviewer know what was intentionally left out?

## SH-ARCH-003 Keep long-lived engineering knowledge in explicit corpora with stable IDs

**Level:** recommended
**Keywords:** knowledge management, corpora, stable ids, workflow, specs, plans

### Rule
Long-lived engineering guidance should live in explicit corpora with stable IDs so specs, plans, task packets, and review flows can cite the same source of truth.

### Why
Reusable workflow knowledge loses force when it stays implicit, conversational, or hidden in one-off docs.

### Applies when
- defining durable workflow rules
- creating reusable skills or review flows
- deciding whether a lesson should be codified beyond one feature

### Exceptions
- short-lived feature decisions that only matter inside one spec or plan

### Good example
```md
Applicable Standards
- SH-ARCH-003 Keep long-lived engineering knowledge in explicit corpora with stable IDs
```

### Bad example
```md
Remember this workflow rule from our last chat.
```

### Reviewer checklist
- Is this guidance durable enough to outlive one feature?
- Does it need a stable ID so later workflow artifacts can cite it directly?

## SH-ARCH-004 Pass only task-relevant excerpts instead of full corpora

**Level:** required
**Keywords:** context, excerpts, task packets, subagents, prompt curation

### Rule
Give implementers and reviewers only the excerpts needed for the current task instead of dumping the full standards corpus into every prompt.

### Why
Curated excerpts reduce context pollution while keeping compliance explicit.

### Applies when
- dispatching subagents
- building task packets
- reviewing multi-stage workflows with large corpora

### Exceptions
- very small corpora where the full context is already minimal and clearly bounded

### Good example
```md
Applicable Standards
- SH-ARCH-004: pass only the relevant excerpt for this task
```

### Bad example
```md
Paste the entire standards corpus into every implementer prompt.
```

### Reviewer checklist
- Did the task packet include only relevant standards or project-note excerpts?
- Did the workflow avoid unnecessary full-corpus loading?
