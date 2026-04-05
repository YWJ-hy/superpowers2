# Progressive Disclosure Frontend Workflow Design

## S1 Problem / Intended Outcome
This fork needs a way to reuse long-lived frontend standards and repo-specific lessons without flooding every agent prompt with the entire corpus. The intended outcome is a workflow where humans review layered design sections and subagents receive only task-relevant excerpts.

## S2 Non-goals / Boundaries
- Do not introduce hidden memory as the source of truth
- Do not import external workflow stacks wholesale
- Do not make repo-specific project notes part of company-wide frontend standards

## S3 User Workflow
A user starts with a feature idea. `brainstorming` turns it into a layered spec, then maps applicable standards and project notes. `writing-plans` turns that design into task packets. `subagent-driven-development` gives each task only the relevant excerpts.

## S4 Architecture / Moving Parts
- standards corpus: `docs/company-standards/frontend/`
- project-notes corpus: `docs/project-playbook/`
- feature specs: `docs/superpowers/specs/`
- implementation plans: `docs/superpowers/plans/`
- orchestration skill: `skills/compound-engineering/SKILL.md`

## S5 File and Interface Impact
- `skills/brainstorming/SKILL.md`
- `skills/writing-plans/SKILL.md`
- `skills/subagent-driven-development/*`
- `docs/company-standards/frontend/*`
- `docs/project-playbook/*`

## S6 Applicable Standards

### Required
- `FE-COMP-001` Single responsibility boundary
- `FE-TEST-001` Prefer user-visible behavior assertions

### Recommended
- `FE-HOOK-003` Reusable async workflow belongs in hooks when stateful or repeated

### Not applied
- `FE-STATE-001` Keep state at the narrowest useful boundary — not a major design pressure for this documentation-only workflow

## S7 Applicable Project Notes
- `PRJ-PAT-001` Put stale-response guards at the data boundary, not in page-level patch logic
- `PRJ-LEG-001` Legacy table components require stable column identity

## S8 Risks / Open Questions
- Tests that rely on exact phrasing may become brittle as skill wording evolves
- A future private overlay needs path assumptions to stay concentrated and easy to swap

## S9 Verification
- Run fast Claude Code skill tests
- Verify the compound-engineering skill is discoverable
- Inspect task packets to ensure only relevant excerpts are included
