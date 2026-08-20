# Rotten Tomatoes — Movie Ratings Analysis

**Notebook:** [`Movie Ratings Analysis.ipynb`](./Movie%20Ratings%20Analysis.ipynb)
**Tools:** Python · pandas · NumPy

## Objective

Clean and explore a large Rotten Tomatoes movie dataset to understand how critic scores
(Tomatometer), audience scores, genre, studio, and MPAA rating relate to one another, producing
an analysis-ready dataset for further reporting.

## Dataset

`Rotten Tomatoes Movies.csv` — 16,600+ movies with:

| Field | Description |
|---|---|
| `movie_title`, `movie_info`, `critics_consensus` | Descriptive fields |
| `rating` | MPAA rating (G, PG, PG-13, R, NR, …) |
| `genre`, `directors`, `writers`, `cast`, `studio_name` | Production metadata |
| `in_theaters_date`, `on_streaming_date`, `runtime_in_minutes` | Release info |
| `tomatometer_status`, `tomatometer_rating`, `tomatometer_count` | Critic scores |
| `audience_rating`, `audience_count` | Audience scores |

## Approach

1. **Data quality audit** — profiled null counts across all columns (`critics_consensus` and
   `writers` had the most missing data) and inspected inconsistent category labels.
2. **Cleaning** — dropped rows missing core descriptive fields (`movie_info`,
   `critics_consensus`), backfilled missing `genre` values with an explicit `"Unknown Genre"`
   category, and corrected malformed MPAA rating labels (e.g. `"PG-13)"` → `"PG-13"`,
   `"R)"` → `"R"`) caused by upstream data-entry errors.
3. **Exploratory analysis** — examined the distribution of MPAA ratings, critic vs. audience
   scoring patterns, and genre/studio breakdowns across the cleaned dataset.

## Skills Demonstrated

Data quality auditing, handling missing data, category normalization / fixing dirty categorical
labels, and exploratory analysis with pandas.
