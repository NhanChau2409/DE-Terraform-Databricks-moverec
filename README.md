# Movie Status Tracking and Ranking IaC Project

## Description

This project is designed to efficiently store and manage the status of movies, including ratings, votes, and popularity.
The solution leverages a robust tech stack, integrating Databricks for ETL pipeline development, Terraform for
infrastructure provisioning on the Azure cloud platform, and PowerBI for visualization.

## Run

Follow instructions in `terraform` folder [README.md](./terraform/README.md)

## High level Architecture
![high_level_workflow](https://github.com/NhanChau2409/movrec/assets/116027999/e1c022fb-4d8c-4b12-a979-84df6bbcde49)

- **Daily & Weekly Data Fetch**:
    - Fetch raw data from TMDB API.
    - Store the data in Azure Data Lake Storage (ADLS) Gen 2.

- **Monthly ETL Process**:
    - Move data from ADLS Gen 2 to Databricks Delta Lake.
    - Transform, denormalize, and structure the data.

- **Weekly Report Generation**:
    - Utilize PowerBI to create reports based on the data in Databricks Delta Lake.

- **Automated Infrastructure Setup**:
    - Terraform is used for automatic setup of infrastructure.
    - Job schedules are configured as part of the automated setup.

## Details

Follow instructions in `databricks` folder [README.md](./databricks/README.md)

- Architecture structure
- Code under the hood

Follow instructions in `terraform` folder [README.md](./terraform/README.md)

- Implementation of infrastructure as code.
- Utilization of specified services.

## Lessons Learned

- First-time use of **_Terraform_** for infrastructure setup
- Implementation of **_Star Schema design_** for the database
- Utilization of **_PowerBI_** for visualization
- Leveraging Delta Lake in Databricks for a lakehouse and implementing **_Medallion Architecture_**
- Apply **_job scheduling_** in Databricks
