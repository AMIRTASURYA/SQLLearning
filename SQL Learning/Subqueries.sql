Select * from Sales.Orders
SELECT AVG(Sales) FROM [Sales].[Orders] 
--Main Query
SELECT 
* 
FROM
--Sub Query
	(SELECT 
	ProductID,
	Price,
	AVG(Price) over() as AvgPrice
	FROM  Sales.Products)t
WHERE PRICE>AvgPrice


SELECT  * from Sales.Products

SELECT 
Sales,
Sum(Sales) over() as total_sales
FROM Sales.Orders

SELECT *,
RANK() over(order by totalsales desc) CustomerRank
FROM

(Select 
CustomerId,
SUM(Sales) totalsales
FROM Sales.Orders
group by CustomerId)t


SELECT 
ProductId,
Product,
Price,
(SELECT Count(*) FROM Sales.Orders) as TotalOrder
FROM
Sales.Products;
--show all the customers details and show the total orders of each customer
Select
c.*,
o.totalorders
From Sales.Customers c
left join 
	(SELECT  
	customerid,
	Count(*) totalorders
	from Sales.Orders
	group by customerid) o
	
on c.CustomerID=o.CustomerID

---Find the products that have a price higher than the average price of all the products


Select
ProductId,
Price,
(Select Avg(Price) from Sales.Products) as AvgPrice
from Sales.Products
where Price> (Select Avg(Price) from Sales.Products)

--Show the details of orders made bycustomers in Germany

SELECT * FROM Sales.Orders
SELECT * FROM Sales.Customers

SELECT * FROM Sales.Orders
WHERE CustomerID in
					(SELECT 
					CustomerID
					FROM Sales.Customers
					WHERE Country != 'Germany');


SELECT * FROM Sales.Orders
WHERE CustomerID NOT IN
					(SELECT 
					CustomerID
					FROM Sales.Customers
					WHERE Country = 'Germany');


SELECT 
CustomerID
FROM Sales.Customers
WHERE Country = 'Germany'


--Find female employees whose salary are greater 
--than the salaries of  any male employees.
SELECT * FROM Sales.Employees WHERE Gender = 'F'

SELECT 
EmployeeID,
FirstName,
Salary
FROM Sales.Employees
WHERE Gender = 'F'
and 
Salary > ANY (SELECT Salary FROM Sales.Employees WHERE Gender='M')


SELECT Salary FROM Sales.Employees WHERE Gender='M'

--Show all the customer details and find the total orders of each customer

SELECT 
*,
(SELECT COUNT(*) from Sales.Orders o where o.CustomerID= c.CustomerID) TotalSales
FROM Sales.Customers c

--Show the details of orders made by customer from germany

SELECT * FROM Sales.Orders o
WHERE EXISTS(
			SELECT 1 FROM Sales.Customers c
			WHERE Country ='Germany'and 
			o.CustomerID = c.CustomerID)



SELECT * FROM Sales.Customers WHERE Country ='Germany'



