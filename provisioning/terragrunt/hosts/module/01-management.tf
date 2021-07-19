module "mgmthost" {
  count              = var.mgmthost_active ? 1 : 0
  source             = "git@github.com:ait-cs-IaaS/terraform-openstack-srv_noportsec.git?ref=v1.4.3"
  hostname           = "mgmthost"
  tag                = "management"
  host_address_index = var.mgmthost_ip_index
  image              = local.mgmthost_image
  flavor             = local.mgmthost_flavor
  volume_size        = local.mgmthost_volume_size
  use_volume         = local.mgmthost_use_volume
  sshkey             = var.sshkey
  network            = var.internet
  subnet             = var.internet_subnet
  additional_networks = {
    intranet = {
      network            = var.intranet
      subnet             = var.intranet_subnet
      host_address_index = null
    }

    dmz = {
      network            = var.dmz
      subnet             = var.dmz_subnet
      host_address_index = null
    }
  }
  userdatafile  = local.mgmthost_userdata_file
  userdata_vars = local.mgmthost_userdata_vars
}

resource "openstack_networking_floatingip_v2" "mgmthost" {
  count = var.mgmthost_active && var.floating_ip_pool != null ? 1 : 0
  pool  = var.floating_ip_pool
}

resource "openstack_compute_floatingip_associate_v2" "mgmthost" {
  count       = var.mgmthost_active && var.floating_ip_pool != null ? 1 : 0
  floating_ip = openstack_networking_floatingip_v2.mgmthost[0].address
  instance_id = module.mgmthost[0].server.id
}
