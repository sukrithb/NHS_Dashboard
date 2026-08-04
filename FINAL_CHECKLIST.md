# Final Checklist — Before Publishing to GitHub

## Power BI
- [ ] Executive Summary page built (first page, 4 cards + 1 trend chart)
- [ ] All 4 cards filtered to FinancialYear = 2024/25
- [ ] Executive Summary page moved to the FRONT of the page tab order
- [ ] "Page 1" renamed to "Outpatient Performance"
- [ ] All 4 pages double-checked: axis sorted by FinancialYear ascending, no truncated labels, no scrollbars
- [ ] .pbix file saved locally into the `PowerBI/` folder of the project

## Screenshots
- [ ] Screenshot of Executive Summary page → save as `Screenshots/01_executive_summary.png`
- [ ] Screenshot of Outpatient Performance page → save as `Screenshots/02_outpatient_performance.png`
- [ ] Screenshot of Inpatient Activity page → save as `Screenshots/03_inpatient_activity.png`
- [ ] Screenshot of Trends & COVID Impact page → save as `Screenshots/04_trends_covid_impact.png`
- [ ] Add these 4 images to the README under "📷 Screenshots" section, replacing the placeholder text

## Documentation
- [ ] Update PROJECT_DOCUMENTATION.md / .docx status from "In Progress" → "Complete" (Phase 3)
- [ ] Update Phase 4 status to "In Progress" once you start the GitHub push
- [ ] Final read-through of README.md for accuracy

## GitHub
- [ ] Create a new repository on GitHub (public, so it's visible as a portfolio piece)
- [ ] Confirm `.gitignore` excludes `Data/*.csv` and `Data/*.xlsx` — raw/cleaned data is NOT published, only the schema/scripts/docs (already configured)
- [ ] In the project folder: `git init`
- [ ] `git add .`
- [ ] `git commit -m "Initial commit: NHS Hospital Activity Dashboard - complete"`
- [ ] `git remote add origin <your-repo-url>`
- [ ] `git push -u origin main`
- [ ] Confirm README renders correctly on the GitHub repo page (check formatting, images load)

## Optional polish (not required, do later if time allows)
- [ ] Fold 2-3 strongest Insights Log entries directly into PROJECT_DOCUMENTATION.md's "Key Findings" section
- [ ] Add repo description + topics/tags on GitHub (e.g. `sql`, `power-bi`, `nhs`, `data-analytics`, `portfolio`)
- [ ] Investigate the Day Case vs Ordinary % share question left open in Insights Log entry #5
