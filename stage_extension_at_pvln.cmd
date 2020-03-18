:: Name:     stage_extension_at_pvln.cmd
:: Purpose:  set enviroment and run deploy script 
:: Author:   pierre@pvln.nl
:: Revision: 2019 02 11 - initial version
::           2020 03 15 - new folder structure
::

@ECHO off

:: Setting required environment variables:
::
SET extension_name=ipheiongraphs

:: Where to put the files on the staging/download server
SET download_folder=/download/joomla/modules/ipheiongraphs/
SET update_folder=/update/joomla/modules/ipheiongraphs/

:: Where to find the secrets
SET secrets_folder=..\..\..\_secrets

:: -OUTPUT DIRECTORY FOR BUILD = INPUT DIRECTORY FOR STAGING
:: do not start with \ , and do not end with \
SET output_dir=..\_bin

::
:: Assume psftp should be used first. Then pscp. If not available choose ftp
::

:: !! Do not use " or ' at beginning or end of the list
::    Do not use sftp as the password can't be entered from batch files   
SET CHECK_TRANSFER_LIST=psftp pscp ftp

CALL stage_files.cmd
