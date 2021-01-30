source "vmware-iso" "this" {

  cd_label = "cidata"
  cd_files = [
    "./http/meta-data",
    "./http/user-data"
  ]
  boot_wait = "10s"
  boot_key_interval = "0.1s"
  boot_command = [
    "<esc><wait10>",
    "<enter><wait10>",
    "c",
    "<wait>",
    "set gfxpayload=keep",
    "<enter><wait>",
    "linux /casper/vmlinuz quiet<wait>",
    " autoinstall<wait>",
    " ---",
    "<enter><wait>",
    "initrd /casper/initrd<wait>",
    "<enter><wait>",
    "boot<enter><wait>"
  ]

  vm_name      = var.vm_name
  ssh_username = var.username
  ssh_password = var.password
  ssh_pty = true
  ssh_timeout = "20m"
  ssh_handshake_attempts = "20"
  # pause_before_connecting = "10m"
  iso_checksum = var.iso_checksum
  iso_url      = "${var.iso_url}/${var.iso_directory}/${var.iso_name}"
  #   floppy_files              = ["../files/ubuntu/http/16.04/preseed.cfg"]
  shutdown_command          = "echo 'vagrant' | sudo -S -E shutdown -P now"
  http_directory            = "./http"
  communicator              = "ssh"
  guest_os_type             = "ubuntu-64"
  remote_type               = var.remote_type
  remote_host               = var.remote_host
  remote_password           = var.remote_password
  remote_username           = var.remote_username
  remote_port               = var.remote_port
  remote_datastore          = var.remote_datastore
  skip_validate_credentials = false
  display_name              = var.vm_name
  cpus                      = var.cpus
  memory                    = var.memory
  disk_size                 = var.disk_size
  network_name              = "VM Network"
  network_adapter_type      = "VMXNET3"
  tools_upload_flavor       = "linux"
  headless                  = false

  # vnc_disable_password = "true"
  vnc_over_websocket  = true
  insecure_connection = true


  #   vmx_data = {
  #     "ethernet0.networkName" = "Management Network"
  #     # "ethernet0.connectionType"                 = "custom"
  #     # "ethernet0.present" = "TRUE"
  #     # "ethernet0.virtualDev"                     = "vmxnet3"
  #     # "ethernet0.vnet"                           = "Management Network"
  #     # "gui.fitguestusingnativedisplayresolution" = "FALSE"
  #     # memsize                                    = var.ram_size
  #     # numvcpus                                   = var.cpu
  #     # "scsi0.virtualDev"                         = "lsisas1068"
  #     # "virtualHW.version"                        = "10"
  #   }

  vmx_data_post = {
    "ide0:0.clientDevice"   = "TRUE"
    "ide0:0.deviceType"     = "cdrom-raw"
    "ide0:0.fileName"       = "emptyBackingString"
    "ide0:0.present"        = "FALSE"
    "ide0:0.startConnected" = "FALSE"
    "ide0:1.clientDevice"   = "TRUE"
    "ide0:1.deviceType"     = "cdrom-raw"
    "ide0:1.fileName"       = "emptyBackingString"
    "ide0:1.present"        = "FALSE"
    "ide0:1.startConnected" = "FALSE"
    "ide1:0.clientDevice"   = "TRUE"
    "ide1:0.deviceType"     = "cdrom-raw"
    "ide1:0.fileName"       = "emptyBackingString"
    "ide1:0.present"        = "TRUE"
    "ide1:0.startConnected" = "FALSE"
    "ide1:1.clientDevice"   = "TRUE"
    "ide1:1.deviceType"     = "cdrom-raw"
    "ide1:1.fileName"       = "emptyBackingString"
    "ide1:1.present"        = "FALSE"
    "ide1:1.startConnected" = "FALSE"
  }

    # Output configuration
  skip_export      = false
  output_directory = "../build/${var.vm_name}"

  # Export configuration
  format          = "ova"
  skip_compaction = false

}
