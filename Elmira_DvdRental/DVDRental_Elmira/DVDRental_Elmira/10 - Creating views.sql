	/*Creatign Views in SQl
	Script Date: February 16,2017
	Developed by: Elmria Amnollahi
	*/
	use Northwind2014
	;
	go

	/*Create customer contact title view in NOrthWind database*/

	if OBJECT_ID('sales.customerContactTitleView','v')    is not null drop view sales.customerContactTitleView
	;
	go

	create view sales.customerContactTitleView
	as
	   select [ContactTitle],[ContactName]
	   from [Sales].[Customers]
   
	;
	go

	/* testing view Sales.CustomeCOntactTitleView*/
	select *
	from sales.customerContactTitleView
	;
	go


	/*modify the view Sales.customerContactTitleview to add the company phone nUmber*/
	alter view sales.customerContactTitleView
	as
	   select [ContactTitle],[ContactName], [Phone]
	   from [Sales].[Customers]
  
	;
	go

	/*create a view HireDateView that provides name and hire date information for the employees of NorthWind Traders*/
	/*check if the view exists*/
	if OBJECT_ID('HireDateView','v') is not null drop view HireDateView
	;
	go
	create view HireDateView
	as 
	select CONCAT ( [FirstName],' ',[LastName]) as 'Full Name',year([HireDate]) as 'Hire year', MONTH(HireDate) as 'hire Month'
	from [HumanResources].[Employees]
	;
	go

	select * 
	from HireDateView
	;
	go

	/*Create a view orderLineView that returns the order subtotal*/
	if OBJECT_ID('sales.orderLineView', 'v') is not null
	drop view sales.orderLineView;
	go
	create view  sales.orderLineView
	as
		select sum(convert(money,(OD.UnitPrice* OD.Quantity * ( 1- OD.Discount)) )) as 'Sub Total' ,OD.[OrderID]
		from [Sales].[Order Details] as OD
		group by OD.OrderID
	;
	go

	/*return the list of orders and their sum for a specific customer*/

	select c.CompanyName,OLv.[Sub Total], O.OrderID
	from [Sales].[Orders] as O 
	inner join 
	[Sales].[Customers] as C
	on o.CustomerID = C.CustomerID
	inner join sales.orderLineView as OLv on
	O.OrderID = OLv.OrderID
	where O.OrderID between  10248 and 10350
	order by O.OrderID

	;
	go

	/*Display the definition of the sales.orderLineView*/

	exec sp_helptext 'sales.orderLineView'
	;
	go


	/*modify the definition of the sales.OrderLine view*/
	alter view  sales.orderLineView
	with encryption
	as
		select sum(convert(money,(OD.UnitPrice* OD.Quantity * ( 1- OD.Discount)) )) as 'Sub Total' ,OD.[OrderID]
		from [Sales].[Order Details] as OD
		group by OD.OrderID
	;
	go

