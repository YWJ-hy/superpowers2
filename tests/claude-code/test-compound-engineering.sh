#!/usr/bin/env bash
# Test: compound-engineering skill
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

echo "=== Test: compound-engineering skill ==="
echo ""

assert_skill_contains() {
    local pattern="$1"
    local test_name="$2"
    if grep -Eq "$pattern" "$REPO_ROOT/skills/compound-engineering/SKILL.md"; then
        echo "  [PASS] $test_name"
    else
        echo "  [FAIL] $test_name"
        echo "  Expected skill file to contain: $pattern"
        exit 1
    fi
}

echo "Test 1: Skill loading..."
assert_skill_contains "# Compound Engineering" "Skill is recognized"
assert_skill_contains "brainstorming|writing-plans|subagent-driven-development" "Mentions existing workflow routing"

echo ""
echo "Test 2: Compound step..."
assert_skill_contains "Compound Candidates|Promote to Company Standards|Add to Project Playbook|Keep in Feature Spec / Plan Only" "Mentions compound candidates output"

echo ""
echo "Test 3: Corpus separation..."
assert_skill_contains "standards corpus|organization-level rules" "Mentions standards corpus"
assert_skill_contains "project-notes corpus|repo-specific pitfalls, patterns, and legacy constraints" "Mentions project notes corpus"

echo ""
echo "Test 4: Codify handoff boundaries..."
assert_skill_contains "codifying-compound-candidates" "Mentions codify handoff"
assert_skill_contains "should only codify entries under:" "Locks codifiable bucket boundary"
assert_skill_contains "Keep in Feature Spec / Plan Only" "Mentions non-codifiable bucket"
assert_skill_contains "Do \*\*not\*\* auto-edit the corpora" "Preserves no-auto-edit boundary"

echo ""
echo "=== All compound-engineering skill tests passed ==="
