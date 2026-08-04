-- DNA (Did Not Attend) percentage trend by month
USE NHS_Hospital_Activity;
SELECT d.MonthEndDate, f.Outpatient_Percent_DNA
FROM dbo.Fact_Consultation f
JOIN dbo.Dim_Date d ON f.DateKey = d.DateKey
ORDER BY d.MonthEndDate;
