-----Retrieve a number of students who have a value in their age. 
select count(st.St_Age)
from Student st


-----Display number of courses for each topic name 
select tp.Top_Name , count(*) as 'num of crs'
from Course crs ,Topic tp
where tp.Top_Id=crs.Top_Id
group by tp.Top_Name



-------Display student with the following Format (use isNull function)
select st.St_Id,st.St_Fname ,isnull(st.St_lname,'not_found') ,dep.Dept_Name
from Student st, Department dep
where st.Dept_Id =dep.Dept_Id



-----Select instructor name and his salary but if there is no salary display value ‘0000’ . “use one of Null Function”
select ins.Ins_Name ,isnull(ins.Salary,'0000') as 'salary'
from Instructor ins



----Select Supervisor first name and the count of students who supervises on them
select super.St_Fname ,count(*) as 'num of student'
from Student st ,Student super
where st.St_super = super.St_Id
group by super.St_Fname


---Display max and min salary for instructors
 select max(ins.Salary) 'maximum salary', min(ins.Salary) 'minimum salary'
from Instructor ins



---Select Average Salary for instructors 
select avg(ins.Salary) 'average salary'
from Instructor ins

use mycompany

------For each project, list the project name and the total hours per week (for all employees) spent on that project.
select pj.Pname ,sum(ws.Hours) as 'total hours'
from Project pj ,Employee emp ,Works_for ws
where pj.Pnumber=ws.Pno and emp.SSN =ws.ESSn
group by pj.Pname

-----For each department, retrieve the department name and the maximum, minimum and average salary of its employees.
select dep.Dname ,max(emp.Salary) as 'max salary' ,min(emp.Salary) as 'min salary',avg (emp.Salary) as 'avg salary'
from Departments dep ,Employee emp
where dep.Dnum = emp.Dno
group by dep.Dname


