#!/usr/bin/env bash
# Test: compound-engineering skill
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

echo "=== Test: compound-engineering skill ==="
echo ""

echo "Test 1: Skill loading..."
output=$(run_claude "What is the compound-engineering skill? Describe its workflow briefly." 90)
assert_contains "$output" "compound-engineering\|Compound Engineering" "Skill is recognized" || exit 1
assert_contains "$output" "brainstorming\|writing-plans\|subagent-driven-development" "Mentions existing workflow routing" || exit 1

echo ""
echo "Test 2: Compound step..."
output=$(run_claude "In the compound-engineering skill, what should be produced at the end of the workflow?" 90)
assert_contains "$output" "Compound Candidates\|Promote to Company Standards\|Project Playbook" "Mentions compound candidates output" || exit 1

echo ""
echo "Test 3: Corpus separation..."
output=$(run_claude "How does compound-engineering distinguish organization-level standards from repo-specific project notes?" 90)
assert_contains "$output" "standards corpus\|company standards" "Mentions standards corpus" || exit 1
assert_contains "$output" "project-notes corpus\|Project-notes corpus\|project playbook\|Project Playbook" "Mentions project notes corpus" || exit 1

echo ""
echo "=== All compound-engineering skill tests passed ==="
