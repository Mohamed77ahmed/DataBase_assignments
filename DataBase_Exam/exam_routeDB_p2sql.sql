/*Write a query that displays Full name of an employee who has more than
3 letters in his/her First Name*/

select CONCAT_WS(' ',emp.Fname,emp.Lname) as 'FullName'
from Employee emp
where emp.Fname like '___%'





/*Write a query to display the total number of Programming books
available in the library with alias name ‘NO OF PROGRAMMING
BOOKS’ */

select count(*) as 'NO OF PROGRAMMING BOOKS'
from book b
where b.Cat_id=1





/*Write a query to display the number of books published by
(HarperCollins) with the alias name 'NO_OF_BOOKS*/

select count(*) as 'NO_OF_BOOKS'
from Book b
where b.Publisher_id=1



/*Write a query to display the User SSN and name, date of borrowing and due date of
the User whose due date is before July 2022.*/

select us.SSN ,us.User_Name,br.Borrow_date
from Users us,Borrowing br
where br.Emp_id=us.Emp_id and br.Borrow_date <'2022-7-1'



/*Write a query to display book title, author name and display in the
following format,
' [Book Title] is written by [Author Name]*/

select CONCAT_WS(' ',b.Title,' is written by ',a.Name)
from book b,Author a,Book_Author ba
where b.Id=ba.Book_id and a.Id=ba.Author_id





--Write a query to display the name of users who have letter 'A' in their names
select u.User_Name
from users u
where u.User_Name like '[a]%'





--Write a query that display user SSN who makes the most borrowing
select max(num),ssn
from (select User_ssn as ssn,count(*) as num
from Borrowing b, Users u
where b.User_ssn=u.SSN
group by b.User_ssn) as m






--Write a query that displays the total amount of money that each user paid for borrowing books

select u.SSN,u.User_Name ,sum(b.Amount) as 'total amount'
from Users u,Borrowing b
where u.SSN=b.User_ssn
group by u.SSN,u.User_Name








/* write a query that displays the category which has the book that has the
minimum amount of money for borrowing*/

select top(1) c.Cat_name ,b.Amount
from Category c,Borrowing b,Book bo
where c.Id=bo.Cat_id and b.Book_id=bo.Id
order by b.Amount


/*write a query that displays the email of an employee if it's not found,
display address if it's not found, display date of birthday*/

select Coalesce(emp.Email ,emp.Address , convert(varchar,emp.DOB,1)) as 'mm'
from Employee emp



/*Write a query to list the category and number of books in each category
with the alias name 'Count Of Books'.*/

select  c.Id,c.Cat_name,count(*) as'Count Of Books'
from Book b,Category c
where b.Cat_id=c.Id
group by c.Cat_name ,c.Id




/*Write a query that display books id which is not found in floor num = 1
and shelf-code = A1*/
select b.Id ,b.Shelf_code,sh.Floor_num
from Book b,Shelf sh
where  b.Shelf_code=sh.Code and
b.Shelf_code !='A1 'and sh.Floor_num !=1







/*3.Write a query that displays the floor number , Number of Blocks and
number of employees working on that floor*/


select f.Number ,f.Num_blocks ,count(*) as 'NumOfEmpolyee'
from floor f,Employee emp
where f.Number=emp.Floor_no
group by f.Number ,f.Num_blocks



/*.Display Book Title and User Name to designate Borrowing that occurred
within the period ‘3/1/2022’ and ‘10/1/2022’.{2 Points}
*/

select b.Title ,u.User_Name 
from book b ,Users u ,Borrowing br
where b.Id=br.Book_id and br.User_ssn=u.SSN and
br.Borrow_date between '2022-03-01'and '2022-10-01'




/*.Display Employee Full Name and Name Of his/her Supervisor as
Supervisor Name.{*/

select CONCAT_WS(' ',emp.Fname,emp.Lname) as'FullName' ,super.Fname
from Employee emp ,Employee super
where emp.Super_id=super.Id





/*6.Select Employee name and his/her salary but if there is no salary display
Employee bonus*/

select emp.Fname,coalesce(emp.Salary, emp.bouns) as 's&b' ,Bouns
from Employee emp




---.Display max and min salary for Employe

select max(Salary)as 'Maximum Salary',min(Salary) as'Minmum Salary'
from Employee






--Write a function that take Number and display if it is even or odd
GO
create function checkEvenOrOdd(@num int)
returns varchar(5)
as 
begin

declare @word varchar(5)
if @num%2!=0
select @word='Odd'
else select @word='Even'
return @word

end

GO
--call
select checkEvenOrOdd(0)



/*.write a function that take category name and display Title of books in that
category*/
GO
create function CategoryReTitle (@name varchar(30))
returns table 
as
return(
select  b.Title
from Category c,Book b
where c.Id=b.Cat_id and c.Cat_name=@name
 
)
GO
--call
select *
from dbo.CategoryReTitle('programming ')





/*write a function that takes the phone of the user and displays Book Title ,
user-name, amount of money and due-date.*/
GO
create or alter function GetInfoAboutUser(@phone_num varchar(20))
returns table


return(
select b.Title ,u.User_Name ,br.Amount,br.Due_date
from User_phones up,Users u,book b,Borrowing br
where u.SSN=br.User_ssn and b.Id=br.Book_id and u.SSN=up.User_ssn
and up.Phone_num=@phone_num)
GO


---call
select * from dbo.GetInfoAboutUser('0120321455')






/*Write a function that take user name and check if it's duplicated
return Message in the following format ([User Name] is Repeated
[Count] times) if it's not duplicated display msg with this format [user
name] is not duplicated,if it's not Found Return [User Name] is Not
Found*/


GO
create function Check_Duplicated(@name varchar(30))
returns varchar(55)
as
begin

declare @message varchar(55)

select @message =CONCAT_WS(' ',u.User_Name,'is Repeated',COUNT(*),'times') 
from Users u
where u.User_Name=@name
group by u.User_Name
having COUNT(*)>1

return @message
end

GO

---call
select dbo.Check_Duplicated('Amr Ahmed')





/*Create a scalar function that takes date and Format to return Date With
That Format*/
GO
create or alter function GetDateWithformat(@ddate date,@format int)
returns VARCHAR(30)
as
begin

declare @outdate varchar(30)
select @outdate=CONVERT(varchar(30),@ddate,@format)

return @outdate
end
GO
---call
select dbo.GetDateWithformat('07-15-2023',1)










--.Create a stored procedure to show the number of books per Category

GO
create or alter proc SP_ShowNumOfBooks @cName varchar(30)

as
select count(*) as 'NumOfBooks'
from Category CT,book B
where ct.Id=b.Cat_id and Cat_name=@cName

GO

--call
SP_ShowNumOfBooks 'self improvement '






/*Create a stored procedure that will be used in case there is an old manager
who has left the floor and a new one becomes his replacement. The
procedure should take 3 parameters (old Emp.id, new Emp.id and the
floor number) and it will be used to update the floor table*/

GO
create or alter proc SP_ChangeManager @OldEmp_Id int ,@NewEmp_Id int ,@Floor_Num int
as
update dbo.Employee 
set Super_id=@NewEmp_Id 
where Super_id =@OldEmp_Id and Floor_no=@Floor_Num

update Floor
set MG_ID=@NewEmp_Id
where Number=@Floor_Num


GO
SP_ChangeManager 1,17,2






/*Create a view AlexAndCairoEmp that displays Employee data for users
who live in Alex or Cairo*/

GO
Create or alter view AlexAndCairoEmp
as
select *
from Employee emp
where emp.Address in ('cairo' ,'alex')
GO
  


  --call
  select * from AlexAndCairoEmp




  /*create a view "V2" That displays number of books per shelf*/
  GO
create or alter view V2
as
select s.Code,count(*) as 'NumOfbooks'
from Shelf s,Book b
where s.Code=b.Shelf_code 
group by s.Code
GO



--call 
select * from dbo.V2







/*.create a view "V3" That display the shelf code that have maximum
number of books using the previous view "V2"*/

GO
create or alter view V3
as
select v2.Code
from V2
where v2.NumOfbooks=(select max(v2.NumOfbooks) from V2)
GO



--call
select  * from V3 








/*create A trigger that instead of inserting the data of returned book
checks if the return date is the due date or not if not so the user must pay
a fee and it will be 20% of the amount that was paid before*/
GO
create or alter trigger CheckReturnDat
on  ReturnedBooks 
instead of insert
as
select 
from
if 
GO






/*In the Floor table insert new Floor With Number of blocks 2 , employee
with SSN = 20 as a manager for this Floor,The start date for this manager
is Now. Do what is required if you know that : Mr.Omar Amr(SSN=5)
moved to be the manager of the new Floor (id = 7), and they give Mr. Ali
Mohamed(his SSN =12) His position .*/

insert into Floor 
values(7,2,20,GETDATE())

update floor
set MG_ID=5
where Number=7

update floor
set MG_ID=12
where Number=4








/*Create view name (v_2006_check) that will display Manager id, Floor
Number where he/she works , Number of Blocks and the Hiring Date
which must be from the first of March and the end of May 2022.this view
will be used to insert data so make sure that the coming new data must
match the condition then try to insert this 2 rows and */

GO
create or alter view v_2006_check
as
select emp.Super_id ,emp.Floor_no,f.Num_blocks,f.Hiring_Date
from Employee emp,Floor f
where  f.MG_ID=emp.Super_id and f.Hiring_Date between '2022-03-01' and '2022-05-30'

GO


--call
select *from v_2006_check

--insert
insert into v_2006_check values (2,6,2,'7-8-2023')  ----cant insert becuase view depands more one table
insert into v_2006_check values (4,7,1,'4-8-2022') 



/*Add a new User Phone Number with User_SSN = 50 in
User_Phones Table*/

insert into User_phones values (50,01011292354) ---The INSERT statement conflicted with the FOREIGN KEY constraint "FK_User_phones_User". The conflict occurred in database "Library", table "dbo.Users", column 'SSN'.



/*Modify the employee id 20 in the employee table to 21*/

update Employee
set Id=21
where Employee.Id=20  --Cannot update identity column 'Id'.



--Delete the employee with id 1 
delete from Employee  --The DELETE statement conflicted with the REFERENCE constraint "FK_Borrowing_Employee"
where id=2





--Delete the employee with id 12
delete from Employee  --The DELETE statement conflicted with the REFERENCE constraint "FK_Borrowing_Employee"
where id=12



/*Create an index on column (Salary) that allows you to cluster the
data in table Employee.*/

create clustered index Ix_salaryemp ----Cannot create more than one clustered index on table 'dbo.employee'
on dbo.employee(salary)










/*Try to Create Login With Your Name And give yourself access Only to
Employee and Floor tables then allow this login to select and insert data
into tables and deny Delete and update (Don't Forget To take screenshot
to every step*/


CREATE LOGIN MoAhmed WITH PASSWORD = 'moh12345'


create user mohamed for login MoAhmed

GRANT SELECT, INSERT ON Employee TO mohamed;
DENY UPDATE, DELETE ON Employee TO mohamed;


GRANT SELECT, INSERT ON Floor TO mohamed;
DENY UPDATE, DELETE ON Floor TO mohamed;


