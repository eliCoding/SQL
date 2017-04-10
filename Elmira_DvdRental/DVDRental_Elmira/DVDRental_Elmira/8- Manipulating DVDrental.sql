/*Manipulating data 
Script Date: February 14,2017
Developed by: Elmria Amnollahi
*/

use DVDRental;
go


/* to answer the question, follow these steps:
    1.Select object(s) needed to answerr the question(table,view, or Function)
	2. Select Column(s) From selected object(s)
	3. Run the Script
	4. Define Criteria(s) and run them one after another

*/
/*List all dvd id,name, year releases*/
select DVDID,DVDName,YearRIsd 
from [production].[dvds]
;
go

/* /*List all dvd id,name, year releases in 2001*/*/
select DVDID,DVDName,YearRIsd 
from [production].[dvds]
where YearRIsd  = '2001'
;
go

/*list all dvds that have more than one disk*/
select DVDID,DVDName
from [production].[dvds]
where NumDisks >1 
;
go


/*re type the previous Script and add alias*/

select DVDID,DVDName
from [production].[dvds] as D
where NumDisks >1 
;
go


/*using alias, Change the column name in the result set of the Employee Table*/
select E.EmpID as 'EmployeeID' ,E.EmpFN as 'First Name',E.EmpMN as 'Middle Name' ,E.EmpLN as 'Last Name'
from [person].[employees] as E 

;
go

/*return the employeefull name as a single String*/
select (E.EmpFN + ' '+  E.EmpMN + ' '+  E.EmpLN) as 'Full Name'
from [person].[employees] as E 

;
go

select concat (E.EmpFN,' ', E.EmpMN,' ', E.EmpLN) as 'Full Name'
from [person].[employees] as E 

;
go

/* update data
  syntax: update sechema_name.table_name
          set column_name  = Expression
*/

select * from [sales].[transactions]
;
go

/*Change the date in to February 17 for the transID number 1*/
Update [sales].[transactions]   
     set  [DateIn] = '2017-02-17'
     where [TransID] = '1'
;
go


/*set the dateIN to date due + 3 days for transaction id = 2*/
update sales.transactions
  set  DateIn =GETDATE() + 6
  where TransID = 2
;
go


/*return the loan time from each dvd in a number of days*/
select t.TransID,t.DateOut,t. DateDue,t.DateIn , datediff(DAY,DateOut,DateIn) as ' Day loan time', '  ' as 'Empty',datediff(HOUR,DateOut,DateIn) as 'hour loan time'
from [sales].[transactions] as t
 ;
 go


 /*Return the unique rating id from the table DVDs*/
 select  distinct  [RatingID] as 'Unique Rating ID'
from [production].[dvds]
;
go


/*return dvd names and movie types for the status ID number S1,S3,and S4*/
select [DVDName], [MtypeID],[StatID]
from [production].[dvds]
where [StatID] in ('S1','S3','S4')
;
go

/*join syntax:
    select T1.F1, T1.F2, T2.F1,  T2.F2
	from table_1 as T1 inner OJin table as T2
	on T1.pk = T2.FK

	
	from table_1 as T1 left outer join table as T2
	on T1.pk = T2.FK

	from table_1 as T1 right outer join table as T2
	on T1.pk = T2.FK

	from table_1 as T1 cross join table as T2
	on T1.pk = T2.FK


*/
/*return dvd names and movie types description and  status description for the status ID number S1,S3,and S4*/
select d.DVDName, d.MtypeID,s.StatID,s.StatDescrip,m.MTypeDescrip
from [production].[dvds] as d inner join [production].[status] as s 
on d.StatID  = s.StatID
 inner join [production].[MoviesTypes] as  m
 on  d.MtypeID  =   m.MtypeID
where s.StatID in ('S1','S3','S4')
;
go