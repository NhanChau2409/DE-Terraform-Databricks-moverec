# movrec IaC

- [movrec IaC](#movrec-iac)
    - [Description](#description)
    - [Requirements](#requirements)
    - [Troubleshooting](#troubleshooting)
    - [Run](#run)

### Description

Infrastructure as Code (IaC) with Terraform simplifies and automates the process of provisioning and managing Azure
resources,
Identity and Access Management (IAM), and other aspects of your cloud infrastructure. This guide outlines the steps to
leverage Terraform for creating and managing Azure resources efficiently.

### Requirements

- [Azure account](https://azure.microsoft.com/en-us/free/search/?ef_id=_k_Cj0KCQiAmNeqBhD4ARIsADsYfTfCVwwbCl8gclCJU6wI8QcFbJkw_wNu30TydWg2mhETRF7ycss2a68aAj-FEALw_wcB_k_&OCID=AIDcmmftanc7uz_SEM__k_Cj0KCQiAmNeqBhD4ARIsADsYfTfCVwwbCl8gclCJU6wI8QcFbJkw_wNu30TydWg2mhETRF7ycss2a68aAj-FEALw_wcB_k_&gad_source=1&gclid=Cj0KCQiAmNeqBhD4ARIsADsYfTfCVwwbCl8gclCJU6wI8QcFbJkw_wNu30TydWg2mhETRF7ycss2a68aAj-FEALw_wcB)
  to access and utilize Azure services.

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
  installed on your local machine to define and manage infrastructure as code.

- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
  to authenticate and authorize Terraform to interact with Azure on your behalf.

### Run

Change the current working directory to the [terraform folder](.):

```bash
$ cd ./terraform
```

Login into your Azure account through Azure CLI:

```bash
$ az login
```

Initialize Terraform:

```bash
$ terraform init
```

Run Terraform planning:

```bash
$ terraform plan
```

Execute plan if there is no error:

```bash
$ terraform apply
```

### Configuration

- Create your own `tfvars` files under [vars](./vars) folder
- Pass these variable files into the `-var-file` flag when executing Terraform commands.

### Troubleshooting

- `Quotas limit error`
    - Request a quotas increase
      [More info](https://learn.microsoft.com/en-us/azure/quotas/quickstart-increase-quota-portal)
    - In case you are using **free trial/student subscription**,
      at some point you may need to update into **pay-as-you-go** one.
      [More info](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/upgrade-azure-subscription)