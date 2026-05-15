param(
    [string]$SkillCreatorRoot = "$env:USERPROFILE\.codex\skills\.system\skill-creator"
)

$ErrorActionPreference = "Stop"

$validator = Join-Path $SkillCreatorRoot "scripts\quick_validate.py"
if (-not (Test-Path $validator)) {
    throw "quick_validate.py not found: $validator"
}

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$skillRoot = Join-Path $repoRoot "skills"
$skills = Get-ChildItem -Path $skillRoot -Directory | Where-Object {
    Test-Path (Join-Path $_.FullName "SKILL.md")
}

if (-not $skills) {
    throw "No triggerable skills found under $skillRoot"
}

foreach ($skill in $skills) {
    Write-Host "Validating $($skill.Name)"
    python -X utf8 $validator $skill.FullName
}

Write-Host "Validated $($skills.Count) triggerable skills."
