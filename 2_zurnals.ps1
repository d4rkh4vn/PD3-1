$documentsPath = [Environment]::GetFolderPath("MyDocuments")
$outputFile = "$documentsPath\Errors.txt"
$sevenDaysAgo = (Get-Date).AddDays(-7)
$errors = Get-EventLog -LogName System -EntryType Error -After $sevenDaysAgo
$errorCount = $errors.Count
"" | Out-File -FilePath $outputFile -Encoding UTF8
if ($errorCount -gt 10) {
"[KRITISKI] Sistema ir nestabila!" | Out-File -FilePath $outputFile -Append -Encoding UTF8
} else {
"[OK] Kludu limenis normalss." | Out-File -FilePath $outputFile -Append -Encoding UTF8
}
"" | Out-File -FilePath $outputFile -Append -Encoding UTF8
if ($errorCount -gt 0) {
foreach ($e in $errors) {
$time = $e.TimeGenerated
$msg = $e.Message
"$time : $msg" | Out-File -FilePath $outputFile -Append -Encoding UTF8
}
} else {
"Nav kludu." | Out-File -FilePath $outputFile -Append -Encoding UTF8
}
