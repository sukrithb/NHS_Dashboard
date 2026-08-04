-- Monthly total outpatient appointments, most recent first
USE NHS_Hospital_Activity;
SELECT d.MonthEndDate, d.MonthName, d.Year, f.Outpatient_Total_Appointments
FROM dbo.Fact_Consultation f
JOIN dbo.Dim_Date d ON f.DateKey = d.DateKey
ORDER BY d.MonthEndDate DESC;
