# SQLBackup
Backup Scripts for backing up SQL Server databases

This project is 3 different batch files for Windows, it uses 7-zip and Xdelta3

https://www.7-zip.org/

http://xdelta.org/

Backup.cmd databasename

This creates a SQL Database full backup, it places this file in a folder, then compresses it to a second folder, the idea being that you can backup the second folder to online storage, each file is the database name with date and time in the name. This script only uses 7-zip.

Baseline.cmd databasename 

This create a SQL Database full backup, it does a very similar job to the Backup.cmd file, main difference is it puts BASELINE into the file name, it then compresses it to a second folder.

Diff.cmd database
This needs Baseline.cmd run once first, this then creates a new full backup, it compares it to the baseline version creates a patch file, then compresses the patch file to a second folder.

Depending on how much online storage you have and your database sizes, Backup.cmd might be enough for your needs, you will have complete copies of your database backups for many points in time. If you want to diff/patch your backups, this will give you the best storage usage. All you need is the baseline database uncompressed, and any patch file to build the full backup back to any point in time.







