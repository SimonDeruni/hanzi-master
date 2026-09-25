# Localizes the hardcoded swipe-grade hint in the four study-mode widgets.
# ASCII-only source: the arrow glyphs are built from code points so the script
# itself never depends on the file's encoding.
$ErrorActionPreference = 'Stop'
$root = 'C:\Users\simon\Documents\hanzi_master'
$utf8 = New-Object System.Text.UTF8Encoding($false)

$arrowLeft = [char]::ConvertFromUtf32(0x2B05) + [char]0xFE0F
$arrowRight = [char]::ConvertFromUtf32(0x27A1) + [char]0xFE0F
$arrowUp = [char]::ConvertFromUtf32(0x2B06) + [char]0xFE0F
$arrowDown = [char]::ConvertFromUtf32(0x2B07) + [char]0xFE0F

$entries = @(
    $arrowLeft + ' ${AppLocalizations.of(context)!.again}',
    $arrowRight + ' ${AppLocalizations.of(context)!.good}',
    $arrowUp + ' ${AppLocalizations.of(context)!.easy}',
    $arrowDown + ' ${AppLocalizations.of(context)!.hard}'
)
$replacement = "'" + ($entries -join '    ') + "'"

$report = @()
foreach ($name in @('reading_mode', 'listening_mode', 'recall_mode', 'speaking_mode')) {
    $path = Join-Path $root "lib\features\flashcards\presentation\widgets\modes\$name.dart"
    $text = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
    if ($text.Contains('swipeToGrade')) { $report += "$name : already localized"; continue }

    $updated = $text.Replace('"Swipe to Grade:"', 'AppLocalizations.of(context)!.swipeToGrade')
    # The direction line is the only quoted literal holding both words.
    $updated = [regex]::Replace(
        $updated,
        '"[^"]{0,20}Again[^"]{0,80}Hard"',
        [System.Text.RegularExpressions.MatchEvaluator] { param($m) $replacement },
        1
    )

    if ($updated -eq $text) { $report += "$name : NO MATCH"; continue }
    if ($updated.Contains('"Swipe to Grade:"') -or $updated.Contains('Again    ')) {
        $report += "$name : REFUSED (leftover English)"; continue
    }
    $open = ([regex]::Matches($updated, '\{')).Count
    $close = ([regex]::Matches($updated, '\}')).Count
    if ($open -ne $close) { $report += "$name : REFUSED (brace mismatch)"; continue }

    [System.IO.File]::WriteAllText($path, $updated, $utf8)
    $report += "$name : localized"
}
$report -join "`n"
