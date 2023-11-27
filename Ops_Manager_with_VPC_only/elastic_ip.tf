// Reserves Public IP address for Ops Manager VM to use

resource "aws_eip" "Public_IP" {
  instance = aws_instance.Ops_Manager_VM.id
  vpc      = true
  tags = {
    Name = "Ops_Manager_VM_IP"
  }
}

resource "aws_eip_association" "eip_association" {
  instance_id   = aws_instance.Ops_Manager_VM.id
  allocation_id = aws_eip.Public_IP.id
}
