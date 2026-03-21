#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PACKAGE_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

temp_dir="$(mktemp -d)"
cleanup() {
  rm -rf "${temp_dir}"
}
trap cleanup EXIT

cd "${PACKAGE_ROOT}"
npx -y skills@latest add . --list >/dev/null

cd "${temp_dir}"
npx -y skills@latest add "${PACKAGE_ROOT}" --skill agentation-fix-loop --agent pi --yes --copy >/dev/null

test -f ./.pi/skills/agentation-fix-loop/SKILL.md
grep -q '^name: agentation-fix-loop$' ./.pi/skills/agentation-fix-loop/SKILL.md
