terraform {
    source = "git@git-service.ait.ac.at:ict-caiscluster/aecid/testbed/terraform/modules/openstack-testbed-networks.git"
}

inputs = {
    extnet-id = "065398c8-b3cb-48c8-8617-d72038557e66"
    local-cidr = "172.16.0.0/24"
    dmz-cidr = "172.16.100.0/24"
    dns = ["8.8.8.8"]
    fwlocalip = "172.16.0.1"
    fwdmzip = "172.16.100.1"
}

include {
  path = find_in_parent_folders()
}
