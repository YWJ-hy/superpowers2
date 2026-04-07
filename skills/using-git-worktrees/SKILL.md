---
name: using-git-worktrees
description: Use when starting feature work that needs isolation from current workspace or before executing implementation plans - creates isolated git worktrees with smart directory selection and safety verification
---

# Using Git Worktrees

## Overview

Git worktrees create isolated workspaces sharing the same repository, allowing work on multiple branches simultaneously without switching.

**Core principle:** Systematic directory selection + safety verification = reliable isolation.

**Announce at start:** "I'm using the using-git-worktrees skill to set up an isolated workspace."

## Directory Selection Process

Follow this priority order:

### 1. Check Existing Directories

```bash
# Check in priority order
ls -d .worktrees 2>/dev/null     # Preferred (hidden)
ls -d worktrees 2>/dev/null      # Alternative
```

**If found:** Use that directory. If both exist, `.worktrees` wins.

### 2. Check CLAUDE.md

```bash
grep -i "worktree.*director" CLAUDE.md 2>/dev/null
```

**If preference specified:** Use it without asking.

### 3. Ask User

If no directory exists and no CLAUDE.md preference:

```
No worktree directory found. Where should I create worktrees?

1. .worktrees/ (project-local, hidden)
2. ~/.config/superpowers/worktrees/<project-name>/ (global location)

Which would you prefer?
```

## Safety Verification

### For Project-Local Directories (.worktrees or worktrees)

**MUST verify directory is ignored before creating worktree:**

```bash
# Check if directory is ignored (respects local, global, and system gitignore)
git check-ignore -q .worktrees 2>/dev/null || git check-ignore -q worktrees 2>/dev/null
```

**If NOT ignored:**

Per Jesse's rule "Fix broken things immediately":
1. Add appropriate line to .gitignore
2. Commit the change
3. Proceed with worktree creation

**Why critical:** Prevents accidentally committing worktree contents to repository.

### For Global Directory (~/.config/superpowers/worktrees)

No .gitignore verification needed - outside project entirely.

## Creation Steps

### 1. Detect Project Name

```bash
repo_root=$(git rev-parse --show-toplevel)
project=$(basename "$repo_root")
```

### 2. Create Worktree

```bash
# Determine full path
case $LOCATION in
  .worktrees|worktrees)
    path="$LOCATION/$BRANCH_NAME"
    ;;
  ~/.config/superpowers/worktrees/*)
    path="~/.config/superpowers/worktrees/$project/$BRANCH_NAME"
    ;;
esac

# Create worktree with new branch
git worktree add "$path" -b "$BRANCH_NAME"
cd "$path"
```

### 3. Apply Optional Directory Links

If the project defines `.superpowers/config.json`, read it from the main repository root captured above:

```bash
config_file="$repo_root/.superpowers/config.json"
```

Supported fields:

```json
{
  "symlinkDirectories": ["node_modules"],
  "runSetupAfterSymlink": false
}
```

Rules:
- `symlinkDirectories` is optional and defaults to `[]`
- `runSetupAfterSymlink` is optional; if omitted, keep the original setup behavior
- Each `symlinkDirectories` entry must be a non-empty repo-root-relative directory path
- Do not allow absolute paths, `~`, globs, environment-variable expansion, files, or paths that escape the repo via `..`
- The source path must already exist in the main repository and must be a directory
- The worktree target path must be the same relative path inside the worktree

Apply each entry after `git worktree add` and before any setup commands:
- If the worktree target does not exist, create parent directories and link it to the main repository directory
- If the worktree target already exists and already points at the correct source directory, treat that as success and continue
- If the worktree target exists but is a regular directory/file or points somewhere else, stop and report the conflict

Platform rules:
- On macOS/Linux, create a directory symlink
- On Windows, a directory junction is acceptable and preferred when it is more reliable than a true symlink

Setup control:
- If `runSetupAfterSymlink` is `false`, skip the setup step below after links are applied and go straight to baseline verification
- If `runSetupAfterSymlink` is `true` or omitted, continue with the original setup step
- If `node_modules` is linked and setup still runs, explicitly note that install commands may mutate the shared main-repository directory

If `.superpowers/config.json` is missing, skip directory linking and continue normally. If the file exists but is invalid, or contains an invalid `symlinkDirectories` entry, stop and report the exact issue before running setup or tests.

### 4. Run Project Setup

Auto-detect and run appropriate setup:

```bash
# Node.js
if [ -f package.json ]; then npm install; fi

# Rust
if [ -f Cargo.toml ]; then cargo build; fi

# Python
if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
if [ -f pyproject.toml ]; then poetry install; fi

# Go
if [ -f go.mod ]; then go mod download; fi
```

### 5. Verify Clean Baseline

Run tests to ensure worktree starts clean:

```bash
# Examples - use project-appropriate command
npm test
cargo test
pytest
go test ./...
```

**If tests fail:** Report failures, ask whether to proceed or investigate.

**If tests pass:** Report ready.

### 6. Report Location

```
Worktree ready at <full-path>
Linked directories: <list or none>
Setup run: <yes/no>
Tests passing (<N> tests, 0 failures)
Ready to implement <feature-name>
```

## Quick Reference

| Situation | Action |
|-----------|--------|
| `.worktrees/` exists | Use it (verify ignored) |
| `worktrees/` exists | Use it (verify ignored) |
| Both exist | Use `.worktrees/` |
| Neither exists | Check CLAUDE.md → Ask user |
| Directory not ignored | Add to .gitignore + commit |
| `.superpowers/config.json` missing | Skip directory linking |
| `.superpowers/config.json` invalid | Stop and report the config error |
| `symlinkDirectories` configured | Link each directory before setup |
| `runSetupAfterSymlink: false` | Skip setup, go to baseline tests |
| Tests fail during baseline | Report failures + ask |
| No package.json/Cargo.toml | Skip dependency install |

## Common Mistakes

### Skipping ignore verification

- **Problem:** Worktree contents get tracked, pollute git status
- **Fix:** Always use `git check-ignore` before creating project-local worktree

### Assuming directory location

- **Problem:** Creates inconsistency, violates project conventions
- **Fix:** Follow priority: existing > CLAUDE.md > ask

### Proceeding with failing tests

- **Problem:** Can't distinguish new bugs from pre-existing issues
- **Fix:** Report failures, get explicit permission to proceed

### Hardcoding setup commands

- **Problem:** Breaks on projects using different tools
- **Fix:** Auto-detect from project files (package.json, etc.)

### Running setup after linking shared directories without checking config

- **Problem:** Setup may mutate a shared directory like main-repo `node_modules`
- **Fix:** Respect `runSetupAfterSymlink`; when omitted, keep original behavior and warn if setup may touch a shared directory

## Example Workflow

```
You: I'm using the using-git-worktrees skill to set up an isolated workspace.

[Check .worktrees/ - exists]
[Verify ignored - git check-ignore confirms .worktrees/ is ignored]
[Create worktree: git worktree add .worktrees/auth -b feature/auth]
[Read .superpowers/config.json]
[Link node_modules from main repository]
[runSetupAfterSymlink=false, so skip npm install]
[Run npm test - 47 passing]

Worktree ready at /Users/jesse/myproject/.worktrees/auth
Linked directories: node_modules
Setup run: no
Tests passing (47 tests, 0 failures)
Ready to implement auth feature
```

## Red Flags

**Never:**
- Create worktree without verifying it's ignored (project-local)
- Skip baseline test verification
- Proceed with failing tests without asking
- Assume directory location when ambiguous
- Skip CLAUDE.md check
- Overwrite an existing worktree path that conflicts with a configured linked directory
- Treat an invalid `.superpowers/config.json` as a warning and continue anyway

**Always:**
- Follow directory priority: existing > CLAUDE.md > ask
- Verify directory is ignored for project-local
- Apply configured directory links before setup
- Respect `runSetupAfterSymlink` when deciding whether to run setup
- Verify clean test baseline

## Integration

**Called by:**
- **brainstorming** (Phase 4) - REQUIRED when design is approved and implementation follows
- **subagent-driven-development** - REQUIRED: Ensures isolated workspace is ready (creates one or verifies existing, then applies any configured directory links before setup)
- **executing-plans** - REQUIRED: Ensures isolated workspace is ready (creates one or verifies existing, then applies any configured directory links before setup)
- Any skill needing isolated workspace

**Pairs with:**
- **finishing-a-development-branch** - REQUIRED for cleanup after work complete
