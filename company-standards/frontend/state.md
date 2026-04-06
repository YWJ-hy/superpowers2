# State Standards

## FE-STATE-001 Keep state at the narrowest useful boundary

**Level:** required
**Keywords:** state ownership, local state, global state, lifting state

### Rule
Keep state at the narrowest boundary that actually needs to own it; do not lift or globalize state early.

### Why
Over-shared state increases coupling and makes flows harder to understand and test.

### Applies when
- deciding whether to lift state
- considering global store extraction
- refactoring repeated state flows

### Exceptions
- genuinely shared cross-feature state with multiple true consumers
- state that must survive navigation or be coordinated across distant boundaries

### Good example
```tsx
function FilterPanel() {
  const [query, setQuery] = useState('')
  // local state stays local
}
```

### Bad example
```tsx
const useGlobalFiltersStore = create(() => ({ query: '', sort: 'newest' }))
// introduced before multiple consumers actually exist
```

### Reviewer checklist
- Is the chosen owner the narrowest useful boundary?
- Was state lifted or globalized without real need?
