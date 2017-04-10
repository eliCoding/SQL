/*user define functions  
		Script Date: February 17,2017
		Developed by: Elmria Amnollahi
		*/


	/* a User defined  dunction (UDF) is a Transaction-SQL )T-SQL) statement that returns parameters,performs an action, such as calculation, and returns the result of that action as a value.
	The return value can either be a Scalar (Single) or a stable.
	*/
	-- switch to the current Database 
	use Northwind2014
	;
	go

	/*Create a  fucntion [HumanResources].[Employees]getEmployeeSeniorityFn that returns 
	the employee seniority
	*/
	/*if the function getEmployeeSeniorityFn exists, then  drop it and recreate it*/

	if OBJECT_ID('[HumanResources].[Employees]', 'FN') is not null
	drop function HumanResources.getEmployeeSenioritiFn
	;
	go


	create function HumanResources.getEmployeeSenioritiFn
	( 
	    @HireDate as datetime
	)
	returns int
	as
	   begin
	       -- Declare the return variable
		   declare @Seniority as int; 
		   -- compute the return value
		   select @Seniority = DATEDIFF(year, @HireDate, getDate());
		   -- return the result to the function caller
		   return @Seniority;
	   end
	;
	go

	/*Testing function HumanResources.HumanResources.getEmployeeSenioritiFn*/

	/*Display the seniority of Northwind Empoyees*/

	select [EmployeeID],[FirstName],[LastName],[HireDate],HumanResources.getEmployeeSenioritiFn     ([HireDate]) as 'Seniority'
	from [HumanResources].[Employees]
	where [EmployeeID] = 1
	;
	go


	/*How old are you?*/

	select HumanResources.getEmployeeSenioritiFn('1965/08/07')
	;
	go


/*How long did it taKE TO SHIP an order? create getNumberOfDayfn that 
returns the number of days between the order datee and the ship date, Drop the function if exists.
*/

	
if OBJECT_ID('[Sales].[Orders]', 'FN') is not null
	drop function Sales.getNumberOfDayfn
	;
	go

create function Sales.getNumberOfDayfn
	(
	@startDate as datetime,
	@EndDate as datetime

	)
	returns int

	as
	     begin 
		 --  declarethe return variable
		 declare @NumberOfDays  as int
		 -- compute the return value
		 select  @NumberOfDays = abs(datediff(day, @startDate ,@EndDate))
		 -- return 
		 return @NumberOfDays;

		 end
;
go



/*Call the function sale.getNumberOfDayfn*/

select [OrderID],[OrderDate],[ShippedDate],
Sales.getNumberOfDayfn([OrderDate],[ShippedDate]) as 'Number of Dys to ship'
from [Sales].[Orders]
-- where [OrderID] = 1048

where [OrderID] between 10248 and 10250
;
go


/*Create a function getNAMEfn that returns the full employee name, and phone number*/


if OBJECT_ID('[HumanResources].[Employees]','FN') is not null
drop function HumanResources.getNAMEfn
;
go

create	FUNCTION HumanResources.getNAMEfn
	(
	  @EmployeeID AS int
	)
	returns varchar(60)
	as
	 begin
	   declare @EmployeeName as varchar(60)
	   
	   select @EmployeeName= CONCAT([FirstName],'',[LastName])
	   from [HumanResources].[Employees]
	  
	   return @EmployeeName
	 end
	 ;
	 go

/*call the HumanResources.getNAMEfn */
select  HumanResources.getNAMEfn([EmployeeID]) as 'Full name' ,[HomePhone],[Extension]
from [HumanResources].[Employees]
where EmployeeID = 2
;
go


/*modify the HumanResources.getNAMEfn */
alter FUNCTION HumanResources.getNAMEfn
	(
	  @EmployeeID AS int
	)
	returns varchar(60)
	as
	 begin
	   declare @EmployeeName as varchar(60)
	   
	   select @EmployeeName= CONCAT([FirstName],'',[LastName])
	   from [HumanResources].[Employees]
	   where  @EmployeeID = [EmployeeID]
	   return @EmployeeName
	 end
	 ;
	 go


	 /*create a function production.getInventoryStockFn That takes one argument(product ID), and returns a single date value (the stock value)*/

if OBJECT_ID('[Production].[Products]','FN') is not null
drop function production.getInventoryStockFn
;
go

	create function production.getInventoryStockFn
	(
	  @ProductID as int
	)
	returns int
	as
	    begin
		 declare @stocklevel as int

		 select @stocklevel = [UnitsInStock] + [UnitsOnOrder]
		 from [Production].[Products]
		 where  @ProductID = [ProductID]
		 return @stocklevel
		end
;
go


select [ProductID],[ProductName],production.getInventoryStockFn (ProductID) as 'Stock Level'

from [Production].[Products]
where ProductID between 1 and 10
;
go



