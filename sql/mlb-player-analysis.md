# MLB Player & Team Analytics

**Query:** [`MLB Player Analysis.sql`](./MLB%20Player%20Analysis.sql)
**Tools:** SQL (CTEs, window functions)

## Objective

A collection of front-office-style analytical queries over historical MLB player, school, and
salary data — covering player development pipelines, team spending trends, and player career
statistics.

## Questions Answered

- How many schools produced MLB players each decade, and which schools produced the most players
  overall (and per decade)?
- Which teams are in the top 20% by average annual spending?
- What is each team's cumulative spending over time, and in what year did each team's cumulative
  spending first cross $1 billion?
- For each player, what was their age at debut and at their final game, and how long was their
  career? Which team did they start and end on, and how many players spent 10+ years with the
  same team from debut to retirement?
- Do any players share the same birthday?
- What percentage of each team's players bat right-handed, left-handed, or switch-hit?
- How have average player height and weight at debut changed decade over decade?

## SQL Techniques Demonstrated

- CTEs chained into multi-step analytical pipelines
- Window functions: `DENSE_RANK()`, `NTILE()`, `LAG()`, and `SUM() OVER (PARTITION BY … ORDER BY …)`
  for running totals and cumulative spend
- Self-joins (matching players against each other to find shared birthdays)
- Conditional aggregation (`CASE` + `SUM`) to compute batting-handedness percentages per team
- Bucketing years into decades with `ROUND(year, -1)`
- Filtering ranked/windowed results down to "first occurrence" rows (e.g. first year crossing $1B)
