-- Financial-year total appointments and year-on-year % growth
-- NHS reporting standard: financial year runs April - March
USE NHS_Hospital_Activity;

WITH Yearly AS (
    SELECT
        d.FinancialYear,
        MIN(d.MonthEndDate) AS FYStart,   -- used only to sort financial years chronologically
        SUM(f.Outpatient_Total_Appointments) AS TotalAppointments
    FROM dbo.Fact_Consultation f
    JOIN dbo.Dim_Date d ON f.DateKey = d.DateKey
    GROUP BY d.FinancialYear
)
SELECT
    FinancialYear,
    TotalAppointments,
    LAG(TotalAppointments) OVER (ORDER BY FYStart) AS PrevYearAppointments,
    CAST(
        (TotalAppointments - LAG(TotalAppointments) OVER (ORDER BY FYStart)) * 100.0
        / NULLIF(LAG(TotalAppointments) OVER (ORDER BY FYStart), 0)
    AS DECIMAL(5,2)) AS PercentGrowth
FROM Yearly
ORDER BY FYStart;
