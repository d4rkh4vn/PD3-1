$allProcesses = Get-Process
$filteredProcesses = $allProcesses | Where-Object { $_.ProcessName -ne "svchost" }
$sortedProcesses = $filteredProcesses | Sort-Object -Property WorkingSet64 -Descending
$top5 = $sortedProcesses | Select-Object -First 5
$totalBytes = ($top5 | Measure-Object -Property WorkingSet64 -Sum).Sum
$totalMB = $totalBytes / 1MB
Write-Host ("Top 5 procesu total RAM: {0:N1} MB" -f $totalMB)