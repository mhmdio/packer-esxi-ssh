source "vmware-iso" "this" {

  boot_command = [
    "<esc><wait10>",
    "<enter><wait10>",
    "c",
    "<wait>",
    "set gfxpayload=keep",
    "<enter><wait>",
    "linux /casper/vmlinuz quiet<wait>",
    " autoinstall<wait>",
    " ds=nocloud-net<wait>",
    "\\;s=http://<wait>",
    "{{.HTTPIP}}<wait>",
    ":{{.HTTPPort}}/<wait>",
    " ---",
    "<enter><wait>",
    "initrd /casper/initrd<wait>",
    "<enter><wait>",
    "boot<enter><wait>"
  ]

  vm_name                   = var.vm_name
  ssh_username              = var.username
  ssh_password              = var.password
  ssh_handshake_attempts    = 1000
  iso_checksum              = var.iso_checksum
  iso_url                   = "${var.iso_url}/${var.iso_directory}/${var.iso_name}"
  shutdown_command          = "echo 'vagrant' | sudo -S -E shutdown -P now"
  boot_wait                 = "10s"
  http_directory            = "http"
  communicator              = "ssh"
  guest_os_type             = "ubuntu-64"
  remote_type               = var.remote_type
  remote_host               = var.remote_host
  remote_password           = var.remote_password
  remote_username           = var.remote_username
  remote_port               = var.remote_port
  remote_datastore          = var.remote_datastore
  skip_validate_credentials = false
  ssh_timeout               = "1h"
  display_name              = var.vm_name
  cpus                      = var.cpus
  memory                    = var.memory
  disk_size                 = var.disk_size
  network_name              = "VM Network"
  network_adapter_type      = "VMXNET3"
  tools_upload_flavor       = "linux"
  headless                  = true

  vnc_over_websocket  = true
  insecure_connection = true

  # Output configuration
  skip_export      = false
  output_directory = "../build/${var.vm_name}"

  # Export configuration
  format          = "ova"
  skip_compaction = false

}
