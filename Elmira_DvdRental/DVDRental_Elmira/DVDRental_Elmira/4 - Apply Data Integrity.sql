/*Create  the dvd Rentals Table
Script Date: February 10,2017
Developed by: Elmria Amnollahi
*/
use DVDRental;

go

/*integtiry types:
 1. Domain(column)
 2. Entity (Row)
 3. Referential (Between 2 tables or columns)



 Constraint type 
 1) Primary ke (PK_)
 2) Unique (u_)
 3) Default (df_)
 4) Check (ck_)
 5) Foregin key (fK_)

*/

/*
Assuming we have  TABLE NAMes table 1
Alter table table1
   Add constraint Constraint_label Constraint_type
*/

/*Add a default value equals to 1 to the NumDisks column in the table DVDs*/
alter table production.dvds
add constraint df_dvsd_numdisks default 1 for numdisks;
go

/* Add foreign key to the table DVDs */
/* 1) betweeen the DVDs and Formats tables */
alter table production.dvds
add constraint  fk_dvds_Formats foreign key (FormID )
references production.Formats(FormID);
go


/*Modify a column in a table 
alter table schema_name.table_name
 alter column column_name data_type constraint   
 */



/* 2) betweeen the DVDs and Rating tables */
alter table production.dvds
add constraint  fk_dvds_Rating foreign key (RatingID )
references production.Rating(RatingID);
go


/* 3) betweeen the DVDs and Movieypes tables*/
alter table production.dvds
add constraint  fk_dvds_MoviesTypes foreign key (MtypeID )
references production.MoviesTypes(MTypeID );
go


/* 4) betweeen the DVDs and Studios tables */ 
alter table production.dvds
add constraint  fk_dvds_MoviesTypes foreign key (MtypeID )
references production.MoviesTypes(MTypeID );
go
/* 5) betweeen the DVDs and Satatus tables*/ 
alter table production.dvds
add constraint  fk_dvds_Status foreign key (StatID )
references production.Status (StatID );
go

/*Add foreing key to the table production.DvDparticipants*/

/*1) betweeen the DvDparticipants and DVD tables */
alter table production.DvDparticipants
add constraint  fk_DvDparticipants_DVDs foreign key (DVDID )
references production.DVDs(DVDID );
go
/*2) betweeen the DvDparticipants and participants tables */
alter table production.DvDparticipants
add constraint  fk_DvDparticipants_participants foreign key (PartID )
references person.participants(PartID );
go
/*3) betweeen the DvDparticipants and Role tables */

alter table production.DvDparticipants
add constraint  fk_DvDparticipants_Roles foreign key (RoleID )
references person.Roles(RoleID );
go

/*to transfer a table to a schema 
alter schema schema_name transfer schema.table_name*/

create table table1
(col1 int);
go

alter schema person transfer dbo.table1
;
go


/*Add foreign key(s) to the table sales.Orders*/
/*1) betweeen the Ordrs and Customerss tables */
alter table [sales].[orders]
add constraint  fk_orders_Customers foreign key (CustID)
references [sales].[Customers] (CustID );
go


/*2) betweeen the Orders and Employees tables */
alter table [sales].[orders]
add constraint  fk_orders_Employees foreign key (EmpID)
references [person].[employees] (EmpID );
go


/*Add foreign key(s) to the table sales.Transactions*/
/*1) betweeen the Transactions and orders tables */
alter table [sales].[transactions]
add constraint  fk_transactions_Orders foreign key (OrderID)
references [sales].[orders](OrderID );
go



/*2) betweeen the Transactions and DVDS  tables */
alter table [sales].[transactions]
add constraint  fk_transactions_DVDS foreign key (DvDID)
references[production].[dvds](DvDID );
go

 /*set dvd name Constraint to unique*/
 alter table [production].[dvds]
 add constraint u_DvDname_DVDs unique (DvDname)
 ;
 go

 /*set a check constrains  on due date in the tables sales.Transaction*/
 alter table [sales].[transactions]
 with nocheck 
   add constraint ck_Datedue_Transaction check(DateDue >= DateOut)
   ;
   go

/*set the pattern of a Phone nUmber  (000) 000-0000 in the table sales.Suppliers*/
create table table2  (
phoneNumber varchar(30)

)

alter table table2
with check 
     add constraint ch_Phone_table2 check([PhoneNumber] like 
	 '([1-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
go
select * from table2
-- or using regular expression
alter table table2
with check 
     add constraint ch_Phone_table2 check([PhoneNumber] like 
	' ((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}')
;
go










