# User Choices
Write-Host "Press 0 for No Office Suite"
Write-Host "Press 1 for OnlyOffice"
Write-Host "Press 2 for Microsoft Office"
$office = Read-Host "Would you like to an Office Suite? (0/1/2)"
$store = Read-Host "Would you like to keep or install the Microsoft Store? (y/n)"
$xbox = Read-Host "Would you like to keep or install Xbox components? (y/n)"

# Windows Activation (credit: massgravel)
Write-Host "Activating Windows..." -F Green
irm https://raw.githubusercontent.com/ShadowElixir/VariousScripts/refs/heads/main/scripts/act.ps1 | iex

# Install WinGet if not installed
Write-Host "Installing WinGet..." -F Green
Install-PackageProvider -Name NuGet -Force
Install-Module -Name Microsoft.WinGet.Client -Repository PSGallery -Force
Repair-WinGetPackageManager -AllUsers

# Essential programs
Write-Host "Installing Programs..." -F Green
winget install -e --id Romanitho.Winget-AutoUpdate --accept-package-agreements --accept-source-agreements --custom "USERCONTEXT=1 UPDATESINTERVAL=Daily"
winget install -e --id Fastfetch-cli.Fastfetch --accept-package-agreements --accept-source-agreements
winget install -e --id yt-dlp.yt-dlp --accept-package-agreements --accept-source-agreements
winget install -e --id Notepad++.Notepad++ --accept-package-agreements --accept-source-agreements
winget install -e --id jurplel.qView --accept-package-agreements --accept-source-agreements
winget install -e --id clsid2.mpc-hc --accept-package-agreements --accept-source-agreements
winget install -e --id amir1376.ABDownloadManager --accept-package-agreements --accept-source-agreements
winget install -e --id 7zip.7zip --accept-package-agreements --accept-source-agreements
winget install -e --id LibreWolf.LibreWolf --accept-package-agreements --accept-source-agreements
winget install -e --id Brave.Brave --accept-package-agreements --accept-source-agreements
winget install -e --id OBSProject.OBSStudio --accept-package-agreements --accept-source-agreements
winget install -e --id SumatraPDF.SumatraPDF --accept-package-agreements --accept-source-agreements
winget install -e --id qBittorrent.qBittorrent --accept-package-agreements --accept-source-agreements
winget install -e --id AdrienAllard.FileConverter --accept-package-agreements --accept-source-agreements
winget install -e --id Microsoft.Sysinternals.Autoruns --accept-package-agreements --accept-source-agreements
winget install -e --id Git.Git --accept-package-agreements --accept-source-agreements --custom "/COMPONENTS=gitlfs,scalar,assoc /o:EditorOption=Notepad++"
winget install -e --id Betterbird.Betterbird --accept-package-agreements --accept-source-agreements
winget install -e --id zhongyang219.TrafficMonitor.Lite --accept-package-agreements --accept-source-agreements
winget install -e --id Klocman.BulkCrapUninstaller --accept-package-agreements --accept-source-agreements
if ([int](Get-CimInstance Win32_OperatingSystem).BuildNumber -ge 22000) {
    winget install -e --id valinet.ExplorerPatcher --accept-package-agreements --accept-source-agreements
}
if (Get-WmiObject Win32_VideoController | Where-Object { $_.Name -like "*NVIDIA*" }) {
    winget install -e --id TechPowerUp.NVCleanstall --accept-package-agreements --accept-source-agreements
}

# Additional Configuration
Write-Host "Configuring Winget-AutoUpdate" -F Blue
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ShadowElixir/PostInstall/refs/heads/main/files/Romanitho.Winget-AutoUpdate-installed.ps1" -OutFile "$Env:ProgramFiles\Winget-AutoUpdate\mods\Romanitho.Winget-AutoUpdate-installed.ps1"
irm https://raw.githubusercontent.com/ShadowElixir/PostInstall/refs/heads/main/files/Romanitho.Winget-AutoUpdate-installed.ps1 | iex

Write-Host "Configuring LibreWolf" -F Blue
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ShadowElixir/PostInstall/refs/heads/main/files/librewolf.overrides.cfg" -OutFile "$env:USERPROFILE\.librewolf\librewolf.overrides.cfg"

# Install basic PowerShell profile
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force
New-Item $env:userprofile\Documents\WindowsPowerShell -ItemType Directory
irm https://raw.githubusercontent.com/ShadowElixir/PostInstall/refs/heads/main/files/profile.ps1 >> $PROFILE

# Debloat script (credit: christitustech)
Write-Host "Debloating Windows..." -F Green

$log = "$env:TEMP\debloat.log"

$p = Start-Process powershell `
    -ArgumentList '-Command & ([ScriptBlock]::Create((irm https://github.com/ChrisTitusTech/winutil/releases/download/26.02.18/winutil.ps1))) -Config https://raw.githubusercontent.com/ShadowElixir/PostInstall/refs/heads/main/files/debloat.json -Run' `
    -RedirectStandardOutput $log `
    -NoNewWindow `
    -PassThru

while (-not $p.HasExited) {
    if (Test-Path $log) {
        $text = Get-Content $log -Raw
        if ($text -match "--     Tweaks are Finished    ---") {
            Stop-Process -Id $p.Id
            break
        }
    }
    Start-Sleep 1
}

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
    Write-Host "Installing Xbox components..." -F Green
    winget install "9mv0b5hzvk9z" --source msstore --accept-package-agreements --accept-source-agreements # Xbox App
    winget install "9wzdncrd1hkw" --source msstore --accept-package-agreements --accept-source-agreements # Xbox Identity Provider
    winget install "9MWPM2CQNLHN" --source msstore --accept-package-agreements --accept-source-agreements # Gaming Services
    winget install "9nzkpstsnw4p" --source msstore --accept-package-agreements --accept-source-agreements # Game Bar
    winget install "9nknc0ld5nn6" --source msstore --accept-package-agreements --accept-source-agreements # Xbox Live in-game experience
} 
else {
    Write-Host "Skipped Xbox installation." -F Red
}

# Office
if ($office -eq '1') {
    Write-Host "Installing OnlyOffice using WinGet..." -F Green
    winget install -e --id ONLYOFFICE.DesktopEditors --accept-package-agreements --accept-source-agreements
    Write-Host "PostInstall script completed." -F Green
}
elseif ($office -eq '2') {
    Write-Host "Installing Office Deployment Tool using WinGet..." -F Green
    winget install -e --id Microsoft.OfficeDeploymentTool --accept-package-agreements --accept-source-agreements
    Write-Host "Installing Office using ODT" -F Green
    & $Env:ProgramFiles\OfficeDeploymentTool\setup.exe /configure https://raw.githubusercontent.com/ShadowElixir/PostInstall/refs/heads/main/files/office.xml
    Write-Host "Activating Office" -F Green
    irm https://raw.githubusercontent.com/ShadowElixir/VariousScripts/refs/heads/main/scripts/act-office.ps1 | iex
    Write-Host "PostInstall script completed." -F Green
}
else {
    Write-Host "PostInstall script completed." -F Green
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
