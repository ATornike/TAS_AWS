# VMware Ops Manager and Bosh Director Configuration with Terraform
# Overview
This project aims to automate the deployment of VMware Ops Manager and the configuration of Bosh Director in AWS using Terraform. <br>
The infrastructure is designed to be customizable, allowing users to dynamically create and manage the required resources.

# Usage
Edit the **terraform.tfvars** file to customize variables. <br>
You will need to create and specify the values for the below variables defined in **terraform.tfvars** file. <br>
AWS **access_key** and secret **secret_key**. <br>
**EC2_pem_key_name** is the name of the PEM key and **EC2_pem_key** is the actual key itself. It is a set of security credentials that you use to prove your identity when connecting to a VM.

The values for **s3_buckets** variable have to be globally unique, **the S3 bucket names must follow the format specified in AWS doc https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html**

Optionally, you can specify the version of the Ops Manager and VM size in the **terraform.tfvars** file. <br>
**Pivnet** and **OM CLI** are installed on the Ops Manager VM, and a Pivnet token can be specified. 
<br>
<br>
**NOTE** If the pivnet_token is not set in the terraform.tfvars file, the apply will fail, but Ops Manager will still be created. <br>
You can add any value to the pivnet_token to prevent failure.

Run `terraform init` to initialize the Terraform configuration.

Run `terraform apply --auto-approve` to apply the configuration and deploy Ops Manager and Bosh Director.

**To destroy**, you first need to manually destroy the Bosh Director VM and the VMs created by the Bosh Director.

Run `terraform destroy --auto-approve` all cloud resourses including the Ops Manager VM will be destroyed.

# Additional configuration options
You can edit all the variables in **terraform.tfvars** file.

You can modify and edit the Cider to specify the size of networks. <br> 
You have the option to choose whether the network has access to the public web or is private by adding the `public_private = "public"` or `public_private = "private"`. <br>

The security group ports can be edited. The `ports = 0` value, defined in the Security Group variable, allows access to all ports only within the VPC networks.

# Bosh Director Configuration
The **bosh_director_config.tf** file is configuring the bosh director all IaaS resourse values are appened dynamically and can be modified as needed.

To place Bosh Director VM in a desired subnet add the name of the subnet from **Subnet_Cidrs_AZs_Names** variable option **subnet_name** to **Place_Bosh_Director_in_Subnet_Name**. Done in **terraform.tfvars** file.
