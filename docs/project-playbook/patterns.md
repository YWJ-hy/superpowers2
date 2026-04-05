# Project Patterns

## PRJ-PAT-001 Put stale-response guards at the data boundary, not in page-level patch logic

**Type:** pattern
**Status:** active
**Last validated:** 2026-04-05
**Keywords:** stale response, data boundary, request ownership, polling

### Applies when
- network responses can overlap
- the same data flow is consumed by more than one UI branch
- pages already contain local timing patches

### Symptom / Problem
When stale-response handling lives in page code, every page invents a different patch and bugs keep reappearing.

### Recommended approach
Centralize stale-response protection where requests are issued or normalized, then expose a clean state/action API upward.

### Avoid / Do not do
- do not spread stale-response guards across many UI handlers
- do not duplicate timing patches per screen

### Why / History
Local patches reduce one symptom at a time but do not give the project a reliable concurrency boundary.

### Example
```ts
async function reload() {
  const token = Symbol('reload')
  latestReload.current = token
  const result = await loadOrders()
  if (latestReload.current !== token) return
  setOrders(result)
}
```

### Reviewer checklist
- Did the guard live at the request/data boundary?
- Is the page consuming a clean API instead of carrying the concurrency logic itself?
