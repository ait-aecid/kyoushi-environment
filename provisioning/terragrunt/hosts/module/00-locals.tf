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
  employee_use_volume    = var.employee_use_volume == null ? var.use_volume : var.employee_use_volume
  employee_userdata_file = var.employee_userdata_file == null ? local.userdata_file : var.employee_userdata_file
  employee_userdata_vars = var.employee_userdata_vars == null ? local.userdata_vars : var.employee_userdata_vars

  # attacker values
  attacker_image         = var.attacker_image == null ? var.image : var.attacker_image
  attacker_flavor        = var.attacker_flavor == null ? var.flavor : var.attacker_flavor
  attacker_volume_size   = var.attacker_volume_size == null ? var.volume_size : var.attacker_volume_size
  attacker_use_volume    = var.attacker_use_volume == null ? var.use_volume : var.attacker_use_volume
  attacker_userdata_file = var.attacker_userdata_file == null ? local.userdata_file : var.attacker_userdata_file
  attacker_userdata_vars = var.attacker_userdata_vars == null ? local.userdata_vars : var.attacker_userdata_vars

  # vpn values
  vpn_image         = var.vpn_image == null ? var.image : var.vpn_image
  vpn_flavor        = var.vpn_flavor == null ? var.flavor : var.vpn_flavor
  vpn_volume_size   = var.vpn_volume_size == null ? var.volume_size : var.vpn_volume_size
  vpn_use_volume    = var.vpn_use_volume == null ? var.use_volume : var.vpn_use_volume
  vpn_userdata_file = var.vpn_userdata_file == null ? local.userdata_file : var.vpn_userdata_file
  vpn_userdata_vars = var.vpn_userdata_vars == null ? local.userdata_vars : var.vpn_userdata_vars

  # mail values
  mail_image         = var.mail_image == null ? var.image : var.mail_image
  mail_flavor        = var.mail_flavor == null ? var.flavor : var.mail_flavor
  mail_volume_size   = var.mail_volume_size == null ? var.volume_size : var.mail_volume_size
  mail_use_volume    = var.mail_use_volume == null ? var.use_volume : var.mail_use_volume
  mail_userdata_file = var.mail_userdata_file == null ? local.userdata_file : var.mail_userdata_file
  mail_userdata_vars = var.mail_userdata_vars == null ? local.userdata_vars : var.mail_userdata_vars

  # cloud values
  cloud_image         = var.cloud_image == null ? var.image : var.cloud_image
  cloud_flavor        = var.cloud_flavor == null ? var.flavor : var.cloud_flavor
  cloud_volume_size   = var.cloud_volume_size == null ? var.volume_size : var.cloud_volume_size
  cloud_use_volume    = var.cloud_use_volume == null ? var.use_volume : var.cloud_use_volume
  cloud_userdata_file = var.cloud_userdata_file == null ? local.userdata_file : var.cloud_userdata_file
  cloud_userdata_vars = var.cloud_userdata_vars == null ? local.userdata_vars : var.cloud_userdata_vars

  # webserver values
  webserver_image         = var.webserver_image == null ? var.image : var.webserver_image
  webserver_flavor        = var.webserver_flavor == null ? var.flavor : var.webserver_flavor
  webserver_volume_size   = var.webserver_volume_size == null ? var.volume_size : var.webserver_volume_size
  webserver_use_volume    = var.webserver_use_volume == null ? var.use_volume : var.webserver_use_volume
  webserver_userdata_file = var.webserver_userdata_file == null ? local.userdata_file : var.webserver_userdata_file
  webserver_userdata_vars = var.webserver_userdata_vars == null ? local.userdata_vars : var.webserver_userdata_vars

  # intranet values
  intranet_image         = var.intranet_image == null ? var.image : var.intranet_image
  intranet_flavor        = var.intranet_flavor == null ? var.flavor : var.intranet_flavor
  intranet_volume_size   = var.intranet_volume_size == null ? var.volume_size : var.intranet_volume_size
  intranet_use_volume    = var.intranet_use_volume == null ? var.use_volume : var.intranet_use_volume
  intranet_userdata_file = var.intranet_userdata_file == null ? local.userdata_file : var.intranet_userdata_file
  intranet_userdata_vars = var.intranet_userdata_vars == null ? local.userdata_vars : var.intranet_userdata_vars

  # share values
  share_image         = var.share_image == null ? var.image : var.share_image
  share_flavor        = var.share_flavor == null ? var.flavor : var.share_flavor
  share_volume_size   = var.share_volume_size == null ? var.volume_size : var.share_volume_size
  share_use_volume    = var.share_use_volume == null ? var.use_volume : var.share_use_volume
  share_userdata_file = var.share_userdata_file == null ? local.userdata_file : var.share_userdata_file
  share_userdata_vars = var.share_userdata_vars == null ? local.userdata_vars : var.share_userdata_vars

  # monitoring values
  monitoring_image         = var.monitoring_image == null ? var.image : var.monitoring_image
  monitoring_flavor        = var.monitoring_flavor == null ? var.flavor : var.monitoring_flavor
  monitoring_volume_size   = var.monitoring_volume_size == null ? var.volume_size : var.monitoring_volume_size
  monitoring_use_volume    = var.monitoring_use_volume == null ? var.use_volume : var.monitoring_use_volume
  monitoring_userdata_file = var.monitoring_userdata_file == null ? local.userdata_file : var.monitoring_userdata_file
  monitoring_userdata_vars = var.monitoring_userdata_vars == null ? local.userdata_vars : var.monitoring_userdata_vars

  # mgmthost values
  mgmthost_image         = var.mgmthost_image == null ? var.image : var.mgmthost_image
  mgmthost_flavor        = var.mgmthost_flavor == null ? var.flavor : var.mgmthost_flavor
  mgmthost_volume_size   = var.mgmthost_volume_size == null ? var.volume_size : var.mgmthost_volume_size
  mgmthost_use_volume    = var.mgmthost_use_volume == null ? var.use_volume : var.mgmthost_use_volume
  mgmthost_userdata_file = var.mgmthost_userdata_file == null ? local.userdata_file : var.mgmthost_userdata_file
  mgmthost_userdata_vars = var.mgmthost_userdata_vars == null ? local.userdata_vars : var.mgmthost_userdata_vars

  # external mail servers values
  ext_mail_image         = var.ext_mail_image == null ? var.image : var.ext_mail_image
  ext_mail_flavor        = var.ext_mail_flavor == null ? var.flavor : var.ext_mail_flavor
  ext_mail_volume_size   = var.ext_mail_volume_size == null ? var.volume_size : var.ext_mail_volume_size
  ext_mail_use_volume    = var.ext_mail_use_volume == null ? var.use_volume : var.ext_mail_use_volume
  ext_mail_userdata_file = var.ext_mail_userdata_file == null ? local.userdata_file : var.ext_mail_userdata_file
  ext_mail_userdata_vars = var.ext_mail_userdata_vars == null ? local.userdata_vars : var.ext_mail_userdata_vars

  # external users values
  ext_user_image         = var.ext_user_image == null ? var.image : var.ext_user_image
  ext_user_flavor        = var.ext_user_flavor == null ? var.flavor : var.ext_user_flavor
  ext_user_volume_size   = var.ext_user_volume_size == null ? var.volume_size : var.ext_user_volume_size
  ext_user_use_volume    = var.ext_user_use_volume == null ? var.use_volume : var.ext_user_use_volume
  ext_user_userdata_file = var.ext_user_userdata_file == null ? local.userdata_file : var.ext_user_userdata_file
  ext_user_userdata_vars = var.ext_user_userdata_vars == null ? local.userdata_vars : var.ext_user_userdata_vars

}
