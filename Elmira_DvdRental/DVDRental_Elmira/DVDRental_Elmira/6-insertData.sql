/*inser data into dvdRental Tables.SQl
Script Date: February 13,2017
Developed by: Elmria Amnollahi
*/
use DVDRental;

go

bulk insert [person].[roles]
from 'H:\Elmira\Winter Semester\SQL2\Elmira_DataBase\DVDRental_Elmira\DVDRental_Elmira\DvDRows.csv'
with 
(
firstrow =2,
Fieldterminator = ',',
rowterminator = '\n'
);

select * from [person].[roles]

/* Inserts into the Roles table */
INSERT INTO [person].[roles] (RoleID, RoleDescrip)
VALUES ('r101', 'Actor'),
('r102', 'Director'),
('r103', 'Producer'),
('r104', 'Executive Producer'),
('r105', 'Co-Producer'),
('r106', 'Assistant Producer'),
('r107', 'Screenwriter'),
('r108', 'Composer');
go

select * from [person].[roles]

exec sp_help '[person].[roles]'
;
go

/* Inserts into the MovieTypes table */
INSERT INTO [production].[MoviesTypes] (MTypeID, MTypeDescrip)
VALUES ('mt10', 'Action'),
('mt11', 'Drama'),
('mt12', 'Comedy'),
('mt13', 'Romantic Comedy'),
('mt14', 'Science Fiction/Fantasy'),
('mt15', 'Documentary'),
('mt16', 'Musical');
go

select * from [production].[MoviesTypes]
go

exec sp_help '[production].[MoviesTypes]'
go

/* Inserts into the Studios table */
INSERT INTO [production].[studios]
VALUES ('s101', 'Universal Studios'),
('s102', 'Warner Brothers'),
('s103', 'Time Warner'),
('s104', 'Columbia Pictures'),
('s105', 'Paramount Pictures'),
('s106', 'Twentieth Century Fox'),
('s107', 'Merchant Ivory Production');
go

select * from [production].[studios]
go

/* Inserts into the Ratings table */
INSERT INTO  [production].[ratings]
VALUES ('NR', 'Not rated'),
('G', 'General audiences'),
('PG', 'Parental guidance suggested'),
('PG13', 'Parents strongly cautioned'),
('R', 'Under 17 requires adult'),
('X', 'No one 17 and under');
go

select * from [production].[ratings]
go

/* Inserts into the Formats table */
INSERT INTO [production].[formats]
VALUES ('f1', 'Widescreen'),
('f2', 'Fullscreen');
go

select * from  [production].[formats]
go

/* Inserts into the Status table */
INSERT INTO [production].[status]
VALUES ('s1', 'Checked out'),
('s2', 'Available'),
('s3', 'Damaged'),
('s4', 'Lost');
go

select * from [production].[status]
go

exec sp_depends '[production].[status]'

/* Inserts into the Particpants table */
INSERT INTO  [person].[participants](PartFN, PartMN, PartLN)
VALUES ('Sydney', NULL, 'Pollack'),
('Robert', NULL, 'Redford'),
('Meryl', NULL, 'Streep'),
('John', NULL, 'Barry'),
('Henry', NULL, 'Buck'),
('Humphrey', NULL, 'Bogart'),
('Danny', NULL, 'Kaye'),
('Rosemary', NULL, 'Clooney'),
('Irving', NULL, 'Berlin'),
('Michael', NULL, 'Curtiz'),
('Bing', NULL, 'Crosby');
go

select * from [person].[participants]
go

/* Inserts into the Employees table */
INSERT INTO [person].[employees](EmpFN, EmpMN, EmpLN)
VALUES ('John', 'P.', 'Smith'),
('Robert', NULL, 'Schroader'),
('Mary', 'Marie', 'Michaels'),
('John', NULL, 'Laguci'),
('Rita', 'C.', 'Carter'),
('George', NULL, 'Brooks');
go

select * from  [person].[employees]
go

/* Inserts into the Customers table */
INSERT INTO [sales].[Customers] (CustFN, CustMN, CustLN)
VALUES ('Ralph', 'Frederick', 'Johnson'),
('Hubert', 'T.', 'Weatherby'),
('Anne', NULL, 'Thomas'),
('Mona', 'J.', 'Cavenaugh'),
('Peter', NULL, 'Taylor'),
('Ginger', 'Meagan', 'Delaney');
go

select * from [sales].[Customers]
go

/* Inserts into the DVDs table */
INSERT INTO [production].[dvds](DVDName, NumDisks,[YearRIsd] , MTypeID, StudID, RatingID, FormID, StatID)
VALUES ('White Christmas', 1, '2000', 'mt16', 's105', 'NR', 'f1', 's1'),
('What''s Up, Doc?', 1, '2001', 'mt12', 's103', 'G', 'f1', 's2'),
('Out of Africa', 1, '2000', 'mt11', 's101', 'PG', 'f1', 's1'),
('The Maltese Falcon', 1, '2000', 'mt11', 's103', 'NR', 'f1', 's2'),
('Amadeus', 1, '1997', 'mt11', 's103', 'PG', 'f1', 's2'),
('The Rocky Horror Picture Show', 2, '2000', 'mt12', 's106', 'NR', 'f1', 's2'),
('A Room with a View', 1, '2000', 'mt11', 's107', 'NR', 'f1', 's1'),
('Mash', 2, '2001', 'mt12', 's106', 'R', 'f1', 's2');
go

select * from [production].[dvds]
go

delete from [production].[dvds]
dbcc checkident (DVDs, reseed, 0)

/* Inserts into the DVDParticipant table */
INSERT INTO [production].[DVDparticipants]
VALUES (3, 1, 'r102'),
(3, 4, 'r108'),
(3, 1, 'r103'),
(3, 2, 'r101'),
(3, 3, 'r101'),
(4, 6, 'r101'),
(1, 8, 'r101'),
(1, 9, 'r108'),
(1, 10, 'r102'),
(1, 11, 'r101'),
(1, 7, 'r101'),
(2, 5, 'r107');
go

 

select * from [production].[DVDparticipants]
go
 
exec sp_help '[production].[DVDparticipants]'
go

/* Inserts into the Orders table */
INSERT INTO  [sales].[orders](CustID, EmpID)
VALUES (1, 3),
(1, 2),
(2, 5),
(3, 6),
(4, 1),
(3, 3),
(5, 2),
(6, 4),
(4, 5),
(6, 2),
(3, 1),
(1, 6),
(5, 4);
go

select * from [sales].[orders]
go


/* Inserts into the Transactions table */
INSERT INTO [sales].[transactions](OrderID, DVDID, DateOut, DateDue)
VALUES (1, 1, GETDATE(), GETDATE()+3),
(1, 4, GETDATE(), GETDATE()+3),
(1, 8, GETDATE(), GETDATE()+3),
(2, 3, GETDATE(), GETDATE()+3),
(3, 4, GETDATE(), GETDATE()+3),
(3, 1, GETDATE(), GETDATE()+3),
(3, 7, GETDATE(), GETDATE()+3),
(4, 4, GETDATE(), GETDATE()+3),
(5, 3, GETDATE(), GETDATE()+3),
(6, 2, GETDATE(), GETDATE()+3),
(6, 1, GETDATE(), GETDATE()+3),
(7, 4, GETDATE(), GETDATE()+3),
(8, 2, GETDATE(), GETDATE()+3),
(8, 1, GETDATE(), GETDATE()+3),
(8, 3, GETDATE(), GETDATE()+3),
(9, 7, GETDATE(), GETDATE()+3),
(9, 1, GETDATE(), GETDATE()+3),
(10, 5, GETDATE(), GETDATE()+3),
(11, 6, GETDATE(), GETDATE()+3),
(11, 2, GETDATE(), GETDATE()+3),
(11, 8, GETDATE(), GETDATE()+3),
(12, 5, GETDATE(), GETDATE()+3),
(13, 7, GETDATE(), GETDATE()+3);
go

select * from [sales].[transactions]





