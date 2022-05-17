--Write a query to display the first name, last name, salary, and job title, for each employee.
--Order them by their last name.



Select E.first_name, E.last_name , E.salary, J.job_title
from dbo.employees as E
left join dbo.jobs as J
on E.job_id = J.job_id
Order by E.last_name





--Write a query to display the first name, last name, department id and department name
--for all employees who work in the department having department id 5 or 7.

select * from dbo.employees

select * from dbo.departments

Select E.first_name, E.last_name, D.department_id, D.department_name
from dbo.employees as E
left join dbo.departments as D
on E.department_id = D.department_id
where E.department_id = '5'
or
E.department_id = '7'





--Write a query to display the employee id, name (first name and last name with a space
--between), hire date and a column called ‘experience’ with the values ‘Senior’ and ‘Junior’
--when the hire date is 1994 or before, and after 1994 respectively . [You can use CONCAT
--function]




Select E.employee_id, CONCAT(E.first_name,' ', E.last_name) as name , E.hire_date,
Case
   when year(hire_date) < = 1994 then 'Senior'
   else 'Junior'
End as experience
from dbo.employees as E





--Write a query to display the first name, last name, employee id, manager id and hire date
--of all employees who report to ‘Neena’.

select * from dbo.employees

select E.first_name, E.last_name , E.employee_id , E.manager_id , E.hire_date
from dbo.employees as E
where E.manager_id = 
(Select E.employee_id
from dbo.employees AS E
where E.first_name = 'Neena')









--Display the employee first name, last name, employee id, and job title for all employees
--whose department location is ‘London’.
--Hint : (USE Subquery for Where clause, There will be one join and multiple subqueries)

select * from dbo.employees
select * from departments
select * from locations


Select E.first_name, E.last_name , E.salary, J.job_title
from dbo.employees as E
left join dbo.jobs as J
on E.job_id = J.job_id
where E.department_id = 
(select D.department_id 
from dbo.departments as D
where D.location_id =
(select L.location_id 
from dbo.locations as L
where L.city = 'London'))


select E.first_name, E.last_name , E.employee_id , J.job_title
from dbo.employees as E
