# Infrastructure Provisioning

## Start working

1. Connect to the OpenStack VPN
2. Activate your  `OpenStack RC file`: `source <file path>`

## Prerequisites

1. An external network(Self-Service Network)
2. Disable port-security on external network
3. Required base images uploaded (e.g., ubuntu, debian)
4. Custom packer images built and available in the OpenStack project

## Bootstrap Sequence

1. Install SSH-keys: cd keys && terragrunt apply
2. Install Basic-Infrastructure: cd bootstrap && terragrunt apply
3. Go back to main directory: cd ..
4. Deploy the hosts: cd hosts && terragrunt apply
