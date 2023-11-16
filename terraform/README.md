# movrec IaC

- [movrec IaC](#movrec-iac)
    - [Description](#description)
    - [Requirements](#requirements)
    - [Initialization](#initialization)
    - [Troubleshooting](#troubleshooting)

### Description

In this project, I utilize Terraform to create cloud resources, [Databricks](https://www.databricks.com/) and [Storage Account](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview) (act as datalake gen 2),
and establish their connections within Azure.

### Requirements

- [Azure account](https://azure.microsoft.com/en-us/free/search/?ef_id=_k_Cj0KCQiAmNeqBhD4ARIsADsYfTfCVwwbCl8gclCJU6wI8QcFbJkw_wNu30TydWg2mhETRF7ycss2a68aAj-FEALw_wcB_k_&OCID=AIDcmmftanc7uz_SEM__k_Cj0KCQiAmNeqBhD4ARIsADsYfTfCVwwbCl8gclCJU6wI8QcFbJkw_wNu30TydWg2mhETRF7ycss2a68aAj-FEALw_wcB_k_&gad_source=1&gclid=Cj0KCQiAmNeqBhD4ARIsADsYfTfCVwwbCl8gclCJU6wI8QcFbJkw_wNu30TydWg2mhETRF7ycss2a68aAj-FEALw_wcB)
  to use services
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
  to automatically construct and manage services.
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
  to authenticate and authorize Terraform to act on behalf of an Azure account

### Configuration

### Initialization

Change the current working directory to the [terraform folder](.):

```bash
$ cd ./terraform
```

Run [initialization scripts](init-azure.sh) for construct services:

```bash
$ ./init-azure.sh
```

### Troubleshooting

- `Quotas limit error`
    - Request a quotas increase
      [More info](https://learn.microsoft.com/en-us/azure/quotas/quickstart-increase-quota-portal)
    - In case you are using **free trial/student subscription**,
      at some point you may need to update into **pay-as-you-go** one.
      [More info](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/upgrade-azure-subscription)