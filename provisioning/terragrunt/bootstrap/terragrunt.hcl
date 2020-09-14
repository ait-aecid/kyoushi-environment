terraform {
    source = "git@git-service.ait.ac.at:sct-cyberrange/terraform-modules/openstack-vmnets.git?ref=v1.2"
}

inputs = {
    host_name = "inet-firewall"
    host_image = "aecid-ubuntu-bionic-amd64"
    host_tag = "firewall"
    host_ext_ip = "100"
    host_userdata = "firewallinit.yml"
    ext_subnet = "internet-subnet"
    extnet = "internet"
    extnet_create = true
    router_name = "aecid-testbed-router"
    sshkey = "testbed-key"
    floating_ip_pool = "provider-aecid-208"
    networks = { 
	local = { 
                network = "local",
                host_address_index = "1",
		subnet = "local-subnet", 
		cidr = "172.16.0.0/24", 
                dns: ["8.8.8.8"] 
	}
        dmz = {
                network = "dmz",
                host_address_index = "1",
		subnet = "dmz-subnet"
		cidr = "172.16.100.0/24"
                dns: ["8.8.8.8"] 
        }
    }
}

include {
  path = find_in_parent_folders()
}
