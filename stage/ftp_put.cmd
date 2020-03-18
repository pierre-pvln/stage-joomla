:: Name:     ftp_put.cmd
:: Purpose:  Transfer files to downloadserver and updateserver using ftp
:: Author:   pierre@pvln.nl
::
:: Required environment variables
:: ==============================
:: - staging_command			  command incl path that is used transfer files to staging/download server
:: - output_dir                   the folder with files that are transfered (on local machine)
:: - temporary_folder             the folder where temporary files are stored (on local machine)
::
:: - downloadserver               the name or ip-address of the download server
:: - user_downloadserver          the username on the download server
:: - pw_downloadserver            the password for that user
:: - download_folder			  the folder where the files are stored in on the download server
::
:: - updateserver                 the name or ip-address of the update server
:: - user_updateserver            the username on the update server
:: - pw_updateserver              the password for that user
:: - update_folder                the folder where the files are stored in on the update server
::
:: - extensionprefix			  the prefix of the extension
:: - extension  e				  the extension name
:: - version                      the version of the extension

:: Remarks
:: ==============================
:: %~n0 = the name of this script
::
@ECHO off
::
:: Check if required environment variables are set. If not exit script.
::
IF "%staging_command%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] staging_command not set ...
   GOTO ERROR_EXIT_SUBSCRIPT
)
IF "%output_dir%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] output_dir not set ...
   GOTO ERROR_EXIT_SUBSCRIPT
)
IF "%downloadserver%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] downloadserver not set ...
   GOTO ERROR_EXIT_SUBSCRIPT
)
IF "%user_downloadserver%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] user_downloadserver not set ...
   GOTO ERROR_EXIT_SUBSCRIPT
)
IF "%pw_downloadserver%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] pw_downloadserver not set ...
   GOTO ERROR_EXIT_SUBSCRIPT
)
IF "%download_folder%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] update_folder not set ...
   GOTO ERROR_EXIT_SUBSCRIPT
)

IF "%updateserver%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] updateserver not set ...
   GOTO ERROR_EXIT_SUBSCRIPT
)
IF "%user_updateserver%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] user_updateserver not set ...
   GOTO ERROR_EXIT_SUBSCRIPT
)
IF "%pw_updateserver%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] pw_updateserver not set ...
   GOTO ERROR_EXIT_SUBSCRIPT
)
IF "%update_folder%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] update_folder not set ...
   GOTO ERROR_EXIT_SUBSCRIPT
)

IF "%temporary_folder%" == "" (
   SET ERROR_MESSAGE=[ERROR] [%~n0 ] temporary_folder not set ...
   GOTO ERROR_EXIT_SUBSCRIPT
)
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
:: Remove any existing %temporary_folder%\_update_files.txt file
::
IF EXIST "%temporary_folder%\_update_files.txt" (del "%temporary_folder%\_update_files.txt")
::
:: Create %temporary_folder%\_update_files.txt
::
echo %user_updateserver%>>%temporary_folder%\_update_files.txt
echo %pw_updateserver%>>%temporary_folder%\_update_files.txt
echo binary>>%temporary_folder%\_update_files.txt
echo cd %update_folder%>>%temporary_folder%\_update_files.txt
echo put %output_dir%\index.html>>%temporary_folder%\_update_files.txt
echo put %output_dir%\%extensionprefix%%extension%.xml>>%temporary_folder%\_update_files.txt
echo bye>>%temporary_folder%\_update_files.txt

:: run the actual FTP commandfile
ftp -s:%temporary_folder%\_update_files.txt %updateserver%

:: Remove any existing %temporary_folder%\_updte_files.txt file
del %temporary_folder%\_update_files.txt

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
:: Remove any existing %temporary_folder%\_download_files.txt file
::
IF EXIST "%temporary_folder%\_download_files.txt" (del "%temporary_folder%\_download_files.txt")
::
:: Create %temporary_folder%\_download_files.txt
::
echo %user_downloadserver%>>%temporary_folder%\_download_files.txt
echo %pw_downloadserver%>>%temporary_folder%\_download_files.txt
echo binary>>%temporary_folder%\_download_files.txt
echo cd %download_folder%>>%temporary_folder%\_download_files.txt
echo put %output_dir%\index.html>>%temporary_folder%\_download_files.txt
echo put %output_dir%\%extensionprefix%%extension%_%version%.zip>>%temporary_folder%\_download_files.txt
echo bye>>%temporary_folder%\_download_files.txt

:: run the actual FTP commandfile
ftp -s:%temporary_folder%\_download_files.txt %downloadserver%

:: Remove %temporary_folder%\_download_files.txt file
del %temporary_folder%\_download_files.txt

ECHO.
ECHO %me%: **************************************
ECHO %me%: %DATE% %TIME%
ECHO %me%: Done transferring the %extension% file(s)
ECHO %me%: **************************************
ECHO.

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
::timeout /T 5
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
::timeout /T 5
EXIT /B 0
