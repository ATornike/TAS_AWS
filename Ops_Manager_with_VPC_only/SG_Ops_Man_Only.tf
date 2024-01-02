variable "Ops_Man_VM_Ports_SG" {
  description = "Var Objects Security Group values for Ops Manager VM"
  type = list(object({
    ports            = number,
    protocols        = string,
    cidr_blocks      = string,
    ipv6_cidr_blocks = string
  }))
}

variable "Sec_Group_Bosh_Deployed_VMs_Ports" {
  description = "Var Objects Security Group values for BOSH-Deployed VMs"
  type = list(object({
    ports       = number,
    protocols   = string,
    cidr_blocks = string
    //ipv6_cidr_blocks = string
  }))
}

// All Posts are open for any VM in VPC Cidr IP. All VMs can access the Ops Manager VM in VPC network.

locals {
  formatted_cidr_blocks = [for item in var.Ops_Man_VM_Ports_SG : {
    ports            = item.ports
    protocols        = item.protocols
    cidr_blocks      = item.ports == 0 ? var.VPC_Cidr_Block : item.cidr_blocks
    ipv6_cidr_blocks = item.ipv6_cidr_blocks
  }]
}


resource "aws_security_group" "Security_Group_For_Ops_Manager" {
  name        = "TF_atornike_Ops_Man_SG"
  description = "Creates SG and Opens Ports defined in Variable"
  vpc_id      = aws_vpc.Terraform_Lab_VPC.id

  dynamic "egress" {
    for_each = local.formatted_cidr_blocks
    iterator = for_val
    content {
      from_port   = for_val.value.ports
      to_port     = for_val.value.ports
      protocol    = for_val.value.protocols
      cidr_blocks = [for_val.value.cidr_blocks]
      //ipv6_cidr_blocks = [for_val.value.ipv6_cidr_blocks]
    }
  }

  dynamic "ingress" {
    for_each = local.formatted_cidr_blocks
    iterator = for_val
    content {
      from_port   = for_val.value.ports
      to_port     = for_val.value.ports
      protocol    = for_val.value.protocols
      cidr_blocks = [for_val.value.cidr_blocks]
      //ipv6_cidr_blocks = [for_val.value.ipv6_cidr_blocks]
    }
  }
}


// All Posts are open for any VM in VPC Cidr IP. All VMs in VPC can access the Bosh Director VM.

locals {
  bosh_formatted_cidr_blocks = [for item in var.Sec_Group_Bosh_Deployed_VMs_Ports : {
    ports       = item.ports
    protocols   = item.protocols
    cidr_blocks = item.ports == 0 ? var.VPC_Cidr_Block : item.cidr_blocks
    //ipv6_cidr_blocks = item.ipv6_cidr_blocks
  }]
}

resource "aws_security_group" "Security_Group_For_Bosh_VMs" {
  name        = "TF_atornike_Bosh_VMs_SG"
  description = "Creates SG and Opens Ports defined in Variable"
  vpc_id      = aws_vpc.Terraform_Lab_VPC.id

  dynamic "egress" {
    for_each = local.bosh_formatted_cidr_blocks
    iterator = for_val
    content {
      from_port   = for_val.value.ports
      to_port     = for_val.value.ports
      protocol    = for_val.value.protocols
      cidr_blocks = [for_val.value.cidr_blocks]
      //ipv6_cidr_blocks = [for_val.value.ipv6_cidr_blocks]
    }
  }

  dynamic "ingress" {
    for_each = local.bosh_formatted_cidr_blocks
    iterator = for_val
    content {
      from_port   = for_val.value.ports
      to_port     = for_val.value.ports
      protocol    = for_val.value.protocols
      cidr_blocks = [for_val.value.cidr_blocks]
      //ipv6_cidr_blocks = [for_val.value.ipv6_cidr_blocks]
    }
  }
}

