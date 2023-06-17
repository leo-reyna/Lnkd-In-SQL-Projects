--use tsql2012 db

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
