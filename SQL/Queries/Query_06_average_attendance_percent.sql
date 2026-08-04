-- Overall average attendance %
USE NHS_Hospital_Activity;
SELECT AVG(Outpatient_Percent_Attended) AS Avg_Attendance_Percent
FROM dbo.Fact_Consultation;
