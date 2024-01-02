# VMware Ops Manager and Bosh Director Deployment with Terraform
# Overview
This project aims to automate the deployment of VMware Ops Manager and the configuration of Bosh Director in AWS using Terraform. The infrastructure is designed to be customizable, allowing users to dynamically create and manage the required resources.

# Usage
Edit the terraform.tfvars file to customize variables.

Run `terraform init` to initialize the Terraform configuration.

Run `terraform apply --auto-approve` to apply the configuration and deploy Ops Manager and Bosh Director.
