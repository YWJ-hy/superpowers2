# Project Playbook Index

## Pitfalls
- `PRJ-PIT-001` Polling requests can race with tab or filter switching
- `PRJ-PIT-002` Ad hoc loading booleans often hide request ownership bugs
- `PRJ-PIT-003` Misclassifying repo-local notes as company standards weakens the corpus split
- `PRJ-PIT-004` Contribution-facing workflow changes in this repo require a real problem statement, evidence, and human review

## Patterns
- `PRJ-PAT-001` Put stale-response guards at the data boundary, not in page-level patch logic
- `PRJ-PAT-002` Route repo knowledge through standards → spec → plan → task packet → subagent prompt

## Legacy Constraints
- `PRJ-LEG-001` Legacy table components require stable column identity
- `PRJ-LEG-002` This repo treats behavior-shaping skill wording as tuned code, not casual prose
