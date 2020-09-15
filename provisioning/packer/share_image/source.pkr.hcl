# Sources

## Build Hosts
source "openstack" "builder" {
  flavor                = "${var.flavor}"
  floating_ip_network   = "${var.floating_ip_pool}"
  image_name            = "${var.timestamp_image ? format("%s-%s", var.image_name, timestamp()) : var.image_name}"
  networks              = ["${var.network}"]
  security_groups       = ["${var.security_group}"]
  ssh_ip_version        = "4"
  ssh_username          = "${var.build_user}"
  source_image_filter {
      filters {
          name = "${var.base_image}"
      }
      most_recent = true
  }
}