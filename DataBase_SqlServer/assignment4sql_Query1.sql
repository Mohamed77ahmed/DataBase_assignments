use ITI
--Create a scalar function that takes a date and returns the Month name of that date.
GO
create or alter function dbo.takedate_getmonthname(@date date)
returns varchar(15)
begin 
    declare @month_name varchar(15)
	set @month_name=DATENAME(MONTH,@date)
	return @month_name
end

GO
select dbo.takedate_getmonthname('5-15-2024') 






--Create a table-valued function that takes Student No and returns Department Name with Student full name.

GO
create or alter function dbo.getstudentname_anddepartment(@st_id int)
returns @data table (full_name varchar(50),dep_name varchar(20))
as
begin

insert into @data 
select CONCAT_WS(' ' ,st.St_Fname,st.St_Lname), dep.Dept_Name 
from Department dep ,Student st
where st.Dept_Id=dep.Dept_Id and st.St_Id=@st_id
return
end
GO
select * from dbo.getstudentname_anddepartment(7)




--Create a scalar function that takes Student ID and returns a message to user 
GO
create or alter function dbo.getstudentID(@st_id int)
returns varchar(50)

begin
declare @fristname varchar(30)
declare @lastname varchar(30)
declare @message varchar(50)

select @fristname=st.St_Fname,  @lastname=st.St_Lname
from Student st
where @st_id=st.St_Id

if @fristname is null and @lastname is null
set @message= 'First name & last name are null' 
else if @fristname is null 
set @message= 'First name is null' 
else if  @lastname is null
set @message= ' last name is null' 
else 
set @message= 'First name & last name are not null' 


return @message

end
GO

select dbo.getstudentID('2')










/*Create a function that takes an integer which represents 
the format of the Manager hiring date 
and displays department name, Manager Name and hiring date with this format.  */
GO

create or alter function dbo.getdepartment_manager_nameBasedfromat(@format int)
returns @data table(manager_name varchar(30),department_name varchar(30),hiring_date varchar(30))
as
begin
if @format=1
insert into @data
select dep.Dept_Name , dep.Dept_Manager ,CONVERT(VARCHAR(20), dep.Manager_hiredate, 23)
from Department dep
else if @format=2
insert into @data
select dep.Dept_Name , dep.Dept_Manager ,format(dep.Manager_hiredate ,'dddd mmmm yyyy')
from Department dep
else if @format=3
insert into @data
select dep.Dept_Name , dep.Dept_Manager ,format(dep.Manager_hiredate ,'ddd mmm yyyy')
from Department dep
else
insert into @data
select dep.Dept_Name , dep.Dept_Manager ,dep.Manager_hiredate
from Department dep
return
end

GO

select *
from dbo.getdepartment_manager_nameBasedfromat('100000000')









-----Create multi-statement table-valued function that takes a string

GO
create or alter function dbo.getname(@format varchar(20))
returns @data table(student_name varchar(30))
as
begin
if @format= 'fristname'
insert into @data
select isnull (st.St_Fname,'notfound')
from Student st
if @format= 'lastname'
insert into @data
select isnull (st.St_Lname,'notfound')
from Student st

if @format= 'fullname'
insert into @data
select CONCAT(st.St_Fname,' ',st.St_Lname)
from Student st

return
end
GO


select *from dbo.getname('fristname')
select *from dbo.getname('lastname')
select *from dbo.getname('fullname')






use MyCompany
---Create function that takes project number and display all employees in this project (Use MyCompany DB)
GO
create or alter function dbo.getall_employee(@pnum int)
returns table 
as
return
(
select concat (emp.Fname,' ',emp.Lname) as 'employees name' --,count(*) as 'num of emp in dep'
from Works_for ws,Employee emp
where ws.ESSn=emp.SSN and ws.pno=@pnum

)


GO



select * from dbo.getall_employee(100)











