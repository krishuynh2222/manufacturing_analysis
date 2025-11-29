-- Total Inventory Value
SELECT 
    SUM(Total_Inventory_Value) AS total_inventory_value
FROM View_Inventory_Final;

-- Low Stock Items
SELECT
    COUNT(*) AS low_stock_items
FROM View_Inventory_Final
WHERE Inventory_Status = 'Low Stock - Reorder';

-- Inventory Value by Category
SELECT category,
	SUM(stockunits) AS total_units,
	SUM(Total_Inventory_Value) AS total_value_USD,
	ROUND(
        (SUM(Total_Inventory_Value) * 100.0) / (SELECT SUM(Total_Inventory_Value) FROM View_Inventory_Final), 
    1) AS Pct_Value
FROM View_Inventory_Final
GROUP BY Category
ORDER BY Total_Value_USD DESC;

-- Inventory Turnover Rate
WITH Sales_Data AS (
    SELECT ProductID, SUM(Quantity) as Total_Sold
    FROM Sales
    GROUP BY ProductID
)
SELECT 
    i.ProductName,
    i.StockUnits AS Current_Stock,
    COALESCE(s.Total_Sold, 0) AS Total_Sold_Qty,
    ROUND(
        COALESCE(s.Total_Sold, 0) * 1.0 / NULLIF(i.StockUnits, 0), 
    2) AS Turnover_Rate
FROM View_Inventory_Final i
LEFT JOIN Sales_Data s ON i.ProductID = s.ProductID
ORDER BY Turnover_Rate ASC; 

