# General inputs

variable "sshkey" {
  type        = string
  description = "ssh key for the server"
  default     = "cyberrange-key"
}

variable "image" {
  type        = string
  description = "name or id of the base image for normal hosts"
}

variable "flavor" {
  type        = string
  description = "instance flavor for the server"
  default     = "m1.small"
}

variable "volume_size" {
  type        = string
  description = "volume_size"
  default     = 5
}

variable "userdata_file" {
  type        = string
  description = "optional override for the default userdata file (defaults to '{path.module}/scripts/default.yml')"
  default     = null
}

variable "userdata_vars" {
  type        = map(string)
  description = "variables for the userdata template"
  default     = null
}

# Network inputs 

variable "internet" {
  type        = string
  description = "name or id of the internet network"
}

variable "internet_subnet" {
  type        = string
  description = "name or id of the internet subnet"
}

variable "dmz" {
  type        = string
  description = "name or id of the dmz network"
}

variable "dmz_subnet" {
  type        = string
  description = "name or id of the dmz subnet"
}

variable "intranet" {
  type        = string
  description = "name or id of the intranet network"
}

variable "intranet_subnet" {
  type        = string
  description = "name or id of the intranet subnet"
}

# Employee inputs

variable "employee_image" {
  type        = string
  description = "optional name or id of the base image for employee hosts (defaults to image)"
  default     = null
}

variable "employee_flavor" {
  type        = string
  description = "optional instance flavor for the employee hosts (defaults to flavor)"
  default     = null
}

variable "employee_volume_size" {
  type        = string
  description = "volume_size for the employee hosts (defaults to volume_size)"
  default     = null
}

variable "employee_userdata_file" {
  type        = string
  description = "optional override for the default userdata file for employee hosts (defaults to userdata_file')"
  default     = null
}

variable "employee_userdata_vars" {
  type        = map(string)
  description = "optional override for the variables for the userdata template for employee hosts (defaults to userdata_vars)"
  default     = null
}

variable "employee_capacity" {
  type        = number
  description = "number of employee clients in the intranet"
}

variable "employee_ip_start_index" {
  type        = number
  description = "optional start index for internal employee clients"
  default     = null
}

variable "remote_employee_capacity" {
  type        = number
  description = "number of remote employee clients in the internet"
}

# Attacker inputs

variable "attacker_image" {
  type        = string
  description = "optional name or id of the base image for attacker hosts (defaults to image)"
  default     = null
}

variable "attacker_flavor" {
  type        = string
  description = "optional instance flavor for the attacker hosts (defaults to flavor)"
  default     = null
}

variable "attacker_volume_size" {
  type        = string
  description = "volume_size for the attacker hosts (defaults to volume_size)"
  default     = null
}

variable "attacker_userdata_file" {
  type        = string
  description = "optional override for the default userdata file for attacker hosts (defaults to userdata_file')"
  default     = null
}

variable "attacker_userdata_vars" {
  type        = map(string)
  description = "optional override for the variables for the userdata template for attacker hosts (defaults to userdata_vars)"
  default     = null
}

variable "attacker_capacity" {
  type        = number
  description = "number of attackers in the internet"
}

# Server inputs

## VPN Server inputs

variable "vpn_image" {
  type        = string
  description = "optional name or id of the base image for vpn host (defaults to image)"
  default     = null
}

variable "vpn_flavor" {
  type        = string
  description = "optional instance flavor for the vpn host (defaults to flavor)"
  default     = null
}

variable "vpn_volume_size" {
  type        = string
  description = "volume_size for the vpn host (defaults to volume_size)"
  default     = null
}

variable "vpn_userdata_file" {
  type        = string
  description = "optional override for the default userdata file for the vpn host (defaults to userdata_file')"
  default     = null
}

variable "vpn_userdata_vars" {
  type        = map(string)
  description = "optional override for the variables for the userdata template for the vpn host (defaults to userdata_vars)"
  default     = null
}

variable "vpn_ip_index" {
  type        = number
  description = "optional host address index for the VPN server"
  default     = null
}

variable "vpn_active" {
  type        = bool
  description = "boolean flag controling if the vpn server is present or not"
  default     = true
}

## Mail Server inputs

variable "mail_image" {
  type        = string
  description = "optional name or id of the base image for the mail server host (defaults to image)"
  default     = null
}

variable "mail_flavor" {
  type        = string
  description = "optional instance flavor for the the mail server host (defaults to flavor)"
  default     = null
}

variable "mail_volume_size" {
  type        = string
  description = "volume_size for the the mail server host (defaults to volume_size)"
  default     = null
}

variable "mail_userdata_file" {
  type        = string
  description = "optional override for the default userdata file for the mail host (defaults to userdata_file')"
  default     = null
}

variable "mail_userdata_vars" {
  type        = map(string)
  description = "optional override for the variables for the userdata template for the mail host (defaults to userdata_vars)"
  default     = null
}

variable "mail_ip_index" {
  type        = number
  description = "optional host address index for the mail server"
  default     = null
}

variable "mail_active" {
  type        = bool
  description = "boolean flag controling if the mail server is present or not"
  default     = true
}

## Cloud share inputs

variable "cloud_image" {
  type        = string
  description = "optional name or id of the base image for the cloud server host (defaults to image)"
  default     = null
}

variable "cloud_flavor" {
  type        = string
  description = "optional instance flavor for the the cloud server host (defaults to flavor)"
  default     = null
}

variable "cloud_volume_size" {
  type        = string
  description = "volume_size for the the cloud server host (defaults to volume_size)"
  default     = null
}

variable "cloud_userdata_file" {
  type        = string
  description = "optional override for the default userdata file for the cloud host (defaults to userdata_file')"
  default     = null
}

variable "cloud_userdata_vars" {
  type        = map(string)
  description = "optional override for the variables for the userdata template for the cloud host (defaults to userdata_vars)"
  default     = null
}

variable "cloud_ip_index" {
  type        = number
  description = "optional host address index for the cloud server"
  default     = null
}

variable "cloud_active" {
  type        = bool
  description = "boolean flag controling if the cloud server is present or not"
  default     = true
}

## Webserver share inputs

variable "webserver_image" {
  type        = string
  description = "optional name or id of the base image for the webserver server host (defaults to image)"
  default     = null
}

variable "webserver_flavor" {
  type        = string
  description = "optional instance flavor for the the webserver server host (defaults to flavor)"
  default     = null
}

variable "webserver_volume_size" {
  type        = string
  description = "volume_size for the the webserver server host (defaults to volume_size)"
  default     = null
}

variable "webserver_userdata_file" {
  type        = string
  description = "optional override for the default userdata file for the webserver host (defaults to userdata_file')"
  default     = null
}

variable "webserver_userdata_vars" {
  type        = map(string)
  description = "optional override for the variables for the userdata template for the webserver host (defaults to userdata_vars)"
  default     = null
}

variable "webserver_ip_index" {
  type        = number
  description = "optional host address index for the webserver server"
  default     = null
}

variable "webserver_active" {
  type        = bool
  description = "boolean flag controling if the web server is present or not"
  default     = true
}

## Intranet Server inputs 

variable "intranet_image" {
  type        = string
  description = "optional name or id of the base image for intranet host (defaults to image)"
  default     = null
}

variable "intranet_flavor" {
  type        = string
  description = "optional instance flavor for the intranet host (defaults to flavor)"
  default     = null
}

variable "intranet_volume_size" {
  type        = string
  description = "volume_size for the intranet host (defaults to volume_size)"
  default     = null
}

variable "intranet_userdata_file" {
  type        = string
  description = "optional override for the default userdata file for the intranet host (defaults to userdata_file')"
  default     = null
}

variable "intranet_userdata_vars" {
  type        = map(string)
  description = "optional override for the variables for the userdata template for the intranet host (defaults to userdata_vars)"
  default     = null
}

variable "intranet_ip_index" {
  type        = number
  description = "optional host address index for the intranet server"
  default     = null
}

variable "intranet_active" {
  type        = bool
  description = "boolean flag controling if the intranet server is present or not"
  default     = true
}

## Shares inputs

variable "share_image" {
  type        = string
  description = "optional name or id of the base image for share hosts (defaults to image)"
  default     = null
}

variable "share_flavor" {
  type        = string
  description = "optional instance flavor for the share hosts (defaults to flavor)"
  default     = null
}

variable "share_volume_size" {
  type        = string
  description = "volume_size for the share hosts (defaults to volume_size)"
  default     = null
}

variable "share_userdata_file" {
  type        = string
  description = "optional override for the default userdata file for share hosts (defaults to userdata_file')"
  default     = null
}

variable "share_userdata_vars" {
  type        = map(string)
  description = "optional override for the variables for the userdata template for share hosts (defaults to userdata_vars)"
  default     = null
}

# share names will be post fixed with internal
variable "shares" {
  type = list(object({
    name     = string
    ip_index = number
  }))
  default = [
    {
      name     = "internal"
      ip_index = null
    }
  ]
}

## Monitoring Server inputs 

variable "monitoring_image" {
  type        = string
  description = "optional name or id of the base image for monitoring host (defaults to image)"
  default     = null
}

variable "monitoring_flavor" {
  type        = string
  description = "optional instance flavor for the monitoring host (defaults to flavor)"
  default     = null
}

variable "monitoring_volume_size" {
  type        = string
  description = "volume_size for the monitoring host (defaults to volume_size)"
  default     = null
}

variable "monitoring_userdata_file" {
  type        = string
  description = "optional override for the default userdata file for the monitoring host (defaults to userdata_file')"
  default     = null
}

variable "monitoring_userdata_vars" {
  type        = map(string)
  description = "optional override for the variables for the userdata template for the monitoring host (defaults to userdata_vars)"
  default     = null
}

variable "monitoring_ip_index" {
  type        = number
  description = "optional host address index for the monitoring server"
  default     = null
}

variable "monitoring_active" {
  type        = bool
  description = "boolean flag controling if the monitoring server is present or not"
  default     = true
}

## Management Server inputs 

variable "mgmthost_image" {
  type        = string
  description = "optional name or id of the base image for mgmthost (defaults to image)"
  default     = null
}

variable "mgmthost_flavor" {
  type        = string
  description = "optional instance flavor for the mgmthost (defaults to flavor)"
  default     = null
}

variable "mgmthost_volume_size" {
  type        = string
  description = "volume_size for the mgmthost (defaults to volume_size)"
  default     = null
}

variable "mgmthost_userdata_file" {
  type        = string
  description = "optional override for the default userdata file for the mgmthost host (defaults to userdata_file')"
  default     = null
}

variable "mgmthost_userdata_vars" {
  type        = map(string)
  description = "optional override for the variables for the userdata template for the mgmthost host (defaults to userdata_vars)"
  default     = null
}

variable "mgmthost_ip_index" {
  type        = number
  description = "optional host address index for the mgmthost"
  default     = null
}

variable "mgmthost_active" {
  type        = bool
  description = "boolean flag controling if the mgmthost is present or not"
  default     = true
}

variable "floating_ip_pool" {
  type        = string
  description = "Floating ip pool to use for the management host"
  default     = null
}


