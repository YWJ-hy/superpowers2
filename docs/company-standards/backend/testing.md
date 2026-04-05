# Backend Testing Standards

## BE-TEST-001 Prefer integration tests where persistence behavior matters

**Level:** required
**Keywords:** backend tests, integration tests, persistence, transport

### Rule
Prefer integration tests when the behavior under test depends on persistence, transactions, queries, transport wiring, or serialization.

### Why
Mock-heavy tests often hide the exact class of failures that occur at backend boundaries.

### Applies when
- database behavior affects correctness
- queues, jobs, or transports are part of the behavior
- serialization or schema behavior matters

### Exceptions
- pure computation or deterministic utility functions

### Good example
```ts
it('persists the order and emits the event', async () => {
  await placeOrder(input)
  expect(await db.orders.count()).toBe(1)
  expect(await testBus.lastEvent()).toMatchObject({ type: 'order.placed' })
})
```

### Bad example
```ts
it('calls repository.save once', async () => {
  expect(repository.save).toHaveBeenCalledTimes(1)
})
```

### Reviewer checklist
- Does the test exercise the real boundary that matters?
- Would a mocked test miss the failure mode here?

## BE-TEST-002 Do not over-mock persistence or transport edges

**Level:** recommended
**Keywords:** mocks, persistence, transport, brittleness

### Rule
Do not over-mock databases, queues, or transport edges when their real behavior is part of the contract being verified.

### Why
Over-mocking makes backend tests fast but untrustworthy in exactly the areas that tend to break under real load and data.

### Applies when
- a service spans repository and transport boundaries
- a test is asserting behavior that depends on serialization, transactions, or retries

### Exceptions
- targeted unit tests for pure decision logic that does not depend on boundary behavior

### Good example
```ts
await app.inject({ method: 'POST', url: '/orders', payload })
expect(await db.orders.count()).toBe(1)
```

### Bad example
```ts
mockRepo.save.mockResolvedValue(...)
mockPublisher.publish.mockResolvedValue(...)
```

### Reviewer checklist
- Are mocks hiding the boundary behavior we actually care about?
- Is the chosen test level honest about what it verifies?
