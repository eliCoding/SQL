

/****** Object:  Database MyLibrary for assignment 2 in DataBase II

Script Date: 2017-02-17
developed by team: Mike Yu, Elmira and Laurian ******/

-- To build Database, tables and data input for each table


IF db_id('MyLibrary') IS NOT NULL
BEGIN
    SELECT 'database does exist'
	DROP DATABASE MyLibrary;
END
ELSE
BEGIN
    SELECT 'database does not exist'
END

CREATE DATABASE MyLibrary
on primary  
( -- row data name
 name= 'My_Library', 
 filename='E:\database II\database-sql\My_Library.mdf',
 -- row data sizem, growth size, maximum size
 size=10MB, filegrowth=1MB, maxsize=100MB 
)
log on 
( --log filename
 name= 'My_Library_log', 
 filename='E:\database II\database-sql\My_Library_log.ldf',
 -- row data sizem, growth size, maximum size
 size=1MB, filegrowth=10%, maxsize=25MB 
);
go
execute sp_helpDB MyLibrary
;
go

USE MyLibrary;
GO

/****** Object:  Schema [items]   ******/
CREATE SCHEMA items;
go
/****** Object:  Schema [loans]   ******/
CREATE SCHEMA lease;
go
/****** Object:  Schema [members] ******/
CREATE SCHEMA members;
go


/****** Object:  Table [items].[copy]  ******/
-- drop table [items].[Copy] ;
CREATE TABLE [items].[Copy](
	[ISBN] [int] NOT NULL,
	[CopyID] [int] NOT NULL,
	[titleID][int] NOT NULL,
	[OnLoan] [char](1) NOT NULL,
 CONSTRAINT [pk_copy] PRIMARY KEY CLUSTERED ([ISBN] ASC,[CopyID] ASC));
GO

BULK INSERT [items].[Copy] 
FROM 'C:\Users\Student\Desktop\poject 2\MyLibrary\copy.csv'
WITH
(
    FIRSTROW = 1,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
);
go

select * from [items].[Copy];
go

drop TABLE [items].[item];
/****** Object:  Table [items].[item] ******/
CREATE TABLE [items].[item](
	[ISBN] [int] NOT NULL,
	[titleID] [int] NOT NULL,
	[Language] [varchar](15) null,
	[cover] [varchar](15) null,
	[loanable] [char](1) NOT NULL,
 CONSTRAINT [pk_item] PRIMARY KEY CLUSTERED ([ISBN] ASC));
GO

BULK INSERT [items].[item] 
FROM 'C:\Users\Student\Desktop\poject 2\MyLibrary\item.csv'
WITH
(
    FIRSTROW = 1,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
);
go

select * from [items].[Item];
go

/****** Object:  Table [items].[title]  ******/

CREATE TABLE [items].[title](
	[titleID] [int] NOT NULL IDENTITY(1,1),
	[title] [varchar](100) NOT NULL,
	[author] [varchar](50) NOT NULL,
	-- [categoryID] [int] NULL,
	[synopsis] [varchar](400) NULL,
 CONSTRAINT [pk_title] PRIMARY KEY CLUSTERED ([titleID] ASC));
GO

BULK INSERT [items].[title]
FROM 'C:\Users\Student\Desktop\poject 2\MyLibrary\title.csv'
WITH
(
    FIRSTROW = 1,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
);
go

select * from [items].[title];
go


/****** Object:  Table [lease].[loan]  ******/

CREATE TABLE [lease].[loan](
	[ISBN] [int] NOT NULL,
	[CopyID] [int] NOT NULL,
	[titleID] [int] NOT NULL,
	[memberID][int]  NOT NULL,
	[out_date] [datetime] NOT NULL,
	[due_date] [datetime] not NULL,
 CONSTRAINT [PK_loan] PRIMARY KEY CLUSTERED ([ISBN],[CopyID]));
GO

--delete  from [lease].[loan];

BULK INSERT [lease].[loan]
FROM 'C:\Users\Student\Desktop\poject 2\MyLibrary\loan.csv'
WITH
(
    FIRSTROW = 1,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
);
go

update [lease].[loan]
set  out_date=dateadd(hour, 23, out_date);
update [lease].[loan]
set  out_date=dateadd(minute, 8, out_date);
update [lease].[loan]
set  due_date=dateadd(hour, 23, due_date);
update [lease].[loan]
set  due_date=dateadd(minute, 8, due_date);
select * from [lease].[loan];
go

drop TABLE [lease].[LoanHist];
/****** Object:  Table [lease].[LoanDetails] ******/
CREATE TABLE [lease].[LoanHist](
	[ISBN] [int] NOT NULL,
	[CopyID] [int] NOT NULL,
	[out_date] [datetime] NOT NULL,
	[titleID] [int] NOT NULL,
	[memberID][int]  NOT NULL,
	[due_date] [datetime] not NULL,
	[in_date] [datetime] not NULL,
	[fine_assessed] money NULL,
	[fine_paid] money NULL,
	[fine_waived] money NULL,
	[remarks] [varchar](200) NULL,
    CONSTRAINT [PK_LoanHist] PRIMARY KEY CLUSTERED ([ISBN] ASC,[CopyID] ASC,[out_date])) ;
GO

BULK INSERT [lease].[loanHist]
FROM 'C:\Users\Student\Desktop\poject 2\MyLibrary\loanhist.csv'
WITH
(
    FIRSTROW = 1,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n'  --Use to shift the control to next row
);
go

select * from [lease].[loanHist];
go

/****** Object:  Table [lease].[Reservation] ******/
-- drop table [lease].[reservation];
CREATE TABLE [lease].[reservation](
	-- [ReservationID] [int] identity(1,1),
	[ISBN] [int] NOT NULL,
	[memberID] [int] NOT NULL,
	[log_date] [datetime]  NULL,
--	[state] [varchar](15) null,
	[remarks] [varchar](200)  NULL,
 CONSTRAINT [pk_reservation] PRIMARY KEY CLUSTERED ([ISBN],[memberID]));
GO

BULK INSERT [lease].[reservation]
FROM 'C:\Users\Student\Desktop\poject 2\MyLibrary\reservation.csv'
WITH
(
    FIRSTROW = 1,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
);
go
update [lease].[reservation]
set  log_date=dateadd(hour, 23, log_date);
update [lease].[reservation]
set  log_date=dateadd(minute, 18, log_date);


select * from [lease].[reservation];
go

-- drop [members].[member];
/****** Object:  Table [members].[member]  ******/
CREATE TABLE [members].[member](
	[memberID] [int] not null identity(1,1),
	[lastname] [varchar](20) NOT NULL,
	[firstname] [varchar](20) NOT NULL,
	[middleinitial] [varchar](4) NULL,
	[photograph] [text] NULL,
	-- [AdultID] [int] NULL,
	-- [JuvenileID] [int] NULL,
 CONSTRAINT [pk_member] PRIMARY KEY CLUSTERED ([memberID] ASC));
 go

BULK INSERT  [members].[member]
FROM 'C:\Users\Student\Desktop\poject 2\MyLibrary\members.csv'
WITH
(
    FIRSTROW = 1,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
);
go
select * from  [members].[member];


/****** Object:  Table [members].[adult]  ******/

CREATE TABLE [members].[adult](
	[memberID] [int] NOT NULL,
	[street] [varchar](20) NOT NULL,
	[city] [varchar](20) NOT NULL,
	[state] [varchar](20) NOT NULL,
	[zip] [varchar](20)  NULL,
	[phoneID] [varchar](20) NULL,
--	[memberID] [int] not NULL,
--	[birth_date] [datetime] NOT NULL,	
	[expr_date] [datetime] NOT NULL,
 CONSTRAINT [pk_adult] PRIMARY KEY CLUSTERED ([memberID] ASC));
 go

BULK INSERT [members].[adult]
FROM 'C:\Users\Student\Desktop\poject 2\MyLibrary\adult.csv'
WITH
(
    FIRSTROW = 1,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
);
go

update [members].[adult]
set  expr_date=dateadd(hour, 23, expr_date);
update [members].[adult]
set  expr_date=dateadd(minute, 18, expr_date);


select * from [members].[adult];



/****** Object:  Table [members].[juvenile]  ******/

CREATE TABLE [members].[juvenile](
	[memberID] [int] NOT NULL,
    [AdultMemberID] [int] NOT NULL,
	[birth_date] [datetime] NOT NULL,
	-- [expr_date] [datetime] NOT NULL,
 CONSTRAINT [pk_juvenile] PRIMARY KEY CLUSTERED ([memberID] ASC));
GO

select * from  [members].[adult];
go

/****** Object:  Table [members].[juvenile]  ******/

-- drop [members].[juvenile];

CREATE TABLE [members].[juvenile](
	[memberID] [int] NOT NULL,
	[Adult_MemberID] [int] NOT NULL,
	[birth_date] [datetime] NOT NULL,
 CONSTRAINT [pk_juvenile] PRIMARY KEY CLUSTERED ([memberID] ASC));
GO

BULK INSERT [members].[juvenile]
FROM 'C:\Users\Student\Desktop\poject 2\MyLibrary\juvenile.csv'
WITH
(
    FIRSTROW = 1,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
);
go

select * from [members].[juvenile];



