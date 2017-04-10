use Moveon_lem;
/* This file for input some data for creted tables
    developed by Mike, Elmira and Slaurian
*/

   

 /*Set the Different types of constraints : 
primary key (pk)| foreign key  (fk)| unique (u) | check(ck) | default (df
*/

/*set the default value of Balance to '0' in Customer table*/
 alter table Customers 
 alter Balance set default '0';
 
 
 
 /*Add foreign key(s) to the UnitRentals*/
 /*	1) beween the order UnitRentals and CustID*/
 alter table UnitRentals
 add constraint fk_UnitRentals_Customers foreign key (CustID)
 references Customers(CustID);

 /*	2) beween the UnitRentals and WarehouseID*/
 alter table UnitRentals
 add constraint fk_UnitRentals_Warehouse foreign key (WarehouseID)
 references Warehouse(WarehouseID);
 

 /* 3) add a check constraint to the DateIn in unitRental table*/
 alter table UnitRentals
 add constraint ck_DateIn_UnitRentals
 check(DateIn >= current_date() and DateOut >=current_date());

 /* 4) add a check constraint to the StartDate in Drivers table*/
 alter table Drivers
 add constraint ck_StartDate_Drivers
 check (StartDate  >= current_date() and EndDate >= current_date());

 /* 5) FK beween the storageUnit and UnitRentals*/
  alter table UnitRentals
 add constraint fk_UnitRentals_StorageUnits foreign key (UnitID)
 references StorageUnits(UnitID);

 /*6) FK beween the Employees and PositionID*/
 alter table Employees
 add constraint fk_Employees_tblPosition foreign key (PositionID)
 references tblPosition(PositionID);
 

 /*7) FK beween the JobOrders and Customers*/
 alter table JobOrders
 add constraint fk_JobOrders_Customers foreign key (CustID)
 references Customers(CustID);
 
 /* 8) FK beween the JObDetail and vehicle  VehicleID */ 
alter table JObDetail
 add constraint fk_JObDetail_Vehicles foreign key (VehicleID)
 references Vehicles(VehicleID);
 
  /* 9) FK beween the JObDetail and Drivers   */ 
 alter table JObDetail
 add constraint fk_JObDetail_Drivers foreign key (DriverID)
 references  Drivers(DriverID);
 
 /* 10) FK beween the storageUnit and WarehoueID*/
  alter table StorageUnits
 add constraint fk_StorageUnits_Warehouse foreign key (WarehouseID)
 references Warehouse(WarehouseID);
 
  
 /* 11) FK beween the JObDetail and JobOrders
         relationship 1:1 */
 alter table JobOrders
 add constraint fk_JobOrders_JObDetail foreign key (JobID)
 references JObDetail(JobID);
 
  alter table JObDetail
 add constraint fk_JObDetail_JobOrders foreign key (JobID)
 references JobOrders(JobID);
 
 
  /* 5) FK beween the Employees and WarehoueID
    This query was fine before data imported, but after data importaed, it reports 1452 error!!!
  
 alter table Employees
 add constraint fk_Employees_Warehouse foreign key (WarehouseID)
 references Warehouse(WarehouseID);
 */


--   insert data for table employees

INSERT INTO Employees VALUES (1,'David','Bowers','10124 Metropolitan Drive','Seattle','WA',98117,2062465132,2065754321,154003785,'1985-09-12 00:00:00','1998-01-22 00:00:00',NULL,1,72000.00,NULL,NULL,NULL,'WA-1');
INSERT INTO Employees VALUES (2,'Robert','Iko','698 Round Mountain','Seattle','WA',98124,2065472315,2064875312,705246513,'1994-12-16 00:00:00','2006-12-15 00:00:00',NULL,7,59500.00,NULL,'2007-06-15 00:00:00',NULL,'WA-1');
INSERT INTO Employees VALUES (3,'Virginia','Sanchez','201 River Road','Spokane','WA',99215,093451687,096348732,724568132,'1988-10-24 00:00:00','2004-06-10 00:00:00',NULL,2,48500.00,NULL,'2007-12-15 00:00:00','Emergency contact for alarm company','WA-1');
INSERT INTO Employees VALUES (4,'Eric','Behrens','21 Adrian Way','Jackson Hole','WY',83005,3075461272,3075763154,956346120,'1995-02-14 00:00:00','2005-09-12 00:00:00','2006-02-15 00:00:00',3,NULL,12.50,NULL,NULL,'WY-1');
INSERT INTO Employees VALUES (7,'Brian','Castillo','52 Denton Drive #49','Portland','OR',97205,5035742742,5035647154,923546124,'1990-08-14 00:00:00','2001-06-14 00:00:00',NULL,3,NULL,12.75,'2008-06-14 00:00:00',NULL,'OR-1');
INSERT INTO Employees VALUES (8,'Cynthia','Cox','1515 Patterson Road','Portland','OR',97210,5032412423,5035496113,854230000,'1985-10-06 00:00:00','2006-12-30 00:00:00',NULL,2,50000.00,NULL,'2007-06-30 00:00:00',NULL,'OR-1');
INSERT INTO Employees VALUES (9,'John','Maestas','5506 Beach Street West','Spokane','WA',99216,5096741543,5093782312,487002468,'1995-11-24 00:00:00','2001-11-15 00:00:00',NULL,4,42500.00,NULL,'2007-11-01 00:00:00','Speaks fluent Spanish','WA-1');
INSERT INTO Employees VALUES (10,'Mark','Cumberland','16542 Angus Road #280','Portland','OR',97206,5032486453,5032786424,705435126,'1996-07-30 00:00:00','2002-10-01 00:00:00','2006-03-15 00:00:00',6,NULL,12.25,NULL,NULL,'OR-1');
INSERT INTO Employees VALUES (11,'Darnell','Colmenero','6000 Balcones Drive','Seattle','WA',98113,2063475354,2063547215,723549785,'1997-04-05 00:00:00','2002-09-02 00:00:00',NULL,3,NULL,15.00,'2008-09-15 00:00:00',NULL,'WA-1');
INSERT INTO Employees VALUES (12,'James','Lu','5003 Mallard Avenue #587','Jackson Hole','WY',83001,3076784513,3072468732,709564321,'1999-12-31 00:00:00','2005-02-24 00:00:00',NULL,2,48500.00,NULL,'2007-02-24 00:00:00','Speaks fluent Chinese','WY-1');
INSERT INTO Employees VALUES (13,'Barry','Orosco','2001 Kenosha Pass','Spokane','WA',99216,5093451357,5093575166,723246875,'1989-07-04 00:00:00','2006-03-21 00:00:00','2006-05-15 00:00:00',5,NULL,9.75,NULL,NULL,'WA-1');
INSERT INTO Employees VALUES (14,'Richard','Hargadon','901 Great Oaks Cove','Seattle','WA',98154,2063547987,2063541287,984651372,'1991-03-01 00:00:00','2006-07-15 00:00:00',NULL,6,NULL,10.50,'2007-08-15 00:00:00',NULL,'WA-1');
INSERT INTO Employees VALUES (15,'John','Nader','321 Sturgis','Jackson Hole','WY',83001,3075467135,3072468731,905346755,'1992-04-24 00:00:00','2001-08-01 00:00:00',NULL,3,NULL,11.25,'2008-08-01 00:00:00',NULL,'WY-1');
INSERT INTO Employees VALUES (16,'George','Medrano','3987 NW 87th Street #8','Seattle','WA',98124,2063412024,2063241200,546570000,'1994-04-10 00:00:00','2006-10-15 00:00:00',NULL,6,NULL,11.25,'2008-10-15 00:00:00',NULL,'WA-1');
INSERT INTO Employees VALUES (17,'Rachel','Goodman','9876 Parker Street','Portland','OR',97204,5032415756,5032175613,978451342,'1997-06-21 00:00:00','2004-11-03 00:00:00',NULL,5,NULL,12.75,'2008-01-15 00:00:00','On maternity leave through 12/2008','OR-1');
INSERT INTO Employees VALUES (18,'Shayla','Anderson','4321 Barton Cliff Drive','Seattle','WA',98124,2063214571,2063218756,926543210,'1988-09-28 00:00:00','2003-09-24 00:00:00',NULL,6,NULL,12.50,'2008-09-15 00:00:00',NULL,'WA-1');
INSERT INTO Employees VALUES (19,'Alfonso','Ozmun','510 Immanuel Avenue','Seattle','WA',98126,2063124024,2062497513,946532100,'1990-05-30 00:00:00','2005-06-15 00:00:00',NULL,5,NULL,12.00,'2008-02-28 00:00:00',NULL,'WA-1');
INSERT INTO Employees VALUES (20,'Sophia','Nunis','5471 Wyoming Springs Way','Spokane','WA',99214,5093478992,5098973246,987451372,'1989-12-12 00:00:00','2006-10-20 00:00:00',NULL,6,NULL,12.00,'2008-01-15 00:00:00',NULL,'WA-1');
INSERT INTO Employees VALUES (21,'Dora','Nettles','24 Frontier Trail NE','Seattle','WA',98123,2067546512,2065795462,723246512,'1988-10-14 00:00:00','2002-10-21 00:00:00',NULL,3,NULL,14.75,'2008-02-15 00:00:00',NULL,'WA-1');
INSERT INTO Employees VALUES (22,'Kristina','Romano','8 Anderson Loop','Seattle','WA',98113,2062449876,2062748648,704513547,'1997-06-20 00:00:00','2001-05-20 00:00:00',NULL,4,45000.00,NULL,'2008-05-01 00:00:00',NULL,'WA-1');
INSERT INTO Employees VALUES (23,'Doug','Hearne','11 Lost Pine Trail','Portland','OR',97204,5032462465,5037654354,722154321,'1982-05-21 00:00:00','2004-01-15 00:00:00',NULL,6,NULL,12.75,'2008-01-15 00:00:00',NULL,'OR-1');
INSERT INTO Employees VALUES (24,'Tom','Murphy','4007 James White Avenue','Portland','OR',97214,5032471355,5037543257,701543216,'1977-06-05 00:00:00','2004-02-16 00:00:00',NULL,6,NULL,13.00,'2008-03-15 00:00:00',NULL,'OR-1');
INSERT INTO Employees VALUES (25,'Felicia','Castro','611 Montclaire Street','Portland','OR',97226,5037543871,5034757135,724216452,'1980-09-14 00:00:00','2005-03-16 00:00:00',NULL,6,NULL,12.50,'2008-03-15 00:00:00',NULL,'OR-1');
INSERT INTO Employees VALUES (26,'Gene','Chiles','2506 Ferguson Lane #411','Portland','OR',97215,5032798246,5032467835,954321642,'1982-07-05 00:00:00','2004-03-01 00:00:00',NULL,6,NULL,12.50,'2008-03-01 00:00:00',NULL,'OR-1');
INSERT INTO Employees VALUES (27,'Kirby','Meyer','110 Ponderosa','Portland','OR',97209,5032716579,5032795132,984651357,'1980-11-12 00:00:00','2005-05-31 00:00:00',NULL,4,42500.00,NULL,'2007-12-15 00:00:00',NULL,'OR-1');
INSERT INTO Employees VALUES (28,'Jim','Bostic','1201 Chestnut Avenue #2','Portland','OR',97211,5032715496,5032164573,454006543,'1979-12-12 00:00:00','2005-07-06 00:00:00',NULL,6,NULL,11.75,'2008-07-01 00:00:00',NULL,'OR-1');
INSERT INTO Employees VALUES (29,'Leland','McKeeman','79513 Airport Blvd.','Jackson Hole','WY',83005,3072462135,3072462465,963124672,'1978-11-01 00:00:00','2004-09-25 00:00:00',NULL,3,NULL,14.50,'2008-09-01 00:00:00',NULL,'WY-1');
INSERT INTO Employees VALUES (30,'Wade','Ragland','9714 Circle Drive','Jackson Hole','WY',83005,3072749264,3072243241,706324675,'1980-03-01 00:00:00','2004-09-25 00:00:00',NULL,4,43500.00,NULL,'2008-09-01 00:00:00',NULL,'WY-1');
INSERT INTO Employees VALUES (31,'Cynthia','Zucker','304 Ridgewood Drive #1','Jackson Hole','WY',83002,3075556432,3072465796,705315790,'1967-08-22 00:00:00','2001-06-22 00:00:00',NULL,6,NULL,11.50,'2007-06-01 00:00:00',NULL,'WY-1');
INSERT INTO Employees VALUES (32,'Lisa','Virr','10086 Wells Parkway','Jackson Hole','WY',83010,3072746313,3072154324,421001579,'1980-11-28 00:00:00','2006-11-16 00:00:00',NULL,5,NULL,11.50,'2007-11-15 00:00:00',NULL,'WY-1');
INSERT INTO Employees VALUES (33,'Shane','Pichardo','8301 Alvin High Blvd.','Jackson Hole','WY',83011,3075553216,3072468763,987465137,'1983-12-14 00:00:00','2006-01-29 00:00:00',NULL,6,NULL,11.50,'2007-01-15 00:00:00',NULL,'WY-1');
INSERT INTO Employees VALUES (34,'Richard','Pena','5713 Mystic Street','Jackson Hole','WY',83012,3072456876,3072132762,716543272,'1981-02-24 00:00:00','2006-04-26 00:00:00',NULL,6,NULL,11.75,'2007-11-25 00:00:00',NULL,'WY-1');
INSERT INTO Employees VALUES (35,'Jason','Collins','10275 Sam Bass Road','Jackson Hole','WY',83012,3072623546,3072664533,722165711,'1980-10-14 00:00:00','2005-08-01 00:00:00',NULL,6,NULL,11.85,'2007-08-01 00:00:00',NULL,'WY-1');

select * from employees;

insert into customers (CompanyName,ContactFirst
,ContactLast,Address,City,State,Zip,Phone,Balance)
values ('Piazza Real Estate','Terry','Ramadani','1897 Gary Ave',
'Spokane','WA','99204','(509) 324-8213',default),
('McDonald Construction','Terese','Spredemann','5976 14th Ave NW','Portland',
'OR','97233','(503) 798-5646',default),
('Douglas Law Firm','Susan','Suarez','375 56th St','Spokane','WA','99245',
'(509) 857-2465',default);

select * from customers;

insert into drivers (DriverFirst,DriverLast,SSN,DOB,StartDate,EndDate,Address,City,
State,Zip,Phone,Cell,MileageRate,Review,DrivingRecord)
values('Jerry','Lo','124002465','1986/09/12','2014/01/22',
'2014/06/15','600 East 22nd Street','Jackson Hole','WY','83001','306435512',
'307545444','0.35','2014/08/16'
,'A'),
('John','Samson','725461340','1984/12/16 ','2015/11/22','2015/11/22'
,'9708 Manchaca Road',
'Spokane','WA','99213','509542212','509574115','0.3','2015/05/20','A');

select * from drivers;

insert into jobdetail (JobID,VehicleID,DriverID,MileageActual,WeightActual)
values ('2','TRK-003','4','68','1300'),
('3','TRK-002','3','18','2260'); 


select * from jobdetail;


insert into joborders(CustID,MoveDate,FromAddress,FromCity,FromState,ToAddress,ToCity,
ToState,DistanceEst,WeightEst,Packing,Heavy,Storag)
values ('1','2016/09/05','1789 Eighth Avenue','Spokane',
'WA','7899 Grandview Apt #5','Pullman','WA','60','1250',TRUE,TRUE,FALSE),

('3','2016/09/15','4433 Grindstaff St','Kennewick',
'WA','#3 Madison Ct','Richmond','WA',
'10','2000',FALSE,FALSE,FALSE);
select * from joborders;

insert into storageunits (UnitID,UnitSize,WarehouseID,Rent)
values ('1','8 x 8','OR-1','25'),('1','12 x 12','WA-1','35'); 
select * from storageunits;


  -- Data for tblposition table;
insert into tblposition (PositionID, Title)
values (1,'Manager'),(2,'Clerk'),(3,'Office Staff'),
   (4,'Worker'), (5,'Moving Staff'), (6,'Receptionist'), (7,'Assistant');
select * from tblposition;

insert into unitrentals (CustID,WarehouseID,UnitID,DateIn,DateOut)
values ('2','OR-1','4','2016/01/04',null), ('2','OR-1','5','2016/01/04',null); 

select * from unitrentals;


insert into  vehicles (LicensePlateNum,VehicleID,Axle,Color)
values('JFG 899','TRK-001','4','Green'), ('KKL 900','TRK-002','4','Blue');

select * from vehicles;


insert into warehouse (WarehouseID,Address,City,State,Zip,Phone,ClimateControl,SecurityGate)
values ('WA-1','6000 Balcones Drive','Spokane','WA','99216','376784513',true,false), 
('OR-1','2001 Kenosha Pass','Seattle','WA','98154','206312024',false,true);

select * from warehouse;






 