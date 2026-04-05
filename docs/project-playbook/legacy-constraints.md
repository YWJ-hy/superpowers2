# Legacy Constraints

## PRJ-LEG-001 Legacy table components require stable column identity

**Type:** constraint
**Status:** active
**Last validated:** 2026-04-05
**Keywords:** legacy table, column identity, memoization, selection state

### Applies when
- using the legacy table stack
- generating columns dynamically
- selection or sort state is held by the table instance

### Symptom / Problem
Recreating column arrays on every render can reset selection or sorting behavior in the legacy table components.

### Recommended approach
Keep column identity stable with memoization or extraction, and avoid rebuilding equivalent column definitions every render.

### Avoid / Do not do
- do not inline unstable column arrays in render when using the legacy table
- do not mix unrelated UI state into the column-definition construction path

### Why / History
This legacy table stack assumes stable identity more strongly than newer table abstractions.

### Example
```tsx
const columns = useMemo(() => buildOrderColumns(onRetry), [onRetry])
```

### Reviewer checklist
- Are column definitions stable across equivalent renders?
- Did the change accidentally couple columns to unrelated page state?
