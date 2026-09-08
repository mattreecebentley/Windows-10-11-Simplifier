# Allow manual creation of system restore points within less-than 24 hours of each other, then create restore point:

New-Item -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" -Name "SystemRestorePointCreationFrequency" -Value 0 -Type DWord


$Description = "Win1xSimplifierRestorePoint"
Checkpoint-Computer -Description $Description -RestorePointType "MODIFY_SETTINGS"

# Verify if it now exists in the system
if (Get-ComputerRestorePoint | Where-Object { $_.Description -eq $Description })
{
	 Write-Host "Success: Restore point '$Description' was created." -ForegroundColor Green
}
else
{
	Write-Host "Unable to create System restore point, if System Restore is disabled for this computer it is highly-recommended that you enable system restore before continuing this script."
	Write-Host "Would you like to do so now and then retry creating the restore point?"

	# Prompt the user for input
	$redo = Read-Host "Press Y or N and then ENTER"

	# Check if the input is "y" (PowerShell is case-insensitive by default)
	if ($redo -eq "y") {
		 Write-Host "Please go into control panel or settings, look for Recovery, and enable system restore for your system drive, then"

		 Read-Host "Press ENTER to continue..."

		Checkpoint-Computer -Description $Description -RestorePointType "MODIFY_SETTINGS"

		if (!(Get-ComputerRestorePoint | Where-Object { $_.Description -eq $Description }))
		{
			 Write-Host "Failure: Restore point creation failed. Continuing anyway. Quit script if this is a problem." -ForegroundColor Red
			 Read-Host "Press ENTER to continue..."
		}
	}
}
