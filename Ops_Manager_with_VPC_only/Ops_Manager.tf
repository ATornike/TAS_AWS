variable "Ops_Manager_Version" {
  type = string
}
variable "Ops_Manager_Instance_Type" {
  type = string
}
variable "Ops_Manager_Instance_Name" {
  type = string
}
variable "PEM_Key_to_ssh_in_Ops_Man_VM" {
  type = string
}

// Name of the PEM key used in the Ops_Manager.tf and bosh_director_config.tf files. to create the VM and to configure Bosh Director Tile. 
variable "EC2_pem_key_name" {
  type = string
}
// Used in the Ops_Manager.tf and bosh_director_config.tf files. 
// In Ops_Manager.tf it is used to ssh into Newly created Ops Manager VM and configure director.
variable "EC2_pem_key" {
  type = string
}

//configure-authentication --username=vmware --password=vmware --decryption-passphrase=vmware pivnet_API_Token
variable "Ops_Manager_Username" {
  type    = string
  default = "vmware"
}

variable "Ops_Manager_Password" {
  type    = string
  default = "vmware"
}

variable "Ops_Manager_Decryption-Passphrase" {
  type    = string
  default = "vmware"
}

variable "pivnet_token" {
  type = string
}

// Finds the newest Available version of Ops Manager ami (amazon machean image)
data "aws_ami" "pivital_ami" {
  most_recent = true
  owners      = ["364390758643"]

  filter {
    name   = "name"
    values = [var.Ops_Manager_Version]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


resource "aws_instance" "Ops_Manager_VM" {
  ami                         = data.aws_ami.pivital_ami.id
  instance_type               = var.Ops_Manager_Instance_Type
  key_name                    = var.PEM_Key_to_ssh_in_Ops_Man_VM
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ins-profile.name

  // Will place Ops Manager in the first subnet from the subnet list.
  subnet_id = aws_subnet.main.*.id[0]

  tags = {
    Name = var.Ops_Manager_Instance_Name
  }
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = "50"
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }
  vpc_security_group_ids = [aws_security_group.Security_Group_For_Ops_Manager.id]

}

// 3 minute delay to allow Ops Manager VM Creation in AWS.
resource "time_sleep" "wait_3m" {
  depends_on = [aws_instance.Ops_Manager_VM]

  create_duration = "3m"
// Initial setup of Ops Manager User, Password and Decryption Passphrase.
  provisioner "local-exec" {
    command = "om -t https://${aws_eip.Public_IP.public_ip}/ -k configure-authentication --username=${var.Ops_Manager_Username} --password=${var.Ops_Manager_Password} --decryption-passphrase=${var.Ops_Manager_Decryption-Passphrase}"
  }


  connection {
    type = "ssh"
    user = "ubuntu"
    //private_key = file("./vmware.pem")
    private_key = var.EC2_pem_key
    host        = aws_eip.Public_IP.public_ip
  }
// Connect/SSH into Ops Manager VM and execute below commands.
  provisioner "remote-exec" {
    inline = [
      "wget https://github.com/pivotal-cf/om/releases/download/7.9.0/om-linux-amd64-7.9.0",
      "chmod +x om-linux*",
      "sudo cp om-linux* /usr/local/bin/om",

      "wget https://github.com/pivotal-cf/pivnet-cli/releases/download/v3.0.1/pivnet-linux-amd64-3.0.1",
      "chmod +x pivnet-linux*",
      "sudo cp pivnet-linux* /usr/local/bin/pivnet",

      "echo '${local.bosh_iaas_config_file}' >> director_config.yaml",
      "om -t https://${aws_eip_association.eip_assoc.public_ip}/ -u ${var.Ops_Manager_Username} -p ${var.Ops_Manager_Password} -k configure-director -c director_config.yaml",
      "om -t https://${aws_eip_association.eip_assoc.public_ip}/ -u ${var.Ops_Manager_Username} -p ${var.Ops_Manager_Password} -k curl -p /api/v0/installations -x POST -d '${local.apply_changes_all_tiles}'",

      "pivnet login --api-token='${var.pivnet_token}'",

    ]
  }
}
