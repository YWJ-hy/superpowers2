#!/usr/bin/env bash
# Test: codifying-compound-candidates skill
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

echo "=== Test: codifying-compound-candidates skill ==="
echo ""

assert_skill_contains() {
    local pattern="$1"
    local test_name="$2"
    if grep -Eq "$pattern" "$REPO_ROOT/skills/codifying-compound-candidates/SKILL.md"; then
        echo "  [PASS] $test_name"
    else
        echo "  [FAIL] $test_name"
        echo "  Expected skill file to contain: $pattern"
        exit 1
    fi
}

echo "Test 1: Skill loading..."
assert_skill_contains "# Codifying Compound Candidates" "Skill is recognized"
assert_skill_contains "docs/company-standards/|docs/project-playbook/" "Mentions docs corpus targets"

echo ""
echo "Test 2: Intake modes..."
assert_skill_contains 'Direct intake|From `compound-engineering`' "Documents both intake modes"
assert_skill_contains 'require the `## Compound Candidates` structure to be visible' "Requires Compound Candidates structure for compound mode"

echo ""
echo "Test 3: Existing topic constraints..."
assert_skill_contains 'already-existing `\[topic\]\.md` files|already-existing `\.md` file|already-existing topic file' "Limits writes to existing topic files"
assert_skill_contains 'Do \*\*not\*\* create or propose a new topic file' "Forbids creating new topic files"
assert_skill_contains 'skip the item entirely' "Skips unmatched items"

echo ""
echo "Test 4: Compound bucket boundaries..."
assert_skill_contains 'Promote to Company Standards' "Handles company standards bucket"
assert_skill_contains 'Add to Project Playbook' "Handles playbook bucket"
assert_skill_contains 'Keep in Feature Spec / Plan Only' "Mentions feature-only bucket"
assert_skill_contains 'do \*\*not\*\* codify anything from:' "Forbids codifying feature-only bucket in compound mode"

echo ""
echo "Test 5: Confirmation gate..."
assert_skill_contains 'produce a short codification plan' "Requires codification plan first"
assert_skill_contains 'ask for confirmation' "Requires confirmation before write"
assert_skill_contains 'Do \*\*not\*\* write directly into `docs/company-standards/` or `docs/project-playbook/` by default' "Forbids direct writes by default"

echo ""
echo "Test 6: Card shapes..."
assert_skill_contains '`ID`.*`level`|`reviewer checklist`' "Mentions standards rule card fields"
assert_skill_contains '`type`.*`status`|`last validated date`' "Mentions playbook note card fields"

echo ""
echo "Test 7: Output language follows user..."
output=$(run_claude "如果用户用中文请求 codifying-compound-candidates，这个 skill 的 codification plan 应该用什么语言？请用中文简短回答。" 90)
assert_contains "$output" "中文\|跟随用户语言\|用中文" "Follows Chinese user language" || exit 1

echo ""
echo "=== All codifying-compound-candidates skill tests passed ==="