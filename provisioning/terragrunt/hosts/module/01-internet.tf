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