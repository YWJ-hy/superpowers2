---
name: compound-engineering
description: Use when you want to orchestrate a full brainstorm-to-plan-to-execution workflow and deliberately capture reusable lessons at the end
---

# Compound Engineering

Run the existing Superpowers workflow as one deliberate loop, then compound what was learned.

## Overview

This skill is a thin orchestration layer. It does not replace the existing workflow skills.

Use it to:
1. route into the right existing workflow stage
2. keep standards/project-note context explicit
3. finish with a `Compound Candidates` block that suggests what should be reused later

## Workflow

1. **Brainstorm** — use `superpowers:brainstorming` to define the design
2. **Plan** — use `superpowers:writing-plans` to create task packets with spec sections, standards, and project-note excerpts
3. **Execute** — prefer `superpowers:subagent-driven-development`; use `superpowers:dispatching-parallel-agents` only for truly independent research or review work
4. **Compound** — after implementation, produce a final lessons block

## Standards and Project Notes

Treat repo-local guidance as two separate corpora:
- **standards corpus** — organization-level rules, which may be domain-specific (for example frontend, backend, or shared)
- **project-notes corpus** — repo-specific pitfalls, patterns, and legacy constraints

In v1 these are repo-local by default. Keep your language generic enough that a future private overlay can replace those corpora without changing the workflow logic.

## Compound Step

At the end of the work, produce:

```md
## Compound Candidates

### Promote to Company Standards
- <lesson that should become a reusable organization-level rule>

### Add to Project Playbook
- <repo-specific pitfall, pattern, or constraint>

### Keep in Feature Spec / Plan Only
- <one-off lesson that should not be promoted>
```

Do **not** auto-edit the corpora as part of this step. Suggest the right destination, then let the human or a follow-up task decide whether to codify it.

## Red Flags

**Never:**
- replace `brainstorming`, `writing-plans`, or `subagent-driven-development` with ad hoc shortcuts
- dump the full standards corpus into every subagent prompt
- promote a repo-specific workaround into company standards without checking scope
- hide important guidance in memory when it belongs in repo docs

## Integration

**Routes into:**
- `superpowers:brainstorming`
- `superpowers:writing-plans`
- `superpowers:subagent-driven-development`
- `superpowers:dispatching-parallel-agents`

**Pairs well with:**
- `superpowers:requesting-code-review`
- `superpowers:finishing-a-development-branch`
