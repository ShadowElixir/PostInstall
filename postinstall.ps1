# Windows Activation (credit: massgravel)
Write-Host "Activating Windows..."
irm https://raw.githubusercontent.com/ShadowElixir/VariousScripts/refs/heads/main/scripts/act.ps1 | iex

# Install WinGet if not installed
Write-Host "Installing WinGet..."
Install-PackageProvider -Name NuGet
Install-Module -Name Microsoft.WinGet.Client -Repository PSGallery
Repair-WinGetPackageManager -AllUsers

# Essential programs
Write-Host "Installing Programs..."
winget install Romanitho.Winget-AutoUpdate --accept-package-agreements --accept-source-agreements
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
winget install Betterbird.Betterbird --accept-package-agreements --accept-source-agreements
winget install ONLYOFFICE.DesktopEditors --accept-package-agreements --accept-source-agreements

# Debloat script (credit: christitustech)
Write-Host "Debloating Windows..."
& ([ScriptBlock]::Create((irm "https://christitus.com/win"))) -Config https://raw.githubusercontent.com/ShadowElixir/PostInstall/refs/heads/main/debloat.json -Run
