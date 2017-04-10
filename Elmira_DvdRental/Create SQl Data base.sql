-- switch to master data base
use master;

go
--create my db3 database
/*syntax:
create database database_name

*/

create database myDB3
on primary 
(
-- rows data name
name = 'MyDB3',
-- path and rows data filename
filename = 'H:\Elmira\Winter Semester\SQL2\Elmira_DataBase\myDB3.mdf',
-- rows data size
size = 5MB,
-- rows data autogrowth
filegrowth = 1MB, 
-- maximum Rows data size
maxsize =100MB

)
log on (
-- log file name 
name = 'MyDB3_log',
--path and log filename
filename = 'H:\Elmira\Winter Semester\SQL2\Elmira_DataBase\myDB3_log.ldf',
-- log file size
size = 1MB,
-- log autogrowth
filegrowth = 10%,
 -- maximum log data size
maxsize =25MB
)
;
go

-- delete MyDB3
drop database myDB3
;
go

-- return information about the my DB2 data base
execute sp_helpDB myDB3
;
go

-- return information about all data base
execute sp_helpDB 
;
go
