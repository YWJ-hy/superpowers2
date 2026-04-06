# Backend Data Access Standards

## BE-DATA-001 Keep query ownership explicit

**Level:** required
**Keywords:** queries, repositories, ownership, data access

### Rule
Keep ownership of queries and data-access patterns explicit so callers know which boundary is responsible for reading or mutating each kind of data.

### Why
Explicit ownership reduces duplicate query logic and hidden coupling across modules.

### Applies when
- adding new repository/query helpers
- refactoring repeated data-access code
- deciding where a join or lookup should live

### Exceptions
- small utilities that are purely local and not reused outside one boundary

### Good example
```ts
const order = await orderRepository.findById(id)
```

### Bad example
```ts
const order = await db.orders.findOne(...)
const payments = await db.payments.find(...)
const user = await db.users.findOne(...)
```

### Reviewer checklist
- Is it clear which boundary owns the query?
- Did this change reduce or increase duplicated data-access logic?

## BE-DATA-002 Avoid hidden cross-repository transaction coupling

**Level:** recommended
**Keywords:** transactions, repositories, coupling, data consistency

### Rule
Do not create hidden cross-repository transaction coupling that only works because multiple boundaries happen to share one transaction context implicitly.

### Why
Hidden transaction coupling makes failures hard to reason about and increases the risk of partial consistency bugs.

### Applies when
- multiple repositories participate in one write path
- a service introduces transaction handling
- data consistency spans several aggregates or modules

### Exceptions
- intentionally coordinated transaction boundaries with explicit ownership and documentation

### Good example
```ts
await orderUnitOfWork.run(async (tx) => {
  await orderRepository.save(tx, order)
  await paymentRepository.save(tx, payment)
})
```

### Bad example
```ts
await orderRepository.save(order)
await paymentRepository.save(payment)
// both assume ambient transaction state exists somewhere else
```

### Reviewer checklist
- Is the transaction boundary explicit?
- Does the code rely on ambient or hidden coupling between repositories?
