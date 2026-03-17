$logPath = Join-Path ([Environment]::GetFolderPath("MyDocuments")) "Apkope.log"
$drive = Get-PSDrive -Name C
$freeSpaceGB = [math]::Round($drive.Free / 1GB, 2)
$totalSpaceGB = [math]::Round(($drive.Used + $drive.Free) / 1GB, 2)
$freePercent = ($drive.Free / ($drive.Used + $drive.Free)) * 100
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
if ($freePercent -lt 25) {
    # Record free space before cleaning
    $beforeFree = $drive.Free
    Write-Host "Cleaning TEMP folder..."
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    try {
        Clear-RecycleBin -Force -ErrorAction Stop
        Write-Host "Recycle Bin cleared."
    }
    catch {
        Write-Host "Could not clear Recycle Bin. Run as administrator if needed."
    }
    # Refresh drive info and calculate freed space
    $drive = Get-PSDrive -Name C
    $afterFree = $drive.Free
    $freedBytes = $afterFree - $beforeFree
    $freedGB = [math]::Round($freedBytes / 1GB, 2)
    "$timestamp Tirīšana veikta. Atbrīvoti $freedGB GB." | Out-File -FilePath $logPath -Append -Encoding UTF8
}
else {
    "$timestamp Vieta pietiekama." | Out-File -FilePath $logPath -Append -Encoding UTF8
}