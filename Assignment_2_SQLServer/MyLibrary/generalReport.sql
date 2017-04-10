/****** Object:  Database [MyBibliotheque]    
Script Date: 2017-02-17
by team: Mike Yu, Elmira and Laurian ******/
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

--- method 1 -- by nest select 
select 
   (SELECT cast(count(distinct [memberID]) as float) from [lease].[loan])
   /(SELECT cast(count(distinct [memberID]) as float) from  [members].[member])*100.0 
   as 'Active member Percentage (%)';

--- method 2 -- create function PercentofActiveMember
IF OBJECT_ID('lease.PercentofActiveMember ', 'F') IS NOT NULL
  DROP function lease.PercentofActiveMember; 
  go

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

--- method 1 -- by nest select 
 select * from 
(select [memberID], count([ISBN]) as 'greatest number' from [lease].[loan] group by [memberID]
	having count([ISBN]) = 
	(select max(cnt1) from
		(select count([ISBN]) as cnt1 from [lease].[loan]  group by [memberID])
  A ) )A;
 go

 -- method 2 -- by creating view
if OBJECT_ID('lease.GreatestNumber', 'v') is not null  
drop view lease.GreatestNumber;
go

create view lease.GreatestNumber 
as
select [memberID], count([ISBN]) as 'counts' from [lease].[loan]
group by [memberID];
go

select max(counts) as 'greates number' from lease.GreatestNumber  ;


 /***
4. What percentage of the books was loaned out at least once last year?
**/

--  create a view for all loaned book from table loan and loanhist in this year
if OBJECT_ID('lease.loaned', 'v') is not null  
drop view lease.loaned;
go

create view lease.loaned 
as
SELECT distinct [ISBN],[CopyID], [out_date] from [lease].[loan]
union all
SELECT distinct [ISBN],[CopyID], [out_date]  from [lease].[loanhist]
go

select * from  lease.loaned 

--create function to calculate the percent of book loaned in a special year

  IF OBJECT_ID('lease.PercentofBookLoaned ', 'F') IS NOT NULL
  DROP function lease.PercentofBookLoaned; 
  go

create function lease.PercentofBookLoaned (@year as int)
RETURNS NUMERIC(5,2)
AS
BEGIN
  DECLARE @BookinLoaned AS int 
  DECLARE @TotalBooks AS int 
	SELECT @BookinLoaned = count(*) from 
		( 
		select distinct ISBN, COPYID from [lease].[loaned]
		where year ([out_date]) =  @year
		)a
	select @TotalBooks= count(*) from
		( 
		select distinct ISBN, COPYID from [items].[Copy] 
		)a
	return cast(@BookinLoaned AS float)/cast(@TotalBooks AS float)*100
END;
go

select lease.PercentofBookLoaned (2008) as 'Percent % of Book once loaned';


/** 5. What percentage of all loans eventually becomes overdue?
-- Since all date are past, so I can set a date (@DATEofSet) for check the overdue in table Loan
and the in_date as the judge of the Overdue in table LoanHist
**/

IF OBJECT_ID('lease.PercentofOverdue', 'F') IS NOT NULL
  DROP function lease.PercentofOverdue; 

create function lease.PercentofOverdue 
(
@DATEofSet as date
)
RETURNS NUMERIC(5,2)
AS

BEGIN
  DECLARE @CountofOverdueHist AS int 
  DECLARE @CountofOverduNow AS int 
  DECLARE @CountofTotalLoanHist AS int 
  DECLARE @CountofTotalLoan AS int 
  DECLARE @Percentage AS NUMERIC(5,2)
		select @CountofOverdueHist=count(ISBN) 
			from [lease].[LoanHist] where [in_date] > [due_date]
		select @CountofTotalLoanHist=count(ISBN) 
			 [lease].[LoanHist]		
		select @CountofOverduNow = count(ISBN) 
			from [lease].[Loan]	  where @DATEofSet > [due_date]
		select @CountofTotalLoan = count(ISBN) 
			from [lease].[Loan]
		set  @Percentage = 
		(cast(@CountofOverdueHist AS float)+cast(@CountofOverduNow AS float))/
		(cast(@CountofTotalLoanHist AS float)+cast(@CountofTotalLoan AS float))*100.0
  RETURN   @Percentage
END;
GO
select  lease.PercentofOverdue('2007-4-1') as 'Overdue Percentage (%);'

/** 6. What is the average length of a loan?
calculate the different days between [in_date]  and [out_date] for table LoanHist
since the data for loan length in loan table is unknown
**/

if OBJECT_ID('lease.LengthLoan', 'v') is not null  
drop view lease.LengthLoan;
go
create view lease.LengthLoan 
as
select  ISBN,CopyID, DATEDIFF(day,[out_date], [in_date]) as Lengthofloan
from [lease].[LoanHist]
go

select avg(Lengthofloan)  from  lease.LengthLoan ;
go

/** 
7. What are the library peak hours for loans?
**/

if OBJECT_ID('lease.peaktime', 'v') is not null  
drop view lease.peaktime;
go
create view lease.peaktime 
as
SELECT [memberID], DATEPART(HOUR, [out_date]) as TimeHour from [lease].[loan]
union all
SELECT [memberID], DATEPART(HOUR, [out_date]) as TimeHour from [lease].[loanhist]
go

select * from lease.peaktime 
go

select count([memberID]) as 'visitors', timehour from lease.peaktime
group by timehour order by count([memberID]) desc;
