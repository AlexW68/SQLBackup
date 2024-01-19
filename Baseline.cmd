REM set database name
set DATABASENAME=%1

set BACKUPFOLDER=C:\SQLBackups\Backups
set ONLINEFOLDER=C:\SQLBackups\Backups\Online

REM set filename based on today's date and time
set DATESTAMP=%DATE:~0,2%_%DATE:~3,2%_%DATE:~-4%_%TIME:~0,2%_%TIME:~3,2%

set DATESTAMP=%DATESTAMP: =0%



set BACKUPFILENAME=%BACKUPFOLDER%\%DATABASENAME%_BASELINE.bak
set ONLINE=%ONLINEFOLDER%\%DATABASENAME%_BASELINE.7z

REM Server name
set SERVERNAME=tcp:(local)\SQLExpress

if Not Exist %BACKUPFOLDER%\ MKDIR %BACKUPFOLDER%
if Not Exist %ONLINEFOLDER%\ MKDIR %ONLINEFOLDER%


REM delete the backup file if it already exists
Del %BACKUPFILENAME% /F

REM run the SQL backup
sqlcmd -E -S %SERVERNAME% -d master -Q "BACKUP DATABASE %DATABASENAME% TO DISK = N'%BACKUPFILENAME%' WITH FORMAT, MEDIANAME = '%1', NAME = 'Full Backup of %1'"

Del %ONLINE% /F

REM compress the backup file
7z a %ONLINE% %BACKUPFILENAME%