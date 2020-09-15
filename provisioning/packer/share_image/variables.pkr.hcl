# Input Variables 

variable "ansible_groups" {
  type    = list(string)
  description = "The ansible groups to assign to the build host"
  default = ["all"]
}

variable "base_image" {
  type    = string
  description = "The base image to build from"
}

variable "flavor" {
    type = string
    description = "The openstack flavor to use for the build host"
    default = "m1.small"
}

variable "security_group" {
    type = string
    description = "The security group to use fo the build host (must allow SSH)"
}

variable "network" {
    type = string
    description = "The openstack network to use for the build host"
}

variable "floating_ip_pool" {
    type = string
    description = "Name of the floating IP pool to use for the build host"
}

variable "image_name" {
    type = string
    description = "The name to use for the resulting image"
}

variable "timestamp_image" {
    type = bool
    description = "Image name is suffixed with a build timestamp if set to true"
    default = true
}


variable "build_user" {
  type    = string
  description = "User to use when building the image"
  default = "ubuntu"
}