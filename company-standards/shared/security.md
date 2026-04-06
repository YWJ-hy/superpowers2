# Shared Security Standards

## SH-SEC-001 Validate untrusted input at system boundaries

**Level:** required
**Keywords:** security, validation, boundaries, untrusted input

### Rule
Validate untrusted input at the system boundary before it enters trusted internal flows.

### Why
Security controls are most reliable when enforced at the first trusted boundary rather than scattered across internals.

### Applies when
- receiving HTTP input
- parsing queue messages
- consuming webhook or external service payloads
- handling user-provided data in client or server code

### Exceptions
- none for truly untrusted input; trusted typed internal calls may already have a validated boundary upstream

### Good example
```ts
const payload = schema.parse(req.body)
```

### Bad example
```ts
service.process(req.body)
```

### Reviewer checklist
- Is validation at the true system boundary?
- Could malformed input reach trusted logic before validation?

## SH-SEC-002 Keep secrets and sensitive config out of implementation logic

**Level:** required
**Keywords:** secrets, config, security, credentials

### Rule
Do not embed secrets or sensitive operational configuration directly in implementation logic.

### Why
Secrets leak easily when treated as code constants, and operational configuration belongs in controlled configuration boundaries.

### Applies when
- wiring credentials
- configuring third-party services
- handling tokens, API keys, or secrets

### Exceptions
- test-only fake values that are clearly non-production and isolated from real credentials

### Good example
```ts
const apiKey = env.EXTERNAL_API_KEY
```

### Bad example
```ts
const apiKey = 'prod-secret-key'
```

### Reviewer checklist
- Are secrets/config sourced from controlled config boundaries?
- Did the change avoid embedding sensitive values in code?
