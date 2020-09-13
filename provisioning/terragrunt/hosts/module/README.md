# Testbed - Hosts

This repository contains a terraform module defining the hosts for the AECID testbed. 

## Network Overview

<center>
<img src="network.svg" alt="Network Graphic" width=40%/>
<div><em>Testbed Hosts Network Overview</em></div>
</center>

## Example Usage

```terragrunt
terraform {
    source = ".//hosts"
}

inputs = {
    internet = "testnet"
    internet_subnet = "testsubnet"
    dmz = "dmz"
    dmz_subnet = "dmz-subnet"
    intranet = "local"
    intranet_subnet = "local-subnet"

    # image configuration
    image = "cr-ubuntu-bionic-amd64"
    employee_image = "cr-client-ubuntu-2020-04-14_10-30-22"
    share_image = "cr-samba-4.5.9-2019-11-15_12-25-25"

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
```

## Ansible Groups and Hosts

The following Ansible groups and hosts will be available after applying this module (assuming all hosts have been configured to be deployed).  
Groups are prefixed with `+`:


- `+internet`
  - `+remote_employee`
    - ...
  - `+attacker`
    - attacker_\<nr\>
- `+dmz`
  - vpn
  - cloud_share
  - webserver
  - mail
- `+intranet`
  - `+internal_employee`
    - ...
  - intranet_server
  - `+share`
    - \<name\>_share

- `+employee`
  - `+remote_employee`
    - remote_employee_\<nr\>
  - `+internal_employee`
    - internal_employee_\<nr\>


