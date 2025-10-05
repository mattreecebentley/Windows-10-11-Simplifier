Windows 10/11 Simplifier Script
===============================


To Download:
------------

Download from github using the green 'Clone or Download' button. Save the resultant zip file and extract the zip to a folder.



Purpose:
--------

This is a set of settings changes and tweaks I regularly apply on new Windows machines, primarily to reduce the amount of 'noise' the user has to deal with. Many of my clients are elderly, and small things irk them.
With this in mind, there are a number of annoying Windows 10/11 features disabled, some silly default settings corrected, and visual effects are turned off (only those which slow the responsiveness of windows, and are unnecessary). Other than that, some useful scripts and programs external to this script will be run automatically if they're placed in the same folder.

Almost all of the settings can be changed back manually in 'Settings' or the Control Panel. In addition, a System Restore point is created on each run, so you can restore the system to exactly how it was prior to simplifying.

This script does not aim to be suitable for all people - so if there's a setting you dislike, edit the registry file, powershell file, or .bat file. Most settings are in the registry file, and all are clearly labeled.



To Run:
-------

Right-click on __Win1x_simplifier.bat and then left-click on "Run as Administrator". Follow the prompts.
Once the script is complete, you will need to restart the computer to see some of the changes (eg. visual effect changes).

Alternatively, run __Win1x_simplifier.bat from the command line with either "-all" or "-none" (without quotes) to respectively enable or disable all options (and avoid prompts). More command line options are available at bottom of page. You can use nircmd (http://www.nirsoft.net/utils/nircmd.html) to elevate this script to 'Run As Administrator' from the command prompt.

Win1x simplifier attempts to create a system restore point every time it runs. So to revert changes, simply run system restore (under windows settings) and restore to the restore point which matches the time you ran the script. Alternatively you can launch __Win1x_unsimplifier.bat (right-click then left-click "Run as Administrator") which attempts to launch system restore.

If you don't have system restore enabled on your computer, simplifier creates a backup of the registry in the simplifier folder under registry_backups\%computer_name% just in case. If you need to revert settings in this scenario, again run __Win1x_unsimplifier.bat and it will correctly select the specific registry backup based on the computer name. If multiple computers have the same internal name, they could overwrite each other's registry backup. Be warned, if you have made any major system changes after running simplifier this could brick your machine on restart. So where possible, have system restore enabled and use that instead.

If you run the scripts and later find that you liked having the Quick Access tree available in File Explorer, double-click on and Merge the _re-enable_quick_access.reg file, this will restore quick access. This is a common enough scenario that I've decided to include it.



This script disables:
---------------------

* people and task view buttons on taskbar
* zip/cab folders (if 7z installer present, see below)
* auto-hide scrollbars
* search button/tool on taskbar
* quick access folders in explorer
* duplicate instances of external/USB drives visible in explorer
* the ability for windows to change the sound scheme when changing themes
* login/lock-screen photos
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
* The "welcome experience" after large updates
* The "Get Even More Out of Windows" nagware screen (which tries to force MS account signup etc)
* Right-click context menu explorer options 'Give access to', 'Add to Libraries', 'Pin to Quick Access', 'Share with', 'Cast to Device' and 'Restore previous version'
* Cortana/Copilot searches
* Cortana icon on taskbar
* 3D Objects folder in explorer
* Web searchs from taskbar search
* 'Shake window to minimize' feature
* Edge desktop shortcut on new user accounts
* "Meet Now" button on taskbar
* Hiding of filename extensions (eg. .bat, .doc etcetera)
* Xbox Gamebar, game monitoring and notifications
* Non-critical Windows Defender notifications
* Play and Enqueue with Windows Media Player in right-click menu options for Folders
* Notifications for Chrome and Edge
* Old Copilot AI and associated buttons
* Most telemetry
* "Learn about this picture" icon on desktop
* (Win11) Widgets
* (Win11) Chat button
* (Win11) Snap/arrange bar at top of screen when dragging windows, snap layouts in general
* (Win11) AI 'Recall' "Feature"
* (Win11) "Unsupported device" message on desktop
* (Win11) Popup window when an application installer isn't from the app store
* (Win11) Settings page splash screen
* Lock screen (automatic if user password is blank, otherwise OPTIONAL - do not do this if your computer is likely to be used in a public area)
* Copilot App (OPTIONAL)
* Notification center and allowing apps like edge or photos to run in the background when closed (OPTIONAL)
* Fast boot and hibernation (to allow updates to be processed on shutdown rather than forcing restarts) (OPTIONAL)
* Hiding of system tray icons (OPTIONAL)
* Automatic changing of Explorer folder layouts based on folder contents eg. Pictures folder displays thumbnails (OPTIONAL)
* Application Experience (required for some older apps, disabling may speed up program launches) (OPTIONAL)
* Autoplay/autorun on all drives (OPTIONAL)
* User Account Control (please read this: https://insights.sei.cmu.edu/cert/2015/07/the-risks-of-disabling-the-windows-uac.html regards the risks before disabling) - most noticable impact to the user is the removal of the box that pops up when you try to install/launch a program (OPTIONAL)
* Requiring the user to login when waking from sleep/hibernate mode (OPTIONAL)
* Superfetch (sysmain) (OPTIONAL)
* Onedrive (OPTIONAL)



Other changes this script makes:
--------------------------------

* Changes default control panel view to large icons rather than categorized
* Sets power scheme to 'Balanced'
* Changes power timeouts for screen off to 15min when plugged in (or a desktop), or 5min when not plugged in
* Changes power timeouts for sleep to Never when plugged in (or a desktop), or 15min when not plugged in
* Sets wireless power use to maximum when plugged in, medium when not
* Sets minimum and maximum CPU states to 5% and 100% respectively, regardless of whether plugged in
* Tells windows to shutdown when the power button is pressed, instead of sleep (regardless of whether it's plugged in or a laptop)
* Tells windows to do nothing when the lid of a laptop is closed, if it's plugged in (and to sleep if it's not)
* Minimum/maximum unparked CPU cores option enabled in power management settings (control panel) and set to 0%/12% min on battery/power
* Makes 'This PC' the default opening point of windows explorer
* Win7's Windows photo viewer is enabled as an option for viewing photos and pictures
* Enables accent colors on title bars, but not taskbars
* Sets the Explorer ribbon to be shown by default
* Enables PS2 mouse/keyboard support (after reboot)
* Enables the F8-button-triggered Advanced boot menu at startup (if fast boot is disabled in UEFI)
* Stops Windows Defender from using more than 20% (average) CPU during scans
* Changes colour mode to Dark while keeping apps Light (ie. custom)
* (Win11) Move start menu to left instead of center
* (Win11) Allow any apps to be installed by default, not just Windows Store apps
* (Win11) Add creating a .txt file from right-click menu back into windows
* (Win11) Restore 'show desktop' button in bottom-right of taskbar
* (Win11) Enables 'verbose' startup/shutdown messages
* (Win11) Get Win10-style right-click explorer menu back (OPTIONAL)
* Cleans the WinSxS folder of redundant files using DISM (OPTIONAL)
* Decrypts any drives currently encrypted using Bitlocker, to speed up disk access by up to 45% and make troubleshooting less of a pain (OPTIONAL)
* Re-enables the option to be able to login without password in netplwiz (OPTIONAL - again, do not do this if your computer is likely to be used in a public area or contains sensitive information)
* Defrags/Optimizes all hard drives in computer. Uses mydefrag.exe if present, otherwise will use defrag.exe and only run TRIM command on SSD drives (OPTIONAL)
* Runs "DISM /Online /Cleanup-image /Restorehealth" followed by "sfc /scannow" to fix any potential Windows system file issues (occasionally, this actually fixes stuff) (OPTIONAL)
* Enables Group Policy Editor (gpedit.msc) for all versions of Windows (OPTIONAL)
* Runs chkdsk /f or chkdsk /f /r on system drive on next boot. Runs powershell command to show status of hard drives beforehand (OPTIONAL)
* Changes desktop background to a solid color - plum color by default (OPTIONAL)
* Reboots once script has finished (OPTIONAL)
* Checks disk for filesystem errors and bad sectors on the next reboot (OPTIONAL)
* Clears pinned apps from taskbar (OPTIONAL)
* If Onedrive is removed (one of the optional disabling options above), revert user folders like Documents to original location eg. c:\users\username\Documents, and move all data out of the Onedrive subfolders and into those folders. Files stored within the Onedrive root folder (eg. c:\users\Owner\Onedrive\*.*) get moved to a subfolder under Documents called 'onedrive'. (OPTIONAL)



Other scripts/executables this script will optionally run, if present in the same folder:
-----------------------------------------------------------------------------------------

* Agent Ransack (https://www.mythicsoft.com/agentransack/) will be installed silently and the Windows Search service disabled if the MSI versions of the installers are present in the same folder under the names "agentransack_x86.exe" and "agentransack_x64.msi" for 32-bit and 64-bit versions respectively. Windows Search will only be disabled if Outlook is not present on the system.
* Coretemp (https://www.alcpu.com/CoreTemp/) to check for CPU overheating. For compatibility across computers I recommend getting the 32-bit portable version (under 'other downloads').
* HDDScan (http://hddscan.com/) to check hard drive health.
* Stop Resetting My Apps (https://www.carifred.com/stop_resetting_my_apps/) to prevent windows updates from resetting default apps to Microsoft's preference. Note: I strongly recommend against using Method 2 in this app, as it tends to screw up associations, use Method 1 instead.
* PC Decrapifier 2.3.1 (https://www.bleepingcomputer.com/download/pc-decrapifier/) for easy uninstallation of programs. File must be named "pc-decrapifier-2.3.1.exe".
* Autoruns by Sysinternals (https://docs.microsoft.com/en-us/sysinternals/downloads/autoruns) for easy disabling of startup processes. If 64-bit windows is detected it will run the 64-bit version, so include both executables.
* 7zip (https://www.7-zip.org/) will be installed silently and zip/cab folders disabled if installers are placed in folder. Please rename 32-bit version of 7z installer '7z.exe' and 64-bit version '7z-x64.exe'. If 64-bit windows is detected it will install the 64-bit version, so include both executables.
* Windows 11 Debloater by Raphire (https://github.com/Raphire/Win11Debloat). This works on Win10 also and is preferred to Windows 10 Debloater as it does a better job of not removing selected apps like Mail. Uses the custom list already included in the simplifier folder (do not overwrite unless customising).
* Windows 10 Debloater by Sycnex (https://github.com/Sycnex/Windows10Debloater), with the following options enabled: -SysPrep -Privacy -Debloat (this will also disable cortana). This is disabled from running on Windows 11 as it causes issues with 24H2. Uses the custom-apps list in the simplifier folder (do not overwrite this). Simplifier will run this instead of Win11 Debloater if it exists in the simplifier folder and Win10 is detected.
* Windows 10 Black Viper Services Tweaks script by Madbomb122 (https://github.com/madbomb122/BlackViperScript/releases) - Safe values Only. Do Not overwrite the blackviper.csv file already present in the simplifier folder. As of time of writing this script also works fine with Win11.
* ShutUp10 by O&O (https://www.oo-software.com/en/shutup10/) - user must have exported their desired settings to "ooshutup10.cfg" and both this file and ShutUp10 must be in the same folder as Win1x-simplifier. Note that settings will differ between home and pro versions of Win10. At time of writing this tool also works with Win11.
* MyDefrag by J.C. Kessels (https://www.majorgeeks.com/files/details/mydefrag.html) - will (optionally - do not use on an SSD) run 'Monthly' defrag script on C: if it and it's "Scripts" folder are in the same folder as Win1x-simplifier. Be aware there is a 64-bit and 32-bit version of mydefrag - it's installer will install the relevant one based on your computer. Use the 32-bit .exe for broader compatibility. You can customise the scripts so that the program will exit once the defrag is complete, look up it's documentation to achieve this.
* Speedyfox by Crystal Idea (https://www.crystalidea.com/speedyfox) - will automatically defrag/compact the database files for opera, firefox, chrome, skype, thunderbird.
* Openshell by Ivo Beltchev (https://github.com/Open-Shell/Open-Shell-Menu) will be installed silently if the installer is in the same folder and renamed to oss.exe. Only the openshell start menu will be installed. Openshell installation restarts the explorer.exe process, thus why this installer is run at the very end of the script.
* Old Windows Calculator (https://winaero.com/blog/get-calculator-from-windows-8-and-windows-7-in-windows-10/) will be installed if the installer is in the same folder and renamed to oldcalc.exe.
* Windows 7 versions of games (https://www.majorgeeks.com/files/details/windows_7_games_for_windows_10.html) will be installed if the installer is in the same folder and renamed to win7games.exe.
* Kaspersky Rootkit Scanner (https://usa.kaspersky.com/content/custom/global/tdsskiller/tdsskiller.html).
* Malwarebytes Adware Cleaner (https://www.malwarebytes.com/adwcleaner).



Other scripts/executables this script will optionally run, if present in subfolders as described:
-------------------------------------------------------------------------------------------------

* Bleachbit portable (https://bleachbit.org), if extracted to subfolder "bleachbit" within the simplifier folder.
* Ccleaner portable by Piriform (https://www.ccleaner.com/ccleaner/builds), if extracted to subfolder "ccleaner" within the simplifier folder. Will run on automatic settings (ie. whatever settings you last used with ccleaner portable) in the background while the rest of the tasks complete. If 64-bit windows is detected it will run the 64-bit version, so include both executables. If the system is already running ccleaner (eg. in system tray) it will be terminated before running ccleaner portable.



Additional Command Line Options:
--------------------------------

The following can be used to run the script without prompts:

* -all - enables all options
* -none - disables all options
* -freshinstall - enables disablenotifications, reboot, solidcolordesktop, disableae, clearpinnedapps, avoids some tests and dism/sfc
* -newcomputer - freshinstall + avoids some additional tasks such as chkdsk

If any of the above are specified, all other command line options will be ignored.
If any other command line options below are specified, it is assumed that any unspecified options are 'off' (same as '-none' above). The individual command line options are:

* -defrag - enables defrag/optimization/trim of all drives in computer. Uses windows defrag, or mydefrag.exe if present.
* -disablenotifications - disables notifications center and prevents background apps from running
* -disablehibernation - disables hibernation/fast boot
* -reboot - reboot computer once script is finished.
* -solidcolordesktop - changes windows desktop background to a solid color
* -chkdsk - check system disk for filesystem errors and bad sectors on next reboot
* -chkdskf - check system disk for filesystem errors only on next reboot (useful for SSDs)
* -showtrayitems - disable hiding of system tray icons
* -disablefoldertemplates - stop windows from changing explorer folder layouts based on folder contents
* -disableae - disable Application Experience (this service is required for some older apps)
* -clearpinnedapps - clears all currently-pinned apps from the taskbar
* -[convenientinsecurity](https://www.youtube.com/watch?v=38sRaDDMD5A) - disables User Account Control and lock screens, re-enables the option to login without password within netplwiz, disables requiring the user to login when waking from sleep/hibernate mode
* -cleanwinsxs - cleans windows winsxs folder of old updates and drivers.
* -disablesuperfetch - disables Superfetch (sysmain)
* -dismsfc - runs DISM and SFC tests
* -installgpedit - installs group policy editor on all versions of windows (can take a while on slower machines)
* -uninstallonedrive - uninstalls Onedrive
* -restoreuserfolders - will only be used if -uninstallonedrive is specified. When Onedrive is uninstalled, revert the user folder locations (eg. Documents) to their default locations (eg. c:\users\Owner\Documents) and move all files from the Onedrive subfolders (eg. c:\users\Owner\Onedrive\Documents) to the default locations. Moves files stored directly within the Onedrive folder itself (eg. c:\users\Owner\Onedrive\*.*) to a subfolder under Documents called 'onedrive'.
* -oldrightclick - removes the simplified version of the right-click menu in Windows 11, replaces it with the Windows 10-style menu ie. what you get in windows 11 if you click on 'more options'


Current bugs:
--------------

Not a bug for my script, but currently the 'safe' setting of madbomb's blackviper services script turns off wifi on desktop machines. To work around this, I've created my own version of the blackviper.csv file - do not overwrite this. Feel free to complain at the author.
And again, not a bug for my script, but Win10debloater removes the camera app by default, which some MS webcams rely on for functionality. For this reason I've included my own custom whitelist/blacklist for Win10_debloater which keeps the Camera app. Win10Debloater still removes the mail and xbox overlay apps even when whitelisted but it is easy to reinstall those from the windows app store.

One known script bug: one some machines, when it reaches the section where the script turns off locks screens if the user password is blank, it just pauses for no known reason - pressing Enter makes the script proceed if this happens. It is unknown what causes this at present.


Additional Notes:
-----------------

Report on Bitlocker slowing down SSD drives by up to 45% here: https://www.tomshardware.com/news/windows-software-bitlocker-slows-performance

This script has been tested on Windows 11 24H2, 23H2, 22H2 and Windows 10 22H2, 22H1, 21H2, 20H2, 2004, 1909, 1903, 1809 and 1803, but not 1709 or lower.
I have not included any scripts to check for updates because from 1803 onwards, Windows 10/11 puts the user's computer in an update beta-tester channel if they click on 'Check for Updates' manually, and there is no good information about how to bypass or disable this. Good job Microsoft! You Really know what you're Doing!!! Really!

https://www.howtogeek.com/fyi/watch-out-clicking-check-for-updates-still-installs-unstable-updates-on-windows-10/

I originally automated disk cleanup, but it was not possible to reliably get it to clean up 'Update storage' or 'Old Windows installation' between Win10 versions. Also the disk cleanup tool is being deprecated in future win10 vers. But you can always run disk cleanup manually later at your leisure once updates have completed. Background apps are only turned off if the notification center is disabled, as the notification center will not function if background apps are disabled as of 1809. However if you don't want to disable notifications, you can still go into settings and disable individual background apps.


Unfortunately I've had to remove the optional Windows defender disabling component, as too many antivirus engines were detecting it as malware! Look up "Dcontrol" on the net as an alternative.

This script is under a Creative Commons Attribution 3.0 New Zealand License (https://creativecommons.org/licenses/by/3.0/nz/)

Thanks go out to the multudinous sources of the registry hacks and powershell scripts, ranging from Stackoverflow to Winaero to tenforums/elevenforums. Thanks to microsoft for making 2020 the year of the linux desktop.

Matt Bentley 2024