-- create database 

create database Hospital_DB;
use Hospital_DB;
create table Patients(
Patient_id int,
PatientName varchar(50),
Age int,
Gender varchar(20),
Admissiondate date
); 
-- alter,modify existing table

alter table Patients
add Doctorassigned varchar(50);
alter table patients
modify patientname varchar(100);

-- rename existing table
rename table Patients to Patient_info ;

-- Truncate
TRUNCATE TABLE Patient_Info;

-- Drop the table
DROP TABLE Patient_Info;
