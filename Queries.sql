use pizza_db;

select * from pizza_sales;

-- Total Revenue --

select sum(total_price) as Total_Revenue from pizza_sales; 


-- Average order value --

select sum(total_price) / count(distinct order_id) as Avg_order_value from pizza_sales;


-- Total pizzas sold --

select sum(quantity) as Total_pizzas_sold from pizza_sales;


-- Total orders --

select count(distinct order_id) as Total_orders from pizza_sales;


-- Average pizzas per order --

select sum(quantity) / count(distinct order_id) as Avg_pizzas_per_order from pizza_sales;


-- Daily trends for total orders--


SELECT DAYNAME(order_date) AS order_day, COUNT(DISTINCT order_id) AS Total_orders 
FROM pizza_sales 
GROUP BY DAYNAME(order_date);


-- Monthly trends for total orders--


SELECT MONTHNAME(order_date) as Month_name, COUNT(DISTINCT order_id) as Total_orders
FROM pizza_sales
GROUP BY MONTHNAME(order_date);


-- Percentage of sales by Pizza category --

SELECT pizza_category, sum(total_price) as Total_sales, 
       (SUM(total_price) * 100) / (SELECT SUM(total_price) FROM pizza_sales) AS Percentage
FROM pizza_sales
GROUP BY pizza_category;



SELECT 
    pizza_category, 
    SUM(total_price) AS Total_sales,
    (SUM(total_price) * 100.0) / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS Percentage
FROM 
    pizza_sales
WHERE 
    MONTH(order_date) = 1
GROUP BY 
    pizza_category;  -- by month --


-- Percentage of sales by Pizza size --

SELECT pizza_size, sum(total_price) as Total_sales, 
       (SUM(total_price) * 100) / (SELECT SUM(total_price) FROM pizza_sales) AS Percentage
FROM pizza_sales
GROUP BY pizza_size;


SELECT 
    pizza_size, 
    cast(SUM(total_price) as decimal(10,2)) AS Total_sales,
    CAST(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS DECIMAL(10, 2)) AS Percentage
FROM 
    pizza_sales
WHERE 
    MONTH(order_date) = 1
GROUP BY 
    pizza_size;    -- by month --
   

   
   SELECT 
    pizza_size, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_sales,
    CAST(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales WHERE QUARTER(order_date) = 1) AS DECIMAL(10, 2)) AS Percentage
FROM 
    pizza_sales
WHERE 
    QUARTER(order_date) = 1
GROUP BY 
    pizza_size;   -- by quarter --
    
    
    
    
-- Top 5 best sellers by Revenue, Total quantity and Total orders --


select pizza_name, cast(sum(total_price) as decimal(10,2)) as Total_Revenue from pizza_sales
group by pizza_name
order by Total_revenue desc   -- revenue --
limit 5;             


select pizza_name, sum(quantity) as Total_quantity from pizza_sales
group by pizza_name
order by Total_quantity desc   -- quantity --
limit 5;        


select pizza_name, count(distinct order_id) as Total_orders from pizza_sales
group by pizza_name
order by Total_orders desc   -- orders --
limit 5;      

-- Top 5 worst sellers by Revenue, Total quantity and Total orders --


select pizza_name, cast(sum(total_price) as decimal(10,2)) as Total_Revenue from pizza_sales
group by pizza_name
order by Total_revenue asc   -- Revenue --
limit 5;



select pizza_name, sum(quantity) as Total_quantity from pizza_sales
group by pizza_name
order by Total_quantity asc   -- Quantity --
limit 5;



select pizza_name, count(distinct order_id) as Total_orders from pizza_sales
group by pizza_name
order by Total_orders asc  -- orders --
limit 5;
