@ECHO OFF

REM Run initial testing software:

IF EXIST "%~dp0\Core Temp.exe" (
	ECHO Core temp found, running ...
	"%~dp0\Core Temp.exe"
)

IF EXIST "%~dp0\HDDscan.exe" (
	ECHO HDDScan found, running ...
	%~dp0\HDDscan.exe
)




REM Run initial cleanup programs that require user input:

IF EXIST "%~dp0\CCleaner.exe" (
	ECHO Ccleaner portable found, Running in background...

	IF "%ProgramFiles(x86)%"=="" (
		REM 32-bit system:
		start %~dp0\CCleaner.exe /AUTO
	) ELSE (
		REM 64-bit system:
		start %~dp0\CCleaner64.exe /AUTO
	)
)


IF EXIST "%~dp0\pc-decrapifier-2.3.1.exe" (
	ECHO PC Decrapifier 2.3.1 found, running ...
	start %~dp0\pc-decrapifier-2.3.1.exe
)


IF EXIST "%~dp0\autoruns.exe" (
	ECHO Autoruns found, running ...

	IF "%ProgramFiles(x86)%"=="" (
		REM 32-bit system:
		%~dp0\Autoruns.exe
	) ELSE (
		REM 64-bit system:
		%~dp0\Autoruns64.exe
	)
)


REM If no command line arguments, go straight to questions:
IF "%~1"=="" goto questions



REM Skip questions if specified on command line:
IF "%1"=="-all" (
	ECHO All options enabled
	set disk_cleanup="y"
	set hibernate_off="y"
	set disable_notifications="y"
	set disable_defender="y"
	set reboot="y"
	set mydefrag="n"
	set solid_color_background="y"
	set chkdsk="y"
	set disablehidesystemtray="y"

	IF EXIST "%~dp0\MyDefrag.exe" (
		set mydefrag="y"
		set reboot="n"
	)

	goto begin
)


IF "%1"=="-none" (
	ECHO All options disabled
	set disk_cleanup="n"
	set hibernate_off="n"
	set mydefrag="n"
	set disable_notifications="n"
	set disable_defender="n"
	set reboot="n"
	set solid_color_background="n"
	set chkdsk="n"
	set disablehidesystemtray="n"
	goto begin
)



REM Process all command line arguments:
set disk_cleanup="n"
set hibernate_off="n"
set mydefrag="n"
set disable_notifications="n"
set disable_defender="n"
set reboot="n"
set solid_color_background="n"
set chkdsk="n"
set disablehidesystemtray="n"



FOR %%A IN (%*) DO (
	IF "%%A"=="-cleanup" (
		ECHO Disk cleanup enabled
		set disk_cleanup="y"
	)

	IF "%%A"=="-defrag" (
		ECHO Defrag enabled
		set mydefrag="y"
	)

	IF "%%A"=="-disablenotifications" (
		ECHO Notification disabling enabled
		set disable_notifications="y"
	)

	IF "%%A"=="-disablehibernation" (
		ECHO Hibernation/fast boot disabling enabled
		set hibernate_off="y"
	)

	IF "%%A"=="-disabledefender" (
		ECHO Defender disabling enabled
		set disable_defender="y"
	)

	IF "%%A"=="-reboot" (
		ECHO Reboot at end of script enabled (will be disabled if -defrag specified)
		set reboot="y"
	)

	IF "%%A"=="-solidcolordesktop" (
		ECHO Solid color desktop background enabled
		set solid_color_background="y"
	)

	IF "%%A"=="-chkdsk" (
		ECHO Chkdsk for bad sectors on reboot enabled
		set chkdsk="y"
	)

	IF "%%A"=="-showtrayitems" (
		ECHO Disable hiding of system tray items enabled
		set disablehidesystemtray="y"
	)

)


If /I "%mydefrag%"=="y" (
	set reboot="n"
)


goto begin



:questions

REM *** Ask questions: ***

ECHO.
ECHO Questions section. Note: either lowercase or uppercase letters are both fine for all answers.

ECHO.
ECHO Do you want to run Windows Disk Cleanup at end of scripts? Previous windows installations will be deleted automatically, Downloads folder will be left alone.
ECHO Press Y or N and then ENTER (or A to say 'yes' to All subsequent questions):
set disk_cleanup=
set /P disk_cleanup=Type input: %=%


If /I "%disk_cleanup%"=="a" (
	set disk_cleanup="y"
	set hibernate_off="y"
	set mydefrag="y"
	set disable_notifications="y"
	set disable_defender="y"
	set reboot="n"
	set solid_color_background="y"
	set chkdsk="y"
	set disablehidesystemtray="y"
	goto begin
)


set mydefrag="n"


setlocal EnableDelayedExpansion

IF EXIST "%~dp0\MyDefrag.exe" (
	ECHO.
	ECHO Do you want defrag C: using MyDefrag Monthly script at end of scripts? Do not if C: is a SSD.
	ECHO Press Y or N and then ENTER:
	set /P mydefrag=Type input: %=%

	If /I "!mydefrag!"=="y" (
		ECHO.
		ECHO Defrag enabled - Make sure your scripts/settings.myd file is set to reboot after defrag, if you want that to happen.
		set reboot="n"
	)
) ELSE (
	IF NOT "%reboot%"=="n" (
		ECHO.
		ECHO Do you want Reboot after the script completes?
		ECHO Press Y or N and then ENTER:
		set /P reboot=Type input: %=%
	)
)

setlocal DisableDelayedExpansion



ECHO.
ECHO Do you want to check the system hard drive for bad sectors and filesystem errors on next reboot?
ECHO Press Y or N and then ENTER:
set chkdsk=
set /P chkdsk=Type input: %=%



IF /I "%chkdsk%"=="y" (
	ECHO.
	ECHO Running chkdsk now, please press Y then Enter at the prompt so it can run on next reboot:
	chkdsk c: /f /r
)




ECHO.
ECHO Do you want to disable the notifications center (action center) and disallow apps from running in the background?
ECHO Press Y or N and then ENTER:
set disable_notifications=
set /P disable_notifications=Type input: %=%



ECHO.
ECHO Do you want to disable Fast Boot and Hibernation (to free up disk space and allow Windows updates to process on shutdown)?
ECHO Press Y or N and then ENTER:
set hibernate_off=
set /P hibernate_off=Type input: %=%



ECHO.
ECHO Do you want to disable Windows Defender (only do this if you're installing another virus scanner)?
ECHO Press Y or N and then ENTER:
set disable_defender=
set /P disable_defender=Type input: %=%



ECHO.
ECHO Do you want to change the desktop background to a solid color?
ECHO Press Y or N and then ENTER:
set solid_color_background=
set /P solid_color_background=Type input: %=%



ECHO.
ECHO Do you want to disable hiding items in system tray (will not be reenable-able from settings)?
ECHO Press Y or N and then ENTER:
set disablehidesystemtray=
set /P disablehidesystemtray=Type input: %=%



:begin

ECHO.
ECHO.
ECHO ***Starting Changes:***
ECHO.

IF EXIST "%~dp0\TDSSKiller.exe" (
	ECHO Kaspersky Rootkit Scanner detected found, running, please wait, threats will be automatically cleaned, log outputted to TDSSKiller_log.txt ...
	%~dp0\TDSSKiller.exe -L %~dp0\TDSSKiller_log.txt -silent -tdlfs -dcexact
)


ECHO Backing up registry...
REG SAVE HKLM\SOFTWARE %~dp0\HKLMSOFTWARE.HIV /y
REG SAVE HKLM\SYSTEM %~dp0\HKLMSYSTEM.HIV /y
REG SAVE HKCU\SOFTWARE %~dp0\HKCUSOFTWARE.HIV /y
REG SAVE "HKCU\Control Panel" %~dp0\HKCUcontrol_panel.HIV /y
REG SAVE "HKCU\AppEvents" %~dp0\HKCUapp_events.HIV /y



REM *** Begin main changes: ***


REM Show all items in system tray:

If /I "%disablehidesystemtray%"=="y" (
	ECHO Disable hiding of items in system tray:
	REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoAutoTrayNotify /d 1 /t REG_DWORD /f
)



If /I "%solid_color_background%"=="y" (
	ECHO Changing desktop background to solid color:
	PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& %~dp0\simplifier_desktop_to_solid_color.ps1" -Verb RunAs
)



If /I "%disable_defender%"=="y" (
	ECHO Disabling Windows Defender - restart required to see change:
	REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /d 1 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /f
	REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /d 1 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /d 1 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnDisableScanOnRealtimeEnableAccessProtection /d 1 /t REG_DWORD /f
)



If /I "%disable_notifications%"=="y" (
	ECHO Disabling notification center:
	REG ADD "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableNotificationCenter /t REG_DWORD /d 1 /f

	ECHO Disabling background apps:
	Reg Add HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v GlobalUserDisabled /t REG_DWORD /d 1 /f
	Reg Add HKCU\Software\Microsoft\Windows\CurrentVersion\Search /v BackgroundAppGlobalToggle /t REG_DWORD /d 0 /f
)



ECHO Doing the registry changes!
regedit.exe /S %~dp0\simplifier_registry_changes.reg



ECHO Doing the Powershell-based changes!
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& %~dp0\simplifier_powershell_scripts.ps1" -Verb RunAs



REM *** Do Power Management Changes ***

If /I "%hibernate_off%"=="y" (
	ECHO.
	ECHO Disabling Hibernation/Fast Boot!
	powercfg -h off
)


ECHO Setting the 'Power Management' to Balanced!
powercfg -SETACTIVE 381b4222-f694-41f0-9685-ff5bb260df2e


ECHO Setting the unplugged settings to 'Never'!
powercfg.exe -change -monitor-timeout-dc 5
powercfg.exe -change -standby-timeout-dc 15
powercfg.exe -change -hibernate-timeout-dc 0


ECHO Setting the plugged in settings to 'Never'!
powercfg.exe -change -monitor-timeout-ac 15
powercfg.exe -change -standby-timeout-ac 0
powercfg.exe -change -hibernate-timeout-ac 0


ECHO Setting the 'Dim Timeout' to Never!
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 7516b95f-f776-4464-8c53-06167f40cc99 17aaa29b-8b43-4b94-aafe-35f64daaf1ee 0
powercfg -SETACVALUEINDEX SCHEME_CURRENT 7516b95f-f776-4464-8c53-06167f40cc99 17aaa29b-8b43-4b94-aafe-35f64daaf1ee 0


ECHO Set windows to do nothing when the lid is closed and it's plugged in, sleep when it's not:
powercfg -SETACVALUEINDEX SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 3


ECHO Set windows to actually shut down when you press the power button, not just sleep:
powercfg -SETACVALUEINDEX SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 3
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 3




REM *** Run External Programs: ***


REM Disable zip/cab folders and install 7zip, if 7zip present:
set 7z_exists="n"
IF EXIST "%~dp0\7z.exe" set 7z_exists="y"
IF EXIST "%~dp0\7z-x64.exe" set 7z_exists="y"


IF "%7z_exists%"=="y" (
	ECHO Disabling zip/cab folders
	REG DELETE HKCU\CompressedFolder\CLSID /f
	REG DELETE HKCU\SystemFileAssociations\.zip\CLSID /f

	ECHO Installing 7-zip!
	IF "%ProgramFiles(x86)%"=="" (
		REM 32-bit system:
		start %~dp0\7z.exe /S /D="%ProgramFiles%7-Zip"
	) ELSE (
		REM 64-bit system:
		start %~dp0\7z-x64.exe /S /D="%ProgramFiles%7-Zip"
	)
)




IF EXIST "%~dp0\_Win10-BlackViper.bat" (
	ECHO Running Windows 10 Black Viper Services Tweaks - Safe settings Only:
	call %~dp0\_Win10-BlackViper.bat -auto -safe
)



IF EXIST "%~dp0\Windows10SysPrepDebloater.ps1" (
	ECHO Running Windows10 Debloater:
	PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& %~dp0\Windows10SysPrepDebloater.ps1 -SysPrep -Privacy -Debloat -StopEdgePDF" -Verb RunAs
)



IF EXIST "%~dp0\OOSU10.exe" (
	ECHO Running ShutUp10 with user-specified settings:
	%~dp0\OOSU10.exe %~dp0\ooshutup10.cfg /quiet
)



IF EXIST "%~dp0\SpeedyFox.exe" (
	ECHO Running SpeedyFox:
	%~dp0\SpeedyFox.exe /Firefox:all /Thunderbird:all /Chrome:all /Skype:all /Opera:all
)



If /I "%disk_cleanup%"=="y" (
	ECHO Running Disk Cleanup!

	REM Enable components to cleanup

	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Active Setup Temp Folders" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\BranchCache" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Downloaded Program Files" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\GameNewsFiles" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\GameStatisticsFiles" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\GameUpdateFiles" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Internet Cache Files" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Memory Dump Files" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Offline Pages Files" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Old ChkDsk Files" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Previous Installations" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Recycle Bin" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Service Pack Cleanup" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Setup Log Files" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error memory dump files" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error minidump files" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Setup Files" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Sync Files" /V StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Update Cleanup" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Upgrade Discarded Files" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\User file versions" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Defender" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting Archive Files" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting Queue Files" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting System Archive Files" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting System Queue Files" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows ESD installation files" /v StateFlags0100 /d 2 /t REG_DWORD /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Upgrade Log Files" /v StateFlags0100 /d 2 /t REG_DWORD /f

	REM Run cleanup

	IF EXIST %SystemRoot%\SYSTEM32\cleanmgr.exe %SystemRoot%\SYSTEM32\cleanmgr.exe /sagerun:100
)



IF EXIST "%~dp0\MyDefrag.exe" (
	If /I "%mydefrag%"=="y" (
		ECHO Running MyDefrag Monthly script on C:
		start %~dp0\MyDefrag.exe -v C -r %~dp0\Scripts\SystemDiskMonthly.MyD
	)
)


IF EXIST "%~dp0\OpenShellSetup.exe" (
	ECHO Installing OpenShell!
	start %~dp0\OpenShellSetup.exe /qn ADDLOCAL=StartMenu
)



If /I "%reboot%"=="y" (
	ECHO Script finished, Rebooting:
	shutdown /r
) ELSE (
	ECHO Simplifier Finished!
	pause
)