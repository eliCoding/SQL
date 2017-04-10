-- create Library database
/*developed by Elmira Amanollahi, Mike Yu,Laurian staicu on feb-17-2017*/


--switch using master DB
use master;

go


create database Libarary
on primary  
( -- row data name
 name= 'Library', filename='H:\Elmira\Winter Semester\SQL2\Assignment2\Library_Elmira_Mike_Laurian.mdf',
 -- row data sizem, growth size, maximum size
 size=10MB, filegrowth=1MB, maxsize=100MB 
)
log on 
( --log filename
 name= 'Library_log', 
 filename='H:\Elmira\Winter Semester\SQL2\Assignment2\Library_Elmira_Mike_Laurian.ldf',
 -- row data sizem, growth size, maximum size
 size=1MB, filegrowth=10%, maxsize=25MB 
);
go


execute sp_helpDB Libarary 
;
go
