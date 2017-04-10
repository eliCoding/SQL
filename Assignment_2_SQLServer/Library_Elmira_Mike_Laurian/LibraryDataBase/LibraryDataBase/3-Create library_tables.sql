-- Create  Library Table
/*Script Date: February 17,2017
developed by Elmira Amanollahi, Mike Yu,Laurian staicu on feb-17-2017*/

/***** Table no1 items.Authors *****/
if OBJECT_ID('items.Authors','U') is	not null
   drop table Sales.Customers
;
go

create table items.Title (
	titleNo int identity(1,1)	not	null,
	title varchar(100) not null ,
	
	author varchar(100) not null,
	synopsis varchar(50),
	primary key clustered (titleNo	asc) 
)
;
go

create table items.item (
	ISBN int identity(1,1) not					null,
	titleNo int ,
	language varchar(40) ,
	
	cover varchar(40),
	loanable varchar(10),
	primary key clustered (titleNo	asc) 
)
;
go

create table items.Copy (
	ISBN int  not					null,
	CopyNo int 	not	null
	,
	titleNo int not	null,
	onLoan varchar(2) not	null,
	
	primary key clustered (CopyNo asc,ISBN asc)

)
;
go












create table lease.loanhist (
	ISBN int not null, --fk
	CopyNo int not null, --fk
	outDate date not null,
	titleNo int not null, --fk
	memberID int not null, -- fk
	dueDate date not null,
	DateIn date not null ,
	fineAssessed decimal (4,2) ,
	finePaid decimal(4,2),
	fineWaived decimal(4,2),
	remarks varchar(200),
	primary key clustered (ISBN asc,CopyNo asc)
	
)
;
go


create table lease.Loan (
	ISBN int not null, -- fk
	CopyNo int not null, --fk
	titleNo int not null, -- fk
	memberID int not null,
	outDate date not null,
	dueDate date not null, 
	
	primary key clustered (ISBN,CopyNo)
)
;
go

create table lease.reservation (
	ISBN int not null, --fk
	memberID int not null, --fk
	logDate date not null,
	state varchar(4),
	remarks varchar(200),
	primary key clustered (ISBN,memberID)
	 
)
;
go


create table members.adult (
	memberID int not null ,
	street varchar(40) not null,
	city varchar(40) not null,
	state varchar(40) not null,
	zip varchar(40) not null,
	phone varchar(40) ,
	
	exprDate date,
	primary key clustered (memberID)
)
;
go



create table members.juvenile (
    juvenileID int ,
	memberID int, -- fk
	DOB date,
	
	primary key clustered (juvenileID)	
)
;
go


create table members.member (
	memberID  int identity(1,1) not null,
	
	firstName varchar(30) not null,
	lastName varchar(30) not null,
	middleI varchar(3) not null ,
	photo varbinary(max),
	primary key clustered (memberID)

)
;
go