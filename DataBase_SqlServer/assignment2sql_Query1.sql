--Display all the employees Data.
select *
from Employee emp;

--Display the employee First name, last name, Salary and Department number.
select emp.Fname ,emp.Lname ,emp.Salary,emp.Dno
from Employee emp


--Display all the projects names, locations and the department which is responsible for it.
select pj.Pname ,pj.Plocation,pj.Dnum
from Project pj



/*If you know that the company policy is to pay an annual commission for each employee with specific percent equals 10% of his/her annual salary.
Display each employee full name and his annual commission in an ANNUAL COMM column (alias)*/

select emp.Fname ,emp.Lname ,emp.Salary *12*0.1 as [ANNUAL COMM]
from Employee emp


/*Display the employees Id, name who earns more than 1000 LE monthly.*/
select emp.SSN ,emp.Fname
from Employee emp
where emp.Salary >1000

/*Display the employees Id, name who earns more than 10000 LE annually.*/

select emp.ssn ,emp.Fname
from Employee emp
where emp.Salary*12 >10000



/*Display the names and salaries of the female employees*/
select emp.Fname ,emp.Salary 
from Employee emp 
where sex = 'f'



/*Display each department id, name which is managed by a manager with id equals 968574.*/
select dep.Dnum ,dep.Dname
from Departments dep
where MGRSSN =968574


/*Display the ids, names and locations of  the projects which are controlled with department 10. */
select pj.Pnumber ,pj.Pname ,pj.Plocation
from Project pj
where dnum=10


--Get all instructors Names without repetition.
select distinct ins.Ins_Name 
from Instructor ins



/*Display instructor Name and Department Name Note: display all the instructors if they are attached to a department or not.*/
select ins.Ins_Name ,dep.Dept_Name
from Instructor ins left outer join Department dep
on ins.Dept_Id =dep.Dept_Id



/*Display student full name and the name of the course he is taking for only courses which have a grade.*/

select st.St_Fname ,st.St_Lname ,crs.Crs_Name
from Student st join Stud_Course stc 
on st.St_Id=stc.St_Id join Course crs
on stc.Crs_Id =crs.Crs_Id
where grade is not null




--Select Student first name and the data of his supervisor. 
select st.St_Fname,super.*
from Student st join Student super
on st.St_super=super.St_Id




--Display student with the following Format. 

select st.St_Id ,st.St_Fname ,st.St_Lname ,dep.Dept_Name
from Student st join Department dep
on st.Dept_Id =dep.Dept_Id


