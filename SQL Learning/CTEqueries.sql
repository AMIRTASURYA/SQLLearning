--Step 1: Find The total sales per customer(standalone CTE)
--Order by is not allowed in CTE

WITH CTE_Total_Sales AS(
SELECT 
	CustomerID,
	SUM(Sales) as TotalSales
FROM Sales.Orders
Group by CustomerID
)
--Step 2 Find the last orderdate for each customer(standalone CTE)
,CTE_Last_Order AS(
SELECT 
	CustomerID,
	Max(OrderDate) as Last_Order

FROM Sales.Orders 
Group by CustomerID
)

--step 3: Rank customer based on total Sales per customer(Nested CTE)
,CTE_Customer_Rank AS(
SELECT 
	CustomerID,
	TotalSales,
	Rank() over(order by TotalSales desc) Customer_rank
FROM CTE_Total_Sales
)

--SELECT * FROM CTE_Customer_Rank

--Step 4 segment customers based on their tolal sales(Nested CTE)
,CTE_Customer_Segement AS (
SELECT
	CustomerID,
	TotalSales,
	CASE WHEN TotalSales>100 THEN 'HIGH'
		 WHEN TotalSales>80 THEN 'MEDIUM'
		 ELSE 'LOW'
	END CustomerSegments
From CTE_Total_Sales)


--Main Query
SELECT 
		c.CustomerID,
		c.FirstName,
		c.LastName,
		cts.TotalSales,
		clo.Last_Order,
		ccr.Customer_rank,
		ccs.CustomerSegments


From Sales.Customers c
Left join CTE_Total_Sales cts
on cts.CustomerID=c.CustomerID

Left join CTE_Last_Order clo
on clo.CustomerID=c.CustomerID

Left join CTE_Customer_Rank ccr
on ccr.CustomerID=c.CustomerID

Left join CTE_Customer_Segement ccs
on ccs.CustomerID=c.CustomerID
Order by CustomerID

--Recursive query
--Generate a Sequence of numbers from 1 to 20

WITH Series AS(
--Anchor query
	SELECT 
	1 AS MyNumber
    Union All
	--recusive query
	SELECT MyNumber + 1 FROM Series
	Where MyNumber< 1000
	)

SELECT * From Series
OPTION (MAXRECURSION 5000)


--show the employee hierarchy by dispalying each employees level withon the organisation

--SELECT * FROM Sales.Employees

WITH CTE_Emp_Hierarchy AS(
	--Anchor Query
	SELECT 
		EmployeeID,
		FirstName,
		ManagerID,
		1 AS LEVEL
	FROM Sales.Employees
	WHERE ManagerID IS NULL
	UNION ALL 
	--recursive query
	SELECT 
		e.EmployeeID,
		e.FirstName,
		e.ManagerID,
		Level +1

	FROM Sales.Employees AS e
	Inner Join  CTE_Emp_Hierarchy ceh
	on e.ManagerID= ceh.EmployeeID

)

--MAIN query 

SELECT * FROM CTE_Emp_Hierarchy
