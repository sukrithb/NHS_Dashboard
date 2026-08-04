"""
NHS Hospital Activity Dashboard
Step 1: Clean the raw Consultation.csv and produce two import-ready files:
    - Dim_Date.csv
    - Fact_Consultation.csv

Run this once on your home PC (or wherever you keep the raw data):
    python 01_clean_and_prepare_data.py

Input : ../Data/Consultation.csv   (raw file, as downloaded from NHS Digital / NHS England)
Output: ../Data/Dim_Date.csv
        ../Data/Fact_Consultation.csv
"""

import pandas as pd
import os

RAW_PATH = os.path.join("..", "Data", "Consultation.csv")
OUT_DIM_DATE = os.path.join("..", "Data", "Dim_Date.csv")
OUT_FACT = os.path.join("..", "Data", "Fact_Consultation.csv")

def main():
    df = pd.read_csv(RAW_PATH)

    # --- Parse the month column, e.g. "Mar-25" -> 2025-03-31 ---
    df["MonthEndDate"] = pd.to_datetime(df["CALENDAR_MONTH_END_DATE"], format="%b-%y")
    df["MonthEndDate"] = df["MonthEndDate"] + pd.offsets.MonthEnd(0)

    # Surrogate key for joining fact <-> date, format YYYYMM (e.g. 202503)
    df["DateKey"] = df["MonthEndDate"].dt.year * 100 + df["MonthEndDate"].dt.month

    # --- Build Dim_Date (one row per distinct month) ---
    dim_date = df[["DateKey", "MonthEndDate"]].drop_duplicates().sort_values("DateKey")
    dim_date["Year"] = dim_date["MonthEndDate"].dt.year
    dim_date["Month"] = dim_date["MonthEndDate"].dt.month
    dim_date["MonthName"] = dim_date["MonthEndDate"].dt.strftime("%B")
    dim_date["Quarter"] = dim_date["MonthEndDate"].dt.quarter
    dim_date["FinancialYear"] = dim_date.apply(
        lambda r: f"{r['Year']}/{str(r['Year'] + 1)[-2:]}" if r["Month"] >= 4
        else f"{r['Year'] - 1}/{str(r['Year'])[-2:]}",
        axis=1,
    )
    dim_date["MonthEndDate"] = dim_date["MonthEndDate"].dt.strftime("%Y-%m-%d")

    # --- Build Fact_Consultation (drop the original text month column) ---
    fact = df.drop(columns=["CALENDAR_MONTH_END_DATE", "MonthEndDate"])
    # put DateKey first
    cols = ["DateKey"] + [c for c in fact.columns if c != "DateKey"]
    fact = fact[cols]

    dim_date.to_csv(OUT_DIM_DATE, index=False)
    fact.to_csv(OUT_FACT, index=False)

    print(f"Wrote {len(dim_date)} rows to {OUT_DIM_DATE}")
    print(f"Wrote {len(fact)} rows to {OUT_FACT}")
    print("\nNext step: run SQL/02_create_tables.sql then SQL/03_import_data.sql in SSMS.")

if __name__ == "__main__":
    main()
