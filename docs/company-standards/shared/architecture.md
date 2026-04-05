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
