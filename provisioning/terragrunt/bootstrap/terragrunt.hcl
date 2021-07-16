terraform {
    source = ".//module"
}

inputs = {
    # firewall host
    host_name = "inet-firewall"
    host_image = "aecid-ubuntu-bionic-amd64"
    host_tag = "firewall, dnsservers, servers"
    host_ext_address_index = 42420
    host_flavor = "m1.medium"
    host_size  = 40
    host_userdata = "firewallinit.yml"

    # external dns server
    ext_dns_name = "inet-dns"
    ext_dns_image = "aecid-ubuntu-bionic-amd64"
    ext_dns_tag = "internet, dnsservers"
    ext_dns_ext_address_index = 22
    ext_dns_size = 20

    ext_subnet = "internet-subnet"
    extnet = "internet"
    extnet_create = true
    ext_dns_address_index = 13370
    router_name = "aecid-testbed-router"
    sshkey = "testbed-key"
    floating_ip_pool = "provider-aecid-208"
    networks = {
        local = {
            network = "local",
            host_address_index = "1",
            subnet = "local-subnet",
            cidr = "172.16.0.0/24",
            dns = [],
            host_as_dns = true,
            routes = null
            fw_routes = null
        }
        dmz = {
            network = "dmz",
            host_address_index = "1",
            subnet = "dmz-subnet"
            cidr = "172.16.100.0/24"
            dns = [],
            host_as_dns = true,
            routes = null
            fw_routes = null
        }
    }
}

include {
    path = find_in_parent_folders()
}
