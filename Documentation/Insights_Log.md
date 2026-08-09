# Data Insights & Understanding Log

A running record of questions raised while working with this dataset,
what was found, and why it matters. Kept separate from the main project
documentation because this is the part that actually demonstrates data
understanding, not just execution — worth reviewing before an interview.

**How to use this:** every time something in the data looks odd, doesn't
match intuition, or raises a "wait, why is that?" moment — write it down
here before moving on, even if the answer turns out to be simple. The
question itself is the evidence of thinking critically about the data.

---

### 1. Calendar year vs. financial year distorted year-on-year growth

**Observation:** Year-on-year growth queries showed a -74% "collapse" in
the final year of the dataset.

**Finding:** The dataset ends in March 2025, so grouping by calendar year
compared 3 months of data (Jan–Mar 2025) against full 12-month years. Not
a real trend — a period-boundary artifact.

**Fix applied:** Switched all yearly aggregations to NHS financial year
(April–March), which also matches NHS England's own reporting convention.
The dataset happens to align exactly to 18 complete financial years, so
this fully resolved the issue rather than just excluding bad data.

**Why it matters:** Shows the difference between a chart that runs
without errors and a chart that's actually correct — and the value of
checking results against domain context (how NHS itself reports), not
just technical correctness.

---

### 2. Why are "Follow-up" attendances higher than "First" attendances?

**Observation:** `Outpatient_Attendance_Type_2` (follow-up) consistently
exceeds `Outpatient_Attendance_Type_1` (first attendance) across the
whole 18-year period. Intuitively this seemed backwards.

**Finding:** Per the NHS Data Dictionary, a "first attendance" is the
first appointment in a referral series; every subsequent appointment on
that same referral is a "follow-up," and there's no limit on how many
follow-ups one referral can generate. A single first attendance for a
long-term condition (e.g. diabetes, cardiology) can generate many
follow-up visits over months or years, so follow-ups outnumbering first
attendances is normal, not an error.

**Why it matters:** A candidate insight for the dashboard: the
follow-up-to-first ratio is a rough proxy for how much of NHS outpatient
capacity is consumed by ongoing/long-term condition management versus
new referrals — worth quantifying once Page 2 is finalised.

---

### 3. Can distinct patient counts be derived from this dataset?

**Observation:** Considered querying for the number of distinct patients
represented in the data.

**Finding:** Not possible with this dataset. `Consultation.csv` contains
pre-aggregated monthly national totals (e.g. "12,112,439 appointments in
March 2025") with no patient-level identifier — NHS England published it
already summed, and patient-level HES data requires separate, restricted
access for privacy reasons. A total cannot be reverse-engineered into
distinct individuals.

**Why it matters — important caveat for the whole project:** every
"appointments" figure in this dashboard represents appointment *volume*,
not the number of *people* seen — the same patient can be counted many
times (e.g. a patient with 4 follow-ups appears 4 times, not once).
This should be stated explicitly wherever appointment totals are shown,
to avoid the figures being misread as patient counts.

---

### 4. DNA % has fallen steadily over 18 years, with a sharp COVID-era dip

**Observation:** Built a "DNA % by Financial Year" trend chart (using the
weighted `Avg DNA % (Weighted)` measure) to replace the earlier single-value
card, since a static number hides whether the metric is improving or
worsening over time.

**Finding:** DNA % has declined almost continuously since FY2007/08
(~8.4%) down to roughly 5.5–6% in recent years — an 18-year improvement
trend, not a flat metric. There's also a sharp additional dip around
FY2020/21 (COVID), followed by a partial rebound in FY2021/22–2022/23,
before the underlying downward trend resumes.

**Why the COVID dip happened (not obvious at first):** intuitively you
might expect missed appointments to rise during a crisis, but the opposite
happened. Likely drivers: (1) a large share of routine/non-urgent
outpatient activity was cancelled or converted to remote appointments
during COVID, reducing the pool of appointments that could be missed, and
(2) patients who did have a scheduled appointment during that period were
often more anxious not to miss it, given reduced access to care generally.

---

### 5. Day Case episodes have NOT overtaken Ordinary episodes (hypothesis rejected)

**Observation:** Before building the "Day Case vs Ordinary Episodes"
chart, expected that day case (same-day) episodes might have overtaken
ordinary (overnight) episodes at some point over the 18-year period —
this is a widely discussed NHS-wide shift toward same-day procedures.

**Finding:** The actual chart shows Ordinary Episodes consistently higher
than Day Case Episodes across the entire FY2007/08–FY2024/25 range, with
both growing at roughly similar rates. No crossover occurs in this
dataset.

**Why it matters:** A useful reminder to check assumptions against the
actual chart rather than assuming a well-known national trend will show
up in every dataset/metric. Possible explanations worth exploring later:
this may be specific to how "Ordinary" vs "Day Case" is defined in this
particular data collection, or the shift toward day case care may show up
more clearly as a % share of total episodes rather than in absolute
volumes (both are growing, so day case's *share* of the total could still
be rising even while remaining below ordinary in raw numbers) — worth a
follow-up query if time allows, rather than stating the original
hypothesis as fact. **(See entry 7 for the resolution — the share
framing was confirmed.)**

---

### 6. COVID-19 impact and recovery — final quantified figures

**Query used:** Query_09 (COVID impact FY2019/20 vs FY2020/21) and Query_10
(recovery trend), cross-checked by summing Query_10's monthly output into
financial years.

**Finding:**
- Outpatient appointments fell **18.4%** in FY2020/21 vs FY2019/20
  (124,927,782 → 101,898,658).
- Finished Admission Episodes fell **25.5%** over the same period
  (17,202,558 → 12,813,120) — a noticeably larger drop than outpatient
  appointments.
- Recovery was not immediate: FY2021/22 remained ~2% below FY2019/20,
  FY2022/23 was effectively flat (~99.6% of FY2019/20), and full recovery
  only occurred in **FY2023/24**, which ended 8.4% above FY2019/20 volume.

**Why it matters:** The gap between the outpatient drop (18.4%) and the
inpatient admissions drop (25.5%) likely reflects that elective/planned
admissions were more aggressively cancelled to preserve bed capacity
during COVID, whereas some outpatient activity could continue via
phone/video consultation rather than being cancelled outright. This is
the headline number for the project — used directly in the Page 4 text
box and the README Key Findings section.

---

### 7. Day Case share of total episodes HAS risen steadily (resolves the open question from #5)

**Query used:** `Query_13_day_case_percentage_share.sql`, the follow-up
scoped in entry #5.

**Finding:** While Day Case episodes never overtook Ordinary episodes in
absolute volume (confirmed in #5), Day Case's **share** of total
episodes has risen steadily and substantially: from **31.0%** in
FY2007/08 to **38.4%** in FY2024/25 — an 18-year upward trend, consistent
with the well-documented NHS-wide shift toward same-day procedures. The
familiar COVID pattern shows up here too: FY2020/21 is the low point of
the whole series (29.45%, the only year below FY2007/08's starting
level), followed by the fastest sustained growth in the dataset from
FY2022/23 onward, ending at the series' all-time high.

**Why it matters:** This is the correct resolution to the hypothesis
first raised in entry 5 — the original framing (does Day Case overtake
Ordinary in raw numbers) was genuinely wrong, but the refined framing
(is Day Case's share of the total rising) is genuinely right. Worth
keeping both entries rather than editing entry 5 to hide the initial
miss — the sequence (wrong framing → rejected → refined framing →
confirmed) is a more honest and more useful record than only showing
the final correct answer.

---

<!-- Add new entries below this line as they come up -->
