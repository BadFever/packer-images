source "vmware-iso" "rocky" {
 
  vm_name = "${var.build_os}-${local.build_time}"

  # vm settings workstation
  guest_os_type         = var.guest_os_type
  firmware              = var.firmware
  version               = var.vm_version
  cpus                  = var.cpus
  cores                 = var.cpu_cores
  memory                = var.memory
  disk_size             = var.disk_size
  network_adapter_type  = "vmxnet3"
  disk_adapter_type     = "scsi"
  cdrom_adapter_type    = "ide"

  # workstation build settings
  iso_url                   = var.iso_path
  iso_checksum              = var.iso_checksum
  #floppy_files              = ["files/${var.build_os}/ks.cfg"]
  #http_directory            = "files/${var.build_os}"
  cd_files                  = ["files/${var.build_os}/ks.cfg"]
  cd_label                  = "KICKSTART"
  communicator              = "ssh"
  ssh_username              = var.ssh_username
  ssh_password              = var.ssh_password
  ssh_timeout               = var.ssh_timeout
  ssh_clear_authorized_keys = "true"
  boot_wait                 = "10s"
  boot_key_interval         = "100ms"
  boot_command              = [
    "<up>",
    "e<wait>",
    "<down><down><end><wait>",
    " inst.text",
    #" inst.ks=hd:fd0:/ks.cfg",
    #" inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<wait>",
    " inst.ks=cdrom:/ks.cfg<wait>",
    "<wait><leftCtrlOn>x<leftCtrlOff>",
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