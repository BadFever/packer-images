source "vsphere-iso" "ubuntu" {

  vm_name = "${var.build_os}_${local.build_time}"

  # vm settings
  guest_os_type         = var.guest_os_type
  firmware              = var.firmware
  vm_version            = var.vm_version
  CPUs                  = var.cpus
  cpu_cores             = var.cpu_cores
  CPU_reservation       = var.cpu_reservation
  CPU_limit             = 0
  CPU_hot_plug          = var.hot_plug
  RAM                   = var.memory
  RAM_reservation       = var.memory_reservation
  RAM_reserve_all       = false
  RAM_hot_plug          = var.hot_plug
  disk_controller_type  = ["pvscsi"]
  network_adapters { 
    network       = var.vsphere_network
    network_card  = "vmxnet3"
  }
  storage { 
    disk_size             = var.disk_size
    disk_thin_provisioned = var.thin_provisioned
    disk_controller_index = 0 
  }
  configuration_parameters = { 
    "disk.EnableUUID" = "TRUE" 
  }

  # vsphere build settings
  iso_url = "${var.iso_url}"
  iso_checksum = "${var.iso_checksum}"

  ip_wait_timeout           = "3600s"
  cd_files = [
    "files/${var.build_os}/meta-data",
    "files/${var.build_os}/user-data"]
  cd_label = "cidata"
  iso_paths                 = [var.iso_path,]
  communicator              = "ssh"
  ssh_username              = "mystic"
  ssh_password              = var.ssh_password
  ssh_timeout               = var.ssh_timeout
  ssh_clear_authorized_keys = "true"
  ssh_pty                   = true
  ssh_timeout               = "20m"
  ssh_handshake_attempts    = 50
  boot_wait                 = var.boot_wait
  boot_command              = var.boot_command
  remove_cdrom              = true
  shutdown_command          = "echo 'VMware1!' | sudo -S shutdown -P now"


  content_library_destination {
    library = "${var.vsphere_content_library}"
    name = "${var.build_os}-${var.build_type}-latest"
    ovf = true
    destroy = true
  }

  # vsphere settings
  vcenter_server       = var.vsphere_vcenter_server
  username             = var.vsphere_username
  password             = var.vsphere_password
  datacenter           = var.vsphere_datacenter
  cluster              = var.vsphere_compute_cluster
  host                 = var.vsphere_host
  datastore            = var.vsphere_datastore
  folder               = var.vsphere_folder
  insecure_connection  = var.vsphere_insecure_connection
}

build {
  sources = ["sources.vsphere-iso.ubuntu"]

  provisioner "shell" {
    execute_command = "echo 'VMware1!' | {{.Vars}} sudo -E -S bash '{{.Path}}'"
    expect_disconnect = true
    scripts = [
      "./provisioner/bootstrap.sh"
    ]
    pause_before = "15s"
  }

  provisioner "ansible-local" {
    playbook_file = "./provisioner/${var.install_base}/playbook.yml"
    galaxy_file = "./provisioner/${var.install_base}/requirements.yml"
    galaxy_roles_path = "/usr/share/ansible/roles"
    extra_arguments = [
      "--extra-vars",
      "\"bootstrap_ansible_user_ssh_public_key='${var.mystic_user_ssh_public_key}'\""
    ]
  }
}