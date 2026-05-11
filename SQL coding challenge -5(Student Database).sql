-- 1CREATE DATABASE

CREATE DATABASE StudentsDB;
USE StudentsDB;

-- CREATE TABLES

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    Age INT,
    City VARCHAR(50)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50),
    Duration VARCHAR(20)
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);


-- INSERT SAMPLE DATA

INSERT INTO Students VALUES
(1, 'Aarav', 21, 'Chennai'),
(2, 'Meera', 22, 'Bangalore'),
(3, 'Karthik', 23, 'Hyderabad'),
(4, 'Divya', 21, 'Delhi');

INSERT INTO Courses VALUES
(101, 'Data Analytics', '3 Months'),
(102, 'Python Programming', '2 Months'),
(103, 'SQL Basics', '1 Month');

INSERT INTO Enrollments VALUES
(1001, 1, 101, '2025-05-10'),
(1002, 2, 102, '2025-06-01'),
(1003, 3, 103, '2025-06-15');

-- INNER JOIN
SELECT s.StudentName, c.CourseName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID;

-- LEFT JOIN and RIGHT JOIN
SELECT s.StudentName, e.CourseID
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID;

-- RIGHT JOIN
SELECT s.StudentName, e.CourseID
FROM Students s
RIGHT JOIN Enrollments e ON s.StudentID = e.StudentID;

-- ROUND()
SELECT ROUND(123.4567, 2) AS Rounded_Value;

-- ABS() & MOD()
SELECT ABS(-50) AS Absolute_Value, MOD(25, 4) AS Remainder;

-- CONCAT()
SELECT CONCAT(StudentName, ' from ', City) AS Full_Description 
FROM Students;

-- LENGTH()
SELECT StudentName, LENGTH(StudentName) AS Name_Length 
FROM Students;

-- REPLACE()
SELECT CourseName, REPLACE(CourseName, 'SQL', 'Database') AS Updated_CourseName 
FROM Courses;

-- SUBSTRING()
SELECT StudentName, SUBSTRING(StudentName, 1, 3) AS Code_Prefix 
FROM Students;
-- UPPER() & LOWER()
SELECT StudentName, UPPER(StudentName) AS UPPER_Name, LOWER(StudentName) AS LOWER_Name 
FROM Students;

-- DATE FUNCTIONS
SELECT 
    s.StudentName, 
    e.EnrollmentDate, 
    DATE_ADD(e.EnrollmentDate, INTERVAL 10 DAY) AS FollowUp_Date,
    DATEDIFF('2025-06-01', '2025-05-10') AS Days_Difference,
    NOW() AS Current_DateTime
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID;