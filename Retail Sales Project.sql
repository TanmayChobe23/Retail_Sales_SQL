-- Create Table For Retail Sales

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );


-- Data Cleaning 

SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

DELETE FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

-- Data Analysis: Key Business Problems & Answers

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

Select * From retail_sales where sale_date = '2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity of items sold is more than 4 in the month of Nov-2022

Select * from retail_sales
Where Category = 'Clothing'
AND To_Char(sale_date, 'YYYY-MM') = '2022-11'
AND Quantity >= 4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT
ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

SELECT category, gender, count(*) as total_transactions
From retail_sales
Group By category, gender
Order By category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
Year, Month, avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE Rank = 1;

-- Q.8 Top 5 Product Categories by Total Sales

SELECT category, SUM(total_sale) AS total_revenue
FROM retail_sales
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 5;

-- Q.9 Average Sale Value by Gender

SELECT gender, AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY gender;

-- Q.10  Sales Distribution by Age Group

SELECT
CASE
	WHEN age < 20 THEN 'Teen'
	WHEN age Between 20 and 29 then '20s'
	WHEN age Between 30 and 39 then '30s'
	WHEN age Between 40 and 49 then '40s'
	ELSE '50+'
END as age_group,
SUM(total_sale) as total_sale
From retail_sales
Group By age_group
Order By total_sale Desc;

-- Q.11 Total Profit by Category

SELECT category, 
       SUM(total_sale - (quantity * cogs)) AS total_profit
FROM retail_sales
GROUP BY category
ORDER BY total_profit DESC;

-- Q.12 Customer Purchase Frequency

SELECT customer_id, COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY customer_id
ORDER BY total_transactions DESC
LIMIT 10;

-- Q.13 Day with Highest Revenue

SELECT sale_date, SUM(total_sale) AS revenue
FROM retail_sales
GROUP BY sale_date
ORDER BY revenue DESC
LIMIT 1;

-- Q.14 Running Total of Sales Over Time (Window Function)
-- Analyze cumulative sales across time to see revenue growth trends.

SELECT 
sale_date,
SUM(total_sale) OVER (ORDER BY sale_date) AS running_total_sales
FROM retail_sales
ORDER BY sale_date;

-- Q.15 Basket Analysis: Most Common Category Pairs
-- Analyze which product categories are frequently bought together by the same customer.

SELECT 
    a.customer_id,
    a.category AS category_1,
    b.category AS category_2,
    COUNT(*) AS pair_count
FROM retail_sales a
JOIN retail_sales b ON 
    a.customer_id = b.customer_id AND 
    a.transaction_id <> b.transaction_id AND 
    a.sale_date = b.sale_date
WHERE a.category < b.category  -- Avoid duplicate & reverse pairs
GROUP BY a.customer_id, category_1, category_2
ORDER BY pair_count DESC;

-- Q.16 Time of Day Sales Performance (Time Bucketing)
-- Find out how different times of day perform in sales volume.

SELECT 
    CASE 
        WHEN sale_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
        WHEN sale_time BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
        WHEN sale_time BETWEEN '18:00:00' AND '21:59:59' THEN 'Evening'
        ELSE 'Night'
    END AS time_of_day,
    COUNT(*) AS transactions_count,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY time_of_day
ORDER BY total_sales DESC;





