@ECHO OFF

ECHO Warning: this may also revert any changes that've been made to your computer post-Simplifier, including program installations, settings changes and suchforth. Are you sure you want to continue?
ECHO Press Y or N and then ENTER (keys other than 'Y'/'y' will be intepreted as 'N'):
set continue=
set /P continue=Type input: %=%


If NOT /I "%continue%"=="y" (
	ECHO Cancelling...
	goto :end
)


powercfg -h on

ECHO Restoring settings... please wait, this will take a while
REG RESTORE HKLM\SOFTWARE %~dp0\HKLMSOFTWARE.HIV
REG RESTORE HKLM\SYSTEM %~dp0\HKLMSYSTEM.HIV
REG RESTORE HKCU\SOFTWARE %~dp0\HKCUSOFTWARE.HIV
REG RESTORE "HKCU\Control Panel" %~dp0\HKCUcontrol_panel.HIV
REG RESTORE "HKCU\AppEvents" %~dp0\HKCUapp_events.HIV


ECHO You will need to restart the computer in order for the changes to take effect. Would you like to do so now?
ECHO Press Y or N and then ENTER (keys other than 'Y'/'y' will be intepreted as 'N'):
set restart=
set /P restart=Type input: %=%


If /I "%restart%"=="y" (
	start shutdown /r
)

:end