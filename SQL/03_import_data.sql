-- =========================================================
-- NHS Hospital Activity Dashboard
-- Step 3: Import the cleaned data
--
-- Two options are given below. Use WHICHEVER ONE WORKS for you -
-- you only need one of them.
-- =========================================================

USE NHS_Hospital_Activity;
GO

-- =========================================================
-- OPTION A (recommended, no permissions issues):
-- Use SSMS's "Import Flat File" wizard instead of this script.
--   Right-click NHS_Hospital_Activity -> Tasks -> Import Flat File
--   File 1: Data\Dim_Date.csv          -> Table name: Dim_Date
--   File 2: Data\Fact_Consultation.csv -> Table name: Fact_Consultation
-- The tables already exist from 02_create_tables.sql, so when the
-- wizard asks, choose "use an existing table" if offered, otherwise
-- let it create a staging table and then run an INSERT INTO ... SELECT
-- from the staging table into the real one.
-- =========================================================


-- =========================================================
-- OPTION B: BULK INSERT (requires the CSV files to be on the SAME
-- machine as SQL Server, and requires you to update the file path below)
-- =========================================================

-- BULK INSERT dbo.Dim_Date
-- FROM 'C:\NHS_Hospital_Activity_Dashboard\Data\Dim_Date.csv'
-- WITH (
--     FORMAT = 'CSV',
--     FIRSTROW = 2,
--     FIELDTERMINATOR = ',',
--     ROWTERMINATOR = '0x0a',
--     CODEPAGE = '65001'
-- );
-- GO

-- BULK INSERT dbo.Fact_Consultation
-- FROM 'C:\NHS_Hospital_Activity_Dashboard\Data\Fact_Consultation.csv'
-- WITH (
--     FORMAT = 'CSV',
--     FIRSTROW = 2,
--     FIELDTERMINATOR = ',',
--     ROWTERMINATOR = '0x0a',
--     CODEPAGE = '65001'
-- );
-- GO


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
