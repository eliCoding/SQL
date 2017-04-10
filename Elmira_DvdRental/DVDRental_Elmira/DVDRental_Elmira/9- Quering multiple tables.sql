	/* Quering multiple tables 
	Script Date: February 15,2017
	Developed by: Elmria Amnollahi
	*/

	use DVDRental;
	go

	/*return dvd names and movie types description and  status description, studio description and format description*/

	select d.[DVDName] as 'DVD Name',LTRIM(m.[MtypeID]) as 'Movie Type',m.MTypeDescrip as 'Status', s.StatDescrip as 'Studio',ps.[StudDescrip] as 'Format'
	from [production].[dvds] as d inner join [production].[MoviesTypes] as m
	on d.MtypeID = m.MtypeID inner join [production].[status] as s
	on d.[StatID]= s.[StatID]
	inner join [production].[studios] as ps
	on d.[StudID] = ps.[StudioID]


	/*return the customer full name who placed orders, Employee full name who run the transaction, the order Number, the transaction number, date out, date in, and the dvd name rented*/
	select [CustFN] +' '+[CustMN]+' '+[CustLN] as 'full Name',[EmpFN] + ' '+ [EmpLN] as 'Emplpyee Full name',o.OrderID, t.DateOut,t.DateDue,t.DateIn,d.DVDName
	from  [sales].[Customers] as c inner join  [sales].[orders] as o
	on  o.[CustID] =c.[CustID]
	inner join  [person].[employees] as e on  
	e.EmpID =o.EmpID 
	inner join [sales].[transactions] as t 
	on t.OrderID = o.OrderID
	inner join [production].[dvds] as d
	 on d.DVDID = t.DVDID
	 ;
	 go

	 /*retrieve the full participant name, role he played in the movie*/
	 select CONCAT( p.[PartFN],' ',p.[PartMN],' ',p.[PartLN]) as 'participant' ,r.[RoleDescrip] as 'Role', pd.DVDName
	 from [production].[DVDparticipants] as D inner join
	[person].[roles] as R
	on d.RoleID = r.RoleID
	inner join [person].[participants] as P
	on d.PartID = p.PartID
	inner join [production].[dvds]  as pd on
	pd.DVDID = D.DVDID
	order by 'participant' 
	;
	go


	/*Switch to northwind*/
	use Northwind2014
	;
	go

	-- using a sub query
	/*return order id and customer id for the most recent date*/
	select   [OrderID],[CustomerID] ,[OrderDate]
	from [Sales].[Orders]
	where OrderDate = (select max([OrderDate])
					  from [Sales].[Orders])
	;
	go

	/*return customer company name who placed orders in the most recent date*/

	select C.[CompanyName]
	from [Sales].[Customers] as C
	where C.CustomerID in (select o.customerID
						   from [Sales].[Orders] as o
						   where OrderDate <= GETDATE() )
	 ;
	 go


	 /*find orders and customer who placed more than 20 units of the product number 23*/
	 select [OrderID],[CustomerID]
	 from [Sales].[Orders] or1 
	 where 20 >( select [Quantity]
				  from [Sales].[Order Details] as od
				  where or1.[OrderID] = od.[OrderID]
				  and  od.ProductID = 23)
	;
	go

	/*using exist and not exists*/
	/*etermines whether the data exists in a list of values*/
	/*return employee name who run orders after february 1 ,2017*/

	select e.firstName, E.lastname
	from HumanResources.Employees as E
	where Exists (select *
				   from Sales.Customers as o
				   where e.employeeID = o.EmployeeID
				   and o.OrderDate> '2/1/2010')
	)
	;
	go

	select COUNT([CustomerID])
	from Sales.Customers
	;
	go
	select * from [HumanResources].[Employees];
	select * from [Sales].[Customers];

	/*built in Functions: Substring (Expressuin, Start,length)
	left(Expression,Length)
	Right (Expression,Length)
	*/

	use DVDRental
	;
	go

	select DvdID,DVDName
	from  [production].[dvds]
	order By DvdID
	;
	go

	/*Return the String 'White', 'Chrismas', and th String 'Chris' from the DVD name with dvd number equals to 1*/

	select DvdID,DVDName, LEFT(DVDname , 5) as 'Left String', RIGHT (DVDName,9) as 'right String', SUBSTRING (DVDName,7,5) as 'Sub String'
	from  [production].[dvds]
	where DvdID = 1
	;
	go



	use Northwind2014;
	;
	go

	/*return the cutomer company name, Area code and Phone Number located in USA and Canada*/

	select  [CompanyName], SUBSTRING(phone,2,3) as 'Area Code', SUBSTRING(phone,7,8) as 'Phone'
	from [Sales].[Customers]
	where Country in ('usa','Canada') 
	;
	go

	/*return the cutomer company name, Area code and Phone Number located in brazil*/

	/*Create a temporary  table use north wind*/

	use Northwind2014
	;
	go
	select productname as 'products',
		  UnitPrice as 'Price',
		  (unitPrice * 1.1) as 'tax'
	into #pricetable
	from production.Products


	select * from  #pricetable
	where tax <20
	;
	go

	-- add northWind Employees to the table tempCustomers
	/*create a temporary table named tempCustomers.Assign the customer id to be 3 Characters from the first name and 2 characters from  the last name of the humanresources.employee last name will be assign to the company name, title to ContactTitle,Address, City, Region,And Country to thr respective column name*/
	if OBJECT_ID(' #tempCustomers', 'U') is not null
	  drop table #tempCustomers
	  ;
	  go
	  select SUBSTRING([FirstName],1,3)  + SUBSTRING([LastName],1,3)  as       'CustomerID', [Title] as 'contact Title', [Address] as 'Address',[City]  as 'City'
	  into #tempCustomers
	  from [HumanResources].[Employees]
	;
	go

	select * from  #tempCustomers
	;
	go
	delete from  #tempCustomers
	;
	go
