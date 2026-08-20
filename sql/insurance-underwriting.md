# Insurance Underwriting Risk Score

**Query:** [`Insurance Underwriting.sql`](./Insurance%20Underwriting.sql)
**Tools:** SQL (CTEs, window functions)

## Objective

Build a standardized, explainable risk score for insurance applicants, to support
underwriting decisions on whether an applicant should be approved.

## Approach

The query derives a **weighted risk score (0–100)** from six underwriting factors, using a
common normalize-and-combine pattern:

1. **Per-factor approval rate** — for each factor (region, subscription length, customer age,
   vehicle age, customer segment, and safety features), compute the historical claim-approval
   rate, bucketing continuous values into ranges (e.g. `customer_age` into `Under 25`, `25-35`,
   … `65+`) with `CASE` expressions.
2. **Min–max normalization** — scale each factor's approval rate to a common 0–100 range using
   `MIN()`/`MAX()` window functions, so factors with different natural scales become comparable.
3. **Weighted composite score** — combine the six normalized factor scores into a single
   `final_risk_score`, weighted by business importance (region, subscription length, and age each
   25%; vehicle age 15%; segment and safety features 5% each).
4. **Risk tiering** — bucket the final score into underwriting-friendly tiers: `A-Level Low Risk`,
   `B-Level Medium Risk`, `C-Level High Risk`.

## SQL Techniques Demonstrated

- Multiple chained CTEs for a multi-stage transformation pipeline
- Window functions (`MIN() OVER()`, `MAX() OVER()`) for normalization
- Conditional aggregation with `FILTER` and `CASE`
- Bucketing continuous variables into categorical ranges
- Multiple `LEFT JOIN`s to recombine per-factor scores onto the base table
- Business-weighted scoring logic translated directly into SQL

## Business Value

Produces a single, auditable risk score and tier per policy that underwriters can use directly
in approval workflows, instead of manually cross-referencing six separate risk factors.
