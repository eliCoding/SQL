/*Create  the dvd Rentals Table
Script Date: February 8,2017
Developed by: Elmria Amnollahi
*/

/*
Syntax:
Create table table_name
(
  column_name_1 data type constraint,
  column_name_2 data_type constraint,
  ...
  column_name_n

)

*/

/*
Auto genaretad number:
    in Acces we used Auto NUmber,
	in mySQl _ Auto_Increment
	in SQL server _ Identity (seed, increment)
	. seed is the value that used for the very first row
	. increment is the incremental value that is added to the identity of the previous row that was loaded

*/

/* Check for existence of specified object by verifying the table has an object ID. if the table exists, it is deleted using the dropstatement if the tables does not exist, it will be created*/

if OBJECT_ID('Sales.Customers','U') is not null
   drop table Sales.Customers
   ;
   go

/***** Table no1 Sales.Customers *****/
create table Sales.Customers
(
  CustID smallInt identity(1,1) not null,
  CustFN varchar (20) not null,
  CustMN varchar(20),
  CustLN varchar(20) not null,
  constraint pk_Customers primary key clustered(CustID asc)
)
;
go

/* return information about the Sales.Customers table*/
execute sp_help 'Sales.Customers'
;
go

-- create the lookup tables();
/*** table no 2 - person.roles ****/
create table person.roles (
  RoleID varchar(4) not null,
  RoleDescrip  varchar(430) not null,
  
  constraint pk_roles primary key clustered (RoleID asc)
  )  ;
  go

  /*** table no 2 - Production.MoviesTypes ****/

  create table Production.MoviesTypes (
  MTypeID varchar(4) not null,
  MTypeDescrip  varchar(30) not null,
  
  constraint pk_MoviesTypes primary key clustered (MTypeID asc)
  )  ;
  go


  /*modify the column MTypeDecript to 40 Characters*/

  ALTER TABLE Production.MoviesTypes Alter column MTypeID varchar(40) not null;
  go

  /** create studios **/
  create table production.studios(
  StudioID varchar(4) not null,
  StudDescrip varchar(40) not null,
  
  constraint pk_StudioID primary key clustered (StudioID asc)
  )  ;
  go
  /** create production.Ratings **/
  create table production.ratings(
  RatingID varchar(4) not null,
  RatingDescrip varchar(30) not null,
  
  constraint pk_Ratings primary key clustered (RatingID asc)
  )  ;
  go

  /***** create production.formats *****/

  create table production.formats(
  FormID varchar(3) not null,
  FormDescrip varchar(15) not null,
  
  constraint pk_Formats primary key clustered (FormID asc)
  )  ;
  go

  /*modify th FormID to char(2) int he Prodcution.Formats table **/

  -- step 1 - drop primary key
  alter table production.formats 
  drop pk_Formats;
  go


  -- sttep 2 modify FormID to char(2)

  alter table production.formats 
  alter column FormID char(2) not null;
  go

  -- step3 - set back the primary key

  alter table production.formats
add constraint pk_Formats primary key clustered (FormID asc)
;
  go


  /*** Table no 7 production.status ****/
  create table production.status(
  StatID varchar(3) not null,
  StatDescrip varchar(20) not null,
  
  constraint pk_Status primary key clustered (StatID asc)
  )  ;
  go

  /* rename a database , table, or column */
  exec sp_renamedb 'old_name' , 'new_name';
  exec sp_rename 'schema_name.table_name.old_column_name' , 'new_name' ;




  /*** Table no 8 sales.transactions **/

  create table sales.transactions(
  TransID int identity(1,1) not null,
  OrderID int not null, -- foreign key 
  DVDID int not null, -- foreign key 
  DateOut date not null, 
  DateDue date not null,
  DateIn date null,

  constraint pk_transactions primary key clustered (TransID asc)
  )  ;
  go

  /*table participants */

  create table person.participants(
  PartID smallint identity(1,1) not null,
  PartFN varchar(20) not null,
  PartMN varchar(20) null,
  PartLN varchar(20) not null,

  constraint pk_participants primary key clustered (PartID asc)
  )  ;
  go

 /* modify the PartMN to null if it was set to no null */
 alter table person.participants 
	alter column  PartMN varchar(20) null
	;
	go


/*** table 10 person.employees ***/

create table person.employees(
  EmpID smallint identity(1,1) not null,
  EmpFN varchar(20) not null,
  EmpMN varchar(20) null,
  EmpLN varchar(20) not null,

  constraint pk_employees primary key clustered (EmpID asc)
  )  ;
  go


  /*** Table No.11 - Production.dvd **/

  create table production.dvds (
  DVDID int  identity(1,1) not null,
  DVDName varchar(60) not null,
  NumDisks tinyint not null,
  YearRIsd datetime not null,
  MtypeID varchar(4) not null, -- foreign key
  StudID varchar(4) not null, -- foreign key
  RatingID varchar(4) not null, -- foreign key
  FormID varchar(2) not null, -- foreign key
  StatID char(3) not null, -- foreign key
  constraint pk_dvds primary key clustered (DVDID asc)
  );
  go


  /*modify the datatype of YearRlsd to char(4) **/

  alter table production.dvds

  alter column YearRIsd char(4) not null
  ;
  go

  /**** table no 12 sales.orders ****/

   create table sales.orders (
  OrderID int  identity(1,1) not null,
  CustID smallint not null, -- foreign key
  EmpID smallint not null, -- foreign key
  constraint pk_orders primary key clustered (OrderID asc)
  );

  go

/*** no 13 production.participants ****/

create table production.DVDparticipants (
DVDID int  not null, -- foreign key
PartID smallint not null, -- foreign key 
RoleID varchar(4) not null, -- foreign key

constraint pk_DVDparticipants primary key clustered (
DVDID asc,
PartID asc,
RoleID asc
)
);
go