// Create Route tables and asossiate subnets

variable "Route_Table_Names" {
  type        = list(string)
  description = "Var Objects Security Group values for Ops Manager VM"
  default     = ["RT_For_Public_Subnets", "RT_For_Private_Subnets"]
}

locals {
  num_subs = length(var.Subnet_Cidrs_AZs_Names)
  toko     = { for i in var.Subnet_Cidrs_AZs_Names : i.public_private => i... }
}


resource "aws_route_table" "TF_Route_Tables" {
  count  = length(var.Route_Table_Names)
  vpc_id = aws_vpc.Terraform_Lab_VPC.id

  tags = {
    Name = var.Route_Table_Names[count.index]
  }
}


// Attaches subnets to Public route Tables
resource "aws_route_table_association" "Route_Table_Association" {
  count          = length(lookup(local.toko, "public")) != local.num_subs ? length(lookup(local.toko, "public")) : local.num_subs
  subnet_id      = aws_subnet.main.*.id[count.index]
  route_table_id = aws_route_table.TF_Route_Tables.*.id[0]
}


// Attaches subnets to Private Route Tables
resource "aws_route_table_association" "RTable_Association_2" {
  count          = length(lookup(local.toko, "private")) != local.num_subs ? local.num_subs - length(lookup(local.toko, "public")) : local.num_subs
  subnet_id      = aws_subnet.main.*.id[count.index + length(lookup(local.toko, "public"))]
  route_table_id = aws_route_table.TF_Route_Tables.*.id[1]
}


// Attaches IGW to first route (Public Route Table) !!! "0.0.0.0/0" default anywhere route ipv4 address
resource "aws_route" "igw_route" {
  route_table_id         = aws_route_table.TF_Route_Tables.*.id[0]
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_route_table.TF_Route_Tables]
}

