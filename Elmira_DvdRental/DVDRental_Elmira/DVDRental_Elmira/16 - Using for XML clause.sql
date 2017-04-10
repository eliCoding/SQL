/* usign for XML Clause
		Script Date: February 21,2017
		Developed by: Elmira Amnollahi
		*/

use Northwind
;
go

select C.[CustomerID], O.OrderID
from [dbo].[Customers] as C
inner join [dbo].[Orders] as O
on C.CustomerID = O.CustomerID
order by C.CustomerID
-- for xml auto
-- for xml raw('Order'), Root ('Orders')
for xml auto, elements
;
go








