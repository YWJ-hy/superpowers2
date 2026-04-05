#!/usr/bin/env bash
# Test: bootstrapping-project-knowledge skill
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

echo "=== Test: bootstrapping-project-knowledge skill ==="
echo ""

echo "Test 1: Skill loading..."
output=$(run_claude "What is the bootstrapping-project-knowledge skill? Describe its purpose briefly." 90)
assert_contains "$output" "bootstrapping-project-knowledge\|Bootstrap Project Knowledge\|project knowledge bootstrap" "Skill is recognized" || exit 1
assert_contains "$output" "company standards\|company-standards\|project playbook\|project-playbook" "Mentions corpus targets" || exit 1

echo ""
echo "Test 2: Classification logic..."
output=$(run_claude "In the bootstrapping-project-knowledge skill, how should Claude decide whether a finding belongs in company standards or the project playbook?" 90)
assert_contains "$output" "cross-project\|reusable\|long-term\|organization-level" "Mentions standards criteria" || exit 1
assert_contains "$output" "repo-specific\|repository-specific\|project-specific\|legacy\|pitfall\|pattern" "Mentions playbook criteria" || exit 1

echo ""
echo "Test 3: Evidence requirement..."
output=$(run_claude "What evidence should bootstrapping-project-knowledge require before proposing a standard or project note?" 90)
assert_contains "$output" "evidence\|file path\|docs\|tests\|config\|codebase" "Mentions evidence sources" || exit 1
assert_contains "$output" "repeat\|repeated\|documented\|signal" "Mentions evidence quality" || exit 1

echo ""
echo "Test 4: Confirmation gate..."
output=$(run_claude "After bootstrapping-project-knowledge finds candidate standards and project notes, should it write them directly into the corpora?" 90)
assert_contains "$output" "candidate\|report\|review\|confirm" "Mentions candidate/review flow" || exit 1
assert_contains "$output" "No\.\|do not write directly\|wait for confirmation\|only then write\|only then update" "Requires confirmation before writes" || exit 1

echo ""
echo "Test 5: Output language follows user..."
output=$(run_claude "如果用户用中文请求 bootstrapping-project-knowledge，这个 skill 生成的 bootstrap report 应该用什么语言？请用中文简短回答。" 90)
assert_contains "$output" "中文\|跟随用户语言\|用中文" "Follows Chinese user language" || exit 1

echo ""
echo "=== All bootstrapping-project-knowledge skill tests passed ==="