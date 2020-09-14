terraform {
    source = "git@git-service.ait.ac.at:sct-cyberrange/terraform-modules/openstack-sshkey.git?ref=v1.0"

    # for the keys we have to use a state file per user since OpenStack keypairs are user specific ressource
    extra_arguments "custom_state_file" {
      commands = [ "init" ]
      arguments = [
        "-backend-config=path=${get_env("OS_USER_DOMAIN_NAME","aecid")}/users/${get_env("OS_USERNAME","DEFAULT")}/${path_relative_to_include()}/aecid.tfstate"
      ]
    }
}

inputs = {
    name = "testbed-key"
    key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDtSS/6glvP/0Or/ZSJrIH8B3Mo+ORQTJd0HqaMDppbz6BE7saezHskWO+ItGhjqv6G9RiXS8uDS8aRYx+z0B9+iRbRnZZvg9Zwaf6YP8rJs4jM2wXOqWWb16K9pA6aO3rh7WAV81cDHRIoq6ek/klmEgs9clLGHAesAbbO6PqEyJI1wh/GLpqKxEfi99jq+YhjZn6upaE5acIR7W6bYnShtv0HCCrotMRQqC3b7e4B6IwrOOBA3+Xo/SeQrGvZNT9eKOVODqQm9qRzOkJdqK3Qy82QAAKVtV2stf8FG6/AzWdrrbCFItXg2cPnPVx7usHHuDtA77HoFpRptfXmfb35"
}

include {
  path = find_in_parent_folders()
}

