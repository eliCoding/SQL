
/****** Object:  Database [MyBibliotheque]    
Script Date: 2017-02-17
by team: Mike Yu, Elmira and Laurian ******/


-- applications ---

-- switch to the database MyLibrary
USE MyLibrary;
GO


/***
1. Create a mailing list of Library members that includes the members¡¯ full names and
 complete address information. */



-- 1) this is for adult information since only adult member has address

select concat([firstname],' ', [middleinitial],' ', [lastname] ) as 'Full Name',
concat([street],', ',[city],' ,',[state],', ',[zip]) as Address
from [members].[member] as M join [members].[adult] as A on A.[memberID]=M.[memberID]
--  join [members].[juvenile] as J
--on A.[memberID]=J.[Adult_MemberID];
order by A.[memberID] asc;

-- 2) this is for kid and their parent address

select distinct J.[Adult_MemberID] as 'parent ID',J.[memberID] as 'kid memeberID',concat([firstname],' ', [middleinitial],' ', [lastname] ) as 'Full Name',
concat([street],', ',[city],' ,',[state],', ',[zip]) as Address
from [members].[adult] as A join [members].[juvenile] as J
on A.[memberID]=J.[Adult_MemberID] join [members].[member] as M
on A.[memberID]=M.[memberID];



/***
2. Write and execute a query on the title, item, and copy tables that returns 
the isbn, copy_no, on_loan, title, translation, and cover, and values for rows 
in the copy table with an ISBN of 1 (one), 500 (five hundred), or 1000 (thousand).
Order the result by isbn column.
***/

select C.[ISBN],C.[CopyID],C.[OnLoan], T.[title], I.[Language],I.[cover]
from [items].[Copy] as C join [items].[item] as I
on C.ISBN=I.ISBN 
join [items].[title] as T on  T.titleID=I.titleID 
where C.ISBN in(1,500,1000);
 

/***
3. Write and execute a query to retrieve the member¡¯s full name and member_no from 
the member table and the isbn and log_date values from the reservation table for 
members 250, 341, 1675. Order the results by member_no. You should show information 
for these members, even if they have no books or reserve.
***/

select concat([firstname],' ', [middleinitial],' ', [lastname] ) as 'Full Name',
 M.[memberID],R.[ISBN],R.[log_date]
from [members].[member] as M join [lease].[reservation] as R 
ON M.[memberID] = R.[memberID]
where  M.[memberID] in (250,341,1675)
order by M.[memberID] asc;

/***
4. Create a view and save it as adultwideView that queries the member and adult tables.
 Lists the name & address for all adults. ***/

create view adultwideView as
select concat([firstname],' ', [middleinitial],' ', [lastname] ) as 'Full Name',
concat([street],', ',[city],' ,',[state],', ',[zip]) as Address
from [members].[member] as M join [members].[adult] as A
on A.[memberID]=M.[memberID];

select * from adultwideView;

/****
5. Create a view and save it as ChildwideView that queries the member,
 adult,and juvenile tables.Lists the name & address for the juveniles. 
**/

create view ChildwideView as
select J.[memberID] as 'Kid MemberID', concat([firstname],' ', [middleinitial],' ', [lastname] ) as 'Parent Name',
J.[Adult_MemberID] as "Parent MemberID",
concat([street],', ',[city],' ,',[state],', ',[zip]) as Address
from [members].[member] as M join [members].[adult] as A on A.[memberID]=M.[memberID] 
join [members].[juvenile] as J on J.[Adult_MemberID]=M.[memberID];
select * from ChildwideView ;

/****
6. Create a view and save it as and CopywideView that queries the copy, title and item tables.
 Lists complete information about each copy.
 **/

create view CopywideView as 
select C.[ISBN],C.[CopyID],T.[title],t.[author], I.[Language],I.[cover],C.[OnLoan]
from [items].[Copy] as C join [items].[item] as I
on C.ISBN=I.ISBN 
join [items].[title] as T on  T.titleID=I.titleID;

select * from CopywideView;

/****
7. Create a view and save it as LoanableView that queries CopywideView (3-table join). 
Lists complete information about each copy marked as loanable (loanable = 'Y').
 **/


 create view LoanableView as 
select C.[ISBN],C.[CopyID],T.[title],t.[author], I.[Language],I.[cover],C.[OnLoan],I.[loanable]
from [items].[Copy] as C join [items].[item] as I
on C.ISBN=I.ISBN 
join [items].[title] as T on  T.titleID=I.titleID
where I.[loanable]='Y';

select * from LoanableView;

/****
8. Create a view and save it as OnshelfView that queries CopywideView (3-table join). 
Lists complete information about each copy 
that is not currently on loan (on_loan ='N').
 **/

 create view OnshelfView as 
select C.[ISBN],C.[CopyID],T.[title],t.[author], I.[Language],I.[cover],C.[OnLoan],I.[loanable]
from [items].[Copy] as C join [items].[item] as I
on C.ISBN=I.ISBN 
join [items].[title] as T on  T.titleID=I.titleID
where C.[OnLoan]='N';

select * from OnshelfView ;
/*
9. Create a view and save it as OnloanView that queries the loan, title, and member tables.
 Lists the member, title, and loan information of a copy that is currently on loan.
 */
 create view OnloanView as
 select  concat([firstname],' ',[lastname] ) as 'Borrower',L.memberID,
T.[title], C.[ISBN],C.[CopyID],C.[OnLoan]
from [items].[Copy] as C join [lease].[loan] as L
on C.ISBN=L.ISBN and C.CopyID=L.CopyID
join [items].[title] as T on  T.titleID=L.titleID
join [members].[member] as M on L.memberID=M.memberID
where C.[OnLoan]='Y';

select * from OnloanView ;

/*********
10. Create a view and save it as OverdueView that queries OnloanView (3-table join.)
 Lists the member, title, and loan information of a copy on loan that is overdue 
 (due_date < current date).
 since all data are old, so all items are listed since cuurent day is much later!
  **********/

create view OverdueView  as
select  L.memberID, concat([firstname],' ',[lastname] ) as 'Borrower',
T.[title], L.[out_date], L.[due_date]
from [lease].[loan] as L join [items].[title] as T 
on  T.titleID=L.titleID
join [members].[member] as M on L.memberID=M.memberID
where [due_date]<getdate();



/*********    Generating Usage Reports   *********/


/***  1. How many loans did the library do last year?
-- I use procedure to do that by the prameters [out_date] as the year to the book loan
***/


IF OBJECT_ID('lease.CountsLoanbyYear ', 'P') IS NOT NULL
  DROP proc lease.CountsLoanbyYear; 

create proc lease.CountsLoanbyYear 
(
@year as int
) as 
begin
	select count([out_date]) 
	from [lease].[loan] 
	where @year = year ([out_date])
end;
go
exec lease.CountsLoanbyYear @year = 2008;


-- 2. What percentage of the membership borrowed at least one book?

--- (1) nest select 
select 
   (SELECT cast(count(distinct [memberID]) as float) from [lease].[loan])
   /(SELECT cast(count(distinct [memberID]) as float) from  [members].[member])*100.0 
   as 'Active member Percentage (%)';

-- (2) create function PercentofActiveMember
IF OBJECT_ID('lease.PercentofActiveMember ', 'F') IS NOT NULL
  DROP function lease.PercentofActiveMember; 

create function lease.PercentofActiveMember ()
RETURNS NUMERIC(5,2)
AS
BEGIN
  DECLARE @MemberTotal AS int 
  DECLARE @ActiveMemberTotal AS int 
   DECLARE @Percentage AS NUMERIC(5,2)
  SELECT  @ActiveMemberTotal = count(distinct [memberID])
		from [lease].[loan] as L
  SELECT  @MemberTotal = count(M.[memberID])
		from [members].[member] as M   
		set  @Percentage = cast(@ActiveMemberTotal AS float)/cast(@MemberTotal AS float)*100
		
  RETURN   @Percentage
END;
GO
select  lease.PercentofActiveMember () as 'Active member Percentage (%);'

/*** 3. What was the greatest number of books borrowed by any one individual?
**/
 select * from 
(select [memberID], count([ISBN]) as cnt from [lease].[loan] group by [memberID]
	having count([ISBN]) = 
	(select max(cnt1) from
		(select count([ISBN]) as cnt1 from [lease].[loan]  group by [memberID])
  A ) )A;
 go

 -- or 
 select [memberID], count([ISBN]) 
 from [lease].[loan] group by [memberID] order by count([ISBN]) desc ;


 /***
4. What percentage of the books was loaned out at least once last year?
**/

select count() 

SELECT Count(*)
FROM   (
        SELECT [ISBN],[CopyID] from [lease].[loan]
       ) As distinctified

SELECT Count(*)
FROM   (
        SELECT [ISBN],[CopyID] from [lease].[loan]
       ) As distinctified



IF OBJECT_ID('lease.PercentofActiveMember ', 'F') IS NOT NULL
  DROP function lease.PercentofActiveMember; 

create function lease.PercentofActiveMember ()
RETURNS NUMERIC(5,2)
AS
BEGIN
  DECLARE @MemberTotal AS int 
  DECLARE @ActiveMemberTotal AS int 
   DECLARE @Percentage AS NUMERIC(5,2)
  SELECT  @ActiveMemberTotal = count(distinct [memberID])
		from [lease].[loan] as L
  SELECT  @MemberTotal = count(M.[memberID])
		from [members].[member] as M   
		set  @Percentage = cast(@ActiveMemberTotal AS float)/cast(@MemberTotal AS float)*100
		
  RETURN   @Percentage
END;
GO
select  lease.PercentofActiveMember () as 'Active member Percentage (%);'




5. What percentage of all loans eventually becomes overdue?
6. What is the average length of a loan?
7. What are the library peak hours for loans?

