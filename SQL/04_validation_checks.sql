-- =========================================================
-- NHS Hospital Activity Dashboard
-- Step 4: Data validation checks (run after 03_import_data.sql)
--
-- Purpose: confirm the import completed correctly and the fact/dimension
-- relationship is sound before building anything on top of it in Power BI.
-- Every check below should return 0 rows (or the stated expected result)
-- if the data is clean. Any non-zero/unexpected result means something
-- needs investigating before proceeding.
-- =========================================================

USE NHS_Hospital_Activity;
GO

-- 1. Row count check — expect 216 rows in both tables (18 years x 12 months)
SELECT 'Dim_Date' AS TableName, COUNT(*) AS ActualRowCount, 216 AS Expected FROM dbo.Dim_Date
UNION ALL
SELECT 'Fact_Consultation', COUNT(*), 216 FROM dbo.Fact_Consultation;
GO

-- 2. Orphan check — fact rows with no matching date (should return 0 rows)
SELECT f.*
FROM dbo.Fact_Consultation f
LEFT JOIN dbo.Dim_Date d ON f.DateKey = d.DateKey
WHERE d.DateKey IS NULL;
GO

-- 3. Duplicate key check — Dim_Date should have exactly one row per DateKey (should return 0 rows)
SELECT DateKey, COUNT(*) AS Occurrences
FROM dbo.Dim_Date
GROUP BY DateKey
HAVING COUNT(*) > 1;
GO

-- 4. Duplicate key check — Fact_Consultation should have exactly one row per DateKey (should return 0 rows)
SELECT DateKey, COUNT(*) AS Occurrences
FROM dbo.Fact_Consultation
GROUP BY DateKey
HAVING COUNT(*) > 1;
GO

-- 5. Null check — no NULLs expected in key measure columns (should return 0 rows)
SELECT *
FROM dbo.Fact_Consultation
WHERE Outpatient_Total_Appointments IS NULL
   OR APC_Finished_Admission_Episodes IS NULL
   OR APC_Emergency IS NULL;
GO

-- 6. Date range / continuity check — confirm no gaps in the monthly sequence
-- Expect this to return an empty result; a non-empty result means a month is missing
WITH Expected AS (
    SELECT MIN(MonthEndDate) AS MinDate, MAX(MonthEndDate) AS MaxDate FROM dbo.Dim_Date
),
AllMonths AS (
    SELECT EOMONTH(DATEADD(MONTH, n, (SELECT MinDate FROM Expected))) AS ExpectedMonthEnd
    FROM (SELECT TOP (300) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS n
          FROM sys.all_objects) AS Numbers
    WHERE DATEADD(MONTH, n, (SELECT MinDate FROM Expected)) <= (SELECT MaxDate FROM Expected)
)
SELECT a.ExpectedMonthEnd
FROM AllMonths a
LEFT JOIN dbo.Dim_Date d ON a.ExpectedMonthEnd = d.MonthEndDate
WHERE d.MonthEndDate IS NULL;
GO

-- 7. Financial year consistency check — every FinancialYear should have exactly 12 months (should return 0 rows)
SELECT FinancialYear, COUNT(*) AS MonthCount
FROM dbo.Dim_Date
GROUP BY FinancialYear
HAVING COUNT(*) <> 12;
GO

-- 8. Sanity range check — percentages should be between 0 and 100 (should return 0 rows)
SELECT *
FROM dbo.Fact_Consultation
WHERE Outpatient_Percent_Attended NOT BETWEEN 0 AND 100
   OR Outpatient_Percent_DNA NOT BETWEEN 0 AND 100;
GO

PRINT 'Validation checks complete. Review each result set above — all should be empty except the row count check (Step 1).';
