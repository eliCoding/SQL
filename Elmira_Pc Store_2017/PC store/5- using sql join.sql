/* Using SQl JOin */
/* Script Date: Februaru 2,2017 */
/* Developed by:Elmira Amanollahi */


use Northwind2017;

/*Q1: return the customer company name and order placed by each of them*/

/* syntax select column 1, column 2 ,...
from  first_table join_type second_table on (join_condition)  */

select C.CompanyName,O.OrderID
from customers as C inner join orders as O 
on C.CustomerID = O.CustomerID;

select count(OrderID) from orders;

/* check if any customer did not place order*/
select C.CompanyName,O.OrderID,C.CustomerID
from customers as C left  outer join orders as O 
on C.CustomerID = O.CustomerID
where O.OrderID is null;

select C.CompanyName,O.OrderID,C.CustomerID
from orders as O right outer join customers as C
on C.CustomerID = O.CustomerID
where O.OrderID is null;





/* list products supplied by each supplier company name,
return the product ID,supplier ID, and supplier company name*/
select P.ProductID,S.CompanyName,S.SupplierID
from suppliers as S inner join products as P 
on S.SupplierID = p.SupplierID;


/* Check if any supplier did not supplied products */
select P.ProductID,S.CompanyName,S.SupplierID
from suppliers as S left outer join products as P 
on S.SupplierID = p.SupplierID;



/*return total of orders placed by each customer (company name).
List from the highest to lowest total*/
select C.CustomerID, C.CompanyName,count(O.OrderID) as 'Total Number'
from orders as O inner join customers as C
on C.CustomerID = O.CustomerID
group by C.CustomerID , C.CompanyName
order by count(O.OrderID) desc;

/* Find the highest unit price, the lowest quantityperUnit and 
the average  of the reorder level from the products table
*/
select ProductID,max(UnitPrice) as 'Maximum Price', min(QuantityPerUnit) as 'Minimum Quantity', avg(ReorderLevel) as 'Average ReorderLevel '
from  products;

/*how many products  in each category, return the catergory name and number of products*/

select count(P.ProductID) as 'Total',C.CategoryName
from categories as C inner join products as P
on C.CategoryID = p.CategoryID
group by C.CategoryName;


/*how many products in each category. return the category name and the number of procucts
for those categories that have  more than 10 products
*/

select count(P.ProductID) as 'Total',C.CategoryName
from categories as C inner join products as P
on C.CategoryID = p.CategoryID
group by C.CategoryName
having `Total` > 10;

/* Some MYSQL Functions*/

-- Greatest and least 
select greatest(4,83,-1,15) as greatest;
select least(4,83,-1,15) as least;

/* function Colease returns the first value in the list of arguments that is not null*/
select coalesce(null,2,null,3);
select isnull( 2 * null);

/*String comparision*/
select strcmp('big','bigest');


/* if() function compares three arguments if(expr1, expr2, expr3)*/
select ProductID,UnitPrice,if (unitPrice < 10, 'Low Price', 'high Price') as 'Price POint'
from products;

-- select if (m, 'Male', 'Female')


/*Case Statement*/
select ProductName,UnitPrice,
case 
  when UnitsInStock <50 then 'watch the stock'
  when UnitsInStock between 10 and 50 then 'Time to reorder'
else
   'Product is Available'
   
end as 'Policy'
  
from products
order by ProductName
;
/* Convert values to a specific data type : cast and convert

cast (expression as data_type)
convert(expression , data_type)
*/

select 2+1 as 'sum';

select cast(20170121 as date);
select convert(20170121,date) as 'date';

/*concatenation functios:
concat() - returns concatenated string
concat_ws = returns concatenated string with separator

*/
select concat('cat',' ', 'and',' ', 'dogs' ) as 'Concat'; 

select concat_ws('  ','cat','and', 'dogs' ) as 'Concat';

/*return the employee fullname and full address*/

select concat_ws(' ',FirstName,LastName) as 'full name' , concat_ws(' ',Address,City,Region,PostalCode) as 'full address'
from employees;


/*change word  case: Lower() | LCase() | UCase()*/
select CompanyName,lower(CompanyName),lcase(CompanyName),upper(CompanyName),ucase(CompanyName)
from customers;
/* Extrat part of a value
left(expression,length)
right(expression,length)
subString(expression,start,length)
*/
select  ProductName,left(ProductName,4) as 'left', right(ProductName,7) as 'right', substring(ProductName,8) as 'Substring'
 from products
where ProductID =41;
 ;
 
 /*how many days it take to ship and order*/
select OrderID,OrderDate,RequiredDate,ShippedDate,
datediff(OrderDate,ShippedDate) as'number of dates'
from orders
where orderID = 10248;


select OrderID,OrderDate,RequiredDate,ShippedDate,
datediff(RequiredDate,ShippedDate) as'dates'
from orders
where orderID = 10248;


 
 
