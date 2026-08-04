-- Top 5 financial years by total outpatient activity
USE NHS_Hospital_Activity;
SELECT TOP 5
    d.FinancialYear,
    SUM(f.Outpatient_Total_Appointments) AS TotalAppointments
FROM dbo.Fact_Consultation f
JOIN dbo.Dim_Date d ON f.DateKey = d.DateKey
GROUP BY d.FinancialYear
ORDER BY TotalAppointments DESC;
