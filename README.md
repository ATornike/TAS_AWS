# VMware Ops Manager and Bosh Director Deployment with Terraform
# Overview
This project aims to automate the deployment of VMware Ops Manager and the configuration of Bosh Director in AWS using Terraform. The infrastructure is designed to be customizable, allowing users to dynamically create and manage the required resources.

# Usage
Edit the terraform.tfvars file to customize variables.
You will need to specify the values for the below variables defined in **terraform.tfvars** file. 
AWS **access_key** and secret **secret_key**.
**EC2_pem_key_name** is the name of the PEM key. It is a set of security credentials that you use to prove your identity when connecting to an VM.
**EC2_pem_key** is the actual key itself. 

The values s3_buckets for **S3 bucket names must follow the format specified in AWS doc https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html**

Run `terraform init` to initialize the Terraform configuration.

Run `terraform apply --auto-approve` to apply the configuration and deploy Ops Manager and Bosh Director.


# Additional configuration options
You can edit all the variables **terraform.tfvars** file.

You can select a specific version of the Ops Manager **Ops_Manager_Version**. 
**pivnet_token** token can be set in the Ops Manager VM.
