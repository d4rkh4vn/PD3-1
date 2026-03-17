$jsonOutput = winget upgrade --output json --accept-source-agreements 2>$null
$updates = $jsonOutput | ConvertFrom-Json
$updateCount = $updates.Count
Write-Host "Sistema ir $updateCount programmas, kuras nepieciesams atjauninat."