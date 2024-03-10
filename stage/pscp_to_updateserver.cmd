:: Name:     pscp_to_updateserver.cmd
:: Purpose:  Transfer files to updateserver using pscp
:: Author:   pierre@pvln.nl
::
:: Required environment variables
:: ==============================
::
:: - extensionprefix			the prefix of the extension
:: - extension   				the extension name
:: - version                    the version of the extension
::
:: - staging_command			command incl path that is used transfer files to staging/download server
:: - output_dir                 the folder with files that are transfered (on local machine)
:: - temporary_folder           the folder where temporary files are stored (on local machine)
::
:: - updateserver               the name or ip-address of the download server
:: - user_updateserver          the username on the download server
:: - pw_updateserver            the password for that user
:: - update_folder			    the folder where the files are stored in on the download server
::
:: Remarks
:: ==============================
:: %~n0 = the name of this script
::
@ECHO off
::
:: Check if required environment variables are set. If not exit script.
::

SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

:: !! Do not use " or ' at beginning or end of the list. 
:: Separate Vars with space. Var can not contain space in the name! 
SET CHECK_ENVIRONMENT_VARS_LIST=extensionprefix extension version staging_command output_dir temporary_folder updateserver user_updateserver pw_updateserver update_folder
SET ERROR_MESSAGE=NO_ERROR

FOR %%x IN (%CHECK_ENVIRONMENT_VARS_LIST%) DO (
	ECHO [INFO ] Checking for variable %%x ...
	CALL:CheckEnvVarHasValue %%x
	IF "!ERROR_MESSAGE!" NEQ "NO_ERROR" GOTO ERROR_EXIT_SUBSCRIPT
)

:: ==================
:: TO UPDATE SERVER
:: ==================
ECHO.
ECHO [INFO ] [%~n0 ] **************************************
ECHO [INFO ] [%~n0 ] %DATE% %TIME%
ECHO [INFO ] [%~n0 ] Start transferring the %extension% file(s) to the update server
ECHO [INFO ] [%~n0 ] **************************************
ECHO.
::
:: Run the script
"%staging_command%" -l %user_updateserver% -pw %pw_updateserver% %output_dir%\index.html %updateserver%:%update_folder%
"%staging_command%" -l %user_updateserver% -pw %pw_updateserver% %output_dir%\%extensionprefix%%extension%.xml %updateserver%:%update_folder%
"%staging_command%" -l %user_updateserver% -pw %pw_updateserver% %output_dir%\changelog.xml %updateserver%:%update_folder%

ECHO.
ECHO [INFO ] [%~n0 ] **************************************
ECHO [INFO ] [%~n0 ] %DATE% %TIME%
ECHO [INFO ] [%~n0 ] Done transferring the %extension% file(s)
ECHO [INFO ] [%~n0 ] **************************************
ECHO.

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO %ERROR_MESSAGE%
::timeout /T 5
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT   
::timeout /T 5
EXIT /B 0

::--------------------------------------------------------
::-- Function section starts below here
::--
::-- Inspiration: https://www.dostips.com/DtTutoFunctions.php
::-- 
::--------------------------------------------------------

:CheckEnvVarHasValue
::
:: Inspiration: https://stackoverflow.com/questions/9700256/bat-file-variable-contents-as-part-of-another-variable
::
:: Check if environment variables is set if not create error message.
IF "!%~1!" == "" SET "ERROR_MESSAGE=[ERROR] [%~n0 ] %~1 variable not set ..."
GOTO:EOF
