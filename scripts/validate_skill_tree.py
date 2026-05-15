from __future__ import annotations

import re
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SKILLS = ROOT / "skills"
NAME_RE = re.compile(r"^[a-z0-9-]+$")


def read_frontmatter(path: Path) -> dict[str, str]:
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        raise ValueError(f"{path}: missing YAML frontmatter")
    end = text.find("\n---", 4)
    if end == -1:
        raise ValueError(f"{path}: unclosed YAML frontmatter")
    frontmatter = text[4:end].strip().splitlines()
    fields: dict[str, str] = {}
    for line in frontmatter:
        if not line.strip():
            continue
        if ":" not in line:
            raise ValueError(f"{path}: invalid frontmatter line: {line}")
        key, value = line.split(":", 1)
        fields[key.strip()] = value.strip()
    return fields


def validate_skill(skill_dir: Path) -> list[str]:
    errors: list[str] = []
    skill_md = skill_dir / "SKILL.md"
    if not skill_md.exists():
        return errors

    try:
        fields = read_frontmatter(skill_md)
    except ValueError as exc:
        return [str(exc)]

    allowed = {"name", "description"}
    extra = set(fields) - allowed
    missing = allowed - set(fields)
    if extra:
        errors.append(f"{skill_md}: unexpected frontmatter fields: {sorted(extra)}")
    if missing:
        errors.append(f"{skill_md}: missing frontmatter fields: {sorted(missing)}")

    name = fields.get("name", "")
    description = fields.get("description", "")
    if name != skill_dir.name:
        errors.append(f"{skill_md}: name '{name}' does not match folder '{skill_dir.name}'")
    if not NAME_RE.match(name):
        errors.append(f"{skill_md}: invalid skill name '{name}'")
    if not description:
        errors.append(f"{skill_md}: description must not be empty")

    openai_yaml = skill_dir / "agents" / "openai.yaml"
    if not openai_yaml.exists():
        errors.append(f"{skill_dir}: missing agents/openai.yaml")
    else:
        yaml_text = openai_yaml.read_text(encoding="utf-8")
        if "?" in yaml_text:
            errors.append(f"{openai_yaml}: contains '?' placeholder or mojibake")

    return errors


def main() -> int:
    if not SKILLS.exists():
        print("skills/ directory not found", file=sys.stderr)
        return 1

    errors: list[str] = []
    triggerable = 0
    for skill_dir in sorted(p for p in SKILLS.iterdir() if p.is_dir()):
        if (skill_dir / "SKILL.md").exists():
            triggerable += 1
            errors.extend(validate_skill(skill_dir))

    if triggerable == 0:
        errors.append("No triggerable skills found")

    if errors:
        for error in errors:
            print(error, file=sys.stderr)
        return 1

    print(f"Validated {triggerable} triggerable skills.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
