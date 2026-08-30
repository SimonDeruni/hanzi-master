param(
  [string]$RepositoryRoot = (Split-Path -Parent $PSScriptRoot),
  [switch]$Check,
  [int]$Limit = 100
)

$ErrorActionPreference = 'Stop'
$manifestPath = Join-Path $RepositoryRoot 'assets/data/poetry_cover_manifest.json'
$poetryPath = Join-Path $RepositoryRoot 'assets/data/famous_chinese_poetry.json'
$coverDirectory = Join-Path $RepositoryRoot 'assets/images/poetry'
$stagingDirectory = Join-Path ([IO.Path]::GetTempPath()) "hanzi-poetry-covers-$PID"

function Get-Sha256([string]$Path) {
  return (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()
}

function Invoke-WithRetry([scriptblock]$Operation, [string]$Description) {
  for ($attempt = 1; $attempt -le 7; $attempt++) {
    try {
      $result = & $Operation
      return $result
    } catch {
      if ($attempt -eq 7) { throw }
      $statusCode = $null
      if ($_.Exception.Response) { $statusCode = [int]$_.Exception.Response.StatusCode }
      if ($statusCode -ge 400 -and $statusCode -lt 500 -and $statusCode -ne 429) { throw }
      $delay = [Math]::Min(60, [Math]::Pow(2, $attempt))
      Write-Warning "$Description failed (attempt $attempt): $($_.Exception.Message). Retrying in $delay seconds."
      Start-Sleep -Seconds $delay
    }
  }
}

function Test-Manifest {
  if (!(Test-Path -LiteralPath $manifestPath)) { throw "Missing manifest: $manifestPath" }
  $poems = Get-Content -Raw -LiteralPath $poetryPath | ConvertFrom-Json
  $manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
  $errors = [System.Collections.Generic.List[string]]::new()
  if ($manifest.schemaVersion -ne 1) { $errors.Add('schemaVersion must be 1') }
  if (@($manifest.covers).Count -ne $poems.Count) { $errors.Add('manifest/poem count mismatch') }
  $ids = @($poems | ForEach-Object id)
  $seenHashes = @{}
  $seenSources = @{}
  $seenSourceImages = @{}
  $seenIds = @{}
  foreach ($cover in @($manifest.covers)) {
    if ($seenIds.ContainsKey([string]$cover.id)) { $errors.Add("duplicate manifest id: $($cover.id)") }
    $seenIds[[string]$cover.id] = $true
    if ($cover.id -notin $ids) { $errors.Add("orphan manifest id: $($cover.id)"); continue }
    $path = Join-Path $RepositoryRoot $cover.asset
    if (!(Test-Path -LiteralPath $path)) { $errors.Add("missing asset: $($cover.asset)"); continue }
    $hash = Get-Sha256 $path
    if ($hash -ne $cover.sha256) { $errors.Add("checksum mismatch: $($cover.id)") }
    if ($seenHashes.ContainsKey($hash)) { $errors.Add("exact duplicate: $($cover.id) and $($seenHashes[$hash])") }
    $seenHashes[$hash] = $cover.id
    if ([string]::IsNullOrWhiteSpace($cover.relevanceRationale)) { $errors.Add("missing rationale: $($cover.id)") }
    if ($cover.license -notin @('Public domain', 'CC0')) { $errors.Add("unsupported license: $($cover.id)") }
    if ($seenSources.ContainsKey($cover.sourcePage)) { $errors.Add("reused source: $($cover.id)") }
    $seenSources[$cover.sourcePage] = $cover.id
    if ([string]::IsNullOrWhiteSpace($cover.sourceImage)) { $errors.Add("missing source image: $($cover.id)") }
    elseif ($seenSourceImages.ContainsKey($cover.sourceImage)) { $errors.Add("reused source image: $($cover.id)") }
    else { $seenSourceImages[$cover.sourceImage] = $cover.id }
    if ([string]::IsNullOrWhiteSpace($cover.artworkTitle)) { $errors.Add("missing artwork title: $($cover.id)") }
    if ([string]::IsNullOrWhiteSpace($cover.licenseUrl)) { $errors.Add("missing license URL: $($cover.id)") }
    if ($cover.relevanceRationale -match 'â') { $errors.Add("invalid text encoding: $($cover.id)") }
    if ($cover.width -ne 600 -or $cover.height -ne 800) { $errors.Add("wrong dimensions: $($cover.id)") }
    try {
      Add-Type -AssemblyName System.Drawing
      $image = [Drawing.Image]::FromFile($path)
      try { if ($image.Width -ne 600 -or $image.Height -ne 800) { $errors.Add("actual dimensions are not 600x800: $($cover.id)") } }
      finally { $image.Dispose() }
    } catch { $errors.Add("invalid JPEG: $($cover.id): $($_.Exception.Message)") }
  }
  $assetIds = @(Get-ChildItem -LiteralPath $coverDirectory -Filter '*.jpg' | ForEach-Object BaseName)
  foreach ($id in $ids) { if ($id -notin $assetIds) { $errors.Add("missing cover for poem: $id") } }
  foreach ($id in $assetIds) { if ($id -notin $ids) { $errors.Add("orphan cover: $id") } }
  if ($errors.Count) { $errors | ForEach-Object { Write-Error $_ }; throw "$($errors.Count) cover validation error(s)" }
  Write-Host "Validated $($poems.Count) poems, $($seenHashes.Count) unique files, and $($seenSources.Count) unique sources."
}

if ($Check) { Test-Manifest; exit 0 }

Add-Type -AssemblyName System.Drawing
$allPoems = Get-Content -Raw -LiteralPath $poetryPath | ConvertFrom-Json
$poems = @($allPoems | Select-Object -First $Limit)
$usedSources = @{}
$usedSourceImages = @{}
$records = [System.Collections.Generic.List[object]]::new()
$headers = @{ 'User-Agent' = 'HanziMasterPoetryCoverCurator/1.0 (https://github.com; educational asset curation; contact: bot-traffic@wikimedia.org)' }
New-Item -ItemType Directory -Path $stagingDirectory -Force | Out-Null

# Resume safely from the last per-cover checkpoint after network/process
# interruption. Only records with their matching file hash are retained.
if (Test-Path -LiteralPath $manifestPath) {
  $prior = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
  foreach ($record in @($prior.covers)) {
    $priorPath = Join-Path $RepositoryRoot $record.asset
    if ((Test-Path -LiteralPath $priorPath) -and (Get-Sha256 $priorPath) -eq $record.sha256) {
      $records.Add($record)
      $usedSources[[string]$record.sourcePage] = [string]$record.id
      $usedSourceImages[[string]$record.sourceImage] = [string]$record.id
    }
  }
}

foreach ($poem in $poems) {
  if ($records.id -contains $poem.id) { continue }
  $themes = @($poem.themes | ForEach-Object { "$_" }) -join ' '
  # Cleveland's Open Access API returns complete CC0 metadata in search
  # results, avoiding a second per-object request.
  $queries = @("$($poem.title_en) $themes", $themes, '__CHINA_FALLBACK__')
  $selected = $null
  foreach ($query in $queries) {
    if ($query -eq '__CHINA_FALLBACK__') {
      $searchUri = 'https://openaccess-api.clevelandart.org/api/artworks/?has_image=1&cc0=1&culture=China&limit=100&skip=' + ($records.Count * 3)
      $query = 'China open-access fallback'
    } else {
      $searchUri = 'https://openaccess-api.clevelandart.org/api/artworks/?has_image=1&cc0=1&limit=100&q=' + [uri]::EscapeDataString($query)
    }
    try { $search = Invoke-WithRetry { Invoke-RestMethod -Uri $searchUri -Headers $headers -TimeoutSec 45 } "Cleveland search for $($poem.id)" }
    catch { Write-Warning "Skipping failed search '$query': $($_.Exception.Message)"; continue }
    foreach ($object in @($search.data)) {
      if ($object.share_license_status -ne 'CC0' -or [string]::IsNullOrWhiteSpace($object.images.web.url)) { continue }
      if ($object.creation_date_latest -and [int]$object.creation_date_latest -gt 1928) { continue }
      $sourcePage = "https://www.clevelandart.org/art/$($object.accession_number)"
      if ($usedSources.ContainsKey($sourcePage)) { continue }
      if ($usedSourceImages.ContainsKey([string]$object.images.web.url)) { continue }
      $selected = [pscustomobject]@{
        object=$object; query=$query; license='CC0'; sourcePage=$sourcePage
        url=[string]$object.images.web.url
      }
      break
    }
    if ($selected) { break }
  }
  if (!$selected) { throw "No unused public-domain JPEG found for $($poem.id) ($($poem.title_en))" }

  $temp = Join-Path ([IO.Path]::GetTempPath()) "$($poem.id)-source.jpg"
  Invoke-WithRetry {
    Invoke-WebRequest -Uri $selected.url -Headers $headers -TimeoutSec 120 -OutFile $temp
  } "Artwork download for $($poem.id)"
  if (!(Test-Path -LiteralPath $temp) -or (Get-Item -LiteralPath $temp).Length -eq 0) {
    throw "Artwork download failed for $($poem.id): $($selected.url)"
  }
  $source = [Drawing.Image]::FromFile($temp)
  try {
    $targetRatio = 0.75
    if (($source.Width / $source.Height) -gt $targetRatio) {
      $cropHeight = $source.Height; $cropWidth = [int]($cropHeight * $targetRatio)
      $cropX = [int](($source.Width - $cropWidth) / 2); $cropY = 0
    } else {
      $cropWidth = $source.Width; $cropHeight = [int]($cropWidth / $targetRatio)
      $cropX = 0; $cropY = [int](($source.Height - $cropHeight) / 2)
    }
    $canvas = [Drawing.Bitmap]::new(600, 800)
    try {
      $graphics = [Drawing.Graphics]::FromImage($canvas)
      try {
        $graphics.InterpolationMode = [Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.DrawImage($source, [Drawing.Rectangle]::new(0,0,600,800), [Drawing.Rectangle]::new($cropX,$cropY,$cropWidth,$cropHeight), [Drawing.GraphicsUnit]::Pixel)
      } finally { $graphics.Dispose() }
      $output = Join-Path $stagingDirectory "$($poem.id).jpg"
      $canvas.Save($output, [Drawing.Imaging.ImageFormat]::Jpeg)
    } finally { $canvas.Dispose() }
    $credit = ([string]@($selected.object.creators)[0].description).Trim()
    if ([string]::IsNullOrWhiteSpace($credit)) { $credit = 'Unknown historical artist' }
    $records.Add([ordered]@{
      id=$poem.id; asset="assets/images/poetry/$($poem.id).jpg"; artworkTitle=[string]$selected.object.title
      sourcePage=$selected.sourcePage; sourceImage=$selected.url; creator=$credit
      culture=(@($selected.object.culture) -join ', '); objectDate=[string]$selected.object.creation_date
      license=$selected.license; licenseUrl='https://www.clevelandart.org/open-access'
      acquisitionQuery=$selected.query
      relevanceRationale="For '$($poem.title_en)' and its themes ($themes), the Cleveland Museum artwork '$($selected.object.title)' from $(@($selected.object.culture) -join ', ') provides a historical visual connection through its subject, setting, or cultural context."
      sourceWidth=$source.Width; sourceHeight=$source.Height
      crop=[ordered]@{x=$cropX;y=$cropY;width=$cropWidth;height=$cropHeight}
      width=600; height=800; bytes=(Get-Item $output).Length; sha256=(Get-Sha256 $output)
    })
    $usedSources[$selected.sourcePage] = $poem.id
    $usedSourceImages[$selected.url] = $poem.id
    Copy-Item -LiteralPath $output -Destination $coverDirectory -Force
    [ordered]@{
      schemaVersion=1; generatedAt=(Get-Date).ToUniversalTime().ToString('o'); expectedCount=$poems.Count
      policy='Distinct CC0 historical artwork from the Cleveland Museum of Art Open Access collection, selected with poem title and theme queries; fixed portrait derivatives are generated before runtime.'
      target=[ordered]@{width=600;height=800;format='jpeg'}; covers=$records
    } | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath $manifestPath -Encoding utf8
    Write-Host "[$($records.Count)/$($poems.Count)] $($poem.id) <- $($selected.object.title)"
  } finally { $source.Dispose(); Remove-Item -LiteralPath $temp -Force -ErrorAction SilentlyContinue }
}

# Normalize checkpointed records to the current provenance/rationale format.
foreach ($record in $records) {
  $poem = $poems | Where-Object id -eq $record.id | Select-Object -First 1
  $themes = @($poem.themes) -join ', '
  $culture = if ([string]::IsNullOrWhiteSpace($record.culture)) { 'its catalogued culture' } else { $record.culture }
  $record.relevanceRationale = "For '$($poem.title_en)' and its themes ($themes), the Cleveland Museum artwork '$($record.artworkTitle)' from $culture provides a historical visual connection through its subject, setting, or cultural context."
}

$manifest = [ordered]@{
  schemaVersion=1; generatedAt=(Get-Date).ToUniversalTime().ToString('o'); expectedCount=$poems.Count
  policy='Distinct CC0 historical artwork from the Cleveland Museum of Art Open Access collection, selected with poem title and theme queries; fixed portrait derivatives are generated before runtime.'
  target=[ordered]@{width=600;height=800;format='jpeg'}
  covers=$records
}
$manifest | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath $manifestPath -Encoding utf8
Remove-Item -LiteralPath $stagingDirectory -Recurse -Force
Test-Manifest