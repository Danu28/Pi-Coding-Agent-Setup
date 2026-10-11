#Requires -Version 5.1
$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $PSScriptRoot
if (-not (Test-Path "$RepoRoot/settings.json")) { $RepoRoot = $PSScriptRoot }
if (-not (Test-Path "$RepoRoot/settings.json")) { $RepoRoot = Get-Location }
$Target = Join-Path $env:USERPROFILE ".pi/agent"
Write-Host "Installing Pi setup to $Target ..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $Target | Out-Null
New-Item -ItemType Directory -Force -Path "$Target/skills" | Out-Null
New-Item -ItemType Directory -Force -Path "$Target/extensions" | Out-Null
Copy-Item "$RepoRoot/AGENTS.md" "$Target/AGENTS.md" -Force -ErrorAction SilentlyContinue
Copy-Item "$RepoRoot/APPEND_SYSTEM.md" "$Target/APPEND_SYSTEM.md" -Force -ErrorAction SilentlyContinue
Copy-Item "$RepoRoot/settings.json" "$Target/settings.json" -Force
if (Test-Path "$RepoRoot/trust.json.example") {
  if (-not (Test-Path "$Target/trust.json")) { Copy-Item "$RepoRoot/trust.json.example" "$Target/trust.json" -Force; Write-Host "Created trust.json - EDIT paths!" -ForegroundColor Yellow }
  else { Write-Host "trust.json exists - skipping" -ForegroundColor DarkGray }
}
if (Test-Path "$RepoRoot/extensions") { Copy-Item "$RepoRoot/extensions/*" "$Target/extensions/" -Recurse -Force -ErrorAction SilentlyContinue }
if (Test-Path "$RepoRoot/skills") { Copy-Item "$RepoRoot/skills/*" "$Target/skills/" -Recurse -Force -ErrorAction SilentlyContinue }
Write-Host "Done! Restart pi and run: pi --version" -ForegroundColor Green
