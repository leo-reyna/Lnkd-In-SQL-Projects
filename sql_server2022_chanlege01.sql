--use tsql2012 db
--categorize products by sale type
--lr 062023

SELECT 
	PRP.productname as [productname], 
	OD.unitprice AS [price], 
	convert(varchar, SO.orderdate, 101) as [date order],
	CASE
	WHEN OD.unitprice < 10.99 THEN 'Low Purchase' 
	WHEN OD.unitprice BETWEEN 11 AND 49.99 THEN 'Low Med Purchase'
	WHEN OD.unitprice BETWEEN 50 AND 99.99 THEN 'Good Purchase'
	WHEN OD.Unitprice BETWEEN 100 AND 190.99 THEN 'Great Purchase'
	ELSE 'Awesome Purchase'
	END AS [saletype]
FROM Sales.OrderDetails AS OD
INNER JOIN 
	Sales.Orders AS SO
ON OD.orderid = SO.orderid
INNER JOIN 
	Production.Products AS PRP
ON PRP.productid = OD.productid
ORDER BY OD.unitprice

-- 2nd PART 
--USE TSQL2012

SELECT empid, YEAR(orderdate) as orderyear, COUNT(*) AS numorders
FROM Sales.Orders
WHERE custid = 71 
GROUP BY empid, YEAR(orderdate)
HAVING COUNT (*) > 1
ORDER BY empid, orderyear

--You will retrieve a list of distinct CITY names from the STATION table where the CITY name starts and ends with a vowel.
SELECT DISTINCT shipcity
FROM Sales.Orders
WHERE shipcity LIKE '[aeiou]%[aeiou]';

--You will retrieve a list of distinct CITY names from the STATION table where the CITY name starts with a vowel
SELECT DISTINCT shipcity
FROM Sales.Orders
WHERE shipcity LIKE '[aeiou]%';

--You will retrieve a list of distinct CITY names from the STATION table where the CITY name ends with a vowel
SELECT DISTINCT shipcity
FROM Sales.Orders
WHERE shipcity LIKE '%[aeiou]';

--You will retrieve a list of distinct CITY names from the STATION table where the CITY name DO NOT START with a vowel
SELECT DISTINCT shipcity, shipcountry
FROM Sales.Orders
WHERE shipcity NOT LIKE '%[aeiou]';
