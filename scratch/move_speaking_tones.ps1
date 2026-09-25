# Moves the tone-feedback block out of speaking_mode.dart into the new panel
# widget (it was spliced in moments ago; this removes it again in one clean cut).
$ErrorActionPreference = 'Stop'
$target = 'C:\Users\simon\Documents\hanzi_master\lib\features\flashcards\presentation\widgets\modes\speaking_mode.dart'
$utf8 = New-Object System.Text.UTF8Encoding($false)

$text = [System.IO.File]::ReadAllText($target, [System.Text.Encoding]::UTF8)
# Built from code points so this script stays ASCII-only (PowerShell reads .ps1
# as ANSI without a BOM, which mangles box-drawing characters).
$dash = [char]0x2500
$startMarker = "  // $dash$dash Tone feedback"
$start = $text.IndexOf($startMarker)
$endMarker = '  /// The tones of the word, one pill per syllable'
$end = $text.IndexOf($endMarker)
if ($start -lt 0 -or $end -lt 0 -or $end -le $start) {
    'REFUSED: could not locate the tone feedback block'
    exit 1
}

$updated = $text.Substring(0, $start) + $text.Substring($end)
$open = ([regex]::Matches($updated, '\{')).Count
$close = ([regex]::Matches($updated, '\}')).Count
if ($open -ne $close) {
    "REFUSED: brace mismatch ($open open / $close close)"
    exit 1
}
if ($updated.Contains('Widget _buildFeedbackPanel')) {
    'REFUSED: the block is still present'
    exit 1
}

[System.IO.File]::WriteAllText($target, $updated, $utf8)
'REMOVED'
