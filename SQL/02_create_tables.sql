-- =========================================================
-- NHS Hospital Activity Dashboard
-- Step 2: Create tables (simple star schema)
-- =========================================================

USE NHS_Hospital_Activity;
GO

IF OBJECT_ID('dbo.Fact_Consultation', 'U') IS NOT NULL DROP TABLE dbo.Fact_Consultation;
IF OBJECT_ID('dbo.Dim_Date', 'U') IS NOT NULL DROP TABLE dbo.Dim_Date;
GO

CREATE TABLE dbo.Dim_Date (
    DateKey         INT PRIMARY KEY,       -- e.g. 202503 (YYYYMM)
    MonthEndDate    DATE NOT NULL,
    [Year]          INT NOT NULL,
    [Month]         INT NOT NULL,
    MonthName       VARCHAR(20) NOT NULL,
    Quarter         INT NOT NULL,
    FinancialYear   VARCHAR(10) NOT NULL
);
GO

CREATE TABLE dbo.Fact_Consultation (
    DateKey                             INT NOT NULL REFERENCES dbo.Dim_Date(DateKey),
    APC_Finished_Consultant             BIGINT,
    APC_FCEs_with_a_procedure           BIGINT,
    APC_Percent_FCEs_with_procedure     DECIMAL(5,2),
    APC_Ordinary_Episodes               BIGINT,
    APC_Day_Case_Episodes               BIGINT,
    APC_Day_Case_Episodes_with_proc     BIGINT,
    APC_Percent_Day_Cases_with_proc     DECIMAL(5,2),
    APC_Finished_Admission_Episodes     BIGINT,
    APC_Emergency                       BIGINT,
    Outpatient_Total_Appointments       BIGINT,
    Outpatient_Attended_Appointments    BIGINT,
    Outpatient_Percent_Attended         DECIMAL(5,2),
    Outpatient_DNA_Appointment          BIGINT,
    Outpatient_Percent_DNA              DECIMAL(5,2),
    Outpatient_Follow_Up_Attendance     DECIMAL(10,4),
    Outpatient_Attendance_Type_1        BIGINT,
    Outpatient_Attendance_Type_2        BIGINT,
    CONSTRAINT PK_Fact_Consultation PRIMARY KEY (DateKey)
);
GO
