source "vmware-iso" "wins2025" {
 
  vm_name               = "${var.build_os}-${var.build_type}-${local.build_time}"

  # vm settings workstation
  guest_os_type         = var.guest_os_type
  firmware              = var.firmware
  version               = var.vm_version
  cpus                  = var.cpus
  cores                 = var.cpu_cores
  memory                = var.memory
  network_adapter_type  = "vmxnet3"
  disk_adapter_type     = "nvme"
  cdrom_adapter_type    = "ide"

  # workstation build settings
  iso_url                   = var.iso_path
  iso_checksum              = var.iso_checksum
  floppy_files              = ["files/wins2025/${var.build_type}/autounattend.xml","files/wins2025/bootstrap.ps1"]
  cd_files                  = var.cd_files
  communicator              = "ssh"
  ssh_username              = "Administrator"
  ssh_password              = var.ssh_password
  ssh_timeout               = var.ssh_timeout
  ssh_clear_authorized_keys = "true"
  boot_wait                 = "3s"
  boot_command              = ["<spacebar><spacebar>"]
  shutdown_command          = "shutdown /s /t 10 /f"
  output_directory          = "build/${var.build_os}-${var.build_type}-${local.build_time}"
  disk_size                 = var.disk_size
  vmx_data_post = {
    "ide1:0.present" = "FALSE"
    "ide0:0.present" = "FALSE"
    "floppy0.present" = "FALSE"
  }
}

build {
  sources = ["source.vmware-iso.wins2025"]

  provisioner "powershell" {
    script   = "provisioning/wins2025/services.ps1"
  }

  provisioner "powershell" {
    script   = "provisioning/wins2025/customize.ps1"
  }

  provisioner "powershell" {
    script   = "provisioning/wins2025/cleanup.ps1"
  }
  
  provisioner "windows-shell" {
    inline = ["ipconfig"]
  }

  #provisioner "windows-update" {
  #  filters = [
  #    "exclude:$_.Title -like '*Broadcom Inc.*'",
  #    "include:$true"
  #  ]
  #}

}