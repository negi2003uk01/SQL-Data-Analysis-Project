/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/

/* Analyze the yearly performance of products by comparing their sales 
to both the average sales performance of the product and the previous year's sales */

-- Performance Analysis 

-- Select all the coloumn which we needed for Analysis 
SELECT 
  s.order_date ,
  p.product_name , 
  s.sales_amount
FROM gold.dim_products p
  LEFT JOIN gold.fact_sales s ON
  s.product_key = p.product_key ;

-- find the  total sales_amount  year wise

    SELECT 
      YEAR(s.order_date) AS order_year ,
      p.product_name , 
      SUM(s.sales_amount) AS current_sales
    FROM gold.dim_products p
      LEFT JOIN gold.fact_sales s ON
      s.product_key = p.product_key
    WHERE s.order_date IS NOT NULL 
    GROUP BY YEAR(s.order_date),
             p.product_name  ;
         

--  Analyze the yearly performance of products by comparing their sales 
 WITH yearly_product_sales AS ( 
    SELECT 
      YEAR(s.order_date) AS order_year ,    --First we make the CTC 
      p.product_name , 
      SUM(s.sales_amount) AS current_sales
    FROM gold.dim_products p
      LEFT JOIN gold.fact_sales s ON
      s.product_key = p.product_key
    WHERE s.order_date IS NOT NULL 
    GROUP BY YEAR(s.order_date),
             p.product_name  
             ) 
SELECT 
order_year ,
product_name ,
current_sales ,
AVG(current_sales) OVER( PARTITION BY product_name) AS avg_sales ,
current_sales -AVG(current_sales) OVER( PARTITION BY product_name) AS diff_avg , -- Compare with the Average sales 
CASE WHEN current_sales -AVG(current_sales) OVER( PARTITION BY product_name) > 0 THEN 'Above Average'   
     WHEN  current_sales -AVG(current_sales) OVER( PARTITION BY product_name) < 0 THEN 'Below Average'
     ELSE 'Average' 
     END avg_change ,
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year ) py_sales ,  
 current_sales -    LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year )AS diff_py ,  -- compare with pervious year sales 
CASE WHEN current_sales -  LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year ) > 0 THEN 'Increase' 
     WHEN  current_sales -  LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year ) < 0 THEN 'Decrease'
     ELSE 'NO change'
     END py_change 
     FROM yearly_product_sales
     ORDER BY product_name ,
              order_year ;
