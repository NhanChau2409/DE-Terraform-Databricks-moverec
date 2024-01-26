## Description

- This directory contains notebooks serving as source material for job scheduling.
- Below give visualization the architecture and workflow process

## Bronze layer

- Using Azure Datalake gen 2 storage
- Store raw data
- Organizing the data in a hierarchical structure with year, month, and filenames based on their respective dates.

## Silver layer

- Using Delta Lake in Databricks
- Apply Star Schema design
- Fact table:
    - `status_fact` table
- Dimension table:
    - `movies_dim`, `gernes_dim`, `movies_gernes`, `dates_dim` tables

## Improvement

- Enhance storage efficiency through the utilization of `Partition` and `Z-oder`
- Facilitate cross-workspace data sharing through the implementation of the `Unity Catalog`
- Ensure data integrity by addressing more nuanced scenarios
- Manage extensive datasets by leveraging the `Azure SQL Database` service
- Improve processing efficiency by handling metadata with greater specificity