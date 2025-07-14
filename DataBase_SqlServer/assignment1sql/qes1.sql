CREATE DATABASE qes1

use qes1

Create Table Aircraft
(Id int primary key identity(1,1),
Capacity int not null,
Model varchar(20) ,
Maj_pilot int ,
Assistant varchar(20),
Host1 varchar(20),
Host2 varchar(20),
Al_id int  references Airline(Id),
)
 
Create Table Airline
(
Id int primary key identity(1,1),
Nname varchar(20) not null,
Adddress varchar(50),
Cont_person varchar(20),

)
 Create Table Airline_phones(
 AL_id int references Airline(Id),
 Phones varchar(20) not null,
 )

 Create Table Transactions
 (
 Id int primary key identity(1,1),
 Deescription varchar(100),
 Amount float ,
 T_Date date ,
 Al_id int references Airline(Id),

 )
 Create Table Employee(
Id int primary key identity(1,1),
E_NAme varchar(20) not null,
E_Address varchar(50) ,
Gender varchar(6),
Position varchar(20),
DB_year int ,
DB_month int,
DB_day int,
Al_id int references Airline(Id),
)


Create Table Emp_Qualifications(
e_id int references Employee(Id),
Qualifications varchar(50),
)

Create Table Rooute (
Id int primary key identity(1,1),
Distance int ,
Destination varchar(50),
origin varchar(50),
Cllassification varchar(50),

)

Create Table Aircraft_Routes
(
AC_id int references EMPLoyee(Id),
ro_id int references Aircraft(Id),
Departure date,
Num_Of_Pass int,
Price float,
Arrival datetime,

)



