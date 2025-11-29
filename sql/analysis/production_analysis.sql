-- Total Production by Month Name
SELECT 
    TO_CHAR(Date, 'FMMonth') AS Month_Name,
    EXTRACT(MONTH FROM Date) AS Month_Number,
    SUM(ProducedQty) AS Total_Production
FROM Production
GROUP BY Month_Name, Month_Number
ORDER BY Month_Number;

-- Total Production by Shift
SELECT 
	shift,
	SUM(producedqty) AS total_production, 
	ROUND(
        (SUM(ProducedQty) * 100.0) / (SELECT SUM(ProducedQty) FROM Production), 
    2) AS Contribution_Percentage
FROM production
GROUP BY shift
ORDER BY total_production DESC;

-- Total Production by Machine ID & Product Type
SELECT 
	pr.line AS machine_id,
	p.category AS product_type,
	SUM(pr.producedqty) AS total_production
FROM production pr
JOIN products p	
	ON pr.productid = p.productid
GROUP BY pr.line, p.category
ORDER BY pr.line, total_production DESC;
