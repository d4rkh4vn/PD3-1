$documentsPath = [Environment]::GetFolderPath("MyDocuments")
$outputFile = Join-Path $documentsPath "Errors.txt"
$sevenDaysAgo = (Get-Date).AddDays(-7)
$errors = Get-EventLog -LogName System -EntryType Error -After $sevenDaysAgo
$errorCount = $errors.Count
if ($errorcount -gt 10) {
$header = "[KRITISKI] Sistēma ir nestabila!"
} else {
$header = "[OK] Kļūdu līmenis normāls."
}
$header | Out-File -FilePath $outputFile -Encoding UTF8
"" | Out-File -FilePath $outputFile -Append -Encoding UTF8
if ($errorCount -gt 0) {
foreach ($err in $errors) {
$line = "$($err.TimeGenerated): $($err.Message)"
$line = | Out-File -FilePath $outputFile -Append -Encoding UTF8
} else {
"Nav kļūdu." | Out-File -FilePath $outputFile -Append -Encoding UTF8
}
