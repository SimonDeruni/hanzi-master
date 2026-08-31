# PowerShell script to run the translation tool
Write-Host "Starting translation process in background..."
Write-Host "Log file: C:\Users\simon\Documents\hanzi_master\translation_log.txt"

$job = Start-Job -ScriptBlock {
    Set-Location "C:\Users\simon\Documents\hanzi_master"
    dart run tool/translate_all_localizations.dart 2>&1
}

# Wait up to 4 hours
$result = Wait-Job $job -Timeout 14400

if ($result -eq $null) {
    Write-Host "Job still running. Check status with: Get-Job"
} else {
    $output = Receive-Job $job
    $output | Out-File -FilePath "C:\Users\simon\Documents\hanzi_master\translation_log.txt"
    Write-Host "Translation complete! Log saved to translation_log.txt"
    $output
}

Write-Host "Job status: $($job.State)"