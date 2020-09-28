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
    employee_image = "aecid-employee-bionic-amd64-2020-09-15T20:46:23Z"
    share_image = "aecid-samba-4.5.9-bionic-amd64-2020-09-15T21:20:23Z"

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
