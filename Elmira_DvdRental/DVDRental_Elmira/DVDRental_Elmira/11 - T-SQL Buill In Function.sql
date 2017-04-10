	/* built in functions 
		Script Date: February 16,2017
		Developed by: Elmria Amnollahi
		*/

	use Northwind2014
	;
	go


	/* Date and Time Built in Function*/

	/*Return the year of an order*/
	select [OrderID],year([OrderDate]), MONTH ([OrderDate]), DAY([OrderDate]),DATENAME(WEEKDAY,OrderDate) AS 'Day Of week' ,[OrderDate]
	from [Sales].[Orders]
	where year([OrderDate]) in (2016, 2017)
	;
	go

	/*how long it took to ship an order */
	select [OrderID],[OrderDate],[RequiredDate],[ShippedDate]
	,datediff(day,OrderDate,ShippedDate) as 'Days to ship'
	from [Sales].[Orders]
	;
	go

	/*Logical Functions*/
	/*IsNumeric() returns 1 if the expresion is convertable to any numeric type, otherWise it returns 0*/


	select [EmployeeID],[FirstName],[LastName],[PostalCode]
	from [HumanResources].[Employees]
	where  ISNUMERIC([PostalCode]) =1
	;
	go


	/*Immediate if (IIF) 
	IIF(condition), true_value,falseValue */

	/*Check if the product UNIt Price in under 50 then display 'Low Price', OtherWise 'High Price '*/

select [ProductID],[ProductName],[UnitPrice],
IIF( [UnitPrice] > 50 , 'High Price', 'Low Price') as 'Price point'
from [Production].[Products]
;
go

/* using the case clause to return a simple expression that determines the the result*/
select  [ProductID],[ProductName],[UnitPrice],
'Price Range' = 
     case 
	    when UnitPrice = 0 then 'Item not for Resale'
		when UnitPrice < 50 then 'Unit Price Under $50'
		when UnitPrice between 50 and 250  then'Unit Price Under $250'
		when UnitPrice between 250 and 1000 then 'Unit Price Under $1000'
		else 'Unit Price over $1000'
	end
from [Production].[Products]


/* Choose returns the item at the specified index from a list of values in SQL 
Syntax: choose (index, val1, valu1,...)
*/

select CHOOSE(2,'Manager','Director', 'Developer', 'Tester')
;
go

select [CategoryID],[CategoryName],choose([CategoryID],'A','B','C','D','E')
from [Production].[Categories]
;
go
/* ISNull replaces null value with the specified replacement value 
IsNull(check_Expresion,replacemenr_value)*/


/*return the customer Address*/
select [CompanyName],[Address],[City],isnull([Region],'Unknown') as 'Region',[PostalCode],[Country]
from [Sales].[Customers]
;
go

/*return the full  customer Address*/
select [CompanyName],isnull(([Address]+' '+[City]+' '+[Region]),'Unknown') as 'Full Address',[PostalCode],[Country]
from [Sales].[Customers]
;
go
-- it returns all the value together null !!!! not good


/*return the full  customer Address*/
select [CompanyName],concat([Address],' ',[City],' ',[Region]) as 'Full Address',[PostalCode],[Country]
from [Sales].[Customers]
;
go

/* coalesce evalutes the arguments in order and retirns the current value of the first expression that initially does not evasluated to null */
select [CompanyName],([Address]+' '+[City]+' '+coalesce([Region],'  | ')) as 'Full Address',[PostalCode],[Country]
from [Sales].[Customers]
;
go

/*aGGREGATE FUNCTION : max() | min() | Count () | sum () | avg () | */
/* return the average unit price, minimum quantity,maximum discount for order details*/

select [OrderID],avg([UnitPrice]) as 'Avg Unit Price',min([Quantity]) as 'Min quantity', max([Discount]) as 'Max Discount'
from [Sales].[Order Details]
group by[OrderID]
;
go
-- sequence of sql execution
-- 1.from
-- 2. where
-- 3.group by
-- 4.Having
-- 5.select
-- 5. order by


/*return only those customers that have placed more that 10 orders*/

select [CustomerID],count([OrderID] )as 'Count'
from [Sales].[Orders]
group by  [CustomerID]
having count([OrderID])> 10
order by count([OrderID]) desc
;
go

