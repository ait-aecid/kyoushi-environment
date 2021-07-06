# Intranet Hosts

## Internal Employees 
module "internal_employees" {
  source                   = "git@github.com:ait-cs-IaaS/terraform-openstack-srv_noportsec-count.git?ref=v1.4"
  host_capacity            = var.employee_capacity
  hostname                 = "internal_employee"
  tag                      = "intranet, employee"
  host_address_start_index = var.employee_ip_start_index
  image                    = local.employee_image
  flavor                   = local.employee_flavor
  volume_size              = local.employee_volume_size
  use_volume               = local.employee_use_volume
  config_drive             = true
  sshkey                   = var.sshkey
  network                  = var.intranet
  subnet                   = var.intranet_subnet
  userdatafile             = local.employee_userdata_file
  userdata_vars            = local.employee_userdata_vars
}

module "intranet" {
  count              = var.intranet_active ? 1 : 0
  source             = "git@github.com:ait-cs-IaaS/terraform-openstack-srv_noportsec.git?ref=v1.4"
  hostname           = "intranet_server"
  tag                = "intranet, servers"
  host_address_index = var.intranet_ip_index
  image              = local.intranet_image
  flavor             = local.intranet_flavor
  volume_size        = local.intranet_volume_size
  use_volume         = local.intranet_use_volume
  config_drive       = true
  sshkey             = var.sshkey
  network            = var.intranet
  subnet             = var.intranet_subnet
  userdatafile       = local.intranet_userdata_file
  userdata_vars      = local.intranet_userdata_vars
}

module "shares" {
  count              = length(var.shares)
  source             = "git@github.com:ait-cs-IaaS/terraform-openstack-srv_noportsec.git?ref=v1.4"
  hostname           = "${var.shares[count.index].name}_share"
  host_address_index = var.shares[count.index].ip_index
  tag                = "intranet, share, servers"
  image              = local.share_image
  flavor             = local.share_flavor
  volume_size        = local.share_volume_size
  use_volume         = local.share_use_volume
  config_drive       = true
  sshkey             = var.sshkey
  network            = var.intranet
  subnet             = var.intranet_subnet
  userdatafile       = local.share_userdata_file
  userdata_vars      = local.share_userdata_vars
}

module "monitoring" {
  count              = var.monitoring_active ? 1 : 0
  source             = "git@github.com:ait-cs-IaaS/terraform-openstack-srv_noportsec.git?ref=v1.4"
  hostname           = "monitoring"
  tag                = "intranet, servers"
  host_address_index = var.monitoring_ip_index
  image              = local.monitoring_image
  flavor             = local.monitoring_flavor
  volume_size        = local.monitoring_volume_size
  use_volume         = local.monitoring_use_volume
  config_drive       = true
  sshkey             = var.sshkey
  network            = var.intranet
  subnet             = var.intranet_subnet
  userdatafile       = local.monitoring_userdata_file
  userdata_vars      = local.monitoring_userdata_vars
}
