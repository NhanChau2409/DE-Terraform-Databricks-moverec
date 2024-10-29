# Movie Status Project

## Description

This project is designed to efficiently store and manage the status of movies, including ratings, votes, and popularity. The solution leverages a robust tech stack, integrating **Databricks** for ETL pipeline development, **Terraform** for infrastructure provisioning on the **Azure** cloud platform.
## Project Highlights

- **Fully Automated IaC**: Creates a comprehensive end-to-end data pipeline with only Azure credentials and **a single command**.

- **User Ratings Integration**: Incorporates ratings from anonymous users, enabling:

  - Advanced analytics for ranking movies.
  - Feeding into a machine **learning-based user recommendation model** to enhance user experience.

- **Efficient Data Architecture**: Implements a Medallion Architecture structured data flow, while utilizing **Star Schema** Data Modeling to optimize query performance.

- **Robust Databricks Solution**: Built to be idempotent and reliable, ensuring consistent execution of data workflows.

## High Level Architecture

![datapipeline](https://github.com/user-attachments/assets/8e7f662b-0d48-46a5-9ecd-88f34871ddc6)


## Terraform

### Requirements

- [Azure account](https://azure.microsoft.com/en-us/free/search/?ef_id=_k_Cj0KCQiAmNeqBhD4ARIsADsYfTfCVwwbCl8gclCJU6wI8QcFbJkw_wNu30TydWg2mhETRF7ycss2a68aAj-FEALw_wcB_k_&OCID=AIDcmmftanc7uz_SEM__k_Cj0KCQiAmNeqBhD4ARIsADsYfTfCVwwbCl8gclCJU6wI8QcFbJkw_wNu30TydWg2mhETRF7ycss2a68aAj-FEALw_wcB_k_&gad_source=1&gclid=Cj0KCQiAmNeqBhD4ARIsADsYfTfCVwwbCl8gclCJU6wI8QcFbJkw_wNu30TydWg2mhETRF7ycss2a68aAj-FEALw_wcB) to access and utilize Azure services.
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) installed on your local machine to define and manage infrastructure as code.
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) to authenticate and authorize Terraform to interact with Azure on your behalf.

### Run

1. Change to the [terraform folder](.):

   ```bash
   $ cd ./terraform
   ```

2. Login to Azure CLI:

   ```bash
   $ az login
   ```

3. Initialize and apply Terraform:

   ```bash
   $ terraform init
   $ terraform apply
   ```

### Structure

1. #### [providers.tf:](./providers.tf)
   - Contains all the necessary provider configurations for Azure and Databricks.
2. #### [main.tf:](./main.tf)
   - Defines the creation of an **Azure resource group** and establishes a **service principal** for `Databricks`.
3. #### [adls_gen2.tf:](adls_gen2.tf)
   - Specifies the creation of a **storage account** for `Azure Data Lake Storage` (ADLS) Gen2 and its associated **container**.
4. #### [databricks.tf:](databricks.tf)
   - Sets up the Databricks **workspace**.
   - Manages Databricks **secrets**.
   - Assigns the `Blob Storage Contributor` role.
   - Creates Databricks **clusters** with associated libraries.
   - Establishes **mount points** between `Databricks` and `Azure Data Lake Gen2`.
   - Develops notebooks with source code in the [databricks folder](../databricks).
   - **Schedules jobs** for daily API requests and weekly data transformation.
5. #### [variables.tf:](variables.tf)
   - Declares variables used across the Terraform configuration.
6. #### [outputs.tf:](outputs.tf)
   - Defines useful outputs that will be displayed when the project is completed.
7. #### [vars folder](./vars)
   - Contains different `.tfvars` files to fit with various use cases.

### Configuration

- Create your own `tfvars` files under [vars](./vars) folder.
- Pass these variable files into the `-var-file` flag when executing Terraform commands.

### Troubleshooting

- `Quotas limit error`
  - Request a quotas increase [More info](https://learn.microsoft.com/en-us/azure/quotas/quickstart-increase-quota-portal).
  - In case you are using **free trial/student subscription**, at some point you may need to update into **pay-as-you-go** one. [More info](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/upgrade-azure-subscription).

## Databricks

### Bronze Layer

- Using Azure Datalake Gen 2 storage.
- Store raw data.
- Organizing the data in a hierarchical structure with year, month, and filenames based on their respective dates.

### Silver Layer

- Using Delta Lake in Databricks.
- Apply Star Schema design.
- Fact table:
  - `status_fact` table.
- Dimension tables:
  - `movies_dim`, `genres_dim`, `movies_genres`, `dates_dim` tables.

## Database Schema

Follow star-schema

### Fact tables

- **status_fact**: This table captures the status metrics of movies, including their popularity and voting details.
  - `movie_id` (INT, NOT NULL)
  - `date_id` (DATE, NOT NULL)
  - `popularity` (FLOAT)
  - `vote_average` (FLOAT)
  - `vote_count` (INT)

### Dimension table

- **movies_dim**: Contains details about each movie, such as title, language, and overview.

  - `movie_id` (INT, NOT NULL)
  - `title` (STRING)
  - `original_language` (STRING)
  - `overview` (STRING)
  - `poster_path` (STRING)

- **gernes_dim**: Lists the genres of movies, allowing for categorization and filtering.

  - `gerne_id` (INT, NOT NULL)
  - `gerne` (STRING, NOT NULL)

- **dates_dim**: Provides a breakdown of dates into day, month, and year, facilitating time-based analysis.

  - `date_id` (DATE, NOT NULL)
  - `day` (INT, GENERATED ALWAYS AS (DAY(date_id)))
  - `month` (INT, GENERATED ALWAYS AS (MONTH(date_id)))
  - `year` (INT, GENERATED ALWAYS AS (YEAR(date_id)))

- **movies_gernes**: A bridge table that connects movies to their respective genres, enabling many-to-many relationships.
  - `movie_id` (INT, NOT NULL)
  - `gerne_id` (INT, NOT NULL)
