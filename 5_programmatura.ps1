$output = winget upgrade
$separatorIndex = -1
for ($i = 0; $i -lt $output.Count; $i++) {
    if ($output[$i] -match "^-{3,}") {
        $separatorIndex = $i
        break
    }
}
$count = 0
if ($separatorIndex -gt -1) {
    for ($i = $separatorIndex + 1; $i -lt $output.Count; $i++) {
        if ($output[$i].Trim() -ne "") {
            $count++
        }
    }
}
Write-Host "Sistema ir $count programmas, kuras nepieciesams atjauninat."
