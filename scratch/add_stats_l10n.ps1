# Inserts the deck-statistics keys into every locale .arb, before the final brace.
$ErrorActionPreference = 'Stop'
$root = 'C:\Users\simon\Documents\hanzi_master'
$keys = Get-Content (Join-Path $root 'scratch\stats_l10n.json') -Raw -Encoding UTF8 |
    ConvertFrom-Json
$utf8 = New-Object System.Text.UTF8Encoding($false)
$report = @()

foreach ($locale in $keys.PSObject.Properties.Name) {
    $path = Join-Path $root "lib\l10n\app_$locale.arb"
    if (-not (Test-Path $path)) { $report += "$locale : MISSING FILE"; continue }
    $text = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
    if ($text.Contains('"trickyCharacters"')) { $report += "$locale : already present"; continue }

    $values = $keys.$locale
    $pairs = @(
        ('"trickyCharacters": ' + (ConvertTo-Json $values.trickyCharacters -Compress)),
        ('"strongestCharacters": ' + (ConvertTo-Json $values.strongestCharacters -Compress)),
        ('"newThisWeek": ' + (ConvertTo-Json $values.newThisWeek -Compress)),
        ('"averageAttemptsPerWord": ' + (ConvertTo-Json $values.averageAttemptsPerWord -Compress)),
        ('"noCardsYet": ' + (ConvertTo-Json $values.noCardsYet -Compress))
    )
    $index = $text.LastIndexOf('}')
    $before = $text.Substring(0, $index).TrimEnd()
    $updated = $before + ",`r`n  " + ($pairs -join ",`r`n  ") + "`r`n}" + $text.Substring($index + 1)

    # Fragment + brace validation only: the files legitimately contain keys that
    # differ by case, which case-insensitive JSON parsers refuse.
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
