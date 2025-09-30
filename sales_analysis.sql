-- Create database
CREATE DATABASE IF NOT EXISTS sales_db;
USE sales_db;

-- Create table
CREATE TABLE IF NOT EXISTS online_sales_dataset (
    InvoiceNo VARCHAR(50),
    StockCode VARCHAR(50),
    Description TEXT,
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10,2),
    CustomerID INT,
    Country VARCHAR(100),
    Discount DECIMAL(10,6),
    PaymentMethod VARCHAR(50),
    ShippingCost DECIMAL(10,2),
    Category VARCHAR(100),
    SalesChannel VARCHAR(50),
    ReturnStatus VARCHAR(50),
    ShipmentProvider VARCHAR(100),
    WarehouseLocation VARCHAR(100),
    OrderPriority VARCHAR(20)
);

-- Load data from CSV (adjust path before running)
-- Replace /path/to/online_sales_dataset.csv with your actual file path
LOAD DATA LOCAL INFILE '/path/to/online_sales_dataset.csv'
INTO TABLE online_sales_dataset
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(InvoiceNo, StockCode, Description, Quantity, @InvoiceDate, UnitPrice, CustomerID, Country, Discount, PaymentMethod, ShippingCost, Category, SalesChannel, ReturnStatus, ShipmentProvider, WarehouseLocation, OrderPriority)
SET InvoiceDate = STR_TO_DATE(@InvoiceDate, '%Y-%m-%d %H:%i');

-- Aggregation query: Monthly revenue & total orders (2020)
SELECT
  EXTRACT(YEAR FROM InvoiceDate) AS year,
  EXTRACT(MONTH FROM InvoiceDate) AS month,
  SUM(Quantity * UnitPrice) AS total_revenue,
  COUNT(DISTINCT InvoiceNo) AS total_orders
FROM online_sales_dataset
WHERE InvoiceDate BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY year, month
ORDER BY year, month;
