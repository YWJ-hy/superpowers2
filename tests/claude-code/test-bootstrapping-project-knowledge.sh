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


echo "Test 0: Repo-root corpora exist and duplicate suites are gone..."
assert_markdown_exists_under "$REPO_ROOT/company-standards" "Company standards corpus files exist"
assert_markdown_exists_under "$REPO_ROOT/project-playbook" "Project playbook corpus files exist"
if find "$REPO_ROOT/skills/bootstrapping-project-knowledge/template-suites" -name "*.md" -print -quit 2>/dev/null | grep -q .; then
    echo "  [FAIL] Duplicate template suite markdown still exists"
    exit 1
else
    echo "  [PASS] Duplicate template suite markdown removed"
fi

echo ""
echo "Test 1: Skill loading..."
output=$(run_claude "What is the bootstrapping-project-knowledge skill? Describe its purpose briefly." 90)
assert_contains "$output" "bootstrapping-project-knowledge\|Bootstrap Project Knowledge\|project knowledge bootstrap\|cold-starting project knowledge\|cold-start project knowledge\|existing repo\|repo-onboarding skill\|existing codebase\|知识冷启动\|已有代码库" "Skill is recognized" || exit 1
assert_contains "$output" "company standards\|company-standards\|project playbook\|project-playbook" "Mentions corpus targets" || exit 1

echo ""
echo "Test 2: Classification logic..."
output=$(run_claude "In the bootstrapping-project-knowledge skill, how should Claude decide whether a finding belongs in company standards or the project playbook?" 90)
assert_contains "$output" "cross-project\|reusable\|long-term\|organization-level\|跨项目\|复用\|长期" "Mentions standards criteria" || exit 1
assert_contains "$output" "repo-specific\|repository-specific\|project-specific\|legacy\|pitfall\|pattern\|当前仓库\|本仓库\|本地模式\|历史包袱" "Mentions playbook criteria" || exit 1

echo ""
echo "Test 3: Evidence requirement..."
output=$(run_claude "What evidence should bootstrapping-project-knowledge require before proposing a standard or project note?" 90)
assert_contains "$output" "evidence\|file path\|docs\|tests\|config\|codebase" "Mentions evidence sources" || exit 1
assert_contains "$output" "repeat\|Repeat\|repeated\|Repeated\|documented\|signal\|重复\|高信号\|多文件" "Mentions evidence quality" || exit 1

echo ""
echo "Test 4: Confirmation gate..."
output=$(run_claude "After bootstrapping-project-knowledge finds candidate standards and project notes, should it write them directly into the corpora?" 90)
assert_contains "$output" "candidate\|report\|review\|confirm" "Mentions candidate/review flow" || exit 1
assert_contains "$output" "No\.\|do not write directly\|wait for confirmation\|only then write\|only then update\|等你确认\|然后才写\|不应该默认直接写入" "Requires confirmation before writes" || exit 1

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
output=$(run_claude "If the user selects a built-in template suite for a missing corpus but declines further analysis, what should bootstrapping-project-knowledge do?" 90)
assert_contains "$output" "copy\|install\|拷贝\|安装" "Installs selected template suite" || exit 1
assert_contains "$output" "stop\|only\|不继续\|仅" "Stops after install when analysis is declined" || exit 1
assert_contains "$output" "not continue analyzing or filling\|stop without analysis/filling\|不继续分析填充" "Does not continue analysis after install-only choice" || exit 1

echo ""
echo "Test 10: Skill text covers partial-missing handling..."
assert_skill_contains "If one corpus already exists and the other is missing:" "Skill documents mixed corpus state"
assert_skill_contains "existing side: only fill existing files" "Skill keeps existing side in existing-corpus mode"
assert_skill_contains "missing side: follow the suite-selection flow" "Skill routes missing side to suite selection"

echo ""
echo "Test 11: Additive ID governance..."
output=$(run_claude "In the bootstrapping-project-knowledge skill, if multiple maintainers add new standards and IDs collide, should Claude renumber existing IDs to make the sequence pretty?" 90)
assert_contains "$output" "No\.\|do not renumber\|prefer additive\|next available\|collision" "Mentions additive ID governance" || exit 1

echo ""
echo "Test 12: Output language follows user..."
output=$(run_claude "如果用户用中文请求 bootstrapping-project-knowledge，这个 skill 生成的 bootstrap report 应该用什么语言？请用中文简短回答。" 90)
assert_contains "$output" "中文\|跟随用户语言\|用中文" "Follows Chinese user language" || exit 1

echo ""
echo "=== All bootstrapping-project-knowledge skill tests passed ==="
