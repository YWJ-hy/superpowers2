# Hook Standards

## FE-HOOK-001 Hooks expose state and actions, not page structure

**Level:** required
**Keywords:** hooks, composables, state, actions, ownership

### Rule
Hooks should expose state, derived values, and actions; they should not encode page structure, layout decisions, or presentation-specific wiring.

### Why
This keeps hooks reusable and prevents UI structure from leaking into logic boundaries.

### Applies when
- extracting reusable logic from a page or feature
- introducing a new async or derived-state hook
- deciding whether something belongs in a hook or in the component tree

### Exceptions
- tiny view-local hooks that exist purely to tidy local component code

### Good example
```tsx
const { orders, loading, reload } = useOrdersPolling()
```

### Bad example
```tsx
const { pageTitle, activeTab, leftRailItems } = useOrdersPage()
```

### Reviewer checklist
- Does the hook return state/actions rather than page structure?
- Did the hook avoid hard-coding presentation choices?

## FE-HOOK-002 Effects should live where ownership is clear

**Level:** required
**Keywords:** effects, ownership, side effects, lifecycle

### Rule
Place side effects at the narrowest boundary that clearly owns them.

### Why
Clear ownership reduces duplicated effect logic, hidden coupling, and cleanup bugs.

### Applies when
- introducing fetch, polling, subscription, or persistence effects
- moving logic between component and hook boundaries
- refactoring repeated effect logic

### Exceptions
- extremely local effects that do not justify extraction

### Good example
```tsx
function useOrdersPolling() {
  useEffect(() => {
    const id = setInterval(reload, 5000)
    return () => clearInterval(id)
  }, [reload])
}
```

### Bad example
```tsx
function OrdersPage() {
  useEffect(() => startPolling(), [])
  useEffect(() => syncPollingState(), [tab])
  useEffect(() => resetPollingHack(), [filter])
}
```

### Reviewer checklist
- Is there one clear owner for the effect?
- Did the change reduce scattered side-effect logic?
- Is cleanup tied to the same owner that started the effect?

## FE-HOOK-003 Reusable async workflow belongs in hooks when stateful or repeated

**Level:** recommended
**Keywords:** async, hooks, polling, retry, loading, reuse

### Rule
When an async workflow is reused or maintains meaningful state, prefer putting it in a hook that exposes state and actions.

### Why
This keeps async lifecycle concerns coherent and easier to test.

### Applies when
- loading/error/retry state must be managed
- a workflow will be reused across screens or branches of UI
- polling, pagination, mutation state, or retry logic is involved

### Exceptions
- single-use async flows inside a tiny local component
- extraction would create a worse API than the inline logic it replaces

### Good example
```tsx
function useUserData() {
  const [data, setData] = useState(null)
  const [loading, setLoading] = useState(false)
  const reload = async () => { /* ... */ }
  return { data, loading, reload }
}
```

### Bad example
```tsx
function UserPage() {
  const [data, setData] = useState(null)
  const [loading, setLoading] = useState(false)
  const [retryCount, setRetryCount] = useState(0)
  // repeated async workflow embedded in the page
}
```

### Reviewer checklist
- Should this async lifecycle live behind a hook boundary?
- Does the hook expose a clean state/action API?
- Did the change avoid coupling async workflow to presentation structure?
