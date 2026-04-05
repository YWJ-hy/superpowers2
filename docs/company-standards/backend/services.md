# Backend Service Standards

## BE-SVC-001 Service boundaries reflect business capability

**Level:** required
**Keywords:** services, business capability, boundaries, ownership

### Rule
Service boundaries should reflect business capability and ownership, not just technical layers or database tables.

### Why
Capability-aligned services stay understandable as the system grows and reduce accidental coupling.

### Applies when
- creating a new service
- splitting a large module
- deciding whether logic belongs in one service or several

### Exceptions
- small codebases where introducing multiple services would add unnecessary ceremony

### Good example
```ts
orderService.placeOrder(input)
paymentService.capturePayment(input)
```

### Bad example
```ts
orderRowService.updateOrderRow(...)
orderMetadataService.updateOrderMetadata(...)
```

### Reviewer checklist
- Does the service boundary map to a business capability?
- Is the split driven by ownership rather than storage layout?

## BE-SVC-002 Keep orchestration out of transport adapters

**Level:** recommended
**Keywords:** orchestration, handlers, adapters, services, boundaries

### Rule
Cross-step business orchestration should live in service code, not in HTTP handlers, queue consumers, or transport adapters.

### Why
Transport adapters change more often and should stay focused on I/O translation and dispatch.

### Applies when
- a workflow spans multiple actions or dependencies
- handlers start branching through business rules
- queue consumers begin duplicating orchestration logic

### Exceptions
- very small adapters that only dispatch a single service call

### Good example
```ts
await orderFulfillmentService.run(input)
```

### Bad example
```ts
if (req.body.retry) { ... }
if (inventoryMissing) { ... }
if (paymentFailed) { ... }
```

### Reviewer checklist
- Is orchestration centralized in a service boundary?
- Did the adapter stay focused on boundary work?
