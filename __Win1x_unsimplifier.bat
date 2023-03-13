@ECHO OFF

pushd "%~dp0"

IF EXIST "registry_backups\%COMPUTERNAME%" goto reg_restore

ECHO.
ECHO Simplifier registry backup for this computer not found in simplifier registry_backup subfolder, therefore (hopefully) a System Restore Point was created instead.
ECHO Running System Restore now, look for the restore point created at the date and time when you ran Win1x_simplifier.
ECHO If no restore point is available, sorry, no unsimplification is possible.
ECHO.

rstrui.exe

ECHO.
ECHO If System Restore does not launch properly, run it manually from 'Recovery' in Control Panel (or search Settings for Recovery).

goto end

:reg_restore

ECHO Restoring registry backup...
ECHO.
ECHO.
ECHO WARNING: If system restore is enabled on your system it is explicitly recommended that you run System Restore and restore the restore point matching the time you ran Win1x simplifier. This batch file is a last resort in case you've run Win1x simplifier, want to reverse changes but didn't have System Restore enabled.
ECHO.
ECHO MAJOR WARNING: If you have made any changes to your system after using Win1x simplifier eg. installing updates, drivers or programs, making other modifications to the operating system, continuing here may cause your system to no longer boot. Win1x simplifier is not responsible for any problems caused by continuing here. In addition it is recommend to run this procedure from a safe mode boot (run msconfig, go to boot tab, restart).
ECHO.
ECHO.
ECHO Are you sure you want to continue?
ECHO Press Y or N and then ENTER:
set continue=
set /P continue=Type input: %=%


If /I "%continue%"=="n" (
	ECHO Cancelling...
	goto :end
)


ECHO Restoring settings... please wait, this will take a while

cd registry_backups\%COMPUTERNAME%

REG RESTORE HKLM\SOFTWARE HKLMSOFTWARE.HIV
REG RESTORE HKLM\SYSTEM HKLMSYSTEM.HIV
REG RESTORE HKCU\SOFTWARE HKCUSOFTWARE.HIV
REG RESTORE "HKCU\Control Panel" HKCUcontrol_panel.HIV
REG RESTORE "HKCU\AppEvents" HKCUapp_events.HIV


ECHO You will need to restart the computer in order for the changes to take effect. Would you like to do so now? Please note that if you do not reboot, you may experience instability and weirdness in Windows until you reboot. Not joking.
ECHO Press Y or N and then ENTER (keys other than 'Y'/'y' will be intepreted as 'N'):
set restart=
set /P restart=Type input: %=%


If /I "%restart%"=="y" (
	start shutdown /r
)

:end
pause
popd
