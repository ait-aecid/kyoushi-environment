terraform {
  backend "consul" {}
}

locals {
  ext_dns_userdata_file = var.ext_dns_userdata == null ? "${path.module}/scripts/default.yml" : var.ext_dns_userdata
  host_userdata_file = var.host_userdata == null ? "${path.module}/scripts/firewallinit.yml" : var.host_userdata
}

module "vmnets" {
  source = "git@git-service.ait.ac.at:sct-cyberrange/terraform-modules/openstack-vmnets.git?ref=v1.4"
  host_name = var.host_name
  host_image = var.host_image
  host_size = var.host_size
  host_flavor = var.host_flavor
  host_tag = var.host_tag
  host_ext_address_index = var.host_ext_address_index
  host_userdata = local.host_userdata_file
  ext_subnet = var.ext_subnet
  extnet = var.extnet
  extnet_create = true
  ext_cidr = var.ext_cidr
  ext_dns = concat([cidrhost(var.ext_cidr, var.ext_dns_address_index)], var.ext_additional_dns )
  router_name = var.router_name
  sshkey = var.sshkey
  floating_ip_pool = var.floating_ip_pool
  networks = var.networks
}

module "internet_dns" {
  count         = var.extnet_create  ? 1 : 0
  source        = "git@git-service.ait.ac.at:sct-cyberrange/terraform-modules/openstack-srv_noportsec.git?ref=v1.4"
  hostname      = var.ext_dns_name
  tag           = var.ext_dns_tag
  host_address_index = var.ext_dns_address_index
  image         = var.ext_dns_image
  flavor        = var.ext_dns_flavor
  volume_size   = var.ext_dns_size
  sshkey        = var.sshkey
  network       = module.vmnets.extnet.network
  subnet        = module.vmnets.extnet.subnet
  userdatafile  = local.ext_dns_userdata_file
  userdata_vars = var.ext_dns_userdata_vars
}