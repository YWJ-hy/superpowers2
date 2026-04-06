#!/usr/bin/env bash
# Test: subagent-driven-development skill
# Verifies that the skill is loaded and follows correct workflow
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

assert_skill_contains() {
    local pattern="$1"
    local test_name="$2"
    if grep -Eq "$pattern" "$REPO_ROOT/skills/subagent-driven-development/SKILL.md"; then
        echo "  [PASS] $test_name"
    else
        echo "  [FAIL] $test_name"
        echo "  Expected skill file to contain: $pattern"
        exit 1
    fi
}

assert_implementer_prompt_contains() {
    local pattern="$1"
    local test_name="$2"
    if grep -Eq "$pattern" "$REPO_ROOT/skills/subagent-driven-development/implementer-prompt.md"; then
        echo "  [PASS] $test_name"
    else
        echo "  [FAIL] $test_name"
        echo "  Expected implementer prompt to contain: $pattern"
        exit 1
    fi
}

echo "=== Test: subagent-driven-development skill ==="
echo ""

# Test 1: Verify skill can be loaded
echo "Test 1: Skill loading..."
assert_skill_contains "# Subagent-Driven Development" "Skill is recognized"
assert_skill_contains "Read plan, extract all tasks with full text" "Mentions loading plan"

echo ""

# Test 2: Verify skill describes correct workflow order
echo "Test 2: Workflow ordering..."
assert_skill_contains "spec compliance first, then code quality" "Spec compliance before code quality"

echo ""

# Test 3: Verify self-review is mentioned
echo "Test 3: Self-review requirement..."
assert_skill_contains "Self-review" "Mentions self-review"
assert_implementer_prompt_contains 'Did I fully implement everything in the spec' "Checks completeness prompt 1"
assert_implementer_prompt_contains 'Did I miss any requirements' "Checks completeness prompt 2"
assert_implementer_prompt_contains 'Do tests actually verify behavior' "Checks completeness prompt 3"

echo ""

# Test 4: Verify plan is read once
echo "Test 4: Plan reading efficiency..."
assert_skill_contains "Read plan, extract all tasks with full text" "Read plan once"
assert_skill_contains "Read plan, extract all tasks with full text.*create TodoWrite" "Read at beginning"

echo ""

# Test 5: Verify spec compliance reviewer is skeptical
echo "Test 5: Spec compliance reviewer mindset..."
assert_skill_contains "Dispatch spec reviewer subagent" "Reviewer stage exists"
assert_implementer_prompt_contains "self-review" "Implementer self-review exists"
if grep -Eq "Do Not Trust the Report|DO NOT:|verify everything independently" "$REPO_ROOT/skills/subagent-driven-development/spec-reviewer-prompt.md"; then
    echo "  [PASS] Reviewer is skeptical"
else
    echo "  [FAIL] Reviewer is skeptical"
    exit 1
fi
if grep -Eq "Read the actual code they wrote|verify by reading code|Read the implementation code and verify" "$REPO_ROOT/skills/subagent-driven-development/spec-reviewer-prompt.md"; then
    echo "  [PASS] Reviewer reads code"
else
    echo "  [FAIL] Reviewer reads code"
    exit 1
fi

echo ""

# Test 6: Verify review loops
echo "Test 6: Review loop requirements..."
assert_skill_contains "re-review|review loops" "Review loops mentioned"
assert_skill_contains "Implementer subagent fixes spec gaps|Implementer subagent fixes quality issues" "Implementer fixes issues"

echo ""

# Test 7: Verify full task text and packet excerpts are provided
echo "Test 7: Task context provision..."
assert_skill_contains "provide full task text|full text instead|Make subagent read plan file \(provide full text instead\)" "Provides text directly"
assert_skill_contains "don't make subagent read file|No file reading overhead|controller provides full task text" "Doesn't make subagent read file"

echo ""

# Test 8: Verify task packets can carry standards/project-note excerpts
echo "Test 8: Task packet excerpts when available..."
assert_skill_contains "any available packet excerpts|Inline excerpts are optional context" "Mentions optional excerpts context"
assert_skill_contains "standards|project notes" "Mentions standards and project notes context"

echo ""

# Test 9: Verify subagent does not resolve IDs itself
echo "Test 9: Inline excerpts vs hidden parser..."
assert_skill_contains "Subagent should not be expected to resolve IDs|no hidden parser|controller passes IDs without inventing missing excerpts" "Does not rely on subagent-side resolution"

echo ""

# Test 10: Verify worktree requirement
echo "Test 10: Worktree requirement..."
assert_skill_contains "using-git-worktrees|worktree" "Mentions worktree requirement"

echo ""

# Test 11: Verify main branch warning
echo "Test 11: Main branch red flag..."
assert_skill_contains "Start implementation on main/master branch without explicit user consent" "Warns against main branch"

echo ""
echo "=== All subagent-driven-development skill tests passed ==="
