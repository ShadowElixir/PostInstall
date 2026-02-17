# Windows Activation (credit: massgravel)
Write-Host "Activating Windows..."
irm https://raw.githubusercontent.com/ShadowElixir/VariousScripts/refs/heads/main/scripts/act.ps1 | iex

# Install WinGet if not installed
Write-Host "Installing WinGet..."
Install-PackageProvider -Name NuGet
Install-Module -Name Microsoft.WinGet.Client -Repository PSGallery
Repair-WinGetPackageManager -AllUsers

Write-Host "Installing Programs & Debloating Windows..."
# Essentials Chris Titus' script doesn't install
winget install Romanitho.Winget-AutoUpdate
winget install jurplel.qView
winget install CodecGuide.K-LiteCodecPack.Mega
winget install amir1376.ABDownloadManager

# Debloat script & some other programs (credit: christitustech)
& ([ScriptBlock]::Create((irm "https://christitus.com/win"))) -Config https://raw.githubusercontent.com/ShadowElixir/PostInstall/refs/heads/main/debloat.json -Run
