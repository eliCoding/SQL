/*Creatign indexes in SQl
Script Date: February 13,2017
Developed by: Elmria Amnollahi
*/

use DVDRental;
go

/*syntax: 
    1)Create a nonClustered index on a table or view
	 create index index_name on table_name (column_name)
	2) create a clustered index on a table 
	 create clustred index index_name on a table_name (column_name)
*/

/*retrieve index information for the Sales.customers*/

exec Sp_helpindex 'Sales.customers'
;
go

/*
Index_id is unique only withinth object. 
0 = heap | 1 = Clusctered index | >1 = NonClustered index

*/


select 
name, -- name of the index
index_id, -- 0 = heap | 1 = Clusctered index | >1 = NonClustered index
object_id, 
type , -- type of index
type_desc, -- description of the index
 is_unique, -- 1 unique | 0 is not unique
 is_primary_key, -- 1 index is part of the primary key
 is_disabled -- 1 index is disabled | 0 index is not disabled
from sys.indexes
where object_id = object_id ('Sales.customers')
;
go

/* modify the table Customer by Adding the Address columns*/
alter table [sales].[Customers]
add 
     Address nvarchar(60) null,
	 City nvarchar(15) null,
	 Region nvarchar(15) null,
	 postalCode nvarchar(10) null,
	 Country nvarchar(20) null
;
go

select * 
from [sales].[Customers]
;
go

/*Add index to the City Column*/

create index ix_Customers_City 
 on  [sales].[Customers] (City)
 ;
 go

 /*Check the existance of indexes in the table person.Employees*/

 exec sp_helpindex '[person].[employees]'
 ;
 go


 /*Create a nonClustered Index (ncl_lastName) on the last name column */
 create nonclustered index ncl_lastName on [person].[employees](EmpLN)
 ;
 go

 /* drop the nonclustered index ncl_lastName*/
 drop index ncl_lastName on [person].[employees]
 ;
 go
  -- or drop index [person].[employees].ncl_lastName


 /*create a unique nonclustered index  u_ncl_DVDName on [production].[dvds]   */

 create unique  nonclustered index  u_ncl_DVDName on [production].[dvds](DVDName)
 ;
 go

 /*drop the u_ncl_DVDName index if exists and then recreate it*/
 if exists
 (
    select name
	from sys.indexes
	where name = 'u_ncl_DVDName'
	)
drop index u_ncl_DVDName on [production].[dvds]
;
go

/*Create a non clustered index on the [sales].[orders]*/

create unique nonclustered index u_ncl_CustID_EmpID on Sales.Orders (CustID, EmpID)
;
go

 if exists
 (
    select name
	from sys.indexes
	where name = 'u_ncl_CustID_EmpID'
	)
drop index u_ncl_CustID_EmpID on Sales.Orders
;
go 
exec sp_helpindex '[sales].[orders]'

select * from sales.orders

delete from [sales].[orders]
where OrderID between 14 and 39 