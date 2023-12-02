# Analysis of Trending Movies

## Description

This project focuses on storing the status (rating, votes, popularity) of movies, ranking them, and generating weekly
reports. The solution utilizes Databricks for building the ETL pipeline, Terraform for infrastructure setup on the Azure
cloud platform, and PowerBI for visualization.

## High level Architecture

![high_level_workflow](./img/high_level_workflow.png)

- **Daily Data Fetch**:
    - Fetch raw data from TMDB API.
    - Store the data in Azure Data Lake Storage (ADLS) Gen 2.

- **Weekly ETL Process**:
    - Move data from ADLS Gen 2 to Databricks Delta Lake.
    - Transform, denormalize, and structure the data.

- **Weekly Report Generation**:
    - Utilize PowerBI to create reports based on the data in Databricks Delta Lake.

- **Automated Infrastructure Setup**:
    - Terraform is used for automatic setup of infrastructure.
    - Job schedules are configured as part of the automated setup.

## Lessons Learned

- First-time use of Terraform for infrastructure setup
- Implementation of Star Schema design for the database
- Utilization of PowerBI for visualization
- Leveraging Delta Lake in Databricks for a lakehouse and implementing Medallion Architecture
- Polishing job scheduling in Databricks