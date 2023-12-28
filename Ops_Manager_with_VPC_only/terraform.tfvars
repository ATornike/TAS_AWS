/*
Enter aws_region and AWS credentials
*/
aws_region = "us-east-1"
access_key = "my_AWS_access_key"
secret_key = "my_AWS_secret_key"

// Tanzu Network Pivnet Token
pivnet_token = "my_pivnet_token"

// Initialize Ops_Manager VM for the first time. Add User, Password and Ops_Manager Decryption-Passphrase of your choice
Ops_Manager_Username = "atornike"
Ops_Manager_Password = "atornike"
Ops_Manager_Decryption-Passphrase = "atornike"


/* 
Use Wild card to find and deploy latest version of Ops Manager "pivotal-ops-manager-*" !!!
To find specific Ops Manager AMI in AWS edit the value specifying a version "pivotal-ops-manager-v3.0.3*" 
*/
Ops_Manager_Version = "pivotal-ops-manager-v3.0.15*"
// AWS specific VM (Instance) Type (Ops Manager VM type)
Ops_Manager_Instance_Type = "t3.xlarge"
// Name of Ops Manager VM deployed in AWS. To identify the VM in AWS GUI.
Ops_Manager_Instance_Name = "Ops_Manager"
// Name of PEM key to ssh into the Ops Manager
PEM_Key_to_ssh_in_Ops_Man_VM = "vmware"

// VPC Cidr_block
vpc_cidr_block = "10.0.0.0/22"
// VPC Name
VPC_Name = "VPC_TAS_Lab"

// Subnet Names
Subnets_Names = ["Main_Net_A_0.0/24","Pub_Sub_B_1.0/24","Pub_Sub_C_2.0/24","Pri_Sub_B_3.0/25","Pri_Sub_B_3.128/25"]
// Subnet IP ranges 
Cidr_List_Var = ["10.0.0.0/24","10.0.1.0/24","10.0.2.0/24","10.0.3.0/25","10.0.3.128/25"]
// Subnets will be deployed in below AZs
AZ_Zones = ["us-east-1a","us-east-1b","us-east-1c","us-east-1b","us-east-1c"]

// Route Table Names. To identify the VM in AWS GUI.
Route_Table_Names = ["RT_For_Public_Subnets","RT_For_Private_Subnets"]


// Security Group Ports Protocols and cider blocks for Ops Manager
Ops_Man_VM_Ports_SG = [
    { ports = 80,  protocols = "tcp", cidr_blocks = "0.0.0.0/0", ipv6_cidr_blocks = "::/0" },
    { ports = 443, protocols = "tcp", cidr_blocks = "0.0.0.0/0", ipv6_cidr_blocks = "::/0" },
    { ports = 22,  protocols = "tcp", cidr_blocks = "0.0.0.0/0", ipv6_cidr_blocks = "::/0" },
    { ports = 6868,   protocols = "tcp", cidr_blocks = "0.0.0.0/0", ipv6_cidr_blocks = "::/0" },
    { ports = 25555,  protocols = "tcp", cidr_blocks = "0.0.0.0/0", ipv6_cidr_blocks = "::/0" },
    { ports = 8844,  protocols = "tcp", cidr_blocks = "0.0.0.0/0", ipv6_cidr_blocks = "::/0" },
    { ports = 8443,  protocols = "tcp", cidr_blocks = "0.0.0.0/0", ipv6_cidr_blocks = "::/0" }
    //{ ports = 53,  protocols = "tcp", cidr_blocks = "0.0.0.0/0", ipv6_cidr_blocks = "::/0" }
]


// Security Group Ports Protocols and cider blocks for BOSH-Deployed VMs
Sec_Group_Bosh_Deployed_VMs_Ports = [
    { ports = 0,  protocols = "All", cidr_blocks = "0.0.0.0/0" },
    { ports = 2222, protocols = "tcp", cidr_blocks = "0.0.0.0/0" }
    //{ ports = 53,  protocols = "tcp", cidr_blocks = "0.0.0.0/0", ipv6_cidr_blocks = "::/0" }
]


// s3_buckets = [ "tas-ops-manager-bucket", "tas-buildpacks-bucket", "tas-packages-bucket", "tas-resources-bucket", "tas-droplets-bucket" ]


