/* System Store Procedures
		Script Date: February 20,2017
		Developed by: Elmira Amnollahi
		*/

use Northwind2014
	;
	go

/*Many administrative and informal activies can be performed by using system stored procedures*/


/*retrieve a list of databases on the server*/

exec sys.sp_databases
;
go


/*retrieve the metadata information ABOUT A USER OBJECT, FOR EXAMPLE : the customer table*/

exec sp_help '[Sales].[Customers]'
;
go


/* retrieve table belonging to different schemas*/
exec sp_tables
;
go

/* display the definition of the procedure sp_help*/

exec sp_helptext 'sp_help'
;
go


/* retrieve table belonging to specific schemas (sales)*/

exec sp_tables 
	-- @table_name = '%'
	-- @table_name = 'Orders'
	@table_name = '%',
	@table_owner = 'Sales'
;
go



/*  return the system language information */

exec sp_helplanguage
;
go



/* return information about all databases*/


exec sp_helpdb
;
go

/* return information about specific databases  */
exec sp_helpdb 'Northwind2014'
;
go

/*return the physical names and attributes of files asocited with the current database*/

exec sp_helpfile
;
go

/* return inforamationabout the table Sales.Ordes*/
exec sp_help 'Sales.Orders'
;
go


/*return list of constraints types*/
exec sp_helpconstraint 'Sales.Orders'
;
go


/*provide information about logins and users associated with them in each database*/

exec sp_helplogins
;
go

exec sp_helplogins '213-19\ipd'
;
go

/* return informationabout databases level principals in the current database*/

exec sp_helpuser
;
go

/*rename the data base*/

exec sp_renamedb 'old_name', 'new_name'
;
go


/* display the number of rows,disk space, and disk space used in  a table*/

exec sp_spaceused 'Sales.[Order Details]'
;
go


select count(*)
from Sales.[Order Details]
;
go

/*return the list of system store procedure*/
exec sys.sp_stored_procedures
;
go


/*return a list of store precedures in the sechema sales*/


exec sys.sp_stored_procedures
	@sp_owner = 'Sales'
;
go

/*information _Schema
	1. write queries to return system meta data
	2. using system catalog views
	3. using standfard information schema views
	4. using system functions 
*/


/* display server setting using system rules and functions*/

select name ,value,value_in_use,description
from sys.configurations
order by name
;
go

/*dusplay the name of the database on the currnt instance of sql Server*/
select name,database_id,user_access,user_access_desc,state,state_desc
from sys.databases
;
go

/*display a list of user_defined table*/

select S.name as 'Schema Name', T.name as 'Table Name'
from sys.tables as T
inner join sys.schemas as S
on S.schema_id = T.schema_id
order by S.name,T.name
;
go

/* Information Schema views*/

select Table_Catalog, TABLE_SCHEMA,TABLE_NAME,TABLE_TYPE
from INFORMATION_SCHEMA.tables
;
go

select view_catalog,VIEW_NAME,VIEW_SCHEMA,TABLE_NAME,COLUMN_NAME,TABLE_SCHEMA
from INFORMATION_SCHEMA.VIEW_COLUMN_USAGE
;
go


exec sp_who
;
go

exec sp_who2
;
go










