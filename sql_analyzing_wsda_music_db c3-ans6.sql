/*
RL March 22 2023
Project:
Why is there a financial discrepancy between 2011 and 2012?
--
CHALLENGE 3
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
ANSWER #6:
*/

SELECT *
FROM Customer AS c
WHERE c.LastName = 'Doeein' -- This customer has no address!!
-- Who do you conclude is our primary person of interest? Support Rep ID 3 Jane Peacock!!!