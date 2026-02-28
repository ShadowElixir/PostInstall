# User Choices
$onlyoffice = Read-Host "Would you like to install OnlyOffice? (y/n)"
$store = Read-Host "Would you like to keep the Microsoft Store? (y/n)"
$xbox = Read-Host "Would you like to keep Xbox components? (y/n)"

# Windows Activation (credit: massgravel)
Write-Host "Activating Windows..."
irm https://raw.githubusercontent.com/ShadowElixir/VariousScripts/refs/heads/main/scripts/act.ps1 | iex

# Install WinGet if not installed
Write-Host "Installing WinGet..."
Install-PackageProvider -Name NuGet -Force
Install-Module -Name Microsoft.WinGet.Client -Repository PSGallery -Force
Repair-WinGetPackageManager -AllUsers

# Essential programs
Write-Host "Installing Programs..."
winget install Romanitho.Winget-AutoUpdate --accept-package-agreements --accept-source-agreements
irm https://raw.githubusercontent.com/ShadowElixir/PostInstall/refs/heads/main/files/Romanitho.Winget-AutoUpdate-installed.ps1 | Out-File "C:\Program Files\Winget-AutoUpdate\mods\Romanitho.Winget-AutoUpdate-installed.ps1"
irm https://raw.githubusercontent.com/ShadowElixir/PostInstall/refs/heads/main/files/Romanitho.Winget-AutoUpdate-installed.ps1 | iex
winget install Fastfetch-cli.Fastfetch --accept-package-agreements --accept-source-agreements
winget install yt-dlp.yt-dlp --accept-package-agreements --accept-source-agreements
winget install Notepad++.Notepad++ --accept-package-agreements --accept-source-agreements
winget install jurplel.qView --accept-package-agreements --accept-source-agreements
winget install CodecGuide.K-LiteCodecPack.Mega --accept-package-agreements --accept-source-agreements
winget install amir1376.ABDownloadManager --accept-package-agreements --accept-source-agreements
winget install 7zip.7zip --accept-package-agreements --accept-source-agreements
winget install LibreWolf.LibreWolf --accept-package-agreements --accept-source-agreements
winget install Brave.Brave --accept-package-agreements --accept-source-agreements
winget install OBSProject.OBSStudio --accept-package-agreements --accept-source-agreements
winget install SumatraPDF.SumatraPDF --accept-package-agreements --accept-source-agreements
winget install qBittorrent.qBittorrent --accept-package-agreements --accept-source-agreements
winget install Klocman.BulkCrapUninstaller --accept-package-agreements --accept-source-agreements
winget install AdrienAllard.FileConverter --accept-package-agreements --accept-source-agreements
winget install Microsoft.Sysinternals.Autoruns --accept-package-agreements --accept-source-agreements
winget install Git.Git --accept-package-agreements --accept-source-agreements
winget install Betterbird.Betterbird --accept-package-agreements --accept-source-agreements
winget install zhongyang219.TrafficMonitor.Lite --accept-package-agreements --accept-source-agreements

# OnlyOffice
if ($onlyoffice -eq 'y') {
    Write-Host "Installing OnlyOffice using WinGet..." -F Green
    winget install ONLYOFFICE.DesktopEditors --accept-package-agreements --accept-source-agreements
} 
else {
    Write-Host "Skipped OnlyOffice installation." -F Red
}

# Install basic PowerShell profile
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force
New-Item $env:userprofile\Documents\WindowsPowerShell -ItemType Directory
irm https://raw.githubusercontent.com/ShadowElixir/PostInstall/refs/heads/main/files/profile.ps1 >> $PROFILE

# Debloat script (credit: christitustech)
Write-Host "Debloating Windows..."
& ([ScriptBlock]::Create((irm "https://christitus.com/win"))) -Config https://raw.githubusercontent.com/ShadowElixir/PostInstall/refs/heads/main/files/debloat.json -Run

# Reverting bad choices by debloat script
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "AllowClipboardHistory" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /f

# Microsoft Store
if ($store -eq 'y') {
    Write-Host "Installing Microsoft Store..." -F Green
    wsreset -i
} 
else {
    Write-Host "Skipped Microsoft Store installation." -F Red
}

# Xbox
if ($xbox -eq 'y') {
    Write-Host "Use the downloaded exe from Microsoft to install required Xbox components."
    Start-Process "https://aka.ms/GamingRepairTool" # Might automate this at some point
    Write-Host "PostInstall Script Completed." -F Green
} 
else {
    Write-Host "PostInstall Script Completed." -F Green
}

# Optional

# Clipboard-related
# reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "AllowCrossDeviceClipboard" /f

# Copilot-related
# reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /f
# reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "PerformedOneTimeHideOfShowDesktopButtonForCopilot" /f
# reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /f

# If you want to re-enable Microsoft Copilot after running the debloat script,
# After running the above 3 commented commands, run the debloat script,
# Go to the "Tweaks" tab, check "Disable Microsoft Copilot",
# Then click "Undo Selected Tweaks".
