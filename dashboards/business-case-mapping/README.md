# Business Case & Mediation Mapping (LGA)

## Overview
A Power BI dashboard that maps case and mediation-application volumes across NSW Local Government Areas (LGAs), benchmarked against the total number of registered businesses in each area, to help identify where regulatory/support demand is concentrated.

## Business Problem
Case and mediation-application data arrives at a postcode/business level, but stakeholders need to understand demand geographically — by LGA — and relative to how many businesses actually operate there, not just raw case counts.

## Objectives
- Visualise case and mediation-application volumes on a choropleth map by LGA.
- Benchmark case volume against total business population per LGA (cases as a % of total business).
- Track case and mediation-application trends over time.
- Allow filtering by LGA, industry, and date range.

## Key KPIs
- Case count by LGA
- Mediation application count by LGA
- % of cases relative to total business population
- Monthly case/mediation trend

## Dashboard Features
- Choropleth map of NSW coloured by case-count band, filterable by LGA, industry, and date range
- Trend line of case/mediation numbers over time
- Ranked table of LGAs by case count, total business count, and % of business affected
- Two report pages: "CX Case Numbers by LGA" and "Mediation Applications by LGA," sharing the same postcode-to-LGA data model

## Data Model
- **Cases** (fact): case ID, postcode, industry, date, case type (CX case / mediation application)
- **PostcodeToLGA** (bridge/dimension): postcode, LGA name — maps raw postcode data to the ABS LGA boundary used for the map
- **BusinessCounts** (dimension): LGA name, industry, total registered businesses
- **Date** (dimension): standard calendar table

Relationships: `Cases[Postcode]` → `PostcodeToLGA[Postcode]` (many-to-one), `PostcodeToLGA[LGA]` → `BusinessCounts[LGA]` (many-to-one), `Cases[Date]` → `Date[Date]`.

## Data Preparation
Power Query steps documented in [`/power-query/business-case-mapping.m`](../../power-query/business-case-mapping.m):
- Mapped raw postcodes to ABS LGA boundaries via a postcode-to-LGA reference table
- Standardised LGA names to match the ABS LGA shape file used by the map visual
- Aggregated case-level data to LGA/month grain for the trend visual

## DAX
Key measures documented in [`/dax/business-case-mapping.dax`](../../dax/business-case-mapping.dax):
- `Case Count`
- `Mediation Application Count`
- `% of Cases to Total Business`
- `Case Count (Rolling 12 Mth)`

## Dashboard Screenshots
![CX Case Numbers by LGA](../../screenshots/cx-case-numbers-by-lga.jpg)
![Mediation Applications by LGA](../../screenshots/mediation-applications-by-lga.jpg)

## Insights
The map view lets stakeholders immediately see which LGAs have disproportionately high case volume relative to their business population — useful for prioritising outreach, resourcing, or policy attention geographically rather than just by raw case count.

## Skills Demonstrated
- Power BI dashboard design (geospatial/choropleth mapping)
- DAX measure development
- Power Query (M) data transformation
- Postcode-to-LGA data modelling
- Trend analysis
- Business analysis

## Files
- `README.md` — this file
- `../../datasets/synthetic/business_case_synthetic.csv` — synthetic case/mediation register
- `../../datasets/synthetic/lga_business_counts_synthetic.csv` — synthetic LGA business population reference
- `../../dax/business-case-mapping.dax` — DAX measures
- `../../power-query/business-case-mapping.m` — Power Query steps
- `../../screenshots/` — dashboard screenshots

## Portfolio Disclaimer
This project is based on a real case/mediation-mapping dashboard built for a NSW Government regulatory body. Case counts and business numbers in the screenshots are obscured, and the CSV files in this repository are **entirely synthetic** — fictional case volumes and business counts — preserving the postcode-to-LGA data model and analytical logic without exposing any real case data.
