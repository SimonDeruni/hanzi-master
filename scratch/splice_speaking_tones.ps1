# Splices the tone-feedback helpers into the speaking mode's state class.
# Inserted before the class's closing brace (the file's last line).
$ErrorActionPreference = 'Stop'
$target = 'C:\Users\simon\Documents\hanzi_master\lib\features\flashcards\presentation\widgets\modes\speaking_mode.dart'
$blockPath = 'C:\Users\simon\Documents\hanzi_master\scratch\speaking_tone_block.dart.txt'
$utf8 = New-Object System.Text.UTF8Encoding($false)

$text = [System.IO.File]::ReadAllText($target, [System.Text.Encoding]::UTF8)
$block = [System.IO.File]::ReadAllText($blockPath, [System.Text.Encoding]::UTF8)
$block = $block.Replace('// @@NEXT@@', '').TrimEnd()

if ($text.Contains('Widget _buildFeedbackPanel')) {
    'REFUSED: already spliced'
    exit 1
}

# The last non-empty line of the file closes the state class.
$trimmed = $text.TrimEnd()
$lastBrace = $trimmed.LastIndexOf("`n}")
if ($lastBrace -lt 0) {
    'REFUSED: could not locate the class closing brace'
    exit 1
}

$updated = $trimmed.Substring(0, $lastBrace + 1) + $block + "`n}"
$open = ([regex]::Matches($updated, '\{')).Count
$close = ([regex]::Matches($updated, '\}')).Count
if ($open -ne $close) {
    "REFUSED: brace mismatch ($open open / $close close)"
    exit 1
}

[System.IO.File]::WriteAllText($target, $updated + "`n", $utf8)
'SPLICED'
