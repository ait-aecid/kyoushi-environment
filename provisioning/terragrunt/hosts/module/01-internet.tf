# Internet hosts

## Remote Employees 
module "remote_employees" {
  source        = "git@git-service.ait.ac.at:sct-cyberrange/terraform-modules/openstack-srv_noportsec-count.git?ref=v1.3.1"
  host_capacity = var.remote_employee_capacity
  hostname      = "remote_employee"
  tag           = "internet, employee"
  image         = local.employee_image
  flavor        = local.employee_flavor
  volume_size   = local.employee_volume_size
  sshkey        = var.sshkey
  network       = var.internet
  subnet        = var.internet_subnet
  userdatafile  = local.employee_userdata_file
  userdata_vars = local.employee_userdata_vars
}

## Attacker
module "attackers" {
  source        = "git@git-service.ait.ac.at:sct-cyberrange/terraform-modules/openstack-srv_noportsec-count.git?ref=v1.3.1"
  host_capacity = var.attacker_capacity
  hostname      = "attacker"
  tag           = "internet"
  image         = local.attacker_image
  flavor        = local.attacker_flavor
  volume_size   = local.attacker_volume_size
  sshkey        = var.sshkey
  network       = var.internet
  subnet        = var.internet_subnet
  userdatafile  = local.attacker_userdata_file
  userdata_vars = local.attacker_userdata_vars
}

## External Mail Servers
module "ext_mail" {
  count              = length(var.ext_mail)
  source             = "git@git-service.ait.ac.at:sct-cyberrange/terraform-modules/openstack-srv_noportsec.git?ref=v1.3.1"
  hostname           = "${var.ext_mail[count.index].name}_mail"
  host_address_index = var.ext_mail[count.index].ip_index
  tag                = "internet, ext_mail, mailserver"
  image              = local.ext_mail_image
  flavor             = local.ext_mail_flavor
  volume_size        = local.ext_mail_volume_size
  config_drive       = true
  sshkey             = var.sshkey
  network            = var.internet
  subnet             = var.internet_subnet
  userdatafile       = local.ext_mail_userdata_file
  userdata_vars      = local.ext_mail_userdata_vars
}