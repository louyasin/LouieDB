--1. Write a query to display the employee id, employee name (first name and last name) for all employees who earn more than the average salary. 

SELECT employee_id, first_name, last_name
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

--2. Write a query to display the employee name (first name and last name), employee id, and salary of all employees who report to Payam. 

SELECT first_name, last_name, employee_id, salary
FROM employees
WHERE manager_id = (SELECT employee_id
                    FROM employees
                    WHERE first_name = 'Payam');

--3. Write a query to display the department number, name (first name and last name),job_id and department name for all employees in the Finance department.

SELECT first_name, last_name, job_title, department_name
FROM employees, departments, jobs
WHERE department_name = 'Finance';

--4. Write a query to display all the information of the employees whose salary is withinthe range of the smallest salary and 2500.

SELECT *
FROM employees
WHERE salary BETWEEN (SELECT MIN(salary) FROM employees) AND 2500;

--5. Write a SQL query to find the first name, last name, department, city, and state province for each employee.

SELECT first_name, last_name, department_name, city, state_province FROM employees, departments, locations;

--6. Write a SQL query to find all those employees who work in department ID 80 or 40.Return first name, last name, department number, and department name.

SELECT E.first_name , E.last_name , 
       E.department_id ,  D.department_name 
         FROM employees E 
         JOIN departments D 
          ON E.department_id = D.department_id 
          AND E.department_id IN (80 , 40)
           ORDER BY E.last_name;

--7.  Write a query to display the employee name (first name and last name) and hire date for all employees in the same department as Clara. Exclude Clara.

SELECT first_name, last_name, hire_date
FROM employees
WHERE department_id = (SELECT department_id
                    FROM employees
                    WHERE first_name = 'Clara')
    AND first_name <> 'Clara';

--8. Write a query to display the employee number, name (first name and last name), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.

SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
AND department_id IN (
    SELECT department_id
    FROM employees
    WHERE first_name LIKE '%J%'
);

--9. Write a SQL query to find those employees whose first name contains the letter ‘z’.Return first name, last name, department, city, and state province.

SELECT E.first_name, E.last_name, D.department_name, L.city, L.state_province
FROM employees E,departments D, locations L
WHERE first_name LIKE '%z%';

--10. Write a SQL query to find all departments, including those without employees. Return first name, last name, department ID, department name.

SELECT first_name, last_name, E.department_id, D.department_name
FROM employees E, departments D;

--11. Write a query to display the employee number, name (first name and last name) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.

SELECT employee_id, first_name, last_name, job_title
FROM employees, jobs
WHERE salary < ANY (
    SELECT salary
    FROM employees
    WHERE job_title = 'MK_MAN'
);

--12. Write a query to display the employee number, name (first name and last name) and job title for all employees whose salary is more than any salary of thoseemployees whose job title is PU_MAN. Exclude job title PU_MAN.

SELECT employee_id, first_name, last_name, job_title
FROM employees, jobs
WHERE salary > ALL (
    SELECT salary
    FROM employees
    WHERE job_title = 'PU_MAN'
)
AND job_title <> 'PU_MAN';

--13. Write a query to display the employee number, name (first name and last name) and job title for all employees whose salary is more than any average salaryof any department.

SELECT employee_id, first_name, last_name, job_title
FROM employees, jobs
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    GROUP BY department_id
);

--14. Write a query to display the department id and the total salary for those departments which contains at least one employee.

SELECT
  departments.department_id,
  SUM(employees.salary) AS total_salary
FROM departments
JOIN employees
ON departments.department_id = employees.department_id
GROUP BY departments.department_id;

--15. Write a SQL query to find the employees who earn less than the employee ofID 182. Return first name, last name and salary.

SELECT
  first_name,
  last_name,
  salary
FROM employees
WHERE salary < (
    SELECT salary
    FROM employees
    WHERE employee_id = 182
  );

--16. Write a SQL query to find the employees and their managers. Return the firstname of the employee and manager.

SELECT
  e.first_name AS employee_first_name,
  m.first_name AS manager_first_name
FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id;

--17. Write a SQL query to display the department name, city, and state province for each department.

SELECT
  departments.department_name,
  locations.city,
  locations.state_province
FROM departments
JOIN locations
ON departments.location_id = locations.location_id;

--18. Write a query to identify all the employees who earn more than the average and who work in any of the IT departments.


SELECT
  first_name,
  last_name,
  salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
  )
AND department_id IN (
    SELECT department_id
    FROM departments
    WHERE department_name LIKE '%IT%'
  );
  
--19. Write a SQL query to find out which employees have or do not have a department. Return first name, last name, department ID, department name.

SELECT
  e.first_name,
  e.last_name,
  e.department_id,
  d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;

--20. Write a SQL query to find the employees and their managers. Those managers do not work under any manager also appear in the list. Return the first name of the employee and manager.

SELECT
  e.first_name AS employee_first_name,
  m.first_name AS manager_first_name
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.employee_id
ORDER BY employee_first_name;

--21.  Write a query to display the name (first name and last name) for those employees who gets more salary than the employee whose ID is 163.

SELECT
  first_name,
  last_name
FROM employees
WHERE salary > (
    SELECT salary
    FROM employees
    WHERE employee_id = 163
  );

--22.  Write a query to display the name (first name and last name), salary, department id, job id for those employees who works in the same designation as the employee works whose id is 169.

SELECT
  first_name,
  last_name,
  salary,
  department_id,
  job_id
FROM employees
WHERE job_id = (
    SELECT job_id
    FROM employees
    WHERE employee_id = 169
  );

--23. Write a SQL query to find the employees who work in the same department as the employee with the last name Taylor. Return first name, last name and department ID.

SELECT
  e.first_name,
  e.last_name,
  e.department_id
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_name IN (
    SELECT department_name
    FROM employees
    WHERE last_name = 'Taylor'
  );
  
  
--24. Write a SQL query to find the department name and the full name (first and last name) of the manager.

SELECT
  d.department_name,
  e.first_name || ' ' || e.last_name AS manager_full_name
FROM departments d
JOIN employees e
ON d.manager_id = e.employee_id;

--25. Write a SQL query to find the employees who earn $12000 or more. Return employee ID, starting date, end date, job ID and department ID.

SELECT
  e.employee_id,
  e.hire_date,
  j.end_date,
  e.job_id,
  e.department_id
FROM employees E, job_history J
WHERE salary >= 12000;


--26. Write a query to display the name (first name and last name), salary, department id for those employees who earn such amount of salary which is the smallest salary of any of the departments.

SELECT
  e.first_name,
  e.last_name,
  e.salary,
  e.department_id
FROM employees e
JOIN (
  SELECT department_id, MIN(salary) AS min_salary
  FROM employees
  GROUP BY department_id
) d
ON e.department_id = d.department_id
AND e.salary = d.min_salary;

--27. Write a query to display all the information of an employee whose salary andreporting person id is 3000 and 121, respectively.

SELECT
  *
FROM employees
WHERE salary = 3000
AND manager_id = 121;

--28. Display the employee name (first name and last name), employee id, and job title for all employees whose department location is Toronto.

SELECT
  e.first_name,
  e.last_name,
  e.employee_id,
  j.job_title,
  l.state_province
  
FROM employees e, departments d, jobs j, locations l
WHERE l.state_province = 'Toronto';


--29. Write a query to display the employee name( first name and last name ) and department for all employees for any existence of those employees whose salary ismore than 3700.

SELECT
  e.first_name,
  e.last_name,
  d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE e.salary > 3700;


--30.  Write a query to determine who earns more than employee with the last name 'Russell'.

SELECT
  e.first_name,
  e.last_name,
  e.salary
FROM employees e
WHERE salary > (
    SELECT salary
    FROM employees
    WHERE last_name = 'Russell'
  );


--31. Write a query to display the names of employees who don't have a manager.

SELECT
  first_name,
  last_name
FROM employees
WHERE manager_id IS NULL;

--32. Write a query to display the names of the departments and the number of employees in each department.

SELECT
  d.department_name,
  COUNT(e.employee_id) AS number_of_employees
FROM departments d
JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name;


--33. Write a query to display the last name of employees and the city where they are located.

SELECT
  last_name,
  city
FROM employees , locations;


--34. Write a query to display the job titles and the average salary of employees for each job title.

SELECT
  j.job_title,
  AVG(e.salary) AS average_salary
FROM employees e
JOIN jobs j
ON e.job_id = j.job_id
GROUP BY j.job_title;


--35. Write a query to display the employee's name, department name, and the city of the department.


SELECT
  first_name,
  last_name,
  city,
  department_name
FROM employees , locations, departments;


--36. Write a query to display the names of employees who do not have a department assigned to them.

SELECT
  first_name,
  last_name
FROM employees
WHERE department_id IS NULL;

--37. Write a query to display the names of all departments and the number of employees in them, even if there are no employees in the department.

SELECT
  d.department_name,
  COUNT(e.employee_id) AS number_of_employees
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name;

--38. Write a query to display the names of employees and the department names, but only include employees whose salary is above 10,000.

SELECT
  e.first_name,
  e.last_name,
  d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE e.salary > 10000;

--39. Write a query to display department names and the average salary within each department, but only for departments with an average salary above 7000.

SELECT
  d.department_name,
  AVG(e.salary) AS average_salary
FROM departments d
JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING AVG(e.salary) > 7000;

--40. Write a query to display the names of employees who work in the 'IT' department.

SELECT
  first_name,
  last_name
FROM employees
WHERE department_id = (
    SELECT department_id
    FROM departments
    WHERE department_name = 'IT'
  );

--41. Write a query which is looking for the names of all employees whose salary isgreater than 50% of their department’s total salary bill.

SELECT
  e.first_name,
  e.last_name,
  d.department_name,
  e.salary,
  (
    SELECT SUM(salary)
    FROM employees
    WHERE department_id = e.department_id
  ) AS total_salary
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE e.salary > 0.5 * total_salary;


--42. Write a query to get the details of employees who are managers.

SELECT
  e.first_name,
  e.last_name,
  j.job_title,
  e.manager_id
FROM employees e, jobs j
WHERE manager_id IS NOT NULL;

--43.  Write a query in SQL to display the department code and name for all departments which located in the city London.

SELECT
  d.department_id,
  d.department_name
FROM departments d
JOIN locations l
ON d.location_id = l.location_id
WHERE l.city = 'London';


--44. Write a query in SQL to display the first and last name, salary, and department ID for all those employees who earn more than the average salary andarrange the list in descending order on salary.

SELECT
  e.first_name,
  e.last_name,
  e.salary,
  e.department_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
  )
ORDER BY e.salary DESC;


--45. Write a query in SQL to display the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.

SELECT
  e.first_name,
  e.last_name,
  e.salary,
  e.department_id
FROM employees e
WHERE e.salary > (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = 40
  );


--46. Write a query in SQL to display the department name and Id for all departments where they located, that Id is equal to the Id for the location where department number 30 is located.

SELECT
  d.department_name,
  d.department_id
FROM departments d
JOIN locations l
ON d.location_id = l.location_id
WHERE l.location_id = (
    SELECT location_id
    FROM departments
    WHERE department_id = 30
  );

--48. Write a query to display the department names and the location cities. Only include departments that are located in a country with the country_id 'US'.

SELECT
  d.department_name,
  d.manager_id,
  d.location_id
FROM departments d
WHERE manager_id IN (
    SELECT employee_id
    FROM employees
    WHERE first_name = 'Susan'
  );


--49. Write a query to display the first name and last name of employees along with the name of the department they work in. Only include employees whose last name starts with the letter 'S'.

SELECT
  e.first_name,
  e.last_name,
  d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE e.last_name LIKE 'S%';


--50. Write a query to display the department names and the number of employees in each department. Only include departments with more than 2 employees, and order the result by the number of employees in descending order.            

SELECT
  d.department_name,
  COUNT(e.employee_id) AS number_of_employees
FROM departments d
JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 2
ORDER BY number_of_employees DESC;