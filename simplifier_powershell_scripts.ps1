# Turn Night Light On

Function Set-BlueLightReductionSettings {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true)] [ValidateRange(0, 23)] [int]$StartHour,
        [Parameter(Mandatory=$true)] [ValidateSet(0, 15, 30, 45)] [int]$StartMinutes,
        [Parameter(Mandatory=$true)] [ValidateRange(0, 23)] [int]$EndHour,
        [Parameter(Mandatory=$true)] [ValidateSet(0, 15, 30, 45)] [int]$EndMinutes,
        [Parameter(Mandatory=$true)] [bool]$Enabled,
        [Parameter(Mandatory=$true)] [ValidateRange(1200, 6500)] [int]$NightColorTemperature
    )
    $data = (2, 0, 0, 0)
    $data += [BitConverter]::GetBytes((Get-Date).ToFileTime())
    $data += (0, 0, 0, 0, 0x43, 0x42, 1, 0)
    If ($Enabled) {$data += (2, 1)}
    $data += (0xC2, 0x0A, 0x00)
    $data += (0xCA, 0x14, 0x0E)
    $data += $StartHour
    $data += 0x2E
    $data += $StartMinutes
    $data += (0, 0xCA, 0x1E, 0x0E)
    $data += $EndHour
    $data += 0x2E
    $data += $EndMinutes
    $data += (0, 0xCF, 0x28)
    $tempHi = [Math]::Floor($NightColorTemperature / 64)
    $tempLo = (($NightColorTemperature - ($tempHi * 64)) * 2) + 128
    $data += ($tempLo, $tempHi)
    $data += (0xCA, 0x32, 0, 0xCA, 0x3C, 0, 0)
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\$$windows.data.bluelightreduction.settings\Current' -Name 'Data' -Value ([byte[]]$data) -Type Binary
}


Set-BlueLightReductionSettings -StartHour 21 -StartMinutes 0 -EndHour 7 -EndMinutes 00 -Enabled $true -NightColorTemperature 4500



# Change sound scheme to 'No Sounds'

New-ItemProperty -Path HKCU:\AppEvents\Schemes -Name "(Default)" -Value ".None" -Force | Out-Null
Get-ChildItem -Path "HKCU:\AppEvents\Schemes\Apps" | Get-ChildItem | Get-ChildItem | Where-Object {$_.PSChildName -eq ".Current"} | Set-ItemProperty -Name "(Default)" -Value ""