CREATE DATABASE CompanyDB;
GO;

USE CompanyDB;
GO;

CREATE SCHEMA Sales;
GO;
CREATE TABLE Sales.Employees (
    employee_id INT DEFAULT NEXT VALUE FOR employee_seq PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
	salary DECIMAL(10, 2),
	hire_date DATE
);

CREATE SEQUENCE employee_seq START WITH 1 INCREMENT BY 1;
ALTER TABLE Sales.Employees ADD hire_date DATE;
INSERT INTO Sales.Employees ( first_name, last_name, salary)
VALUES ('John', 'Smith', 30000),
       ('Anna', 'Brown', 50000),
       ('Alan', 'Green', 40000)

-- 1
SELECT * FROM Sales.Employees;

-- 2
SELECT first_name, last_name FROM Sales.Employees;

-- 3
SELECT first_name + ' ' + last_name AS full_name FROM Sales.Employees;

-- 4
SELECT AVG(salary)  FROM Sales.Employees;

-- 5
SELECT * FROM Sales.Employees
WHERE salary > 50000;

-- 6
SELECT * FROM Sales.Employees
WHERE (hire_date) = 2020;

--7
SELECT * FROM Sales.Employees
WHERE last_name LIKE 'S%';

--8
SELECT TOP 10 * FROM Sales.Employees;

--9
SELECT * FROM Sales.Employees
WHERE salary BETWEEN 40000 AND 60000;

--10
SELECT * FROM Sales.Employees
WHERE first_name LIKE '%man%' OR last_name LIKE '%man%';

--11
SELECT * FROM Sales.Employees
WHERE hire_date IS NULL;

--12 
SELECT * FROM Sales.Employees
WHERE salary IN (40000, 45000, 50000);

--13 
SELECT * FROM Sales.Employees
WHERE hire_date BETWEEN '2020-01-01' AND '2021-01-01';

--14
SELECT * FROM Sales.Employees
ORDER BY salary DESC;

--15
SELECT TOP 5 * FROM Sales.Employees
ORDER BY last_name ;

--16
SELECT * FROM Sales.Employees
WHERE salary > 55000 AND (hire_date) = 2020;

--17
SELECT * FROM Sales.Employees
WHERE first_name IN ('John', 'jane');

--18
SELECT* FROM Sales.Employees
WHERE hire_date > '2022-01-01' AND salary <= 55000;

--19 
SELECT * FROM Sales.Employees
WHERE salary > (SELECT AVG(salary) FROM Sales.Employees);

--20
SELECT * FROM Sales.Employees
ORDER BY salary DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;

--21
SELECT * FROM Sales.Employees
WHERE hire_date > '2021-01-01'
ORDER BY first_name ;

--22
SELECT * FROM Sales.Employees
WHERE salary > 50000 AND last_name NOT LIKE 'A%';

--23
SELECT * FROM Sales.Employees
WHERE salary IS NOT NULL;

--24
SELECT * FROM Sales.Employees
WHERE (first_name LIKE '%i%' OR last_name LIKE '%i%') OR (first_name LIKE '%e%' OR last_name LIKE '%e%')
  AND salary > 45000;

--25
 
CREATE TABLE Sales.departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
);
CREATE TABLE Sales.managers (
    manager_id INT PRIMARY KEY,
    employee_id INT,
    department_id INT,
    FOREIGN KEY (employee_id) REFERENCES Sales.Employees(employee_id),
    FOREIGN KEY (department_id) REFERENCES Sales.departments(department_id)
);


--26

SELECT first_name, last_name, department_name
FROM Sales.Employees e
JOIN Sales.managers m ON e.employee_id = m.employee_id
JOIN Sales.departments d ON m.department_id = d.department_id;

--27

SELECT e.employee_id,first_name, last_name, department_name
FROM Sales.Employees e
 JOIN Sales.managers m ON e.employee_id = m.employee_id
JOIN Sales.departments d ON m.department_id = d.department_id


--28

SELECT  e.employee_id, first_name, last_name, department_name
FROM Sales.employees e
LEFT JOIN Sales.managers m ON e.employee_id = m.employee_id
LEFT JOIN Sales.departments d ON m.department_id = d.department_id


--29
 SELECT department_name, COUNT(e.employee_id) 
FROM Sales.departments d
JOIN Sales.managers m ON d.department_id = m.department_id
JOIN Sales.Employees e ON m.employee_id = e.employee_id
GROUP BY d.department_name;

--30
SELECT d.department_id, MAX(e.salary) AS highest_salary
FROM Sales.departments d
JOIN Sales.managers m ON d.department_id = m.department_id
JOIN Sales.Employees e ON m.employee_id = e.employee_id;
