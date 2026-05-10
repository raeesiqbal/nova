param(
  [string]$Output = "Nova Proposal - Client.pdf"
)

$ErrorActionPreference = "Stop"
if (Get-Variable -Name PSNativeCommandUseErrorActionPreference -Scope Global -ErrorAction SilentlyContinue) {
  $Global:PSNativeCommandUseErrorActionPreference = $false
}

$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$HtmlPath = Join-Path $Root "Nova Proposal.html"

if (-not (Test-Path -LiteralPath $HtmlPath)) {
  throw "Cannot find Nova Proposal.html beside this script."
}

$ChromeCandidates = @(
  "C:\Program Files\Google\Chrome\Application\chrome.exe",
  "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
  "C:\Program Files\Microsoft\Edge\Application\msedge.exe",
  "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
)

$Browser = $ChromeCandidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
if (-not $Browser) {
  $BrowserCommand = Get-Command chrome, msedge -ErrorAction SilentlyContinue | Select-Object -First 1
  if ($BrowserCommand) {
    $Browser = $BrowserCommand.Source
  }
}

if (-not $Browser) {
  throw "Chrome or Edge was not found. Install one of them, or add it to PATH."
}

$OutputPath = if ([System.IO.Path]::IsPathRooted($Output)) {
  $Output
} else {
  Join-Path $Root $Output
}

$ProfilePath = Join-Path $env:TEMP ("nova-pdf-profile-" + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Force -Path $ProfilePath | Out-Null

try {
  $HtmlUri = [System.Uri]::new((Resolve-Path -LiteralPath $HtmlPath).Path).AbsoluteUri

  $Args = @(
    "--headless=new",
    "--disable-gpu",
    "--disable-extensions",
    "--disable-background-networking",
    "--allow-file-access-from-files",
    "--no-pdf-header-footer",
    "--print-to-pdf-no-header",
    "--run-all-compositor-stages-before-draw",
    "--virtual-time-budget=5000",
    "--user-data-dir=$ProfilePath",
    "--print-to-pdf=$OutputPath",
    $HtmlUri
  )

  $PreviousErrorActionPreference = $ErrorActionPreference
  $ErrorActionPreference = "Continue"
  $BrowserOutput = & $Browser @Args 2>&1
  $BrowserExitCode = $LASTEXITCODE
  $ErrorActionPreference = $PreviousErrorActionPreference

  $BrowserOutput |
    Where-Object { $_ -match "bytes written to file|ERROR|WARNING|failed|Failed" } |
    ForEach-Object { Write-Verbose $_ }

  if (-not (Test-Path -LiteralPath $OutputPath)) {
    throw "PDF generation finished, but the output file was not created."
  }

  $File = Get-Item -LiteralPath $OutputPath
  if ($File.Length -le 0) {
    throw "PDF generation finished, but the output file is empty."
  }

  if ($null -ne $BrowserExitCode -and $BrowserExitCode -ne 0) {
    Write-Warning "Chrome returned exit code $BrowserExitCode, but the PDF was created successfully."
  }

  Write-Output ("PDF written: {0}" -f $File.FullName)
  Write-Output ("Size: {0:N0} bytes" -f $File.Length)
} finally {
  Remove-Item -LiteralPath $ProfilePath -Recurse -Force -ErrorAction SilentlyContinue
}
