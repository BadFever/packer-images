source "vsphere-iso" "vsphere" {
  
  vm_name = "Template-W2025-${var.build_type}-${local.build_time}"

  # vm settings
  guest_os_type = "${var.guest_os_type}"
  firmware = "${var.firmware}"
  vm_version = "${var.vm_version}"
  CPUs = "${var.cpus}"
  cpu_cores = "${var.cpu_cores}"
  CPU_reservation = "${var.cpu_reservation}"
  CPU_limit = 0
  CPU_hot_plug = "${var.hot_plug}"
  RAM = "${var.memory}"
  RAM_reservation = "${var.memory_reservation}"
  RAM_reserve_all = false
  RAM_hot_plug = "${var.hot_plug}"
  network_adapters { 
    network = "${var.vsphere_network}"
    network_card = "vmxnet3"
  }
  disk_controller_type = ["pvscsi"]
  storage { 
    disk_size = "${var.disk_size}"
    disk_thin_provisioned = "${var.thin_provisioned}"
    disk_controller_index = 0 
  }
  configuration_parameters = { 
    "disk.EnableUUID" = "TRUE" 
  }

  # vsphere settings
  vcenter_server       = "${var.vsphere_vcenter_server}"
  username             = "${var.vsphere_username}"
  password             = "${var.vsphere_password}"
  datacenter           = "${var.vsphere_datacenter}"
  cluster              = "${var.vsphere_compute_cluster}"
  host                 = "${var.vsphere_host}"
  datastore            = "${var.vsphere_datastore}"
  folder               = "${var.vsphere_folder}"
  insecure_connection  = "${var.vsphere_insecure_connection}"

  ip_wait_timeout      = "3600s"
  floppy_files         = ["setup/${var.build_type}/autounattend.xml","setup/bootstrap.ps1"]
  iso_paths            = ["${var.iso_path}","${var.tools_path}"]
  communicator         = "ssh"
  ssh_username         = "Administrator"
  ssh_password         = "${var.ssh_password}"
  ssh_timeout          = "${var.ssh_timeout}"
  ssh_clear_authorized_keys = "true"

  boot_wait = "3s"
  boot_command = ["<spacebar><spacebar>"]

  remove_cdrom = true

  content_library_destination {
    library = "${var.vsphere_content_library}"
    name = "win2025-${var.build_type}-latest"
    ovf = true
    destroy = true
  }

}

build {
  sources = ["source.vsphere-iso.vsphere"]

  provisioner "powershell" {
    script   = "./provisioning/services.ps1"
  }

  provisioner "powershell" {
    script   = "./provisioning/customize.ps1"
  }

  provisioner "powershell" {
    script   = "./provisioning/cleanup.ps1"
  }
  
  provisioner "windows-shell" {
    inline = ["ipconfig"]
  }

  #provisioner "windows-update" {
  #  filters = [
  #    "exclude:$_.Title -like '*VMware*'",
  #    "include:$true"
  #  ]
  #}

}