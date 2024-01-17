# VMware Ops Manager and Bosh Director Configuration with Terraform
# Overview
This project aims to automate the deployment of VMware Ops Manager and the configuration of Bosh Director in AWS using Terraform. <br>
The infrastructure is designed to be customizable, allowing users to dynamically create and manage the required resources.

# Usage
Edit the **terraform.tfvars** file to customize variables. <br>
You will need to create and specify the values for the below variables defined in **terraform.tfvars** file. <br>
AWS **access_key** and secret **secret_key**. <br>
**EC2_pem_key_name** is the name of the PEM key and **EC2_pem_key** is the actual key itself. It is a set of security credentials that you use to prove your identity when connecting to a VM.

The values for s3_buckets have to be globally unique, **the S3 bucket names must follow the format specified in AWS doc https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html**

Run `terraform init` to initialize the Terraform configuration.

Run `terraform apply --auto-approve` to apply the configuration and deploy Ops Manager and Bosh Director.

**To destroy**, you first need to manually destroy the Bosh Director VM and the VMs created by the Bosh Director.

Run `terraform destroy --auto-approve` all cloud resourses including the Ops Manager VM will be destroyed.

# Additional configuration options
You can edit all the variables **terraform.tfvars** file.

You can select a specific version of the Ops Manager **Ops_Manager_Version**. 

If the **pivnet_token** token is not set in **terraform.tfvars** file the apply will fail, but Ops Manager will be created.
