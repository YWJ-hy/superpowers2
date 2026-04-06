# Testing Standards

## FE-TEST-001 Prefer user-visible behavior assertions

**Level:** required
**Keywords:** behavior testing, user-visible, assertions, outcomes

### Rule
Prefer assertions about user-visible behavior and externally observable outcomes over assertions about internal implementation.

### Why
Behavior-level tests survive refactors better and catch the thing users actually experience.

### Applies when
- writing component tests
- testing hooks through consuming UI or exposed behavior
- choosing between DOM/output assertions and internals

### Exceptions
- low-level utility tests where internals are the public contract

### Good example
```tsx
expect(screen.getByText('Retry')).toBeInTheDocument()
```

### Bad example
```tsx
expect(wrapper.instance().state.loading).toBe(true)
```

### Reviewer checklist
- Do tests verify what a user or caller can observe?
- Are assertions resilient to internal refactors?

## FE-TEST-002 Avoid coupling tests to internal implementation details

**Level:** required
**Keywords:** test brittleness, internals, implementation details

### Rule
Do not couple tests to internal state shape, private helpers, or temporary render structure unless that structure is the public contract.

### Why
Implementation-coupled tests block safe refactors and often miss real regressions.

### Applies when
- adding selectors or assertions
- testing hooks/components after refactors
- deciding whether to mock internals

### Exceptions
- public low-level APIs whose explicit contract is structural

### Good example
```tsx
await waitFor(() => expect(screen.getByText('3 results')).toBeInTheDocument())
```

### Bad example
```tsx
expect(useOrdersPollingMock).toHaveBeenCalledTimes(1)
expect(component.find('.internal-spinner')).toHaveLength(1)
```

### Reviewer checklist
- Are tests tied to internals or to behavior?
- Would a safe refactor break these tests for the wrong reasons?
