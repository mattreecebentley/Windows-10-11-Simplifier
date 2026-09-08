@ECHO OFF

pushd "%~dp0"

ECHO.
ECHO Simplifier registry backup for this computer not found in simplifier registry_backup subfolder, therefore (hopefully) a System Restore Point was created instead.
ECHO Running System Restore now, look for the restore point created at the date and time when you ran Win1x_simplifier.
ECHO If no restore point is available, sorry, no unsimplification is possible.
ECHO.

rstrui.exe

ECHO.
ECHO If System Restore does not launch properly, run it manually from 'Recovery' in Control Panel (or search Settings for Recovery).

:end
pause
popd
