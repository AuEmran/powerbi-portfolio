# Business Risk Mapping — Bushfire & Flood Prone Businesses (ABN)

## Overview
A Power BI dashboard that maps registered NSW businesses (by ABN) located in bushfire-prone and flood-prone areas, filterable by Local Government Area (LGA) and industry classification, to support risk-based planning and outreach.

## Business Problem
Emergency planning and business-support teams need to know how many, and which, registered businesses sit within known bushfire- or flood-risk zones — information that only becomes actionable once ABN business registration data is combined with official hazard mapping (Local Environmental Plan flood layers, bushfire-prone land mapping) at the LGA level.

## Objectives
- Identify the number and location of businesses in bushfire-prone and flood-prone areas.
- Allow filtering by LGA, industry division, industry class, and entity sub-type.
- Express risk exposure as a percentage of the total registered business population.

## Key KPIs
- Bushfire-prone business count and % of total business
- Flood-prone business count and % of total business
- Total registered business number (filtered)

## Dashboard Features
- Two map pages: "Bushfire Prone Businesses" and "Flood Prone Businesses," each plotting affected businesses on a NSW map
- Slicers for LGA, industry division, industry class, and entity sub-type
- KPI cards for affected business count, % of total, and total business number
- Map style toggle (road / hybrid satellite view)

## Data Model
- **Businesses** (fact): ABN (masked/synthetic), LGA, industry division, industry class, entity sub-type, latitude/longitude
- **HazardZones** (dimension): zone type (bushfire-prone / flood-prone), LGA, geographic boundary (from LEP flood mapping and bushfire-prone land data)
- **IndustryClassification** (dimension): industry division, class, sub-type

Relationships: `Businesses[LGA]` → `HazardZones[LGA]` (many-to-one), `Businesses[Industry]` → `IndustryClassification[Industry]` (many-to-one). Businesses are flagged as bushfire- or flood-prone via a spatial join against the hazard boundary layers.

## Data Preparation
Power Query steps documented in [`/power-query/business-risk-mapping.m`](../../power-query/business-risk-mapping.m):
- Standardised ABN business register fields (industry division/class/sub-type) to a consistent classification
- Performed a spatial match of business location against bushfire-prone land and Local Environmental Plan (LEP) flood-zone layers
- Calculated % of total business population per LGA for each hazard type

## DAX
Key measures documented in [`/dax/business-risk-mapping.dax`](../../dax/business-risk-mapping.dax):
- `Bushfire Prone Business Count`
- `Flood Prone Business Count`
- `% Bushfire Prone Business`
- `% Flood Prone Business`
- `Total Business Number`

## Dashboard Screenshots
![Bushfire Prone Businesses](../../screenshots/bushfire-prone-businesses-map.png)
![Flood Prone Businesses](../../screenshots/flood-prone-businesses-map.png)

## Insights
The dashboard lets planning teams filter down to a specific LGA or industry and immediately see how exposed the local business population is to bushfire or flood risk — supporting targeted resilience communications or support programs rather than a blanket, state-wide approach.

## Skills Demonstrated
- Power BI dashboard design (geospatial mapping)
- DAX measure development
- Power Query (M) data transformation
- Working with geospatial/hazard-layer data (LEP flood, bushfire-prone land)
- Industry classification analysis
- Business/risk analysis

## Files
- `README.md` — this file
- `../../datasets/synthetic/business_risk_mapping_synthetic.csv` — synthetic ABN business/hazard register
- `../../dax/business-risk-mapping.dax` — DAX measures
- `../../power-query/business-risk-mapping.m` — Power Query steps
- `../../screenshots/` — dashboard screenshots

## Portfolio Disclaimer
This project is based on a real business risk-mapping dashboard combining ABN business registration data with official NSW bushfire-prone land and flood-zone mapping. The screenshots above show map-level, non-identifying business counts only, and the CSV in this repository is **entirely synthetic** — fictional ABNs and business locations — preserving the data model and spatial-analysis logic without exposing any real business register data.
