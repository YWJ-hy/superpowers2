# Backend API Standards

## BE-API-001 Keep handlers thin; orchestration belongs in services

**Level:** required
**Keywords:** handlers, controllers, services, orchestration, transport boundary

### Rule
HTTP handlers, RPC handlers, and transport adapters should stay thin; business orchestration belongs in service-layer boundaries.

### Why
Thin handlers are easier to test, easier to change when transport changes, and less likely to mix parsing, policy, and business flow in one place.

### Applies when
- adding a new endpoint or handler
- refactoring a large controller
- deciding whether logic belongs in a transport layer or service layer

### Exceptions
- truly trivial passthrough endpoints with no meaningful orchestration

### Good example
```ts
export async function getOrderHandler(req, res) {
  const input = parseOrderRequest(req)
  const order = await orderService.getOrder(input)
  res.json(order)
}
```

### Bad example
```ts
export async function getOrderHandler(req, res) {
  const input = parseOrderRequest(req)
  const order = await db.orders.findOne(...)
  const permissions = await authz.check(...)
  const audit = await auditLogger.write(...)
  res.json(transform(order, permissions, audit))
}
```

### Reviewer checklist
- Is business orchestration in the service layer rather than the handler?
- Did the handler stay focused on boundary concerns?

## BE-API-002 Validate untrusted input at the boundary

**Level:** required
**Keywords:** validation, boundary, API input, untrusted input, parsing

### Rule
Validate and normalize untrusted input at the system boundary before it enters internal business logic.

### Why
Boundary validation prevents malformed or hostile input from leaking into internal assumptions.

### Applies when
- handling request bodies, query params, headers, or external event payloads
- exposing new public or internal APIs

### Exceptions
- trusted internal callers with an already-validated typed contract, when that contract is the actual boundary

### Good example
```ts
const input = orderQuerySchema.parse(req.query)
return orderService.searchOrders(input)
```

### Bad example
```ts
return orderService.searchOrders(req.query)
```

### Reviewer checklist
- Is untrusted input validated at the boundary?
- Did normalization happen before internal logic used the values?

## BE-API-003 Evolve API responses compatibly

**Level:** recommended
**Keywords:** compatibility, response contract, versioning, API evolution

### Rule
When changing an API response contract, prefer additive or explicitly versioned evolution over silent breaking changes.

### Why
Response compatibility reduces surprise for callers and makes rollout safer.

### Applies when
- modifying existing API fields
- renaming response properties
- changing nullability or semantics

### Exceptions
- private endpoints with one tightly controlled caller and a coordinated migration window

### Good example
```ts
return {
  id: order.id,
  status: order.status,
  displayStatus: mapDisplayStatus(order.status),
}
```

### Bad example
```ts
return {
  id: order.id,
  state: order.status, // silently renamed from status
}
```

### Reviewer checklist
- Is the response change additive or explicitly coordinated?
- Would existing callers break unexpectedly?
