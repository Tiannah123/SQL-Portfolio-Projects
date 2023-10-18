--1. Find all the information pertaining individuals 
--who were contacted via the channel of banner or facebook.
SELECT *
FROM web_events
WHERE channel in ('banner', 'facebook')
LIMIT 10;

--2. Which sales representative has the highest sales in terms of total revenue?
SELECT s.name AS sales_rep_name, o.total_amt_usd AS total_amount
FROM sales_reps AS s
JOIN accounts AS a
ON a.sales_rep_id=s.id
JOIN orders AS o
ON o.account_id=a.id
ORDER BY total_amount desc
LIMIT 10;

--3.Determine the total amount spent per order on each paper type.
SELECT SUM(standard_amt_usd) AS Standard_total, SUM(gloss_amt_usd) AS Gloss_total, SUM(poster_amt_usd) AS Postal_total
FROM ORDERS;

--4. What are the names of the top 10 customers by total revenue? 
SELECT a.name AS customer_name, SUM(o.total_amt_usd) AS total_revenue
FROM accounts AS a
JOIN orders AS o ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_revenue DESC
LIMIT 10;

--5.Determine the total number of times each type of channel from the 
-- web events was used.
SELECT channel, COUNT(*) AS total_usage
FROM web_events
GROUP BY channel
LIMIT 10;

--6. How many accounts spent less than 1500 usd total across all orders? 
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) < 1500
ORDER BY total_spent;

--7.Determine the total sales in usd for each company in descending order.
--It should also include the company’s name.
SELECT accounts.name AS company_name, SUM(orders.total_amt_usd) AS total_sales_usd
FROM accounts
INNER JOIN orders ON accounts.id = orders.account_id
GROUP BY company_name
ORDER BY total_sales_usd DESC
LIMIT 10;

--8. Determine the AVERAGE amount spent per order on each paper type,
-- it should also include the account name. Limit the search to 20
SELECT accounts.name AS account_name, 
       ROUND(AVG(standard_amt_usd), 2) AS avg_standard_amt_usd, 
       ROUND(AVG(gloss_amt_usd), 2) AS avg_gloss_amt_usd, 
       ROUND(AVG(poster_amt_usd), 2) AS avg_poster_amt_usd
FROM orders
JOIN accounts ON accounts.id = orders.account_id
GROUP BY accounts.name
ORDER BY account_name
LIMIT 10;

--9. Which is Parch and Posey’s total sales per month in usd.  
SELECT DATE_PART('month',occurred_at) AS Sales_Month , SUM(total_amt_usd) AS Monthly_total_sales
FROM orders
WHERE occurred_at BETWEEN '2013-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 ASC;

--10.Which region contributes the most to parch and Posey’s revenue
SELECT r.name region, SUM(o.total_amt_usd) AS Total_amount
FROM REGION AS r
JOIN SALES_REPS AS s
ON s.region_id=r.id
JOIN ACCOUNTS AS a
ON a.sales_rep_id=s.id
JOIN orders AS o
ON o.account_id=a.id
group by region
ORDER BY Total_amount desc;