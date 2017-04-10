/* Manipulate Northwind data  */
/* Script Date: February 1,2017 */
/* Developed by:Elmira Amanollahi */
/*switch to the current database Northwind data*/
use Northwind2017;
/*display all mysql databases in the server*/
show databases;

/*display the tables in Northwind 2017 */
show tables;

/*retrieve information about database objects */


/*show create database <database_name>*/
 show create database Northwind2017;
 
 
 /*show data bases [like '<value>]*/
 show databases like 'p%';
 
 /*show column from <table_name> from <database_name> [like '<value>]*/
 
 show columns from customers from Northwind2017 like 'c%';
 /*show index from <table_name> from <database_name>*/
 show index from customers;
 
 /*describe <table_name> [<column_name> | '<value>' ]*/
 
 describe suppliers;
 
 describe orders;
 
 show columns from orders;
 show index from orders;
 
 /*Retrive data from MySQL database
 
 <select_list | <column_name> | <expression> [AS <Alias>]alter
  from object_name
  [where <search_condition>] */
  --   ex:       expression     -- 
  -- select unitprice * quantity as 'Subtotal';
/* to answer a question 
 1) undestand where the data comes from : table , view,... alter
 2) select the object name
 3) select the column name(s) that will be returned in the result set
 4) add Criterieas  (condition)one after another
 5) groop by the data (if nessecery ) when used and aggregate function 
 6) sort the data (if nessecery )
*/
 /* Q1: list countries where suppliers are located   1) supplier 2) countries, */
 select Country,CompanyName
 from suppliers;
 
 /* Q2:list countries where suppliers are located. Arrange the counties alphabeticalyand
 within each country list the suplier*/
 select Country,CompanyName
 from suppliers
 order by Country asc,CompanyName asc;
 
 
 /*Q3: return the name and the location on suppliers from germany and sweden*/
 select Country,CompanyName,city
 from suppliers
 where Country in ('sweden','germany');
 
 /* Q4: return all information about the order details only for those orders 
 id greater than 11000
 */
 select *
 from `order details`
 where OrderID >11000;
 
 /* Q5: find employees who where hired in the first quarter of 2015*/
 
 select *
 from employees
 where HireDate between 01/01/2016 and 03/31/2016;
 
 select *
 from employees
 where HireDate between 2005/01/01 and 2005/03/31;
 /*update the order date, required date, and ship date
 the date_ADD(date,interval expr type)
 where type value can be MICRODECOND |SECOND| MINUTES | HOUR|DAY | WEEK| YEAR| 
 
 */
 select * from orders;
 set sql_safe_Updates = 0;
 update orders
 set OrderDate = date_add(OrderDate, interval 9 year)
 WHERE OrderDate between '2006/1/1' and '2008/12/31';
 
 set sql_safe_Updates = 0; -- let you to enable the safe mode
 update orders
 set RequiredDate = date_add(RequiredDate, interval 9 year)
 WHERE RequiredDate between '2006/1/1' and '2008/12/31';
 
 set sql_safe_Updates = 0; -- let you to enable the safe mode
 update orders
 set ShippedDate = date_add(ShippedDate, interval 9 year)
 WHERE ShippedDate between '2006/1/1' and '2008/12/31';
 
 select *from employees;
 update employees
 set BirthDate = date_add(BirthDate, interval 10 year );
 
 update employees
 set HireDate = date_add(HireDate, interval 10 year );
 -- reduce the hiredate by 1 for the employee id number 1
 update employees
 set HireDate = date_add(HireDate, interval -1 year )
 where EmployeeID = 9;
 
 
 /* suppose that you do not rmember the customers company name that starts with 
 "the" Find all company names starting with "the"
 */
 
 select CompanyName
 from customers
 where CompanyName like 'the%';
 
 /*find sippliers in either UK or Paris*/
 
 select City, Country
 from suppliers
 where  Country='uk' or  City= 'Paris'; 
 
 /*find suppliers who have fax numbers*/
 select Fax, CompanyName
 from suppliers
 where Fax != "null"; -- is not null
 
 /*check if here are some orders that need to be shipped today*/
 select OrderDate, OrderID, RequiredDate
 from orders
 where RequiredDate = current_date();
 
 /* Find customers who are located in seattle kirkland or portland*/
 select CustomerID, City
 from customers
 where city in ('seattle' , 'kirkland', 'portland');
 
 /* List all orders that have been shipped in the past 90 days*/
 
 select OrderID,ShippedDate
 from orders
 where ShippedDate between date_sub(current_date(), interval 90 day) and current_date();
 
 
 /*calculated field*/
 
 /*find out what all confident product (category ID =3) would cost if you raise the price by 25 percent*/
 select ProductID,ProductName,UnitPrice, (UnitPrice* 1.25) as 'New Price'
 from products
 where CategoryID =3;
 
 /*find out what countries customers are located and order them*/
 select  distinct Country
 from customers 
 order by Country asc;
 
 
 
 
 
 
 
 
 
 
 
 
 
 