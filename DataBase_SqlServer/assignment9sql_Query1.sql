/*Create a trigger to prevent anyone from inserting a new record in the Department table 
( Display a message for user to tell him that he can’t insert a new record in that table )*/
GO
create or alter trigger DisableDepartment
on department
instead of insert
as
select ' you can’t insert a new record in that table'
GO

insert into Department (Dept_Id,Dept_Name) values (1000,'Bi')

---Create a table named “StudentAudit”. Its Columns are (Server User Name , Date, Note) 
create table StudentAudit
(
Server_User_Name varchar(20),
DDate Date,
Note varchar(50)
)




/*Create a trigger on student table after insert to add Row in StudentAudit table 
 The Name of User Has Inserted the New Student  
Date
Note that will be like ([username] Insert New Row with Key = [Student Id] in table [table name]
*/
GO
create or alter trigger T_StudentAudit
on StudentAudit
after insert 
as
select CONCAT_WS(' ','The Name of User Has Inserted the New Student :',(select Server_User_Name from inserted),'Date :',(select DDate from inserted),'Note',(select Note from inserted))

GO
INSERT INTO StudentAudit (Server_User_Name, DDate, Note)
VALUES ('admin_user', '2025-06-20', 'Routine maintenance completed.')



/*Create a trigger on student table instead of delete to add Row in StudentAudit table 
 The Name of User Has Inserted the New Student
Date
Note that will be like “try to delete Row with id = [Student Id]” 
*/


GO
create or alter trigger T_StudentAudit
on StudentAudit
instead of delete 
as
select CONCAT_WS(' ','The Name of User can''t deleted :',(select Server_User_Name from deleted),'Date :',(select DDate from deleted),'Note',(select Note from deleted))

GO
 
 delete from StudentAudit
 where Server_User_Name='admin_user'



Use MyCompany
--Create a trigger that prevents the insertion Process for Employee table in March.

GO
create or alter trigger preventInsert_Employee
on employee
instead of insert
as
if ( MONTH(GETDATE()) = 3)
begin
select 'you can''t insert because this month is march'
end
else
select 'insert completed successfully'


GO

insert into Employee(SSN,Fname) values (5000,'salem')






--Create an Audit table with the following structure 


CREATE TABLE ProjectAudit (
    ProjectNo INT,
    UserName NVARCHAR(100),
    ModifiedDate DATETIME,
    Budget_Old DECIMAL(18, 2),
    Budget_New DECIMAL(18, 2)
)

GO
create or alter trigger t_ProjectAudit
on ProjectAudit
after update 
as
select * from inserted
select * from deleted
GO

update ProjectAudit
set Budget_New=700000 ,Budget_Old=200000
where Budget_New=200000



use  ITI

--Create an index on column (Hiredate) that allows you to cluster the data in table Department. What will happen?
GO
create clustered index IX_hiredate
on [dbo].[Departments]               --The statement failed because specifying key list is missing when creating an index. Create the index with specifying key list
GO




--Create an index that allows you to enter unique ages in the student table. What will happen?


create unique index IX_ages
on student(st_age)           --The CREATE UNIQUE INDEX statement terminated because a duplicate key was found for the object name 'dbo.Student' and the index name 'IX_ages'. The duplicate key value





--part2

---Create a view that displays the student's full name, course name if the student has a grade more than 50. 
GO
create or alter view studentsPassInExam
as
select CONCAT_WS(' ',st.St_Fname,st.St_Lname) as 'FullName',crs.Crs_Name
from Student st ,Course crs,Stud_Course sc
where st.St_Id =sc.St_Id and crs.Crs_Id=sc.Crs_Id and sc.Grade>=50

GO

select * from studentsPassInExam





-- Create an Encrypted view that displays manager names and the topics they teach. 
GO
create or alter view teach_topics
with encryption
as
select ins.Ins_Name 'manager' ,crs.Crs_Name
from Instructor ins,Course crs
where st.St_super=
GO






--Create a view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department 
--“use Schema binding” and describe what is the meaning of Schema Binding
GO
create or alter view InsInDepratments
with schemabinding 
as
select ins.Ins_Name,dep.Dept_Name
from dbo.Instructor ins, dbo.Department dep
where ins.Dept_Id=dep.Dept_Id and dep.Dept_Name in ('SD','Java')
GO

select * from InsInDepratments








/* Create a view “V1” that displays student data for students who live in Alex or Cairo. 
Note: Prevent the users to run the following query 
Update V1 set st_address=’tanta’
Where st_address=’alex’;
*/

GO
create or alter view V1
as
select *
from Student st
where st.St_Address in ('alex','cairo')

GO

Update V1 set st_address='tanta'
Where st_address='alex'

select * from v1








use MyCompany
--Create a view that will display the project name and the number of employees working on it. (Use Company DB)
GO
create or alter view NumberOfEmp_WorkInProject
as
select pp.Pname,count(*) as 'NumOfemp'
from Employee emp ,Project pp,Works_for ws
where emp.SSN=ws.ESSn and ws.Pno=pp.Pnumber
group by pp.Pname
GO


select * from NumberOfEmp_WorkInProject






---Create a view named   “v_clerk” that will display employee Number ,project Number, the date of hiring of all the jobs of the type 'Clerk'.


GO
create or alter view v_clerk
aS
SELECT 
    e.Emp_No, 
    w.Project_No, 
    e.Hire_Date
FROM  Employee emp, Works_on ws  
WHERE e.Emp_No = w.Emp_No,e.Job = 'Clerk'
GO




select * from v_clerk








--Create view named  “v_without_budget” that will display all the projects data without budget

GO
create or alter view v_without_budget
as
select *
from Project
where Budget is null
GO


select * from v_without_budget









---Create view named ” v_project_p2” that will display the emp# s for the project# ‘p2’ . (use the previously created view  “v_clerk”)

GO
create or alter view v_project_p2
as
select Emp_No
from v_clerk
where Project_No = 'p2'
GO


select * from v_project_p2







---modify the view named  “v_without_budget”  to display all DATA in project p1 and p2.

GO
create or alter view v_without_budget
as
select *
from Project
where Pnumber in ('p1', 'p2')
GO


select * from v_without_budget




--Delete the views  “v_ clerk” and “v_count”

drop view v_ clerk
drop view v_count --doesnt exist




--create view that will display the emp# and emp last name who works on deptNumber is ‘d2’

GO
create or alter view v_emp_d2
as
select SSN , Lname
from Employee
where Dno = '2'
GO


select * from v_emp_d2




---Display the employee  lastname that contains letter “J” (Use the previous view created in Q#7)

GO
create or alter view v_clerk_withj
as
select emp.SSN , emp.Lname
from Employee emp
where Dno = '2' and Lname like '%J%'
GO





select * from v_clerk_withj





---reate view named “v_dept” that will display the department# and department name


GO
create or alter view v_dept
as
select dep.Dnum ,dep.Dname
from Departments dep
GO


select * from v_dept








--using the previous view try enter new department data where dept# is ’d4’ and dept name is ‘Development’


insert into v_dept (Dnum, Dname)
values ('4', 'Development');






--
GO
create or alter view v_2006_check
as
select ws.ESSn , Pno , ws.JoinDate
from Works_for ws
where ws.JoinDate between '2006-01-01' and '2006-12-31'
GO

select * from v_2006_check
