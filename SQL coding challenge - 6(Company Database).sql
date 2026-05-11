-- DATABASE CREATION
-- Tables:
-- Departments, Employees, Customers,
-- Products, Orders, Sales, MonthlySales, SalesTeam


CREATE DATABASE SQL_COMPANY_DB;
USE SQL_COMPANY_DB;


-- 1. DEPARTMENTS

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

INSERT INTO Departments VALUES
(1,'HR'),
(2,'IT'),
(3,'Finance'),
(4,'Sales'),
(5,'Marketing');


-- 2. EMPLOYEES

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2),
    city VARCHAR(50)
);

INSERT INTO Employees VALUES
(101,'Arun',2,55000,'Chennai'),
(102,'Bala',2,60000,'Madurai'),
(103,'Anitha',1,45000,'Trichy'),
(104,'David',3,NULL,'Coimbatore'),
(105,'Asha',4,70000,'Madurai'),
(106,'John',NULL,50000,'Salem'),
(107,'Kavin',4,80000,'Chennai'),
(108,'Meena',5,65000,'Madurai'),
(109,'Priya',2,60000,'Trichy'),
(110,'Ravi',4,80000,'Madurai');


-- 3. CUSTOMERS
-- Includes duplicates

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO Customers VALUES
(1,'Raj','raj@gmail.com','Madurai'),
(2,'Kumar','kumar@gmail.com','Chennai'),
(3,'Divya','divya@gmail.com','Madurai'),
(4,'Raj','raj@gmail.com','Madurai'),
(5,'Sneha','sneha@gmail.com','Trichy'),
(6,'Vijay','vijay@gmail.com','Chennai'),
(7,'Rani','rani@gmail.com','Madurai'),
(8,'Arun','arun@gmail.com','Salem');

-- 4. PRODUCTS

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO Products VALUES
(201,'Laptop','Electronics',55000),
(202,'Mobile','Electronics',25000),
(203,'Shoes','Fashion',3000),
(204,'Watch','Accessories',5000),
(205,'Tablet','Electronics',35000);

-- 5. ORDERS

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT
);

INSERT INTO Orders VALUES
(1001,1,201,'2025-01-10',1),
(1002,2,202,'2025-01-15',2),
(1003,1,203,'2025-02-05',3),
(1004,3,204,'2025-02-12',1),
(1005,4,202,'2025-03-01',1),
(1006,5,201,'2025-03-10',1),
(1007,1,205,'2025-04-05',1),
(1008,6,202,'2025-04-15',2),
(1009,1,204,'2025-05-01',1),
(1010,7,203,'2025-05-12',2),
(1011,1,202,'2025-06-01',1),
(1012,1,203,'2025-06-15',1);


-- 6. SALES

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    order_date DATE,
    product_id INT,
    amount DECIMAL(10,2)
);

INSERT INTO Sales VALUES
(1,'2025-01-10',201,55000),
(2,'2025-01-15',202,50000),
(3,'2025-02-05',203,9000),
(4,'2025-02-12',204,5000),
(5,'2025-03-01',202,25000),
(6,'2025-03-10',201,55000),
(7,'2025-04-05',205,35000),
(8,'2025-04-15',202,50000),
(9,'2025-05-01',204,5000),
(10,'2025-05-12',203,6000),
(11,'2025-06-01',202,25000),
(12,'2025-06-15',203,3000);


-- 7. MONTHLY SALES

CREATE TABLE MonthlySales (
    month VARCHAR(20),
    sales DECIMAL(10,2)
);

INSERT INTO MonthlySales VALUES
('Jan',105000),
('Feb',14000),
('Mar',80000),
('Apr',85000),
('May',11000),
('Jun',28000);


-- 8. SALES TEAM

CREATE TABLE SalesTeam (
    emp_name VARCHAR(50),
    region VARCHAR(50),
    sales DECIMAL(10,2)
);

INSERT INTO SalesTeam VALUES
('Arun','South',80000),
('Bala','South',90000),
('Divya','North',70000),
('John','North',95000),
('Meena','East',60000),
('Priya','East',75000),
('Ravi','West',85000),
('Kavin','West',92000);

-- Employees with salary > average salary:
SELECT * FROM Employees 
WHERE salary > (SELECT AVG(salary) FROM Employees);

-- Employees who earn more than Ravi:
SELECT * FROM Employees 
WHERE salary > (SELECT salary FROM Employees WHERE emp_name = 'Ravi');

-- Employees who joined after Meena:
SELECT * FROM Employees 
WHERE emp_id > (SELECT emp_id FROM Employees WHERE emp_name = 'Meena');

-- Salary > average salary of the IT department:
SELECT * FROM Employees 
WHERE salary > (SELECT AVG(salary) FROM Employees WHERE dept_id = 2);

ALTER TABLE Employees ADD COLUMN rating INT;
UPDATE Employees SET rating = 4 WHERE emp_id IN (101, 102, 103);
UPDATE Employees SET rating = 5 WHERE emp_id IN (105, 107, 110);
UPDATE Employees SET rating = 3 WHERE emp_id IN (106, 108, 109);

-- Performance rating > average:
SELECT * FROM Employees 
WHERE rating> (SELECT AVG(rating) FROM Employees);

-- Multi-Row Subqueries
-- Employees in departments located in Chennai or Bangalore:
SELECT * FROM Employees 
WHERE city IN ('Chennai', 'Bangalore');

-- Employees in Pune:
SELECT * FROM Employees 
WHERE city = 'Pune';

-- Salary > ANY employee in Marketing:
SELECT * FROM Employees 
WHERE salary > ANY (SELECT salary FROM Employees WHERE dept_id = 5);

-- Salary > ALL employees in HR:
SELECT * FROM Employees 
WHERE salary > ALL (SELECT salary FROM Employees WHERE dept_id = 1);

-- Departments with rating = 5 employees:
SELECT * FROM Employees 
WHERE dept_id IN (SELECT dept_id FROM Employees WHERE rating = 5);

-- Correlated Subqueries
-- Salary > average of their own department:
SELECT * FROM Employees e1 
WHERE salary > (SELECT AVG(salary) FROM Employees e2 WHERE e1.dept_id = e2.dept_id);

-- Highest salary in their department:
SELECT * FROM Employees e1 
WHERE salary = (SELECT MAX(salary) FROM Employees e2 WHERE e1.dept_id = e2.dept_id);

-- Rating > department average:
SELECT * FROM Employees e1 
WHERE rating > (SELECT AVG(rating) FROM Employees e2 WHERE e1.dept_id = e2.dept_id);

-- Joined after department average date:
SELECT * FROM Employees e1 
WHERE emp_id > (SELECT AVG(emp_id) FROM Employees e2 WHERE e1.dept_id = e2.dept_id);

-- Salary < maximum in their department:
SELECT * FROM Employees e1 
WHERE salary < (SELECT MAX(salary) FROM Employees e2 WHERE e1.dept_id = e2.dept_id);

-- Salary = minimum in their department:
SELECT * FROM Employees e1 
WHERE salary = (SELECT MIN(salary) FROM Employees e2 WHERE e1.dept_id = e2.dept_id);

-- Departments with employees earning > 70000:
 SELECT dept_name FROM Departments d 
WHERE EXISTS (SELECT 1 FROM Employees e WHERE e.dept_id = d.dept_id AND e.salary > 70000);

-- Salary > at least one employee in their department:
SELECT * FROM Employees e1 
WHERE salary > (SELECT MIN(salary) FROM Employees e2 WHERE e1.dept_id = e2.dept_id);

-- Only employee in their department:
SELECT * FROM Employees e1 
WHERE (SELECT COUNT(*) FROM Employees e2 WHERE e1.dept_id = e2.dept_id) = 1;

-- Salary > average of those who joined after them:
SELECT * FROM Employees e1 
WHERE salary > (SELECT AVG(salary) FROM Employees e2 WHERE e2.emp_id > e1.emp_id);