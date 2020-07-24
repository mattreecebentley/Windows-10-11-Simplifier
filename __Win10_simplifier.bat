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



IF EXIST "%~dp0\StopResettingMyApps.exe" (
	ECHO Stop Resetting My Apps found, running ...
	start %~dp0\StopResettingMyApps.exe
)



REM If no command line arguments, go straight to questions:
IF "%~1"=="" goto questions



REM Skip questions if specified on command line:
IF "%1"=="-all" (
	ECHO All options enabled
	set hibernate_off=y
	set disable_notifications=y
	set disable_defender=y
	set reboot=y
	set mydefrag=n
	set solid_color_background=y
	set chkdsk=y
	set disable_hide_systemtray=y
	set disable_folder_templates=y
	set disable_application_experience=y
	set clear_pinned_apps=y
	set disable_uac=y

	IF EXIST "%~dp0\MyDefrag.exe" (
		set mydefrag=y
		set reboot=n
	)

	goto begin
)


IF "%1"=="-none" (
	ECHO All options disabled
	set hibernate_off=n
	set mydefrag=n
	set disable_notifications=n
	set disable_defender=n
	set reboot=n
	set solid_color_background=n
	set chkdsk=n
	set disable_hide_systemtray=n
	set disable_folder_templates=n
	set disable_application_experience=n
	set disable_superfetch=n
	set clear_pinned_apps=n
	set disable_uac=n
	goto begin
)



REM Process all command line arguments:
set hibernate_off=n
set mydefrag=n
set disable_notifications=n
set disable_defender=n
set reboot=n
set solid_color_background=n
set chkdsk=n
set disable_hide_systemtray=n
set disable_folder_templates=n
set disable_application_experience=n
set disable_superfetch=n
set clear_pinned_apps=n
set disable_uac=n



FOR %%A IN (%*) DO (
	IF "%%A"=="-defrag" (
		ECHO Defrag enabled
		set mydefrag=y
	)

	IF "%%A"=="-disablesuperfetch" (
		ECHO Notification disabling enabled
		set disable_superfetch=y
	)

	IF "%%A"=="-disablenotifications" (
		ECHO Notification disabling enabled
		set disable_notifications=y
	)

	IF "%%A"=="-disablehibernation" (
		ECHO Hibernation/fast boot disabling enabled
		set hibernate_off=y
	)

	IF "%%A"=="-disabledefender" (
		ECHO Defender disabling enabled
		set disable_defender=y
	)

	IF "%%A"=="-reboot" (
		ECHO Reboot at end of script enabled (will be disabled if -defrag specified)
		set reboot=y
	)

	IF "%%A"=="-solidcolordesktop" (
		ECHO Solid color desktop background enabled
		set solid_color_background=y
	)

	IF "%%A"=="-chkdsk" (
		ECHO Chkdsk for bad sectors on reboot enabled
		set chkdsk=y
	)

	IF "%%A"=="-showtrayitems" (
		ECHO Disable hiding of system tray items enabled
		set disable_hide_systemtray=y
	)

	IF "%%A"=="-disablefoldertemplates" (
		ECHO Disable hiding of system tray items enabled
		set disable_folder_templates=y
	)

	IF "%%A"=="-disableae" (
		ECHO Disable hiding of system tray items enabled
		set disable_application_experience=y
	)

	IF "%%A"=="-clearpinnedapps" (
		ECHO Clear all pinned apps from taskbar enabled
		set clear_pinned_apps=y
	)

	IF "%%A"=="-disableuac" (
		ECHO Clear all pinned apps from taskbar enabled
		set disable_uac=y
	)
)


If /I "%mydefrag%"=="y" (
	set reboot=n
)


goto begin



:questions

REM *** Ask questions: ***

ECHO.
ECHO Questions section. Note: either lowercase or uppercase letters are both fine for all answers.


set mydefrag=n

IF EXIST "%~dp0\MyDefrag.exe" (
	ECHO.
	ECHO Do you want defrag C: using MyDefrag Monthly script at end of scripts? Do not if C: is a SSD.
	ECHO Press Y or N and then ENTER
	set /P mydefrag=Type input: %=%
)


If /I "mydefrag"=="y" (
	ECHO.
	ECHO Defrag enabled - Make sure your scripts/settings.myd file is set to reboot after defrag, if you want that to happen.
	set reboot="n"
)


IF /I "%mydefrag%"=="n" (
	ECHO.
	ECHO Do you want Reboot after the script completes?
	ECHO Press Y or N and then ENTER:
	set /P reboot=Type input: %=%
)



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
set disable_hide_systemtray=
set /P disable_hide_systemtray=Type input: %=%


ECHO.
ECHO Do you want to set all folders to the 'General Items' template (remove music-oriented folder layouts)?
ECHO Press Y or N and then ENTER:
set disable_folder_templates=
set /P disable_folder_templates=Type input: %=%


ECHO.
ECHO Do you want to disable Application Experience (required for running old applications, disabling can speed up program launch)?
ECHO Press Y or N and then ENTER:
set disable_application_experience=
set /P disable_application_experience=Type input: %=%


ECHO.
ECHO Do you want to clear the currently pinned apps from the taskbar?
ECHO Press Y or N and then ENTER:
set clear_pinned_apps=
set /P clear_pinned_apps=Type input: %=%


ECHO.
ECHO Do you want to disable UAC (to get rid of those annoying popups every time you run a program)?
ECHO Press Y or N and then ENTER:
set disable_uac=
set /P disable_uac=Type input: %=%


ECHO.
ECHO Do you want to disable Superfetch?
ECHO Press Y or N and then ENTER:
set disable_superfetch=
set /P disable_superfetch=Type input: %=%



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



If /I "%disable_superfetch%"=="y" (
	ECHO Disable User Account Control:
	sc stop “SysMain”
	sc config “SysMain” start=disabled
)



If /I "%disable_uac%"=="y" (
	ECHO Disable User Account Control:
	REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
)



If /I "%disable_hide_systemtray%"=="y" (
	ECHO Disable hiding of items in system tray:
	REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoAutoTrayNotify /d 1 /t REG_DWORD /f
)



If /I "%solid_color_background%"=="y" (
	ECHO Changing desktop background to solid color:
	REG ADD "HKEY_CURRENT_USER\Control Panel\Colors" /v Background /t REG_SZ /d "50 50 100" /f
	PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& %~dp0\simplifier_desktop_to_solid_color.ps1" -Verb RunAs
)



If /I "%disable_folder_templates%"=="y" (
	ECHO Remove per-folder layout templates:
	REG ADD "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /V FolderType /T REG_SZ /D NotSpecified /F
)



If /I "%disable_application_experience%"=="y" (
	ECHO Disable application experience/Microsoft Compatibility Appraiser:
	schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable
)



If /I "%clear_pinned_apps%"=="y" (
	ECHO Clear pinned apps from taskbar:
	DEL /F /S /Q /A "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*"
	REG DELETE HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband /F
	taskkill /f /im explorer.exe
	start explorer.exe
)



If /I "%disable_defender%"=="y" (
	ECHO Disabling Windows Defender - restart required to see change:
	REM from: https://pastebin.com/kYCVzZPz
	REM Disable Tamper Protection First !!!!!
	reg add "HKLM\Software\Microsoft\Windows Defender\Features" /v "TamperProtection" /t REG_DWORD /d "0" /f

	REM To disable System Guard Runtime Monitor Broker
	REM reg add "HKLM\System\CurrentControlSet\Services\SgrmBroker" /v "Start" /t REG_DWORD /d "4" /f

	REM To disable Windows Defender Security Center include this
	REM reg add "HKLM\System\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d "4" /f

	REM 1 - Disable Real-time protection
	reg delete "HKLM\Software\Policies\Microsoft\Windows Defender" /f
	reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f
	reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableAntiVirus" /t REG_DWORD /d "1" /f
	reg add "HKLM\Software\Policies\Microsoft\Windows Defender\MpEngine" /v "MpEnablePus" /t REG_DWORD /d "0" /f
	reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d "1" /f
	reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d "1" /f
	reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d "1" /f
	reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d "1" /f
	reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d "1" /f
	reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d "1" /f
	reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Reporting" /v "DisableEnhancedNotifications" /t REG_DWORD /d "1" /f
	reg add "HKLM\Software\Policies\Microsoft\Windows Defender\SpyNet" /v "DisableBlockAtFirstSeen" /t REG_DWORD /d "1" /f
	reg add "HKLM\Software\Policies\Microsoft\Windows Defender\SpyNet" /v "SpynetReporting" /t REG_DWORD /d "0" /f
	reg add "HKLM\Software\Policies\Microsoft\Windows Defender\SpyNet" /v "SubmitSamplesConsent" /t REG_DWORD /d "2" /f
	
	REM 0 - Disable Logging
	reg add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v "Start" /t REG_DWORD /d "0" /f
	reg add "HKLM\System\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v "Start" /t REG_DWORD /d "0" /f
	
	REM Disable WD Tasks
	schtasks /Change /TN "Microsoft\Windows\ExploitGuard\ExploitGuard MDM policy Refresh" /Disable
	schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /Disable
	schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /Disable
	schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /Disable
	schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Verification" /Disable
	
	REM Disable WD systray icon
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /f
	reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f
	
	REM Remove WD context menu
	reg delete "HKCR\*\shellex\ContextMenuHandlers\EPP" /f
	reg delete "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /f
	reg delete "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /f
	
	REM Disable WD services
	reg add "HKLM\System\CurrentControlSet\Services\WdBoot" /v "Start" /t REG_DWORD /d "4" /f
	reg add "HKLM\System\CurrentControlSet\Services\WdFilter" /v "Start" /t REG_DWORD /d "4" /f
	reg add "HKLM\System\CurrentControlSet\Services\WdNisDrv" /v "Start" /t REG_DWORD /d "4" /f
	reg add "HKLM\System\CurrentControlSet\Services\WdNisSvc" /v "Start" /t REG_DWORD /d "4" /f
	reg add "HKLM\System\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d "4" /f
)



If /I "%disable_notifications%"=="y" (
	ECHO Disabling notification center:
	REG ADD "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableNotificationCenter /t REG_DWORD /d 1 /f
	REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /t REG_DWORD /d 0 /f

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


REM Disable Windows Search and install Agent Ransack, if Agent Ransack is present:
set agentransack_exists=n
IF EXIST "%~dp0\agentransack.msi" set agentransack_exists=y


IF "%agentransack_exists%"=="y" (
	ECHO Disabling Windows Search
	sc stop "WSearch"
	sc config "WSearch" start= disabled

	ECHO Installing Agent Ransack!
	IF "%ProgramFiles(x86)%"=="" (
		REM 32-bit system:
		start %~dp0\agentransack.msi /quiet
	) ELSE (
		REM 64-bit system:
		start %~dp0\agentransack-x64.msi /quiet
	)
)



REM Disable zip/cab folders and install 7zip, if 7zip present:
set sevenzip_exists=n
IF EXIST "%~dp0\7z.exe" set sevenzip_exists=y
IF EXIST "%~dp0\7z-x64.exe" set sevenzip_exists=y


IF "%sevenzip_exists%"=="y" (
	ECHO Disabling zip/cab folders
	REG DELETE HKCR\CompressedFolder\CLSID /f
	REG DELETE HKCR\SystemFileAssociations\.zip\CLSID /f

	ECHO Installing 7-zip!
	IF "%ProgramFiles(x86)%"=="" (
		REM 32-bit system:
		start %~dp0\7z.exe /S /D="%ProgramFiles%\7-Zip"
	) ELSE (
		REM 64-bit system:
		start %~dp0\7z-x64.exe /S /D="%ProgramFiles%\7-Zip"
	)
)



IF EXIST "%~dp0\_Win10-BlackViper.bat" (
	ECHO Running Windows 10 Black Viper Services Tweaks - Safe settings Only:
	call %~dp0\_Win10-BlackViper.bat -auto -safe -sbc -sec
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
	start explorer.exe
	pause
)