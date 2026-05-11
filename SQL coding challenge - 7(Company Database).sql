Use  SQL_COMPANY_DB;
-- SIMPLE VIEW : EmployeeBasicView
CREATE VIEW EmployeeBasicView AS
SELECT emp_name, dept_id, salary
FROM Employees;

SELECT * FROM EmployeeBasicView;

-- COMPLEX VIEW : EmployeeDepartmentView
CREATE VIEW EmployeeDepartmentView AS
SELECT e.emp_name, d.dept_name, e.city AS Location, e.salary
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id;

SELECT * FROM EmployeeDepartmentView;

-- COMPLEX VIEW with Aggregation
CREATE VIEW DeptSalaryStats AS
SELECT d.dept_name, AVG(e.salary) AS AvgSalary, COUNT(e.emp_id) AS TotalEmployees
FROM Departments d
LEFT JOIN Employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

SELECT * FROM DeptSalaryStats;

-- UPDATE Using VIEW
SET SQL_SAFE_UPDATES = 0;

UPDATE EmployeeBasicView 
SET salary = salary + 5000;

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM Employees;

-- DROP VIEW
DROP VIEW DeptSalaryStats;

-- TRIGGER (BEFORE INSERT)
DELIMITER //
CREATE TRIGGER check_min_salary
BEFORE INSERT ON Employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 30000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary must be at least 30000';
    END IF;
END //
DELIMITER ;

-- TRIGGER (AFTER INSERT – Audit Log)
CREATE TABLE EmployeeAudit (
    EmpID INT, 
    EmpName VARCHAR(50), 
    Action VARCHAR(50), 
    ActionDate DATETIME
);

DELIMITER //
CREATE TRIGGER log_employee_insert
AFTER INSERT ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeAudit(EmpID, EmpName, Action, ActionDate)
    VALUES (NEW.emp_id, NEW.emp_name, 'INSERTED', NOW());
END //
DELIMITER ;
-- TRIGGER (AFTER UPDATE – Salary Log)
CREATE TABLE SalaryLog (
    EmpID INT, 
    OldSalary DECIMAL(10,2), 
    NewSalary DECIMAL(10,2), 
    ChangeDate DATETIME
);

DELIMITER //
CREATE TRIGGER log_salary_change
AFTER UPDATE ON Employees
FOR EACH ROW
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO SalaryLog(EmpID, OldSalary, NewSalary, ChangeDate)
        VALUES (OLD.emp_id, OLD.salary, NEW.salary, NOW());
    END IF;
END //
DELIMITER ;

-- TRIGGER (BEFORE DELETE – Block Action)

DELIMITER //
CREATE TRIGGER prevent_it_delete
BEFORE DELETE ON Employees
FOR EACH ROW
BEGIN
    -- Assumed DeptID 2 is IT
    IF OLD.dept_id = 2 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete employees from IT department';
    END IF;
END //
DELIMITER ;

-- TRIGGER (AFTER DELETE – Archive Record)
CREATE TABLE EmployeeArchive (
    EmpID INT, 
    EmpName VARCHAR(50), 
    DeptID INT, 
    Salary DECIMAL(10,2), 
    ExitDate DATETIME
);

DELIMITER //
CREATE TRIGGER archive_deleted_employee
AFTER DELETE ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeArchive(EmpID, EmpName, DeptID, Salary, ExitDate)
    VALUES (OLD.emp_id, OLD.emp_name, OLD.dept_id, OLD.salary, NOW());
END //
DELIMITER ;
