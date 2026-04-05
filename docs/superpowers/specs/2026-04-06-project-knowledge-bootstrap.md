# Project Knowledge Bootstrap Report

## Project Signals / Inventory

This repository is not using skills as standalone prose. It is building a layered workflow where long-lived knowledge must be explicitly separated into:
- `docs/company-standards/` for reusable organization-level rules
- `docs/project-playbook/` for repo-specific pitfalls, patterns, and legacy constraints
- `docs/superpowers/specs/` and `docs/superpowers/plans/` for feature-scoped design and execution

High-signal evidence inspected:
- `README.md:30-53` — company standards are long-lived, cross-project, and injected into workflow artifacts
- `README.md:54-69` — project playbook is explicitly repo-local and must not be promoted incorrectly
- `README.md:71-114` — brainstorming / writing-plans / subagent-driven-development / compound-engineering are designed around standards + project-note mapping
- `CLAUDE.md:11-19` — strong guardrails against low-quality, speculative, or duplicate contributions
- `.github/PULL_REQUEST_TEMPLATE.md:7-16` — contribution quality is problem-driven and evidence-backed
- `skills/subagent-driven-development/SKILL.md:215-224` — controller should provide curated task packets and only task-relevant excerpts
- `skills/compound-engineering/SKILL.md:26-32` and `skills/compound-engineering/SKILL.md:34-51` — end-of-work lessons must be classified into standards vs project playbook, not mixed
- `docs/project-playbook/patterns.md:3-41` and `docs/project-playbook/legacy-constraints.md:3-35` — existing project-note card shapes and level of specificity
- `docs/superpowers/specs/2026-04-05-progressive-disclosure-frontend-design.md:3-12` — current design already depends on explicit standards / project-note mapping and warns against promoting repo-local notes into company standards

## Candidate Company Standards

### Candidate 1
- **Proposed title:** `SH-ARCH-003 Keep long-lived engineering knowledge in explicit corpora with stable IDs`
- **Proposed ID family:** `SH-ARCH-*`
- **Destination corpus:** `docs/company-standards/shared/architecture.md`
- **Applies when:** designing workflow systems, writing reusable skills, building any process that needs durable guidance reused across specs, plans, task packets, or reviews
- **Evidence paths:**
  - `README.md:40-52`
  - `README.md:47-53`
  - `README.md:494-502`
  - `docs/company-standards/README.md:31-41`
- **Why this belongs here:** this is framed as a cross-project workflow rule, not a quirk of one repository. The repo repeatedly states that long-lived guidance should be codified with stable IDs and injected into downstream artifacts.
- **Draft card fields:**
  - **Rule:** Long-lived engineering guidance should live in explicit corpora with stable IDs so specs, plans, task packets, and review flows can cite the same source of truth.
  - **Why:** Reusable workflow knowledge loses force when it stays implicit, conversational, or hidden in one-off docs.
  - **Avoid / Do not do:** Do not keep durable rules only in feature docs or transient prompts.

### Candidate 2
- **Proposed title:** `SH-ARCH-004 Pass only task-relevant excerpts instead of full corpora`
- **Proposed ID family:** `SH-ARCH-*`
- **Destination corpus:** `docs/company-standards/shared/architecture.md`
- **Applies when:** dispatching subagents, building task packets, or designing multi-stage agent workflows with constrained context windows
- **Evidence paths:**
  - `README.md:92-99`
  - `README.md:494-499`
  - `skills/subagent-driven-development/SKILL.md:215-224`
  - `skills/compound-engineering/SKILL.md:28-32`
- **Why this belongs here:** this is a reusable workflow principle for any project using a standards/project-notes corpus split. It is not tied to a single app domain.
- **Draft card fields:**
  - **Rule:** Give implementers and reviewers only the excerpts needed for the current task instead of dumping the full standards corpus into every prompt.
  - **Why:** Curated excerpts reduce context pollution while keeping compliance explicit.
  - **Avoid / Do not do:** Do not make every subagent load the full corpus by default.

## Candidate Project Playbook Notes

### Candidate 1
- **Proposed title:** `PRJ-PAT-002 Route repo knowledge through standards → spec → plan → task packet → subagent prompt`
- **Proposed ID family:** `PRJ-PAT-*`
- **Destination corpus:** `docs/project-playbook/patterns.md`
- **Applies when:** extending this repository’s workflow, adding new skills, or deciding where reusable context should enter the agent loop
- **Evidence paths:**
  - `README.md:47-53`
  - `README.md:78-90`
  - `README.md:180-209`
  - `README.md:494-502`
- **Why this belongs here:** this chaining behavior is specific to this repository’s architecture and terminology. It is a proven local workflow pattern, not a universal company rule.
- **Draft card fields:**
  - **Recommended approach:** Put durable knowledge into standards/project playbook first, then reference it from specs, plans, and task packets instead of repeating it ad hoc in execution prompts.
  - **Avoid / Do not do:** Do not bypass the corpus layers by embedding long-lived repo guidance directly into one feature plan or one subagent prompt.

### Candidate 2
- **Proposed title:** `PRJ-PIT-003 Misclassifying repo-local notes as company standards weakens the corpus split`
- **Proposed ID family:** `PRJ-PIT-*`
- **Destination corpus:** `docs/project-playbook/pitfalls.md`
- **Applies when:** classifying new lessons, bootstrapping corpus content, or deciding whether a finding should be promoted beyond this repo
- **Evidence paths:**
  - `README.md:61-69`
  - `README.md:442-455`
  - `docs/project-playbook/README.md:7-18`
  - `docs/superpowers/specs/2026-04-05-progressive-disclosure-frontend-design.md:6-10`
- **Why this belongs here:** the mistake is specific to this repo’s explicit two-corpus model. It is a local classification trap that maintainers here care about.
- **Draft card fields:**
  - **Symptom / Problem:** Repo-specific lessons get promoted too early into long-lived shared standards.
  - **Recommended approach:** Keep repo-bound patterns, pitfalls, and legacy constraints in `docs/project-playbook/` unless the evidence clearly shows cross-project reuse.
  - **Avoid / Do not do:** Do not elevate local architecture quirks into company-wide rules without wider proof.

### Candidate 3
- **Proposed title:** `PRJ-LEG-002 This repo treats behavior-shaping skill wording as tuned code, not casual prose`
- **Proposed ID family:** `PRJ-LEG-*`
- **Destination corpus:** `docs/project-playbook/legacy-constraints.md`
- **Applies when:** editing existing skills, changing red-flag language, or rephrasing instructions that shape agent behavior
- **Evidence paths:**
  - `CLAUDE.md:35-38`
  - `CLAUDE.md:67-74`
  - `CLAUDE.md:76-78`
- **Why this belongs here:** this is a repository-specific constraint on how maintainers expect wording changes to be handled. It is not a universal engineering truth; it is part of this project’s local operating model.
- **Draft card fields:**
  - **Constraint:** Existing behavior-shaping skill language is treated as tuned workflow code and should not be casually rewritten.
  - **Why / History:** Maintainers explicitly warn that wording changes need evidence because the repo has a tested internal philosophy and a high rejection bar.
  - **Avoid / Do not do:** Do not rephrase core skill language for style or “compliance” reasons without evaluation evidence.

### Candidate 4
- **Proposed title:** `PRJ-PIT-004 Contribution-facing workflow changes in this repo require a real problem statement, evidence, and human review`
- **Proposed ID family:** `PRJ-PIT-*`
- **Destination corpus:** `docs/project-playbook/pitfalls.md`
- **Applies when:** proposing core workflow changes, skill changes, or PR-facing automation inside this repository
- **Evidence paths:**
  - `CLAUDE.md:11-19`
  - `CLAUDE.md:21-27`
  - `.github/PULL_REQUEST_TEMPLATE.md:7-16`
  - `.github/PULL_REQUEST_TEMPLATE.md:53-75`
- **Why this belongs here:** the underlying rigor principle may generalize, but the current wording and enforcement are tightly bound to this repository’s contributor workflow and rejection history, so it is safer as a repo-local playbook note.
- **Draft card fields:**
  - **Symptom / Problem:** workflow-facing changes get proposed without a concrete user failure, eval evidence, or human review.
  - **Recommended approach:** require a real motivating problem, explicit eval evidence, and human review before treating a workflow change as ready for submission.
  - **Avoid / Do not do:** do not justify workflow changes with speculative improvements alone.

## Needs Review / Rejected

### Needs Review 1
- **Candidate:** a shared standard about “always require a complete PR template”
- **Why not promoted yet:** strong evidence exists in this repo, but the current wording is tightly coupled to this project’s contributor workflow and should stay repo-local unless there is broader org-wide evidence.
- **Evidence paths:**
  - `.github/PULL_REQUEST_TEMPLATE.md:1-5`
  - `.github/PULL_REQUEST_TEMPLATE.md:74-86`

### Needs Review 2
- **Candidate:** a shared standard about “always use Claude Code headless tests for skill verification”
- **Why not promoted yet:** evidence is currently repo-local (`tests/claude-code/README.md`) and may describe this repository’s preferred harness rather than a portable company-wide rule.
- **Evidence paths:**
  - `tests/claude-code/README.md:1-18`
  - `tests/claude-code/README.md:82-108`

## Proposed Next Writes

If you approve these candidates, the next step should be:
1. add approved shared rules to `docs/company-standards/shared/index.md` and the appropriate shared corpus file(s)
2. add approved repo-local notes to `docs/project-playbook/index.md` plus `pitfalls.md` / `patterns.md` / `legacy-constraints.md`
3. keep anything uncertain in `Needs Review` until more cross-project evidence exists

## Confirmation Gate

This file is only a candidate report.

Do **not** treat these entries as adopted corpus content until we explicitly confirm which candidates should be written into `docs/company-standards/` and `docs/project-playbook/`.