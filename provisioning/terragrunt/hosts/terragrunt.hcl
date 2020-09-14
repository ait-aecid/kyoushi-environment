terraform {
    source = ".//module"
}

inputs = {
    # networks
    internet = "internet"
    internet_subnet = "internet-subnet"
    dmz = "dmz"
    dmz_subnet = "dmz-subnet"
    intranet = "local"
    intranet_subnet = "local-subnet"

    # image configuration
    image = "aecid-ubuntu-bionic-amd64"
    employee_image = "aecid-ubuntu-bionic-amd64"
    share_image = "aecid-ubuntu-bionic-amd64"

    sshkey = "testbed-key"

    employee_capacity        = 1
    remote_employee_capacity = 1
    attacker_capacity = 1
    
    shares = [
        {
            name     = "internal"
            ip_index = null
        }
    ]
}

include {
  path = find_in_parent_folders()
}
