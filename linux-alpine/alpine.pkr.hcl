# This file was autogenerated by the BETA 'packer hcl2_upgrade' command. We
# recommend double checking that everything is correct before going forward. We
# also recommend treating this file as disposable. The HCL2 blocks in this
# file can be moved to other files. For example, the variable blocks could be
# moved to their own 'variables.pkr.hcl' file, etc. Those files need to be
# suffixed with '.pkr.hcl' to be visible to Packer. To use multiple files at
# once they also need to be in the same folder. 'packer inspect folder/'
# will describe to you what is in that folder.

# Avoid mixing go templating calls ( for example ```{{ upper(`string`) }}``` )
# and HCL2 calls (for example '${ var.string_value_example }' ). They won't be
# executed together and the outcome will be unknown.

# All generated input variables will be of 'string' type as this is how Packer JSON
# views them; you can change their type later on. Read the variables type
# constraints documentation
# https://www.packer.io/docs/from-1.5/variables#type-constraints for more info.
variable "cpus" {
  type    = string
  default = "1"
}

variable "disk_size" {
  type    = string
  default = "8000"
}

variable "iso_checksum" {
  type    = string
  default = "fe694a34c0e2d30b9e5dea7e2c1a3892c1f14cb474b69cc5c557a52970071da5"
}

variable "iso_checksum_type" {
  type    = string
  default = "sha256"
}

variable "iso_download_url" {
  type    = string
  default = "http://dl-cdn.alpinelinux.org/alpine/v3.12/releases/x86_64/alpine-virt-3.12.0-x86_64.iso"
}

variable "iso_local_url" {
  type    = string
  default = "../../iso/alpine-virt-3.12.0-x86_64.iso"
}

variable "memory" {
  type    = string
  default = "1024"
}

variable "root_password" {
  type    = string
  default = "vagrant"
}

variable "ssh_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key"
}

variable "ssh_password" {
  type    = string
  default = "vagrant"
}

variable "ssh_username" {
  type    = string
  default = "vagrant"
}

variable "vm_name" {
  type    = string
  default = "alpine-3.12.0-x86_64"
}

# "timestamp" template function replacement
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/from-1.5/blocks/source
# could not parse template for following block: "template: hcl2_upgrade:19:42: executing \"hcl2_upgrade\" at <.Name>: can't evaluate field Name in type struct { HTTPIP string; HTTPPort string }"

source "virtualbox-iso" "autogenerated_1" {

  boot_command         = [
    "root<enter><wait>", 
    "ifconfig eth0 up && udhcpc -i eth0<enter><wait5>", 
    "wget http://{{ .HTTPIP }}:{{ .HTTPPort }}/answers<enter><wait>", 
    "setup-apkrepos -1<enter><wait>", 
    "printf \"{{user `root_password`}}\\n{{user `root_password`}}\\ny\\n\" | setup-alpine -f $PWD/answers ; ", 
    "mount /dev/sda3 /mnt && ", 
    "echo 'PermitRootLogin yes' >> /mnt/etc/ssh/sshd_config && ", 
    "umount /mnt ; reboot<enter>"
  ]

  boot_wait            = "10s"
  communicator         = "ssh"
  disk_size            = "{{user `disk_size`}}"
  format               = "ova"
  guest_additions_mode = "disable"
  guest_os_type        = "Linux26_64"
  headless             = false
  http_directory       = "http"
  iso_checksum         = "{{user `iso_checksum_type`}}:{{user `iso_checksum`}}"
  iso_urls             = ["{{user `iso_local_url`}}", "{{user `iso_download_url`}}"]
  keep_registered      = "false"
  shutdown_command     = "/sbin/poweroff"
  ssh_password         = "{{user `ssh_password`}}"
  ssh_timeout          = "10m"
  ssh_username         = "root"
  vboxmanage           = [["modifyvm", "{{.Name}}", "--memory", "{{user `memory`}}"], ["modifyvm", "{{.Name}}", "--cpus", "{{user `cpus`}}"], ["modifyvm", "{{.Name}}", "--rtcuseutc", "on"], ["modifyvm", "{{.Name}}", "--graphicscontroller", "vmsvga"], ["modifyvm", "{{.Name}}", "--vrde", "off"]]
  vm_name              = "{{user `vm_name`}}"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/from-1.5/blocks/build
build {
  description = "Build base Alpine Linux x86_64"

  sources = ["source.virtualbox-iso.autogenerated_1"]

  provisioner "shell" {
    inline = [
    "echo http://dl-cdn.alpinelinux.org/alpine/v3.12/community >> /etc/apk/repositories", 
    "apk update", 
    "apk add sudo", 
    "apk add virtualbox-guest-additions virtualbox-guest-modules-virt", 
    "echo '%wheel ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/wheel", 
    "user=${var.ssh_username}", 
    "echo Add user $user with NOPASSWD sudo", 
    "adduser $user --disabled-password", 
    "echo '${var.ssh_username}:${var.ssh_password}' | chpasswd", 
    "adduser $user wheel", 
    "echo add ssh key", 
    "cd ~${var.ssh_username}", 
    "mkdir .ssh", "chmod 700 .ssh", 
    "echo ${var.ssh_key} > .ssh/authorized_keys", 
    "chown -R $user .ssh",
    "echo disable ssh root login", 
    "sed '/PermitRootLogin yes/d' -i /etc/ssh/sshd_config"
  ]
  }
}
