USE MyDatabase;

SELECT TOP (10) *
FROM [MyDatabase].[dbo].[Sales];


--Sales by date
SELECT 
    CAST(Date AS DATE) AS nDate,
    SUM(quantity * Price) AS Total_Sales
FROM Sales
GROUP BY CAST(Date AS DATE)
ORDER BY nDate;


--Sales by product
SELECT 
    ProductNo,
    ProductName,
    SUM(Quantity * Price) AS Total_Sales,
    COUNT(DISTINCT TransactionNo) AS Orders
FROM Sales
GROUP BY ProductNo, ProductName
ORDER BY Total_Sales DESC;


SELECT TOP (10) *
FROM Sales
WHERE Quantity <= 0;


ALTER TABLE Sales ADD Flag INT;

UPDATE Sales
SET Flag = 0
WHERE Quantity <= 0;

UPDATE Sales
SET Flag = 1
WHERE Quantity > 0;



--checking null values
select sum(case when Date is null then 1 else 0 end) count_nulls
     , count(Date) count_not_nulls 
  from Sales;


--customers with highest orders
SELECT CustomerNo, COUNT(*) AS Orders
FROM Sales
GROUP BY CustomerNo
ORDER BY Orders DESC;

-- adding a revenue and return value columns
ALTER TABLE Sales
ADD Revenue DECIMAL(18,2),
    ReturnValue DECIMAL(18,2);

UPDATE Sales
SET 
  Revenue = CASE WHEN Flag = 1 THEN Quantity * Price ELSE 0 END,
  ReturnValue = CASE WHEN Flag = 0 THEN ABS(Quantity * Price) ELSE 0 END;


-- adding days and months

ALTER TABLE Sales
  ADD Days INT,
      Months INT;

SELECT TOP 5
    s.Date
FROM Sales as s
ORDER BY s.Date ASC;


UPDATE Sales
SET 
  Days = DAY(CAST(Sales.Date AS DATE)),
  Months = MONTH(CAST(Sales.Date AS DATE));

-- counting
select ProductName,ProductNo,
count(*) number
from Sales
group by ProductName, ProductNo
order by number DESC;

-- rounding up price to match £

SELECT TOP (20) Price,
ROUND(Sales.Price, 2) trunc_price
FROM Sales;

UPDATE Sales
SET Price = ROUND(Sales.Price, 2);

SELECT TOP (20) *
FROM Sales;


-- creating seperate tables for analysis in power bi

SELECT
  ProductNo,
  MAX(ProductName) AS ProductName
INTO ProductInfo
FROM Sales
GROUP BY ProductNo
ORDER BY ProductName;

SELECT
  CustomerNo,
  MAX(Country) AS Country
INTO CustomerInfo
FROM Sales
GROUP BY CustomerNo;

-- creating a calender tbale


WITH CTE AS (
  SELECT CAST('2018-01-01' AS DATE) AS [Date]
  UNION ALL
  SELECT DATEADD(day,1,[Date]) FROM CTE WHERE [Date] < '2020-01-01'
)
SELECT
  [Date],
  YEAR([Date]) AS [Year],
  MONTH([Date]) AS [Month],
  DATENAME(month, [Date]) AS MonthName,
  FORMAT([Date], 'yyyy-MM') AS YearMonth,
  DATEPART(weekday,[Date]) AS Weekday
INTO DimDate
FROM CTE
OPTION (MAXRECURSION 0);

-- cross checking for QA

SELECT SUM(Revenue) AS TotalRevenue,
       SUM(ReturnValue) AS TotalReturns,
       COUNT(DISTINCT CustomerNo) AS DistinctCustomers
FROM Sales;


SELECT TOP (10) *
FROM Sales;

