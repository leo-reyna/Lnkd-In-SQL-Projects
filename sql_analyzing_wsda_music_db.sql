/*
RL March 20 2023
Project:
Why is there a financial discrepancy between 2011 and 2012?

CHALLENGE 1
1. How many transactions took place between the years 2011 and 2012?
2. How much money did WSDA Music make during the same period?

use wsda_music.db
*/

SELECT 
	COUNT(*) AS [# Transactions],
	ROUND(SUM(TOTAL),2) AS [Income]
FROM 
	Invoice
WHERE 
	InvoiceDate >= '2011/01/01' AND '2012/01/31'

/*
CHALLENGE 2
1. Get a list of customers who made purchases between 2011 and 2012.
2. Get a list of customers, sales reps, and total transaction amounts for each customer 
between 2011 and 2012.
3. How many transactions are above the average transaction amount during the same 
time period?
4. What is the average transaction amount for each year that WSDA Music has been 
in business
use wsda_music.db
*/

-- #1 ANSWER

SELECT
	c.FirstName,
	c.LastName,
	i.InvoiceDate,
	i.total
FROM 
	Customer AS c
INNER JOIN Invoice AS i
ON c.CustomerId = i.CustomerId
WHERE
	i.InvoiceDate >= '12-01-01' AND '12-01-31'

-- #2 ANSWER 

SELECT
	c.FirstName, 
	c.LastName, 
	i.InvoiceDate,
	e.FirstName AS [Employee FirstName],
	e.LastName AS [Employee LastName],
	i.total
FROM 
	Customer AS c
INNER JOIN Invoice AS i
	ON c.CustomerId = i.CustomerId
INNER JOIN Employee AS e
	ON c.SupportRepId = e.EmployeeId
WHERE
	i.InvoiceDate >= '12-01-01' AND '12-01-31'

-- #3 ANSWER 
SELECT ROUND(AVG(Total),2) AS [Average]
FROM Invoice
WHERE InvoiceDate >= '2011-01-01' AND InvoiceDate <= '2012-12-31' -- $11.66


/* CHALLENGE 3
Queries that perform in-depth analysis with the aim of finding employees who may have been 
financially motivated to commit a crime
1. Get a list of employees who exceeded the average transaction amount from sales they 
generated during 2011 and 2012.
2. Create a Commission Payout column that displays each employee’s commission 
based on 15% of the sales transaction amount.
3. Which employee made the highest commission?
4. List the customers that the employee identified in the last question.
5. Which customer made the highest purchase?
6. Look at this customer record—do you see anything suspicious?
7. Who do you conclude is our primary person of interest?

use wsda_music.db
sqlite dbbrowswer
*/

--ANSWER #1:
SELECT
	emp.FirstName AS [Employee First Name],
	emp.LastName AS [Employee Last Name],
	SUM(inv.total) as [TOTAL Sales]
FROM 
	Invoice AS inv
INNER JOIN 
	Customer AS cus
ON inv.CustomerId = cus.CustomerId
INNER JOIN 
	Employee AS emp
ON emp.EmployeeId = cus.SupportRepId
WHERE 
	InvoiceDate >= '2011-01-01' AND InvoiceDate <= '2012-12-31'
AND 
	inv.Total > 11.66  --average sale
GROUP BY
	emp.FirstName,
	emp.LastName
ORDER BY emp.LastName

--ANSWER #2:

SELECT
	cus.FirstName AS [cus First Name],
	cus.LastName AS [cus Last Name],
	emp.FirstName AS [Employee First Name],
	emp.LastName AS [Employee Last Name],
	SUM(inv.Total) as [TOTAL Sales],
	ROUND(SUM(inv.Total) *.15, 2) AS [Commission Payout]	
FROM 
	Invoice AS inv
INNER JOIN 
	Customer AS cus
ON inv.CustomerId = cus.CustomerId
INNER JOIN 
	Employee AS emp
ON emp.EmployeeId = cus.SupportRepId
WHERE 
	InvoiceDate >= '2011-01-01' AND InvoiceDate <= '2012-12-31'
AND 
	emp.LastName = 'Peacock'
GROUP BY
	cus.FirstName,
	cus.LastName,
	emp.FirstName,
	emp.LastName
ORDER BY [Total Sales] Desc

ANSWER #2:
*/
SELECT
	emp.FirstName AS [Employee First Name],
	emp.LastName AS [Employee Last Name],
	SUM(inv.Total) as [TOTAL Sales],
	ROUND(SUM(inv.Total) *.15, 2) AS [Commission Payout] -- Calculated Column
FROM 
	Invoice AS inv
INNER JOIN 
	Customer AS cus
ON inv.CustomerId = cus.CustomerId
INNER JOIN 
	Employee AS emp
ON emp.EmployeeId = cus.SupportRepId
WHERE 
	InvoiceDate >= '2011-01-01' AND InvoiceDate <= '2012-12-31'
AND 
	inv.Total > 11.66  --average sale
GROUP BY
	emp.FirstName,
	emp.LastName
ORDER BY emp.LastName

-- ANSWER #4
-- Jane Peacok with $170.65


--ANSWER #6:


SELECT *
FROM Customer AS c
WHERE c.LastName = 'Doeein' -- This customer has no address!!
-- Who do you conclude is our primary person of interest? Support Rep ID 3 Jane Peacock!!!