-- Executive Summary page KPIs, most recent month
USE NHS_Hospital_Activity;
SELECT TOP 1
    d.MonthEndDate,
    f.Outpatient_Total_Appointments        AS Total_Appointments,
    f.Outpatient_Attended_Appointments     AS Attended_Appointments,
    f.Outpatient_DNA_Appointment           AS DNA_Count,
    f.Outpatient_Percent_DNA               AS DNA_Percent,
    f.APC_Emergency                        AS Emergency_Admissions,
    f.APC_Finished_Admission_Episodes      AS Finished_Admission_Episodes
FROM dbo.Fact_Consultation f
JOIN dbo.Dim_Date d ON f.DateKey = d.DateKey
ORDER BY d.MonthEndDate DESC;
