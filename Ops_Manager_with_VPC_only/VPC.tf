// To create a VPC

// VPC Name
variable "VPC_Name" {
  type = string
  default     = "TF_VPC"
}
// VPC Cidr Block
variable "VPC_Cidr_Block" {
  type = string
  default     = "10.0.0.0/22"
}

resource "aws_vpc" "Terraform_Lab_VPC" {
  cidr_block           = var.VPC_Cidr_Block
  enable_dns_support   = true
  enable_dns_hostnames = false
  tags = {
    "Name" = var.VPC_Name
  }
}
