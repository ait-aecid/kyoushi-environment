variable "networks" {
  type = map(
    object({
      network            = string
      subnet             = string
      cidr               = string
      dns                = list(string)
      host_address_index = number
      host_as_dns        = bool
    })
  )
  description = "map of internal networks to be created. (Note that if host_as_dns is true host_address_index must not be null)"
}

variable "host_name" {
  type        = string
  description = "Name of the virtual machine"
}

variable "host_tag" {
  type        = string
  description = "Tag for the virtual machine"
}

variable "host_ext_address_index" {
  type        = number
  description = "External IP address index for the host"
  default     = null

}

variable "host_image" {
  type        = string
  description = "Name of the image to use for the virtual machine"
}

variable "host_userdata" {
  type        = string
  description = "Userdata for the virtual machine"
  default     = null
}

variable "host_flavor" {
  type        = string
  description = "Flavor of the virtual machine"
  default     = "m1.small"
}

variable "host_size" {
  type        = number
  description = "Disksize in gb of the virtual machine"
  default     = 5
}

variable "host_delete_on_termination" {
  type        = bool
  description = "Delete host on termination"
  default     = false
}

variable "sshkey" {
  type        = string
  description = "ssh key for the virtual machine"
}

variable "extnet" {
  type        = string
  description = "Name or id of the network to connect the host to (if extnet_create=true always assumed to be name)"
}

variable "ext_subnet" {
  type        = string
  description = "Name or id of the subnet to connect the host to (if extnet_create=true always assumed to be name)"
}

variable "extnet_create" {
  type        = bool
  description = "Flag determining if extnet is created or pre-existing network is used (true -> create, false -> use existing)"
  default     = false
}

variable "ext_cidr" {
  type        = string
  description = "CIDR of the subnet to connect the host to (only needed if extnet_create=true)"
  default     = "192.42.0.0/16"
}

variable "ext_dns" {
  type        = list(string)
  description = "List of dns-servers (only needed if extnet_create=true)"
  default     = ["8.8.8.8"]
}

variable "router_name" {
  type        = string
  description = "Name of the public router to connect the ext_subnet to (only needed if extnet_create=true)"
  default     = null
}

variable "floating_ip_pool" {
  type        = string
  description = "The floating ip pool to use, if not set no floating ip will be assigned to the router host"
  default     = null
}

variable "ext_dns_name" {
  type        = string
  description = "Name of the virtual machine"
  default     = "inet-dns"
}

variable "ext_dns_tag" {
  type        = string
  description = "Tag for the virtual machine"
  default     = null
}

variable "ext_dns_address_index" {
  type        = number
  description = "External IP address index for the ext_dns"
  default     = null

}

variable "ext_dns_image" {
  type        = string
  description = "Name of the image to use for the virtual machine"
  default     = null
}

variable "ext_dns_userdata" {
  type        = string
  description = "Userdata for the virtual machine"
  default     = null
}

variable "ext_dns_flavor" {
  type        = string
  description = "Flavor of the virtual machine"
  default     = "m1.small"
}

variable "ext_dns_size" {
  type        = number
  description = "Disksize in gb of the virtual machine (only when volumes are used)"
  default     = 5
}

variable "ext_dns_use_volume" {
  type        = bool
  description = "If the compute node should use a volume or root file"
  default     = false
}

variable "ext_dns_userdata_vars" {
  type        = map(string)
  description = "variables for the userdata template"
  default     = {}
}

variable "ext_additional_dns" {
  type        = list(string)
  description = "addtional external dns servers to configure for the internet"
  default     = []
}

