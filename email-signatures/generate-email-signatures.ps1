$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$rootDir = Split-Path -Parent $scriptDir
$logoPath = Join-Path $rootDir 'Nova-Limited-Logo.base64.txt'

if (-not (Test-Path -LiteralPath $logoPath)) {
  throw "Logo base64 file not found: $logoPath"
}

$logoDataUri = 'data:image/png;base64,' + ((Get-Content -Raw -LiteralPath $logoPath).Trim())

$dark = '#0a1628'
$dark2 = '#0f1d33'
$dark3 = '#1a2740'
$gold = '#e8a020'
$light = '#f4f6f9'
$rule = '#e1e5ec'
$muted = '#7a8699'
$font = 'Helvetica Neue, Helvetica, Arial, sans-serif'

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
<table role="presentation" cellpadding="0" cellspacing="0" border="0" width="620" style="width:620px;border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt;font-family:$font;color:$dark;">
  <tr>
    <td width="178" valign="top" bgcolor="$dark" style="width:178px;background:$dark;padding:20px 18px 18px 18px;border-top:4px solid $gold;">
      <img src="$logoDataUri" width="124" alt="NOVA" style="display:block;width:124px;height:auto;border:0;outline:none;text-decoration:none;margin:0 0 22px 0;">
      <div style="font-family:$font;font-size:10px;line-height:14px;letter-spacing:2px;text-transform:uppercase;color:$gold;font-weight:800;mso-line-height-rule:exactly;">Commercial roofing</div>
      <div style="font-family:$font;font-size:10px;line-height:14px;letter-spacing:2px;text-transform:uppercase;color:#ffffff;font-weight:800;mso-line-height-rule:exactly;">Integrated solar</div>
    </td>
    <td valign="top" bgcolor="#ffffff" style="background:#ffffff;padding:18px 22px 16px 22px;border-top:4px solid $gold;border-right:1px solid $rule;border-bottom:1px solid $rule;">
      <div style="font-family:$font;font-size:22px;line-height:25px;color:$dark;font-weight:900;mso-line-height-rule:exactly;">Jamie Gibbs</div>
      <div style="font-family:$font;font-size:13px;line-height:18px;color:$gold;font-weight:800;mso-line-height-rule:exactly;margin-top:2px;">Director, Nova</div>
      <div style="font-family:$font;font-size:12px;line-height:18px;color:$dark;font-weight:500;mso-line-height-rule:exactly;margin-top:10px;">
        22 years in commercial roofing<br>
        Master&rsquo;s in Construction Law and Dispute Resolution<br>
        Former Regional Chair, Institute of Roofing
      </div>
      <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%" style="width:100%;border-collapse:collapse;margin-top:14px;mso-table-lspace:0pt;mso-table-rspace:0pt;">
        <tr>
          <td style="padding:9px 0 0 0;border-top:1px solid $rule;font-family:$font;font-size:11px;line-height:16px;color:$muted;font-weight:800;letter-spacing:1.6px;text-transform:uppercase;mso-line-height-rule:exactly;">Phone</td>
          <td style="padding:9px 0 0 18px;border-top:1px solid $rule;font-family:$font;font-size:11px;line-height:16px;color:$muted;font-weight:800;letter-spacing:1.6px;text-transform:uppercase;mso-line-height-rule:exactly;">Email</td>
          <td style="padding:9px 0 0 18px;border-top:1px solid $rule;font-family:$font;font-size:11px;line-height:16px;color:$muted;font-weight:800;letter-spacing:1.6px;text-transform:uppercase;mso-line-height-rule:exactly;">Website</td>
        </tr>
        <tr>
          <td style="padding:2px 0 0 0;font-family:$font;font-size:14px;line-height:18px;font-weight:900;mso-line-height-rule:exactly;"><a href="tel:+442034792994" style="color:$dark;text-decoration:none;">0203 479 2994</a></td>
          <td style="padding:2px 0 0 18px;font-family:$font;font-size:13px;line-height:18px;font-weight:800;mso-line-height-rule:exactly;"><a href="mailto:jamie@nova-limited.com" style="color:$dark;text-decoration:none;">jamie@nova-limited.com</a></td>
          <td style="padding:2px 0 0 18px;font-family:$font;font-size:13px;line-height:18px;font-weight:800;mso-line-height-rule:exactly;"><a href="https://nova-limited.com" style="color:$dark;text-decoration:none;">nova-limited.com</a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
"@

$darkBlock = @"
<table role="presentation" cellpadding="0" cellspacing="0" border="0" width="620" bgcolor="$dark" style="width:620px;border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt;background:$dark;font-family:$font;color:#ffffff;">
  <tr>
    <td style="padding:22px 24px 18px 24px;border-top:4px solid $gold;">
      <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%" style="width:100%;border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt;">
        <tr>
          <td valign="top" style="padding:0 22px 0 0;">
            <img src="$logoDataUri" width="122" alt="NOVA" style="display:block;width:122px;height:auto;border:0;outline:none;text-decoration:none;">
          </td>
          <td valign="top" align="right" style="padding:0;font-family:$font;font-size:10px;line-height:14px;color:$gold;font-weight:800;letter-spacing:2px;text-transform:uppercase;mso-line-height-rule:exactly;">Financial case<br><span style="color:#ffffff;">Roof + solar</span></td>
        </tr>
      </table>
      <div style="height:16px;line-height:16px;font-size:16px;">&nbsp;</div>
      <div style="font-family:$font;font-size:26px;line-height:30px;color:#ffffff;font-weight:900;mso-line-height-rule:exactly;">Jamie Gibbs</div>
      <div style="font-family:$font;font-size:13px;line-height:18px;color:$gold;font-weight:800;mso-line-height-rule:exactly;">Director, Nova</div>
      <div style="font-family:$font;font-size:12px;line-height:18px;color:#d8dee8;font-weight:500;mso-line-height-rule:exactly;margin-top:8px;">22 years in commercial roofing &nbsp;|&nbsp; Master&rsquo;s in Construction Law and Dispute Resolution &nbsp;|&nbsp; Former Regional Chair, Institute of Roofing</div>
      <div style="height:14px;line-height:14px;font-size:14px;border-bottom:1px solid #2d3a50;">&nbsp;</div>
      <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%" style="width:100%;border-collapse:collapse;margin-top:13px;mso-table-lspace:0pt;mso-table-rspace:0pt;">
        <tr>
          <td width="35%" style="font-family:$font;font-size:19px;line-height:22px;color:$gold;font-weight:900;mso-line-height-rule:exactly;"><a href="tel:+442034792994" style="color:$gold;text-decoration:none;">0203 479 2994</a></td>
          <td width="34%" style="font-family:$font;font-size:13px;line-height:18px;color:#ffffff;font-weight:800;mso-line-height-rule:exactly;"><a href="mailto:jamie@nova-limited.com" style="color:#ffffff;text-decoration:none;">jamie@nova-limited.com</a></td>
          <td width="31%" style="font-family:$font;font-size:13px;line-height:18px;color:#ffffff;font-weight:800;mso-line-height-rule:exactly;"><a href="https://nova-limited.com" style="color:#ffffff;text-decoration:none;">nova-limited.com</a></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
"@

$compact = @"
<table role="presentation" cellpadding="0" cellspacing="0" border="0" width="540" style="width:540px;border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt;font-family:$font;color:$dark;">
  <tr>
    <td width="146" valign="middle" bgcolor="$dark" style="width:146px;background:$dark;padding:16px 16px;border-left:4px solid $gold;">
      <img src="$logoDataUri" width="108" alt="NOVA" style="display:block;width:108px;height:auto;border:0;outline:none;text-decoration:none;">
    </td>
    <td valign="top" bgcolor="#ffffff" style="background:#ffffff;padding:14px 18px;border-top:1px solid $rule;border-right:1px solid $rule;border-bottom:1px solid $rule;">
      <div style="font-family:$font;font-size:21px;line-height:24px;color:$dark;font-weight:900;mso-line-height-rule:exactly;">Jamie Gibbs</div>
      <div style="font-family:$font;font-size:12px;line-height:17px;color:$gold;font-weight:800;mso-line-height-rule:exactly;">Director, Nova</div>
      <div style="font-family:$font;font-size:11px;line-height:16px;color:$muted;font-weight:700;mso-line-height-rule:exactly;margin-top:6px;">22 years commercial roofing | MSc Construction Law | Former Regional Chair, Institute of Roofing</div>
      <div style="font-family:$font;font-size:12.5px;line-height:18px;color:$dark;font-weight:800;mso-line-height-rule:exactly;margin-top:8px;">
        <a href="tel:+442034792994" style="color:$dark;text-decoration:none;">0203 479 2994</a>
        <span style="color:$gold;">&nbsp;|&nbsp;</span>
        <a href="mailto:jamie@nova-limited.com" style="color:$dark;text-decoration:none;">jamie@nova-limited.com</a>
        <span style="color:$gold;">&nbsp;|&nbsp;</span>
        <a href="https://nova-limited.com" style="color:$dark;text-decoration:none;">nova-limited.com</a>
      </div>
    </td>
  </tr>
</table>
"@

$panel = @"
<table role="presentation" cellpadding="0" cellspacing="0" border="0" width="620" style="width:620px;border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt;font-family:$font;color:$dark;">
  <tr>
    <td colspan="2" bgcolor="$dark" style="background:$dark;padding:17px 20px 15px 20px;border-bottom:3px solid $gold;">
      <table role="presentation" cellpadding="0" cellspacing="0" border="0" width="100%" style="width:100%;border-collapse:collapse;mso-table-lspace:0pt;mso-table-rspace:0pt;">
        <tr>
          <td valign="middle"><img src="$logoDataUri" width="116" alt="NOVA" style="display:block;width:116px;height:auto;border:0;outline:none;text-decoration:none;"></td>
          <td valign="middle" align="right" style="font-family:$font;font-size:10px;line-height:14px;color:$gold;font-weight:800;letter-spacing:2px;text-transform:uppercase;mso-line-height-rule:exactly;">Roof refurbishment + integrated solar</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td valign="top" bgcolor="$light" style="background:$light;padding:18px 20px 17px 20px;border-left:1px solid $rule;border-bottom:1px solid $rule;">
      <div style="font-family:$font;font-size:23px;line-height:26px;color:$dark;font-weight:900;mso-line-height-rule:exactly;">Jamie Gibbs</div>
      <div style="font-family:$font;font-size:13px;line-height:18px;color:$gold;font-weight:800;mso-line-height-rule:exactly;">Director, Nova</div>
      <div style="font-family:$font;font-size:12px;line-height:18px;color:$dark;font-weight:500;mso-line-height-rule:exactly;margin-top:9px;">22 years in commercial roofing<br>Master&rsquo;s in Construction Law and Dispute Resolution<br>Former Regional Chair, Institute of Roofing</div>
    </td>
    <td width="225" valign="top" bgcolor="$dark2" style="width:225px;background:$dark2;padding:18px 20px 17px 20px;border-right:1px solid $dark2;border-bottom:1px solid $dark2;">
      <div style="font-family:$font;font-size:10px;line-height:14px;color:$gold;font-weight:800;letter-spacing:1.8px;text-transform:uppercase;mso-line-height-rule:exactly;">Call us</div>
      <div style="font-family:$font;font-size:20px;line-height:24px;color:#ffffff;font-weight:900;mso-line-height-rule:exactly;margin-bottom:10px;"><a href="tel:+442034792994" style="color:#ffffff;text-decoration:none;">0203 479 2994</a></div>
      <div style="font-family:$font;font-size:10px;line-height:14px;color:$gold;font-weight:800;letter-spacing:1.8px;text-transform:uppercase;mso-line-height-rule:exactly;">Email</div>
      <div style="font-family:$font;font-size:13px;line-height:18px;color:#ffffff;font-weight:800;mso-line-height-rule:exactly;margin-bottom:10px;"><a href="mailto:jamie@nova-limited.com" style="color:#ffffff;text-decoration:none;">jamie@nova-limited.com</a></div>
      <div style="font-family:$font;font-size:10px;line-height:14px;color:$gold;font-weight:800;letter-spacing:1.8px;text-transform:uppercase;mso-line-height-rule:exactly;">Website</div>
      <div style="font-family:$font;font-size:13px;line-height:18px;color:#ffffff;font-weight:800;mso-line-height-rule:exactly;"><a href="https://nova-limited.com" style="color:#ffffff;text-decoration:none;">nova-limited.com</a></div>
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
