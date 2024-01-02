/*
Bosh Director (Tile Configuration) manifest will be created with AWS resources dynamically allocated to the manifest file.
This file (local) is used to create the file in Ops Manager VM and to configure the Bosh Director Tile.
*/

// Select Subnet name that you defined in Subnet_Cidrs_AZs_Names variable to Deploy Bosh director in that subnet.
variable "Place_Bosh_Director_in_Subnet_Name" {
  type = string
}

locals {
/*
Dynamically creates Config file for Bosh director
*/
  bosh_iaas_config_file = replace(yamlencode({
    iaas-configurations = [{
      additional_cloud_properties = { "max_retries" = "3" }
      iam_instance_profile        = "${aws_instance.Ops_Manager_VM.iam_instance_profile}"
      key_pair_name               = "${var.EC2_pem_key_name}"
      ssh_private_key             = "${var.EC2_pem_key}"
      security_group              = "${aws_security_group.Security_Group_For_Bosh_VMs.id}"
      region                      = "${var.aws_region}"
      disk_type                   = "gp3"
      encrypted                   = false
      name                        = "default"
      require_imds_v2             = false
    }]
    az-configuration = [for i in concat(distinct(var.Subnet_Cidrs_AZs_Names.*.subnet_AZ)) : {
      name = i
    }]
    networks-configuration = {
      networks = [
        for networks in aws_subnet.main : {
          subnets = [{
            iaas_identifier         = networks.id
            cidr                    = networks.cidr_block
            gateway                 = cidrhost(networks.cidr_block, 1)
            reserved_ip_ranges      = join("-", [cidrhost(networks.cidr_block, 1), cidrhost(networks.cidr_block, 10)])
            availability_zone_names = [networks.availability_zone]
            dns                     = "169.254.169.253"
            }
          ]
          name = networks.tags.Name
        }
      ]
      icmp_checks_enabled = true
    }

    network-assignment = {
      network = {
        name = var.Subnet_Cidrs_AZs_Names[index(var.Subnet_Cidrs_AZs_Names[*].subnet_name, var.Place_Bosh_Director_in_Subnet_Name)].subnet_name
      }
      other_availability_zones = []
      singleton_availability_zone = {
        name = var.Subnet_Cidrs_AZs_Names[index(var.Subnet_Cidrs_AZs_Names[*].subnet_name, var.Place_Bosh_Director_in_Subnet_Name)].subnet_AZ
      }
    }

    properties-configuration = {
      director_configuration = {
        additional_ssh_users                          = []
        blobstore_type                                = "local"
        bosh_director_recreate_on_next_deploy         = false
        bosh_recreate_on_next_deploy                  = false
        bosh_recreate_persistent_disks_on_next_deploy = false
        ca_certificate_duration                       = 1460
        database_type                                 = "internal"
        director_metrics_server_enabled               = true
        director_worker_count                         = 5
        duration_overrides_enabled                    = false
        encryption = {
          keys      = []
          providers = []
        }
        hm_emailer_options = {
          enabled = false
        }
        hm_pager_duty_options = {
          enabled = false
        }
        identification_tags        = {}
        job_configuration_on_tmpfs = false
        keep_unreachable_vms       = false
        leaf_certificate_duration  = 730
        local_blobstore_options = {
          enable_signed_urls = true
        }
        metrics_server_enabled         = true
        ntp_servers_string             = "169.254.169.123"
        post_deploy_enabled            = false
        resurrector_enabled            = false
        retry_bosh_deploys             = false
        skip_director_drain            = false
        system_metrics_runtime_enabled = true
      }
      dns_configuration = {
        excluded_recursors = []
        handlers           = []
      }
      security_configuration = {
        clear_default_trusted_certificates_store = false
        generate_vm_passwords                    = true
        opsmanager_root_ca_trusted_certs         = false
      }
      syslog_configuration = {
        enabled = false
    } }
    resource-configuration = {
      compilation = {
        additional_networks      = []
        additional_vm_extensions = []
        elb_names                = []
        instance_type = {
          id = "automatic"
        }
        instances                      = "automatic"
        internet_connected             = false
        swap_as_percent_of_memory_size = "automatic"
        director = {
          additional_networks      = []
          additional_vm_extensions = []
          elb_names                = []
          instance_type = {
            id = "automatic"
        } }
        instances          = "automatic"
        internet_connected = false
        persistent_disk = {
          size_mb                        = "automatic"
          swap_as_percent_of_memory_size = "automatic"
        }
      }
    }
    vmextensions-configuration = []
    vmtypes-configuration      = {}
  }), "\"", "")
}


locals {
/*
Needed to trigger an Apply Change to deploy Bosh Director. Passed to Ops Manager VM remote-exec command.
*/
  apply_changes_all_tiles = jsonencode({ "deploy_products" : "all", "ignore_warnings" : true })
}

/*
output "iaas_bosh_config" {
  value = local.bosh_iaas_config_file
}
*/


