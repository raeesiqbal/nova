$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$rootDir = Split-Path -Parent $scriptDir

$logoWhitePath = Join-Path $rootDir '1\Master_NOVA_White.png'
$logoFallbackBase64Path = Join-Path $rootDir 'Nova-Limited-Logo.base64.txt'

function New-ImageDataUri {
  param(
    [Parameter(Mandatory)] [string] $Path
  )

  if (-not (Test-Path -LiteralPath $Path)) {
    throw "Image file not found: $Path"
  }

  $extension = [System.IO.Path]::GetExtension($Path).TrimStart('.').ToLowerInvariant()
  $mime = if ($extension -eq 'jpg' -or $extension -eq 'jpeg') { 'image/jpeg' } else { 'image/png' }
  $bytes = [System.IO.File]::ReadAllBytes((Resolve-Path -LiteralPath $Path))
  return "data:$mime;base64,$([Convert]::ToBase64String($bytes))"
}

if (Test-Path -LiteralPath $logoWhitePath) {
  $logoDataUri = New-ImageDataUri -Path $logoWhitePath
} elseif (Test-Path -LiteralPath $logoFallbackBase64Path) {
  $logoDataUri = 'data:image/png;base64,' + ((Get-Content -Raw -LiteralPath $logoFallbackBase64Path).Trim())
} else {
  throw "No usable Nova logo found."
}

$dark = '#434244'
$dark2 = '#4e4d4f'
$dark3 = '#5a595b'
$gold = '#e8a020'
$green = '#1a7a4a'
$light = '#f4f6f9'
$paper = '#ffffff'
$ink = '#434244'
$ink2 = '#5f5e60'
$muted = '#858386'
$rule = '#e1e5ec'
$ruleDark = '#686669'
$textOnDark = '#e6e4e4'
$mutedOnDark = '#bdb9ba'
$font = "'Helvetica Neue', Helvetica, Arial, 'Segoe UI', sans-serif"

$name = 'Jamie Gibbs'
$role = 'Director, Nova'
$phoneDisplay = '0203 479 2994'
$phoneHref = '+442034792994'
$email = 'jamie@nova-limited.com'
$websiteDisplay = 'nova-limited.com'
$websiteHref = 'https://nova-limited.com/'
$credentialsLong = '22 years in commercial roofing &nbsp;|&nbsp; Master&rsquo;s in Construction Law and Dispute Resolution &nbsp;|&nbsp; Former Regional Chair, Institute of Roofing'
$credentialsStacked = "22 years in commercial roofing<br>Master&rsquo;s in Construction Law and Dispute Resolution<br>Former Regional Chair, Institute of Roofing"
$credentialsCompact = '22 years commercial roofing &nbsp;|&nbsp; MSc Construction Law &nbsp;|&nbsp; Former Regional Chair, Institute of Roofing'
$companyDetails = 'Registered in England No 16369950 &nbsp;|&nbsp; VAT 4638916110'

function New-EmailSignatureFile {
  param(
    [Parameter(Mandatory)] [string] $Name,
    [Parameter(Mandatory)] [string] $Title,
    [Parameter(Mandatory)] [string] $SignatureHtml
  )

  $html = @"
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>$Title</title>
</head>
<body style="margin:0;padding:0;background:#ffffff;">
$SignatureHtml
</body>
</html>
"@

  $outputPath = Join-Path $scriptDir $Name
  [System.IO.File]::WriteAllText($outputPath, $html, [System.Text.UTF8Encoding]::new($false))
}

$standard = @"
<table role="presentation" cellpadding="0" cellspacing="0" border="0" width="600" style="width:600px;max-width:600px;border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt;font-family:$font;color:$ink;">
  <tr>
    <td width="162" valign="top" bgcolor="$dark" style="width:162px;background:$dark;padding:18px 18px 16px 18px;border-top:4px solid $gold;border-bottom:1px solid $dark;">
      <img src="$logoDataUri" width="112" alt="NOVA" style="display:block;width:112px;height:auto;border:0;outline:none;text-decoration:none;margin:0 0 18px 0;">
      <div style="font-family:$font;font-size:10px;line-height:14px;letter-spacing:1.8px;text-transform:uppercase;color:$gold;font-weight:800;mso-line-height-rule:exactly;">Commercial roofing</div>
      <div style="font-family:$font;font-size:10px;line-height:14px;letter-spacing:1.8px;text-transform:uppercase;color:#ffffff;font-weight:800;mso-line-height-rule:exactly;">Integrated solar</div>
      <div style="height:14px;line-height:14px;font-size:14px;">&nbsp;</div>
      <div style="height:2px;line-height:2px;font-size:2px;background:$gold;width:38px;">&nbsp;</div>
    </td>
    <td valign="top" bgcolor="$paper" style="background:$paper;padding:17px 20px 15px 20px;border-top:4px solid $gold;border-right:1px solid $rule;border-bottom:1px solid $rule;">
      <div style="font-family:$font;font-size:23px;line-height:26px;color:$ink;font-weight:900;letter-spacing:0;mso-line-height-rule:exactly;">$name</div>
      <div style="font-family:$font;font-size:13px;line-height:18px;color:$gold;font-weight:800;mso-line-height-rule:exactly;margin-top:2px;">$role</div>
      <div style="font-family:$font;font-size:12px;line-height:18px;color:$ink2;font-weight:500;mso-line-height-rule:exactly;margin-top:9px;">$credentialsStacked</div>
      <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%" style="width:100%;border-collapse:collapse;margin-top:13px;mso-table-lspace:0pt;mso-table-rspace:0pt;">
        <tr>
          <td width="31%" style="padding:9px 0 0 0;border-top:1px solid $rule;font-family:$font;font-size:10px;line-height:15px;color:$muted;font-weight:800;letter-spacing:1.5px;text-transform:uppercase;mso-line-height-rule:exactly;">Phone</td>
          <td width="41%" style="padding:9px 0 0 16px;border-top:1px solid $rule;font-family:$font;font-size:10px;line-height:15px;color:$muted;font-weight:800;letter-spacing:1.5px;text-transform:uppercase;mso-line-height-rule:exactly;">Email</td>
          <td width="28%" style="padding:9px 0 0 16px;border-top:1px solid $rule;font-family:$font;font-size:10px;line-height:15px;color:$muted;font-weight:800;letter-spacing:1.5px;text-transform:uppercase;mso-line-height-rule:exactly;">Website</td>
        </tr>
        <tr>
          <td width="31%" style="padding:2px 0 0 0;font-family:$font;font-size:13.5px;line-height:18px;font-weight:900;mso-line-height-rule:exactly;"><a href="tel:$phoneHref" style="color:$ink;text-decoration:none;">$phoneDisplay</a></td>
          <td width="41%" style="padding:2px 0 0 16px;font-family:$font;font-size:13px;line-height:18px;font-weight:800;mso-line-height-rule:exactly;"><a href="mailto:$email" style="color:$ink;text-decoration:none;">$email</a></td>
          <td width="28%" style="padding:2px 0 0 16px;font-family:$font;font-size:13px;line-height:18px;font-weight:800;mso-line-height-rule:exactly;"><a href="$websiteHref" style="color:$ink;text-decoration:none;">$websiteDisplay</a></td>
        </tr>
      </table>
      <div style="font-family:$font;font-size:10.5px;line-height:15px;color:$muted;font-weight:500;mso-line-height-rule:exactly;margin-top:10px;">$companyDetails</div>
    </td>
  </tr>
</table>
"@

$darkBlock = @"
<table role="presentation" cellpadding="0" cellspacing="0" border="0" width="600" bgcolor="$dark" style="width:600px;max-width:600px;border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt;background:$dark;font-family:$font;color:#ffffff;">
  <tr>
    <td style="padding:21px 24px 18px 24px;border-top:4px solid $gold;">
      <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%" style="width:100%;border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt;">
        <tr>
          <td valign="top" style="padding:0 18px 0 0;">
            <img src="$logoDataUri" width="118" alt="NOVA" style="display:block;width:118px;height:auto;border:0;outline:none;text-decoration:none;">
          </td>
          <td valign="top" align="right" style="padding:1px 0 0 0;font-family:$font;font-size:10px;line-height:14px;color:$gold;font-weight:800;letter-spacing:1.9px;text-transform:uppercase;mso-line-height-rule:exactly;">Commercial roofing<br><span style="color:#ffffff;">Integrated solar</span></td>
        </tr>
      </table>
      <div style="height:16px;line-height:16px;font-size:16px;">&nbsp;</div>
      <div style="font-family:$font;font-size:26px;line-height:30px;color:#ffffff;font-weight:900;letter-spacing:0;mso-line-height-rule:exactly;">$name</div>
      <div style="font-family:$font;font-size:13px;line-height:18px;color:$gold;font-weight:800;mso-line-height-rule:exactly;">$role</div>
      <div style="font-family:$font;font-size:12px;line-height:18px;color:$textOnDark;font-weight:500;mso-line-height-rule:exactly;margin-top:8px;">$credentialsLong</div>
      <div style="height:14px;line-height:14px;font-size:14px;border-bottom:1px solid $ruleDark;">&nbsp;</div>
      <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%" style="width:100%;border-collapse:collapse;margin-top:12px;mso-table-lspace:0pt;mso-table-rspace:0pt;">
        <tr>
          <td width="31%" style="font-family:$font;font-size:19px;line-height:23px;color:$gold;font-weight:900;mso-line-height-rule:exactly;"><a href="tel:$phoneHref" style="color:$gold;text-decoration:none;">$phoneDisplay</a></td>
          <td width="39%" style="font-family:$font;font-size:13px;line-height:18px;color:#ffffff;font-weight:800;mso-line-height-rule:exactly;"><a href="mailto:$email" style="color:#ffffff;text-decoration:none;">$email</a></td>
          <td width="30%" style="font-family:$font;font-size:13px;line-height:18px;color:#ffffff;font-weight:800;mso-line-height-rule:exactly;"><a href="$websiteHref" style="color:#ffffff;text-decoration:none;">$websiteDisplay</a></td>
        </tr>
      </table>
      <div style="font-family:$font;font-size:10.5px;line-height:15px;color:$mutedOnDark;font-weight:500;mso-line-height-rule:exactly;margin-top:11px;">$companyDetails</div>
    </td>
  </tr>
</table>
"@

$compact = @"
<table role="presentation" cellpadding="0" cellspacing="0" border="0" width="540" style="width:540px;max-width:540px;border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt;font-family:$font;color:$ink;">
  <tr>
    <td width="132" valign="middle" bgcolor="$dark" style="width:132px;background:$dark;padding:15px 16px;border-left:4px solid $gold;">
      <img src="$logoDataUri" width="100" alt="NOVA" style="display:block;width:100px;height:auto;border:0;outline:none;text-decoration:none;">
    </td>
    <td valign="top" bgcolor="$paper" style="background:$paper;padding:13px 17px 12px 17px;border-top:1px solid $rule;border-right:1px solid $rule;border-bottom:1px solid $rule;">
      <div style="font-family:$font;font-size:21px;line-height:24px;color:$ink;font-weight:900;letter-spacing:0;mso-line-height-rule:exactly;">$name</div>
      <div style="font-family:$font;font-size:12px;line-height:17px;color:$gold;font-weight:800;mso-line-height-rule:exactly;">$role</div>
      <div style="font-family:$font;font-size:11px;line-height:16px;color:$ink2;font-weight:600;mso-line-height-rule:exactly;margin-top:5px;">$credentialsCompact</div>
      <div style="font-family:$font;font-size:12.5px;line-height:18px;color:$ink;font-weight:800;mso-line-height-rule:exactly;margin-top:7px;">
        <a href="tel:$phoneHref" style="color:$ink;text-decoration:none;">$phoneDisplay</a>
        <span style="color:$gold;">&nbsp;|&nbsp;</span>
        <a href="mailto:$email" style="color:$ink;text-decoration:none;">$email</a>
        <span style="color:$gold;">&nbsp;|&nbsp;</span>
        <a href="$websiteHref" style="color:$ink;text-decoration:none;">$websiteDisplay</a>
      </div>
    </td>
  </tr>
</table>
"@

$panel = @"
<table role="presentation" cellpadding="0" cellspacing="0" border="0" width="600" style="width:600px;max-width:600px;border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt;font-family:$font;color:$ink;">
  <tr>
    <td colspan="2" bgcolor="$dark" style="background:$dark;padding:16px 20px 14px 20px;border-bottom:3px solid $gold;">
      <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%" style="width:100%;border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt;">
        <tr>
          <td valign="middle"><img src="$logoDataUri" width="112" alt="NOVA" style="display:block;width:112px;height:auto;border:0;outline:none;text-decoration:none;"></td>
          <td valign="middle" align="right" style="font-family:$font;font-size:10px;line-height:14px;color:$gold;font-weight:800;letter-spacing:1.9px;text-transform:uppercase;mso-line-height-rule:exactly;">Roof refurbishment + integrated solar</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td valign="top" bgcolor="$light" style="background:$light;padding:18px 20px 16px 20px;border-left:1px solid $rule;border-bottom:1px solid $rule;">
      <div style="font-family:$font;font-size:23px;line-height:26px;color:$ink;font-weight:900;letter-spacing:0;mso-line-height-rule:exactly;">$name</div>
      <div style="font-family:$font;font-size:13px;line-height:18px;color:$gold;font-weight:800;mso-line-height-rule:exactly;">$role</div>
      <div style="font-family:$font;font-size:12px;line-height:18px;color:$ink2;font-weight:500;mso-line-height-rule:exactly;margin-top:8px;">$credentialsStacked</div>
      <div style="font-family:$font;font-size:10.5px;line-height:15px;color:$muted;font-weight:500;mso-line-height-rule:exactly;margin-top:10px;">$companyDetails</div>
    </td>
    <td width="224" valign="top" bgcolor="$dark2" style="width:224px;background:$dark2;padding:18px 20px 16px 20px;border-right:1px solid $dark2;border-bottom:1px solid $dark2;">
      <div style="font-family:$font;font-size:10px;line-height:14px;color:$gold;font-weight:800;letter-spacing:1.7px;text-transform:uppercase;mso-line-height-rule:exactly;">Call</div>
      <div style="font-family:$font;font-size:20px;line-height:24px;color:#ffffff;font-weight:900;mso-line-height-rule:exactly;margin-bottom:10px;"><a href="tel:$phoneHref" style="color:#ffffff;text-decoration:none;">$phoneDisplay</a></div>
      <div style="font-family:$font;font-size:10px;line-height:14px;color:$gold;font-weight:800;letter-spacing:1.7px;text-transform:uppercase;mso-line-height-rule:exactly;">Email</div>
      <div style="font-family:$font;font-size:13px;line-height:18px;color:#ffffff;font-weight:800;mso-line-height-rule:exactly;margin-bottom:10px;"><a href="mailto:$email" style="color:#ffffff;text-decoration:none;">$email</a></div>
      <div style="font-family:$font;font-size:10px;line-height:14px;color:$gold;font-weight:800;letter-spacing:1.7px;text-transform:uppercase;mso-line-height-rule:exactly;">Website</div>
      <div style="font-family:$font;font-size:13px;line-height:18px;color:#ffffff;font-weight:800;mso-line-height-rule:exactly;"><a href="$websiteHref" style="color:#ffffff;text-decoration:none;">$websiteDisplay</a></div>
    </td>
  </tr>
</table>
"@

New-EmailSignatureFile -Name 'nova-signature-standard.html' -Title 'Nova Email Signature - Standard' -SignatureHtml $standard
New-EmailSignatureFile -Name 'nova-signature-dark.html' -Title 'Nova Email Signature - Dark' -SignatureHtml $darkBlock
New-EmailSignatureFile -Name 'nova-signature-compact.html' -Title 'Nova Email Signature - Compact' -SignatureHtml $compact
New-EmailSignatureFile -Name 'nova-signature-panel.html' -Title 'Nova Email Signature - Panel' -SignatureHtml $panel

Write-Host 'Generated Nova email signature templates:'
Get-ChildItem -LiteralPath $scriptDir -Filter 'nova-signature-*.html' | Sort-Object Name | ForEach-Object {
  Write-Host " - $($_.Name)"
}
