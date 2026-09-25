# Inserts the deck-picker keys into every locale .arb, before the final brace.
# Values come from a UTF-8 JSON file so no non-ASCII text has to survive a
# console round-trip. The generated JSON is validated before anything is written.
$ErrorActionPreference = 'Stop'
$root = 'C:\Users\simon\Documents\hanzi_master'
$keys = Get-Content (Join-Path $root 'scratch\deck_picker_l10n.json') -Raw -Encoding UTF8 |
    ConvertFrom-Json
$utf8 = New-Object System.Text.UTF8Encoding($false)
$report = @()

foreach ($locale in $keys.PSObject.Properties.Name) {
    $path = Join-Path $root "lib\l10n\app_$locale.arb"
    if (-not (Test-Path $path)) { $report += "$locale : MISSING FILE"; continue }
    $text = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
    if ($text.Contains('"generatingYourScenario"')) { $report += "$locale : already present"; continue }

    $values = $keys.$locale
    $pairs = @(
        ('"generatingYourScenario": ' + (ConvertTo-Json $values.generatingYourScenario -Compress)),
        ('"failedToGenerateScenario": ' + (ConvertTo-Json $values.failedToGenerateScenario -Compress))
    )
    # The previous file ends with:  "someKey": "..." \n }  -> add a comma, then the pairs.
    $index = $text.LastIndexOf('}')
    $before = $text.Substring(0, $index).TrimEnd()
    $updated = $before + ",`r`n  " + ($pairs -join ",`r`n  ") + "`r`n}" + $text.Substring($index + 1)

    # Validate the fragment we are about to append. The whole-file check cannot be
    # used here: the .arb files already contain keys that differ only by case
    # (`linGdp6`/`lingdp6`), which .NET's case-insensitive JSON parser rejects even
    # though they are valid JSON and `flutter gen-l10n` accepts them.
    try {
        $null = ('{' + ($pairs -join ',') + '}') | ConvertFrom-Json
    } catch {
        $report += "$locale : REFUSED (fragment is not valid JSON)"
        continue
    }
    if (([regex]::Matches($updated, '\{')).Count -ne ([regex]::Matches($updated, '\}')).Count) {
        $report += "$locale : REFUSED (brace mismatch)"
        continue
    }
    [System.IO.File]::WriteAllText($path, $updated, $utf8)
    $report += "$locale : inserted"
}
$report -join "`n"
