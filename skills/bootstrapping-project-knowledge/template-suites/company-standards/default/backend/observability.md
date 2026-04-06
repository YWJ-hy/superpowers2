# Backend Observability Standards

## BE-OBS-001 Log with request or job identity

**Level:** required
**Keywords:** logging, request id, job id, tracing, observability

### Rule
Logs for backend workflows should carry request identity, job identity, or another stable execution identifier.

### Why
Stable identity is what turns logs from local debugging noise into traceable operational evidence.

### Applies when
- handling HTTP requests
- processing background jobs
- running retryable async workflows

### Exceptions
- tiny local scripts or one-off tooling not used in operations

### Good example
```ts
logger.info({ requestId, orderId }, 'placing order')
```

### Bad example
```ts
logger.info('placing order')
```

### Reviewer checklist
- Can this execution path be correlated in logs?
- Is the identifier stable enough to trace the workflow?

## BE-OBS-002 Emit metrics at stable ownership boundaries

**Level:** recommended
**Keywords:** metrics, ownership, observability, boundaries

### Rule
Emit operational metrics at stable ownership boundaries such as service operations, jobs, and external integration boundaries.

### Why
Metrics become more meaningful when they reflect durable business or operational boundaries rather than arbitrary implementation details.

### Applies when
- adding latency/error/success metrics
- instrumenting a new service or background job
- deciding where to count retries or failures

### Exceptions
- deeply local instrumentation that never leaves developer-facing debugging

### Good example
```ts
metrics.orderPlacementLatency.observe(durationMs)
```

### Bad example
```ts
metrics.helperFunctionStep3.observe(durationMs)
```

### Reviewer checklist
- Is the metric attached to a stable ownership boundary?
- Would operators understand what a spike here actually means?
