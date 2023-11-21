#!/bin/bash

# Move to the Terraform project directory
cd ./terraform

# Azure CLI login
az login

# Set the Azure subscription (if you have multiple subscriptions)
# az account set --subscription <subscription-id>

# Initialize the Terraform configuration
terraform init

# Generate and show an execution plan
terraform plan

# Apply the Terraform configuration to create or update resources
terraform apply -auto-approve

# Optional: Display a message indicating the completion of the deployment
echo "Terraform deployment completed successfully."
