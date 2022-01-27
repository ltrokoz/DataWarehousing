USE dbw624;

-- 1. Sales Volumes Analysis by fiscal quarter
-- a. By Store
SELECT 
    stores.StoreName AS Store,
    date_.Quater AS Quater,
    SUM(sales.Quantity) AS `Total Qty`
FROM sales
INNER JOIN stores 
ON (sales.StoreID = stores.id) 
INNER JOIN date_ 
ON (sales.DateID = date_.id) 
GROUP BY date_.Quater, stores.id
ORDER BY date_.Quater, `Total Qty` DESC;

-- b. By Product
SELECT 
    products.ProductName AS Product,
    date_.Quater AS Quater,
    SUM(sales.Quantity) AS `Total Qty`
FROM sales
INNER JOIN products 
ON (sales.ProductID = products.id) 
INNER JOIN date_ 
ON (sales.DateID = date_.id) 
GROUP BY date_.Quater, products.id
ORDER BY date_.Quater, `Total Qty` DESC;

-- c. By Product Group (Age Group)
SELECT 
    AgeGroupName AS `Age Group`,
    date_.Quater AS Quater,
    SUM(sales.Quantity) AS `Total Qty`
FROM sales
INNER JOIN date_ 
ON (sales.DateID = date_.id)
GROUP BY date_.Quater, `Age Group`
ORDER BY date_.Quater, `Total Qty` DESC;

-- ********************************************************************************
-- 2. Sales Revenue Analysis by fiscal quarter
-- a. By Store,
SELECT 
    stores.StoreName AS Store,
    date_.Quater AS Quater,
    ROUND(SUM(sales.Amount),2) AS Revenue
FROM sales
INNER JOIN stores 
ON (sales.StoreID = stores.id) 
INNER JOIN date_
ON (sales.DateID = date_.id) 
GROUP BY date_.Quater, stores.id
ORDER BY date_.Quater, Revenue DESC;

-- b. By Product
SELECT 
    products.ProductName AS Product,
    date_.Quater AS Quater,
    ROUND(SUM(sales.Amount),2) AS Revenue
FROM sales
INNER JOIN products 
ON (sales.ProductID = products.id) 
INNER JOIN date_ 
ON (sales.DateID = date_.id) 
GROUP BY date_.Quater, products.id
ORDER BY date_.Quater, Revenue DESC;

-- c. By Product Group (Age Group)
SELECT 
    AgeGroupName AS `Age Group`,
    date_.Quater AS Quater,
    ROUND(SUM(sales.Amount),2) AS Revenue
FROM sales
INNER JOIN date_ 
ON (sales.DateID = date_.id)
GROUP BY date_.Quater, `Age Group`
ORDER BY date_.Quater, Revenue DESC;

-- ********************************************************************************
-- 3. Sales Profit Analysis by fiscal quarter
-- a. By Store,
SELECT 
    stores.StoreName AS Store,
    date_.Quater AS Quater,
    ROUND(SUM(sales.Profit),2) AS Profit
FROM sales
INNER JOIN stores 
ON (sales.StoreID = stores.id) 
INNER JOIN date_
ON (sales.DateID = date_.id) 
GROUP BY date_.Quater, stores.id
ORDER BY date_.Quater, Profit DESC;

-- b. By Product
SELECT 
    products.ProductName AS Product,
    date_.Quater AS Quater,
    ROUND(SUM(sales.Profit),2) AS Profit
FROM sales
INNER JOIN products 
ON (sales.ProductID = products.id) 
INNER JOIN date_ 
ON (sales.DateID = date_.id) 
GROUP BY date_.Quater, products.id
ORDER BY date_.Quater, Profit DESC;

-- c. By Product Group (Age Group)
SELECT 
    AgeGroupName AS `Age Group`,
    date_.Quater AS Quater,
    ROUND(SUM(sales.Profit),2) AS Profit
FROM sales
INNER JOIN date_ 
ON (sales.DateID = date_.id)
GROUP BY date_.Quater, `Age Group`
ORDER BY date_.Quater, Profit DESC;

-- ********************************************************************************
-- 4. Product Line Analysis by fiscal quarter, measured by revenue and profit
-- a. Which products have been the most / least successful
SELECT 
	products.ProductName AS Product,
	date_.Quater AS Quater,
	ROUND(SUM(sales.Amount),2) AS Revenue,
    ROUND(SUM(sales.Profit),2) AS Profit
FROM sales
INNER JOIN products 
ON (sales.ProductID = products.id) 
INNER JOIN date_
ON (sales.DateID = date_.id) 
GROUP BY date_.Quater, products.ProductName
ORDER BY date_.Quater, Revenue DESC, Profit DESC;

-- b. Which product groups have been the most / least successful
SELECT 
	AgeGroupName,
	date_.Quater AS Quater,
	ROUND(SUM(sales.Amount),2) AS Revenue,
    ROUND(SUM(sales.Profit),2) AS Profit
FROM sales
INNER JOIN date_
ON (sales.DateID = date_.id) 
GROUP BY date_.Quater, AgeGroupName
ORDER BY date_.Quater, Revenue DESC, Profit DESC;

-- c. What is the product trends (growth or declining)?
SELECT 
	products.ProductName AS Product,
	date_.Quater AS Quater,
	ROUND(SUM(sales.Amount),2) AS Revenue,
    ROUND(SUM(sales.Profit),2) AS Profit
FROM sales
INNER JOIN products 
ON (sales.ProductID = products.id) 
INNER JOIN date_
ON (sales.DateID = date_.id)
WHERE products.id = 1000001
GROUP BY date_.Quater, products.ProductName
ORDER BY date_.Quater, Revenue DESC, Profit DESC;

-- ********************************************************************************
-- 5. Store Analysis by fiscal quarter, measured by revenue and profit
-- a. Which stores are the most / least successful
SELECT 
	stores.StoreName AS Store,
	date_.Quater AS Quater,
	ROUND(SUM(sales.Amount),2) AS Revenue,
    ROUND(SUM(sales.Profit),2) AS Profit
FROM sales
INNER JOIN stores 
ON (sales.StoreID = stores.id) 
INNER JOIN date_
ON (sales.DateID = date_.id)
GROUP BY date_.Quater, stores.StoreName 
ORDER BY date_.Quater, Revenue DESC, Profit DESC;

-- b. What is the growth trends for each store (growth or declining)?
SELECT 
	stores.StoreName AS Store,
	date_.Quater AS Quater,
	ROUND(SUM(sales.Amount),2) AS Revenue,
    ROUND(SUM(sales.Profit),2) AS Profit
FROM sales
INNER JOIN stores 
ON (sales.StoreID = stores.id) 
INNER JOIN date_
ON (sales.DateID = date_.id)
WHERE stores.id = 10001
GROUP BY date_.Quater, stores.StoreName 
ORDER BY date_.Quater, Revenue DESC, Profit DESC;

-- ********************************************************************************
-- 6. Additional Analysis
-- a. Which names have been most successful by volume
SELECT 
	CustomerFirstName,   
	SUM(Quantity) AS `Total Qty`
FROM sales
GROUP BY CustomerFirstName
ORDER BY `Total Qty` DESC;

-- b. Which gender has been most successful by volume
SELECT 
	CustomerGender,   
	SUM(Quantity) AS `Total Qty`
FROM sales
GROUP BY CustomerGender
ORDER BY `Total Qty` DESC;

-- c. Who was the top sales person for the quarter?
SELECT 
	employee.EmployeeFirstName AS `Sales Person`,   
	date_.Quater AS `Quater`,
	SUM(Quantity) AS `Sales Qty`
FROM sales
INNER JOIN employee 
ON (sales.EmployeeID = employee.id) 
INNER JOIN date_ 
ON (sales.DateID = date_.id) 
GROUP BY date_.Quater, employee.EmployeeFirstName
ORDER BY date_.Quater, `Sales Qty` DESC;

-- d. What percentage of sales are cash versus credit card?
SELECT @total_sales;

SELECT @total_sales:=SUM(payment_methods.PayMethodAmount)
FROM payment_methods; 

SELECT 
	payment_methods.PayMethod AS `Payment Method`,
	CONCAT(ROUND((100*SUM(payment_methods.PayMethodAmount))/@total_sales,0),"%") AS Percentage
FROM payment_methods 
GROUP BY payment_methods.PayMethod;

-- e. What percentage of sales were using a marketing campaign?
SELECT @total_sales;

SELECT @total_sales:=SUM(Amount)
FROM sales; 

SELECT 
	marketing_campaign.MCampName AS Promotion, 
	CONCAT(ROUND((100*SUM(Amount))/@total_sales,0),"%") AS Percentage
FROM sales 
INNER JOIN marketing_campaign 
ON (sales.MCampID = marketing_campaign.id) 
GROUP BY MCampID;

-- ********************************************************************************
-- 7. Analytics Against Reference Tables
-- a. Which ten cities should we open stores in, based on population?
SELECT 
	GEO AS City,  
    Population
FROM city_population
ORDER BY Population DESC
LIMIT 10;

-- b. Which names should we expect will be the most popular for our personalized products?
SELECT 
	Name_,  
    NameRank
FROM names_
ORDER BY NameRank DESC
LIMIT 1;