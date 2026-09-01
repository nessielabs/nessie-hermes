#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

python3 - "$REPO_ROOT" <<'PY'
import json
import pathlib
import re
import sys

root = pathlib.Path(sys.argv[1])

required = [
    "README.md",
    "LICENSE",
    "package.json",
    "skill-version.json",
    "skills/nessie/SKILL.md",
]
missing = [path for path in required if not (root / path).is_file()]
if missing:
    raise SystemExit(f"Missing required files: {', '.join(missing)}")

package = json.loads((root / "package.json").read_text(encoding="utf-8"))
if package.get("name") != "@nessielabs/nessie-hermes":
    raise SystemExit("package.json name must be @nessielabs/nessie-hermes")
if package.get("license") != "MIT-0":
    raise SystemExit("package.json license must be MIT-0")
package_version = package.get("version")
if not package_version:
    raise SystemExit("package.json must declare version")

skill = (root / "skills/nessie/SKILL.md").read_text(encoding="utf-8")
skill_version = re.search(r"^version:\s*(\S+)\s*$", skill, re.MULTILINE)
if not skill_version:
    raise SystemExit("skills/nessie/SKILL.md must declare version frontmatter")
if skill_version.group(1) != package_version:
    raise SystemExit("skills/nessie/SKILL.md version must match package.json version")
for needle in [
    "## Session Initiation",
    "`initiated` is Nessie's derived, provider-neutral category",
    "current listing's direct children",
    'pass `initiated: "human"`',
    "including the virtual Contexts root, reject an initiation filter",
    "## Native Coding-Agent Memory",
    "`native_memory_collection`",
    "`requiresVerification: true`",
    "older MCP host may reject the `memory` filter",
    "`memory`, or `meeting`",
    "provider-derived project orientation",
]:
    if needle not in skill:
        raise SystemExit(f"skills/nessie/SKILL.md must mention {needle}")

pointer = json.loads((root / "skill-version.json").read_text(encoding="utf-8"))
if pointer.get("surface") != "hermes":
    raise SystemExit("skill-version.json surface must be hermes")
if pointer.get("version") != package_version:
    raise SystemExit("skill-version.json version must match package.json version")
if pointer.get("skillUrl") != "https://raw.githubusercontent.com/nessielabs/nessie-hermes/main/skills/nessie/SKILL.md":
    raise SystemExit("skill-version.json skillUrl must point at the published SKILL.md")
if pointer.get("updateCommand") != "hermes skills update nessie":
    raise SystemExit("skill-version.json updateCommand must be the Hermes skill update command")

attributed_url = "https://mcp.nessielabs.com/mcp?client=hermes"
setup_command = f'hermes mcp add nessie --url "{attributed_url}" --auth header'
for relative_path, content in [
    ("README.md", (root / "README.md").read_text(encoding="utf-8")),
    ("skills/nessie/SKILL.md", skill),
]:
    if setup_command not in content:
        raise SystemExit(f"{relative_path} must include the shell-safe attributed Hermes setup command")
    unattributed = re.search(r"https://mcp\.nessielabs\.com/mcp(?!\?client=hermes)", content)
    if unattributed:
        raise SystemExit(f"{relative_path} must not reference an unattributed hosted MCP endpoint")
PY

echo "Nessie Hermes package validation passed."
