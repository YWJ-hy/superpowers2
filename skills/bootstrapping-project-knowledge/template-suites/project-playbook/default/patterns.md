# Project Patterns

## PRJ-PAT-001 Put stale-response guards at the data boundary, not in page-level patch logic

**Type:** pattern
**Status:** active
**Last validated:** 2026-04-05
**Keywords:** stale response, data boundary, request ownership, polling

### Applies when
- network responses can overlap
- the same data flow is consumed by more than one UI branch
- pages already contain local timing patches

### Symptom / Problem
When stale-response handling lives in page code, every page invents a different patch and bugs keep reappearing.

### Recommended approach
Centralize stale-response protection where requests are issued or normalized, then expose a clean state/action API upward.

### Avoid / Do not do
- do not spread stale-response guards across many UI handlers
- do not duplicate timing patches per screen

### Why / History
Local patches reduce one symptom at a time but do not give the project a reliable concurrency boundary.

### Example
```ts
async function reload() {
  const token = Symbol('reload')
  latestReload.current = token
  const result = await loadOrders()
  if (latestReload.current !== token) return
  setOrders(result)
}
```

### Reviewer checklist
- Did the guard live at the request/data boundary?
- Is the page consuming a clean API instead of carrying the concurrency logic itself?

## PRJ-PAT-002 Route repo knowledge through standards → spec → plan → task packet → subagent prompt

**Type:** pattern
**Status:** active
**Last validated:** 2026-04-06
**Keywords:** workflow, standards, specs, plans, task packets, prompt context

### Applies when
- extending this repository’s workflow
- adding new skills
- deciding where durable repo knowledge should enter the agent loop

### Symptom / Problem
When durable guidance is embedded ad hoc in one prompt or one feature doc, later tasks drift because the same rule is not cited consistently across the workflow.

### Recommended approach
Put durable knowledge into `company-standards` or `project-playbook` first, then reference it from specs, plans, task packets, and subagent prompts instead of re-explaining it each time.

### Avoid / Do not do
- do not hide long-lived repo guidance only inside one feature spec
- do not embed workflow rules directly into one execution prompt when they need to be cited repeatedly

### Why / History
This repository’s workflow is designed so long-lived knowledge flows through explicit layers rather than being recopied ad hoc in every implementation session.

### Example
```md
Applicable Project Notes
- PRJ-PAT-002 Route repo knowledge through standards → spec → plan → task packet → subagent prompt
```

### Reviewer checklist
- Did the change place durable knowledge in the right corpus layer first?
- Can later specs and plans reference the same note without restating it manually?
