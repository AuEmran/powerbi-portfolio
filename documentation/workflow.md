# Standard Project Workflow

Every dashboard in this portfolio follows the same end-to-end BI workflow:

```
Raw Data → Data Cleaning (Power Query) → Data Model (star schema) → DAX Measures → Visualisation (Power BI) → Business Insights
```

1. **Raw Data** — source exports (asset registers, billing files, case logs, ABN business register, hazard-layer shapefiles).
2. **Data Cleaning** — Power Query steps standardise field formats, merge reference tables, and remove duplicates/nulls (see `/power-query`).
3. **Data Model** — fact tables and dimension tables are related in a star schema for efficient filtering and aggregation.
4. **DAX Measures** — KPI logic is built as reusable measures rather than calculated columns where possible (see `/dax`).
5. **Visualisation** — Power BI report pages combine maps, KPI cards, trend charts, and slicers for self-service exploration.
6. **Business Insights** — each dashboard's README documents what decisions the dashboard is designed to support.

