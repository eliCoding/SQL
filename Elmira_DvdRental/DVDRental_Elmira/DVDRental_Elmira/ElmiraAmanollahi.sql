use Northwind2014
;
go


create table[HumanResources].HumanResourcesActions(
 EmployeeID int not null,
 ActionType varchar(1) not null,
 Initiatedby int not null,
 ScheduledDate date not null,
 ApprovedBy int not null,
 EffectiveDate date not null,
 HRRating int,
 newSalary decimal(6,2) not null,
 newRate decimal(6,2),
 newBonus decimal(6,2),
 newCommission int,
 HRComments varchar(60),
  constraint pk_HumanResourcesActions primary key clustered (EmployeeiD,ActionType,ScheduledDate)

)
;
go


alter table [HumanResources].HumanResourcesActions
add constraint  fk_HumanResourcesActions_Employees foreign key ( [EmployeeID])
references [HumanResources].[Employees]([EmployeeID] );
go

alter table [HumanResources].HumanResourcesActions
add constraint df_HRActions_hrComments default 'Hired' for [HRComments];
go
alter table [HumanResources].HumanResourcesActions
add constraint df_HRActions_ActionType default 'H' for [ActionType] ;
go




insert into [HumanResources].[HumanResourcesActions] (EmployeeID, ActionType, Initiatedby, ScheduledDate, ApprovedBy, EffectiveDate, newSalary,  HRComments)
values (1,default,1,'5/1/2011',1,'5/1/2011',2000.00,default),
(2,default,1,'8/14/2011',1,'8/14/2011',3500.00,default),
(3,default,1,'5/3/2012',1,'5/3/2012',2250.00,default)
,
(4,default,2,'5/3/2012',2,'5/3/2012',2250.00,default),
(5,default,2,'10/17/2012',2,'10/17/2012',2500.00,default),
(6,default,5,'10/17/2012',2,'10/17/2012',4000.00,default),
(7,default,5,'1/2/2013',2,'1/2/2013',3000.00,default),
(8,default,2,'5/5/2013',2,'5/5/2013',2500.00,default),
(9,default,5,'11/15/2013',2,'11/15/2013',3000.00,default)
;
go


select EmployeeID, ActionType, Initiatedby, ScheduledDate, ApprovedBy, EffectiveDate, newSalary,  HRComments
from [HumanResources].[HumanResourcesActions]
;
go


if OBJECT_ID('HumanResources.ListOfCountriesView','v')    is not null drop view HumanResources.ListOfCountriesView
	;
	go

	
select e.[LastName], e.Country
from [HumanResources].[Employees] as E 
inner join
[HumanResources].[HumanResourcesActions] as H
 on e.EmployeeID = h.EmployeeID
 order by e.[LastName] asc, e.Country asc
 ;
 go

 create view HumanResources.ListOfCountriesView
as

select e.[LastName], e.Country
from [HumanResources].[Employees] as E 
inner join
[HumanResources].[HumanResourcesActions] as H
 on e.EmployeeID = h.EmployeeID
 ;
 go

create view HumanResources.EmployeeInSeattleOrLondon
as

select [LastName], [City]
from [HumanResources].[Employees]  
 where Country in ('Seattle','London')
 ;
 go


create view HumanResources.EmployeeHiredInFirstQuarterView
as

select e.[LastName],e.[EmployeeID]
from [HumanResources].[Employees] as E 
 where [HireDate] between '1/1/2016' and '1/4/2016'
 ;
 go


 create view HumanResources.yearEmployeesWerehiredView
as
select [EmployeeID],year(HireDate) as 'Hired year'
from [HumanResources].[Employees]
;
go


 create view HumanResources.AverageSalaryView
as

select AVG([newSalary]) as 'Average alary' ,[EmployeeID]
from [HumanResources].[HumanResourcesActions]
group by [EmployeeID]
;
go

create view HumanResources.EmployeeReporsView
as
select e.[EmployeeID],CONCAT(e.[FirstName],' ',e.[LastName]) as 'Full Name',e.[Title],e.[BirthDate],h.[newSalary],h.[newRate],h.[newBonus],h.[newCommission], DATEDIFF(year,[HireDate],GETDATE())as 'number of year hired'

from [HumanResources].[Employees] as E 
inner join
[HumanResources].[HumanResourcesActions] as H
 on e.EmployeeID = h.EmployeeID
 
 ;
 go


