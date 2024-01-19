REM set database name
set DATABASENAME=%1

REM set backup folder
set BACKUPFOLDER=C:\SQLBackups\Backups

REM set online folder
set ONLINEFOLDER=C:\SQLBackups\Backups\Online

REM set filename based on today's date and time
set DATESTAMP=%DATE:~0,2%_%DATE:~3,2%_%DATE:~-4%_%TIME:~0,2%_%TIME:~3,2%

REM replace spaces with 0
set DATESTAMP=%DATESTAMP: =0%

set BACKUPFILENAME=%BACKUPFOLDER%\%DATABASENAME%_%DATESTAMP%.bak
set BASELINE=%BACKUPFOLDER%\%DATABASENAME%_BASELINE.bak
set PATCHFILE=%BACKUPFOLDER%\%DATABASENAME%_%DATESTAMP%.patch
set ONLINEFILE=%ONLINEFOLDER%\%DATABASENAME%_%DATESTAMP%.patch.7z

REM Server name
set SERVERNAME=tcp:(local)\SQLExpress

REM create folders if they don't exist
if Not Exist %BACKUPFOLDER%\ MKDIR %BACKUPFOLDER%
if Not Exist %ONLINEFOLDER%\ MKDIR %ONLINEFOLDER%

REM delete the backup file if it already exists
Del %BACKUPFILENAME% /F

REM run the SQL backup
sqlcmd -E -S %SERVERNAME% -d master -Q "BACKUP DATABASE %DATABASENAME% TO DISK = N'%BACKUPFILENAME%' WITH FORMAT, MEDIANAME = '%1', NAME = 'Full Backup of %1'"

REM diff the file comparing the new backup to the baseline file
XDelta3 -e -s %BASELINE% %BACKUPFILENAME% %PATCHFILE%

REM compress the backup file
7z a %ONLINEFILE% %PATCHFILE%
