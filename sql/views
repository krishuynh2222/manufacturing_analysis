-- View 1: Current Inventory Snapshot
CREATE OR REPLACE VIEW View_Inventory_Final AS
WITH RankedInventory AS (
    SELECT 
        ProductID,
        Warehouse,
        StockUnits,
        LeadTimeDays,
        LastUpdated,
        ROW_NUMBER() OVER(
            PARTITION BY ProductID, Warehouse 
            ORDER BY LastUpdated DESC
        ) as rn
    FROM Inventory
)
SELECT 
    r.ProductID,
    p.ProductName,
    p.Category,
    r.Warehouse,
    r.StockUnits,
    (r.StockUnits * p.StandardCost) as Total_Inventory_Value,
    r.LeadTimeDays,
    CASE 
        WHEN r.StockUnits < 500 THEN 'Low Stock - Reorder' 
        ELSE 'Healthy' 
    END as Inventory_Status
FROM RankedInventory r
JOIN Products p ON r.ProductID = p.ProductID
WHERE r.rn = 1;

SELECT * FROM View_Inventory_Final LIMIT 5;


-- View 2: Production Performance Analysis
CREATE OR REPLACE VIEW View_Production_Analysis AS
SELECT 	pr.workorder,
		pr.date,
		pr.productid,
		p.productname,
		p.category,
		pr.line,
		pr.shift,
		
		-- Effciency metrics
		pr.plannedhours,
		pr.actualhours,
		(pr.actualhours - pr.plannedhours) AS hours_variance,
		CASE 
			WHEN pr.actualhours > pr.plannedhours THEN 'Over Budget'
			ELSE 'Efficient'
		END AS efficiency_status,

		-- Financial metrics (cost of poor quality)
		pr.producedqty,
		pr.scrapqty,
		(pr.scrapqty * p.standardcost) AS scrapCost, --This is the $$ lost

		-- Operational metrics
		ROUND(pr.downtimeminutes / 60.0, 2) AS downtime_hours
FROM production pr
JOIN products p ON p.productid = pr.productid;

SELECT * FROM View_Production_Analysis LIMIT 5;
