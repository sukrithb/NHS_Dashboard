-- Day case episodes vs ordinary episodes by financial year
USE NHS_Hospital_Activity;
SELECT
    d.FinancialYear,
    MIN(d.MonthEndDate) AS FYStart,
    SUM(f.APC_Day_Case_Episodes) AS DayCaseEpisodes,
    SUM(f.APC_Ordinary_Episodes) AS OrdinaryEpisodes
FROM dbo.Fact_Consultation f
JOIN dbo.Dim_Date d ON f.DateKey = d.DateKey
GROUP BY d.FinancialYear
ORDER BY FYStart;
