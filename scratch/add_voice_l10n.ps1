# Inserts the voice-picker keys into every locale .arb, before the final brace.
# Reads values from scratch/voice_l10n_keys.json so no non-ASCII text has to
# survive a console round-trip.
$ErrorActionPreference = 'Stop'
$root = 'C:\Users\simon\Documents\hanzi_master'
$keys = Get-Content (Join-Path $root 'scratch\voice_l10n_keys.json') -Raw -Encoding UTF8 |
    ConvertFrom-Json
$utf8 = New-Object System.Text.UTF8Encoding($false)
$report = @()

foreach ($locale in $keys.PSObject.Properties.Name) {
    $path = Join-Path $root "lib\l10n\app_$locale.arb"
    if (-not (Test-Path $path)) { $report += "$locale : MISSING FILE"; continue }
    $text = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
    if ($text.Contains('"tapToHearVoiceSample"')) { $report += "$locale : already present"; continue }

    $values = $keys.$locale
    $insert = (@(
        '"tapToHearVoiceSample": ' + (ConvertTo-Json $values.tapToHearVoiceSample -Compress),
        '"soundEffects": ' + (ConvertTo-Json $values.soundEffects -Compress),
        '"soundEffectsDesc": ' + (ConvertTo-Json $values.soundEffectsDesc -Compress)
    ) -join ",`r`n  ")
    # ConvertTo-Json escapes the arrow as \u25b6; keep it literal for readability.
    $insert = $insert -replace '\\u25b6', ([char]0x25B6)

    # The files end with:  "dictionarySearchFailed": "..." \n }
    $index = $text.LastIndexOf('}')
    $updated = $text.Substring(0, $index) + '  ' + $insert + "`r`n}" + $text.Substring($index + 1)
    [System.IO.File]::WriteAllText($path, $updated, $utf8)
    $report += "$locale : inserted"
}
$report -join "`n"
