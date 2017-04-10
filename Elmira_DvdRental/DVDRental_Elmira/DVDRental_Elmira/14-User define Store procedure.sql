/* user define Store Procedures
		Script Date: February 20,2017
		Developed by: Elmira Amnollahi
		*/

/*syntax :
	create proc[edure] schema_name precedure_name
	([paramerter_list])
	as
		sql statement
*/
/*create a precedure tht return the database name. Drop procedure if exists*/

if OBJECT_ID('Sales.getDatabaseName','p') is not null
drop procedure Sales.getDatabaseName
;
go


create proc Sales.getDatabaseName 
as 
	select DB_NAME()
;
go

/* call the procedure Sales.getDatabaseName*/

exec Sales.getDatabaseName 
;
go


/* modify the procedure Sales.getDatabaseName and add an input parameter to make procedure more flexible*/

alter proc Sales.getDatabaseName 

	(
	    @Database_ID as int	
	
	)
	as
	select DB_NAME(@Database_ID) as 'Database Name'

;
go


exec Sales.getDatabaseName @Database_ID = 2
;
go

/* Create a procedure getAllEmplyeeSP that returns the last name,first name and employee title*/

if OBJECT_ID('HumanResources.getAllEmplyeeSP','p') is not null
drop procedure HumanResources.getAllEmplyeeSP
;
go

create proc HumanResources.getAllEmplyeeSP
as 
	begin
	select[FirstName],[LastName],[Title]
	from [HumanResources].[Employees] as E
	end
;
go

/*call*/
exec HumanResources.getAllEmplyeeSP
;
go


/* create a procedure HumanResources.getEmoployeesBynameSP that
returns the last name, first name, and title by selecting the 
employee number(iD)

*/
if OBJECT_ID('HumanResources.getEmoployeesBynameSP','p') is not null
drop procedure HumanResources.getEmoployeesBynameSP
;
go


create proc HumanResources.getEmoployeesBynameSP
(
	@EmployeeID as int
)

as 
	select E.[FirstName],E.[LastName],E.[Title]
	from [HumanResources].[Employees] as E
	where E.EmployeeID =@EmployeeID
;
go

/*call */
exec HumanResources.getEmoployeesBynameSP @EmployeeID= 1
;
go


/* create a procedure getEmployeeByTitleSP that returns the employee full name, the title by assigning  the title*/

-- drop procedure if exists 'HumanResources.getEmployeeByTitleSP'








create proc HumanResources.getEmployeeByTitleSP
(
	@Title as nvarchar(60)
)


	as 
		select CONCAT(E.[FirstName] , '' ,E. [LastName]) as				'Full Name',[Title]
		from [HumanResources].[Employees] as E
		where e.Title = @Title
;
go


alter proc HumanResources.getEmployeeByTitleSP
(
	@Title as nvarchar(60)
)


	as 
		select CONCAT(E.[FirstName] , '' ,E. [LastName]) as				'Full Name',[Title]
		from [HumanResources].[Employees] as E
		where e.Title like @Title
;
go

exec HumanResources.getEmployeeByTitleSP @title =  'Sales%'
;
go

/*Create  a store procedure getEmployeeByTitleAndCirySP that returns the employee full name, the title and the city by assigning the title and the city*/

if OBJECT_ID('HumanResources.getEmployeeByTitleAndCitySP','p') is not null
drop procedure HumanResources.getEmployeeByTitleAndCitySP
;
go

create proc getEmployeeByTitleAndCitySP

	(
	 @Title nvarchar(60),
	 @City nvarchar(60)	
	
	)

as 
	begin
     select E.[Title], CONCAT(E.[FirstName] , '' ,E. [LastName]) as	'Full Name',e.City
	 from [HumanResources].[Employees] as E
	 where  e.Title like @Title and e.City like  @City
	 end
;
go

exec getEmployeeByTitleAndCitySP @Title = 'Sales%', @City = 'Seattle'
;
go


/* Create the procedure getEmoployeenamesWithoutEncryptionSP*/
if OBJECT_ID('HumanResources.getEmoployeenamesWithoutEncryptionSP','P') is not null 
drop proc HumanResources.getEmoployeenamesWithoutEncryptionSP
;
go

create proc HumanResources.getEmoployeenamesWithoutEncryptionSP
as
	select E.firstName , E.LastName
	from [HumanResources].[Employees] as E

;
go

/* Create the procedure getEmoployeenamesWithEncryptionSP*/
if OBJECT_ID('HumanResources.getEmoployeenamesWithEncryptionSP','P') is not null 
drop proc HumanResources.getEmoployeenamesWithEncryptionSP

;
go

create proc HumanResources.getEmoployeenamesWithEncryptionSP
with encryption
as
	select E.firstName , E.LastName
	from [HumanResources].[Employees] as E

;
go

/* return  the definition  of the procedure 
HumanResources.getEmoployeenamesWithEncryptionSP
*/
exec sp_helptext 'HumanResources.getEmoployeenamesWithEncryptionSP'
;
go


select * 
from [HumanResources].[Employees]
;
go



/*Create a new table myEmployees: EmployeeID, firstName, lastName, title, and hireDate*/

	create table HumanResources.myEmployees
	(
	   EmplyeeID int identity (1,1) not null ,
	   firstName nvarchar(30) not null,
	   LastName nvarchar(30) not null,
	   title nvarchar(30) not null,
	   hireDate datetime not null,
	   constraint pk_myemployeea primary key clustered (EmplyeeID)
		
	)
;
go

/*create a procedure  InsertEmployeeSP that inser a newe record into table [HumanResources].[Employees]*/


if OBJECT_ID('HumanResources.InsertEmployeeSP', 'p')
is not null 
drop proc HumanResources.InsertEmployeeSP
;
go

create proc HumanResources.InsertEmployeeSP
(
	@firstName as nvarchar(30),
	@LastName as nvarchar(30),
	@title as nvarchar(60),
	@hireDate as date


)
as 
	insert  into  HumanResources.myEmployees (firstName,[LastName],[title],[hireDate])
	values (@firstName,@LastName,@title,@hireDate)
	
;
go


exec HumanResources.InsertEmployeeSP
	@firstName = 'Elmira'
	,@LastName = 'Amanollahi'
	,@title = 'Sales Representative'
	,@hireDate = '2017/02/03'
;
go
    


select * 
from HumanResources.myEmployees
;
go


/*  Create a procedure getProductListSP that returns a list of products that unit prices do not exeed a specified amount*/

if OBJECT_ID('Production.getProductListSP', 'p')
is not null 
drop proc Production.getProductListSP
;
go

create proc Production.getProductListSP
(
	@ProductName as nvarchar(40),	
	@MaxPrice as smallmoney,
	@comparePrice as smallmoney output, 
	@ListPrice as smallmoney out
)
as
	select P.[ProductName] as 'Product', P.UnitPrice as 'List Price'
	from [Production].[Products] as p
	inner join [Sales].[Order Details] as OD 
	on p.ProductID = OD.ProductID
	where P.ProductName like @ProductName 
			and OD.UnitPrice < @MaxPrice
	-- populate the out put paramete @ListPrice
	set @ListPrice = 
	(
		select max(P.UnitPrice)
		from [Production].[Products] as P
		inner join [Sales].[Order Details] as OD
		on OD.ProductID = P.ProductID
		where P.ProductName like @ProductName
			and OD.UnitPrice < @MaxPrice		
	)
	-- populate the parameter @comparePrice 
	set @comparePrice  = @MaxPrice

	
;
go



-- Declare variable
	declare @comparePrice as smallmoney,
	        @Cost as smallmoney
	exec Production.getProductListSP '%Mishi%',100,@comparePrice out,@Cost out
	if (
		@Cost <=@comparePrice)
		begin 
			print 'These products can be puechased for less than $' + rtrim(cast(@comparePrice as varchar(20))) + '.'
		end
	else
		print ' The prices for all products in this category exceed $' +
		rtrim(cast(@ComparePrice  as varchar(20))) + '.'
	
	
;
go











