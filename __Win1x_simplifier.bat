@ECHO OFF

REM Change working directory to script directory:
pushd "%~dp0"


REM If no command line arguments, skip this
IF "%~1"=="" goto begin_preliminaries



REM Skip questions if specified on command line:
IF "%1"=="-all" (
	ECHO All options enabled
	set hibernate_off=y
	set disable_notifications=y
	set reboot=y
	set driveoptimize=y
	set solid_color_background=y
	set chkdsk=y
	set disable_hide_systemtray=y
	set disable_folder_templates=y
	set disable_application_experience=y
	set disable_superfetch=y
	set clear_pinned_apps=y
	set disable_uac=y
	set uninstall_onedrive=y
	set freshinstall=n
	set newmachine=n
	set dismsfc=y
	set installgpedit=y


	goto begin_tests
)


IF "%1"=="-none" (
	ECHO All options disabled
	set hibernate_off=n
	set driveoptimize=n
	set disable_notifications=n
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
	set freshinstall=n
	set newmachine=n
	set dismsfc=n
	set installgpedit=n
	goto begin_tests
)


IF "%1"=="-freshinstall" (
	ECHO All options disabled
	set hibernate_off=y
	set driveoptimize=n
	set disable_notifications=y
	set reboot=y
	set solid_color_background=y
	set chkdsk=y
	set disable_hide_systemtray=n
	set disable_folder_templates=n
	set disable_application_experience=y
	set disable_superfetch=n
	set clear_pinned_apps=y
	set disable_uac=n
	set uninstall_onedrive=n
	set freshinstall=y
	set newmachine=n
	set dismsfc=n
	set installgpedit=y
	goto skip_initial_cleanup
)


IF "%1"=="-newmachine" (
	ECHO All options disabled
	set hibernate_off=y
	set driveoptimize=n
	set disable_notifications=y
	set reboot=y
	set solid_color_background=y
	set chkdsk=n
	set disable_hide_systemtray=n
	set disable_folder_templates=n
	set disable_application_experience=y
	set disable_superfetch=n
	set clear_pinned_apps=y
	set disable_uac=n
	set uninstall_onedrive=n
	set freshinstall=y
	set newmachine=y
	set dismsfc=n
	set installgpedit=y
	goto skip_initial_testing
)



REM Process all command line arguments:
set hibernate_off=n
set driveoptimize=n
set disable_notifications=n
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
set freshinstall=n
set newmachine=n
set dismsfc=n
set installgpedit=n



FOR %%A IN (%*) DO (
	IF "%%A"=="-defrag" (
		ECHO Defrag enabled
		set driveoptimize=y
	)

	IF "%%A"=="-disablesuperfetch" (
		ECHO Superfetch disabled
		set disable_superfetch=y
	)

	IF "%%A"=="-disablenotifications" (
		ECHO Notifications disabled
		set disable_notifications=y
	)

	IF "%%A"=="-disablehibernation" (
		ECHO Hibernation/fast boot disabled
		set hibernate_off=y
	)

	IF "%%A"=="-reboot" (
		ECHO Reboot at end of script enabled
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

	IF "%%A"=="-chkdskf" (
		ECHO Chkdsk for filesystem errors only on reboot enabled
		set chkdsk=f
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

	IF "%%A"=="-dismsfc" (
		ECHO DISM and SFC testing enabled
		set dismsfc=y
	)

	IF "%%A"=="-installgpedit" (
		ECHO Skipping installation of group policy editor
		set installgpedit=y
	)
)




goto begin_tests


:begin_preliminaries

REM Run initial testing software:

ECHO.
ECHO Is this a fresh installation of Windows 10 (ie. not preloaded by factory on a new computer, or an old installation)?
ECHO Press Y or N and then ENTER:
set freshinstall=
set /P freshinstall=Type input: %=%

If /I "%freshinstall%"=="y" (
	set dismsfc=n
	goto skip_initial_cleanup
)


ECHO.
ECHO Is this a new computer?
ECHO Press Y or N and then ENTER:
set newmachine=
set /P newmachine=Type input: %=%


If /I "%newmachine%"=="y" (
	set dismsfc=n
	goto skip_initial_testing
)


:begin_tests


IF EXIST "Core Temp.exe" (
	ECHO Core temp found, running ...
	"Core Temp.exe"
)

IF EXIST "HDDscan.exe" (
	ECHO HDDScan found, running ...
	HDDscan.exe
)



REM Run initial cleanup programs:


IF EXIST "ccleaner/CCleaner.exe" (
	ECHO Ccleaner portable found, killing any previously-running instantiations of ccleaner
	tasklist | findstr /i /c:"CCleaner64" > nul && taskkill /IM ccleaner64.exe
	tasklist | findstr /i /c:"CCleaner" > nul && taskkill /IM ccleaner.exe

	ECHO Running ccleaner portable in background...

	IF "%ProgramFiles(x86)%"=="" (
		REM 32-bit system:
		start ccleaner/CCleaner.exe /AUTO
	) ELSE (
		REM 64-bit system:
		start ccleaner/CCleaner64.exe /AUTO
	)
)



IF EXIST "bleachbit\Bleachbit.exe" (
	ECHO Bleachbit portable found, running...
	bleachbit\Bleachbit.exe
)



:skip_initial_testing

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



IF EXIST "TDSSKiller.exe" (
	ECHO Kaspersky Rootkit Scanner detected found, running, please wait, threats will be automatically cleaned, log outputted to TDSSKiller_log.txt ...
	TDSSKiller.exe -L TDSSKiller_log.txt -tdlfs -dcexact -accepteula -accepteulaksn
)



:skip_initial_cleanup


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


IF "%~1"=="" goto questions

REM If there are command line options, skip questions

goto begin



:questions

REM *** Ask questions: ***

ECHO.
ECHO Getting physical disk information:
powershell "get-physicaldisk | format-table -autosize"

ECHO.
ECHO =============================================================================================
ECHO Questions section. Note: either lowercase or uppercase letters are both fine for all answers.
ECHO =============================================================================================


ECHO.
ECHO Do you want to check the system hard drive for bad sectors and filesystem errors on next reboot?
ECHO Do not check for bad sectors on SSD drives.
ECHO Press Y or N, or F for just filesystem errors and no bad-sector checks and then ENTER:
set chkdsk=
set /P chkdsk=Type input: %=%



IF /I "%chkdsk%"=="y" (
	ECHO.
	ECHO Running chkdsk now, please press Y then Enter at the prompt so it can run on next reboot:
	chkdsk %SystemDrive% /f /r
)




IF /I "%chkdsk%"=="f" (
	ECHO.
	ECHO Running chkdsk now, please press Y then Enter at the prompt so it can run on next reboot:
	chkdsk %SystemDrive% /f
)



set driveoptimize=n
	ECHO.


IF EXIST "MyDefrag.exe" (
	ECHO Do you want defrag the system drive using MyDefrag Monthly script at end of scripts? Do not do this if the system drive media type is a SSD.
) ELSE (
	ECHO Do you want defrag/optimize all drives in the computer? SSD drives will only be trimmed.
)

ECHO Press Y or N and then ENTER
set /P driveoptimize=Type input: %=%


ECHO.
ECHO Do you want Reboot after the script completes? Many changes will not be visible until after reboot.
ECHO Press Y or N and then ENTER:
set /P reboot=Type input: %=%


ECHO.
ECHO Do you want to disable the notifications/action center and prevent closed Microsoft apps like Camera from running in the background?
ECHO Press Y or N and then ENTER:
set disable_notifications=
set /P disable_notifications=Type input: %=%



ECHO.
ECHO Do you want to disable Fast Boot and Hibernation? This frees up disk space and allows Windows updates to process on shutdown.
ECHO Press Y or N and then ENTER:
set hibernate_off=
set /P hibernate_off=Type input: %=%



ECHO.
ECHO Do you want to change the desktop background to a solid color?
ECHO Press Y or N and then ENTER:
set solid_color_background=
set /P solid_color_background=Type input: %=%



ECHO.
ECHO Do you want to disable hiding items in system tray? This will not be reenable-able from Settings.
ECHO Press Y or N and then ENTER:
set disable_hide_systemtray=
set /P disable_hide_systemtray=Type input: %=%


ECHO.
ECHO Do you want to set all folders to the 'General Items' template (remove music/photo/video-oriented folder layouts)?
ECHO Press Y or N and then ENTER:
set disable_folder_templates=
set /P disable_folder_templates=Type input: %=%


ECHO.
ECHO Do you want to disable Application Experience? This is required for running some very old applications, but disabling it can speed up program launch.
ECHO Press Y or N and then ENTER:
set disable_application_experience=
set /P disable_application_experience=Type input: %=%


ECHO.
ECHO Do you want to clear the currently pinned apps from the taskbar?
ECHO Press Y or N and then ENTER:
set clear_pinned_apps=
set /P clear_pinned_apps=Type input: %=%


ECHO.
ECHO Do you want to disable UAC? This reduces overall security but disables application launch popups.
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
ECHO Do you want to run DISM and SFC testing?
ECHO Press Y or N and then ENTER:
set dismsfc=
set /P dismsfc=Type input: %=%



ECHO.
ECHO Do you want to install group policy editor, if it's not already installed?
ECHO Press Y or N and then ENTER:
set installgpedit=
set /P installgpedit=Type input: %=%



:begin

ECHO.
ECHO.
ECHO Attempting to create System Restore Point prior to changes, please wait...
ECHO.
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Before Win1x_simplifier", 100, 7 | findstr /i /c:"ReturnValue = 0" > nul && goto skip_registry_backup

ECHO.
ECHO Unable to create System restore point, if System Restore is disabled for this computer it is highly-recommended that you enable system restore before continuing this script.
ECHO Would you like to do so now and then retry creating the restore point?
ECHO Press Y or N and then ENTER:
set redo=
set /P redo=Type input: %=%

IF "%redo%"=="y" (
	ECHO Please go into control panel, Recovery, and enable system restore for your system drive, then
	pause
	goto begin
)


ECHO Backing up registry in registry_backups subfolder instead, please note this recovery method is highly-problematic if it is relied upon...

md registry_backups
md registry_backups\%COMPUTERNAME%
cd registry_backups\%COMPUTERNAME%\

REG SAVE HKLM\SOFTWARE HKLMSOFTWARE.HIV /y
REG SAVE HKLM\SYSTEM HKLMSYSTEM.HIV /y
REG SAVE HKCU\SOFTWARE HKCUSOFTWARE.HIV /y
REG SAVE "HKCU\Control Panel" HKCUcontrol_panel.HIV /y
REG SAVE "HKCU\AppEvents" HKCUapp_events.HIV /y

cd ../..

:skip_registry_backup

ECHO.
ECHO ***Starting Changes:***
ECHO.



REM *** Run External Programs: ***


IF "%dismsfc%"=="y" (
	ECHO Checking Windows Image and restoring corrupt files if necessary:
	DISM /Online /Cleanup-image /Restorehealth
	sfc /scannow
)


ECHO Cleaning up the WinSxS folder:
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase


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



REM Install Agent Ransack if it is present, Disable Windows Search if Outlook is not installed:

IF EXIST "agentransack.msi" (
	ECHO Installing Agent Ransack
	IF "%ProgramFiles(x86)%"=="" (
		REM 32-bit system:
		start agentransack_x86.msi /quiet
	) ELSE (
		REM 64-bit system:
		start agentransack_x64.msi /quiet
	)

	set outlook=false

	IF EXIST "%ProgramFiles(x86)%\Microsoft Office" (
		where /Q /R "%ProgramFiles(x86)%\Microsoft Office" Outlook.exe && set outlook=true
	)

	IF EXIST "%ProgramFiles%\Microsoft Office" (
		where /Q /R "%ProgramFiles%\Microsoft Office" Outlook.exe && set outlook=true
	)

	IF EXIST "%systemdrive%\ProgramData\Microsoft\Windows\Start Menu\Programs\Outlook.lnk" set outlook=true

	IF "%outlook%"=="false" (
		ECHO Outlook not installed, disabling Windows Search
		sc stop "WSearch"
		sc config "WSearch" start= disabled
	)
)



If /I "%disable_superfetch%"=="y" (
	ECHO Disable Superfetch:
	sc stop "SysMain"
	sc config "SysMain" start=disabled
)



IF EXIST "Windows10SysPrepDebloater.ps1" (
	ECHO Running Windows10 Debloater:
	PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0Windows10SysPrepDebloater.ps1' -SysPrep -Privacy -Debloat" -Verb RunAs
)



IF EXIST "OOSU10.exe" (
	ECHO Running ShutUp10 with user-specified settings:
	OOSU10.exe ooshutup10.cfg /quiet
)



IF EXIST "OpenShellSetup.exe" (
	If /I "%winver%"=="11" (
		ECHO Installing OpenShell
		start OpenShellSetup.exe /quiet /norestart ADDLOCAL=StartMenu
	)
)


If /I "%freshinstall%"=="y" (
	goto skip_speedyfox
)


If /I "%newmachine%"=="y" (
	goto skip_speedyfox
)


IF EXIST "SpeedyFox.exe" (
	ECHO Running SpeedyFox:
	SpeedyFox.exe /Firefox:all /Thunderbird:all /Chrome:all /Skype:all /Opera:all
)

:skip_speedyfox



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
	PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0simplifier_desktop_to_solid_color.ps1'" -Verb RunAs
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



If /I "%disable_notifications%"=="y" (
	ECHO Disabling notification center:
	REG ADD "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableNotificationCenter /t REG_DWORD /d 1 /f

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




REM *** Begin main changes: ***

set winver=10
systeminfo | findstr /i /c:"windows 11" > nul && set winver=11

ECHO Doing the registry changes
If /I "%winver%"=="11" (
	regedit.exe /S simplifier_registry_changes_win11.reg
) ELSE (
	regedit.exe /S simplifier_registry_changes_win10.reg
)


ECHO Removing "Cast to Device" from right-click context menu
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /V {7AD84985-87B4-4a16-BE58-8B72A5B390F7} /T REG_SZ /D "Play to Menu" /F


ECHO Enabling F8 boot options
bcdedit /set {current} bootmenupolicy Legacy


ECHO Disabling system sounds
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0simplifier_disable_system_sounds.ps1'" -Verb RunAs


ECHO Disabling web search in taskbar/start
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0simplifier_disable_web_search.ps1'" -Verb RunAs


ECHO Remove M$ in-start-menu advertising for it's own online services
%systemdrive%
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
IF EXIST "MSN*.website" del /F "MSN*.website"
popd
pushd "%~dp0"



REM *** Do Power Management Changes ***

If /I "%hibernate_off%"=="y" (
	ECHO.
	ECHO Disabling Hibernation/Fast Boot
	powercfg -h off
	powercfg.exe -change -hibernate-timeout-dc 0
	powercfg.exe -change -hibernate-timeout-ac 0
)


ECHO Setting the 'Power Management' to Balanced
powercfg -SETACTIVE 381b4222-f694-41f0-9685-ff5bb260df2e


ECHO Setting min CPU state to 5% and max to 100% both for when on battery and plugged in
powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 5
powercfg -setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 5
powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100
powercfg -setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100


ECHO Setting wireless power settings as Medium for battery, Maximum for plugged in
powercfg /SETDCVALUEINDEX SCHEME_CURRENT 19cbb8fa-5279-450e-9fac-8a3d5fedd0c1 12bbebe6-58d6-4636-95bb-3217ef867c1a 0
powercfg /SETDCVALUEINDEX SCHEME_CURRENT 19cbb8fa-5279-450e-9fac-8a3d5fedd0c1 12bbebe6-58d6-4636-95bb-3217ef867c1a 2


ECHO Setting the unplugged settings to never hibernate
powercfg.exe -change -monitor-timeout-dc 5
powercfg.exe -change -standby-timeout-dc 15


ECHO Setting the plugged in settings to never sleep
powercfg.exe -change -monitor-timeout-ac 15
powercfg.exe -change -standby-timeout-ac 0


ECHO Setting the 'Dim Timeout' to Never
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 7516b95f-f776-4464-8c53-06167f40cc99 17aaa29b-8b43-4b94-aafe-35f64daaf1ee 0
powercfg -SETACVALUEINDEX SCHEME_CURRENT 7516b95f-f776-4464-8c53-06167f40cc99 17aaa29b-8b43-4b94-aafe-35f64daaf1ee 0


ECHO Set windows to do nothing when the lid is closed and it's plugged in, sleep when it's not
powercfg -SETACVALUEINDEX SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 1


ECHO Set windows to actually shut down when you press the power button, not just sleep
powercfg -SETACVALUEINDEX SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 3
powercfg -SETDCVALUEINDEX SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 3


ECHO Stop Windows from requiring sign-in when waking from sleep
powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 0
powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 0


IF NOT EXIST "%SystemRoot%\System32\gpedit.dll" (
	If /I "%installgpedit%"=="y" (
		ECHO Enabling Group Policy Editor
		dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~3*.mum >List.txt
		dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~3*.mum >>List.txt
		for /f %%i in ('findstr /i . List.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i"
	)
)


REM Optionally run defrag
If /I "%driveoptimize%"=="y" (
	ECHO.

	IF EXIST "MyDefrag.exe" (
		ECHO Running MyDefrag Monthly script on System drive
		MyDefrag.exe -v %SystemDrive% -r Scripts\SystemDiskMonthly.MyD
	) ELSE (
		ECHO Beginning optimisation/defrag of all drives
		Defrag.exe /C /B /O /M
	)
)


REM Loop until both ccleaner and bleachbit have finished running:
IF EXIST "CCleaner.exe" goto ccleaner_wait_loop
goto ccleaner_finished

:ccleaner_wait_loop
tasklist | findstr /i /c:"CCleaner" > nul && ECHO Waiting for CCleaner to stop running || goto ccleaner_finished
timeout /t 10
goto ccleaner_wait_loop

:ccleaner_finished


IF EXIST "bleachbit.exe" goto bleachbit_wait_loop
goto bleachbit_finished

:bleachbit_wait_loop
tasklist | findstr /i /c:"bleachbit" > nul && ECHO Waiting for Bleachbit to stop running || goto bleachbit_finished
timeout /t 10
goto bleachbit_wait_loop

:bleachbit_finished



REM Change working directory to back to original directory
popd


If /I "%reboot%"=="y" (
	ECHO Script finished, Rebooting
	shutdown /r
) ELSE (
	ECHO Simplifier Finished!
	start explorer.exe
	pause
)