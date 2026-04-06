#!/usr/bin/env bash
# Test: bootstrapping-project-knowledge skill
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

echo "=== Test: bootstrapping-project-knowledge skill ==="
echo ""

assert_skill_contains() {
    local pattern="$1"
    local test_name="$2"
    if grep -Eq "$pattern" "$REPO_ROOT/skills/bootstrapping-project-knowledge/SKILL.md"; then
        echo "  [PASS] $test_name"
    else
        echo "  [FAIL] $test_name"
        echo "  Expected skill file to contain: $pattern"
        exit 1
    fi
}

assert_markdown_exists_under() {
    local dir="$1"
    local test_name="$2"
    if find "$dir" -name "*.md" -print -quit | grep -q .; then
        echo "  [PASS] $test_name"
    else
        echo "  [FAIL] $test_name"
        echo "  Expected markdown files under: $dir"
        exit 1
    fi
}


echo "Test 0: Repo-root corpora exist, topic shells are empty, and duplicate suites are gone..."
assert_markdown_exists_under "$REPO_ROOT/company-standards" "Company standards corpus files exist"
assert_markdown_exists_under "$REPO_ROOT/project-playbook" "Project playbook corpus files exist"
if grep -R "## FE-\|## BE-\|## SH-\|## PRJ-" "$REPO_ROOT/company-standards" "$REPO_ROOT/project-playbook" >/dev/null 2>&1; then
    echo "  [FAIL] Seeded rule or note entries still exist in template topics"
    exit 1
else
    echo "  [PASS] Repo-root topic files are empty shells"
fi
if find "$REPO_ROOT/skills/bootstrapping-project-knowledge/template-suites" -name "*.md" -print -quit 2>/dev/null | grep -q .; then
    echo "  [FAIL] Duplicate template suite markdown still exists"
    exit 1
else
    echo "  [PASS] Duplicate template suite markdown removed"
fi

echo ""
echo "Test 1: Skill loading..."
assert_skill_contains "# Bootstrapping Project Knowledge" "Skill is recognized"
assert_skill_contains "company-standards/|project-playbook/" "Mentions corpus targets"

echo ""
echo "Test 2: Classification logic..."
assert_skill_contains "reusable across multiple features or projects|stable enough to remain useful over time" "Mentions standards criteria"
assert_skill_contains "repo-specific pitfalls, patterns, and legacy constraints|PRJ-LEG-\*|legacy constraints" "Mentions playbook criteria"

echo ""
echo "Test 3: Evidence requirement..."
assert_skill_contains "at least one concrete file path|a short evidence summary|why the evidence implies a durable rule or note" "Mentions evidence sources"
assert_skill_contains "repeated patterns in multiple files|explicit repo docs or contributor guidance|repeated tests" "Mentions evidence quality"

echo ""
echo "Test 4: Confirmation gate..."
assert_skill_contains "produce candidate report|ask for confirmation|only then write or update corpus files" "Mentions candidate/review flow"
assert_skill_contains 'Do \*\*not\*\* write directly into `company-standards/` or `project-playbook/` by default' "Requires confirmation before writes"

echo ""
echo "Test 5: Skill text locks missing-corpus suite boundaries..."
assert_skill_contains "Do \*\*not\*\* add extra topic files beyond the chosen suite" "Skill forbids extra topic files beyond selected suite"
assert_skill_contains "user chooses a built-in template suite.*before any copying, scaffolding, analysis, or filling happens" "Skill requires template selection before copy or analysis"

echo ""
echo "Test 6: Skill text locks existing-corpus restrictions..."
assert_skill_contains 'only analyze and fill `\.md` files that already exist inside that corpus' "Skill limits existing-corpus mode to existing files"
assert_skill_contains 'do \*\*not\*\* privately add any new `\[topic\]\.md`' "Skill forbids new topic files in existing-corpus mode"

echo ""
echo "Test 7: Skill text locks unmatched-file skipping..."
assert_skill_contains "skip the finding entirely" "Skill says unmatched findings are skipped"
assert_skill_contains "should Claude create or propose a new topic file\? \*\*No\.\*\*" "Skill quick answers forbid new topic files for unmatched findings"

echo ""
echo "Test 8: Skill text locks template selection first..."
assert_skill_contains "should Claude ask the user to choose a built-in template suite before any copying or analysis\? \*\*Yes\.\*\*" "Skill quick answers require template selection before copying or analysis"

echo ""
echo "Test 9: Install-only path..."
assert_skill_contains "only perform the requested template install/copy step and stop" "Installs selected template suite"
assert_skill_contains "Empty topic files after install are expected in template mode" "Install-only path keeps empty topic shells"
assert_skill_contains "no further evidence analysis or inferred content generation should happen" "Does not continue analysis after install-only choice"

echo ""
echo "Test 10: Skill text covers partial-missing handling..."
assert_skill_contains "If one corpus already exists and the other is missing:" "Skill documents mixed corpus state"
assert_skill_contains "existing side: only fill existing files" "Skill keeps existing side in existing-corpus mode"
assert_skill_contains "missing side: follow the suite-selection flow" "Skill routes missing side to suite selection"

echo ""
echo "Test 11: Additive ID governance..."
assert_skill_contains "prefer additive growth over renumbering|resolve collisions at merge time by choosing the next available ID" "Mentions additive ID governance"

echo ""
echo "Test 12: Output language follows user..."
output=$(run_claude "如果用户用中文请求 bootstrapping-project-knowledge，这个 skill 生成的 bootstrap report 应该用什么语言？请用中文简短回答。" 90)
assert_contains "$output" "中文\|跟随用户语言\|用中文" "Follows Chinese user language" || exit 1

echo ""
echo "=== All bootstrapping-project-knowledge skill tests passed ==="
