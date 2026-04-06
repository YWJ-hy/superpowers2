# Shared Reliability Standards

## SH-REL-001 Put retry and idempotency at the ownership boundary

**Level:** recommended
**Keywords:** retries, idempotency, reliability, ownership

### Rule
Place retry and idempotency handling at the boundary that truly owns the operation rather than scattering retries across multiple callers.

### Why
Reliability improves when one clear boundary owns retries, deduplication, or idempotency semantics.

### Applies when
- designing retryable jobs or requests
- integrating with flaky external systems
- deciding where idempotency keys or dedupe checks belong

### Exceptions
- simple local retries that are purely internal and cannot conflict with a broader ownership boundary

### Good example
```ts
await paymentService.captureWithIdempotency(command)
```

### Bad example
```ts
await retry(() => controllerCall())
await retry(() => serviceCall())
await retry(() => repositoryCall())
```

### Reviewer checklist
- Is retry/idempotency owned at one clear boundary?
- Did the change avoid duplicated retry logic at multiple layers?
