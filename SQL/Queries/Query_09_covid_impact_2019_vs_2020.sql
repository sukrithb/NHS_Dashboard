-- COVID impact: compare FY2019/20 (pre/onset) vs FY2020/21 (full COVID year)
USE NHS_Hospital_Activity;
SELECT
    d.FinancialYear,
    SUM(f.Outpatient_Total_Appointments) AS TotalAppointments,
    SUM(f.APC_Finished_Admission_Episodes) AS FinishedAdmissionEpisodes
FROM dbo.Fact_Consultation f
JOIN dbo.Dim_Date d ON f.DateKey = d.DateKey
WHERE d.FinancialYear IN ('2019/20', '2020/21')
GROUP BY d.FinancialYear
ORDER BY d.FinancialYear;
