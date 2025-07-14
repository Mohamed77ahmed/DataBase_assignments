--Select max two salaries in the instructor table. 

select top 2 ins.Salary
from Instructor ins 
where ins.Salary is not null
order by ins.Salary desc




--Write a query to select the highest two salaries in Each Department for instructors who have salaries. “using one of Ranking Functions”
select Dept_Id ,Salary
from(select ins.Dept_Id,ins.salary,
      DENSE_RANK() over (PARTITION by Dept_Id order by ins.salary desc) as 'rank'
      from Instructor ins
	  where ins.Salary is not null) as T
where t.rank <=2





--Write a query to select a random  student from each department.  “using one of Ranking Functions”

select t.St_Id ,t.St_Fname,t.St_Fname
from(select * , DENSE_RANK() over (PARTITION by st.Dept_Id order by newid()) as 'rank'
from Student st
where st.Dept_Id is not null) as T
where t.rank <=1







--Display the SalesOrderID, ShipDate of the SalesOrderHearder table (Sales schema) to designate SalesOrders that occurred within the period ‘7/28/2002’ and ‘7/29/2014’

select ss.SalesOrderID ,ss.ShipDate
from [Sales].[SalesOrderHeader] ss
where ss.ShipDate between '7/28/2002' and '7/29/2014'



--Display only Products(Production schema) with a StandardCost below $110.00 (show ProductID, Name only)


select pp.Name ,pp.ProductID--,pp.StandardCost
from [Production].[Product] pp
where pp.StandardCost <'110.00'


--Display ProductID, Name if its weight is unknown

select pp.Name ,pp.ProductID--,pp.StandardCost
from [Production].[Product] pp
where pp.Weight is null



-- Display all Products with a Silver, Black, or Red Color

select *
from [Production].[Product] pp
where pp.Color in( 'Silver' , 'Black' , 'Red')




-- Display any Product with a Name starting with the letter B

select *
from [Production].[Product] pp
where pp.Name like 'b%'



--Run the following Query

select pp.Description
from Production.ProductDescription pp
WHERE ProductDescriptionID = 3





UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

select pp.Description
from Production.ProductDescription pp
WHERE pp.Description like '[_]% '


-- Display the Employees HireDate (note no repeated values are allowed)

select distinct em.HireDate
from [HumanResources].[Employee] em


--Display the Product Name and its ListPrice within the values of 100 and 120 the list should have the following format "The [product name] is only! [List price]" (the list will be sorted according to its ListPrice value)


select pp.Name ,pp.ProductID
from [Production].[Product] pp
where pp.ListPrice between 100 and 120
order by pp.ListPrice



