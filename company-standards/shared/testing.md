# Shared Testing Standards

## SH-TEST-001 Prefer externally observable behavior assertions

**Level:** required
**Keywords:** testing, behavior, observable outcomes, assertions

### Rule
Prefer assertions about externally observable behavior over assertions about internal implementation details.

### Why
Behavior-focused tests are more resilient to refactors and more honest about what users or callers actually depend on.

### Applies when
- testing UI behavior
- testing API responses
- testing service outcomes
- deciding between black-box and white-box assertions

### Exceptions
- low-level utilities where the internal structure is itself the public contract

### Good example
```ts
expect(response.status).toBe(200)
expect(screen.getByText('Saved')).toBeInTheDocument()
```

### Bad example
```ts
expect(component.state.loading).toBe(false)
expect(service.internalSteps).toEqual([...])
```

### Reviewer checklist
- Does the test assert a caller-visible or user-visible outcome?
- Would an internal refactor break the test for the wrong reason?

## SH-TEST-002 Do not overspecify implementation details in tests

**Level:** required
**Keywords:** tests, brittleness, internals, overspecification

### Rule
Do not overspecify temporary implementation details in tests unless those details are part of the contract that consumers truly rely on.

### Why
Overspecified tests create churn and discourage healthy refactoring.

### Applies when
- snapshotting large internal structures
- asserting exact intermediate steps
- verifying private call sequences instead of end behavior

### Exceptions
- intentionally testing a stable contract whose structure is the thing being promised

### Good example
```ts
expect(result).toEqual({ status: 'ok' })
```

### Bad example
```ts
expect(logger.info).toHaveBeenNthCalledWith(3, 'step 3 complete')
```

### Reviewer checklist
- Is this test overspecifying internals?
- Is the asserted detail truly part of the contract?
