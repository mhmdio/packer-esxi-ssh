# All generated input variables will be of 'string' type as this is how Packer JSON
# views them; you can change their type later on. Read the variables type
# constraints documentation
# https://www.packer.io/docs/from-1.5/variables#type-constraints for more info.


variable "preseed_path" {
  type    = string
  default = "preseed.cfg"
}

variable "cpus" {
  type    = string
  default = "2"
}

variable "memory" {
  type    = string
  default = "2048"
}

variable "disk_size" {
  type    = number
  default = 8000
}

variable "iso_checksum" {
  type    = string
  default = "defdc1ad3af7b661fe2b4ee861fb6fdb5f52039389ef56da6efc05e6adfe3d45"
}

variable "iso_url" {
  type    = string
  default = "http://releases.ubuntu.com"
}

variable "iso_directory" {
  type    = string
  default = "groovy"
}

variable "iso_name" {
  type    = string
  default = "ubuntu-20.10-live-server-amd64.iso"
}

variable "password" {
  type        = string
  default     = "vagrant"
  description = "vm password"
  sensitive   = true
}

variable "username" {
  type    = string
  default = "vagrant"
}

variable "vm_name" {
  type    = string
  default = "ubuntu2010"
}

variable "remote_type" {
  type    = string
  default = "esx5"
}

variable "remote_port" {
  type    = number
  default = 22
}

variable "remote_host" {
  type = string
}

variable "remote_password" {
  type        = string
  description = "esxi password"
  sensitive   = true
}

variable "remote_username" {
  type = string
}

variable "remote_datastore" {
  type = string
}
