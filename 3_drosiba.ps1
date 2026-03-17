$status = Get-MpComputerStatus
$realTimeOn = $status.RealTimeProtectionEnabled
$daysSinceQuickScan = $status.QuickScanAge
if ( ($realTimeOn -eq $false) -or ($daysSinceQuickScan -gt 3) ) {
Write-Host "Sistema ir apdraudeta!" -ForegroundColor Red
} else {
Write-Host "Sistema ir drosa." -ForegroundColor Green
}
