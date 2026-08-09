-- Follow-up to Insights Log entry #5: Day Case episodes never overtook
-- Ordinary episodes in absolute volume. This checks the alternative
-- framing suggested in that entry — has Day Case's SHARE of total
-- episodes been rising, even while remaining below Ordinary in raw numbers?
USE NHS_Hospital_Activity;

SELECT
    d.FinancialYear,
    MIN(d.MonthEndDate) AS FYStart,
    SUM(f.APC_Day_Case_Episodes) AS DayCaseEpisodes,
    SUM(f.APC_Ordinary_Episodes) AS OrdinaryEpisodes,
    CAST(
        SUM(f.APC_Day_Case_Episodes) * 100.0
        / NULLIF(SUM(f.APC_Day_Case_Episodes) + SUM(f.APC_Ordinary_Episodes), 0)
    AS DECIMAL(5,2)) AS DayCasePercentShare
FROM dbo.Fact_Consultation f
JOIN dbo.Dim_Date d ON f.DateKey = d.DateKey
GROUP BY d.FinancialYear
ORDER BY FYStart;
