
Retail Sales SQL Analysis - README
==================================

Project Overview:
-----------------
This project involves analysis of a retail sales dataset using PostgreSQL. The data captures transactional information such as sale date, time, customer demographics, category of items, cost, and total sale value.

This README provides explanations for SQL scripts used for data setup, cleaning, and various analytical queries.

1. Table Setup
--------------
- Drops the existing `retail_sales` table (if any) and recreates it with appropriate data types.

2. Data Cleaning
----------------
- Queries to check and remove rows with NULL values in essential columns to ensure data integrity before analysis.

3. Business Problem-Solving Queries
-----------------------------------
Q1. Sales on a Specific Date:
    - Filters transactions made on '2022-11-05'.

Q2. High Quantity Clothing Sales in Nov 2022:
    - Identifies Clothing transactions with quantity ≥ 4 in Nov 2022.

Q3. Total Sales by Category:
    - Sums `total_sale` and counts orders for each category.

Q4. Average Age of Beauty Buyers:
    - Calculates average age of customers purchasing Beauty products.

Q5. High Value Transactions:
    - Lists transactions where `total_sale` > 1000.

Q6. Transactions Count by Gender & Category:
    - Counts transactions grouped by both gender and product category.

Q7. Best Selling Month Each Year:
    - Uses ranking to find top-selling month for each year.

Q8. Top 5 Product Categories by Revenue:
    - Identifies categories with highest total sales.

Q9. Average Sale Value by Gender:
    - Compares average sale value between genders.

Q10. Sales Distribution by Age Group:
    - Groups sales by age segments like 20s, 30s, etc.

Q11. Profit by Category:
    - Calculates profit = total_sale - (quantity * COGS) for each category.

Q12. Top 10 Customers by Transactions:
    - Identifies customers with the highest transaction frequency.

Q13. Highest Revenue Day:
    - Finds the day with the most revenue generated.

Q14. Running Total of Sales (Window Function):
    - Tracks cumulative total sales over time using window functions.

Q15. Basket Analysis (Category Pairing):
    - Finds categories frequently bought together by the same customer.

Q16. Time of Day Sales Performance:
    - Buckets transactions into Morning, Afternoon, Evening, Night based on `sale_time` and analyzes their performance.

How to Use:
-----------
- Run the SQL scripts in a PostgreSQL environment (e.g., pgAdmin).
- Load your retail sales data into the `retail_sales` table after creating it.
- Execute individual queries to explore patterns, trends, and insights in the sales data.

