-- 1. How many units did we produce in total?
SELECT 
	SUM(producedqty) AS total_production
FROM production;

-- 2. What percentage of produced units are scrapped?
SELECT 
    ROUND(
        (SUM(scrapqty) * 100.0) / 
        NULLIF(SUM(producedqty) + SUM(scrapqty), 0), 
    2) AS defect_percentage
FROM production;

-- 3. How many hours of production time did we lose?
SELECT 
    ROUND(SUM(downtimeminutes) / 60.0, 2) AS total_downtime_hours
FROM production;

-- 4. What share of planned time was lost to downtime?
SELECT 
    ROUND(
        ((SUM(DowntimeMinutes) / 60.0) * 100.0) / 
        NULLIF(SUM(PlannedHours), 0), 
    2) AS Downtime_Percentage
FROM Production;

-- 5. On average, how often do we meet or beat the planned hours?
SELECT 
    ROUND(
        (SUM(PlannedHours) * 100.0) / 
        NULLIF(SUM(ActualHours), 0), 
    2) AS Avg_Efficiency_Rate
FROM Production;
