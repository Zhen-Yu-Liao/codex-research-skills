$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$scanRoots = @("skills", "README.md", "docs", "scripts", ".github") | ForEach-Object {
    Join-Path $repoRoot $_
} | Where-Object {
    Test-Path $_
}

$patterns = @(
    "JCGS",
    "Huang",
    "main_zh",
    "D:\\User",
    "C:\\Users\\USER",
    "OPENAI_API_KEY",
    "GITHUB_TOKEN",
    "GH_TOKEN",
    "ghp_[A-Za-z0-9_]+",
    "gho_[A-Za-z0-9_]+",
    "sk-[A-Za-z0-9_]+",
    "password\\s*[:=]",
    "secret\\s*[:=]"
)

$files = foreach ($root in $scanRoots) {
    if (Test-Path $root -PathType Leaf) {
        Get-Item $root
    } else {
        Get-ChildItem -Path $root -Recurse -File -Include *.md,*.yaml,*.yml,*.ps1,*.py,*.txt
    }
}

$self = $MyInvocation.MyCommand.Path
$files = $files | Where-Object { $_.FullName -ne $self }

$findings = foreach ($pattern in $patterns) {
    $files | Select-String -Pattern $pattern -CaseSensitive:$false | ForEach-Object {
        [PSCustomObject]@{
            Pattern = $pattern
            Path = $_.Path
            LineNumber = $_.LineNumber
            Line = $_.Line.Trim()
        }
    }
}

$yamlFindings = Get-ChildItem -Path (Join-Path $repoRoot "skills") -Recurse -File -Filter openai.yaml |
    Select-String -Pattern "[?]" | ForEach-Object {
        [PSCustomObject]@{
            Pattern = "openai.yaml literal ?"
            Path = $_.Path
            LineNumber = $_.LineNumber
            Line = $_.Line.Trim()
        }
    }

$findings = @($findings) + @($yamlFindings)

if ($findings) {
    $findings | Format-Table -AutoSize
    throw "Public safety scan found potential private content or unsafe placeholders."
}

Write-Host "Public safety scan passed."
