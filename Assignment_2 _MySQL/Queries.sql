
/* Script Date: February ,1,2017 */
/* Developed by:Elmira Amanollahi, Laurian Staicu, Mike*/




/*Q7: In what states or provinces do the employees reside? 
Save this query as qryEmployeeStatesProvinces*/

select distinct State as 'EmployeeStatesProvinces'
from employees;


/* Q8: How many employees in each city?
 Save this query as qryEmployeesPerCity*/
 SELECT City, COUNT(EmpID) as 'Number of Employees', concat_ws(' ',EmpFirst,EmpLast ) as 'Full Name'
 FROM employees
 GROUP BY City
 Order By City;


/*Q9: Who makes the highest salary? 
Save this query as qrySalariedEmployees*/
select concat_ws(' ',EmpFirst,EmpLast ) as 'Full Name',max(Salary) as 'SalariedEmployees', EmpID
FROM employees
group by HourlyRate;




/*Q10: Who is paid the lowest hourly rate?
 Save this query as qryEmployeeLowWage*/
select concat_ws(' ',EmpFirst,EmpLast ) as 'Full Name',min(HourlyRate) as 'EmployeeLowWage',EmpID
FROM employees
group by HourlyRate;
 
 /*Q11:How many types of jobs are offered at MonivOn?
 Save this query as qryJobPositions*/
 select count( distinct PositionID) as 'JobPositions',PositionID
 FROM employees
 group by PositionID;  
 
 
 /*Q12: How many people are employed in each type of job? 
 Save this query as qryJobsPerPosition */
 
SELECT distinct PositionID, COUNT(EmpID) as 'JobsPerPosition'   
 FROM employees
 GROUP BY PositionID
 Order By PositionID;


