# Progressive Disclosure Frontend Workflow Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add repo-local standards/project-note corpora and thread them through brainstorming, planning, and execution using compact task packets.

**Architecture:** Keep company-wide standards and repo-local project notes separate, then map both into feature specs and task packets. Subagents receive only relevant excerpts instead of the full corpora.

**Tech Stack:** Markdown skill files, repository docs, shell-based Claude Code tests

---

## File Structure

| File | Responsibility | Action |
|---|---|---|
| `docs/company-standards/frontend/*` | Organization-level frontend standards corpus | Create |
| `docs/project-playbook/*` | Repo-specific project notes corpus | Create |
| `skills/brainstorming/SKILL.md` | Layered spec generation and standards/project-note mapping | Modify |
| `skills/writing-plans/SKILL.md` | Task packet generation | Modify |
| `skills/subagent-driven-development/*` | Execution payloads and review prompts | Modify |
| `skills/compound-engineering/SKILL.md` | Workflow orchestration + compounding | Create |

---

### Task 1: Add standards and project-note corpora

**Files:**
- Create: `docs/company-standards/frontend/README.md`
- Create: `docs/company-standards/frontend/index.md`
- Create: `docs/company-standards/frontend/components.md`
- Create: `docs/company-standards/frontend/hooks.md`
- Create: `docs/project-playbook/README.md`
- Create: `docs/project-playbook/index.md`
- Create: `docs/project-playbook/pitfalls.md`

**Goal:**
Seed the repo-local corpora needed for progressive disclosure.

**Spec Sections:**
- `S1`, `S4`, `S6`, `S7`, `S9`

**Applicable Standards:**
- `FE-COMP-001`
- `FE-TEST-001`

**Standards Excerpts:**
- `FE-COMP-001`: A component should not simultaneously own data fetching, business orchestration, and leaf rendering unless the scope is genuinely tiny.
- `FE-TEST-001`: Prefer assertions about user-visible behavior and externally observable outcomes over assertions about internal implementation.

**Applicable Project Notes:**
- `PRJ-PAT-001`

**Project Note Excerpts:**
- `PRJ-PAT-001`: Put stale-response guards at the data boundary, not in page-level patch logic.

**Constraints / Non-goals:**
- Do not mix repo-specific notes into the standards corpus
- Do not create a hidden-memory dependency

**Acceptance Checks:**
- Standards and project notes have stable IDs
- The two corpora have separate README/index files

- [ ] **Step 1: Write the corpus docs**
- [ ] **Step 2: Verify IDs and separation are clear**
- [ ] **Step 3: Commit**

---

### Task 2: Update workflow skills to emit and consume task packets

**Files:**
- Modify: `skills/brainstorming/SKILL.md`
- Modify: `skills/writing-plans/SKILL.md`
- Modify: `skills/subagent-driven-development/SKILL.md`
- Modify: `skills/subagent-driven-development/implementer-prompt.md`
- Modify: `skills/subagent-driven-development/spec-reviewer-prompt.md`
- Modify: `skills/subagent-driven-development/code-quality-reviewer-prompt.md`

**Goal:**
Thread standards/project-note mappings from design through execution.

**Spec Sections:**
- `S3`, `S4`, `S5`, `S6`, `S9`

**Applicable Standards:**
- `FE-HOOK-003`
- `FE-TEST-002`

**Standards Excerpts:**
- `FE-HOOK-003`: When an async workflow is reused or maintains meaningful state, prefer putting it in a hook that exposes state and actions.
- `FE-TEST-002`: Do not couple tests to internal state shape, private helpers, or temporary render structure unless that structure is the public contract.

**Applicable Project Notes:**
- `PRJ-PIT-002`
- `PRJ-LEG-001`

**Project Note Excerpts:**
- `PRJ-PIT-002`: Ad hoc loading booleans often hide request ownership bugs.
- `PRJ-LEG-001`: Legacy table components require stable column identity.

**Constraints / Non-goals:**
- Do not give subagents the full corpora by default
- Do not change review ordering

**Acceptance Checks:**
- brainstorming persists `Applicable Standards` and `Applicable Project Notes`
- writing-plans documents task packets
- execution prompts mention standards/project-note excerpts explicitly

- [ ] **Step 1: Update brainstorming**
- [ ] **Step 2: Update writing-plans**
- [ ] **Step 3: Update execution prompts**
- [ ] **Step 4: Commit**

---

### Task 3: Add orchestration and regression tests

**Files:**
- Create: `skills/compound-engineering/SKILL.md`
- Modify: `README.md`
- Modify: `docs/testing.md`
- Modify: `tests/claude-code/run-skill-tests.sh`
- Create: `tests/claude-code/test-compound-engineering.sh`

**Goal:**
Make the new workflow discoverable and tested.

**Spec Sections:**
- `S3`, `S4`, `S8`, `S9`

**Applicable Standards:**
- `FE-TEST-001`
- `FE-TEST-002`

**Standards Excerpts:**
- `FE-TEST-001`: Prefer assertions about user-visible behavior and externally observable outcomes over assertions about internal implementation.
- `FE-TEST-002`: Avoid coupling tests to internal implementation details.

**Applicable Project Notes:**
- `PRJ-PAT-001`

**Project Note Excerpts:**
- `PRJ-PAT-001`: Centralize reusable guard logic at the owning boundary rather than duplicating patches.

**Constraints / Non-goals:**
- Keep the new skill small and orchestration-focused
- Avoid brittle phrase-specific tests where structure-based checks are enough

**Acceptance Checks:**
- `compound-engineering` is loadable
- fast test suite includes the new test
- docs mention the progressive-disclosure workflow

- [ ] **Step 1: Add compound-engineering skill**
- [ ] **Step 2: Update docs and test runner**
- [ ] **Step 3: Run fast tests**
- [ ] **Step 4: Commit**
