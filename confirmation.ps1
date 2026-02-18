Write-Host "This script will:" -F Yellow
Write-Host "1. Activate Windows (Using MAS)"
Write-Host "2. Install essential programs using winget (Type 'i' for info)"
Write-Host "3. Install a basic powershell profile with fastfetch"
Write-Host "4. Debloat Windows (using Chris Titus' debloat script)"

$choice = Read-Host "Do you want to proceed? (y/n/i)"

if ($choice -eq 'i') {
    irm https://raw.githubusercontent.com/ShadowElixir/PostInstall/refs/heads/main/List.md
    $choice = Read-Host "Ready to run now? (y/n)"
}

if ($choice -eq 'y') {
    Write-Host "Starting PostInstall..." -F Green
    irm https://cutt.ly/postinstall | iex
} 
else {
    Write-Host "Cancelled." -F Red
}
