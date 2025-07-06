source "vmware-iso" "rocky" {
 
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
  floppy_files              = ["files/${var.build_os}/rocky.ks"]
  cd_label                  = "cidata"
  communicator              = "ssh"
  ssh_username              = var.ssh_username
  ssh_password              = var.ssh_password
  ssh_timeout               = var.ssh_timeout
  ssh_clear_authorized_keys = "true"
  boot_wait                 = "15s"
  boot_key_interval         = "100ms"
  boot_command              = [
    "<up>",
    "e<wait>",
    "<down><down><end><wait>",
    " inst.text inst.ks=hd:fd0:/rocky.ks<wait>",
    "<enter><wait><leftCtrlOn>x<leftCtrlOff>",
  ]
  shutdown_command          = "echo 'VMware1!' | sudo -S shutdown -P now"
  output_directory          = "build/${var.build_os}-${local.build_time}"
}

build {
  sources = ["source.vmware-iso.rocky"]

  #provisioner "shell" {
  #  execute_command = "echo 'VMware1!' | {{.Vars}} sudo -E -S bash '{{.Path}}'"
  #  expect_disconnect = true
  #  scripts = [
  #    "provisioning/${var.build_os}/bootstrap.sh"
  #  ]
  #  pause_before = "15s"
  #}

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