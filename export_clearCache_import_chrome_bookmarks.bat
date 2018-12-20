@ECHO off

TITLE Backup and restore chrome bookmarks on windows
REM ---------------------------------------------------------------------
REM * Below command will close all open chrome browsers.
REM ---------------------------------------------------------------------
taskkill /f /im chrome.exe
REM ---------------------------------------------------------------------
REM * Path for bookmark backup folder
REM ---------------------------------------------------------------------
SET userBookmarksPath=%HOMESHARE%\bookmarkBackups\%COMPUTERNAME%
REM ---------------------------------------------------------------------
REM * Chrome bookmark locations on user's machine.
REM ---------------------------------------------------------------------
SET bookmarkChrome=%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default
REM ---------------------------------------------------------------------
REM * Create folder to backup a computer's bookmarks to
REM ---------------------------------------------------------------------
IF NOT EXIST "%userBookmarksPath%" (
	mkdir "%userBookmarksPath%"
)
REM ---------------------------------------------------------------------
REM * Backup bookmarks
REM ---------------------------------------------------------------------
ROBOCOPY "%bookmarkChrome%" "%userBookmarksPath%" Bookmarks /COPY:DAT /DCOPY:T /R:1 /W:30 /NP
REM ---------------------------------------------------------------------
REM * save a script that opens the users chrome folder
REM ---------------------------------------------------------------------
ECHO explorer %USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\ > %userBookmarksPath%\openChromeFolder.bat
REM ---------------------------------------------------------------------
REM * Clean and clear chrome cache.
REM ---------------------------------------------------------------------
SET ChromeDir=C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data
DEL /q /s /f "%ChromeDir%"
RD /s /q "%ChromeDir%"
REM ---------------------------------------------------------------------
REM * Restore bookmark on chrome browsers.
REM ---------------------------------------------------------------------
ROBOCOPY "%userBookmarksPath%" "%bookmarkChrome%" Bookmarks /COPY:DAT /DCOPY:T /R:1 /W:30 /NP