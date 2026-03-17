$documentsPath = [Environment]::GetFolderPath("MyDocuments")
$sourceFile = Join-Path $documentsPath "Errors.txt"
$date = Get-Date -Format "yyyy-MM-dd"
$archiveName = "Atskaite_$date.zip"
$archivePath = Join-Path $documentsPath $archiveName
if (Test-Path $sourceFile) {
    Compress-Archive -Path $sourceFile -DestinationPath $archivePath -Force
    $fileSizeBytes = (Get-Item $archivePath).Length
    $fileSizeKB = $fileSizeBytes / 1KB
    Write-Host ("Arhiva izmers: {0:N2} KB" -f $fileSizeKB)
} else {
    Write-Host "Errors.txt nav atrasts!" -ForegroundColor Red
}