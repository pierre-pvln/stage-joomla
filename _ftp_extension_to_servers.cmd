:: Name:     05_ftp_extension_to_servers.cmd
:: Purpose:  FTP files to updateserver
:: Author:   pierre.veelen@pvln.nl
:: Revision: 2017 03 26 - initial version
::           2018 02 09 - folderstructure changed
::           2018 07 21 - update and download servers added
::           2018 07 24 - build process unified and extension as environment variable
::           2018 08 21 - ftp script filename changed to include name of the extension
::                      - error handling for non existing settings files added
::

@ECHO off
SETLOCAL ENABLEEXTENSIONS

:: BASIC SETTINGS
:: ==============
:: Setting the name of the script
SET me=%~n0
:: Setting the name of the directory with this script
SET parent=%~p0
:: Setting the drive of this commandfile
SET drive=%~d0
:: Setting the directory and drive of this commandfile
SET cmd_dir=%~dp0

:: Setting for Error messages
::SET ERROR_MESSAGE=errorfree

:: STATIC VARIABLES
:: ================
CD ..\04_settings\

IF EXIST 00_name.cmd (
   CALL 00_name.cmd
) ELSE (
   SET ERROR_MESSAGE=File with extension name settings doesn't exist
   GOTO ERROR_EXIT
)

IF EXIST 02_version.cmd (
   CALL 02_version.cmd
) ELSE (
   SET ERROR_MESSAGE=File with version info settings doesn't exist
   GOTO ERROR_EXIT
)

IF EXIST 04_folders.cmd (
   CALL 04_folders.cmd
) ELSE (
   SET ERROR_MESSAGE=File with folder settings doesn't exist
   GOTO ERROR_EXIT
)

::call ..\04_settings\00_name.cmd
::call ..\04_settings\02_version.cmd
::call ..\04_settings\04_folders.cmd

cd ..\..\..\_secrets
IF EXIST ftp_%extension%_settings.cmd (
   CALL ftp_%extension%_settings.cmd
) ELSE (
   SET ERROR_MESSAGE=File with ftp settings for this extension doesn't exist
   GOTO ERROR_EXIT
)

::call ftp_%extension%_settings.cmd
cd "%cmd_dir%"

::IF %ERROR_MESSAGE% NEQ errorfree GOTO ERROR_EXIT
::
:: UPDATE SERVER
:: =============
ECHO.
ECHO %me%: **************************************
ECHO %me%: %DATE% %TIME%
ECHO %me%: Start transferring the %extension% file(s) to the update server
ECHO %me%: **************************************
ECHO.
::
:: Create ..\04_settings\_ftp_files.txt
::
:: remove any existing ..\04_settings\_ftp_files.txt file
IF EXIST "..\04_settings\_ftp_files.txt" (del "..\04_settings\_ftp_files.txt")

echo %ftp_user_updateserver%>>..\04_settings\_ftp_files.txt
echo %ftp_pw_updateserver%>>..\04_settings\_ftp_files.txt
echo binary>>..\04_settings\_ftp_files.txt
echo cd %ftp_update_folder%>>..\04_settings\_ftp_files.txt
echo put %output_dir%\index.html>>..\04_settings\_ftp_files.txt
echo put %output_dir%\%extensionprefix%%extension%.xml>>..\04_settings\_ftp_files.txt
echo bye>>..\04_settings\_ftp_files.txt

:: run the actual FTP commandfile
ftp -s:..\04_settings\_ftp_files.txt %ftp_updateserver%

del ..\04_settings\_ftp_files.txt

::
:: DOWNLOAD SERVER
:: =============
ECHO.
ECHO %me%: **************************************
ECHO %me%: %DATE% %TIME%
ECHO %me%: Start transferring the %extension% file(s) to the download server
ECHO %me%: **************************************
ECHO.
::
:: Create ..\04_settings\_ftp_files.txt
::
:: remove any existing ..\04_settings\_ftp_files.txt file
IF EXIST "..\04_settings\_ftp_files.txt" (del "..\04_settings\_ftp_files.txt")

echo %ftp_user_downloadserver%>>..\04_settings\_ftp_files.txt
echo %ftp_pw_downloadserver%>>..\04_settings\_ftp_files.txt
echo binary>>..\04_settings\_ftp_files.txt
echo cd %ftp_download_folder%>>..\04_settings\_ftp_files.txt
echo put %output_dir%\index.html>>..\04_settings\_ftp_files.txt
echo put %output_dir%\%extensionprefix%%extension%_%version%.zip>>..\04_settings\_ftp_files.txt
echo bye>>..\04_settings\_ftp_files.txt

:: run the actual FTP commandfile
ftp -s:..\04_settings\_ftp_files.txt %ftp_downloadserver%

del ..\04_settings\_ftp_files.txt

ECHO.
ECHO %me%: **************************************
ECHO %me%: %DATE% %TIME%
ECHO %me%: Done transferring the %extension% file(s)
ECHO %me%: **************************************
ECHO.

GOTO CLEAN_EXIT

:ERROR_EXIT
cd "%cmd_dir%" 
:: remove any existing _ftp_files.txt file
IF EXIST "..\04_settings\_ftp_files.txt" (del "..\04_settings\_ftp_files.txt")
ECHO *******************
ECHO Error: %ERROR_MESSAGE%
ECHO *******************

   
:CLEAN_EXIT
:: Wait some time and exit the script
::
timeout /T 10
