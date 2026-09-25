# Replaces [ _buildFallbackImage … build() ] in story_summary_screen.dart with the
# book-screen-parity block from scratch/story_summary_block.dart.txt, keeping the
# imports/state above it and _buildKeyWords below it.
$ErrorActionPreference = 'Stop'
$root = 'C:\Users\simon\Documents\hanzi_master'
$screen = Join-Path $root 'lib\features\media\presentation\screens\story_summary_screen.dart'
$block  = Join-Path $root 'scratch\story_summary_block.dart.txt'
$utf8 = New-Object System.Text.UTF8Encoding($false)

$lines = [System.IO.File]::ReadAllLines($screen, [System.Text.Encoding]::UTF8)
$start = -1
$keep  = -1
for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($start -lt 0 -and $lines[$i] -match '^  Widget _buildFallbackImage\(\) \{') { $start = $i }
    if ($lines[$i] -match '^  Widget _buildKeyWords\(StoryState storyState\) \{') { $keep = $i; break }
}
if ($start -lt 0) { throw 'start marker not found' }
if ($keep -lt 0) { throw 'keep marker not found' }
if ($keep -le $start) { throw "markers out of order ($start / $keep)" }

$new = @()
$new += $lines[0..($start - 1)]
$new += [System.IO.File]::ReadAllLines($block, [System.Text.Encoding]::UTF8)
$new += $lines[$keep..($lines.Count - 1)]
[System.IO.File]::WriteAllLines($screen, $new, $utf8)

"replaced lines $($start+1)..$keep with $((Get-Content $block).Count) lines"
"new file length: $((Get-Content $screen).Count) lines"
'--- sanity: mountains references left: ' + ((Select-String -Path $screen -Pattern 'ai_hub_ink_mountains' | Measure-Object).Count)
