# Backend Standards Index

## API
- `BE-API-001` Keep handlers thin; orchestration belongs in services
- `BE-API-002` Validate untrusted input at the boundary
- `BE-API-003` Evolve API responses compatibly

## Services
- `BE-SVC-001` Service boundaries reflect business capability
- `BE-SVC-002` Keep orchestration out of transport adapters

## Data Access
- `BE-DATA-001` Keep query ownership explicit
- `BE-DATA-002` Avoid hidden cross-repository transaction coupling

## Testing
- `BE-TEST-001` Prefer integration tests where persistence behavior matters
- `BE-TEST-002` Do not over-mock persistence or transport edges

## Observability
- `BE-OBS-001` Log with request/job identity
- `BE-OBS-002` Emit metrics at stable ownership boundaries
