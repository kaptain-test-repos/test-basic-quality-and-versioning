#!/usr/bin/env bash
set -euo pipefail
# Hook: postVersionsAndNaming — version vars MUST be set now

errors=0
assert_set() { if [[ -z "${!1:-}" ]]; then echo "FAIL: $1 should be set" >&2; errors=$((errors + 1)); fi; }
assert_equals() { if [[ "${!1:-}" != "$2" ]]; then echo "FAIL: $1 expected '$2' got '${!1:-}'" >&2; errors=$((errors + 1)); fi; }

assert_set VERSION
assert_set VERSION_MAJOR
assert_set VERSION_MINOR
assert_set VERSION_PATCH
assert_set VERSION_2_PART
assert_set VERSION_3_PART
assert_set DOCKER_TAG
assert_set GIT_TAG
assert_set PROJECT_NAME
assert_set IS_RELEASE

# Internal consistency: VERSION_3_PART should equal MAJOR.MINOR.PATCH
expected="${VERSION_MAJOR:-}.${VERSION_MINOR:-}.${VERSION_PATCH:-}"
if [[ "${VERSION_3_PART:-}" != "$expected" ]]; then
  echo "FAIL: VERSION_3_PART '${VERSION_3_PART:-}' != assembled '$expected'" >&2
  errors=$((errors + 1))
fi

if [[ "$errors" -gt 0 ]]; then echo "FAILED: $errors assertion(s) in postVersionsAndNaming" >&2; exit 1; fi
echo "PASSED: postVersionsAndNaming validation"
