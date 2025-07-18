source "vmware-iso" "ubuntu" {
 
  vm_name = "${var.build_os}-${local.build_time}"

  # vm settings workstation
  guest_os_type         = var.guest_os_type
  firmware              = var.firmware
  version               = var.vm_version
  cpus                  = var.cpus
  cores                 = var.cpu_cores
  memory                = var.memory
  network_adapter_type  = "vmxnet3"
  disk_adapter_type     = "scsi"
  cdrom_adapter_type    = "ide"

  # workstation build settings
  iso_url                   = var.iso_path
  iso_checksum              = var.iso_checksum
  cd_files                  = ["files/${var.build_os}/meta-data","files/${var.build_os}/user-data"]
  cd_label                  = "cidata"
  communicator              = "ssh"
  ssh_username              = var.ssh_username
  ssh_password              = var.ssh_password
  ssh_timeout               = var.ssh_timeout
  ssh_clear_authorized_keys = "true"
  boot_wait                 = "3s"
  boot_command              = var.boot_command
  shutdown_command          = "echo 'VMware1!' | sudo -S shutdown -P now"
  output_directory          = "build/${var.build_os}-${local.build_time}"
  vmx_data_post = {
    "ide1:0.present" = "FALSE"
    "ide1:0.fileName" = ""
    "ide0:0.present" = "FALSE"
    "ide0:0.fileName" = ""
  }
}

build {
  sources = ["source.vmware-iso.ubuntu"]

  provisioner "shell" {
    execute_command = "echo 'VMware1!' | {{.Vars}} sudo -E -S bash '{{.Path}}'"
    expect_disconnect = true
    scripts = [
      "provisioning/${var.build_os}/bootstrap.sh"
    ]
    pause_before = "15s"
  }

  #provisioner "ansible-local" {
  #  playbook_file = "provisioning/${var.build_os}/playbook.yml"
  #  galaxy_file = "provisioning/${var.build_os}/requirements.yml"
  #  galaxy_roles_path = "/usr/share/ansible/roles"
  #  extra_arguments = [
  #    "--extra-vars",
  #    "\"bootstrap_ansible_user_ssh_public_key='${var.mystic_user_ssh_public_key}'\""
  #  ]
  #}

}