USE ECommerceDB;

-- ORDER BY & LIMIT
SELECT product_id, product_name, price 
FROM Product 
ORDER BY price DESC 
LIMIT 3;

-- Aggregate Functions
SELECT 
    COUNT(*) AS Total_Sales_Records, 
    SUM(sale_amount) AS Total_Revenue, 
    AVG(sale_amount) AS Average_Sale_Value, 
    MAX(sale_amount) AS Highest_Sale, 
    MIN(sale_amount) AS Lowest_Sale 
FROM Sales;

-- GROUP BY & HAVING
SELECT product_id, SUM(sale_amount) AS Total_Sales_Amount
FROM Sales
GROUP BY product_id
HAVING SUM(sale_amount) > 100;

-- Window Functions
SELECT 
    product_id, 
    product_name, 
    price, 
    RANK() OVER (ORDER BY price DESC) AS Price_Rank
FROM Product;
