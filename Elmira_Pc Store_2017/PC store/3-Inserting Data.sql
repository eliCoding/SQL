/*Insert and Populate Data in PC store database*/
/*Script Date: january 31,2017*/
/*Developed by :Elmira Amanollahi*/

/*switch to the current database pcstore_EA*/
use pcstore_EA;
-- Dumping data for table Shippers

insert into shippers (CompanyName,Phone)
values ('Speedy Express','(503) 555 - 98 31'),
('Federal Shipping','(504) 4444 56 45');

/* return the list of shippers*/

select *
from shippers;
 

 -- inserting data into table catgories
 insert into Categories (CategoryName,Description, Pictture)
 values ('Beverages','soft drink,cofees, teas, beers, and ales' , '');
 
 
 -- inserting data into table catgories
 insert into Categories (CategoryName,Description, Pictture)
 values ('Condimenrt','Sweetsauce,relishes,spreads,seasong' , ''),
 ('confection','Desserts,candie,and sweet breads','');
 
 select*
 from Categories;
 
 /* to rename a column 
 alter Table table_name 
 Change old_name new_name data_type constraints*/
 
 -- inserting data into table supppliers
 insert into supplier(CompanyName,Contactname,ContactTitle,Address, City, Region,PostalCode, Country, Phone, Fax, HomePage)
 values('Exotic Liquids','Charlotte cooper','Purchasign Manager','49 giblert st','London',null,'Ec1 4SD','UK','1715555',null,null);
 insert into supplier(CompanyName,Contactname,ContactTitle,Address, City, Region,PostalCode, Country, Phone, Fax, HomePage)
 values('new Orlaneas','shelley burke',
 
 'orer Administrator','P.O.Box 3423','new Orlean','LA','70117',default,'12334454',null,'www.cajun.com/insex/html');
 select*
 from supplier;
  /*Modify the data for SupplierID numer3*/
  update supplier
  set CompanyName = 'Tokyo traders',
      Contactname = 'Yoshi negase',
      ContactTitle = 'Marketing Manager',
      Address = '9-8 sekimai',
       City = 'Tokyo',
       Region = null,
       PostalCode = null,
       Country = 'Jappan',
       Phone = '123345',
       HomePage = null
	where SupplierID = 3;
    
    
    
  -- inserting data into table Products
  
 
 
 
 