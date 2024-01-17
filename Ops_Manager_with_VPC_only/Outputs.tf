output "Out_Ops_Manager_Sec_Group_ID" {
  description = "Ops Manager Security Group ID"
  value       = aws_security_group.Security_Group_For_Ops_Manager.id
}

output "Out_Bosh_VMs_Sec_Group_ID" {
  description = "Bosh VMs Security Group ID"
  value       = aws_security_group.Security_Group_For_Bosh_VMs.id
}

output "Ops_Manager_Public_IP" {
  description = "Public IP address of Ops Manager is Associated Elastic IP to Ops Manager VM"
  value       = aws_eip_association.eip_association.public_ip
}


// Need to configure Bosh Director

output "Ops_Man_Subnet_ID" {
  description = "Subnet ID of Ops Manager"
  value       = aws_instance.Ops_Manager_VM.subnet_id
}

output "Ops_Man_Availability_Zone" {
  description = "Availability Zone of Ops Manager"
  value       = aws_instance.Ops_Manager_VM.availability_zone
}

output "Ops_Man_private_ip" {
  description = "private_ip of Ops Manager"
  value       = aws_instance.Ops_Manager_VM.private_ip
}

output "Ops_Man_key_name" {
  description = "key_name of Ops Manager"
  value       = aws_instance.Ops_Manager_VM.key_name
}

output "Ops_Man_iam_instance_profile" {
  description = "iam_instance_profile of Ops Manager"
  value       = aws_instance.Ops_Manager_VM.iam_instance_profile
}

output "Ops_Man_region" {
  description = "region of Ops Manager"
  value       = var.aws_region
}

output "IAM_policy_name" {
  description = "IAM_policy_name"
  value       = aws_iam_instance_profile.ins-profile.name
}

output "Ops_Man_Subnet_IP" {
  description = "Ops_Manager_Subnet_ID"
  value       = aws_instance.Ops_Manager_VM.subnet_id
}

/*
output "Subnet_Cidrs" {
  value = aws_subnet.main.*.cidr_block
}

output "AZs_Of_Subnets" {
  value = tolist(var.Subnet_Cidrs_AZs_Names.*.subnet_AZ)
}
*/
