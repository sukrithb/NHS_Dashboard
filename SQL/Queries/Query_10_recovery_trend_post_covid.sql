-- Recovery trend: monthly appointments from 2021 onwards
USE NHS_Hospital_Activity;
SELECT d.MonthEndDate, f.Outpatient_Total_Appointments
FROM dbo.Fact_Consultation f
JOIN dbo.Dim_Date d ON f.DateKey = d.DateKey
WHERE d.Year >= 2021
ORDER BY d.MonthEndDate;
