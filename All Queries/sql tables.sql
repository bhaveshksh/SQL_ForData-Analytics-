CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, HireDate) VALUES
(1, 'Neha', 'Gupta', 101, '2023-01-15'),
(2, 'Anita', 'Sharma', 102, '2022-05-20'),
(3, 'Rahul', 'Verma', 103, '2021-11-10'),
(4, 'Priya', 'Singh', 101, '2023-07-01'),
(5, 'Amit', 'Kumar', 104, '2020-09-25');

SELECT * FROM Employees;
------------------------------------------------------------------------------------------------
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    ManagerID INT
);

INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID) VALUES
(101, 'Finance', 1),
(102, 'HR', 2),
(103, 'IT', 3),
(104, 'Sales', 4),
(105, 'Marketing', 5);

SELECT * FROM Departments;
------------------------------------------------------------------------------------------
CREATE TABLE Salaries (
    EmployeeID INT PRIMARY KEY,
    BaseSalary DECIMAL(10,2),
    Bonus DECIMAL(10,2)
);

INSERT INTO Salaries (EmployeeID, BaseSalary, Bonus) VALUES
(1, 50000, 5000),
(2, 45000, 4000),
(3, 60000, 6000),
(4, 55000, 4500),
(5, 48000, 3500);

SELECT * FROM Salaries;
------------------------------------------------------------------------------------------
CREATE TABLE Jobs (
    JobID INT PRIMARY KEY,
    JobTitle VARCHAR(50),
    MinSalary DECIMAL(10,2),
    MaxSalary DECIMAL(10,2)
);

INSERT INTO Jobs (JobID, JobTitle, MinSalary, MaxSalary) VALUES
(201, 'Accountant', 40000, 60000),
(202, 'HR Manager', 45000, 65000),
(203, 'Software Engineer', 50000, 80000),
(204, 'Sales Executive', 35000, 55000),
(205, 'Marketing Specialist', 40000, 60000);

SELECT * FROM Jobs;
------------------------------------------------------------------------------------------------
----select all employees in department 101
SELECT * FROM Employees;
SELECT * FROM Departments;

SELECT e.departmentid,e.firstname, d.departmentid
FROM Employees as e
Join Departments as d ON e.departmentid = d.departmentid
Where e.departmentid = 101;
------------------------------------------------------------------------------------------------
------select all employees who are hired after 2022-01-01
SELECT * FROM Employees;

SELECT * FROM Employees
where hiredate>'2022-01-01';
-----------------------------------------------------------------------------------------------
------select employees who are hired date is between 2022-01-01 and 2023-01-01
SELECT * FROM Employees;

SELECT * FROM Employees
WHERE hiredate BETWEEN '2022-01-01' and '2023-01-01';
----------------------------------------------------------------------------------------------
----select employees whose first name contains 'i' or last anme contain 'm'
SELECT * FROM Employees;

SELECT * FROM Employees
WHERE firstname like 'i%' or lastname like '%m';
---------------------------------------------------------------------------------------------
-----show department with more than 1 employees
SELECT * FROM Employees;
SELECT * FROM departments;

SELECT d.departmentname FROM departments as d
JOIN Employees as e On e.departmentid = d.departmentid
GROUP BY d.departmentid,d.departmentname
HAVING COUNT(e.departmentid) > 1;
-----------------------------------------------------------------------------------------
-----show distict department named from department table
SELECT * FROM Departments;

SELECT DISTINCT(departmentname) FROM Departments;
------------------------------------------------------------------------------------------
------select employees who are not in department 102
SELECT * FROM Employees;
SELECT * FROM Departments;

SELECT * FROM Employees
WHERE departmentid != 102;
-------------------------------------------------------------------------------------------
------select employees with salary not equal to 48000
SELECT * FROM Employees;
SELECT * FROM Salaries;

SELECT e.firstname,s.basesalary FROM Employees as e
JOIN Salaries as s ON e.employeeid = s.employeeid
WHERE s.basesalary <> 48000;
---------------------------------------------------------------------------------------
-----------JOINS
------select employees whose salary is greater than 50000
SELECT * FROM Employees;
SELECT * FROM Salaries;

SELECT e.firstname, s.basesalary
FROM employees as e
JOIN Salaries as s ON e.employeeid = s.employeeid
WHERE s.basesalary > 50000;
-------------------------------------------------------------------------------------
-----select employees whose salary is between 45000 and 55000
SELECT * FROM Employees;
SELECT * FROM Salaries;

SELECT e.firstname, s.basesalary
FROM Employees as e
INNER JOIN salaries as s 
ON e.employeeid = s.employeeid
WHERE s.basesalary BETWEEN 45000 AND 55000;
----------------------------------------------------------------------------------------
-----select employees whose department is not in finance
SELECT * FROM Employees;
SELECT * FROM Departments;

SELECT e.firstname, d.departmentname
FROM Employees as e 
JOIN Departments as d
ON e.departmentid = d.departmentid
WHERE d.departmentname != 'Finance' ;
----------------------------------------------------------------------------------------
------select employees in hr department
SELECT * FROM Employees;
SELECT * FROM Departments;

SELECT e.firstname, d.departmentname
FROM Employees as e
INNER JOIN Departments as d
ON e.departmentid = d.departmentid
WHERE d.departmentname = 'Finance';
--------------------------------------------------------------------------------------
-----select employees in sales or marketing department
SELECT * FROM Employees;
SELECT * FROM Departments;

SELECT e.firstname, d.departmentname
FROM Employees as e
JOIN Departments as d
ON e.departmentid = d.departmentid
WHERE d.departmentname = 'Sales' OR d.departmentname = 'Marketing';
-----------------------------------------------------------------------------------
----select employees who are in finance department or salary > 55000
SELECT * FROM Employees;
SELECT * FROM Departments;
SELECT * FROM Salaries;

SELECT e.firstname, d.departmentname, s.basesalary
FROM Employees as e
JOIN Departments as d
ON e.departmentid = d.departmentid
JOIN Salaries as s ON s.employeeid = e.employeeid
WHERE d.departmentname = 'Finance' OR s.basesalary > 55000 ;
-------------------------------------------------------------------------------------
-----select employees whose first_name starts with "A" and salary > 45000
SELECT * FROM Employees;
SELECT * FROM Salaries;

SELECT e.firstname, s.basesalary
FROM Employees as e
JOIN salaries as s
ON e.employeeid = s.employeeid
WHERE e.firstname like 'A%' and s.basesalary > 45000;
-------------------------------------------------------------------------------------
----select employees whose salary is between 45000 and 60000 and bonus >=4000.
SELECT * FROM Employees;
SELECT * FROM Salaries;

SELECT e.firstname, e.lastname, s.basesalary, s.bonus
FROM Employees as e
JOIN Salaries as s
ON e.employeeid = s.employeeid
WHERE s.basesalary BETWEEN 45000 AND 60000 AND s.bonus >= 4000;
------------------------------------------------------------------------------------
------show total salary of each department
SELECT * FROM Employees;
SELECT * FROM Departments;
SELECT * FROM Salaries;

SELECT d.departmentname,
sum(s.basesalary + s.bonus) as Total_salary
FROM Departments as d
JOIN Employees as e ON e.departmentid = d.departmentid
JOIN Salaries as s ON e.employeeid = s.employeeid
GROUP BY d.departmentname;
---------------------------------------------------------------------------------------
------show the average salary of employees in each department
SELECT * FROM Employees;
SELECT * FROM Departments;
SELECT * FROM Salaries;

SELECT d.departmentname, round(avg(s.basesalary + s.bonus),0) as Avg_salaries
FROM Employees as e
JOIN Departments as d on e.departmentid = d.departmentid
JOIN salaries as s ON e.employeeid = s.employeeid
GROUP BY d.departmentname;
