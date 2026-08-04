# Data Folder

This folder is empty in the GitHub repository — the raw and cleaned data
files are intentionally **not published** here, since this is publicly
available, licensed open data and there's no need to re-host it in this repo.

## Data Source

**Dataset:** NHS Open Dataset: Hospital Episode Statistics
**Download:** https://www.kaggle.com/datasets/fungainicolechirombe/nhs-free-dataset-for-analysis
**Original source:** NHS Digital, Hospital Episode Statistics (HES) —
https://digital.nhs.uk/services/hospital-episode-statistics
**Licence:** Open Government Licence v3.0 —
https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/

This Kaggle dataset is a curated collection of NHS HES data covering
Admitted Patient Care (APC), Accident & Emergency (A&E), and Outpatients
data, plus supporting data (NHS Trust performance ratings, staff numbers,
and financial data). This project uses the **Consultation** activity
extract from that collection.

## How to get the data yourself

1. Download the dataset from the Kaggle link above (free Kaggle account
   required to download).
2. Locate the consultation/outpatient activity file within the download
   and save it into this folder as `Consultation.csv`.
3. Run the cleaning script from the project root:
   ```
   cd Scripts
   python 01_clean_and_prepare_data.py
   ```
   This generates `Dim_Date.csv` and `Fact_Consultation.csv` in this same
   folder, ready to import using the scripts in `SQL/`.

## Why the data isn't committed to this repo

- It's freely available under OGL v3.0 from the source above, so
  re-publishing it here adds no value and risks going stale if the
  source is updated or corrected.
- Keeps the repository focused on the actual work — the cleaning script,
  database design, SQL queries, and dashboard — rather than data files.
- Good general practice: raw/derived data generally shouldn't live in
  version control alongside code, especially for larger datasets.

See [`../Documentation/Data_Dictionary.md`](../Documentation/Data_Dictionary.md)
for the full column-by-column schema of what the data contains, without
needing the actual file.
