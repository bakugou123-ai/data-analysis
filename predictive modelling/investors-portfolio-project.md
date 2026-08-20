# Unicorn Companies — Investor Portfolio Analysis

**Notebook:** [`Investors Portfolio project.ipynb`](./Investors%20Portfolio%20project.ipynb)
**Tools:** Python · pandas · NumPy · seaborn · matplotlib

## Objective

Analyze a global dataset of unicorn companies (private startups valued at $1B+) to build a
data-driven investor briefing: which industries are the most attractive to invest in, which
companies reached unicorn status the fastest, and how valuations/funding trends have shifted
over time — with visualizations suitable for a stakeholder report.

## Dataset

`Unicorn_Companies.csv` — 1,074 companies with:

| Field | Description |
|---|---|
| `Company` | Company name |
| `Valuation` | Valuation in USD (e.g. `$180B`) |
| `Date Joined` | Date the company reached unicorn status |
| `Industry` | Industry category |
| `City` / `Country/Region` / `Continent` | Headquarters location |
| `Year Founded` | Founding year |
| `Funding` | Total funding raised |
| `Select Investors` | Notable investors |

## Approach

1. **Data cleaning** — removed a corrupted record (`Yidian Zixun`), dropped rows with
   `Funding == 'Unknown'`, and converted `Valuation` from a formatted string (`"$180B"`) into a
   numeric column (`Valuation in $B`) for analysis.
2. **Exploratory analysis** — profiled company counts by founding year/decade, ranked companies
   by valuation, and grouped by industry and region to surface concentration patterns.
3. **Time-to-unicorn analysis** — computed how quickly companies reached unicorn status relative
   to their founding date to identify the fastest-growing companies and industries.
4. **Portfolio recommendation** — aggregated average valuation and funding by industry/time
   period to highlight which sectors show the strongest investment case.
5. **Visualization** — charted findings with seaborn/matplotlib for a stakeholder-facing summary.

## Key Questions Answered

- Which industries have historically produced the most (and the highest-valued) unicorns?
- Which companies reached a $1B valuation in the shortest time after founding?
- How do average valuation and funding compare across industries and time periods?

## Skills Demonstrated

Data cleaning & type coercion, exploratory data analysis, groupby aggregation, ranking/sorting,
and stakeholder-ready data visualization in pandas/seaborn.
