param(
    [string]$Root = "."
)

$ErrorActionPreference = "Stop"

$releaseDir = Join-Path $Root "build\windows\x64\runner\Release"
$distDir = Join-Path $Root "dist"
$outFile = Join-Path $distDir "logoi-windows-x64.zip"

if (-not (Test-Path $releaseDir)) {
    Write-Error "Windows release directory not found: $releaseDir"
}

New-Item -ItemType Directory -Force -Path $distDir | Out-Null
if (Test-Path $outFile) { Remove-Item $outFile -Force }

Compress-Archive -Path (Join-Path $releaseDir "*") -DestinationPath $outFile -Force

if ($env:GITHUB_OUTPUT) {
    "artifact=$outFile" | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8
}

Write-Host "Created $outFile"
