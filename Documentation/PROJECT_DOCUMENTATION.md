# NHS Hospital Activity Dashboard — Project Documentation

**Type:** Personal portfolio project
**Status:** In progress (see Phase Status below)
**Last updated:** July 2026

---

## 1. Overview

This project analyses 18 years of NHS England hospital activity data (April
2007 – March 2025) — outpatient appointments, attendance/DNA rates, and
inpatient admissions — using a SQL Server database and a Power BI dashboard.

It was built as a self-directed learning project to move beyond basic Excel
work into structured data analysis: relational database design, SQL, and
BI visualisation, using real, publicly available NHS statistics.

**Data source:** NHS England open data (Hospital Episode Statistics /
Consultation activity), monthly national totals.

---

## 2. Objective

To take a raw, messily-formatted public dataset and turn it into a
trustworthy, decision-ready dashboard — practicing the full pipeline:
clean → structure → validate → analyse → visualise, rather than just
producing charts from whatever the source file happened to contain.

---

## 3. Technologies & Skills Used

| Area | Tools / Skills |
|---|---|
| Data cleaning | Python (pandas) |
| Database | Microsoft SQL Server (SSMS), T-SQL |
| Data modelling | Star schema design (fact/dimension tables) |
| Analysis | SQL (CTEs, window functions, aggregation, joins) |
| Visualisation | Power BI Desktop, DAX (measures) |
| Version control | Git / GitHub |
| Working practice | Data validation, documentation, reproducible scripts |

---

## 4. Project Phases

### Phase 1 — Data Preparation & Database Design ✅ Complete

- Sourced raw monthly NHS activity data (`Consultation.csv`, 216 rows,
  April 2007–March 2025).
- Identified that the raw month field (`CALENDAR_MONTH_END_DATE`, e.g.
  `"Mar-25"`) was stored as text, which would break date sorting/filtering
  in SQL and Power BI.
- Wrote a Python (pandas) script to parse this into a proper date and
  split the source into two tables suited to a star schema:
  - `Dim_Date` — one row per month, with year, quarter, month name, and
    **financial year** pre-calculated.
  - `Fact_Consultation` — the numeric activity measures, keyed to `Dim_Date`
    via a `DateKey` surrogate key.

**Design decision — star schema over a single flat table:**
A single wide table would have worked for this dataset's size, but a
fact/dimension split was used deliberately as good practice: it keeps
date logic (financial year, quarter, etc.) in one place rather than
recalculated in every query, and it mirrors how real BI/data warehouse
projects are structured, which is the pattern Power BI itself expects
for clean relationships.

### Phase 2 — SQL Database Build & Analysis ✅ Complete

- Created the database and both tables in SQL Server with explicit,
  appropriate data types (e.g. `DECIMAL` for percentages rather than
  `FLOAT`, to avoid floating-point rounding issues in reporting figures).
- Imported and validated the data (row counts checked against source:
  216/216 in both tables; join integrity confirmed).
- Wrote 12 analysis queries covering monthly trends, year-on-year growth,
  attendance/DNA rates, admissions, and procedures performed.

**Key decision — calendar year vs. financial year:**
Initial year-on-year growth queries (grouped by calendar year) produced a
misleading -74% "collapse" in the final year of the dataset. Investigation
showed this wasn't a real trend — the dataset ends in March, so the final
calendar year only contained 3 months of data being compared against full
12-month years elsewhere.

Rather than just excluding the incomplete period, the queries were
redesigned to group by **NHS financial year (April–March)** instead —
which is also the reporting convention NHS England itself uses. Because
the dataset happens to run from April 2007 to March 2025, this change
made every period in the dataset a complete financial year (18 in total),
removing the distortion entirely rather than just hiding it. This was a
deliberate correction made after reviewing query output, not caught in
advance — a genuine example of validating results rather than assuming
they're right.

### Phase 3 — Power BI Dashboard ✅ Complete

- Connected Power BI Desktop to the SQL Server database (Import mode),
  with the `DateKey` relationship between `Dim_Date` and `Fact_Consultation`
  confirmed in the model view.
- **All 4 pages built:** Executive Summary, Outpatient Performance,
  Inpatient Activity, and Trends & COVID Impact.

**Key decision — weighted averages via DAX measures instead of default
aggregation:**
Dragging percentage columns (e.g. `Outpatient_Percent_DNA`) into a visual
with default "Sum" or simple "Average" aggregation produces misleading
figures — summing percentages is meaningless, and a simple average of
monthly percentages doesn't account for months having different appointment
volumes. Custom DAX measures were written instead, e.g.:

```dax
Avg DNA % (Weighted) =
DIVIDE(
    SUM(Fact_Consultation[Outpatient_DNA_Appointment]),
    SUM(Fact_Consultation[Outpatient_Total_Appointments])
)
```

This recalculates the rate from the underlying totals, giving a figure
that's actually correct regardless of how the data is filtered or sliced —
a foundational Power BI/DAX concept (measures vs. columns) applied
correctly rather than just visually.

### Phase 4 — Publishing & Documentation ⬜ Not Started

- Push project (SQL scripts, Python script, documentation, `.pbix` file)
  to GitHub as a public portfolio repository.
- Add dashboard screenshots and a short "Key Findings" write-up to the
  repository README, using real figures pulled from the SQL analysis
  (e.g. quantified COVID-19 impact on activity, and recovery timeline).
- Final proofread of documentation and repository structure.

### Phase 5 — Future Work (Planned, Not Started) ⬜

Three further datasets were sourced alongside this one, intended as
follow-on projects reusing the same skills:

- **Project 2 — NHS Workforce Analytics**, using `NHS_Workforce.xlsx`.
- **Project 3 — NHS Emergency Care Dashboard**, using `AE_Activity.xlsx`
  and `AE_Quality_Index.xlsx`.
- **Project 4 (flagship) — NHS Demand vs. Capacity Dashboard**, combining
  this project's outpatient/inpatient activity data with workforce and
  A&E data, to explore whether hospital activity has grown faster than
  staffing capacity over the same period.

These are scoped but not yet started, and depend on completing Phases
3–4 of this project first.

---

## 5. Key Findings

- **COVID-19 impact:** outpatient appointments fell 18.4% in FY2020/21 vs
  FY2019/20 (124,927,782 → 101,898,658); finished admission episodes fell
  more sharply, by 25.5% (17,202,558 → 12,813,120) — likely reflecting
  that elective/planned admissions were cancelled more aggressively than
  outpatient care, some of which shifted to remote consultation instead.
- **Recovery:** activity did not return to pre-pandemic volume until
  FY2023/24, which finished 8.4% above FY2019/20 levels. FY2022/23 was
  essentially flat with pre-pandemic volume (99.6%), showing the recovery
  was gradual rather than immediate.
- **DNA (missed appointment) rate:** fell steadily from ~8.4% (FY2007/08)
  to ~5.6% (FY2024/25) — an 18-year improvement trend — with a temporary
  additional dip during the COVID period before resuming its downward path.
- **Follow-up vs. first attendances:** follow-up attendances consistently
  exceed first attendances across all 18 years, consistent with NHS
  outpatient activity being dominated by ongoing management of long-term
  conditions rather than one-off consultations.
- **Hypothesis tested and not confirmed:** expected Day Case episodes to
  overtake Ordinary (overnight) episodes over time, reflecting the known
  NHS-wide shift toward same-day procedures. The data did not support
  this — Ordinary episodes remained consistently higher across the full
  period. Documented as an open question rather than forced to fit the
  expected narrative.

Full reasoning behind each finding, including dead ends and corrected
assumptions, is in [`Insights_Log.md`](Insights_Log.md).

---

## 6. Notes for Future Reference

- All yearly analysis in this project uses **NHS financial year**, not
  calendar year — see Phase 2 decision above for why.
- The full SQL scripts, Python cleaning script, and query set are version
  controlled and reproducible from raw data — see project `README.md`
  for setup steps.
