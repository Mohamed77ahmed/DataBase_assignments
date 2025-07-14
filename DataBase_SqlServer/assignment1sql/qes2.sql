CREATE DATABASE qes2

USE qes2

CREATE TABLE Consultant (
Id int primary key identity(1,1),
Cname varchar(50)
)

CREATE TABLE Ward (
Id int primary key identity(1,1),
Wname varchar(50),
Nurse_Num int
)

CREATE TABLE Nurse (
Number int primary key,
N_Name varchar(50),
N_Address varchar(100),
Ward_Id int references Ward(Id)
)

CREATE TABLE Patient (
Id int primary key identity(1,1),
Pname varchar(50),
DOB date,
Ward_Id int references Ward(Id),
Con_Id int references Consultant(Id)
)

CREATE TABLE Patient_Con (
Con_Id int references Consultant(Id),
Pat_Id int references Patient(Id)
)

CREATE TABLE Drugs (
Code int primary key,
Ddosage varchar(50)
)

CREATE TABLE Drug_Brand (
Code int references Drugs(Code),
Brand varchar(50)
)

CREATE TABLE Nurse_Drug_Patient (
Nur_Num int references Nurse(Number),
Druf_cod int references Drugs(Code),
Pat_Id int references Patient(Id),
Adm_Date date,
Adm_Time time,
Adm_Dosage varchar(50)
)
