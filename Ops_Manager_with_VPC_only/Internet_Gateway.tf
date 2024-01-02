// Creates Internet Gateway, is attached to Public Route Table giving associated subnets access to internet.

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.Terraform_Lab_VPC.id

  tags = {
    Name = "TF_IGW"
  }
}
