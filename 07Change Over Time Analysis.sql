--Change Over Time Analysis
--Trends
SELECT * FROM  gold.fact_sales ;  
 
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
   COUNT(DISTINCT customer_key) AS total_customers ,  --We get the total_sales , total_quantity sold  by year 
   SUM(quantity) AS total_quantity ,
   SUM(sales_amount) AS total_sales
FROM gold.fact_sales 
WHERE YEAR(order_date) IS NOT NULL 
GROUP BY YEAR(order_date) 
ORDER BY YEAR(order_date) DESC ;



-- get the data according to month 
SELECT 
    MONTH(order_date) AS  order_year ,
    COUNT(DISTINCT customer_key) AS total_customers ,
    SUM(quantity) AS total_quantity ,     --How is the total_sales , total_quanity sold  by year  
    SUM(sales_amount) AS total_sales
FROM gold.fact_sales 
WHERE  MONTH(order_date) IS NOT NULL 
GROUP BY MONTH(order_date) 
ORDER BY MONTH(order_date)  DESC ;

-- DATETRUNC()
SELECT
    DATETRUNC(month, order_date) AS order_date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date);


-- FORMAT()
SELECT
    FORMAT(order_date, 'yyyy-MMM') AS order_date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM');




