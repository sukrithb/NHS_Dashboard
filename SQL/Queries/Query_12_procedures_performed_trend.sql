-- Procedures performed trend (FCEs with a procedure) by financial year
USE NHS_Hospital_Activity;
SELECT
    d.FinancialYear,
    MIN(d.MonthEndDate) AS FYStart,
    SUM(f.APC_FCEs_with_a_procedure) AS ProceduresPerformed
FROM dbo.Fact_Consultation f
JOIN dbo.Dim_Date d ON f.DateKey = d.DateKey
GROUP BY d.FinancialYear
ORDER BY FYStart;
