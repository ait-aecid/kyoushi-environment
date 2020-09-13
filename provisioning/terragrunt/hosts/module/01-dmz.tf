# DMZ Hosts

module "vpn" {
  source             = "git@git-service.ait.ac.at:sct-cyberrange/terraform-modules/openstack-srv_noportsec.git?ref=v1.3"
  hostname           = "vpn"
  host_address_index = var.vpn_ip_index
  image              = local.vpn_image
  flavor             = local.vpn_flavor
  sshkey             = var.sshkey
  network            = var.dmz
  subnet             = var.dmz_subnet
  userdatafile       = local.vpn_userdata_file
  userdata_vars      = local.vpn_userdata_vars
}

module "mail" {
  source             = "git@git-service.ait.ac.at:sct-cyberrange/terraform-modules/openstack-srv_noportsec.git?ref=v1.3"
  hostname           = "mail"
  host_address_index = var.mail_ip_index
  image              = local.mail_image
  flavor             = local.mail_flavor
  sshkey             = var.sshkey
  network            = var.dmz
  subnet             = var.dmz_subnet
  userdatafile       = local.mail_userdata_file
  userdata_vars      = local.mail_userdata_vars
}
