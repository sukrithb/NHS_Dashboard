# Data Dictionary — NHS Hospital Activity Dashboard

Source file: `Consultation.csv` (NHS Hospital Episode Statistics / NHS England open data, monthly, 2007–2025)

| Column | Table | Type | Description |
|---|---|---|---|
| DateKey | Dim_Date, Fact_Consultation | INT | Surrogate key for the month, format YYYYMM (e.g. 202503 = March 2025). Used to join fact to date dimension. |
| MonthEndDate | Dim_Date | DATE | Last calendar day of the reporting month. |
| Year | Dim_Date | INT | Calendar year. |
| Month | Dim_Date | INT | Calendar month number (1–12). |
| MonthName | Dim_Date | VARCHAR | Full month name (e.g. "March"). |
| Quarter | Dim_Date | INT | Calendar quarter (1–4). |
| FinancialYear | Dim_Date | VARCHAR | NHS financial year (April–March), e.g. "2024/25". |
| APC_Finished_Consultant | Fact_Consultation | BIGINT | Finished Consultant Episodes (FCEs) — a completed period of care under one consultant. |
| APC_FCEs_with_a_procedure | Fact_Consultation | BIGINT | Number of FCEs that included at least one procedure. |
| APC_Percent_FCEs_with_procedure | Fact_Consultation | DECIMAL | % of FCEs that included a procedure. |
| APC_Ordinary_Episodes | Fact_Consultation | BIGINT | Episodes requiring an overnight stay. |
| APC_Day_Case_Episodes | Fact_Consultation | BIGINT | Episodes where the patient was admitted and discharged same day. |
| APC_Day_Case_Episodes_with_proc | Fact_Consultation | BIGINT | Day case episodes that included a procedure. |
| APC_Percent_Day_Cases_with_proc | Fact_Consultation | DECIMAL | % of day case episodes with a procedure. |
| APC_Finished_Admission_Episodes | Fact_Consultation | BIGINT | Total finished admission episodes (ordinary + day case). |
| APC_Emergency | Fact_Consultation | BIGINT | Emergency admissions in the month. |
| Outpatient_Total_Appointments | Fact_Consultation | BIGINT | Total outpatient appointments scheduled. |
| Outpatient_Attended_Appointments | Fact_Consultation | BIGINT | Appointments the patient attended. |
| Outpatient_Percent_Attended | Fact_Consultation | DECIMAL | % of appointments attended. |
| Outpatient_DNA_Appointment | Fact_Consultation | BIGINT | "Did Not Attend" appointments — patient didn't show and didn't cancel in advance. |
| Outpatient_Percent_DNA | Fact_Consultation | DECIMAL | % of appointments that were DNA. |
| Outpatient_Follow_Up_Attendance | Fact_Consultation | DECIMAL | Ratio/rate of follow-up attendances (see NHS England outpatient statistics notes for exact derivation). |
| Outpatient_Attendance_Type_1 | Fact_Consultation | BIGINT | First attendances (new referral). |
| Outpatient_Attendance_Type_2 | Fact_Consultation | BIGINT | Follow-up attendances. |

**Notes:**
- APC = Admitted Patient Care.
- FCE = Finished Consultant Episode.
- DNA = Did Not Attend.
- All figures are monthly national totals for NHS England (not broken down by trust in this dataset).
