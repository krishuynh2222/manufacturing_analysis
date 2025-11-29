-- Total Defects by Shift
SELECT 
    Shift,
    SUM(ScrapQty) AS Total_Defects,
    -- Calculate what % of all factory defects come from this shift
    ROUND(
        (SUM(ScrapQty) * 100.0) / (SELECT SUM(ScrapQty) FROM Production), 
    2) AS Pct_Of_All_Defects
FROM Production
GROUP BY Shift
ORDER BY Total_Defects DESC;
		
-- Total Production & Total Defects by Product Category
SELECT 
    p.Category AS Product_Type,
    SUM(pr.ProducedQty) AS Total_Production,
    SUM(pr.ScrapQty) AS Total_Defects,
    -- Calculate Defect Rate specific to this product
    ROUND(
        (SUM(pr.ScrapQty) * 100.0) / NULLIF(SUM(pr.ProducedQty) + SUM(pr.ScrapQty), 0), 
    2) AS Defect_Rate_Pct
FROM Production pr
JOIN Products p ON pr.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY Total_Defects DESC;

-- Defect % by Machine ID
SELECT 
	line AS machine_id,
	SUM(producedqty) AS goodUnits,
	SUM(scrapqty) AS defectUnits,
	-- Calcualte the Defect % (red flag is high)
	ROUND(
		(SUM(scrapqty) * 100.0) / NULLIF(SUM(producedqty) + SUM(scrapqty),0),
	2) AS defectPercentage
FROM production
GROUP BY line
ORDER BY defectPercentage DESC;
	

	
