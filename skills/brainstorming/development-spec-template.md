# Layered Development Spec Template

Use this template when a feature needs progressive disclosure and explicit mapping to standards and repo-local project notes.

## S1 Problem / Intended Outcome
- What user or engineering problem is being solved?
- What does success look like?

## S2 Non-goals / Boundaries
- What is explicitly out of scope?
- What tempting adjacent work should not be included?

## S3 User Workflow
- What flow changes for the user or operator?
- What states and transitions matter?

## S4 Architecture / Moving Parts
- What components, hooks, modules, or services are involved?
- What boundaries should remain clear?

## S5 File and Interface Impact
- Which files or directories are likely to change?
- Which interfaces, props, hook APIs, or contracts are likely to change?

## S6 Applicable Standards

Use stable rule IDs that point to cards in the standards corpus. The spec contract is the ID plus summary, not a filename, and one file may contain multiple rule cards.

### Required
- `<rule-id>` <one-line summary>

### Recommended
- `<rule-id>` <one-line summary>

### Not applied
- `<rule-id>` <reason it does not apply>

## S7 Applicable Project Notes

Use stable note IDs that point to repo-local note cards. Keep filenames out of the contract here too.
- `<note-id>` <one-line summary>

## S8 Risks / Open Questions
- What could go wrong?
- What should be clarified before implementation?

## S9 Verification
- How should the implementation be verified end-to-end?
- Which tests or manual checks matter?
