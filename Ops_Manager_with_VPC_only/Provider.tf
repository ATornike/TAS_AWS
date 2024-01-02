// !!! Edit terraform.tfvars file to change the variables used !!! 

variable "aws_region" {
  type = string
  // default = "us-east-1"
}
variable "access_key" {
  type = string
  // default = "AK-access_key-RFC"
}
variable "secret_key" {
  type = string
  // default = "SK-secret_key-RFC"
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}
