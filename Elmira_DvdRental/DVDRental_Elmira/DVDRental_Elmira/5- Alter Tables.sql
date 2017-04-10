/*Altering Tables
Script Date: February 13,2017
Developed by: Elmria Amnollahi
*/

use DVDRental;

go

/*Syntax for modifying table structure 
 alter table schema_name.table_name

        1) Add a new Column
		2) drop a column
		3)modify an existing column
		4)add constraints to a column
*/
/* 1)Add a new column*/
alter table  schema_name.table_name
     add column_name datatype  constraint(s)   
;
go

/*2) drop a column*/

alter table  schema_name.table_name
   drop column colomn_name 
   ;
   go


/*3)Adding check constraint to an existing column*/
alter  table schema_name.table_name
    with check | with no check
	add constraint ck_constrains_name check (column_1> value)
;
go

/*4)adding a default value to  an existing column*/

alter table schema_name.table_name
  add constraint df_constrains_name default (default_value) for column_name
 ;
 go

 /*5) adding a default value to a new column */

alter  table schema_name.table_name
   add column_name data_type constraint(s)
   df_constrains_name default (default_value)
 ;
 go

/*create a new table myTable */
create table Sales.MyTable 
(
column_a int,
column_b varchar(20) null
)
;
go

/* return the definition of MyTbale*/
exec sp_help 'Sales.MyTable' 
;
go

/*remove the column_b*/
alter table Sales.MyTable
 drop column column_b
 ;
 go

 /*Add a new column_c of type int */
 alter table Sales.MyTable
 add column_c int null
 ;
 go

/* modify the data type of column_c to decimal(fixed precision, Scale Numbers)*/
alter table Sales.MyTable
alter column column_c decimal(5,2) 
;
go


/*add a check constrains to column_c. For Example the value must be greater than 2*/
alter table Sales.MyTable
add constraint ck_MyTable_column_c check (column_c>2.00)
;
go


/* Syntax 
insert into schema_name.table_name(column_1,column_2,...)
values (val1,val2,...)
*/
insert into Sales.MyTable(column_a,[column_c])
values (5,10)
;
go

select * from Sales.MyTable

