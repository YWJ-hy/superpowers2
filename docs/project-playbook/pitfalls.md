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
