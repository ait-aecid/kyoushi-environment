locals {
  # resolve defaults to actual values
  # be sure to use local values for *_image, *_flavor 
  # *_volume_size, *_userdata_file, *_userdata_vars

  # default user data
  userdata_file = var.userdata_file == null ? "${path.module}/scripts/default.yml" : var.userdata_file
  userdata_vars = var.userdata_vars == null ? {} : var.userdata_vars

  # employee values
  employee_image         = var.employee_image == null ? var.image : var.employee_image
  employee_flavor        = var.employee_flavor == null ? var.flavor : var.employee_flavor
  employee_volume_size   = var.employee_volume_size == null ? var.volume_size : var.employee_volume_size
  employee_userdata_file = var.employee_userdata_file == null ? local.userdata_file : var.employee_userdata_file
  employee_userdata_vars = var.employee_userdata_vars == null ? local.userdata_vars : var.employee_userdata_vars

  # attacker values
  attacker_image         = var.attacker_image == null ? var.image : var.attacker_image
  attacker_flavor        = var.attacker_flavor == null ? var.flavor : var.attacker_flavor
  attacker_volume_size   = var.attacker_volume_size == null ? var.volume_size : var.attacker_volume_size
  attacker_userdata_file = var.attacker_userdata_file == null ? local.userdata_file : var.attacker_userdata_file
  attacker_userdata_vars = var.attacker_userdata_vars == null ? local.userdata_vars : var.attacker_userdata_vars

  # vpn values
  vpn_image         = var.vpn_image == null ? var.image : var.vpn_image
  vpn_flavor        = var.vpn_flavor == null ? var.flavor : var.vpn_flavor
  vpn_volume_size   = var.vpn_volume_size == null ? var.volume_size : var.vpn_volume_size
  vpn_userdata_file = var.vpn_userdata_file == null ? local.userdata_file : var.vpn_userdata_file
  vpn_userdata_vars = var.vpn_userdata_vars == null ? local.userdata_vars : var.vpn_userdata_vars

  # mail values
  mail_image         = var.mail_image == null ? var.image : var.mail_image
  mail_flavor        = var.mail_flavor == null ? var.flavor : var.mail_flavor
  mail_volume_size   = var.mail_volume_size == null ? var.volume_size : var.mail_volume_size
  mail_userdata_file = var.mail_userdata_file == null ? local.userdata_file : var.mail_userdata_file
  mail_userdata_vars = var.mail_userdata_vars == null ? local.userdata_vars : var.mail_userdata_vars

  # intranet values
  intranet_image         = var.intranet_image == null ? var.image : var.intranet_image
  intranet_flavor        = var.intranet_flavor == null ? var.flavor : var.intranet_flavor
  intranet_volume_size   = var.intranet_volume_size == null ? var.volume_size : var.intranet_volume_size
  intranet_userdata_file = var.intranet_userdata_file == null ? local.userdata_file : var.intranet_userdata_file
  intranet_userdata_vars = var.intranet_userdata_vars == null ? local.userdata_vars : var.intranet_userdata_vars

  # share values
  share_image         = var.share_image == null ? var.image : var.share_image
  share_flavor        = var.share_flavor == null ? var.flavor : var.share_flavor
  share_volume_size   = var.share_volume_size == null ? var.volume_size : var.share_volume_size
  share_userdata_file = var.share_userdata_file == null ? local.userdata_file : var.share_userdata_file
  share_userdata_vars = var.share_userdata_vars == null ? local.userdata_vars : var.share_userdata_vars

}