# Component Standards

## FE-COMP-001 Single responsibility boundary

**Level:** required
**Keywords:** component boundaries, separation of concerns, ownership

### Rule
A component should not simultaneously own data fetching, business orchestration, and leaf rendering unless the scope is genuinely tiny.

### Why
Clear ownership boundaries keep components easier to understand, test, and evolve.

### Applies when
- a component is growing quickly
- one file handles requests, transformations, and rendering
- unrelated UI states are accumulating in the same component

### Exceptions
- very small one-off UI wrappers
- local glue components where extraction would add indirection without clarity

### Good example
```tsx
function UserListPage() {
  const { users, loading, reload } = useUsers()
  return <UserListView users={users} loading={loading} onReload={reload} />
}
```

### Bad example
```tsx
function UserListPage() {
  const [users, setUsers] = useState([])
  const [loading, setLoading] = useState(false)
  const columns = [...]
  const pageTitle = 'Users'
  // request + orchestration + rendering all mixed together
}
```

### Reviewer checklist
- Does the component own multiple unrelated responsibilities?
- Could request/orchestration move behind a clearer boundary?
- Did this change make ownership clearer, not blurrier?

## FE-COMP-002 Split container and presentation when ownership is mixed

**Level:** recommended
**Keywords:** container, presentation, decomposition, UI boundary

### Rule
When a component mixes data or state orchestration with substantial rendering logic, prefer splitting a container component from a presentational component.

### Why
This preserves a clear interface between behavior and rendering without forcing every small component into two files.

### Applies when
- one component has both data orchestration and heavy markup
- multiple render states share the same orchestration logic
- the same presentation may be reused under different data sources

### Exceptions
- minimal render trees where the split would create more ceremony than value

### Good example
```tsx
function OrdersPage() {
  const orderState = useOrdersPageState()
  return <OrdersView {...orderState} />
}
```

### Bad example
```tsx
function OrdersPage() {
  // fetching, filtering, tabs, table rendering, empty state, modal wiring
}
```

### Reviewer checklist
- Is the render tree substantial enough to justify a split?
- Does the split improve ownership clarity rather than create churn?

## FE-COMP-003 Props should reflect intent, not implementation details

**Level:** required
**Keywords:** props, API design, intent, interface

### Rule
Component props should describe caller intent and domain meaning rather than leaking internal layout or implementation mechanics.

### Why
Intent-driven props are easier to reuse and less brittle when internals change.

### Applies when
- designing reusable leaf components
- extending an existing component API
- deciding whether to pass raw low-level flags or domain-friendly values

### Exceptions
- thin wrappers over platform primitives may expose a mostly pass-through API

### Good example
```tsx
<Banner tone="warning" dismissible />
```

### Bad example
```tsx
<Banner isYellow hasCloseButton withLeftBorder />
```

### Reviewer checklist
- Do prop names express business/UI intent?
- Did this change add low-level flags that should be abstracted?

## FE-COMP-004 Prefer composition over boolean-flag explosion

**Level:** recommended
**Keywords:** composition, variants, flags, API sprawl

### Rule
Prefer composition, dedicated wrappers, or variant objects over accumulating many boolean flags on a single component.

### Why
Boolean-flag explosion creates hard-to-predict combinations and unclear ownership of behavior.

### Applies when
- a component has many boolean props
- prop combinations are growing faster than component clarity
- callers are forced to memorize invalid prop mixes

### Exceptions
- one or two truly independent flags are often fine

### Good example
```tsx
<Card>
  <CardHeader />
  <CardBody />
</Card>
```

### Bad example
```tsx
<Card compact bordered highlighted interactive elevated sticky />
```

### Reviewer checklist
- Are new flags truly independent?
- Would composition or a higher-level wrapper be clearer?
