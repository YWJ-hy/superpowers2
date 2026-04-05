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

## PRJ-LEG-002 This repo treats behavior-shaping skill wording as tuned code, not casual prose

**Type:** constraint
**Status:** active
**Last validated:** 2026-04-06
**Keywords:** skills, wording, behavior shaping, evaluation, repository philosophy

### Applies when
- editing existing skills
- changing red-flag language or rationalization counters
- rephrasing instructions that shape agent behavior

### Symptom / Problem
A wording-only edit can look harmless while still changing agent behavior in ways the maintainers consider regressions.

### Recommended approach
Treat behavior-shaping skill language as tuned workflow code. Change it only with evaluation evidence and a clear reason grounded in this repo’s workflow philosophy.

### Avoid / Do not do
- do not rewrite core skill wording for style alone
- do not make “compliance” edits to behavior-shaping content without evidence

### Why / History
This repository explicitly warns that its skill language has been tuned through testing and should not be casually rewritten as if it were ordinary prose.

### Example
```md
Do not change Red Flags wording unless eval evidence shows the new wording improves outcomes.
```

### Reviewer checklist
- Does the wording change have evaluation evidence behind it?
- Is the edit grounded in the repo’s existing workflow philosophy instead of style preference alone?
