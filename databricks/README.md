## Data Workflow

1. Fetch raw data from TMDB API, updated daily
2. Parse data into CSV format and load it into Azure Data Lake Gen2, serving as the bronze/silver layer
3. Transform, denormalize, and structure data in Databricks Delta Lake, acting as the gold layer
4. Prepare data for report generation

## Ending Data Schema (Gold Table)
