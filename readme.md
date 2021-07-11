Windows 10 Simplifier Script
============================


To Download:
------------

Download from github using the green 'Clone or Download' button. Save the resultant zip file and extract the zip to a folder.



Purpose:
--------

This is a set of settings changes and tweaks I regularly apply on new Windows 10 machines, primarily to reduce the amount of 'noise' the user has to deal with. Many of my clients are elderly, and small things irk them.
With this in mind, there are a number of annoying Windows 10 features disabled, some silly default settings corrected, and visual effects are turned off (only those which slow the responsiveness of windows, and are unnecessary). Other than that, some useful scripts and programs external to this script will be run automatically if they're placed in the same folder.

Almost all of the settings can be changed back manually in 'Settings' or the Control Panel (the real "settings"). In addition, all settings are backed up in registry files prior to execution and will be restored if the user runs the 'unsimplifier' .bat. However those registry files are written to the same folder, so will be overwritten if you use the script, for example, on more than one computer from an external drive.

This script does not aim to be suitable for all people - so if there's a setting you dislike, edit the registry file, powershell file, or .bat file. Most settings are in the registry file, and all are clearly labeled.



To Run:
-------

Right-click on __Win10_simplifier.bat and then left-click on "Run as Administrator". Follow the prompts.
Once the script is complete, you will need to restart the computer to see some of the changes (eg. visual effect changes).

Alternatively, run __Win10_simplifier.bat from the command line with either "-all" or "-none" (without quotes) to respectively enable or disable all options (and avoid prompts). More command line options are available at bottom of page. You can use nircmd (http://www.nirsoft.net/utils/nircmd.html) to elevate this script to 'Run As Administrator' from the command prompt.

To revert changes, right-click on __Win10_unsimplifier.bat and then left-click on "Run as Administrator". The registry settings will be restored. Any changes made by external scripts or programs may or may not be reverted. You will be prompted to restart the computer.



This script disables:
---------------------

* game mode notifications
* people and task view buttons on taskbar
* zip/cab folders (if 7z installer present, see below)
* auto-hide scrollbars
* search button/tool on taskbar
* quick access folders in explorer
* duplicate instances of external/USB drives visible in explorer
* the ability for windows to change the sound scheme when changing themes
* login/lock screen screen photos
* lock screen
* combining of taskbar buttons
* transparency of windows and taskbar
* windows startup sound
* windows sounds (sound scheme is set to 'No Sounds', sound scheme tab is removed)
* Remote assistance (does not affect apps like teamviewer)
* Window animation
* Taskbar animations
* Control/element animation
* Fade or slide UI elements into view
* Fade in/out UI objects
* Smooth-scroll list boxes
* Sliding comboboxes
* Background picture on login screen
* Notifications on lock screen
* Reminders on lock screen
* "News and interests" button on taskbar
* Microsoft Office web app links on start menu
* "Tips, tricks and suggestions" after you receive updates
* The windows 10 "welcome experience" after large updates
* The "Get Even More Out of Windows" nagware screen (which tries to force MS account signup etc)
* Right-click context menu explorer options 'Give access to', 'Add to Libraries', 'Pin to Quick Access', 'Share with', 'Cast to Device' and 'Restore previous version'
* Cortana searches
* Cortana icon on taskbar
* 3D Objects folder in explorer
* Web searchs from taskbar search
* Xbox Gamebar and game monitoring
* 'Shake window to minimize' feature
* Edge desktop shortcut on new user accounts
* "Meet Now" button on taskbar
* Hiding of filename extensions (eg. .bat, .doc etcetera)
* Notification center and allowing apps like edge or photos to run in the background when closed (OPTIONAL)
* Fast boot (to allow updates to be processed on shutdown rather than forcing restarts) (OPTIONAL)
* Hibernation and removes the hibernation file (OPTIONAL)
* Hiding of system tray icons (OPTIONAL)
* Automatically changing of Explorer folder layouts based on folder contents eg. mp3s (OPTIONAL)
* Application Experience (required for some older apps, disabling may speed up program launches) (OPTIONAL)
* Autoplay/autorun on all drives (OPTIONAL)
* User Account Control (please read this: https://insights.sei.cmu.edu/cert/2015/07/the-risks-of-disabling-the-windows-uac.html before disabling) - most noticable impact of this is the removal of the box that pops up when you try to install/launch a program (OPTIONAL)
* Superfetch (sysmain) (OPTIONAL)
* Onedrive (OPTIONAL)
* Microsoft Edge (OPTIONAL)



Other changes this script makes (for all versions of Windows 10):
-----------------------------------------------------------------

* Re-enables the option to login without password in "control userpasswords2" or netplwiz
* Changes default control panel view to large icons rather than categorized
* Enables Group Policy Editor (gpedit.msc) for all versions of Windows 10
* Quality updates are deferred by 1 month
* Feature updates are deferred by 1 year
* Update-Ring level changed to "Semi-Annual Channel" (non-beta-tester "professional" branch)
* Runs "DISM /Online /Cleanup-image /Restorehealth" followed by "sfc /scannow" to fix any potential Windows system file issues (sometimes, this actually fixes stuff! Crazy huh)
* Sets power scheme to 'Balanced'
* Changes power timeouts for screen off to 15min when plugged in (or a desktop), or 5min when not plugged in
* Changes power timeouts for sleep to Never when plugged in (or a desktop), or 15min when not plugged in
* Tells windows to shutdown when the power button is pressed, instead of sleep (regardless of whether it's plugged in or a laptop)
* Tells windows to do nothing when the lid of a laptop is closed, if it's plugged in (and to sleep if it's not)
* Makes 'This PC' the default opening point of windows explorer
* Win7's Windows photo viewer is enabled as an option for viewing photos and pictures
* Enables accent colors on title bars, but not taskbars
* Sets the Explorer ribbon to be shown by default
* Enables PS2 mouse/keyboard support (after reboot)
* Enables the F8-button-triggered Advanced boot menu at startup (if fast boot is disabled in UEFI)
* Changes desktop background to a solid color - plum color by default (OPTIONAL)
* Reboots once script has finished (OPTIONAL)
* Checks disk for filesystem errors and bad sectors on the next reboot (OPTIONAL)
* Clears pinned apps from taskbar (OPTIONAL)



Other scripts/executables this script will optionally run, if present in the same folder:
-----------------------------------------------------------------------------------------

* Agent Ransack (https://www.mythicsoft.com/agentransack/) will be installed silently and the Windows Search service disabled if both 32-bit and 64-bit MSI installer files are present in the same folder under the names "agentransack.msi" and "agentransack-x64.msi". Windows Search will only be disabled if Outlook is not present on the system.
* Coretemp (https://www.alcpu.com/CoreTemp/) to check for CPU overheating. For compatibility across computers I recommend getting the 32-bit portable version.
* HDDScan (http://hddscan.com/) to check hard drive health.
* Stop Resetting My Apps (https://www.carifred.com/stop_resetting_my_apps/) to prevent windows updates from resetting default apps to Microsoft's preference.
* Ccleaner portable by Piriform (https://www.ccleaner.com/ccleaner/builds) on automatic settings (ie. whatever settings you last used with ccleaner portable) will run in the background while the rest of the tasks complete, if extracted to the same folder as Win10-simplifier. If 64-bit win10 is detected it will run the 64-bit version, so include both executables.
* PC Decrapifier 2.3.1 (https://www.bleepingcomputer.com/download/pc-decrapifier/) for easy uninstallation of programs. File must be named "pc-decrapifier-2.3.1.exe".
* Autoruns by Sysinternals (https://docs.microsoft.com/en-us/sysinternals/downloads/autoruns) for easy disabling of startup processes. If 64-bit win10 is detected it will run the 64-bit version, so include both executables.
* 7zip (https://www.7-zip.org/) will be installed silently and zip/cab folders disabled if installers are placed in folder. Please rename 32-bit version of 7z installer '7z.exe' and 64-bit version '7z-x64.exe'. If 64-bit win10 is detected it will install the 64-bit version, so include both executables.
* Windows 10 Debloater by Sycnex (https://github.com/Sycnex/Windows10Debloater) with the following options enabled: -SysPrep -Privacy -Debloat (this will also disable cortana).
* Windows 10 Black Viper Services Tweaks script by Madbomb122 (https://github.com/madbomb122/BlackViperScript/releases) if placed in same folder - Safe values Only. Do Not overwrite the blackviper.csv file already present in the simplifier folder.
* ShutUp10 by O&O (https://www.oo-software.com/en/shutup10/) - user must have exported their desired settings to "ooshutup10.cfg" and both this file and ShutUp10 must be in the same folder as Win10-simplifier. Note that settings will differ between home and pro versions of Win10.
* MyDefrag by J.C. Kessels (https://www.majorgeeks.com/files/details/mydefrag.html) - will (optionally - do not use on an SSD) run 'Monthly' defrag script on C: if it and it's "Scripts" folder are in the same folder as Win10-simplifier. Be aware there is a 64-bit and 32-bit version of mydefrag - it's installer will install the relevant one based on your computer. Use the 32-bit .exe for broader compatibility.
* Speedyfox by Crystal Idea (https://www.crystalidea.com/speedyfox) - will automatically defrag/compact the database files for opera, firefox, chrome, skype, thunderbird.
* Openshell by Ivo Beltchev (https://github.com/Open-Shell/Open-Shell-Menu) will be installed silently if the installer is in the same folder and renamed to OpenShellSetup.exe. Only the openshell start menu will be installed. Openshell installation restarts the explorer.exe process, thus why this installer is run at the very end of the script.
* Old Windows Calculator (https://winaero.com/blog/get-calculator-from-windows-8-and-windows-7-in-windows-10/) will be installed if the installer is in the same folder and renamed to oldcalc.exe.
* Windows 7 versions of games (https://www.majorgeeks.com/files/details/windows_7_games_for_windows_10.html) will be installed if the installer is in the same folder and renamed to win7games.exe.


Additional Command Line Options:
--------------------------------

The following can be used to run the script without prompts:

* -all - enables all options
* -none - disables all options
* -freshinstall - enables disablenotifications, reboot, solidcolordesktop, disableae, clearpinnedapps, uninstalledge, avoids some tests and dism/sfc
* -newcomputer - freshinstall + avoids some additional tasks such as chkdsk

If any of the above are specified, all other command line options will be ignored.
If any other command line options below are specified, it is assumed that any unspecified options are 'off' (same as '-none' above). The individual command line options are:

* -defrag - enables defrag using mydefrag with a monthly script at end of all scripts
* -disablenotifications - disables notifications center and prevents background apps from running
* -disablehibernation - disables hibernation/fast boot
* -reboot - reboot computer once script is finished. Will only occur if mydefrag is not run.
* -solidcolordesktop - changes windows desktop background to a solid color
* -chkdsk - check system disk for filesystem errors and bad sectors on next reboot
* -showtrayitems - disable hiding of system tray icons
* -disablefoldertemplates - stop windows from changing explorer folder layouts based on folder contents
* -disableae - disable Application Experience (this service is required for some older apps)
* -clearpinnedapps - clears all currently-pinned apps from the taskbar
* -disableuac - disables User Account Control
* -disablesuperfetch - disables Superfetch (sysmain)
* -uninstallonedrive - uninstalls Onedrive
* -uninstalledge - removes Chromium Edge

The -reboot and -defrag options are mutually exclusive. Specifically, if -defrag is specified, -reboot will be disabled.



Current bugs:
--------------

I've noticed that the enabling of F8 on boot doesn't work on some machines, windows won't run bcdedit from the elevated batch file even though it'll run it from an elevated command prompt. However this is rare.

Not a bug for my script, but currently the 'safe' setting of madbomb's blackviper services script turns off wifi on desktop machines. To work around this, I've created my own version of the blackviper.csv file - do not overwrite this. Feel free to complain at the author.
And again, not a bug for my script, but Win10debloater removes the camera app by default, which some MS webcams rely on for functionality. For this reason I've included my own custom whitelist/blacklist for Win10_debloater which keeps the Camera app.



Additional Notes:
-----------------

This script has been tested on Windows 10 20H2, 2004, 1909, 1903, 1809 and 1803, but not 1709 or lower.
I have not included any scripts to check for updates because from 1803 onwards, Windows 10 puts the user into a beta-tester role if they click on 'Check for Updates' manually, and there is no good information about how to bypass or disable this. Good job Microsoft! You Really know what you're Doing!!! Really!!!! Top marks

https://www.howtogeek.com/fyi/watch-out-clicking-check-for-updates-still-installs-unstable-updates-on-windows-10/

I originally automated disk cleanup, but it was not possible to reliably get it to clean up 'Update storage' or 'Old Windows installation' between Win10 versions. Also the disk cleanup tool is being deprecated in future win10 vers. But you can always run disk cleanup manually later at your leisure once updates have completed. Background apps are only turned off if the notification center is disabled, as the notification center will not function if background apps are disabled as of 1809. However if you don't want to disable notifications, you can still go into settings and disable individual background apps.


Unfortunately I've had to move the optional Windows defender disabling component to a different repo, as too many antivirus engines were detecting it as malware!
See here: https://www.github.com/mattreecebentley/win10_disable_defender

This script is under a Creative Commons Attribution 3.0 New Zealand License (https://creativecommons.org/licenses/by/3.0/nz/)

Thanks go out to the multudinous sources of the registry hacks and powershell scripts, ranging from Stackoverflow to Winaero to tenforums. Thanks to microsoft for making 2020 the year of the linux desktop.

Matt Bentley 2021