CREATE DATABASE qess3

USE qess3

CREATE TABLE Topics (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50)
);

CREATE TABLE Courses (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50),
    Duration INT,
    Description VARCHAR(100),
    top_Id INT REFERENCES Topics(Id)
);

CREATE TABLE Departments (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50),
    Hiring_Date DATE,
    Ins_Id INT
);

CREATE TABLE Instructors (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50),
    Address VARCHAR(100),
    Bouns FLOAT,
    Salary FLOAT,
    Hour_Rate FLOAT,
    Dep_Id INT REFERENCES Departments(Id)
);

CREATE TABLE Students (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FName VARCHAR(50),
    LName VARCHAR(50),
    Age INT,
    Address VARCHAR(100),
    Dep_Id INT REFERENCES Departments(Id)
);

CREATE TABLE Stud_Course (
    Stud_Id INT REFERENCES Students(Id),
    Course_Id INT REFERENCES Courses(Id),
    Grade FLOAT
);

CREATE TABLE Course_Instructor (
    Course_Id INT REFERENCES Courses(Id),
    Inst_Id INT REFERENCES Instructors(Id),
    Evaluation FLOAT
);
