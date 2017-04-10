bulk insert members.adult 
from 
'H:\Elmira\Winter Semester\SQL2\Assignment2\Library Database Data Files for Assignment 2\populate Library database\adults.csv'
with 
(
firstrow =2,
Fieldterminator = ',',
rowterminator = '\n'
);
go

select * from members.adult