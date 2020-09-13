# DMZ Hosts

module "vpn" {
  count              = var.vpn_active ? 1 : 0
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
  count              = var.mail_active ? 1 : 0
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

module "cloud_share" {
  count              = var.cloud_active ? 1 : 0
  source             = "git@git-service.ait.ac.at:sct-cyberrange/terraform-modules/openstack-srv_noportsec.git?ref=v1.3"
  hostname           = "cloud_share"
  host_address_index = var.cloud_ip_index
  image              = local.cloud_image
  flavor             = local.cloud_flavor
  sshkey             = var.sshkey
  network            = var.dmz
  subnet             = var.dmz_subnet
  userdatafile       = local.cloud_userdata_file
  userdata_vars      = local.cloud_userdata_vars
}

module "webserver" {
  count              = var.webserver_active ? 1 : 0
  source             = "git@git-service.ait.ac.at:sct-cyberrange/terraform-modules/openstack-srv_noportsec.git?ref=v1.3"
  hostname           = "webserver"
  host_address_index = var.webserver_ip_index
  image              = local.webserver_image
  flavor             = local.webserver_flavor
  sshkey             = var.sshkey
  network            = var.dmz
  subnet             = var.dmz_subnet
  userdatafile       = local.webserver_userdata_file
  userdata_vars      = local.webserver_userdata_vars
}
