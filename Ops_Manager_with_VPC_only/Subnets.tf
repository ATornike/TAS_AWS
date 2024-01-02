//List of CIDR blocks"
//List of Availability Zones in AWS. Only 3 unique are listed, some AWS Regions have only 3 Availability Zones. 
//Can be modified based on the targeted Region 
//List of names. Will be used to name Subnets.
//List of Availability Zones in AWS. Only 3 unique are listed, some AWS Regions have only 3 Availability Zones. 
//Can be modified based on the targeted Region 

variable "Subnet_Cidrs_AZs_Names" {
  type = list(object({
    subnet         = string,
    subnet_AZ      = string,
    subnet_name    = string,
    public_private = string
  }))
}


resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.Terraform_Lab_VPC.id
  count             = length(var.Subnet_Cidrs_AZs_Names)
  cidr_block        = var.Subnet_Cidrs_AZs_Names.*.subnet[count.index]
  availability_zone = var.Subnet_Cidrs_AZs_Names.*.subnet_AZ[count.index]

  tags = {
    Name = var.Subnet_Cidrs_AZs_Names.*.subnet_name[count.index]
  }
}
