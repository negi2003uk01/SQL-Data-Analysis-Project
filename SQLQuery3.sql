--Change Over Time Analysis
--Trends
select * from gold.fact_sales ;

SELECT 
YEAR(order_date) AS  order_year ,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales 
WHERE YEAR(order_date) IS NOT NULL 
GROUP BY YEAR(order_date) 
ORDER BY YEAR(order_date) DESC ;

-- get the data according to year 
SELECT 
YEAR(order_date) AS  order_year ,
COUNT(DISTINCT customer_key) AS total_customers ,
SUM(quantity) AS total_quantity ,
SUM(sales_amount) AS total_sales
FROM gold.fact_sales 
WHERE YEAR(order_date) IS NOT NULL 
GROUP BY YEAR(order_date) 
ORDER BY YEAR(order_date) DESC ;

-- get the data according to month 


