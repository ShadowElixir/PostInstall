# Windows Activation (credit: massgravel)
irm https://raw.githubusercontent.com/massgravel/Microsoft-Activation-Scripts/refs/heads/master/MAS/Separate-Files-Version/Activators/HWID_Activation.cmd | iex

# Essentials Chris Titus' script doesn't install
winget install Romanitho.Winget-AutoUpdate
winget install jurplel.qView
winget install CodecGuide.K-LiteCodecPack.Mega
winget install amir1376.ABDownloadManager

# Debloat script & some other programs (credit: christitustech)
& ([ScriptBlock]::Create((irm "https://christitus.com/win"))) -Config https://raw.githubusercontent.com/ShadowElixir/PostInstall/refs/heads/main/debloat.json -Run
