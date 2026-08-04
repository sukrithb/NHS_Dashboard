-- =========================================================
-- NHS Hospital Activity Dashboard
-- Step 1: Create the database
-- Run this in SSMS while connected to .\SQLEXPRESS (or localhost\SQLEXPRESS)
-- =========================================================

IF DB_ID('NHS_Hospital_Activity') IS NULL
BEGIN
    CREATE DATABASE NHS_Hospital_Activity;
END
GO

USE NHS_Hospital_Activity;
GO
