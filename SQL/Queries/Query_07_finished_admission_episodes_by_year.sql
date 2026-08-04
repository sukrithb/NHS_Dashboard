-- Finished admission episodes by financial year (inpatient activity trend)
USE NHS_Hospital_Activity;
SELECT
    d.FinancialYear,
    MIN(d.MonthEndDate) AS FYStart,
    SUM(f.APC_Finished_Admission_Episodes) AS FinishedAdmissionEpisodes
FROM dbo.Fact_Consultation f
JOIN dbo.Dim_Date d ON f.DateKey = d.DateKey
GROUP BY d.FinancialYear
ORDER BY FYStart;
