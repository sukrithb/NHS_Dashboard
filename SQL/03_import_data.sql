-- =========================================================
-- NHS Hospital Activity Dashboard
-- Step 3: Import the cleaned data
--
-- Two options are given below. Use WHICHEVER ONE WORKS for you -
-- you only need one of them.
-- =========================================================

USE NHS_Hospital_Activity;
GO



BULK INSERT dbo.Dim_Date
FROM 'D:\Data_Analyst_Prep\NHS_Data\Dim_Date.csv'
 WITH (
     FORMAT = 'CSV',
     FIRSTROW = 2,
     FIELDTERMINATOR = ',',
     ROWTERMINATOR = '0x0a',
     CODEPAGE = '65001'
 );
 GO

 BULK INSERT dbo.Fact_Consultation
 FROM 'D:\Data_Analyst_Prep\NHS_Data\Fact_Consultation.csv'
 WITH (
     FORMAT = 'CSV',
     FIRSTROW = 2,
     FIELDTERMINATOR = ',',
     ROWTERMINATOR = '0x0a',
     CODEPAGE = '65001'
 );
 GO


-- =========================================================
-- Step 4: Verify the import worked
-- =========================================================
SELECT COUNT(*) AS Dim_Date_Rows FROM dbo.Dim_Date;
SELECT COUNT(*) AS Fact_Consultation_Rows FROM dbo.Fact_Consultation;

SELECT TOP 10 *
FROM dbo.Fact_Consultation f
JOIN dbo.Dim_Date d ON f.DateKey = d.DateKey
ORDER BY d.MonthEndDate DESC;
GO
