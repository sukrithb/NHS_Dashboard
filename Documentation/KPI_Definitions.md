# KPI Definitions — NHS Hospital Activity Dashboard

> **Note on time periods:** all year-level analysis in this project uses NHS
> **financial year** (April–March), not calendar year — this matches how
> NHS England reports its own statistics. The dataset runs exactly from
> April 2007 to March 2025, so it covers 18 complete financial years
> (FY2007/08 – FY2024/25) with no partial years. Monthly-level views
> (e.g. Query_01, Query_02, Query_04, Query_10) still use calendar dates
> since financial year only matters once you start aggregating to yearly totals.

## Page 1 — Executive Summary

| KPI | Source Column | Definition |
|---|---|---|
| Total Appointments | Outpatient_Total_Appointments | Total outpatient appointments scheduled in the period |
| Attended Appointments | Outpatient_Attended_Appointments | Appointments the patient actually attended |
| DNA Count | Outpatient_DNA_Appointment | Appointments where patient did not attend |
| DNA % | Outpatient_Percent_DNA | DNA Count ÷ Total Appointments |
| Emergency Admissions | APC_Emergency | Unplanned/emergency hospital admissions |
| Finished Admission Episodes | APC_Finished_Admission_Episodes | Completed inpatient episodes (ordinary + day case) |

## Page 2 — Outpatient Performance
- Monthly Appointments Trend → `Outpatient_Total_Appointments` over `MonthEndDate`
- Attendance % → `Outpatient_Percent_Attended` over `MonthEndDate`
- DNA % → `Outpatient_Percent_DNA` over `MonthEndDate`
- Follow-up Attendance Trend → `Outpatient_Attendance_Type_2` over `MonthEndDate`

## Page 3 — Inpatient Activity
- Finished Consultant Episodes → `APC_Finished_Consultant`
- Procedures Performed → `APC_FCEs_with_a_procedure`
- Day Cases → `APC_Day_Case_Episodes`
- Emergency Admissions → `APC_Emergency`

## Page 4 — Trends Dashboard
- FY2007/08–FY2024/25 Activity Trend → `Outpatient_Total_Appointments` by FinancialYear
- COVID Impact → FY2019/20 vs FY2020/21 comparison (see Query_09)
- Recovery Trend → 2021 onwards, monthly (see Query_10)
