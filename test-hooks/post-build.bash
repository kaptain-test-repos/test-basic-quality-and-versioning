#!/usr/bin/env bash
set -euo pipefail
# Hook: postBuild — final validation

errors=0
assert_set() { if [[ -z "${!1:-}" ]]; then echo "FAIL: $1 should be set" >&2; ((errors++)); fi; }

assert_set REPOSITORY_NAME
assert_set CURRENT_BRANCH
assert_set VERSION
assert_set PROJECT_NAME
assert_set IS_RELEASE

if [[ "$errors" -gt 0 ]]; then echo "FAILED: $errors assertion(s) in postBuild" >&2; exit 1; fi
echo "PASSED: postBuild validation"
