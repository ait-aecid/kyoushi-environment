# Module Outputs

output "mgmthost_floating_ip" {
  value = openstack_networking_floatingip_v2.mgmthost[0].address
}