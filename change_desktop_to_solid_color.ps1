# Set the wallpaper PATH to ''
$key = 'HKCU:\Control Panel\Desktop'
Set-ItemProperty -Path $key -Name 'WallPaper' -Value ''

# Re-start windows Explorer:
Stop-Process -ProcessName explorer

# Using `CMD+R` and run :
shell::{ED834ED6-4B5A-4bfe-8F11-A626DCB6A921} -Microsoft.Personalization\pageWallpaper

# Getting the "Transcoded" PATH:
$TIC=(Get-ItemProperty 'HKCU:\Control Panel\Desktop' TranscodedImageCache -ErrorAction Stop).TranscodedImageCache
[System.Text.Encoding]::Unicode.GetString($TIC) -replace '(.+)([A-Z]:[0-9a-zA-Z\\])+','$2'

Start-Process -ProcessName explorer
