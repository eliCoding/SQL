-- create DVD rental database
-- developed by Elmira Amanollahi on feb-08-2017


--switch using master DB
use master;

go

-- to create  database database_name following by parameter

create database DVDRental
on primary  
( -- row data name
 name= 'DVD_rental', filename='H:\Elmira\Winter Semester\SQL2\Elmira_DataBase\DVDRental_Elmira.mdf',
 -- row data sizem, growth size, maximum size
 size=10MB, filegrowth=1MB, maxsize=100MB 
)
log on 
( --log filename
 name= 'DVD_rental_log', 
 filename='H:\Elmira\Winter Semester\SQL2\Elmira_DataBase\DVDRental_Elmira_log.ldf',
 -- row data sizem, growth size, maximum size
 size=1MB, filegrowth=10%, maxsize=25MB 
);
go



--return information about the myDB2 database
execute sp_helpDB DVDRental
;
go

execute sp_helpDB
;
go