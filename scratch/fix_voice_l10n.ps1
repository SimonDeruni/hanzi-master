# Repairs the malformed tail written by add_voice_l10n.ps1:
#   "dictionarySearchFailed": "..."      <- missing comma
#   "tapToHear...": "..." "soundEffects": "..." "soundEffectsDesc": "..."
# becomes three properly separated, comma-terminated lines before the final brace.
$ErrorActionPreference = 'Stop'
$root = 'C:\Users\simon\Documents\hanzi_master'
$utf8 = New-Object System.Text.UTF8Encoding($false)
$report = @()

foreach ($file in Get-ChildItem (Join-Path $root 'lib\l10n') -Filter 'app_*.arb') {
    $text = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)

    $pattern = '("dictionarySearchFailed":\s*"[^"\r\n]*")\s*\r?\n\s*' +
               '("tapToHearVoiceSample":\s*"[^"\r\n]*")\s+' +
               '("soundEffects":\s*"[^"\r\n]*")\s+' +
               '("soundEffectsDesc":\s*"[^"\r\n]*")\s*\r?\n\}'
    $fixed = [System.Text.RegularExpressions.Regex]::Replace(
        $text, $pattern,
        { param($m) "$($m.Groups[1].Value),`r`n  $($m.Groups[2].Value),`r`n  $($m.Groups[3].Value),`r`n  $($m.Groups[4].Value)`r`n}" },
        [System.Text.RegularExpressions.RegexOptions]::Singleline)

    if ($fixed -ne $text) {
        [System.IO.File]::WriteAllText($file.FullName, $fixed, $utf8)
        $report += "$($file.Name) : repaired"
    } else {
        $report += "$($file.Name) : no match (check manually)"
    }
}
$report -join "`n"

'--- JSON validation ---'
foreach ($file in Get-ChildItem (Join-Path $root 'lib\l10n') -Filter 'app_*.arb') {
    try {
        $null = (Get-Content $file.FullName -Raw -Encoding UTF8 | ConvertFrom-Json)
        "OK   $($file.Name)"
    } catch {
        "FAIL $($file.Name)"
    }
}
