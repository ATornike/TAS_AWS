/*
Enter aws_region and AWS credentials
*/
aws_region = "us-east-1"
access_key = "aws_access_key"
secret_key = "aws_secret_key"

/* 
EC2 key pair needs to be created and specified.
Used under iaas-configurations in bosh_director_config.tf file for (key_pair_name) and (ssh_private_key)
EC2_pem_key needs to be in one line format used in ssh_private_key 
*/
EC2_pem_key_name = "vmware"

// PEM key is used to access the Ops Manager VM and Bosh Director VM. It will be used to configure the Bosh Director Tile.
EC2_pem_key = <<EOT
-----BEGIN RSA PRIVATE KEY-----
0NSnVl+b8uSIvNHr270uWvpwBVQuCeUUuv8YtAjX3d6evb5FBVQuCeUUuv8YtAjX
0NSnVl+b8uSIvNHr270uWvpwBVQu0E9HGpjeUI4HyVTN00E9HGpjeUI4HyVTN05F
0NSnVl+b8uS0E9HGpjeUI4HyVTN0CeUUuv8YtAjX3d6evb5FBVQuCeUUuv8YtAjX
0NSnVl+b80E9HGpjeUI4HyVTN0QuCeUUuv8YtAjX3d6evb5FBVQuCeUUuv8YtAjX
0NSnVl+b8uSIvNHr270uWvpwBVQuCeUUuv8YtAjX3d6evb5FBVQuCeUUuv8YtAjX
0NSnVl+b8uSIvNHr270uWvpwBVQu0E9HGpjeUI4HyVTN00E9HGpjeUI4HyVTN05F
0NSnVl+b8uS0E9HGpjeUI4HyVTN0CeUUuv8YtAjX3d6evb5FBVQuCeUUuv8YtAjX
0NSnVl+b80E9HGpjeUI4HyVTN0QuCeUUuv8YtAjX3d6evb5FBVQuCeUUuv8YtAjX
0NSnVl+b8uSIvNHr270uWvpwBVQuCeUUuv8YtAjX3d6evb5FBVQuCeUUuv8YtAjX
0NSnVl+b8uSIvNHr270uWvpwBVQuCeUUuv8YtAjX3d6evb5FBVQuCeUUuv8YtAjX
0NSnVl+b8uSIvNHr270uWvpwBVQu0E9HGpjeUI4HyVTN00E9HGpjeUI4HyVTN05F
0NSnVl+b8uS0E9HGpjeUI4HyVTN0CeUUuv8YtAjX3d6evb5FBVQuCeUUuv8YtAjX
0NSnVl+b80E9HGpjeUI4HyVTN0QuCeUUuv8YtAjX3d6evb5FBVQuCeUUuv8YtAjX
0NSnVl+b8uSIvNHr270uWvpwBVQuCeUUuv8YtAjX3d6evb5FBVQuCeUUuv8YtAjX
0NSnVl+b8uSIvNHr270uWvpwBVQu0E9HGpjeUI4HyVTN00E9HGpjeUI4HyVTN05F
0NSnVl+b8uS0E9HGpjeUI4HyVTN0CeUUuv8YtAjX3d6evb5FBVQuCeUUuv8YtAjX
0NSnVl+b80E9HGpjeUI4HyVTN0QuCeUUuv8YtAjX3d6evb5FBVQuCeUUuv8YtAjX
0NSnVl+b8uS0E9HGpjeUI4HyVTN0CeUUuv8YtAjX3d6evb5FBVQuCeUUuv8YtAjX
0NSnVl+b80E9HGpjeUI4HyVTN0QuCeUUuv8YtAjX3d6evb5FBVQuCeUUuv8YtAjX
-----END RSA PRIVATE KEY-----
EOT

/* 
Use Wild card to find and deploy the latest version of Ops Manager "pivotal-ops-manager-*" !!!
To find a specific Ops Manager AMI in AWS edit the value specifying a version "pivotal-ops-manager-v3.0.3*" 
*/
Ops_Manager_Version = "pivotal-ops-manager-v2.10.*"
// AWS specific VM (Instance) Type
Ops_Manager_Instance_Type = "t3.xlarge"
// Name of Ops Manager VM deployed in AWS. To identify the VM in AWS GUI.
Ops_Manager_Instance_Name = "Ops_Manager"
// Name of PEM key to ssh into the Ops Manager
PEM_Key_to_ssh_in_Ops_Man_VM = "vmware"
// IAM instance profile name
iam_instance_profile_name = "VM-role-ops-manager-role-12345"


// Tanzu Network Pivnet Token
pivnet_token = "Pivnet_Token"
// Ops Manager inital credential setup. Username, Password and Decryption-Passphrase
Ops_Manager_Username              = "vmware"
Ops_Manager_Password              = "vmware"
Ops_Manager_Decryption-Passphrase = "vmware"

// VPC Cidr_block
VPC_Cidr_Block = "10.0.0.0/22"
// VPC Name
VPC_Name = "TF_Lab_VPC"

// Subnet Names, IP ranges, AZs and public_private will let you access Internet or Not.
// Subnet Names are used to configure the Networks in Bosh Director tile. subnet_name can only contain letters, numbers, and dashes 
Subnet_Cidrs_AZs_Names = [
  { subnet = "10.0.0.0/24", subnet_AZ = "us-east-1a", subnet_name = "Main-Net-A-0-0-24", public_private = "public" },
  { subnet = "10.0.1.0/24", subnet_AZ = "us-east-1b", subnet_name = "Pub-Sub-B-1-0-24", public_private = "public" },
  { subnet = "10.0.2.0/24", subnet_AZ = "us-east-1a", subnet_name = "Pri-Sub-A-2-0-24", public_private = "private" },
  { subnet = "10.0.3.0/25", subnet_AZ = "us-east-1b", subnet_name = "Pri-Sub-B-3-0-25", public_private = "private" },
  { subnet = "10.0.3.128/25", subnet_AZ = "us-east-1c", subnet_name = "Pri-Sub-C-3-128-25", public_private = "private" }
  //{ subnet = "", subnet_AZ = "", subnet_name = "" }
]
// Name of the subnet to place Bosh director, variable Subnet_Cidrs_AZs_Names nneds to be value of subnet_name
Place_Bosh_Director_in_Subnet_Name = "Pri-Sub-A-2-0-24"


// Route Table Names. To identify the VM in AWS GUI.
Route_Table_Names = ["RT_For_Public_Subnets", "RT_For_Private_Subnets"]


// Security Group Ports Protocols and cider blocks for Ops Manager
Ops_Man_VM_Ports_SG = [
  { ports = 80, protocols = "tcp", cidr_blocks = "0.0.0.0/0", ipv6_cidr_blocks = "::/0" },
  { ports = 443, protocols = "tcp", cidr_blocks = "0.0.0.0/0", ipv6_cidr_blocks = "::/0" },
  { ports = 22, protocols = "tcp", cidr_blocks = "0.0.0.0/0", ipv6_cidr_blocks = "::/0" },
  { ports = 0, protocols = "All", cidr_blocks = "0.0.0.0/0", ipv6_cidr_blocks = "::/0" }
  //{ ports = 6868,   protocols = "tcp", cidr_blocks = "0.0.0.0/0", ipv6_cidr_blocks = "::/0" },
  //{ ports = 25555,  protocols = "tcp", cidr_blocks = "0.0.0.0/0", ipv6_cidr_blocks = "::/0" },
  //{ ports = 8844,  protocols = "tcp", cidr_blocks = "0.0.0.0/0", ipv6_cidr_blocks = "::/0" },
  //{ ports = 8443,  protocols = "tcp", cidr_blocks = "0.0.0.0/0", ipv6_cidr_blocks = "::/0" }
  //{ ports = 53,  protocols = "tcp", cidr_blocks = "0.0.0.0/0", ipv6_cidr_blocks = "::/0" }
]


// Security Group Ports Protocols and cider blocks for BOSH-Deployed VMs
Sec_Group_Bosh_Deployed_VMs_Ports = [
  { ports = 0, protocols = "All", cidr_blocks = "0.0.0.0/0" },
  { ports = 2222, protocols = "tcp", cidr_blocks = "0.0.0.0/0" }
  //{ ports = 53,  protocols = "tcp", cidr_blocks = "0.0.0.0/0", ipv6_cidr_blocks = "::/0" }
]


s3_buckets = [ "tas-ops-manager-bucket", "tas-buildpacks-bucket", "tas-packages-bucket", "tas-resources-bucket", "tas-droplets-bucket" ]
