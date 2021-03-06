# Internet hosts

## Remote Employees 
module "remote_employees" {
  source        = "git@github.com:ait-cs-IaaS/terraform-openstack-srv_noportsec-count.git?ref=v1.4"
  host_capacity = var.remote_employee_capacity
  hostname      = "remote_employee"
  tag           = "internet, employee"
  image         = local.employee_image
  flavor        = local.employee_flavor
  volume_size   = local.employee_volume_size
  use_volume    = local.employee_use_volume
  sshkey        = var.sshkey
  network       = var.internet
  subnet        = var.internet_subnet
  userdatafile  = local.employee_userdata_file
  userdata_vars = local.employee_userdata_vars
}

## Attacker
module "attackers" {
  source        = "git@github.com:ait-cs-IaaS/terraform-openstack-srv_noportsec-count.git?ref=v1.4"
  host_capacity = var.attacker_capacity
  hostname      = "attacker"
  tag           = "internet"
  image         = local.attacker_image
  flavor        = local.attacker_flavor
  volume_size   = local.attacker_volume_size
  use_volume    = local.attacker_use_volume
  sshkey        = var.sshkey
  network       = var.internet
  subnet        = var.internet_subnet
  userdatafile  = local.attacker_userdata_file
  userdata_vars = local.attacker_userdata_vars
}

## External Mail Servers
module "ext_mail" {
  count              = length(var.ext_mail)
  source             = "git@github.com:ait-cs-IaaS/terraform-openstack-srv_noportsec.git?ref=v1.4.3"
  hostname           = "${var.ext_mail[count.index].name}_mail"
  host_address_index = var.ext_mail[count.index].ip_index
  tag                = "internet, ext_mail, mailserver"
  image              = local.ext_mail_image
  flavor             = local.ext_mail_flavor
  volume_size        = local.ext_mail_volume_size
  use_volume         = local.ext_mail_use_volume
  config_drive       = true
  sshkey             = var.sshkey
  network            = var.internet
  subnet             = var.internet_subnet
  userdatafile       = local.ext_mail_userdata_file
  userdata_vars      = local.ext_mail_userdata_vars
}

## External Users 
module "ext_users" {
  source        = "git@github.com:ait-cs-IaaS/terraform-openstack-srv_noportsec-count.git?ref=v1.4"
  host_capacity = var.ext_user_capacity
  hostname      = "ext_user"
  tag           = "internet"
  image         = local.ext_user_image
  flavor        = local.ext_user_flavor
  volume_size   = local.ext_user_volume_size
  use_volume    = local.ext_user_use_volume
  sshkey        = var.sshkey
  network       = var.internet
  subnet        = var.internet_subnet
  userdatafile  = local.ext_user_userdata_file
  userdata_vars = local.ext_user_userdata_vars
}
