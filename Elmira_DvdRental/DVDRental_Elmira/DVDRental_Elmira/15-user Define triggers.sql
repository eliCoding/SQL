/* user define Triggers
		Script Date: February 21,2017
		Developed by: Elmira Amnollahi
		*/

use Northwind;
go

/* display  a msg when anyone modifies or insert data in table Sales.customer
create a trigger notifyCustomerTr */

if OBJECT_ID('Sales.notifyCustomerTr','Tr') is not null
	drop trigger Sales.notifyCustomerTr
;
go

/*Partial Syntax:
	create trigger schema_name.trigger_name
	on table_name
	[after][Insert] | [Update][delete]

as
	sql statement
*/

create trigger Sales.notifyCustomerTr
on [Sales].[Customers]
	after insert, update
as
	raiserror('Customer table was modified',16,10)
;
go

/*testing Sales.notifyCustomerTr  / change the contact name for the  customer ID 'ALFKI'*/

select *
from dbo.[Customers]
-- where CustomerID = 'ALFKI'
;
go


update dbo.[Customers]
set ContactName = 'Anna Trump' -- Ronald Trump
where CustomerID = 'ALFKI'
;
go

/* create a trigger (checkModifiedDateTr) that checks the modified date.
 it ensures that during the insert of a new department , the modified date is the current 
 date. if it is not, the row is updated, setting the modified date to the current date and time
*/

/* first let;s create the deparmtnet table*/
if OBJECT_ID('Department', 'U') is not null
	drop table Departmenrs
;
go

create table Departments
(
	DepartmentID int identity (1,1) not null,
	Department nvarchar(60) not null,
	ModifiedDate datetime null,
	constraint pk_Departments primary key clustered (DepartmentID asc)
) 
;
go

/* Display the definition of the table Departments*/

exec sp_help Departments
;
go


select * from Departments
;
go



/*insert a new row in the table Departments */
insert into Departments (Department)
values ('IT')
;
go


/*create trigger checkModifiedDateTr*/

if OBJECT_ID('dbo.checkModifiedDateTr', 'tr') is not null
	drop trigger dbo.checkModifiedDateTr
;
go

create trigger checkModifiedDateTr
on  Departments
for insert,update
as
	begin
		-- declare variable
		declare @ModifiedDate as datetime,
		@DepartmentID as int 
		-- compure return value
		select @ModifiedDate = ModifiedDate,
			@DepartmentID = DepartmentID 
		from inserted
		-- making decision 
		if (abs((DATEDIFF(day,@ModifiedDate,GETDATE()))) > 0
		or  (@ModifiedDate is null)) 
			begin
				-- set the modified date to the current Date
				update Departments
				set ModifiedDate = GETDATE() 
				where DepartmentID = @DepartmentID
				print '**** Modified Date value was Modifies ****'

			end
	end
;
go

/* Inserting new into the table Departments*/

	insert into Departments (Department,ModifiedDate)
	values ('Marketing', '2014/2/13')
;
go

insert into Departments (Department,ModifiedDate)
	values ('HR', '2018/2/13')
;
go

insert into Departments (Department,ModifiedDate)
	values ('Sales', '2015/2/13')
;
go

select * from Departments


/* Create EmployeeData And AuditEmployeeData*/

if exists
(
	select table_name 
	from Information_Schema.Tables
	where TABLE_NAME = 'EmployeeData'
)
	drop table EmployeeData
;
go

create table EmployeeData
(
	EmpID int not null,
	BankAccountNumber char(10) not null,
	Salary smallmoney not null,
	EmpSIN char(11) not null,
	lastName nvarchar(30) not null,
	Firstname nvarchar(30) not null,
	ManagerID int not null
)
;
go

if exists
(
	select table_name 
	from Information_Schema.Tables
	where TABLE_NAME = 'AuditEmployeeData'
)
	drop table EmployeeData
;
go



create table AuditEmployeeData (
	AuditLogID uniqueIdentifier  default newid(),
	LogType char(3) not null,
	EmployeeID int not null,
	AuditBankAccountNumber char(10) not null,
	AuditSalary smallmoney not null,
	AuditEmpSIN char(11) not null,

	/*return the login nAME Associated with a 
	 security identifiation number SID
	*/
	AuditUser sysname default suser_name(),
	AuditChanged datetime default getdate()
)
;
go

/* Create trrigger getAuditEmployeeTr*/

if OBJECT_ID('getAuditEmployeeTr','Tr') is not null
	drop trigger getAuditEmployeeTr
;
go

create trigger getAuditEmployeeTr
on EmployeeData
for update
as
	begin 

	-- audit old data
		
		insert into AuditEmployeeData
		(
			LogType,
			EmployeeID,
			AuditBankAccountNumber,
			AuditSalary,
			AuditEmpSIN	
			
		)
	select 'old' as 'Salary Status',
		del.EmpID,
		del.BankAccountNumber,
		del.Salary,
		del.EmpSIN
		from deleted as del
	select 'new' as 'Salary Status',
		ins.EmpID,
		ins.BankAccountNumber,
		ins.Salary,
		ins.EmpSIN
		from inserted as ins
	end
;
go


/* add a new row in the table EmployeeData*/

insert into  [dbo].[EmployeeData](EmpID,[BankAccountNumber],[Salary],[EmpSIN],
[lastName],[Firstname],[ManagerID])
values (101,'E-1234556',45000,'123 567 897','Mendel','Ronald', 32)
;
go

select * from [dbo].[EmployeeData]
select * from [dbo].[AuditEmployeeData]


/* update the salary Date for employee number 101*/


update [dbo].[EmployeeData]
set Salary = 86000
where [EmpID] = 101
;
go


/* to enable or disable trigger*/
disable trigger getAuditEmployeeTr on EmployeeData
;
go



