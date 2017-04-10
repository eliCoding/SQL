/* Create the MoveOn database */
/* Script Date: January 31,2017 */
/* Developed by:Elmira Amanollahi, Mike Zhi Yu, Laurian Staicu */

/* Syntax: create database_name */
create database if not exists MoveOn_LEM;

/* Switch to the current database MoveOn_LEM*/
use  MoveOn_LEM;

/* create the Definition of table Customers*/
create table Customers (
 CustID int not null auto_increment,
 CompanyName varchar(50) null,
 ContactFirst varchar(30) not null,
 ContactLast varchar(30) not null,
 Address varchar(60) not  null,
 City varchar(15)  not null,
 State varchar(2) not null,
 Zip int(5) not null,
 Phone varchar(20) null,
 Balance decimal(8,2) null,
 constraint  pk_Customers primary key (CustID asc)
 );
 
/* create the Definition of table UnitRentals*/ 
 create table UnitRentals (
 CustID int not null,
 WarehouseID varchar(4) not null,
 UnitID int not null,
 DateIn date null,
 DateOut date null,
 constraint pk_UnitRentals primary key (CustID asc ,WarehouseID asc ,UnitID asc)
 );
 
/* create the Definition of table Drivers*/ 
 create table Drivers (
 DriverID int not null auto_increment,
 DriverFirst varchar(30) not null,
 DriverLast varchar(30) not null,
 SSN int(9) not null, 
 DOB date not null,
 StartDate date not null,
 EndDate date null,
 Address varchar(60) not null,
 City varchar(15)  not null,
 State varchar(2) not null,
 Zip int(5) not null,
 Phone int(10) not null,
 Cell int(10) not null,
 MileageRate decimal(3,2)  not null ,
 Review date not null,
 DrivingRecord varchar(1) not null default "A",
 CONSTRAINT chk_Drivers
 CHECK (DrivingRecord='A' or DrivingRecord='B' or DrivingRecord ='C' or DrivingRecord='D'), 
 constraint pk_Drivers primary key (DriverID asc)
 );

/* create the Definition of table Employees 
*/
CREATE TABLE Employees (
    EmpID int not null auto_increment,
    EmpFirst VARCHAR(8) not null,
    EmpLast VARCHAR(10) not null,
    Address VARCHAR(24) not null,
    City VARCHAR(12) not null ,
    State VARCHAR(2) not null ,
    Zip INT not null,
    Phone VARCHAR(24) not null,
    Cell VARCHAR(24) not null,
    SSN INT not null,
    DOB DATE not null,
    StartDate DATE not null,
    EndDate DATE,
    PositionID INT,
    Salary NUMERIC(7, 2),
    HourlyRate NUMERIC(4, 2),
    Review DATE,
    Memo VARCHAR(35) CHARACTER SET utf8,
    WarehouseID varchar(4), 
    constraint pk_Employees primary key (EmpID asc)
);

/*
 create table Employees (
EmpID  int not null auto_increment,
EmpFirst  varchar(30) not null,
EmpLast varchar(30) not null,
Address varchar(60) not null,
City varchar(15)  not null,
State varchar(2) not null,
Zip int(5) not null,
Phone int(10) not null,
Cell int(10) not null,
SSN int(9) not null, 
DOB date not null,
StartDate date not null,
EndDate date null,
PositionID int not null,
Salary decimal(7,2) null,
HourlyRate decimal (4,2)  null,
Review date null,
Memo longtext ,
WarehouseID varchar(4),
 constraint pk_Employees primary key (EmpID asc)
 );
 */ 
 
 
 
 
/* create the Definition of table JobOrders */  
create table JobOrders (
JobID  int not null,
CustID int not null,
MoveDate date not null,
FromAddress varchar(60) not null,
FromCity varchar(15)  not null,
FromState varchar(2) not null,
ToAddress  varchar(60) not null,
ToCity varchar(15)  not null,
ToState varchar(2) not null,
DistanceEst double not null,
WeightEst double not null,
Packing boolean not null,
Heavy boolean not null,
Storag boolean not null,
constraint pk_JobOrder primary key (JobID asc)
); 

/* create the Definition of table Jobdetail */ 
create table JobDetail (
JobID int not null,
VehicleID varchar(7) not null,
DriverID  int   not null,
MileageActual double  not null,
WeightActual  double  not null,
 constraint pk_JObDetail primary key (JobID asc) 
); 

/* create the Definition of table StorageUnits */ 
 create table StorageUnits (
 UnitID int not null auto_increment,
 UnitSize varchar(10)  not null,
 WarehouseID varchar(4) not null,
 Rent decimal(4,2) not null,
 constraint pk_StorageUnits primary key (UnitID asc , WarehouseID asc)
 );
 
/* create the Definition of table Vehicles */ 
 create table Vehicles (
 VehicleID varchar(7) not null,
 LicensePlateNum varchar(7) not null,
 Axle int not null,
 Color varchar(20) not null,
 constraint pk_Vehicles primary key (VehicleID asc)
 );
 
 
 /* create the Definition of table Warehouse */ 
 create table Warehouse (
WarehouseID varchar(4) not null,
Address varchar(60) not null,
City varchar(15)  not null,
State varchar(2) not null,
Zip int(5) not null,
Phone int(10) not null,
ClimateControl boolean not null,
SecurityGate boolean not null,
constraint pk_Warehouse primary key (WarehouseID asc)
 );
 
 
 /* create the Definition of table position */ 
create table tblPosition (
PositionID int not null auto_increment,
Title varchar(15)  not null,
constraint pk_tblPosition primary key (PositionID asc)
); 
 
 
 

 
 
 