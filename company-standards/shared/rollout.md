# Shared Rollout Standards

## SH-ROLL-001 Rollout-sensitive changes need a verification plan

**Level:** recommended
**Keywords:** rollout, migration, deployment, verification

### Rule
Changes that are risky to release should include an explicit verification plan covering how correctness will be checked during or after rollout.

### Why
A release plan is incomplete if it describes the change but not how to verify it safely in the real environment.

### Applies when
- changing APIs, schemas, queues, auth, or data flow
- making infrastructure-sensitive or rollout-sensitive edits
- deploying changes with meaningful operational risk

### Exceptions
- tiny changes with negligible blast radius and obvious verification

### Good example
```md
## Verification
- run integration tests
- verify canary metric remains within threshold
- confirm no migration errors in logs
```

### Bad example
```md
## Verification
- should be fine
```

### Reviewer checklist
- Is there a concrete rollout verification plan?
- Would operators know what to watch after release?
