select * from fashion;

--identify top 5 selling products

select category,count(*) as top_selling_product
from fashion
group by category 
order by top_selling_product desc 
limit 5;

--monthly trend of total sales
--first sale and last sale
select min(order_date) as first_sale, max(order_date) as last_sale
from fashion;
SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS order_month,
    SUM(revenue) AS total_monthly_sales
FROM
    fashion
GROUP BY
    order_month
ORDER BY
    order_month;
--distribution by day of the week

SELECT
    CASE EXTRACT(DOW FROM order_date)
        WHEN 0 THEN 'Sunday'
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
        WHEN 6 THEN 'Saturday'
    END AS day_of_week,
    SUM(revenue) AS total_sales,
    COUNT(*) AS total_orders
from fashion
GROUP by EXTRACT(DOW FROM order_date)  
ORDER BY EXTRACT(DOW FROM order_date);

---list top ten cutomers by revenue

select customer_name,SUM(revenue) AS total_revenue
from fashion
GROUP by customer_name
ORDER by total_revenue DESC
LIMIT 10;

--- comparison between repeat and new cutomers

SELECT
    CASE 
        WHEN order_count = 1 THEN 'New Customer'   
        ELSE 'Repeat Customer'                     
    END AS customer_type,
    COUNT(*) AS total_customers                    
FROM (SELECT customer_email, COUNT(*) AS order_count
	from fashion
	GROUP by customer_email) AS customer_orders
GROUP by customer_type
ORDER BY customer_type;


---identify locations with the most active buyers
select shop_outlet,count(customer_name) as active_buyers
from fashion
group by shop_outlet
order by active_buyers desc
limit 10;

---compare sales between weekdays and weekends
SELECT
    CASE 
        WHEN EXTRACT(DOW FROM order_date) IN (0, 6) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    SUM(revenue) AS total_sales,
    COUNT(*) AS total_orders
FROM
    fashion
GROUP BY
    day_type
ORDER BY
    day_type;
