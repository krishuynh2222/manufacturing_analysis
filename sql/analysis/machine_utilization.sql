-- Overall Average Efficiency Rate 
SELECT 
	ROUND(
		(SUM(plannedhours) * 100.0) / NULLIF(SUM(actualhours), 0),
	2) AS Avg_Efficiency_Rate
FROM production;

-- Total Downtime (Hours) by Shift
SELECT shift,
	-- Convert minutes to hours
	ROUND(SUM(downtimeminutes) / 60.0,1) AS Total_Downtime_Hours
FROM production
GROUP BY shift
ORDER BY Total_Downtime_Hours DESC;

-- Average Efficiency Rate by Machine ID
WITH base AS (
    SELECT DISTINCT workorder, line, plannedhours, actualhours
    FROM production
)
SELECT
    line AS machine_id,
    ROUND(
        COUNT(*) FILTER (WHERE actualhours <= plannedhours)::numeric
        / NULLIF(COUNT(*), 0) * 100,
        2
    ) AS avg_efficiency_rate_pct
FROM base
GROUP BY line
ORDER BY avg_efficiency_rate_pct DESC;

-- Downtime % by Machine ID
WITH agg AS (
    SELECT
        line AS machine_id,
        SUM(plannedhours) AS planned_h,
        ROUND(SUM(downtimeminutes) / 60.0, 2) AS downtime_h
    FROM production
    GROUP BY line
)
SELECT
    machine_id,
    downtime_h,
    planned_h,
    ROUND(
        downtime_h::numeric / NULLIF(planned_h, 0) * 100,
        2
    ) AS downtime_percent
FROM agg
ORDER BY downtime_percent DESC;



