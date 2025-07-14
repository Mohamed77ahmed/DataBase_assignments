use RouteCompany
create table Department
( DeptNo varchar(10) primary key ,
DeptName varchar(30) ,
 Location_ varchar(30)
)

insert into Department values ('d1','Research','NY')
insert into Department values ('d2','Accounting','DS')
insert into Department values ('d3','marketing','KW')

insert into [HR].[Employee](EmpNo,EmpFname,EmpLname,DeptNo,Salary)
values('29346','James','James','d2','2800')



create table Employee
( EmpNo  int primary key ,
EmpFname varchar(30) ,
 EmpLname varchar(30),
 Salary DECIMAL(10, 2) UNIQUE, 
 DeptNo varchar(10) references Department(DeptNo)
)


insert into Employee (EmpNo,EmpFname,EmpLname,DeptNo,Salary)
values
      ('25348','Mathew','Smith','d3','2500'),
	   ('10102','Ann','Jones','d3','3000'),
	    ('18316','John','Barrymore','d1','2400'),
		
--Create the following schema and transfer the following tables to it 
--Company Schema 
--Department table 
 

go
create schema company
go

alter schema company
transfer [dbo].[Department]


--Project table
alter schema company
transfer [dbo].[Project]





--Human Resource Schema
  --Employee table

go
create schema HR
go

alter schema HR
transfer [dbo].[Employee]





--Increase the budget of the project where the manager number is 10102 by 10%.

update [company].[Project]
set budget =budget*1.1
where ProjectNo in (select ProjectNo
                    from [dbo].[Works_on]
					where EmpNo=10102
					)




---Change the name of the department for which the employee named James works.The new department name is Sales.
update [company].[Department]
set DeptName='sales'
where DeptNo=
(select em.DeptNo
from[HR].[Employee] em
where em.EmpFname='james')






--Change the enter date for the projects for those employees who work in project p1 and belong to department ‘Sales’. The new date is 12.12.2007

update [dbo].[Works_on] 
set Enter_Date='12.12.2007'
where ProjectNo= (select pro.ProjectNo 
from  [company].[Project] pro ,[company].[Department] dep
where pro.ProjectNo='p1' and dep.DeptName ='sales'
           )






---Delete the information in the works_on table for all employees who work for the department located in KW.


delete from [dbo].[Works_on]
where EmpNo in (select emp.EmpNo
from[company].[Department] dep,[HR].[Employee] emp
where dep.DeptNo=emp.DeptNo and dep.Location_='kw')





--Create a stored procedure to show the number of students per department.[use ITI DB] 


use ITI

Go
create or alter proc SP_shownumofstudents @depNo int
with encryption
as
select count(*) 'NumOfStudent'
from Student st,Department dep
where st.Dept_Id =dep.Dept_Id
group by dep.Dept_Id
having dep.Dept_Id=@depNo
Go

exec SP_shownumofstudents 70





/*Create a stored procedure that will check for the Number of employees 
in the project 100 if they are more than 3 print message to the user
“'The number of employees in the project 100 is 3 or more'” if they are less
display a message to the user “'The following employees work for 
the project 100'” in addition to the first name and last name of each one.
[MyCompany DB] 
*/


use MyCompany

GO
create or alter proc SP_checkEmployees
as
declare @resalt int
select  @resalt= count(*) 
from Works_for ws
where ws.Pno=100

if @resalt >=3
begin
print 'The number of employees in the project 100 is 3 or more'
end
else
begin 
PRINT 'The following employees work for the project 100'


select emp.Fname,emp.Lname
from Employee emp,Works_for ws
where emp.SSN=ws.ESSn and ws.Pno=100
 end
GO


exec SP_checkEmployees







/*Create a stored procedure that will be used in case an old employee has
left the project and a new one becomes his replacement. The procedure 
should take 3 parameters (old Emp. number, new Emp. number and the project number)
and it will be used to update works_on table. 
[MyCompany DB]
*/