@ECHO OFF

REM Change working directory to script directory:
pushd "%~dp0"


REM Run initial testing software:

IF EXIST "Core Temp.exe" (
	ECHO Core temp found, running ...
	"Core Temp.exe"
)

IF EXIST "HDDscan.exe" (
	ECHO HDDScan found, running ...
	HDDscan.exe
)

IF EXIST "TDSSKiller.exe" (
	ECHO Kaspersky Rootkit Scanner detected found, running, please wait, threats will be automatically cleaned, log outputted to TDSSKiller_log.txt ...
	TDSSKiller.exe -L TDSSKiller_log.txt -tdlfs -dcexact -accepteula -accepteulaksn
)



REM Run initial cleanup programs:


IF EXIST "CCleaner.exe" (
	ECHO Ccleaner portable found, Running in background...

	IF "%ProgramFiles(x86)%"=="" (
		REM 32-bit system:
		start CCleaner.exe /AUTO
	) ELSE (
		REM 64-bit system:
		start CCleaner64.exe /AUTO
	)
)



IF EXIST "pc-decrapifier-2.3.1.exe" (
	ECHO PC Decrapifier 2.3.1 found, running ...
	start pc-decrapifier-2.3.1.exe
)


IF EXIST "autoruns.exe" (
	ECHO Autoruns found, running ...

	IF "%ProgramFiles(x86)%"=="" (
		REM 32-bit system:
		Autoruns.exe
	) ELSE (
		REM 64-bit system:
		Autoruns64.exe
	)
)



IF EXIST "StopResettingMyApps.exe" (
	ECHO Stop Resetting My Apps found, running ...
	start StopResettingMyApps.exe
)


IF EXIST "oldcalc.exe" (
	ECHO Installing old version of Calc:
	start oldcalc.exe
)


IF EXIST "win7games.exe" (
	ECHO Installing old versions of Windows 7 games:
	start win7games.exe
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
	set disable_superfetch=y
	set clear_pinned_apps=y
	set disable_uac=y
	set uninstall_onedrive=y
	set uninstall_edge=y

	IF EXIST "MyDefrag.exe" (
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
	set uninstall_onedrive=n
	set uninstall_edge=n
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
set uninstall_onedrive=n
set uninstall_edge=n



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
		ECHO Folder templates disabled
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
		ECHO UAC disabled
		set disable_uac=y
	)

	IF "%%A"=="-uninstallonedrive" (
		ECHO Uninstalling onedrive enabled
		set uninstall_onedrive=y
	)

	IF "%%A"=="-uninstalledge" (
		ECHO Uninstalling edge enabled
		set uninstall_edge=y
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

IF EXIST "MyDefrag.exe" (
	ECHO.
	ECHO Do you want defrag the system drive using MyDefrag Monthly script at end of scripts? Do not if system drive is a SSD.
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
	chkdsk %SystemDrive% /f /r
)




ECHO.
ECHO Do you want to disable the notifications center (action center) and prevent closed Microsoft apps like Camera from running in the background?
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

IF /I "%disable_defender%"=="y" (
	ECHO.
	ECHO Please note that Defender can only be disabled in Win10 v2004 and upwards if Tamper Protection is disabled.
	ECHO This setting can be found in Window Security settings. Please do this now and then,
	pause
)


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
ECHO Do you want to disable UAC (reduces overall security, disables application launch popups?
ECHO Press Y or N and then ENTER:
set disable_uac=
set /P disable_uac=Type input: %=%


ECHO.
ECHO Do you want to disable Superfetch?
ECHO Press Y or N and then ENTER:
set disable_superfetch=
set /P disable_superfetch=Type input: %=%



ECHO.
ECHO Do you want to uninstall Onedrive?
ECHO Press Y or N and then ENTER:
set uninstall_onedrive=
set /P uninstall_onedrive=Type input: %=%



ECHO.
ECHO Do you want to burn and destroy Edge Browser?
ECHO Press Y or N and then ENTER:
set uninstall_edge=
set /P uninstall_edge=Type input: %=%



:begin

ECHO.
ECHO.
ECHO ***Starting Changes:***
ECHO.



ECHO Backing up registry...
REG SAVE HKLM\SOFTWARE HKLMSOFTWARE.HIV /y
REG SAVE HKLM\SYSTEM HKLMSYSTEM.HIV /y
REG SAVE HKCU\SOFTWARE HKCUSOFTWARE.HIV /y
REG SAVE "HKCU\Control Panel" HKCUcontrol_panel.HIV /y
REG SAVE "HKCU\AppEvents" HKCUapp_events.HIV /y



REM *** Run External Programs: ***


REM Disable zip/cab folders and install 7zip, if 7zip present:
set sevenzip_exists=n
IF EXIST "7z.exe" set sevenzip_exists=y
IF EXIST "7z-x64.exe" set sevenzip_exists=y


IF "%sevenzip_exists%"=="y" (
	ECHO Disabling zip/cab folders
	REG DELETE HKEY_CLASSES_ROOT\CompressedFolder\CLSID /f
	REG DELETE HKEY_CLASSES_ROOT\CABFolder\CLSID /f
	REG DELETE HKEY_CLASSES_ROOT\SystemFileAssociations\.zip\CLSID /f
	REG DELETE HKEY_CLASSES_ROOT\SystemFileAssociations\.cab\CLSID /f

	ECHO Installing 7-zip
	IF "%ProgramFiles(x86)%"=="" (
		REM 32-bit system:
		start 7z.exe /S /D="%ProgramFiles%\7-Zip"
	) ELSE (
		REM 64-bit system:
		start 7z-x64.exe /S /D="%ProgramFiles%\7-Zip"
	)
)



IF EXIST "_Win10-BlackViper.bat" (
	ECHO Running Windows 10 Black Viper Services Tweaks - Safe settings Only:
	call _Win10-BlackViper.bat -auto -safe -sbc -secp -sech -sds
)



REM Disable Windows Search and install Agent Ransack, if Agent Ransack is present:
set agentransack_exists=n
IF EXIST "agentransack.msi" set agentransack_exists=y


IF "%agentransack_exists%"=="y" (
	ECHO Disabling Windows Search
	sc stop "WSearch"
	sc config "WSearch" start= disabled

	ECHO Installing Agent Ransack
	IF "%ProgramFiles(x86)%"=="" (
		REM 32-bit system:
		start agentransack.msi /quiet
	) ELSE (
		REM 64-bit system:
		start agentransack-x64.msi /quiet
	)
)



If /I "%disable_superfetch%"=="y" (
	ECHO Disable Superfetch:
	sc stop "SysMain"
	sc config "SysMain" start=disabled
)



IF EXIST "Windows10SysPrepDebloater.ps1" (
	ECHO Running Windows10 Debloater:
	PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& %~dp0\Windows10SysPrepDebloater.ps1 -SysPrep -Privacy -Debloat" -Verb RunAs
)



IF EXIST "OOSU10.exe" (
	ECHO Running ShutUp10 with user-specified settings:
	OOSU10.exe ooshutup10.cfg /quiet
)



IF EXIST "SpeedyFox.exe" (
	ECHO Running SpeedyFox:
	SpeedyFox.exe /Firefox:all /Thunderbird:all /Chrome:all /Skype:all /Opera:all
)



IF EXIST "OpenShellSetup.exe" (
	ECHO Installing OpenShell
	start OpenShellSetup.exe /quiet /norestart ADDLOCAL=StartMenu
)




REM ***** Optional changes *****


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
	taskkill /f /im explorer.exe
	start explorer.exe
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
	REM Disable Tamper Protection First - on WIn10 vers which allow for this (not from 2004 onwards)
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

	REM Disable Security system tray icon
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v "HideSystray" /t REG_DWORD /d "1" /f
)



If /I "%disable_notifications%"=="y" (
	ECHO Disabling notification center:
	REG ADD "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableNotificationCenter /t REG_DWORD /d 1 /f
	REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /t REG_DWORD /d 0 /f

	ECHO Disabling background apps:
	Reg Add HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v GlobalUserDisabled /t REG_DWORD /d 1 /f
	Reg Add HKCU\Software\Microsoft\Windows\CurrentVersion\Search /v BackgroundAppGlobalToggle /t REG_DWORD /d 0 /f
)



If /I "%uninstall_onedrive%"=="y" (
	ECHO Uninstalling OneDrive
	taskkill /f /im OneDrive.exe

	IF "%ProgramFiles(x86)%"=="" (
		REM 32-bit system:
		start %systemroot%\System32\OneDriveSetup.exe /uninstall
	) ELSE (
		REM 64-bit system:
		start %systemroot%\SysWOW64\OneDriveSetup.exe /uninstall
	)
)



If /I "%uninstall_edge%"=="y" (
	ECHO Uninstalling Chromium Edge and/or preventing it from being installed again
	popd
	cd "C:\Program Files (x86)\Microsoft\Edge\Application\"
	FORFILES /S /M setup.exe /C "cmd /c call @file -uninstall -system-level -verbose-logging -force-uninstall"
	Reg Add HKLM\Software\Microsoft\EdgeUpdate /f
	Reg Add HKLM\Software\Microsoft\EdgeUpdate /v DoNotUpdateToEdgeWithChromium /t REG_DWORD /d 1 /f
	pushd "%~dp0"
)




REM *** Begin main changes: ***


ECHO Doing the registry changes
regedit.exe /S simplifier_registry_changes.reg


ECHO Enabling F8 boot options
bcdedit /set {current} bootmenupolicy Legacy


ECHO Disabling system sounds
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& %~dp0\simplifier_disable_system_sounds.ps1" -Verb RunAs


ECHO Disabling web search in taskbar/start:
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& %~dp0\simplifier_disable_web_search.ps1" -Verb RunAs


ECHO Remove M$ in-start-menu advertising for it's own online services:
popd
cd "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\
IF EXIST "Excel.lnk" del /F "Excel.lnk"
IF EXIST "Outlook.lnk" del /F "Outlook.lnk"
IF EXIST "Word.lnk" del /F "Word.lnk"
IF EXIST "Powerpoint.lnk" del /F "Powerpoint.lnk"
IF EXIST "Excel (1).lnk" del /F "Excel (1).lnk"
IF EXIST "Outlook (1).lnk" del /F "Outlook (1).lnk"
IF EXIST "Word (1).lnk" del /F "Word (1).lnk"
IF EXIST "Powerpoint (1).lnk" del /F "Powerpoint (1).lnk"
cd ..
IF EXIST "MSN New Zealand  latest news, Hotmail, Outlook, photos and Videos.website" del /F "MSN New Zealand  latest news, Hotmail, Outlook, photos and Videos.website"
pushd "%~dp0"



REM *** Do Power Management Changes ***

If /I "%hibernate_off%"=="y" (
	ECHO.
	ECHO Disabling Hibernation/Fast Boot
	powercfg -h off
)


ECHO Setting the 'Power Management' to Balanced
powercfg -SETACTIVE 381b4222-f694-41f0-9685-ff5bb260df2e


ECHO Setting the unplugged settings to never hibernate
powercfg.exe -change -monitor-timeout-dc 5
powercfg.exe -change -standby-timeout-dc 15
powercfg.exe -change -hibernate-timeout-dc 0


ECHO Setting the plugged in settings to never sleep
powercfg.exe -change -monitor-timeout-ac 15
powercfg.exe -change -standby-timeout-ac 0
powercfg.exe -change -hibernate-timeout-ac 0


ECHO Setting the 'Dim Timeout' to Never
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 7516b95f-f776-4464-8c53-06167f40cc99 17aaa29b-8b43-4b94-aafe-35f64daaf1ee 0
powercfg -SETACVALUEINDEX SCHEME_CURRENT 7516b95f-f776-4464-8c53-06167f40cc99 17aaa29b-8b43-4b94-aafe-35f64daaf1ee 0


ECHO Set windows to do nothing when the lid is closed and it's plugged in, sleep when it's not:
powercfg -SETACVALUEINDEX SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 3


ECHO Set windows to actually shut down when you press the power button, not just sleep:
powercfg -SETACVALUEINDEX SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 3
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 3


ECHO Enabling Group Policy Editor if not already present:
IF NOT EXIST "%SystemRoot%\System32\gpedit.msc" (
	dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~3*.mum >List.txt
	dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~3*.mum >>List.txt 
	for /f %%i in ('findstr /i . List.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i"
)


REM Optionally run mydefrag:
IF EXIST "MyDefrag.exe" (
	If /I "%mydefrag%"=="y" (
		ECHO Running MyDefrag Monthly script on System drive
		start MyDefrag.exe -v %SystemDrive% -r Scripts\SystemDiskMonthly.MyD
	)
)


REM Change working directory to back to original directory:
popd


If /I "%reboot%"=="y" (
	ECHO Script finished, Rebooting:
	shutdown /r
) ELSE (
	ECHO Simplifier Finished!
	start explorer.exe
	pause
)